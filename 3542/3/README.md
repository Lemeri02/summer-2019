Execute in terminal:

```export BOOTSTRAP=https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css```

```export BOOTSTRAP_INTEGRITY=sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T```

If you run application first:

```bundle```

```rake db:create db:migrate```

Then in project folder:

```ruby db/seeds.rb```

```ruby app.rb```
