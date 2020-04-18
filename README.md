# CommonMark Chez
## FFI Bindings for Chez Scheme

### Description
This library aims to provide the procedures in [CommonMark's](https://commonmark.org/) reference C implementation, [CMark](https://github.com/commonmark/cmark), to the Chez Scheme environment.

### Status
Currently only the procedure `cmark_markdown_to_html` is exposed as `markdown->html`.

### API

#### `(markdown->html string options)`
Option values are:
- `'default`
- `'sourcepos`
- `'hardbreaks`
- `'safe`
- `'unsafe`
- `'nobreak`
- `'normalize`


