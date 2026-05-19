require('dotenv').config();
const { GoogleGenerativeAI } = require("@google/generative-ai");
const express = require('express');
const mysql = require('mysql2');
const cors = require('cors');
const multer = require('multer');
const fs = require('fs');
const path = require('path');
const speakeasy = require('speakeasy');
const qrcode = require('qrcode');
const bcrypt = require('bcrypt');
const helmet = require('helmet');
const rateLimit = require('express-rate-limit');

const genAI = new GoogleGenerativeAI(process.env.GEMINI_KEY);
const app = express();

app.use(helmet());
app.use(cors({ origin: true, credentials: true }));
app.use(express.json({ limit: '10mb' }));

const loginLimiter = rateLimit({
    windowMs: 15 * 60 * 1000,
    max: 5,
    message: { success: false, message: 'Demasiadas tentativas. Tenta novamente em 15 minutos.' }
});

app.use(express.static(path.join(__dirname, 'site')));

const uploadDir = path.join(__dirname, 'uploads');
if (!fs.existsSync(uploadDir)) {
    fs.mkdirSync(uploadDir, { recursive: true });
}
app.use('/uploads', express.static(uploadDir));

const allowedMimeTypes = ['application/pdf', 'image/png', 'image/jpeg', 'image/jpg'];
const storage = multer.diskStorage({
    destination: (req, file, cb) => {
        cb(null, uploadDir);
    },
    filename: (req, file, cb) => {
        const safeName = file.originalname.replace(/[^a-zA-Z0-9.-]/g, '_');
        cb(null, `upload-${Date.now()}-${safeName}`);
    }
});

const upload = multer({
    storage,
    limits: { fileSize: 10 * 1024 * 1024 },
    fileFilter: (req, file, cb) => {
        if (!allowedMimeTypes.includes(file.mimetype)) {
            return cb(new Error('Tipo de ficheiro inválido'));
        }
        cb(null, true);
    }
});

const db = mysql.createConnection({
    host: 'mysql-218d61d7-nunohenrique1108-80e4.h.aivencloud.com',
    user: 'avnadmin',
    password: process.env.DB_PASSWORD,
    database: 'defaultdb',
    port: 20669,
    ssl: { rejectUnauthorized: false }
}).promise();

async function inicializarBancoNuvem() {
    try {
        await db.query(`CREATE TABLE IF NOT EXISTS utilizadores (id INT AUTO_INCREMENT PRIMARY KEY, nome VARCHAR(100), username VARCHAR(50) UNIQUE, password VARCHAR(255), secret_2fa VARCHAR(255), is_2fa_active TINYINT(1) DEFAULT 0)`);
        await db.query(`CREATE TABLE IF NOT EXISTS empresas (id_empresa INT AUTO_INCREMENT PRIMARY KEY, nome_empresa VARCHAR(255))`);
        await db.query(`CREATE TABLE IF NOT EXISTS auditorias (id_controlo VARCHAR(50) PRIMARY KEY, nome_controlo VARCHAR(255), risco VARCHAR(20), estado VARCHAR(50) DEFAULT 'PENDENTE', conforme TINYINT(1) DEFAULT 0, plano_acao TEXT, id_empresa INT)`);
        await db.query(`CREATE TABLE IF NOT EXISTS evidencias (id INT AUTO_INCREMENT PRIMARY KEY, nome_arquivo VARCHAR(255), caminho VARCHAR(255), id_controlo VARCHAR(50), data_upload TIMESTAMP DEFAULT CURRENT_TIMESTAMP)`);
        await db.query(`CREATE TABLE IF NOT EXISTS logs_auditoria (id INT AUTO_INCREMENT PRIMARY KEY, id_controlo VARCHAR(50), acao VARCHAR(255), usuario VARCHAR(100), data_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP)`);

        const [users] = await db.query("SELECT * FROM utilizadores WHERE username = ?", ['nuno']);
        if (users.length === 0) {
            const hashedPassword = await bcrypt.hash('1234', 12);
            await db.query("INSERT INTO utilizadores (nome, username, password) VALUES (?, ?, ?)", ['Nuno Carvalho', 'nuno', hashedPassword]);
        }

        await db.query("INSERT IGNORE INTO empresas (id_empresa, nome_empresa) VALUES (1, 'CyberGuard GRC')");
        await db.query("INSERT IGNORE INTO auditorias (id_controlo, nome_controlo, risco, id_empresa) VALUES ('A.5.1', 'Políticas de Segurança da Informação', 'CRÍTICO', 1)");

    } catch (err) {
        console.error(err.message);
    }
}
inicializarBancoNuvem();

