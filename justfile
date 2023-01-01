@_default:
    just --list

# installs/updates all dependencies
@bootstrap:
    docker-compose pull
    docker-compose build
    pip install -r requirements.in
    playwright install

# invoked by continuous integration servers to run tests
@cibuild:
    just bootstrap

@clean:
    rm -f Gemfile.lock
    rm -rf .vendor

# opens a console
@console:
    echo "TODO: console"

# starts app
@server *ARGS:
    docker-compose up {{ ARGS }}

# sets up a project to be used for the first time
@setup:
    just bootstrap

@start +ARGS="--detach":
    just server {{ ARGS }}

# runs tests
@test:
    echo "TODO: test"

# updates a project to run at its current version
@update:
    docker-compose pull

# ----

@fmt:
    just --fmt --unstable

@lint:
    djhtml \
        --in-place \
        --tabwidth 2 \
        *.html _includes/*.html _layouts/*.html
    rustywind \
        --write \
        .

@screenshots ARGS="--no-clobber":
    shot-scraper multi {{ ARGS }} ./shots.yml
