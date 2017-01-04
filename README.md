Anacapa Frontend
================

A first attempt at MVP for allowing students to self-enroll in a github organization associated with a course, provided (a) their school email address appears as a verified email address on their account, and (b) that email is in the course roster for the course (uploaded by the instructor)

To run this application in development, you need Postgres running locally, and a postgres user called `anacapa-frontend`.  Create it like this:

```
$ psql
psql (9.6.1)
Type "help" for help.

pconrad=# create user "anacapa-frontend" with createdb;
CREATE ROLE
pconrad=# \q
```

Also, edit the file `env.sh.EXAMPLE` to set the appropriate values.
* Values for github oauth from, for example <https://github.com/settings/applications/new>
* Create a machine account, and create a personal access token with the correct scope (user,admin:org) here: <https://github.com/settings/tokens>

Then run `bundle install`, `rake db:setup` and `rake db:migrate`, `rails server`, etc. in the normal fashion.

# EVERYTHING BELOW HERE WAS AUTOMATICALLY CREATED BY Rails Composer

[![Deploy to Heroku](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy)

This application was generated with the [rails_apps_composer](https://github.com/RailsApps/rails_apps_composer) gem
provided by the [RailsApps Project](http://railsapps.github.io/).

Rails Composer is supported by developers who purchase our RailsApps tutorials.

Problems? Issues?
-----------

Need help? Ask on Stack Overflow with the tag 'railsapps.'

Your application contains diagnostics in the README file. Please provide a copy of the README file when reporting any issues.

If the application doesn't work as expected, please [report an issue](https://github.com/RailsApps/rails_apps_composer/issues)
and include the diagnostics.

Ruby on Rails
-------------

This application requires:

- Ruby 2.3.0
- Rails 5.0.0.1

Learn more about [Installing Rails](http://railsapps.github.io/installing-rails.html).

Getting Started
---------------

Documentation and Support
-------------------------

Issues
-------------

Similar Projects
----------------

Contributing
------------

Credits
-------

License
-------
