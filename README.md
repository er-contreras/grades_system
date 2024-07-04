## How to turn on the lights
    If you decide to use docker, you can do the next:

    - `docker-compose run --rm web build`
    - `docker-compose up`

    If you decide to run directly in your machine, you may choose your prefered way but I recommend the next.

    As I don't like to install many other dependecies over my ruby version I choose to install all the gems in a separate
    directory called vendor.

    - `bundle install --path vendor/bundle`

    In order to run rails you will need to do the next as follows.

    - `bundle exec rails s`

## Run test
    docker-compose run --rm web rails db:create RAILS_ENV=test
    docker-compose run --rm web bundle exec rspec spec

## External gems used
    - https://github.com/rspec/rspec-rails
    - https://github.com/thoughtbot/factory_bot_rails
    - https://github.com/faker-ruby/faker
    - https://github.com/thoughtbot/json_matchers

## Make requests
    You can make use of `curl` to make request.

    Example:

    - `curl -v http://localhost:3000/users -H "Authorization: Bearer <token>" | python3 -m json.tool`

## Entity Relational Database
![Screenshot 2024-05-23 at 12 22 02](https://github.com/er-contreras/grades_system/assets/67211919/be0df13e-89bb-4c09-8ed7-b3512f879f0a)
