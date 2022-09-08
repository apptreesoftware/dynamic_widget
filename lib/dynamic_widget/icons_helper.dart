library icons_helper;

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter_named/font_awesome_flutter_named.dart';
import 'package:material_icons_named/material_icons_named.dart';

// Returns an icon by examining the name for the format ICON_LIBRARY.ICON_NAME and if not, looks for a Material icon of the ICON_NAME
// For example fa.fiveHundredPx returns the icon named fiveHundredPx in the FontAwesome lib, if it didn't exist, it'd try to return the material icon named fiveHundredPx, otherwise you get null.
// If you don't use the dot notation described it will attempt to get you an icon favoring the Material icon set using getIconGuessFavorMaterial
IconData? getIconUsingPrefix({required String? name}) {
  if (name == null || name.isEmpty) {
    return null;
  }

  final List<String> split = name.split('.');

  IconData? icon;
  if (split.length > 1) {
    name = split[1];
    if (split[0].toLowerCase() == 'fa' ||
        split[0].toLowerCase() == 'fontawesome') {
      icon = getFontAwesomeIcon(name: name);
    }
  } else {
    icon = getIconGuessFavorMaterial(name: name);
  }
  if (icon == null) {
    print("No icon for name: $name");
  }
  return icon;
}

// Returns an icon named in name favoring Font Awesome
IconData? getIconGuessFavorFA({String? name}) {
  if (name == null) {
    return null;
  }
  if (faIconNameMapping[name] != null) {
    return faIconNameMapping[name];
  } else {
    return materialIcons[name];
  }
}

// Returns an icon named in name favoring Material
IconData? getIconGuessFavorMaterial({String? name}) {
  if (name == null) {
    return null;
  }
  if (materialIcons[name] != null) {
    return materialIcons[name];
  } else {
    return faIconNameMapping[name];
  }
}

String exportIconGuessFavorMaterial(IconData? iconData) {
  for (var entry in materialIcons.entries) {
    if (entry.value == iconData) {
      return entry.key;
    }
  }

  for (var entry in faIconNameMapping.entries) {
    if (entry.value == iconData) {
      return entry.key;
    }
  }
  return "android";
}

// Kinda self explanatory, no?
IconData? getMaterialIcon({String? name}) {
  return materialIcons[name!];
}

// Kinda self explanatory, no?
IconData? getFontAwesomeIcon({String? name}) {
  return faIconNameMapping[name];
}

List<String> get allIcons {
  var material = materialIcons;
  var fontAwesome = faIconNameMapping.values;

  var allIcons = <String>[];
  allIcons.addAll(material.keys);
  fontAwesome.forEach((element) {
    allIcons.add('fa.$element');
  });
  return allIcons;
}
