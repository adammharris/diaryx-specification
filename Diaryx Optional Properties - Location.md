---
title: Diaryx Optional Properties - Location
author: Adam Harris
created: 2025-09-02T08:08:12-06:00
updated: 2025-09-02T08:33:07-06:00
visibility: public
format: "[CommonMark (Markdown)](https://spec.commonmark.org/0.31.2/)"
part_of: "[Diaryx Writing Specification](<Diaryx Writing Specification.md>)"
---

# Diaryx Optional Properties - Location

Diaryx has optional support for location information, to allow for travel logs to be preserved. There are three properties that represent three different kinds of information:

## `coordinates`

This property is a comma-separated pair of floating point decimals, representing geographic coordinates. Degree sign (º) and letter indicators (N/S, E/W) are optional. Assumes the global WGS 84 datum.

```yaml
coordinates: "43.72309° N, 10.39657° E" # Leaning tower of Pisa!
coordinates: "-33.85684, 151.21510" # Sydney opera house!
# North/east = positive, south/west = negative
```

## `location`

This property is a string of text representing an address. Due to the widely varying nature of mailing/residental addresses, there is no standardized format for this property. A good rule of thumb is that a person should be able to copy/paste this value into a digital map and be able to find the location you are referring to.

```yaml
location: "1 Infinite Loop, Cupertino, CA  95014, United States"
location: "Great Pyramid of Giza, Giza, Egypt"
location: "40 Sejong-daero, Jung-gu, Seoul 04528, South Korea"
```

## `position`

This property is meant to include more specific information about location, such as a room in a house, a position on a chair, or a floor in a building.

```yaml
position: "bedroom"
position: "sitting on chair"
position: "3rd floor"
```
