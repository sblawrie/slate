#!/bin/bash
bundle exec middleman build --clean
cp -R build/ ../wescreenplay/laravel/public/api-docs/v1/
