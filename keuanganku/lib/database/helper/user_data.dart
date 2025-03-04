import 'package:keuanganku/database/model/user_data.dart';
import 'package:sqflite/sqflite.dart';

class SQLHelperUserData {
  static final Map<String, Map<String, String>> _table = {
    "ID User": {
      "name": "id",
      "type": "INTEGER",
      "constraint": "PRIMARY KEY AUTOINCREMENT",
    },
    "Nama User": {
      "name": "username",
      "type": "TEXT",
      "constraint": "",
    },
  };
  static const String _tableName = "userdata";

  String get sqlCreateQuery {
    String columns = "";
    _table.forEach((key, value) {
      columns += "${value['name']} ${value['type']} ${value['constraint']}, ";
    });

    // Hapus spasi dan koma pada baris terakhir
    columns = columns.substring(0, columns.length - 2);

    return """
      CREATE TABLE IF NOT EXISTS $_tableName (
        $columns
      )
    """;
  }
  static Future createTable(Database db) async {
    await db.execute(SQLHelperUserData().sqlCreateQuery);
    await db.rawInsert("INSERT INTO $_tableName(username) VALUES(?)", [null]);
  }

  Future<SQLModelUserdata?> read(Database db, int userId) async {
    List<Map<String, dynamic>> result = await db.query(
      _tableName,
      where: "id = ?",
      whereArgs: [userId],
    );

    if (result.isNotEmpty) {
      return SQLModelUserdata.fromJson(result.first);
    } else {
      return null;
    }
  }

  Future<List<SQLModelUserdata>> readAll(Database db) async {
    List<Map<String, dynamic>> result = await db.query(_tableName);

    return result.map((data) => SQLModelUserdata.fromJson(data)).toList();
  }

  Future<int> update(Database db, SQLModelUserdata userData) async {
    return await db.update(
      _tableName,
      userData.toJson(),
      where: "id = ?",
      whereArgs: [userData.id],
    );
  }

  Future<int> delete(Database db, int userId) async {
    return await db.delete(
      _tableName,
      where: "id = ?",
      whereArgs: [userId],
    );
  }
}