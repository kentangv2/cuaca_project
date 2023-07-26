import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/weather.dart';
import '../resources/weather_api.dart';

class HomePage extends StatelessWidget {
  
  const HomePage();

  @override
  Widget build(BuildContext context) {
    var cerah = "https://ibnux.github.io/BMKG-importer/icon/1.png";
    var cerahberawan = "https://ibnux.github.io/BMKG-importer/icon/3.png" ;
    var berawan = "https://ibnux.github.io/BMKG-importer/icon/4.png";
    var hujan = "https://ibnux.github.io/BMKG-importer/icon/5.png";
    return FutureBuilder<List<Weather>>(
      future: fetchDailyWeather(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          showDialog(
            context: context,
            builder: (BuildContext context) => const AlertDialog(
              title: Text("Error"),
              content: Text('An error has occurred...'),
            ),
          );
        } else if (snapshot.hasData) {
          return Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 50),
                height: 50,
                child: Text(
                  'Perkiraan Cuaca Muara Enim',
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
              ),
              Flexible(
                child: GridView.builder(
                  itemCount: snapshot.data!.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 5.0,
                    mainAxisSpacing: 5.0,
                  ),
                  itemBuilder: (context, index) =>
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              
                              if(snapshot.data![index].cuaca == 'Cerah') ...[
                                Image.network('$cerah', width: 50, height: 50)
                              ] else if(snapshot.data![index].cuaca == 'Berawan') ...[
                                Image.network('$berawan',width: 50, height: 50)
                              ] else if(snapshot.data![index].cuaca == 'Cerah Berawan') ...[
                                Image.network('$cerahberawan', width: 50, height: 50)
                              ]else if(snapshot.data![index].cuaca == 'Hujan Ringan') ...[
                                Image.network('$hujan', width: 50, height: 50)
                              ]else if(snapshot.data![index].cuaca == 'Hujan Deras') ...[
                                Image.network('$hujan',width: 50, height: 50)
                              ]else ... [
                                Image.network('$hujan',width: 50, height: 50)
                              ],
                              
                              Text(snapshot.data![index].jamCuaca),
                              Text(snapshot.data![index].cuaca),
                              Text('${snapshot.data![index].tempC} \u00B0C'),
                            ],
                          ),
                        ),
                      ),
                ),
              ),
            ],
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
