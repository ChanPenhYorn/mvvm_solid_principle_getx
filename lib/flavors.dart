enum Flavor {
  dev,
  staging,
  prod,
}

class F {
  static late final Flavor appFlavor;

  static String get name => appFlavor.name;

  static String get title {
    switch (appFlavor) {
      case Flavor.dev:
        return 'Dev App';
      case Flavor.staging:
        return 'Staging App';
      case Flavor.prod:
        return 'Prod App';
    }
  }

}
