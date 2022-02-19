class PrizesData {
  List<Prizes> prizes;

  PrizesData({this.prizes});

  PrizesData.fromJson(Map<String, dynamic> json) {
    if (json['prizes'] != null) {
      prizes = <Prizes>[];
      json['prizes'].forEach((v) {
        prizes.add(new Prizes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.prizes != null) {
      data['prizes'] = this.prizes.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Prizes {
  String year;
  String category;
  List<Laureates> laureates;
  String overallMotivation;

  Prizes({this.year, this.category, this.laureates, this.overallMotivation});

  Prizes.fromJson(Map<String, dynamic> json) {
    year = json['year'];
    category = json['category'];
    if (json['laureates'] != null) {
      laureates = <Laureates>[];
      json['laureates'].forEach((v) {
        laureates.add(new Laureates.fromJson(v));
      });
    }
    overallMotivation = json['overallMotivation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['year'] = this.year;
    data['category'] = this.category;
    if (this.laureates != null) {
      data['laureates'] = this.laureates.map((v) => v.toJson()).toList();
    }
    data['overallMotivation'] = this.overallMotivation;
    return data;
  }
}

class Laureates {
  String id;
  String firstname;
  String surname;
  String motivation;
  String share;

  Laureates(
      {this.id, this.firstname, this.surname, this.motivation, this.share});

  Laureates.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstname = json['firstname'];
    surname = json['surname'];
    motivation = json['motivation'];
    share = json['share'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstname'] = this.firstname;
    data['surname'] = this.surname;
    data['motivation'] = this.motivation;
    data['share'] = this.share;
    return data;
  }
}