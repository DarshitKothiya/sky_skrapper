class Random {
  String gender;
  String title;
  String fName;
  String lName;
  String city;
  String state;
  String country;
  String email;
  String call;
  String image;
  int sNumber;
  String sName;
  int age;

  Random({
    required this.gender,
    required this.title,
    required this.fName,
    required this.lName,
    required this.city,
    required this.state,
    required this.country,
    required this.email,
    required this.call,
    required this.image,
    required this.sNumber,
    required this.sName,
    required this.age,
  });
  
  factory Random.fromMap({required Map data}){
    return Random(
        gender: data["results"][0]['gender'],
        title: data["results"][0]['name']['title'],
        fName: data["results"][0]['name']['first'],
        lName: data["results"][0]['name']['last'],
        city: data["results"][0]['location']['city'],
        state: data["results"][0]['location']['state'],
        country: data["results"][0]['location']['country'],
        email: data["results"][0]['email'],
        call: data["results"][0]['phone'],
        image: data["results"][0]['picture']['large'],
        sName: data["results"][0]['location']['street']['name'],
        sNumber: data["results"][0]['location']['street']['number'],
        age: data["results"][0]['dob']['age'],
    );
  }
}
