import 'package:flutter/material.dart';
import '../model/movie.dart';

class MovieDetailScreen extends StatelessWidget {
  final Movie film;

  const MovieDetailScreen({super.key, required this.film});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          title: Text("Movie Application")
      ),
      body: Stack(
        children: [
          Positioned.fill(child: film.backdrop_path!=null 
              ?Image.network("https://image.tmdb.org/t/p/w780${film.backdrop_path}",fit: BoxFit.cover,)
              :Container(color: Color(0xFF0B0F29),)
          ),

          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 100,),
                  Center(
                    child: Container(
                      width: 200,
                      height: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            spreadRadius: 5,
                            blurRadius: 15,
                            offset: Offset(0, 5)
                          )
                        ]
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: film.poster_path != null ? Image.network(
                          "https://image.tmdb.org/t/p/w500${film.poster_path}",
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace){
                            return Image.asset("assets/images/no_image.jpg",
                              width: double.infinity,
                              fit: BoxFit.cover,);
                          },
                        ):Image.asset("assets/images/no_image.jpg",
                          width: double.infinity,
                          fit: BoxFit.cover,),
                      ),
                    ),
                  ),

                  SizedBox(height: 25,),
                  Text(film.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [Shadow(color: Colors.black,blurRadius: 10)]
                  ),),
                  SizedBox(height: 10,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      buildContainer("IMDB: ${film.average.toStringAsFixed(1)}"),
                      SizedBox(width: 10,),
                      buildContainer(film.release_date.split("-")[0])
                    ],
                  ),

                  SizedBox(height: 25,),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Plot Summary",
                    style: TextStyle(fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),),
                  ),
                  SizedBox(height: 10,),

                  Text(film.overview,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                    height: 1.5
                  ),),

                  SizedBox(height: 100,),

                ],
              ),
            ),
          )

        ],
      ),
    );
  }

  Widget buildContainer(String value) {
    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white24,
                        border: Border.all(color: Colors.white30)
                      ),
                      padding:EdgeInsets.symmetric(horizontal: 12,vertical: 6),
                      child: Text(value,
                      style: TextStyle(color: Colors.white, fontSize: 12,fontWeight: FontWeight.bold),),

                    );
  }
}
