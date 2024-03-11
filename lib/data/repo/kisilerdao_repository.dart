import 'package:persons_app/data/entity/kisiler.dart';

class KisilerDaoRepository{
  Future<void> kaydet(String kisi_adi,String kisi_no) async{
    print("Kisi kaydet  ${kisi_adi} ${kisi_no}");
  }

  Future<void> guncelle(int kisi_id,String kisi_adi,String kisi_no) async{
    print("Kisi güncelle ${kisi_id} ${kisi_adi} ${kisi_no}");
  }

  Future<List<Kisiler>> kisileriListele() async{
    List<Kisiler> kisi = [];

    var k1 = Kisiler(kisi_id: 1,kisi_adi: "Ahmet",kisi_no: "123554");
    var k2 = Kisiler(kisi_id: 2,kisi_adi: "Mustafa",kisi_no: "998763");

    kisi.add(k1);
    kisi.add(k2);

    return kisi;
  }
}