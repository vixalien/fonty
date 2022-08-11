# gtk-hello

Following along the GTK tutorial from elementaryOS

## Link

Putting the link to the tutorial here cause I might forget: https://docs.elementary.io/develop/writing-apps/hello-world?s=09

### Nitpicks

- Inconsistent naming: `main_window` then `button_hello`
- Using `master` instead of `main`
- Maybe explain that `MyApp` can be anything and that the `public MyApp` is a constructor.
- I think we don't create the `Gtk.Application` but instead extend from it
- What's the difference between `run` and `activate`? Why not just call `MyApp().activate`?
- Maybe upgrade to GTK4
