const { spawn } = require('child_process');
const path = require('path');
const fs = require('fs');

const repoRoot = path.resolve(__dirname, '..');
const mlDir = path.join(repoRoot, 'pharma_ml');

function findUvicorn() {
  const winUv = path.join(mlDir, 'venv', 'Scripts', 'uvicorn.exe');
  const winUvPy = path.join(mlDir, 'venv', 'Scripts', 'uvicorn');
  const unixUv = path.join(mlDir, 'venv', 'bin', 'uvicorn');
  if (fs.existsSync(winUv)) return winUv;
  if (fs.existsSync(winUvPy)) return winUvPy;
  if (fs.existsSync(unixUv)) return unixUv;
  return 'uvicorn';
}

const uvicornCmd = findUvicorn();
const args = ['main:app', '--reload', '--host', '0.0.0.0', '--port', '8000'];

console.log('Starting ML service with:', uvicornCmd, args.join(' '));

const p = spawn(uvicornCmd, args, { cwd: mlDir, stdio: 'inherit', shell: false });

p.on('close', (code) => {
  console.log(`ML process exited with ${code}`);
  process.exit(code);
});

p.on('error', (err) => {
  console.error('Failed to start ML process:', err);
  process.exit(1);
});
