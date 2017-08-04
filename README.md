# [itty.be]

The [itty.be] project is a simple url shortener which values privacy. There's no analytics, ads, or tracking software of any kind.
Literally, it's just a url shortener.

Proudly built in Ruby with Sinatra as the framework and Redis as the database. It's really a single page app which makes requests over AJAX.
Presently, it's deployed on Heroku. Feel free to use it, fork the project, contribute some pull requests, and show some love with those stars.

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

## License

Source code released under the [MIT License]. This project makes use of several open source projects licensed under different terms. Please see the [Gemfile] for a current listing.

[itty.be]: http://itty.be
[MIT License]: http://github.com/codeblooded/ittybe/tree/master/LICENSE
[Terms of Service]: http://itty.be/terms
[Gemfile]: http://github.com/codeblooded/ittybe/tree/master/Gemfile
