# Capstone Report

LaTeX sources for the capstone reports. Each report lives in its own folder
(e.g. [`midterm/`](midterm/)) with `main.tex` as the root file.

## Building

The project is compiled with [Tectonic](https://tectonic-typesetting.github.io/),
a self-contained TeX engine that downloads required packages on demand and runs
BibTeX automatically.

```sh
brew install tectonic   # one-time setup (macOS)
make                    # build all reports -> <report>/main.pdf
make midterm            # build a single report
make watch-midterm      # rebuild on file changes
make clean              # remove LaTeX intermediates
```

In VS Code, install the **LaTeX Workshop** extension; the workspace settings in
`.vscode/settings.json` configure it to build with Tectonic on save.
