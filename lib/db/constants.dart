import 'package:postgres/postgres.dart';

var connection = PostgreSQLConnection(
  "10.0.2.2",
  3000,
  "mydb",
  username: "postgres",
  password: "shotgun",
);


// 192.168.100.20
// 10.0.2.2