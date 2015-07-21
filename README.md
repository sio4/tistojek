# tistojek, TisToJek or Tis2Jek

`tistojek` is **TIS**tory **TO** **JEK**yll Markdown converter for
tistory.com users who consider migrate to jekyll/markdown based
blogging system like github.io.

It takes Tistory's backup XML file as the one and only argument,
then exports all posts and its attachments into directory named
`_in` and `attachments`. Then you can review and edit posts in `_in`
more simply.

Most of attached images are autometically _markdowned_ within post
body but some are not. so you should better to review and edit all
posts.

## Installation

`tistojek` is ruby application so you need to install `ruby` and
some required gems. (`bundler` also used for gem management)

```
$ sudo apt-get install ruby ruby-dev
$ sudo apt-get install build-essential
$ sudo apt-get install zlib1g-dev
$ sudo gem install bundler --no-ri --no-rdoc
```

(`nokogiri` gem has native extensions so you need to install compiler
and zlib dev files.)

then,

```
$ bundle install --path ./vendor/bundle
Fetching gem metadata from https://rubygems.org/.........
Fetching version metadata from https://rubygems.org/..
Installing mini_portile 0.6.2
Installing nokogiri 1.6.6.2 with native extensions
Installing reverse_markdown 0.8.2
Using bundler 1.10.5
Bundle complete! 2 Gemfile dependencies, 4 gems now installed.
Bundled gems are installed into ./vendor/bundle.
$ 
```

OK, installation done!

## Usage

Now, you can run `tistojek` like below:

```
$ bundle exec ./tistojek.rb Tistory-Backup-20150721.xml 
Input: Tistory-Backup-20150721.xml
Read 7751254 Byte from Tistory-Backup-20150721.xml.
<...>
$ 
```

## Limitation

* Comments are not supported
* Some embedded images are not converted to markdown.

## License

Tistojek: Tistory.com to Jekyll Markdown converter

Copyright (C) 2015  Yonghwan SO

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
