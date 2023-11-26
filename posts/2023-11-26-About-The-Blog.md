---
layout: post
title: "About the blog"
author: Yiming Zhang
release: true
---

I've decided to launch a new blog to record my learning journey.
In the very first post, I'd like to talk about why I want it
and how I started.

## Why

I am lazy.

I did not have the good habbit to systematically document and review
the things I learned. It is quite bad. I am not the type of smart
guy who can retain information effortlessly. I forgot quickly. 
This is a disastor for learning, especially for a PhD student. Finally, 
I resolved to make a change, leading to the creation of this blog."

The main focus of this blog will be quantum computing(superconducting platform)
and programming. Superconducting qubit is what I majored in for my PhD and
programming is my hobby.

## How

I have used some static site generators like `jekyll` and `hugo`, which are both
great. However, for this time, I choose to fork the [The Rust Blog](https://github.com/rust-lang/blog.rust-lang.org)
repo and use the very basic functionality out of it. 

Firstly, I love the style of the rust blog. It's simple and consice. Secondly, the 
generator codebase is pretty small. I can read through the source code easilly and
make whatever changes I want at ease.

I cut off most unrelevant informations from it, e.g. the feed and metas in the headers.
And additionaly, I added [katex](https://katex.org/) for math typesetting support to the
code. Suprisingly, the version of `highlight.js` it used did not support some common languages
like Python. I have changed it to incoorperate the most of common language set.

That's all for now. Here's the blog. Fingers crossed I can maintain it!
