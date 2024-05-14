import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:weather_management/controller/base_controller.dart';
import 'package:weather_management/utlils/common.dart';
import 'package:weather_management/utlils/utility.dart';
import '../model/login_model.dart';
import '../model/temp_model.dart';
import '../network/api_end_points.dart';
import '../network/webservice.dart';
import '../utlils/connectivity.dart';

class HomeController extends BaseController {
  BuildContext context;

  HomeController(this.context);

  TextEditingController searchController = TextEditingController();
  MyConnectivity _connectivity = MyConnectivity.instance;

  bool isFahrenheit = false;
  double currentTemp = 0;
  double otherCityTemp = 0;
  TempModel? tempModel;
  bool isConnected = false;
  String currentLatitude = "";
  String currentLongitude = "";
  Map _source = {ConnectivityResult.none: false};

  @override
  Future<void> onInit() async {
    _connectivity.initialise();
    _connectivity.myStream.listen((source) {
      _source = source;
      print("source : ${_source.keys.toList()[0]}");
      if (_source.keys.toList()[0] == ConnectivityResult.none) {
        isConnected = false;
        update();
      } else {
        isConnected = true;
        update();
      }
    });
    await getUserCurrentLocation();
    if (isConnected == false) {
      currentTemp = await Utility.getWeather();
      update();
    }
    super.onInit();
  }

  // created method for getting user current location
  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    printf(position.longitude.toString()); //Output: 80.24599079
    printf(position.latitude.toString());
    currentLatitude = position.latitude.toString();
    currentLongitude = position.longitude.toString();
    printf("current latitude :  ${currentLatitude.toString()}");
    printf("current Longitude :  ${currentLongitude.toString()}");
    if (isConnected == true) {
      getWeatherByLat(
          lat: currentLatitude.toString(), lng: currentLongitude.toString());
    }
    update();
    return await Geolocator.getCurrentPosition();
  }

  void getWeatherByCity({
    required String city,
  }) {
    Utility.isConnected().then((value) async {
      update();
      try {
        Map<String, dynamic> map = <String, dynamic>{};
        otherCityTemp = 0;
        printf('map-$map');
        printf('jsonMap-${json.encode(map)}');
        Webservice()
            .loadGetDataWithOutHeader(getWeatherApi, "${city}")
            .then((value) => {});
      } catch (e) {
        printf("$e Error");
      }
    });
  }

  Resource<LoginModel> get getWeatherApi {
    return Resource(
        url: APIEndPoints.baseUrl + APIEndPoints.city,
        parse: (response) {
          if (response.statusCode == 200) {
            dynamic data = response.body;
            TempModel responseModel = TempModel.fromJson(json.decode(data));
            tempModel = responseModel;
            otherCityTemp = double.parse(tempModel!.temp.toString());
            update();
          } else if (response.statusCode != 200) {}
          update();
          return LoginModel();
        });
  }

  void getWeatherByLat({
    required String lat,
    required String lng,
  }) {
    Utility.isConnected().then((value) async {
      update();
      try {
        Webservice()
            .loadGetDataWithOutHeader(
                getWeatherByLatLngApi, "lat=${lat}&lon=${lng}")
            .then((value) => {});
      } catch (e) {
        printf("$e Error");
      }
    });
  }

  Resource<LoginModel> get getWeatherByLatLngApi {
    return Resource(
        url: APIEndPoints.baseUrl,
        parse: (response) {
          if (response.statusCode == 200) {
            dynamic data = response.body;
            TempModel responseModel = TempModel.fromJson(json.decode(data));
            tempModel = responseModel;
            currentTemp = double.parse(tempModel!.temp.toString());
            Utility.setWeather(currentTemp);
            update();
          } else if (response.statusCode != 200) {
            Fluttertoast.showToast(msg: "Something went wrong");
          }
          update();
          return LoginModel();
        });
  }

  double celsiusToFahrenheit(double celsius) {
    return (celsius * 9 / 5) + 32;
  }

  double fahrenheitToCelsius(double fahrenheit) {
    return (fahrenheit - 32) * 5 / 9;
  }
}
