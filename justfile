@_default:
    just --list

# installs/updates all dependencies
@bootstrap:
    docker-compose pull
    docker-compose build

# invoked by continuous integration servers to run tests
@cibuild:
    just bootstrap

# opens a console
@console:
    echo "TODO: console"

# starts app
@server *ARGS:
    docker-compose up {{ ARGS }}

# sets up a project to be used for the first time
@setup:
    just bootstrap

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

@screenshot:
    npx pageres https://webology.dev/ --overwrite --filename=./assets/images/screenshot
    npx pageres https://webology.dev/preview/ --overwrite --filename=./assets/images/preview
