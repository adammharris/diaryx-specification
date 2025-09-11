---
title: Diaryx Optional Properties - Weather
author: Adam Harris
created: 2025-09-02T08:40:19-06:00
updated: 2025-09-10T21:49:33-06:00
visibility: public
format: "[CommonMark (Markdown)](https://spec.commonmark.org/0.31.2/)"
reachable: "[Diaryx Spec Github Repo](https://github.com/adammharris/diaryx-specification)"
part_of: "[Diaryx Writing Specification](<Diaryx Writing Specification.md>)"
---

# Diaryx Optional Properties - Weather

For those who log the weather in their journal entries, Diaryx has optional support for a `weather` property. This property is an enumerated value from a list taken from Open Weather Map. The value in the `weather` property may be any of the following, or up to four separate values containing no more than one value from each section:

Section 1 - thunderstorms
```
thunderstorm with light rain
thunderstorm with rain
thunderstorm with heavy rain
light thunderstorm
thunderstorm
heavy thunderstorm
ragged thunderstorm
thunderstorm with light drizzle
thunderstorm with drizzle
thunderstorm with heavy drizzle
```

Section 2 - precipitation
```
light intensity drizzle
drizzle
heavy intensity drizzle
light intensity drizzle rain
drizzle rain
heavy intensity drizzle rain
shower rain and drizzle
heavy shower rain and drizzle
shower drizzle
light rain  
moderate rain  
heavy intensity rain  
very heavy rain  
extreme rain  
freezing rain  
light intensity shower rain
shower rain  
heavy intensity shower rain  
ragged shower rain
light snow  
snow  
heavy snow  
sleet  
light shower sleet  
shower sleet  
light rain and snow  
rain and snow  
light shower snow  
shower snow  
heavy shower snow
```

Section 3 - special
```
mist  
smoke  
haze  
sand/dust whirls  
fog  
sand  
dust  
volcanic ash  
squalls  
tornado
```

Section 4 - cloud cover
```
clear sky  
few clouds: 11-25%  
scattered clouds: 25-50%  
broken clouds: 51-84%  
overcast clouds: 85-100%
```

**What about more weather information?**

Values such as sunset/sunrise times, moon phase, and length of day can be calculated from the location and time of your entry.

**Examples**
```yaml
weather: "thunderstorm" # it was a dark and stormy night…
weather: 
- "thunderstorm" # Or perhaps it was stormy…
- "snow" # AND snowy…
- "smoke" # And smokey?
- "scattered clouds: 25-50%" # And only half-covered?
```
