class Weather{
 final String city;
 final String description;
 final double temp;
 final double feelsLike;
 final double tempMin;
 final double tempMax;
 final int humidity;
 final String icon;

 Weather({required this.city,required this.description, required this.temp, required this.feelsLike, required this.tempMin,required this.tempMax, required this.humidity, required this.icon});
 
 factory Weather.fromJson(Map<String,dynamic> json){
   return Weather(
       city: json["name"],
       description: json["weather"][0]["description"],
       temp: json["main"]["temp"].toDouble(),
       feelsLike: json["main"]["feels_like"].toDouble(),
       tempMin: json["main"]["temp_min"].toDouble(),
       tempMax: json["main"]["temp_max"].toDouble(),
       humidity: json["main"]["humidity"],
       icon: json["weather"][0]["icon"],
   );
 }
}