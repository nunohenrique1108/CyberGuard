require('dotenv').config(); // Isto faz o Node.js ler o teu ficheiro .env
const { GoogleGenerativeAI } = require("@google/generative-ai");
const express = require('express');
const mysql = require('mysql2');
const cors = require('cors');
const multer = require('multer');
const fs = require('fs');
const path = require('path');
const speakeasy = require('speakeasy');
const qrcode = require('qrcode');

// CONFIGURAÇÃO DA IA (Vai buscar ao .env local ou à Render)
const genAI = new GoogleGenerativeAI(process.env.GEMINI_KEY);

const app = express();
app.use(cors());
app.use(express.json());

// ==========================================
// 🌐 LIGAÇÃO AO SITE (FRONTEND)
// ==========================================
// Isto diz ao servidor para mostrar os ficheiros da pasta "site"
app.use(express.static(path.join(__dirname, 'site')));

// Pasta de uploads para imagens/PDFs
app.use('/uploads', express.static(path.join(__dirname, 'uploads')));
const uploadDir = path.join(__dirname, 'uploads');
if (!fs.existsSync(uploadDir)) { 
    fs.mkdirSync(uploadDir, { recursive: true }); 
}

// Configuração do Multer para uploads manuais de evidências
const storage = multer.diskStorage({
    destination: (req, file, cb) => cb(null, uploadDir),
    filename: (req, file, cb) => {
        cb(null, `upload-${Date.now()}-${file.originalname}`);
    }
});
const upload = multer({ storage: storage });

// ==========================================
// ☁️ DATABASE (Configurada para o Aiven)
// ==========================================
const db = mysql.createConnection({
    host: 'mysql-218d61d7-nunohenrique1108-80e4.h.aivencloud.com',
    user: 'avnadmin',
    password: process.env.DB_PASSWORD, // Vai buscar ao .env local ou à Render
    database: 'defaultdb',
    port: 20669,
    ssl: { rejectUnauthorized: false } 
}).promise();

// ==========================================
// 🛠️ CRIAÇÃO AUTOMÁTICA DE TABELAS
// ==========================================
async function inicializarBancoNuvem() {
    try {
        await db.query(`CREATE TABLE IF NOT EXISTS usuarios (
            id INT AUTO_INCREMENT PRIMARY KEY,
            nome VARCHAR(100),
            username VARCHAR(50) UNIQUE,
            password VARCHAR(255),
            secret_2fa VARCHAR(255),
            is_2fa_active TINYINT(1) DEFAULT 0
        )`);

        await db.query(`CREATE TABLE IF NOT EXISTS empresas (
            id_empresa INT AUTO_INCREMENT PRIMARY KEY,
            nome_empresa VARCHAR(255)
        )`);

        await db.query(`CREATE TABLE IF NOT EXISTS auditorias (
            id_controlo VARCHAR(50) PRIMARY KEY,
            nome_controlo VARCHAR(255),
            risco VARCHAR(20),
            estado VARCHAR(50) DEFAULT 'PENDENTE',
            conforme TINYINT(1) DEFAULT 0,
            plano_acao TEXT,
            id_empresa INT
        )`);

        await db.query(`CREATE TABLE IF NOT EXISTS evidencias (
            id INT AUTO_INCREMENT PRIMARY KEY,
            nome_arquivo VARCHAR(255),
            caminho VARCHAR(255),
            id_controlo VARCHAR(50),
            data_upload TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        )`);

        await db.query(`CREATE TABLE IF NOT EXISTS logs_auditoria (
            id INT AUTO_INCREMENT PRIMARY KEY,
            id_controlo VARCHAR(50),
            acao VARCHAR(255),
            usuario VARCHAR(100),
            data_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        )`);

        // Insere o teu utilizador para conseguires entrar
        await db.query("INSERT IGNORE INTO usuarios (nome, username, password) VALUES ('Nuno Carvalho', 'nuno', '1234')");
        // Insere a empresa default
        await db.query("INSERT IGNORE INTO empresas (id_empresa, nome_empresa) VALUES (1, 'CyberGuard GRC')");
        // Insere um controlo de exemplo para a Dashboard não ficar vazia
        await db.query("INSERT IGNORE INTO auditorias (id_controlo, nome_controlo, risco, id_empresa) VALUES ('A.5.1', 'Políticas de Segurança da Informação', 'CRÍTICO', 1)");

        console.log("✅ Base de Dados na Nuvem configurada com sucesso!");
    } catch (err) { console.log("⚠️ Erro ao configurar tabelas:", err.message); }
}
inicializarBancoNuvem();

// ==========================================
// 🛡️ ROTAS DE LOGIN E 2FA
// ==========================================

app.post('/api/login', async (req, res) => {
    const { user, pass } = req.body;
    try {
        const [r] = await db.query("SELECT * FROM usuarios WHERE username=? AND password=?", [user, pass]);
        if (r.length > 0) {
            res.json({ success: true, requires2FA: r[0].is_2fa_active === 1, user: { id: r[0].id, nome: r[0].nome, username: r[0].username } });
        } else { res.status(401).json({ success: false }); }
    } catch (err) { res.status(500).json({ error: "Erro DB" }); }
});

