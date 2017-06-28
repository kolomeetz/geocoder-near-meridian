# README

This is small project to reproduce bug in [geocoder](https://github.com/alexreisner/geocoder) gem with searching POIs across the [180th meridian](https://en.wikipedia.org/wiki/180th_meridian).

It runs on sqlite3.

Steps to reproduce:
    
    bundle install && rake db:create && rake db:migrate && rake db:seeds

It creates database, the only model and two poins one near another but separated with 180th meridian.

Then run `rails console` and search for POIs. First:

```
irb> City.near([-30, -177], 5000)
=> #<ActiveRecord::Relation [#<City id: 1, name: "Kermadec Islands", address: "Kermadec Islands", latitude: -29.2666667, longitude: -177.9166667, created_at: "2017-06-28 16:16:22", updated_at: "2017-06-28 16:16:22">]>
```

It shows you only one object from west hemisphere. Second:

```
irb> City.near([-30, 177], 5000)
=> #<ActiveRecord::Relation [#<City id: 2, name: "Auckland", address: "Auckland, New Zealand", latitude: -36.8484597, longitude: 174.7633315, created_at: "2017-06-28 16:16:18", updated_at: "2017-06-28 16:16:18">]>
```

It shows you only one object from east hemispere. 

The distance between that points is calculated correctly:

```
irb> City.last.distance_to([City.first.latitude, City.first.longitude])
=> 673.3762329642476
```

