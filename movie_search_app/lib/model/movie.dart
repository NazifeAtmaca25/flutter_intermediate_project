class Movie{
 final int id;
 final String title;
 final String overview;
 final int? runtime;
 final String release_date;
 final double average;
 final List<int> genre_ids;
 final String? poster_path;
 final String? backdrop_path;

 Movie({required this.id,required this.title,required this.overview, this.runtime,required this.release_date,
    required this.average,required this.genre_ids, this.poster_path, this.backdrop_path});

 factory Movie.fromJson(Map<String, dynamic> json){
  return Movie(id: json['id'] ?? 0,
      title: json['title'] ?? "İsimsiz Film" ,
      overview: json['overview'] ?? "Özet bulunamadı.",
      release_date: json['release_date'] ?? "",
      average: (json['vote_average'] as num?)?.toDouble() ?? 0.0,
      genre_ids: (json['genre_ids'] as List<dynamic>?)?.map((e)=> e as int).toList() ?? [],
      poster_path: json['poster_path'],
      backdrop_path: json['backdrop_path']
  );
 }


}