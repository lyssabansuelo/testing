const mysql = require('mysql2/promise');
const path = require('path');
require('dotenv').config({ path: path.resolve(__dirname, '.env') });

(async () => {
  const config = {
    host: process.env.DB_HOST || '127.0.0.1',
    user: process.env.DB_USER || 'root',
    password: process.env.DB_PASSWORD || 'example',
    database: process.env.DB_NAME || 'drugstore',
    port: process.env.DB_PORT ? parseInt(process.env.DB_PORT, 10) : 3306,
  };
  try {
    console.log('Testing MySQL connection with config:', config);
    const conn = await mysql.createConnection(config);
    const [rows] = await conn.query('SELECT 1 AS ok');
    console.log('Query result:', rows);
    await conn.end();
    console.log('MySQL connection OK');
  } catch (err) {
    console.error('MySQL connection FAILED:', err.message, err.code);
    process.exit(1);
  }
})();
