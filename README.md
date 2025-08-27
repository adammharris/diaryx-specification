---
title: Diaryx Writing Specification
author: Adam Harris
created: 2025-08-08 14:41:00-0600
updated: 2025-08-26 18:01:08-0600
visibility: public
format: "[CommonMark (Markdown)](https://spec.commonmark.org/0.31.2/)"
copying: "[Creative Commons Attribution-Sharealike 4.0](https://creativecommons.org/licenses/by-sa/4.0/)"
version: v0.1.1
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
format: https://spec.commonmark.org/0.31.2/
part_of: "()[<Journal entries>]"
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
created: YYYY-MM-DD HH:mm:ssZZ
updated: YYYY-MM-DD HH:mm:ssZZ
visibility: author_defined_visibility_rule
format: https://spec.commonmark.org/0.31.2/
---
```

1. `title`: String representing the document.
2. `author`: Single string or list of strings representing author/authors of document.
3. `created`: Timestamp at creation of file, format of YYYY-MM-DD HH:mm:ssZZ in MomentJS format (where ZZ is ±HHmm indicating timezone distance away from UTC).
4. `updated`: Timestamp at time of last modification to file. Same format as `created`
5. `visibility`: Intended to represent who the writing is intended for, such as `private` or `public`. Can be any single string or list of strings. If this value is a list, the list should not include the values "public" or "private" in order to avoid confusion.
6. `format`: URI or file path pointing to the specification that defines how to parse this document's content. By default, is the latest CommonMark spec. 

## Optional

### `contents`

Specifies child documents that this index file organizes, listed in intended reading/processing order. Only used by index files.

```yaml
# All equivalent - choose your preference. Default is `index`
index:
  - "()[<chapter-01>]"
  - "()[<chapter-02>]"

contents:
  - "()[<chapter-01>]" 
  - "()[<chapter-02>]"

children:
  - "()[<chapter-01>]"
  - "()[<chapter-02>]"
```

**Format rules:**

- **Files** are represented as quoted Markdown links: `"(alias)[<filename>]"`
- Items should be listed in intended reading/processing order
- File paths are relative to the document containing this frontmatter

### `part_of`

Specifies parent index files that contain/organize this document. Only used by content files.

```yaml
# Single parent
part_of: "()[<GoCoEdit Index>]"

# Multiple parents  
part_of:
  - "()[<GoCoEdit Index>]"
  - "()[<Creative Writing Index>]"

# Equivalent using 'parents' alias
parents: "()[<GoCoEdit Index>]"
```

### `this_file_is_root_index`

Boolean indicating whether this file serves as the root index for a collection. If a file uses this property, it must also use the `index`/`contents`/`children` property.
```yaml
this_file_is_root_index: true   # This is the main organizational hub
```

### `format-extensions`

Optional list of additional format specifications that modify the base format. Used for extending CommonMark (or other format) with additional syntax or features.

```yaml
format-extensions:
  - "./extensions/math-blocks.md"
  - "https://github.com/user/custom-callouts"
```
### `version`

A version number for the document, in case you want to record formal version updates.

### `copying`

Used for showing users the ways they are allowed to copy the document. Can be a file path to a license file, or a link to a popular license, such as https://creativecommons.org/licenses/by/4.0/

### `checksums`

File path to checksums. Useful for verifying file downloads.

### `banner`

Used for specifying an optional Notion-style image banner over a file. Link to image, or alternatively use `!(alias)[<link>]` syntax.

### `language`

Used for specifying the language this file is written in.