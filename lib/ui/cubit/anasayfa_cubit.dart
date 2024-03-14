import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persons_app/data/entity/kisiler.dart';
import 'package:persons_app/data/repo/kisilerdao_repository.dart';

class AnasayfaCubit extends Cubit<List<Kisiler>>{
  AnasayfaCubit():super(<Kisiler>[]);

  var kRepo = KisilerDaoRepository();

  var collectionKisiler = FirebaseFirestore.instance.collection("Kisiler");

    Future<void> kisileriListele() async{
      collectionKisiler.snapshots().listen((event) {
        var kisilerListesi = <Kisiler>[];

        var documents = event.docs;

        for(var document in documents){
          var key = document.id;
          var data = document.data();
          var kisi = Kisiler.fromJson(data, key);
          kisilerListesi.add(kisi);
        }
        kisilerListesi.sort((a,b) => a.kisi_adi.compareTo(b.kisi_adi));

        emit(kisilerListesi);
      });
    }

  Future<void> ara(String aramaKelime) async{
    collectionKisiler.snapshots().listen((event) {
      var kisilerListesi = <Kisiler>[];

      var documents = event.docs;

      for(var document in documents){
        var key = document.id;
        var data = document.data();
        var kisi = Kisiler.fromJson(data, key);

        if(kisi.kisi_adi.toLowerCase().contains(aramaKelime.toLowerCase())){
          kisilerListesi.add(kisi);
        }
      }

      emit(kisilerListesi);
    });
  }

  Future<void> sil(String kisi_id) async{
    await kRepo.sil(kisi_id);
  }

}