import 'package:ecomm/db/constants.dart';
import 'package:postgres/postgres.dart';

class PostGres {
  static Future<PostgreSQLConnection> connect() async {
    await connection.open();
    return connection;
  }

  static Future<List<Map<String, dynamic>>> getData() async {
    final data = await connection.query('SELECT * FROM public."Products"');
    print("data: $data");

    final resultList = data.map((column) => column.toColumnMap()).toList();
    return resultList;
  }

  static Future<List<Map<String, dynamic>>> getCategory(String category) async {
    final data = await connection.query(
        'SELECT * FROM public."Products" WHERE category = @category',
        substitutionValues: {'category': category});
    print("catgory: $category");
    final resultList = data.map((column) => column.toColumnMap()).toList();
    return resultList;
  }
}
