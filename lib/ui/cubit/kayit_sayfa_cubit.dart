import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persons_app/data/repo/kisilerdao_repository.dart';

class KayitSayfaCubit extends Cubit<void>{
  KayitSayfaCubit():super(0);

  var kRepo = KisilerDaoRepository();

  Future<void> kaydet(String kisi_adi,String kisi_no) async{
    await kRepo.kaydet(kisi_adi, kisi_no);
  }

}