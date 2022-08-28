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
    // var box = new Gtk.Box (Gtk.Orientation.VERTICAL, 10);
    var box = new Gtk.FlowBox ();
    box.column_spacing = 10;
    box.row_spacing = 10;
    box.margin_end = 15;
    box.margin_start = 15;
    box.margin_top = 15;
    box.margin_bottom = 15;
    box.selection_mode = Gtk.SelectionMode.NONE;

    var main_window = new Gtk.ApplicationWindow(this) {
      default_height = 500,
      default_width = 500,
      title = _("Fonty")
    };

    var fontMap = Pango.CairoFontMap.get_default();
    var context = fontMap.create_context();
    Pango.FontFamily[] families;

    context.list_families(out families);

    //  string length = (string) families.length;

    //  stdout.printf((string) families);
    //  stdout.printf("Number of fonts is " + (length == "" ? "0" : length) + "yep");

    if (families.length == 0) {
      box.append(new Gtk.Label("No font faces"));
    } else {
      var fontlist = new List<Pango.FontFamily>();

      foreach (var family in families) {
        fontlist.append (family);
      }

      fontlist.sort((a, b) => {
        return a.get_name().ascii_casecmp (b.get_name());
      });

      foreach (var family in fontlist) {
        var fontbox = new Gtk.Box(Gtk.Orientation.VERTICAL, 10);
        fontbox.margin_start = 15;
        fontbox.margin_end = 15;
        fontbox.margin_top = 15;
        fontbox.margin_bottom = 15;

        var label = new Gtk.Label(family.get_name());
        var labelattrs = new Pango.AttrList ();
        labelattrs.insert(Pango.attr_weight_new (Pango.Weight.MEDIUM));
        label.halign = Gtk.Align.START;
        label.attributes = labelattrs;
        fontbox.append(label);

        Pango.FontFace[] faces;

        family.list_faces(out faces);

        var facesbox = new Gtk.Box(Gtk.Orientation.VERTICAL, 0);

        foreach (var face in faces) {
          var facelabel = new Gtk.Label(face.get_face_name());
          facelabel.halign = Gtk.Align.START;
          var attrs = new Pango.AttrList();
          // attrs.insert(new Pango.AttrFontDesc (face.describe ()));
          attrs.insert(Pango.attr_scale_new (Pango.Scale.XX_LARGE));

          facelabel.attributes = attrs;
          facesbox.append(facelabel);
        }

        fontbox.append(facesbox);

        var frame = new Gtk.Frame(null);
        frame.set_child(fontbox);

        box.append(frame);
      }
    }

    var scrolled = new Gtk.ScrolledWindow ();
    scrolled.set_child(box);

    main_window.set_child (scrolled);
    main_window.present();
  }

  public static int main (string[] args) {
    return new MyApp().run(args);
  }
}
