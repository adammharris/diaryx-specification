---
title: Diaryx Writing Specification
author: Adam Harris
created: 2025-08-28T01:17:34+00:00
updated: 2025-08-27T20:21:05-06:00
visibility: public
format: "[CommonMark (Markdown)](https://spec.commonmark.org/0.31.2/)"
copying: "[Creative Commons Attribution-Sharealike 4.0](https://creativecommons.org/licenses/by-sa/4.0/)"
version: v0.1.4
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
part_of: "[](<Journal entries>)"
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
  - "[Chapter One](<chapter-01>)" 
  - "[Chapter Two](<chapter-02>)"
```

**Format rules:**

- **Files** are represented as quoted Markdown links: `"(alias)[<filename>]"`
- Items should be listed in intended reading/processing order
- File paths are relative to the document containing this frontmatter

### `part_of`

Specifies parent index files that contain/organize this document. Only used by content files.

```yaml
# Single parent
part_of: "[](<GoCoEdit files>)"

# Multiple parents  
part_of:
  - "[](<GoCoEdit files>)"
  - "[](<Creative Writing>)"
```

### `this_file_is_root_index`

Boolean indicating whether this file serves as the root index for a collection. If a file uses this property, it must also use the `index`/`contents`/`children` property.
```yaml
this_file_is_root_index: true   # This is the main organizational hub
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

### Health-related properties

For those who use journaling to track their health, Diaryx has optional support for a wide array of health metrics: mood, activity, sleep, vitals, and nutrition.

#### Mood

##### `mood`

One-word description of feeling.
```yaml
mood: "content" # :-)
mood: "calm" # :)
mood: "numb" # :|
```

##### `mood_scale`

Rating of feeling from one to ten.
```yaml
mood_scale: "8/10" #feeling pretty good!
mood_scale: "3/10" #feeling sad :(
mood_scale: "11/10" #invalid, too high
mood_scale: "1/5" #invalid, must be out of 10
```

#### Activity

##### `activity_distance`

If an activity you are doing takes place over distance, you can record the distance here. Supported units include `mi`, `km`, `yd`, and `m`.
```yaml
activity_distance: "2mi" # nice run!
activity_distance: "1.2 km" #good job! (space between number and unit is optional)
activity_distance: "5 parsecs" #invalid unit
```

##### `activity_type`

Record the type of activity you are doing here.
```yaml
activity_type: "running" # going fast!
activity_type: "HIIT" # working hard!
activity_type: "dance" # got moves?
```

##### `calories_burned`

If you track the number of calories you burn during an activity, you can record it here.

```yaml
calories_burned: 1 #did you move today?
calories_burned: 1000 #wow, slow down
calories_burned: -5 #invalid, must be >0
```

##### `steps`

If you track a number of steps you take, you can record that number here.
```yaml
steps: 100 #sedentary
steps: 20000 #many
steps: -100 #invalid, must be >0
```

#### Sleep

##### `sleep_hours`

Record the number of hours you sleep here. Single floating-point or integer number.
```yaml
sleep_hours: 8 # good sleep!
sleep_hours: 7.5 #realistic
sleep_hours: 1.45 #invalid, only one decimal allowed
sleep_hours: -3 #invalid, must be >0
```

##### `sleep_scale`

Rate the quality of your sleep from 1 to 10. Same rules as `mood_scale`

#### Vitals

##### `blood_pressure`

Record systolic and diastolic blood pressure in the format similar to `120/80`
```yaml
blood_pressure: "140/100" #high
blood_pressure: "120.1/80.7" #invalid, only integers
blood_pressure: "120 / 80" # spaces are optional
blood_pressure: "120-80" #invalid, must be a /
```

##### `heart_rate`

Record heart rate in beats per minute (bpm). Integer.
```yaml
heart_rate: 60 #resting rate
heart_rate: 400 #hummingbird
heart_rate: -80 #invalid, must be >0
```

##### `body_weight`

Record your body weight. Floating point number or integer. Supports two units: `lbs` and `kg`
```yaml
body_weight: "130lbs" #average woman
body_weight: "185 lbs" # space optional
body_weight: "55kg" #artemis fowl
```

#### Nutrition

##### `calories_consumed`

Record the number of calories consumed, for those who count their calories. Integer >0.
```yaml
calories_consumed: 2000 #recommended daily amount
```

##### `carbs_consumed`

Count the gram amount of carbohydrates consumed. Integer >0.

##### `fats_consumed`

Count the gram amount of fat consumed. Integer >0.

##### `proteins_consumed`

Count the gram amount of protein consumed. Integer >0.

##### `water_consumed`

Count the amount of water consumed. Supports four units: `glasses`, `cups`, `grams`, and `liters`.
```yaml
water_consumed: "8 glasses" #good job!
water_consumed: "1liter" #thirsty! Space optional, `liter` is valid when the number is 1
```




