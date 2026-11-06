# Levi

CSS for the HTML you already write. One stylesheet, no JavaScript, no build step.

```html
<link rel="stylesheet" href="levi.css">
<body class="mc-theme">
```

`levi.css` is one file with every component inside, and `levi.min.css` is the same without comments. The components live in `src/`, and `./build.sh` rebuilds both files (a commit hook does it too).

Open `index.html` to start, `demo/` for every component on one page, and one folder per component (`progress/`, `table/`, `tabs/`) for its documentation.

## A note on activity

Few commits does not mean a dead project. Levi is meant to be finished.

The Mona Lisa was completed hundreds of years ago and now receives only light maintenance. That does not make it worse than a painting finished yesterday. A library that does its job, and has little left to add, is complete, not abandoned.
