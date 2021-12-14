

class WeatherData {

  double temperature;
  double humidity;
  String scale;

  WeatherData(this.temperature, this.humidity, this.scale) {
    sanityCheck();
  }

  bool rangeCheck(int lower, int upper){
    return temperature >= lower && temperature <= upper;
  }

  void sanityCheck() {
    if (this.scale == 'C') {
      bool isOK = rangeCheck(-60, 60);
      if (!isOK)
        throw Exception('Temperature should be in range -60 and 60 for C');
    } else if (this.scale == 'F') {
      bool isOK = rangeCheck(-76, 140);
      if (!isOK) {
        throw Exception('Temperature should be in range -76 and 140 for F');
      }
    }
  }
}

void main() {

  WeatherData wd = WeatherData(20, 900, 'C');

}