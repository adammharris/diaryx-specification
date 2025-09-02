---
title: Diaryx Optional Properties - Device Info
author: Adam Harris
created: 2025-09-02T08:56:01-06:00
updated: 2025-09-02T09:08:04-06:00
visibility: public
format: "[CommonMark (Markdown)](https://spec.commonmark.org/0.31.2/)"
part_of: "[Diaryx Writing Specification](<Diaryx Writing Specification.md>)"
---

# Diaryx Optional Properties - Device Info

For those who want to record information about the device where a file was created, Diaryx has optional support for device information properties. These properties have a soft-standardization: specific strings in them will be recognized, but there is no specific schema for them.

## `created_on_hardware`

This property is used to specify what kind of hardware this file was created on. For detailed information, you may use key-values separated by semicolons. You may also include a list of options to indicate that this entry was created through multiple devices.
```yaml
# general devices
created_on_hardware: "phone"
created_on_hardware: "laptop"
created_on_hardware: "desktop"
created_on_hardware: "tablet"
created_on_hardware: "e-reader"
created_on_hardware: "watch"
created_on_hardware: "other" # not recommended. Prefer leaving the property out entirely

# specific devices
created_on_hardware: "Adam's Laptop; Model Identifier: Mac15,6" # supported; "laptop" will be identified

created_on_hardware: # multiple entries supported
- "Adam's Laptop"
- "Adam's Phone"
- "Adam's Tablet"
```

## `created_on_software`

This property is used to specify which software this file was created with.

```yaml
created_on_software: "[Diaryx](https://www.diaryx.net)"
created_on_software: # mutliple entries supported
- "Diaryx"
- "Neovim"
- "Obsidian"
```