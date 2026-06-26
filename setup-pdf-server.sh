#!/bin/bash
# PDF转换服务部署脚本
cd /opt
mkdir -p pdf-tools && cd pdf-tools
npm init -y 2>/dev/null
npm install express multer cors 2>/dev/null

cat > server.js << 'EOF'
const express = require('express');
const multer = require('multer');
const cors = require('cors');
const { exec } = require('child_process');
const fs = require('fs');
const path = require('path');
const app = express();

app.use(cors());
const upload = multer({ dest: '/tmp/pdf-uploads/', limits: { fileSize: 50 * 1024 * 1024 } });
fs.mkdirSync('/tmp/pdf-uploads', { recursive: true });

function convert(type, ext, req, res) {
    if (!req.file) return res.status(400).json({ error: '请上传文件' });
    const inputPath = req.file.path;
    const outputDir = '/tmp/pdf-out-' + Date.now();
    fs.mkdirSync(outputDir, { recursive: true });
    exec('libreoffice --headless --convert-to ' + ext + ' --outdir ' + outputDir + ' ' + inputPath, { timeout: 60000 }, (err, stdout, stderr) => {
        fs.unlink(inputPath, () => {});
        if (err) {
            try { fs.rmSync(outputDir, { recursive: true, force: true }); } catch(e) {}
            return res.status(500).json({ error: '转换失败，请确认PDF包含可识别内容' });
        }
        const files = fs.readdirSync(outputDir).filter(f => f.endsWith('.' + ext) || f.endsWith('.' + ext.toUpperCase()));
        if (files.length === 0) {
            try { fs.rmSync(outputDir, { recursive: true, force: true }); } catch(e) {}
            return res.status(500).json({ error: '转换失败，未生成文件' });
        }
        const outFile = path.join(outputDir, files[0]);
        res.setHeader('Content-Disposition', 'attachment; filename="' + encodeURIComponent(files[0]) + '"');
        res.sendFile(outFile, () => {
            try { fs.rmSync(outputDir, { recursive: true, force: true }); } catch(e) {}
        });
    });
}

app.post('/convert/pdf-to-word', upload.single('file'), (req, res) => convert('docx', 'docx', req, res));
app.post('/convert/pdf-to-excel', upload.single('file'), (req, res) => convert('xlsx', 'xlsx', req, res));
app.get('/health', (req, res) => res.json({ status: 'ok' }));
app.listen(3000, () => console.log('PDF converter on port 3000'));
EOF

# Start as background service
pkill -f "node.*server.js" 2>/dev/null
nohup node server.js > /opt/pdf-tools/server.log 2>&1 &
echo "Service started on port 3000"
sleep 2
curl -s http://localhost:3000/health
