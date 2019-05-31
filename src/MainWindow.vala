/*
* Copyright 2019 elementary, Inc. (https://elementary.io)
*
* This program is free software; you can redistribute it and/or
* modify it under the terms of the GNU General Public
* License as published by the Free Software Foundation; either
* version 3 of the License, or (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
* General Public License for more details.
*
* You should have received a copy of the GNU General Public
* License along with this program; if not, write to the
* Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
* Boston, MA 02110-1301 USA
*
*/

public class Sideload.MainWindow : Gtk.ApplicationWindow {
    public MainWindow (Gtk.Application application) {
        Object (
            application: application,
            icon_name: "io.elementary.sideload",
            resizable: false,
            title: _("Install Untrusted Software")
        );
    }

    construct {
        var titlebar = new Gtk.HeaderBar ();
        titlebar.get_style_context ().add_class (Gtk.STYLE_CLASS_FLAT);
        titlebar.set_custom_title (new Gtk.Grid ());

        var image = new Gtk.Image.from_icon_name ("io.elementary.sideload", Gtk.IconSize.DIALOG);
        image.valign = Gtk.Align.START;

        var primary_label = new Gtk.Label (_("Install Untrusted Software?"));
        primary_label.max_width_chars = 50;
        primary_label.selectable = true;
        primary_label.wrap = true;
        primary_label.xalign = 0;
        primary_label.get_style_context ().add_class (Granite.STYLE_CLASS_PRIMARY_LABEL);

        var secondary_label = new Gtk.Label (_("This software is provided solely by its developer and has not been reviewed for security, privacy, or system integration."));
        secondary_label.max_width_chars = 55;
        secondary_label.selectable = true;
        secondary_label.wrap = true;
        secondary_label.xalign = 0;

        var agree_check = new Gtk.CheckButton.with_label (_("I understand"));
        agree_check.margin_bottom = 6;
        agree_check.margin_top = 12;

        var cancel_button = new Gtk.Button.with_label (_("Cancel"));
        cancel_button.action_name = "app.quit";

        var install_button = new Gtk.Button.with_label (_("Install"));
        install_button.sensitive = false;
        install_button.get_style_context ().add_class (Gtk.STYLE_CLASS_DESTRUCTIVE_ACTION);

        var button_box = new Gtk.ButtonBox (Gtk.Orientation.HORIZONTAL);
        button_box.layout_style = Gtk.ButtonBoxStyle.END;
        button_box.margin_top = 12;
        button_box.spacing = 6;
        button_box.add (cancel_button);
        button_box.add (install_button);

        var grid = new Gtk.Grid ();
        grid.column_spacing = 12;
        grid.margin = 12;
        grid.attach (image, 0, 0, 1, 2);
        grid.attach (primary_label, 1, 0);
        grid.attach (secondary_label, 1, 1);
        grid.attach (agree_check, 1, 2);
        grid.attach (button_box, 0, 3, 2);
        grid.show_all ();

        add (grid);
        get_style_context ().add_class ("rounded");
        set_titlebar (titlebar);


        agree_check.bind_property ("active", install_button, "sensitive");

        install_button.clicked.connect (() => destroy ());
    }
}

