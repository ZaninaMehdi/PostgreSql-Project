# Meal Planning Web Application

Authors: Basil Gil, Mehdi Zanina

## Project Setup

- Ensure PostgreSQL (version 14) and Node (version 16) are installed.
- In the `/client` directory, run `npm ci` in a terminal.
- In the `/server` directory, run `npm ci` in a terminal.
- In the `/server` directory, run `npm start` in a terminal to launch the server at `localhost:3000` by default.
- In the `/client` directory, run `npm start` in a terminal to launch the client at `localhost:4200` by default.

## Database Configuration

- Create a database with the name of your choice and "postgres" as the user.
- Set the password for "postgres" to "root" (Login/Group Roles -> right-click on "postgres" -> Properties -> Definition).
- Use the following configuration for the database in VS Code, in the file "database.service.ts", in the "connectionConfig" variable:

    user: "postgres",
    database: mae of your databae,
    password: "root",
    port: 5432,
    host: "127.0.0.1",
    keepAlive: true,

