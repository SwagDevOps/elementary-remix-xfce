# Elementary Remix (Xfce)

This theme is mostly based on
[varlesh/elementary-add][varlesh/elementary-add].<br>
This theme is intended to be used with a dark panel,
it DEPENDS on [``elementary-xfce``][shimmerproject/elementary-xfce].

## Install

Install is as simple as possible, simply type:

```sh
sudo rake install
```

Theme will be installed in ``/usr/local/share/icons``, but you can choose
another location:

```sh
sudo rake install[/home/somebody/.local/share/icons]
```

To uninstall:

```
sudo rake uninstall
```

## Icons (sources, credits)

| name                     | source                           | license |
| ------------------------ | -------------------------------- | ------- |
| apps/vlc                 | [elementaryplus][elementaryplus] | GNU GPL |
| apps/messengerfordesktop | [elementaryplus][elementaryplus] | GNU GPL |
| apps/virtualbox          | [elementaryplus][elementaryplus] | GNU GPL |
| apps/viewnior            | [elementaryplus][elementaryplus] | GNU GPL |
| apps/libreoffice         | [elementaryplus][elementaryplus] | GNU GPL |
| apps/firefox             | [loklaan][loklaan]               | unknown |
| apps/gitkraken           | [boosterdev][gitkraken.svg]      | unknown |
| apps/shotwell            | [spg76][spg76]                   | unknown |
| apps/emacs               | [xendke/elementaryos-emacs-icon][xendke/elementaryos-emacs-icon] | GNU GPL |
| panel                    | [shimmerproject/elementary-xfce][shimmerproject/elementary-xfce] | unknown |
| notifications            | [shimmerproject/elementary-xfce][shimmerproject/elementary-xfce] | unknown |

[elementaryplus]: https://github.com/mank319/elementaryPlus
[varlesh/elementary-add]: https://github.com/varlesh/elementary-add
[shimmerproject/elementary-xfce]: https://github.com/shimmerproject/elementary-xfce
[xendke/elementaryos-emacs-icon]: https://github.com/xendke/elementaryos-emacs-icon
[loklaan]: https://loklaan.deviantart.com/
[spg76]: https://spg76.deviantart.com/
[gitkraken.svg]: https://gist.github.com/boosterdev/fa6133c36b3570df96719233e007f65a