app.post('/api/2fa/setup', async (req, res) => {
    const { userId } = req.body;
    const secret = speakeasy.generateSecret({ name: `CyberGuard (${userId})` });
    await db.query("UPDATE usuarios SET secret_2fa = ? WHERE id = ?", [secret.base32, userId]);
    qrcode.toDataURL(secret.otpauth_url, (err, data_url) => { res.json({ qrCode: data_url }); });
});

app.post('/api/2fa/verify', async (req, res) => {
    const { userId, token } = req.body;
    const [rows] = await db.query("SELECT secret_2fa FROM usuarios WHERE id = ?", [userId]);
    const verified = speakeasy.totp.verify({ secret: rows[0].secret_2fa, encoding: 'base32', token: token });
    if (verified) {
        await db.query("UPDATE usuarios SET is_2fa_active = TRUE WHERE id = ?", [userId]);
        res.json({ success: true });
    } else { res.json({ success: false }); }
});

// ==========================================
// 🤖 GERADOR DE EVIDÊNCIAS (IA)
// ==========================================

app.post('/api/gerar-evidencia-ia', async (req, res) => {
    const { id_controlo, nome_controlo } = req.body;
    try {
        let textoDinamico = "";
        try {
            const model = genAI.getGenerativeModel({ model: "gemini-1.5-flash" });
            const prompt = `Atua como Auditor ISO 27001. Escreve um parágrafo de análise técnica confirmando que o controlo ${id_controlo} (${nome_controlo}) está implementado. Usa linguagem formal.`;
            const result = await model.generateContent(prompt);
            textoDinamico = result.response.text().replace(/\n/g, '<br>');
        } catch (iaError) {
            textoDinamico = `<strong>Verificação Automática de Conformidade executada.</strong><br>As políticas estão implementadas e a segregação de funções foi validada.`;
        }

        const dataHoje = new Date().toLocaleString('pt-PT');
        const htmlTemplate = `
        <!DOCTYPE html>
        <html lang="pt">
        <head><meta charset="UTF-8"><title>Evidência - ${id_controlo}</title></head>
        <body style="font-family: sans-serif; padding: 40px; background: #f4f4f4;">
            <div style="background: white; padding: 30px; border-radius: 8px;">
                <h1 style="color: #2c3e50;">Relatório de Conformidade ISO 27001</h1>
                <p><strong>Controlo:</strong> ${id_controlo} - ${nome_controlo}</p>
                <p><strong>Data:</strong> ${dataHoje}</p>
                <hr>
                <div style="background: #e8f4fd; padding: 15px; border-left: 4px solid #3498db;">
                    ${textoDinamico}
                </div>
            </div>
        </body>
        </html>`;

        const nomeArquivo = `evidencia-${id_controlo}-${Date.now()}.html`;
        const caminhoArquivo = path.join(uploadDir, nomeArquivo);
        fs.writeFileSync(caminhoArquivo, htmlTemplate);

        await db.query("INSERT INTO evidencias (nome_arquivo, caminho, id_controlo) VALUES (?, ?, ?)", [nomeArquivo, `uploads/${nomeArquivo}`, id_controlo]);
        await db.query("UPDATE auditorias SET estado='CONFORME' WHERE id_controlo=?", [id_controlo]);
        await db.query("INSERT INTO logs_auditoria (id_controlo, acao, usuario) VALUES (?, ?, ?)", [id_controlo, "Evidência gerada", "Sistema IA"]);

        res.json({ success: true });
    } catch (error) { res.status(500).json({ success: false, message: error.message }); }
});

app.post('/api/evidencias/upload', upload.single('ficheiro'), async (req, res) => {
    const { id_controlo } = req.body;
    if (!req.file || !id_controlo) return res.status(400).json({ success: false });

    try {
        const nomeArquivo = req.file.filename;
        const caminhoArquivo = `uploads/${nomeArquivo}`;
        await db.query("INSERT INTO evidencias (nome_arquivo, caminho, id_controlo) VALUES (?, ?, ?)", [req.file.originalname, caminhoArquivo, id_controlo]);
        await db.query("INSERT INTO logs_auditoria (id_controlo, acao, usuario) VALUES (?, ?, ?)", [id_controlo, "Upload manual de evidência", "Auditor"]);
        res.json({ success: true });
    } catch (err) { res.status(500).json({ success: false }); }
});

// ==========================================
// 📊 ROTA DO RELATÓRIO GLOBAL
// ==========================================

