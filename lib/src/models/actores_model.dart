
//Crear instancia y que la instancia reciba el mapa completo(lista) de actores
class Cast {
  List<Actor> actores = new List();

  Cast.fromJsonList(List<dynamic> jsonList){
    if (jsonList == null) return;

    jsonList.forEach((item){//Recorrer cada elemento del jsonList
      final actor = Actor.fromJsonMap(item);
      actores.add(actor);//adicionar cada actor a la lista de actores
    });
  }
}



class Actor {
  int castId;
  String character;
  String creditId;
  int gender;
  int id;
  String name;
  int order;
  String profilePath;

  Actor({
    this.castId,
    this.character,
    this.creditId,
    this.gender,
    this.id,
    this.name,
    this.order,
    this.profilePath,
  });

  Actor.fromJsonMap(Map<String, dynamic> json){
    castId    = json['cast_id'];
    character = json['character'];
    creditId  = json['credit_id'];
    gender    = json['gender'];
    id        = json['id'];
    name      = json['name'];
    order     = json['order'];
    profilePath = json['profile_path'];
  }

    getFoto(){
    if (profilePath == null) {
      return 'https://proxy.duckduckgo.com/iu/?u=https%3A%2F%2Fwww.urcamp.tche.br%2Fsite%2Fimg%2Fno-avatar.jpg&f=1&nofb=1';
    }else {
      return 'https://image.tmdb.org/t/p/w500/$profilePath';
    } 
  }
}


