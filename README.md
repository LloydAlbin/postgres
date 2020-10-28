# postgres

|License|Overall Build|
|:---:|:---:|
|![GitHub](https://img.shields.io/github/license/LloydAlbin/postgres-docker)|[![Build Status](https://www.travis-ci.org/LloydAlbin/postgres-docker.svg?branch=main)](https://www.travis-ci.org/LloydAlbin/postgres-docker/builds)|
|**Postgresql**|**Build Status**|
|10|[![Build Status](https://travis-matrix-badges.herokuapp.com/repos/LloydAlbin/postgres-docker/branches/main/1)](https://www.travis-ci.org/LloydAlbin/postgres-docker/builds)|
|11|[![Build Status](https://travis-matrix-badges.herokuapp.com/repos/LloydAlbin/postgres-docker/branches/main/2)](https://www.travis-ci.org/LloydAlbin/postgres-docker/builds)|
|12|[![Build Status](https://travis-matrix-badges.herokuapp.com/repos/LloydAlbin/postgres-docker/branches/main/3)](https://www.travis-ci.org/LloydAlbin/postgres-docker/builds)|
|13|[![Build Status](https://travis-matrix-badges.herokuapp.com/repos/LloydAlbin/postgres-docker/branches/main/4)](https://www.travis-ci.org/LloydAlbin/postgres-docker/builds)|

This is a custom builder that is based off the Official PostgreSQL for Alpine Linux for use with TimescaleDB. The build script patches the official Dockerfile and then builds using the updated Dockerfile.

The Official PostgreSQL Alpine version is created by default without LDAP support. We need the LDAP support at work, so this repository contains the code to build the PostgreSQL Alpine with LDAP support and a few additional extensions.

```bash
cd ~
# Get the postgres-docker repository
git clone https://github.com/LloydAlbin/postgres-docker.git
```

## Build Custom PostgreSQL Docker Image

The make command takes some optional options:

* org
* ts_name
* pg_name
* location
* push
* clean
* postgres

These options help define the docker image names in this format:

* org/pg_name:VERSION aka lloydalbin/postgres:11-alpine
* location aka ~ meaning ~/postgres and ~/timescaledb-docker for the two repositories needed to be downloaded
* --push aka push docker image(s) to the repsoitory
* --clean aka delete the two repositories
* --postgres aka build only postgres

If you have your own inhouse docker registery, then the ORG name should be the name of your inhouse docker registry.

The build script will download the postgres repository.

```bash
# For the first time
~/postgres-docker/build_postgres.sh -v -v -v -V --add all --postgres -pgv pg11
~/postgres-docker/build_postgres.sh -v -v -v -V --add all --postgres -pgv pg12
# Using the optional arguments
~/postgres-docker/build_postgres.sh --add all --postgres --org=lloydalbin ---pg_name=postgres

# For the second time, otherwise the postgres Dockerfile will get double patched.
~/postgres-docker/build_postgres.sh --clean postgres --override_exit
```

### PostgreSQL Versions

The build_timescaledb.sh script has been updated to use PostgreSQL 12, but still works for PostgreSQL 11. The older versions can use PostgresSQl 10, just use the -pgv flag to be pg10.

## Clean / Delete Repositories

If you wish to delete the repositories, you may do so manually or you can use the make command to clean up the postgres repository.

```bash
# Delete repositories
~/pg_monitor/timescaledb/custom/build_postgres.sh --clean
# Optional: Just Postgres
~/pg_monitor/timescaledb/custom/build_postgres.sh --clean postgres
```
