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

    if (families.length == 0) {
      box.add(new Gtk.Label("No font faces"));
    } else {
      var fontnames = new List<string>();

      foreach (var family in families) {
        fontnames.append (family.get_name());
      }

      fontnames.sort((a, b) => {
        return a.ascii_casecmp (b);
      });

      foreach (var fontname in fontnames) {
        stdout.printf("Got font: "+ fontname + "\n");
      }

      var family = families[0];
      var label = new Gtk.Label(family.get_name());
      var fontbox = new Gtk.Box(Gtk.Orientation.VERTICAL, 10);
      fontbox.add(label);

      Pango.FontFace[] faces;

      family.list_faces(out faces);

      var facesbox = new Gtk.Box(Gtk.Orientation.VERTICAL, 10);

      foreach (var face in faces) {
        var facelabel = new Gtk.Label(face.get_face_name());
        facesbox.add(facelabel);
      }

      fontbox.add(facesbox);

      box.add(fontbox);
    }


    main_window.add(box);
    main_window.show_all();
  }

  public static int main (string[] args) {
    return new MyApp().run(args);
  }
}
