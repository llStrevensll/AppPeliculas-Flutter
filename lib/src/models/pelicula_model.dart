class Peliculas {
  List<Pelicula> items = new List();

  Peliculas();
  Peliculas.fromJsonList(List<dynamic> jsonList){
    if (jsonList == null) return;

    for (var item in jsonList) {
      
      final pelicula = new Pelicula.fromJsonMap(item);//instancia de pelicula
      items.add(pelicula);
    }
  }
}


class Pelicula {

  String uniqueId;

  int voteCount;
  int id;
  bool video;
  double voteAverage;
  String title;
  double popularity;
  String posterPath;
  String originalLanguage;
  String originalTitle;
  List<int> genreIds;
  String backdropPath;
  bool adult;
  String overview;
  String releaseDate;

  Pelicula({
    this.voteCount,
    this.id,
    this.video,
    this.voteAverage,
    this.title,
    this.popularity,
    this.posterPath,
    this.originalLanguage,
    this.originalTitle,
    this.genreIds,
    this.backdropPath,
    this.adult,
    this.overview,
    this.releaseDate,
  });

  Pelicula.fromJsonMap( Map<String, dynamic> json ) {

    voteCount        = json['vote_count'];
    id               = json['id'];
    video            = json['video'];
    voteAverage      = json['vote_average'] / 1;
    title            = json['title'];
    popularity       = json['popularity'] / 1;
    posterPath       = json['poster_path'];
    originalLanguage = json['original_language'];
    originalTitle    = json['original_title'];
    genreIds         = json['genre_ids'].cast<int>();
    backdropPath     = json['backdrop_path'];
    adult            = json['adult'];
    overview         = json['overview'];
    releaseDate      = json['release_date'];

  }

  //obtener solo la imagen(poster) de la respectiva pelicula
  getPosterImg(){
    if (posterPath == null) {
      return 'https://proxy.duckduckgo.com/iu/?u=http%3A%2F%2Feni-learning.com%2Fphp-custom%2Fimg%2Fno-image.jpg&f=1&nofb=1';
    }else {
      return 'https://image.tmdb.org/t/p/w500/$posterPath';
    } 
  }

  getBackgroundImg(){
    if (posterPath == null) {
      return 'https://proxy.duckduckgo.com/iu/?u=http%3A%2F%2Feni-learning.com%2Fphp-custom%2Fimg%2Fno-image.jpg&f=1&nofb=1';
    }else {
      return 'https://image.tmdb.org/t/p/w500/$backdropPath';
    } 
  }

}