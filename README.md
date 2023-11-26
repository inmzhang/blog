# Inm's Blog

This is my blog forked from [The Rust Blog](https://github.com/rust-lang/blog.rust-lang.org)

It's implemented as a small static site generator, that's deployed to GitHub
Pages via GitHub Actions.

## Building

To build the site locally:

```console
> git clone https://github.com/inmzhang/blog.git
> cd blog.rust-lang.org
> cargo run
```

You could do it in release mode if you'd like, but it's pretty fast in debug.

From there, the generated HTML will be in a `site` directory.
Open `site/index.html` in your web browser to view the site.

```console
> firefox site/index.html
```

You can also run a server, if you need to preview your changes on a different machine:

```console
> cargo run -p serve
Serving on: http://192.168.123.45:8000
```

## Contributing

When writing a new blog post, keep in mind the file headers:
```
---
layout: post
title: Title of the blog post
author: Blog post author (or on behalf of which team)
release: true (to be only used for official posts about Rust releases announcements)
---
```
