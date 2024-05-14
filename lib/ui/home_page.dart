
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_management/utlils/app_constants.dart';
import 'package:weather_management/utlils/color_constants.dart';
import '../controller/home_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(context),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: ColorConstants.appBarColor,
            title: const Text(
              AppConstants.appName,
              style: TextStyle(color: Colors.yellow),
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              color: ColorConstants.appBarColor,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  controller.isConnected
                      ? Container()
                      : Container(
                          height: 40,
                          width: double.infinity,
                          color: Colors.red,
                          child: const Center(
                            child: Text(
                              AppConstants.offlineUser,
                              style: TextStyle(color: ColorConstants.white),
                            ),
                          ),
                        ),
                   SizedBox(
                    height: 50,
                  ),
                  Container(
                    width: 350,
                    color: ColorConstants.white,
                    child: TextFormField(
                      controller: controller.searchController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                          suffixIcon: InkWell(
                              onTap: () async {
                                controller.getWeatherByCity(
                                    city: controller.searchController.text);
                              },
                              child: const Icon(Icons.search))),
                    ),
                  ),
                   SizedBox(
                    height: 70,
                  ),
                  Container(
                    width: 300,
                    color: ColorConstants.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            if (controller.isFahrenheit == true) {
                              controller.isFahrenheit = false;
                              controller.currentTemp = controller
                                  .fahrenheitToCelsius(controller.currentTemp);
                              controller.update();
                            }
                          },
                          child: Container(
                            color: controller.isFahrenheit == false
                                ? Colors.amber
                                : Colors.white,
                            height: 50,
                            width: 150,
                            child: const Center(
                              child: Text(AppConstants.celsius),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            if (controller.isFahrenheit != true) {
                              controller.isFahrenheit = true;
                              controller.currentTemp = controller
                                  .celsiusToFahrenheit(controller.currentTemp);
                              controller.update();
                            }
                          },
                          child: Container(
                            color: controller.isFahrenheit == true
                                ? Colors.amber
                                : Colors.white,
                            height: 50,
                            width: 150,
                            child: const Center(
                              child: Text(AppConstants.fahrenheit),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                   SizedBox(
                    height: 50,
                  ),
                  const Text(AppConstants.currentWeatherTitle,
                      style:
                          TextStyle(color: ColorConstants.white, fontSize: 20)),
                   SizedBox(
                    height: 30,
                  ),
                  Text(
                      controller.isFahrenheit
                          ? " ${controller.currentTemp.toString()} F"
                          : " ${controller.currentTemp.toString()} C",
                      style: const TextStyle(
                          color: ColorConstants.white, fontSize: 28)),
                   SizedBox(
                    height: 30,
                  ),
                  controller.otherCityTemp != 0
                      ? Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(controller.searchController.text.toUpperCase(),
                                  style: const TextStyle(
                                      color: ColorConstants.white,
                                      fontSize: 20)),
                              Text("${controller.otherCityTemp} C",
                                  style: const TextStyle(
                                      color: ColorConstants.white,
                                      fontSize: 20)),
                              Text("${controller.celsiusToFahrenheit(double.parse(controller.otherCityTemp.toString()))} F",
                                  style: const TextStyle(
                                      color: ColorConstants.white,
                                      fontSize: 20)),
                            ],
                          ),
                        )
                      : Container()
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
