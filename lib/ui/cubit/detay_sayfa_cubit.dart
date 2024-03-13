import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persons_app/data/repo/kisilerdao_repository.dart';

class DetaySayfaCubit extends Cubit<void>{
  DetaySayfaCubit():super(0);

  var kRepo = KisilerDaoRepository();

  Future<void> guncelle(String kisi_id,String kisi_adi,String kisi_no) async{
    await kRepo.guncelle(kisi_id, kisi_adi, kisi_no);
  }

}