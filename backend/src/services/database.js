const { Sequelize } = require('sequelize');
require('dotenv').config();

poolConfig = {
    max: 5,
    min: 0,
    acquire: 60000,
    idle: 10000
}

class Database {
    constructor() {
        if(!Database.instance) {
            this.sequelize = new Sequelize({
                database: process.env.DB_DATABASE,
                username: process.env.DB_USERNAME,
                password: process.env.DB_PASSWORD,
                host: process.env.DB_HOST,
                port: process.env.DB_PORT,
                dialect: 'postgres',
                pool: poolConfig
            })
            Database.instance = this
        }
        return Database.instance;
    }

    getSequelizeInstance() {
        return this.sequelize;
    }

    async openConnection() {
        try {
            await this.sequelize.authenticate();
            console.log('[server]: connection to database established successfully.');
        } catch (error) {
            console.error('[server]: unable to connect to the database,', error);
        }     
    }

    closeConnection() {
        this.sequelize.close();
    }
}

const database = new Database();
Object.freeze(database);

module.exports = database;