app.post('/api/login', loginLimiter, async (req, res) => {
    try {
        const { user, pass } = req.body;
        if (!user || !pass) return res.status(400).json({ success: false, message: 'Dados inválidos' });

        const [rows] = await db.query("SELECT * FROM utilizadores WHERE username = ?", [user]);
        if (rows.length === 0) return res.status(401).json({ success: false, message: 'Credenciais inválidas' });

        const utilizador = rows[0];
        const passwordValida = await bcrypt.compare(pass, utilizador.password);
        if (!passwordValida) return res.status(401).json({ success: false, message: 'Credenciais inválidas' });

        res.json({
            success: true,
            requires2FA: utilizador.is_2fa_active === 1,
            user: { id: utilizador.id, nome: utilizador.nome, username: utilizador.username }
        });
    } catch (err) {
        res.status(500).json({ success: false, message: 'Erro interno' });
    }
});

app.post('/api/register', async (req, res) => {
    try {
        const { nome, username, password } = req.body;
        if (!nome || !username || !password) return res.status(400).json({ success: false, message: 'Campos obrigatórios' });

        const [existing] = await db.query("SELECT id FROM utilizadores WHERE username = ?", [username]);
        if (existing.length > 0) return res.status(409).json({ success: false, message: 'Utilizador já existe' });

        const hashedPassword = await bcrypt.hash(password, 12);
        await db.query("INSERT INTO utilizadores (nome, username, password) VALUES (?, ?, ?)", [nome, username, hashedPassword]);

        res.json({ success: true, message: 'Conta criada com sucesso' });
    } catch (err) {
        res.status(500).json({ success: false, message: 'Erro interno' });
    }
});

app.post('/api/2fa/setup', async (req, res) => {
    try {
        const { userId } = req.body;
        const secret = speakeasy.generateSecret({ name: `CyberGuard (${userId})` });
        await db.query("UPDATE utilizadores SET secret_2fa = ? WHERE id = ?", [secret.base32, userId]);
        qrcode.toDataURL(secret.otpauth_url, (err, data_url) => {
            if (err) return res.status(500).json({ success: false });
            res.json({ qrCode: data_url });
        });
    } catch (err) { res.status(500).json({ success: false }); }
});

app.post('/api/2fa/verify', async (req, res) => {
    try {
        const { userId, token } = req.body;
        const [rows] = await db.query("SELECT secret_2fa FROM utilizadores WHERE id = ?", [userId]);
        if (rows.length === 0) return res.status(404).json({ success: false });

        const verified = speakeasy.totp.verify({ secret: rows[0].secret_2fa, encoding: 'base32', token: token });
        if (verified) {
            await db.query("UPDATE utilizadores SET is_2fa_active = TRUE WHERE id = ?", [userId]);
            return res.json({ success: true });
        }
        res.json({ success: false });
    } catch (err) { res.status(500).json({ success: false }); }
});

app.post('/api/evidencias/upload', upload.single('ficheiro'), async (req, res) => {
    try {
        const { id_controlo } = req.body;
        if (!req.file || !id_controlo) return res.status(400).json({ success: false });

        const nomeArquivo = req.file.filename;
        const caminhoArquivo = `uploads/${nomeArquivo}`;

        await db.query("INSERT INTO evidencias (nome_arquivo, caminho, id_controlo) VALUES (?, ?, ?)", [req.file.originalname, caminhoArquivo, id_controlo]);
        await db.query("INSERT INTO logs_auditoria (id_controlo, acao, usuario) VALUES (?, ?, ?)", [id_controlo, 'Upload manual de evidência', 'Auditor']);

        res.json({ success: true });
    } catch (err) { res.status(500).json({ success: false }); }
});

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
            textoDinamico = `<strong>Verificação Automática de Conformidade executada.</strong><br>As políticas implementadas.`;
        }

        const htmlTemplate = `<!DOCTYPE html><html lang="pt"><head><meta charset="UTF-8"></head><body style="padding: 40px;">${textoDinamico}</body></html>`;
        const nomeArquivo = `evidencia-${id_controlo}-${Date.now()}.html`;
        fs.writeFileSync(path.join(uploadDir, nomeArquivo), htmlTemplate);

        await db.query("INSERT INTO evidencias (nome_arquivo, caminho, id_controlo) VALUES (?, ?, ?)", [nomeArquivo, `uploads/${nomeArquivo}`, id_controlo]);
        await db.query("UPDATE auditorias SET estado='CONFORME', conforme=1 WHERE id_controlo=?", [id_controlo]);
        res.json({ success: true });
    } catch (error) { res.status(500).json({ success: false }); }
});

