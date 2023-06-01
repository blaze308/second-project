import 'package:postgres/postgres.dart';

var connection = PostgreSQLConnection(
  "10.0.2.2",
  3000,
  "mydb",
  username: "postgres",
  password: "shotgun",
);



// 10.0.2.2