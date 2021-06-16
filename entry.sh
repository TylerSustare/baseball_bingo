#!/bin/bash

export SECRET_KEY_BASE=$(cat .secret)
export DATABASE_URL=$(cat .db_url)
_build/prod/rel/bingo_hall/bin/bingo_hall start
