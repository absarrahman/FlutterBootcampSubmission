class User {
  String _name,
      _email;
  int _coursesCompleted = 0;
  int _coursesEnrolled = 0;

  User(this._name, this._email, this._coursesCompleted, this._coursesEnrolled);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> m = Map<String, dynamic>();
    m["name"] = this._name;
    m["email"] = this._email;
    m["courses_completed"] = this._coursesCompleted;
    m["courses_enrolled"] = this._coursesEnrolled;
    return m;
  }
}