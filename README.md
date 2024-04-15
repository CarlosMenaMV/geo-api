# GEO API

## Prerequisites

This project requires Docker and Docker Compose. Ensure you have these tools installed on your system before proceeding:

- Docker: [https://www.docker.com/get-started](https://www.docker.com/get-started)
- Docker Compose: [https://docs.docker.com/compose/install/](https://docs.docker.com/compose/install/)

## Initial Setup

### Environment Setup

First, you need to set up the required environment variables:

```bash
cp .env
```

To start the local database container using Docker Compose, run:

```bash
docker compose up -d
```

After starting the database service, create the project database with the following command:

```bash
rake db:create
```

To update the database schema to the latest version, apply migrations by running:

```bash
rake db:migrate
```

To fetch initial data for the application (for example, earthquake data), execute:

```bash
rake earthquake:get_data
```

Finally, to start the Rails application server and access the API, use:

```bash
rails server -p 3001
```

Happy Code!!
