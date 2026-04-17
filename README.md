# Backend Notes

This folder contains the challenge-specific Rails API code (controllers/models/migrations/channels/specs).

If this is a fresh environment, generate the Rails skeleton first:

```bash
rails new backend --api -d postgresql
```

Then keep these challenge files and run:

```bash
bundle install
rails db:create db:migrate db:seed
bundle exec rspec
```
