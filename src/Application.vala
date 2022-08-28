/**
 * SPDX-License-Identifier: MIT
 * SPDX-FileCopyrightText: 2022 Angelo Verlain <geoangercola@gmail.com>
 */

public class MyApp : Gtk.Application {
  public MyApp () {
    Object (
      application_id: "com.vixalien.gtk_hello",
      flags: ApplicationFlags.FLAGS_NONE
    );
  }

  protected override void activate () {
    var box = new Gtk.Box (Gtk.Orientation.VERTICAL, 10);

    var main_window = new Gtk.ApplicationWindow(this) {
      default_height = 300,
      default_width = 300,
      title = _("Hello World")
    };

    var fontMap = Pango.CairoFontMap.get_default();
    var context = fontMap.create_context();
    Pango.FontFamily[] families;

    context.list_families(out families);

    //  string length = (string) families.length;

    //  stdout.printf((string) families);
    //  stdout.printf("Number of fonts is " + (length == "" ? "0" : length) + "yep");

    foreach (var family in families) {
      var label = new Gtk.Label(family.get_name());
      box.add(label);
    }

    main_window.add(box);
    main_window.show_all();
  }

  public static int main (string[] args) {
    return new MyApp().run(args);
  }
}
