@_default:
    just --list

# installs/updates all dependencies
bootstrap:
    #!/usr/bin/env bash
    set -euo pipefail

    docker compose build --force-rm

    pip install -r requirements.in

    playwright install

@clean:
    rm -rf .vendor _site Gemfile.lock

@cog:
    cog -r _includes/link-css-classes.html
    cog -r README.md

@down:
    docker-compose down

@fmt:
    just --fmt --unstable

@lint:
    pre-commit run --all-files

@restart:
    docker-compose restart

@screenshots ARGS="--no-clobber":
    shot-scraper multi {{ ARGS }} ./shots.yml

# starts app
@server *ARGS:
    docker-compose up {{ ARGS }}

# sets up a project to be used for the first time
@setup:
    just bootstrap

@start *ARGS="--detach":
    just up {{ ARGS }}

@stop:
    just down

@tail:
    docker-compose logs --follow --tail 100

@up *ARGS:
    docker-compose up {{ ARGS }}

# updates a project to run at its current version
@update:
    pre-commit autoupdate
    just bootstrap
