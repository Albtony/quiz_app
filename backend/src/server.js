const express = require('express');
const dotenv = require('dotenv');
const routes = require('./routes/routes.js');
const database = require('./services/database.js');

const app = express();
dotenv.config();

app.use('/api/v1', routes);

app.get('/', (req, res) => {
    res.status(200).json({ status: 'success', message: 'express server'})
});

app.use((req, res, next) => {
    res.status(404).json({ status: 'error', message: 'page not found'});
});

async function startServer() {
    try {
        await database.openConnection();
        const PORT = process.env.PORT || 3000;
        app.listen(PORT, () => {
            console.log(`[server]: Server is running at http://localhost:${PORT}`);
        });
    } catch (error) {
        console.error('[server]: Failed to start server:', error);
    }
}
  
startServer();
