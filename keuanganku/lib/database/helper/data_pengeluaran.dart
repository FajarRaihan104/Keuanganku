import 'package:keuanganku/database/model/data_pengeluaran.dart';
import 'package:sqflite/sqflite.dart';

class SQLDataPengeluaran {
  Future createTable(Database db) async {
    await db.execute(SQLDataPengeluaran().sqlCreateQuery);
  }

  final Map<String, Map<String, String>> _table = {
    "id": {
      "name": "id",
      "type": "INTEGER",
      "constraint": "AUTO INCREMENT PRIMARY KEY",
    },
    "id_kategori": {
      "name": "id_kategori",
      "type": "INTEGER",
      "constraint": "NOT NULL",
    },
    "id_wallet": {
      "name": "id_wallet",
      "type": "INTEGER",
      "constraint": "NOT NULL",
    },
    "waktu": {
      "name": "waktu",
      "type": "TEXT",
      "constraint": "NOT NULL",
    },
    "judul": {
      "name": "judul",
      "type": "TEXT",
      "constraint": "",
    },
    "deskripsi": {
      "name": "deskripsi",
      "type": "TEXT",
      "constraint": "",
    },
    "nilai": {
      "name": "nilai",
      "type": "REAL",
      "constraint": "",
    },
  };

  final _tableName = "data_pengeluaran";
  
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

  Future<List<ModelDataPengeluaran>> readAll(Database db) async {
    final List<Map<String, dynamic>> results = await db.query(_tableName);
    List<ModelDataPengeluaran> data = [];
    for (final result in results) {
      data.add(ModelDataPengeluaran.fromMap(result));
    }
    return data;
  }

  Future<int> create(ModelDataPengeluaran data, {required Database db}) async {
    return 
    await db.rawInsert(
      "INSERT INTO $_tableName(id_kategori, id_wallet, waktu, judul, deskripsi, nilai) VALUES(?,?,?,?,?,?)", 
      [data.id_kategori, data.id_wallet, data.waktu.toIso8601String(), data.judul, data.deskripsi, data.nilai]
    );
  }
}