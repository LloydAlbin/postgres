# postgres

|Postgresql|Build Status|
|:---:|:---:|
|10|[![Build Status](https://travis-matrix-badges.herokuapp.com/repos/LloydAlbin/postgres-docker/branches/main/1)](https://www.travis-ci.org/LloydAlbin/postgres-docker/builds)|
|11|[![Build Status](https://travis-matrix-badges.herokuapp.com/repos/LloydAlbin/postgres-docker/branches/main/2)](https://www.travis-ci.org/LloydAlbin/postgres-docker/builds)|
|12|[![Build Status](https://travis-matrix-badges.herokuapp.com/repos/LloydAlbin/postgres-docker/branches/main/3)](https://www.travis-ci.org/LloydAlbin/postgres-docker/builds)|
|13|[![Build Status](https://travis-matrix-badges.herokuapp.com/repos/LloydAlbin/postgres-docker/branches/main/4)](https://www.travis-ci.org/LloydAlbin/postgres-docker/builds)|
|**License**|![GitHub](https://img.shields.io/github/license/LloydAlbin/postgres-docker)|

This is a custom builder that is based off the Official PostgreSQL for Alpine Linux for use with TimescaleDB. The build script patches the official Dockerfile and then builds using the updated Dockerfile.

The Official PostgreSQL Alpine version is created by default without LDAP support. We need the LDAP support at work, so this repository contains the code to build the PostgreSQL Alpine with LDAP support and a few additional extensions.

```bash
cd ~
# Get the postgres-docker repository
git clone https://github.com/LloydAlbin/postgres-docker.git
```

## Built Docker Images

The built images may be found on [Docker Hub](https://hub.docker.com/r/lloydalbin/postgres).

The have been built with the -add all flag.

## Build Custom PostgreSQL Docker Image

The make command takes some optional options:

* --org lloydalbin
* --pg_name postgres
* --location location
* --push
* --push_only
* --clean
* --add pgtap
* --add pgaudit
* --add tds
* --add pgnodemx
* --add all

These options help define the docker image names in this format:

* org/pg_name:VERSION aka lloydalbin/postgres:12-alpine
* location aka ~ meaning ~/postgres for the repository needed to be downloaded
* --push aka push docker image(s) to the repsoitory
* --clean aka delete the repository
* --clean --clean aka delete the respository and do a system purge after the build.

Besides having LDAP enables, the pg_semver extension is also installed.

If you have your own inhouse docker registery, then the ORG name should be the name of your inhouse docker registry.

The build script will download the postgres repository.

```bash
# For the first time
~/postgres-docker/build_postgres.sh -v -v -v -V --add all -pgv pg11 --org=lloydalbin ---pg_name=postgres
~/postgres-docker/build_postgres.sh -v -v -v -V --add all -pgv pg12 --org=lloydalbin ---pg_name=postgres

# For the second time, otherwise the postgres Dockerfile will get double patched.
~/postgres-docker/build_postgres.sh --clean postgres --override_exit --add all -pgv pg12 --org=lloydalbin --pg_name=postgres

# For pushing the builds to the docker registry
docker login -U lloydalbin -p my_password
~/postgres-docker/build_postgres.sh -pgv pg12 --org=lloydalbin --pg_name=postgres --push_only
# You may also build and push at the same time.
~/postgres-docker/build_postgres.sh -v -v -v -V --add all -pgv pg12 --org=lloydalbin ---pg_name=postgres --push
```

### PostgreSQL Versions

The build_postgres.sh script has been updated to use PostgreSQL 12 by default, but still works for PostgreSQL 10, 11 and 13. To build a specific version, just use the -pgv flag to pg10, pg11, or pg13.

## Clean / Delete Repositories

If you wish to delete the repositories, you may do so manually or you can use the make command to clean up the postgres repository.

```bash
# Delete repositories
~/postgres-docker/build_postgres.sh --clean
# Optional: Just Postgres
~/postgres-docker/build_postgres.sh --clean postgres
```
