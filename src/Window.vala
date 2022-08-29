namespace Fonty {
  public class Face : Gtk.Box {
    Gtk.Label label;
    Pango.FontFace face;

    public Face(ref Pango.FontFace face) {
      this.face = face;
      var new_label = new Gtk.Label(face.get_face_name());
      new_label.halign = Gtk.Align.START;
      var attributes = new Pango.AttrList();
      attributes.insert(Pango.attr_scale_new (Pango.Scale.XX_LARGE));
      new_label.attributes = attributes;
      this.label = new_label;
      this.append(new_label);

      this.render();
    }

    public void render () {
      this.label.attributes.insert(new Pango.AttrFontDesc (face.describe ()));
    }
  }

  public class Family : Gtk.Box {
    public Family (ref unowned Pango.FontFamily family) {
      Object(
        orientation: Gtk.Orientation.VERTICAL,
        spacing: 10,
        margin_start: 15,
        margin_end: 15,
        margin_top: 15,
        margin_bottom: 15
      );

      var label = new Gtk.Label(family.get_name());
      var labelattrs = new Pango.AttrList ();
      labelattrs.insert(Pango.attr_weight_new (Pango.Weight.MEDIUM));
      label.halign = Gtk.Align.START;
      label.attributes = labelattrs;
      this.append(label);

      Pango.FontFace[] faces;

      family.list_faces(out faces);

      var facesbox = new Gtk.Box(Gtk.Orientation.VERTICAL, 0);

      foreach (var face in faces) {

        var facebox = new Fonty.Face(ref face);
        facesbox.append(facebox);
      }

      this.append(facesbox);
    }
  }

  public class Window : Gtk.ApplicationWindow {
    List<weak Pango.FontFamily> families;
    List<weak Pango.FontFamily> searched_families;

    Gtk.Overlay font_box = new Gtk.Overlay ();

    public Window (Gtk.Application app) {
      Object(
        application: app,
        default_height: 500,
        default_width: 500
      );
    }

    void load_fonts () {
      var fontMap = Pango.CairoFontMap.get_default();
      var context = fontMap.create_context();

      Pango.FontFamily[] families_array;

      context.list_families(out families_array);

      var list = new List<Pango.FontFamily>();

      foreach (var family in families_array) {
        list.append (family);
      }

      list.sort((a, b) => {
        return a.get_name().ascii_casecmp (b.get_name());
      });

      families = list.copy();
      this.init_search ();
      this.show_fonts ();
    }

    void show_fonts () {
      var box = new Gtk.FlowBox ();
      box.column_spacing = 10;
      box.row_spacing = 10;
      box.margin_end = 15;
      box.margin_start = 15;
      box.margin_top = 15;
      box.margin_bottom = 15;
      box.selection_mode = Gtk.SelectionMode.NONE;
      box.homogeneous = false;

      var containerbox = new Gtk.Box(Gtk.Orientation.VERTICAL, 0);

      containerbox.append(searchbar);

      if (searched_families.length() == 0) {
        var label = new Gtk.Label("There are no installed fonts");
        var labelattrs = new Pango.AttrList ();
        labelattrs.insert(Pango.attr_scale_new(Pango.Scale.XX_LARGE));
        label.halign = Gtk.Align.CENTER;
        label.vexpand = true;
        label.attributes = labelattrs;
        containerbox.append(label);
      } else {
        searched_families.foreach ((family) => {
          var familybox = new Fonty.Family(ref family);

          var frame = new Gtk.Frame(null);
          frame.set_child(familybox);

          box.append(frame);

        });

        var scrolled = new Gtk.ScrolledWindow ();
        scrolled.vexpand = true;
        scrolled.set_child(box);

        containerbox.append(scrolled);
      }

      this.font_box.set_child (containerbox);
    }

    void init_search () {
      searched_families = families.copy();
    }

    void search (string? search) {
      if (families.length () == 0) { /* Change this line. */
        return;
      }
      searched_families = new List<weak Pango.FontFamily>();
      foreach (var family in families) {
        if (family.get_name().down().contains(search.down())) {
          searched_families.append(family);
        }
      }
      message("searching %s (%u)...", search, searched_families.length());
      show_fonts();
    }

    Gtk.SearchBar searchbar;
    Gtk.SearchEntry searchentry;

    construct {
      var toggle = new Gtk.ToggleButton ();
      toggle.set_icon_name ("system-search-symbolic");
      searchentry = new Gtk.SearchEntry ();
      searchentry.search_changed.connect((entry) => {
        this.search(entry.text);
      });
      searchbar = new Gtk.SearchBar ();
      searchbar.set_child(searchentry);
      searchbar.connect_entry (searchentry);
      searchbar.bind_property ("search_mode_enabled", toggle, "active", GLib.BindingFlags.BIDIRECTIONAL);

      var headerbar = new Gtk.HeaderBar ();
      headerbar.pack_start (toggle);

      headerbar.set_title_widget(new Gtk.Label("Fonty"));

      this.set_titlebar (headerbar);

      var content_box = new Gtk.Box(Gtk.Orientation.VERTICAL, 0);

      content_box.append(searchbar);
      content_box.append(font_box);

      this.set_child(content_box);

      this.load_fonts ();
    }
  }
}
