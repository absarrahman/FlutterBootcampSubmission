class User {
  String _name,
      _email;
  int _score = 0;

  User(this._name, this._email);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> m = Map<String, dynamic>();
    m["name"] = this._name;
    m["email"] = this._email;
    m["score"] = this._score;
    return m;
  }
}