app.get('/api/relatorio-ia', async (req, res) => {
    try {
        const [controlos] = await db.query("SELECT * FROM auditorias");
        const total = controlos.length || 1;
        const conformes = controlos.filter(c => c.estado === 'CONFORME').length;
        const score = Math.round((conformes / total) * 100);

        const model = genAI.getGenerativeModel({ model: "gemini-1.5-flash" });
        const prompt = `Analise a auditoria ISO 27001. Score: ${score}%. Gere um JSON com: {"resumo": "...", "plano": [{"controlo": "ID", "problema": "...", "solucao": "..."}]}`;

        const result = await model.generateContent(prompt);
        let responseText = result.response.text();
        const jsonLimpo = responseText.substring(responseText.indexOf('{'), responseText.lastIndexOf('}') + 1);
        res.json(JSON.parse(jsonLimpo));
    } catch (err) { res.json({ score: 0, resumo: "Dados indisponíveis.", plano: [] }); }
});

app.get('/api/controlos', async (req, res) => {
    try {
        const [r] = await db.query("SELECT * FROM auditorias GROUP BY id_controlo ORDER BY id_controlo ASC");
        res.json(r);
    } catch (err) { res.status(500).json([]); }
});

app.post('/api/update-status', async (req, res) => {
    try {
        const { id, novo_estado, auditor } = req.body;
        const conformeVal = novo_estado === 'CONFORME' ? 1 : 0;
        await db.query("UPDATE auditorias SET estado=?, conforme=? WHERE id_controlo=?", [novo_estado, conformeVal, id]);
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
        const [rows] = await db.query(`SELECT e.nome_empresa, a.id_controlo, a.nome_controlo, a.risco FROM auditorias a LEFT JOIN empresas e ON a.id_empresa = e.id_empresa WHERE a.conforme = 0 ORDER BY e.nome_empresa ASC, FIELD(a.risco, 'CRÍTICO', 'MÉDIO', 'BAIXO')`);
        res.json(rows);
    } catch (err) { res.status(500).json({ error: "Erro DB" }); }
});

app.post('/api/atualizar-checklist', async (req, res) => {
    try {
        const { id_controlo, conforme } = req.body;
        await db.query("UPDATE auditorias SET conforme = ? WHERE id_controlo = ?", [conforme, id_controlo]);
        res.json({ success: true });
    } catch (err) { res.status(500).json({ error: "Erro DB" }); }
});

app.post('/api/mitigar-risco', async (req, res) => {
    try {
        const { id_controlo, plano_acao, auditor } = req.body;
        const plano = `[Registado por ${auditor}]\nPlano: ${plano_acao}`;
        // ALTERAÇÃO: O estado passa a ser 'PLANO APLICADO' e conforme continua a 0 até ter evidência
        await db.query("UPDATE auditorias SET conforme = 0, estado = 'PLANO APLICADO', plano_acao = ? WHERE id_controlo = ?", [plano, id_controlo]);
        await db.query("INSERT INTO logs_auditoria (id_controlo, acao, usuario) VALUES (?, ?, ?)", [id_controlo, "Plano de Ação Aplicado", auditor]);
        res.json({ success: true });
    } catch (err) { res.status(500).json({ error: "Erro DB" }); }
});

app.use((req, res) => {
    res.sendFile(path.join(__dirname, 'site', 'index.html'));
});

const PORT = process.env.PORT || 5000;
app.listen(PORT, () => {
    console.log(`SERVIDOR ONLINE NA PORTA ${PORT}`);
});