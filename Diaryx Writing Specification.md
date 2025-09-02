---
title: Diaryx Writing Specification
author: Adam Harris
created: 2025-08-28T01:17:34+00:00
updated: 2025-09-02T09:14:41-06:00
visibility: public
format: "[CommonMark (Markdown)](https://spec.commonmark.org/0.31.2/)"
contents:
  - "[Optional Properties - Device Info](<Diaryx Optional Properties - Device Info.md>)"
  - "[Optional Properties - Health](<Diaryx Optional Properties - Health>)"
  - "[Optional Properties - Location](<Diaryx Optional Properties - Location.md>)"
  - "[Optional Properties - Weather](<Diaryx Optional Properties - Weather.md>)"
copying: "[Creative Commons Attribution-Sharealike 4.0](https://creativecommons.org/licenses/by-sa/4.0/)"
this_file_is_root_index: "true"
version: v0.5.1
---

# Diaryx Writing Specification

**The Diaryx format is a standardized metadata and file organization format with the goal to enable personal writings to last forever.** To accomplish this, it is designed to:
1. Be easy for humans to read and use directly.
2. Clearly describe its own structure, making sharing and importing straightforward.
3. Be easy for software to parse, search, and transform.

## Why is this standard needed?

**Digital journaling has no single portable format.** All store entries differently and export in inconsistent ways. Even when a popular format such as Markdown is used, there’s no agreement on how to represent important metadata such as dates, relation to other writings, or sharing permissions. As a result, personal writings — often a person’s most important and private records — risk being lost over time.

**Most things people write are not intended to be public.** In contrast, existing standardized writing formats are public-facing (essays, posts, microblogs, comments). HTML, APA, and MLA are all designed for public-facing or academic work. Non-public or private writing deserves the same long-term portability as published works, but without specialized formatting rules.

The Diaryx format aims to fill this gap. **It standardizes metadata in an easily comprehensible way and encourages good defaults, ensuring that an entry can be read and understood decades later.**

## Principles

Principles are guidelines for how this specification should be. Here are some guidelines:
- **Human-readable**: Diaryx metadata should make intuitive sense to a non-technical person reading the plain text file. For example, we avoid JSON and prefer YAML. And by default, a file's format is CommonMark, a well-defined markup syntax designed to be both readable in plain text and publishable as-is.
- **Self-describing**:  A Diaryx file should describe itself sufficiently well to introduce a newcomer. For example, the required properties answer the basic newcomer questions of "What is this?" (title) "Who wrote it?" (author) "When was it written?" (created, updated) "Who can see it?" (visibility) and "How do I understand it?" (format). Additional optional properties allow authors to provide more context when needed.
- **Author flexibility**: Should limit the author as little as possible— not requiring them to name or organize their files in a specific way where reasonable.
- **Minimal metadata**: A Diaryx file should describe itself as concisely as possible. It should follow well-established conventions and use the absolute minimum amount of metadata possible, while still being sufficiently self-describing.

## Use-case

Imagine you open a file or folder without any prior context. What would you search for? How would you understand the content of the file?

Perhaps the most intuitive introduction is a plain description in your native language, like "This file is a journal entry recorded on Dec 31, 2003 by John Doe." However, this presupposes several things: 
- the reader is familiar with how this entry relates to other entries
- the reader knows what format John Doe usually writes his entries in
- the reader knows John Doe is okay with sharing this entry

If the file was in Diaryx format, the reader would see something like this:

```yaml
---
title: Thoughts about stuff
author: John Doe
created: 2025-08-25 16:24:16-0600
updated: 2025-08-25 16:24:16-0600
visibility: family
format: "[CommonMark (Markdown)](https://spec.commonmark.org/0.31.2/)"
part_of: "[](<Journal entries.md>)"
---
Today I had thoughts about stuff…
```

Now the reader knows that this entry is appropriate to share with family, and that John Doe recorded this particular entry in CommonMark format. We also see that this entry is part of a larger group of entries, as is evident in the `part_of` attribute.

# YAML Frontmatter

YAML frontmatter is a common convention for human-readable metadata. Diaryx adopts this convention and requires six properties, and allows for additional properties.

## Required

```yaml
---
title: Title of file
author: Name of author
created: YYYY-MM-DDTHH:mm:ssZ
updated: YYYY-MM-DDTHH:mm:ssZ
visibility: author_defined_visibility_rule
format: "[CommonMark (Markdown)](https://spec.commonmark.org/0.31.2/)"
---
```