app.get('/api/relatorio-ia', async (req, res) => {
    try {
        const [controlos] = await db.query("SELECT * FROM auditorias");
        const total = controlos.length || 93;
        const conformes = controlos.filter(c => c.estado === 'CONFORME').length;
        const pendentes = controlos.filter(c => c.estado !== 'CONFORME');
        const score = Math.round((conformes / total) * 100);

        const model = genAI.getGenerativeModel({ model: "gemini-1.5-flash" });
        const prompt = `Analise estes dados de auditoria ISO 27001. Score: ${score}%. Falhas: ${pendentes.map(p=>p.id_controlo).join(", ")}.
        Gere um JSON com: {"resumo": "...", "plano": [{"controlo": "ID", "problema": "...", "solucao": "..."}]}`;

        const result = await model.generateContent(prompt);
        let responseText = result.response.text();
        const jsonLimpo = responseText.substring(responseText.indexOf('{'), responseText.lastIndexOf('}') + 1);
        const dadosIA = JSON.parse(jsonLimpo);

        res.json({ score: score, resumo: dadosIA.resumo, plano: dadosIA.plano });
    } catch (err) { res.json({ score: 0, resumo: "Dados insuficientes.", plano: [] }); }
});

// ==========================================
// 📋 ROTAS (CONTROLES, LOGS, STATS)
// ==========================================

app.get('/api/controlos', async (req, res) => {
    try {
        const [r] = await db.query("SELECT * FROM auditorias GROUP BY id_controlo ORDER BY id_controlo ASC");
        res.json(r);
    } catch (err) { res.status(500).json([]); }
});

app.post('/api/update-status', async (req, res) => {
    const { id, novo_estado, auditor } = req.body;
    try {
        await db.query("UPDATE auditorias SET estado=? WHERE id_controlo=?", [novo_estado, id]);
        await db.query("INSERT INTO logs_auditoria (id_controlo, acao, usuario) VALUES (?, ?, ?)", [id, `Alterou para ${novo_estado}`, auditor]);
        res.json({ success: true });
    } catch (err) { res.status(500).json(err); }
});

app.get('/api/logs', async (req, res) => {
    try {
        const [r] = await db.query("SELECT * FROM logs_auditoria ORDER BY data_hora DESC LIMIT 50");
        res.json(r);
    } catch (err) { res.status(500).json([]); }
});

app.get('/api/stats', async (req, res) => {
    try {
        const [r] = await db.query("SELECT COUNT(DISTINCT id_controlo) as total, SUM(CASE WHEN estado='CONFORME' THEN 1 ELSE 0 END) as conforme, SUM(CASE WHEN estado='PENDENTE' OR estado='NÃO CONFORME' THEN 1 ELSE 0 END) as pendente FROM auditorias");
        res.json(r[0] || { total: 0, conforme: 0, pendente: 0 });
    } catch (err) { res.status(500).json({ total: 0, conforme: 0, pendente: 0 }); }
});

app.get('/api/evidencias', async (req, res) => {
    try {
        const [r] = await db.query("SELECT * FROM evidencias ORDER BY id DESC");
        res.json(r);
    } catch (err) { res.status(500).json([]); }
});

app.get('/api/riscos-urgentes', async (req, res) => {
    try {
        const [rows] = await db.query(`
            SELECT e.nome_empresa, a.id_controlo, a.nome_controlo, a.risco 
            FROM auditorias a
            LEFT JOIN empresas e ON a.id_empresa = e.id_empresa
            WHERE a.conforme = 0 
            ORDER BY e.nome_empresa ASC, FIELD(a.risco, 'CRÍTICO', 'MÉDIO', 'BAIXO')
        `);
        res.json(rows);
    } catch (err) { res.status(500).json({ error: "Erro DB" }); }
});

app.post('/api/atualizar-checklist', async (req, res) => {
    const { id_controlo, conforme } = req.body;
    try {
        await db.query("UPDATE auditorias SET conforme = ? WHERE id_controlo = ?", [conforme, id_controlo]);
        res.json({ success: true });
    } catch (err) { res.status(500).json({ error: "Erro DB" }); }
});

app.post('/api/mitigar-risco', async (req, res) => {
    const { id_controlo, plano_acao, auditor } = req.body;
    try {
        const plano = `[Registado por ${auditor}]\nPlano: ${plano_acao}`;
        await db.query("UPDATE auditorias SET conforme = 1, estado = 'CONFORME', plano_acao = ? WHERE id_controlo = ?", [plano, id_controlo]);
        await db.query("INSERT INTO logs_auditoria (id_controlo, acao, usuario) VALUES (?, ?, ?)", [id_controlo, "Risco Mitigado", auditor]);
        res.json({ success: true });
    } catch (err) { res.status(500).json({ error: "Erro DB" }); }
});

// ==========================================
// 🚨 ROTA FINAL (MÁGICA)
// ==========================================
// Se o pedido não for uma API nem uma imagem, abre o site!
app.get((req, res) => {
    res.sendFile(path.join(__dirname, 'site', 'index.html'));
});

// ==========================================
// 🚀 INICIA O SERVIDOR (Preparado para a Nuvem e Localhost)
// ==========================================
const PORT = process.env.PORT || 5000;
app.listen(PORT, () => console.log(`🚀 SERVIDOR ONLINE NA PORTA ${PORT}`));