---
title: Diaryx-Obsidian Workflow
author: Adam Harris
created: 2025-08-28T01:10:45+00:00
updated: 2025-08-27T19:52:24-06:00
visibility: public
format: "[CommonMark (Markdown)](https://spec.commonmark.org/0.31.2/)"
---

# Diaryx-Obsidian Workflow

To use Diaryx in an Obsidian vault, you can set a specific setting in the regular Obsidian settings, and use two helpful community plugins:

- [_Linter_](obsidian://show-plugin?id=obsidian-linter)
- [_Frontmatter Markdown Links_](obsidian://show-plugin?id=obsidian-linter)

_Frontmatter Markdown Links_ allows for clickable Markdown-style links in Obsidian frontmatter, which is very helpful for those who make extensive use of the `contents` and `part_of` properties. _Linter_ allows you to define a specific YAML schema and automatically update the title and timestamp fields.

First, change the "Use \[\[Wikilinks]]" option in Obsidian's "Files and Links" settings to **off**. The Diaryx schema only supports Markdown links for compatibility.

Next, install _Linter_ and _Frontmatter Markdown Links_.

Next, configure _Linter_ with the following options:
1. Turn **on** "Insert YAML Attributes"
2. Insert the following content into the "Text to insert" text box:
```
title:
author:
created:
updated:
visibility:
format:
```
3. Turn **on** "YAML Timestamp"
4. Change the "Date Created Key" value to `created` to match the Diaryx schema
5. Change the "Date Modified Key" value to `updated` to match the Diaryx schema
6. Insert `YYYY-MM-DDTHH:mm:ssZ` into the "Format" text box to match the required RCC 3339 timestamp format.
7. Finally, turn **on** "YAML Title". The default options should work.

## Optional configuration

Here are some suggested (but not required) changes to get a little more leverage out of your Diaryx-Obsidian workflow.

- In general _Linter_ settings, turn on "Lint on Save" and "Lint on Focused File Change" so you don't have to activate the lint manually.
- Turn **on** "YAML Key Sort" in the YAML settings. Insert the same content into "YAML Key Priority Sort Order" that you already inserted into the "Text to insert" text box.
- Turn **on** "Convert Local Time to UTC" for timezone privacy with the timestamps. Or, leave this off if you want to preserve timezone information.

## Celebrate!

Congratulations! Now your Obsidian vault will enforce the Diaryx format, ensuring that your files always have a clear source of truth for a variety of 