1. `title`: String representing the document.
2. `author`: Single string or list of strings representing author/authors of document.
3. `created`: Timestamp at creation of file, RFC 3339 formatted (YYYY-MM-DDTHH:mm:ssZ in MomentJS style).
4. `updated`: Timestamp at time of last modification to file. Same format as `created`
5. `visibility`: Intended to represent who the writing is intended for, such as `private` or `public`. Can be any single string or list of strings. If this value is a list, the list should not include the values "public" or "private" in order to avoid confusion.
6. `format`: URI, Markdown link, or file path pointing to the specification that defines how to parse this document's content. By default, is the latest CommonMark spec.  Can also be a list to allow for a certain format with extensions (for example, CommonMark with table, footnote, and callout extensions).

## Optional

### `contents`

Specifies child documents that this index file organizes, listed in intended reading/processing order. Only used by index files.

```yaml
contents:
  - "[Chapter One](chapter-01.md)" 
  - "[Chapter Two](chapter-02.md)"
```

**Format rules:**

- Files are represented as quoted Markdown links: `"[alias](link)"`
- Items should be listed in intended reading/processing order
- File paths are relative to the document containing this frontmatter
- Note that markdown links must be URL-encoded. To avoid this, the CommonMark spec allows links to be wrapped in angle brackets so you can write the name of the link without URL encoding (for example, `[GoCoEdit Files](<GoCoEdit Files.md>)` as opposed to `[GoCoEdit Files](GoCoEdit%20Files.md)`)
- Make sure to include file extensions in the link for compatibility.

### `part_of`

Specifies parent index files that contain/organize this document. Only used by content files.

```yaml
# Single parent
part_of: "[](<GoCoEdit files.md>)"

# Multiple parents  
part_of:
  - "[](<GoCoEdit files.md>)"
  - "[](<Creative Writing.md>)"
```

### `version`

A version number for the document, in case you want to record formal version updates. This specification has an example at the top.

### `copying`

Used for showing users the ways they are allowed to copy the document. Can be a file path to a license file, or a link to a popular license, such as <https://creativecommons.org/licenses/by/4.0/>. This specification has an example at the top.

### `checksums`

File path to checksums. Useful for verifying file downloads.

### `banner`

Used for specifying an optional Notion-style image banner over a file. Link to image, or alternatively use `!(alias)[<link>]` syntax.

### `language`

Used for specifying the language this file is written in.

### `tags`, `aliases`

Both of these are lists of arbitrary strings. `tags` is used for assigning topics or organization groups to entries. `aliases` is used to specify other names this entry could go by.

```yaml
tags: ["notes","thoughts"] #any string you want, as many as you want
aliases: ["That one note", "my favorite note"]
``` 

### Flags

These property values give information simply by their presence. Their value is always `true`; otherwise they are invalid. (That is, a `false` value would be the flag simply not being present.)

#### `this_file_is_root_index`

Flag indicating whether this file serves as the root index for a collection. If a file uses this property, it must also use the `contents` property. If present, must be `true`.
```yaml
this_file_is_root_index: true   # This is the main organizational hub
```

#### `starred`

Flag indicating that this file has been designated by the author to be part of a special first-class group of documents. If present, must be `true`.

#### `pinned`

Flag indicating that this file has been designated as requiring a prominent, visible spot in the UI.

### Device information properties

For those who want to track which files were created on which device, Diaryx has optional support for device information properties. For information about these optional properties, please visit [Diaryx Optional Properties - Device Info](<Diaryx Optional Properties - Device Info.md>)
### Health-related properties

For those who use journaling to track their health, Diaryx has optional support for a wide array of health metrics: mood, activity, sleep, vitals, and nutrition. For information about these optional properties, please visit [Diaryx Optional Properties - Health](<Diaryx Optional Properties - Health.md>).

### Location-related properties

For those who use journaling to log their travels, Diaryx has optional support for location data, including `coordinates`, `location`, and `position`. For information about these optional properties, please visit [Diaryx Optional Properties - Location](<Diaryx Optional Properties - Location.md>).

### `weather` property

For those who log the weather in their journal, Diaryx has optional support for weather metadata. For more information about this optional property, please visit [Diaryx Optional Properties - Weather](<Diaryx Optional Properties - Weather.md>).
## Error Handling

If the YAML frontmatter is malformed, it may not be parsed and the Diaryx-formatted file is invalid.

If the YAML is valid but does not adhere to rules in the specification (for example, an invalid range or unit), that specific property is invalid, but the Diaryx formatted file is otherwise valid. If any of the required properties are invalid, the whole Diaryx file is invalid.