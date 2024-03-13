import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:persons_app/data/entity/kisiler.dart';

class KisilerDaoRepository{

  var collectionKisiler = FirebaseFirestore.instance.collection("Kisiler");

  Future<void> kaydet(String kisi_adi,String kisi_no) async{
    var yeniKisi = HashMap<String,dynamic>();
    yeniKisi["kisi_id"] = "";
    yeniKisi["kisi_adi"] = kisi_adi;
    yeniKisi["kisi_no"] = kisi_no;
    collectionKisiler.add(yeniKisi);
  }

  Future<void> guncelle(String kisi_id,String kisi_adi,String kisi_no) async{
    var guncellenenKisi = HashMap<String,dynamic>();
    guncellenenKisi["kisi_adi"] = kisi_adi;
    guncellenenKisi["kisi_no"] = kisi_no;
    collectionKisiler.doc(kisi_id).update(guncellenenKisi);
  }

  Future<void> sil(String kisi_id) async{
    collectionKisiler.doc(kisi_id).delete();
  }
}