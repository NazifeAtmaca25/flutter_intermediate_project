import 'package:flutter/material.dart';
import 'package:movie_search_app/screen/movie_detail_screen.dart';
import 'package:movie_search_app/services/tmdb_api.dart';

import '../model/movie.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<Movie> _filmler=[];
  bool _loading=true;
  final TmdbApi _service=TmdbApi();

  TextEditingController  _searchController= TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _firstData();
  }
  void _firstData() async{
    var films= await _service.getPopularMovies();
    setState(() {
      _filmler=films;
      _loading=false;
    });
  }
  void _searchData(String searchWord) async{
    if(searchWord.isEmpty) return;
    setState(() {
      _loading=true;
    });
    var result= await _service.searchMovie(searchWord);
    setState(() {
      _filmler=result;
      _loading=false;
    });
  }
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movie Application"),
      ),
      body: Column(
        children: [
          Padding(padding: EdgeInsetsGeometry.all(16),
          child: TextField(
            controller: _searchController,
            onSubmitted: (movie){
              _searchData(movie);
            },
            decoration: InputDecoration(
              hintText: "Write the movie name...",
              prefixIcon: Icon(Icons.search),
              suffixIcon: IconButton(
                  onPressed: (){
                    _searchController.clear();
                    _firstData();
                  }, icon: Icon(Icons.clear)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20)
              ),
              filled: true,
              fillColor: Colors.white10
            ),
          ),),
          Expanded(child: _loading
              ? Center(child: CircularProgressIndicator(),)
              : _filmler.isEmpty
                  ? Center(child: Text("Movie not found",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),)
                  :GridView.builder(
            padding: EdgeInsetsGeometry.all(10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.65),
              itemCount: _filmler.length,
              itemBuilder: (context, index){
              var film=_filmler[index];
              return GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>MovieDetailScreen(film: film,)));
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF151C38),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      )
                    ]
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: ClipRRect(
                        borderRadius: BorderRadius.vertical(top:  Radius.circular(15)),
                        child:
                        film.poster_path != null ? Image.network(
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
                        fit: BoxFit.cover,)
                      )),
                      Padding(
                          padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(film.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16
                            ),),
                            SizedBox(height: 5,),
                            Row(
                              children: [
                                Icon(Icons.star, color: Colors.amber,size: 16,),
                                SizedBox(width: 5,),
                                Text(film.average.toStringAsFixed(1),
                                style: TextStyle(color: Colors.grey , fontSize: 14),),
                                Spacer(),
                                Text(film.release_date.split("-")[0],
                                style: TextStyle(color: Colors.grey,fontSize: 14),)
                              ],
                            )
                          ],
                        ),

                      )
                    ],
                  ),
                ),
              );
              }))
        ],
      ),
    );
  }
}
