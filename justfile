export JUST_UNSTABLE := "true"

@_default:
    just --list

# installs/updates all dependencies
bootstrap:
    #!/usr/bin/env bash
    set -euo pipefail

    docker compose build --force-rm

    pip install --upgrade pip uv
    uv pip install --requirement requirements.in

    playwright install

# removes generated files
@clean:
    rm -rf .vendor _site Gemfile.lock

# updates README.md with cog
@cog:
    uv tool run cog -r README.md

# stops all docker services
@down:
    docker compose down

# formats the justfile
@fmt:
    just --fmt

# formats html and sorts tailwind classes
@lint:
    uv run --with pre-commit-uv pre-commit run --all-files

# restarts all docker services
@restart:
    docker compose restart

# generates screenshots using shot-scraper
@screenshots ARGS="--no-clobber":
    uv run shot-scraper multi {{ ARGS }} ./shots.yml

# starts app
@server *ARGS:
    docker compose up {{ ARGS }}

# sets up a project to be used for the first time
@setup:
    just bootstrap

# starts server in detached mode
@start *ARGS="--detach":
    just up {{ ARGS }}

# stops all docker services
@stop:
    just down

# follows docker container logs
@tail:
    docker compose logs --follow --tail 100

# starts docker services
@up *ARGS:
    docker compose up {{ ARGS }}

# updates a project to run at its current version
@update:
    uv run --with pre-commit-uv pre-commit autoupdate
    just bootstrap
