class TempModel{



  int? cloudPct;
  int? temp;
  int? feelsLike;
  int? humidity;
  int? minTemp;
  int? maxTemp;
  double? windSpeed;
  int? windDegrees;
  int? sunrise;
  int? sunset;

  TempModel(
      {required this.cloudPct,
        required   this.temp,
        required  this.feelsLike,
        required  this.humidity,
        required  this.minTemp,
        required   this.maxTemp,
        required   this.windSpeed,
        required   this.windDegrees,
        required   this.sunrise,
        required  this.sunset});

  TempModel.fromJson(Map<String, dynamic> json) {
    cloudPct = json['cloud_pct'];
    temp = json['temp'];
    feelsLike = json['feels_like'];
    humidity = json['humidity'];
    minTemp = json['min_temp'];
    maxTemp = json['max_temp'];
    windSpeed = json['wind_speed'];
    windDegrees = json['wind_degrees'];
    sunrise = json['sunrise'];
    sunset = json['sunset'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cloud_pct'] = this.cloudPct;
    data['temp'] = this.temp;
    data['feels_like'] = this.feelsLike;
    data['humidity'] = this.humidity;
    data['min_temp'] = this.minTemp;
    data['max_temp'] = this.maxTemp;
    data['wind_speed'] = this.windSpeed;
    data['wind_degrees'] = this.windDegrees;
    data['sunrise'] = this.sunrise;
    data['sunset'] = this.sunset;
    return data;
  }

}