/**
 * SPDX-License-Identifier: MIT
 * SPDX-FileCopyrightText: 2022 Angelo Verlain (https://vixalien.com)
 */

namespace Fonty {
  public class Application : Gtk.Application {
    public Application (string[] args) {
      Object (
        application_id: "com.vixalien.Fonty",
        flags: ApplicationFlags.FLAGS_NONE
      );
    }

    protected override void activate () {
      base.activate();
      var win = this.active_window;
      if (win == null) {
        win = new Fonty.Window (this);
      }
      win.present();
    }
  }
}
