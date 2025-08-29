---
title: Diaryx Optional Properties - Health
author: Adam Harris
created: 2025-08-29T12:07:47-06:00
updated: 2025-08-29T12:09:36-06:00
visibility: public
format: "[CommonMark (Markdown)](https://spec.commonmark.org/0.31.2/)"
---

# Diaryx Optional Properties - Health

Diaryx provides optional support for health-related properties, for those who use documents to log health data.

## Mood

### `mood`

One-word description of feeling.
```yaml
mood: "content" # :-)
mood: "calm" # :)
mood: "numb" # :|
```

### `mood_scale`

Rating of feeling from one to ten.
```yaml
mood_scale: "8/10" #feeling pretty good!
mood_scale: "3/10" #feeling sad :(
mood_scale: "11/10" #invalid, too high
mood_scale: "1/5" #invalid, must be out of 10
```

## Activity

### `activity_distance`

If an activity you are doing takes place over distance, you can record the distance here. Supported units include `mi`, `km`, `yd`, and `m`.
```yaml
activity_distance: "2mi" # nice run!
activity_distance: "1.2 km" #good job! (space between number and unit is optional)
activity_distance: "5 parsecs" #invalid unit
```

### `activity_type`

Record the type of activity you are doing here.
```yaml
activity_type: "running" # going fast!
activity_type: "HIIT" # working hard!
activity_type: "dance" # got moves?
```

### `calories_burned`

If you track the number of calories you burn during an activity, you can record it here.

```yaml
calories_burned: 1 #did you move today?
calories_burned: 1000 #wow, slow down
calories_burned: -5 #invalid, must be >0
```

### `steps`

If you track a number of steps you take, you can record that number here.
```yaml
steps: 100 #sedentary
steps: 20000 #many
steps: -100 #invalid, must be >0
```

## Sleep

### `sleep_hours`

Record the number of hours you sleep here. Single floating-point or integer number.
```yaml
sleep_hours: 8 # good sleep!
sleep_hours: 7.5 #realistic
sleep_hours: 1.45 #invalid, only one decimal allowed
sleep_hours: -3 #invalid, must be >0
```

### `sleep_scale`

Rate the quality of your sleep from 1 to 10. Same rules as `mood_scale`

## Vitals

### `blood_pressure`

Record systolic and diastolic blood pressure in the format similar to `120/80`
```yaml
blood_pressure: "140/100" #high
blood_pressure: "120.1/80.7" #invalid, only integers
blood_pressure: "120 / 80" # spaces are optional
blood_pressure: "120-80" #invalid, must be a /
```

### `heart_rate`

Record heart rate in beats per minute (bpm). Integer.
```yaml
heart_rate: 60 #resting rate
heart_rate: 400 #hummingbird
heart_rate: -80 #invalid, must be >0
```

### `body_weight`

Record your body weight. Floating point number or integer. Supports two units: `lbs` and `kg`
```yaml
body_weight: "130lbs" #average woman
body_weight: "185 lbs" # space optional
body_weight: "55kg" #artemis fowl
```

## Nutrition

### `calories_consumed`

Record the number of calories consumed, for those who count their calories. Integer >0.
```yaml
calories_consumed: 2000 #recommended daily amount
```

### `carbs_consumed`

Count the gram amount of carbohydrates consumed. Integer >0.

### `fats_consumed`

Count the gram amount of fat consumed. Integer >0.

### `proteins_consumed`

Count the gram amount of protein consumed. Integer >0.

### `water_consumed`

Count the amount of water consumed. Supports four units: `glasses`, `cups`, `grams`, and `liters`.
```yaml
water_consumed: "8 glasses" #good job!
water_consumed: "1liter" #thirsty! Space optional, `liter` is valid when the number is 1
```
