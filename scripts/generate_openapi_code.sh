#!/usr/bin/env bash

# Turn on echo command
set -x

fern generate --local

sed 's/  \//  \/api\//' openapi.yaml > mock_openapi.yaml

cd sdks/python && \
    poetry run poe format && \
    cd -

cd sdks/ts && \
    npm i && npm run codegen && \
    cd -

cd agents-api && \
    poetry run poe codegen && \
    poetry run poe format && \
    cd -
