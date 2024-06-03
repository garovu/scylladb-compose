const { Client } = require('cassandra-driver');

async function testSSLConnection(host, port, username, password) {
    const client = new Client({
        contactPoints: [`${host}:${port}`],
        auth: {
            username: username,
            password: password
        },
        sslOptions: {
            rejectUnauthorized: false // Disable SSL certificate validation
        }
    });

    try {
        await client.connect();
        console.log('SSL connection successful!');
    } catch (error) {
        console.error('SSL connection failed:', error.message);
    } finally {
        await client.shutdown();
    }
}