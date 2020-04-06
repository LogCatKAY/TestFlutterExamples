enum City {
  MOSCOW
}

class CitiesUtils {
  static int getCityId(City city) {
    switch(city) {
      case City.MOSCOW:
        return 2122265;
      default:
        return -1;
    }
  }
}