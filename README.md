# [itty.be]

<img src="https://github.com/codeblooded/ittybe/blob/master/assets/images/demo.gif?raw=true" width="500px" />

The [itty.be] project is a simple url shortener which values privacy. There's no analytics, ads, or tracking software of any kind.
Literally, it's just a url shortener.

Proudly built in Ruby with Sinatra as the framework and Redis as the database. It's really a single page app which makes requests over AJAX. Feel free to use it, fork the project, contribute some pull requests, and show some love with those stars.

## API

Yes, you can use the API. By doing so, you agree to the [Terms of Service]. Give it a test drive! Send a `POST` request to http://itty.be/shorten with a JSON body like this:

```json
{
    "url": "THE LONG URL GOES HERE :)"
}
```

And, you'll get back something like this:

```json
{
    "url": {
        "long": "http://twitter.com/benvreed",
        "short": "http://itty.be/zdfd1"
    }
}
```

## Deploying Your Own Shortener

This project is designed to be a backbone for building other url shorteners. It's super simple to customize. Clone the repo, and edit the [config.yml](http://github.com/codeblooded/ittybe/tree/master/config.yml) file to use your domain name and adjust the length of the paths if you so choose.

Then, the project is easily deployable. It's deployed on Heroku right now, and you can successfully scale it using Heroku Redis. In the future, I hope to add docker support.

## Contributing

If you're reading this section, you're already awesome!  Feel free to send PRs, open issues, and share the project with your friends. As for style guidelines, I generally like to follow the [bbatsov/ruby-style-guide](http://github.com/bbatsov/ruby-style-guide). Logically name your commits, and don't push to the master branch if granted commit access. Master is always directly deployed on Heroku.

## Testing <img src="https://img.shields.io/codeship/a9aff230-5c51-0135-594b-3e3c953d0b79/master.svg" />

The [itty.be] url shortener is tested using rspec. You can run the tests using
the following command:

    $ bundle exec rspec .

## License

Source code released under the [MIT License]. This project makes use of several open source projects licensed under different terms. Please see the [Gemfile] for a current listing.

[itty.be]: http://itty.be
[MIT License]: http://github.com/codeblooded/ittybe/tree/master/LICENSE
[Terms of Service]: http://itty.be/terms
[Gemfile]: http://github.com/codeblooded/ittybe/tree/master/Gemfile
