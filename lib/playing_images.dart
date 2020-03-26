import 'package:aqib_freelancer/services/bloc_pattern.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:image/image.dart' as ImageProcess;
class PlayingImagesClass extends StatefulWidget {
  final CameraModel model;
  PlayingImagesClass(this.model);

  @override
  _PlayingImagesClassState createState() => _PlayingImagesClassState();
}

class _PlayingImagesClassState extends State<PlayingImagesClass> {
  var _firebaseRef = FirebaseDatabase().reference();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    print(widget.model.id);
//    _firebaseRef.child(widget.model.id).child("Photos").child("250320").onValue.listen((res){
//      print("resres here");
//      print(res.snapshot.value[1]);
//    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Text(widget.model.name,style: TextStyle(color: Colors.black),),
        iconTheme: IconThemeData(
          color: Colors.black
        ),
      ),
      body:

      Swiper(
          controller: SwiperController(),
          itemCount: widget.model.photos["250320"].length,
          itemBuilder: (context, index){
            var baseres = "";
            Uint8List bytes;
            widget.model.photos["250320"][index+1].forEach((res){
              print(res);
              baseres = "";
              baseres = baseres + res.toString();
              print(baseres);
            });

//            bytes = ;
            return Container(
              child: Image.memory(base64Decode("data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAASAAAADACAIAAAAr0inhAAAABGdBTUEAALGPC%2FxhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAABmJLR0QA%2FwD%2FAP%2BgvaeTAAAwL0lEQVR42u2dd5xU1fn%2FT719ys7OzDYQBAQxigZ7BxSNGjUaE6PJ1yTGmGjsDXtsgIK9kdh%2Blthib9iwRayIvfcSMShl68wtp%2Fz%2BuLN3BtiFnd2Z3WU979e8eO197p3ZM5f72XPOc57zPPDLaecAhUJRHdBAN0ChGMoogSkUVUQJTKGoIkpgCkUVUQJTKKqIEphCUUWUwBSKKqIEplBUESUwhaKKKIEpFFVECUyhqCJKYApFFVECUyiqiBKYQlFFlMAUiiqiBKZQVBEy0A1QdI2UhR8gHOimKPqAEthgIVSUBDL8QQBZMEGIAAQAQAhg5w%2BKtQUlsAFGSiCBFFJyIQIhuOACIy1TixNxqGkiCKCU7tJl%2FvfLMIIUYYIQRghBBJXS1gaUwAaGSFeBEB4LPAg2POEIoy6LyOr%2BR7jrNn%2Fw4afX3WZqVMOEIowggAAqpQ1aoEp60%2F9ICbgUHmN5yUf8br%2F0phN78SFf3PvAsmdfsgjVCMEQKY0NTpTA%2BhUpgZDS40Gb5290xnFmXV0fP3D5ex989o8bbU3XMUFQdWWDDiWw%2FkNIyTjvCILs3lMbp0zu4gLOF3%2Fx5fzb73jz2ReEHyAIIQBMiNqGuo2n7PDTPXbLrLNOl5%2F83tXXBh99YWsaRVhpbFChBNYfhB2Xz1kbZ5tfMn1V78T9F1%2B28MFHDUIsTdcp1QnRMCEYAyAZFz5nPmNuEHT4ntTIpP87YPsD9l%2FpE7zly984fUbSMHVC1Kxs8KAEVnVCdeWZH2RTm5x8XOmpwPVm%2FvI30PVTlp2w7JiuW5qmY0IxJhgRCCUAXEgmRcC5x1iH77e5bnM%2B15zrGDZh%2FB8umgXRCqEC8486OUmIRTSMlMIGBUpgVYcL2RH4scnbjNxr91L7LSef8fXCNzJOPO04NablaLpBKS144UumU1LKcHgpRMC5y4J2z1uezy9pb%2F%2B%2BrWW7gw6Y%2FPvflX7sa%2BfNNpa2WFRpbFCgBFZdQnXpW2w49oDflNrPnLRrXTzZEE%2BkHSeuGyal4fSpu6XkaBk6VFo%2BCFrc%2FJKO9u9aW%2F%2FXsvy8554ovfjFk%2F%2Be8IVFqfItDjgqFrGKcClzzCcbji1V11tPzJu5y17r1TWsX1e%2Fbqq23okldEPHBCMYugG7FEVoRxAShHRM4rpRH4uvm0qvn60bm22YMXXPH778Mrp4m%2FPPXi55PghEFHClGCCUwKqFkNJjrJWg8X86KDI%2BdsVVT186Z1y2fnRtpjGeSBimhglC5fkkIAQYQR2ThGE0xhNjMplxdQ03H37covffj67Z7pIZSzo6XMaUxgYWJbCqICUIOF%2BWy20zqzgCn3v51R89%2FsyYbHadmlTatg3Sp5UrCAFByKS01rJHJGvGpLN3nnjG9599Hl2w3ZUXNOdzTCiJDSRKYJUnDNRo87ytLj0vMn7wn%2F98%2FPjTo2qzw%2BLJpGFoCFdkXRhBqGOSNM2mRHLd2swtRxyfb20rnKJ02P57t3mekGKgb8mPFyWwyiOBdBkDw%2BuxboSWwHUfmXnJurWZxkQipuukosvBEAKCcMIwmhKJdWuzV%2Fzq%2F6JTw3fcfklHe14NFAcOJbAKIyVgnLfk85uedExknLXnr0bWphsT8USl1RUCIaAIJw2zKZEYWZu%2B8sA%2FRKd2%2FuclLW5eDRQHCiWwCiOBzDPWtG9xyeuBmbOH1aQa44mEblRDXSEFjZlmUyLhBKJ50XehHRHimprHmARKYQOAElglkRIwIVo9d8TUKZHx6xdfbYonkqZJcXUDBSEEGsY1pjUskbz50KMi%2Bw7Tz2z1XC6l6sT6HyWwSiKB9FiARzREljl%2FOLQhkay1bQP3x7IvgtCgNGVZ9YnE24%2FPC43EMJbn8x4LBvr2%2FBhRAqskQsh239%2FyxGPDQyklaG7N2DGLav0WVIEAtDU9Y8eev%2BrayLjxYX%2Fs8H2uurB%2BRwmsYkgJAsHbgwBhHFruPfPsrBNPmoZW5cFhKRACinHSMDJOrH3JktA4bIvN2jyPCSWx%2FkYJrGJIIF3OUptPiCyL3nw%2FZVkGoWGEYb%2BBADQ1LWVZ9556VmRsdV2fs4G%2BST86lMAqhpAyHwQT%2F3xweOi2taUsO6brFPV3zC2EgCIUNwyxvDUybnDAPvkgEMqX2L8ogVWG0H%2BY8%2F3IsvC%2BBxOmaRKK4ADcZAShSWjSMCPLqEk75oOAqwWx%2FkUJrGJwIfJB0VO38O4HHF3XOudj%2FQwEUCPEMYyXb7wptFDLzAcBEypsql9RAqsYgRDx0cWcGTbVTELxACXJiEKB37r%2FsciYUwLrd5TAKoMEkgme3mijyGJpuk7IAO54RAAamFiaXmykRrjgKqSjP1ECqwxhCGKsPhNZDEIIQv3sP1wBCCjGOi1mMsWmqeI5%2BhklsMoggeRCWulUeOjnchRjjAby9kIAEYSlk0Ck61wNEfsXJbDKIKVkQlDLCg9bvv2WlrtRuQogCDEsCoxLyaVUQ8T%2BROWmrwwSAC5LPOAQEoTRQNdngBCW5pZiUnAhQPljRCGkp5PEJhuV%2B8Ye0vbKQg0OzZSpSmAVAwLgtrYkmhoBALUjRw6Gx2UlJTHX68WYRUiwGMutzj21eu1s%2BOWe7xxzWtww%2BvsGVR8lsMoAAUAQeW3t4SEihAkx8EMxKVfwyzOGNaPcXjUX%2BFtdfC4A4N35LwIhK%2Ft3Q0iZqs82jRvr7LKjeO7loZdnTgmsMkAICUbN3%2F4vWggLhBBSSjmQo0SxosBYLo91s1zHptu5z%2BX52ZePzdZVVgM537%2F104%2FPnz9P6jqQYAB9rlVCCawyQAAxhIveeHPCPnuGloCzgc02I4HkUjLBi5YgwKj3%2BX5HpTOjU%2BnKNtIX%2FL3vFgEwJMUFgBJYpYAQYIS%2B%2F%2BizyOIxzriQdOCeGwkCztffa5fIoGGCC%2FVoe%2FUdO79pBRnydSqUm75iEIx1XPyDNWaXHT0%2BkGETQkqfsQn7%2Fzo89Do69EqvfUvZ5xcodvJhfWope%2BHmHLyoHqwyQAApwhalkWXcbru%2B%2FvIbXAg0EOGIYW5Gt2QD2CfP%2FceiGqnQ2ncghLntpk17%2F7zvH3UiAACA0TvtCHbaMTIue2XBsnvm0gFdqa8Ia%2F0XGDxQhCyqvXjDjeGhU5ft8LyA8z59aB%2FwhZB2cbvK01ffYFBSkeASIeUPJq2IurojteXmYLONhsDWGtWDVQYIAULI1OjH857f5uA%2FhEaZcDzGDEL7vwsTUrpBsNGhxcpGtm4YlFYknXDARe0OWwEAztlrP9baXtmWSynbg%2BCSF58e8%2Bt9P17wtj5A%2B30qhRJYxcAQmpQaEkgpw6d4t4tmzP%2FbiY6uI9mvEpMSMMHbPS%2B70Yah5Zu330mYhkFIRXZ%2FCikQIQCAzYaNGK4blfX%2FSSle%2BurLwi8SEqzd%2BlICqxwQQJ2QhGG8fMutWx%2F0OwAAxLgdApcFROvXsHoJpMdZdtJWkeXh6bPHOEmdkMo2osYy40Tv%2B%2BeUIoS0Na0%2FblO%2FoOZgFQNCoCESN4x37ns0Mk69ZEar6zHef7MJKQEXotV1NziwWMdZ5yBm6KpEev%2BjBFZJMIKOrqdt%2B9MXXw4txDA8x8izoN%2F89QLIXBBkdtkhstwx7fS0ZduaPvQCkQY%2FSmCVBAJoEpqy7MfPvyQyTr7gnOX5nMf7IyehlMBnbLnnjt1n78jY%2FNFnNZZpEDKQuz9%2FrCiBVRIIAcE4aRp18fiz19xQMCI08fTj21y32hmdQt9Gq%2BftOOeiyHj%2B7vtmY7G4YZDqZ48TQroU%2B3GnvJepD4Kw6GqhnBwVBgFoUi1jxz6c%2B%2BSkQws5EmPDh8kRDW3%2FXRzTDQyq9aALKTt8v2Hf3SLL8u%2B%2BqzXMjO2Y%2FZL89Idc%2BxazZvXijW8cfWrKNHvxxsGP6sEqTGeJE7Mpkbxw919G9i1OPGY5kO2%2BX41eTEogpMwxX4xsGD5lUmS%2F7o%2BHNcQTSdOsXtmk0ja4Abvx%2BJMCzyvr9Z%2BbbvKCYO1fUu4a1YNVHgigSWnGibV63ryrr9n58END%2B%2BTLzv%2FPcadC33M0vSILvhFCynzg%2B9maicceGRmvOeTwYTWprO2YpD9KT0AI6mKxoKX5qcOOL%2BuNGiYNyeRQ9b8ogVWeMCdhwjAaE4lP5j33zXZbDZ9QSFi%2Fw8Uznj1qGvCBrWkVGStKCZgUOd%2BnG42d%2BKffR%2Fa5l1yGlrc2pbNx0%2ByH2VeIQUjv9rMMVXUBNUSsEghCjZC0ZY%2BoST10xvRl33wTnZp0%2BQXO5G1aXDfgTPQtiZqQ0ues1XWHHfq78SXqevOxJz57%2BoV1kjUpy9L6d%2B0Lwt68hjCqB6sWGEKLanWxGBPy1sOP%2F9O%2FrrUSifDUqL33CKZOXnDCmQnD0AnF4WPW4%2BdMyjBLnHAZ64Byy8tmlD6kbz0x75kr%2Fjkmk806jkkp7v0Gy7IREniM6Y3ldWL%2Bd0t0PJAZWquKElgVQRA6mt4Qjwkpr%2F3tIT8%2F86TRW2wenqKWtc3VF%2F732f98e%2FfDjqbrGGOEVi%2BzsK%2BTQDIhfM7zUP7k1KPMTLb0mqeuvf69Bx4bnc42xhK2puP%2BrTuxNNe%2B2RUX9OKNbx1zWnIoZrwBSmBVBUKAAYppRmMCACDnnju7dqPxB844O7pg2KQdhk3aofWzL96%2FZI5JiIYJQQhBiECJU10CWbL%2F32OMDK8fe8jv9WRypV938W8O0nP%2BmEy2PhaL6UY%2FB0ZJCTp8%2F%2F7Zl2y886Sy3vjf994ngZ%2FQjSHZiSmBVZfQ4RHXdJhIEIS%2B%2FuDTv0%2F62Wlz79U6U5QCAOKj193qylkAAHfJko9vuJUva5a5HIIIQSAlEEACgqFtJyaMG7vfvl3%2BlubFiy874I%2FDamqHZzJ1TszRdDwQRcmyTqzj%2FU%2FfevvDns8rIQQx3WhI1gxJdQElsH4AQkAQjusGQcggxNG1y%2Fb9bd2E8QfNmrHSlUY6PeGko8v6cB4EFx%2F4e9TujqtraIzHU5ZtUYrgwEQdWpSOz9aXfX%2BGtBdRCaw%2FCMeKDtVJDBuExg1z8Wdfz5i6Z2rddf589WWY9OZ%2Fwcvlp%2B%2B1n4VJXSxeV99Qa9kJw9AJGdiI3n50qawdKIFVhVLne%2FjAh45CAxJi27auJQwzbTvfL2m%2BcI9fekDudPBB2%2B6%2FX08%2Bufm77568%2Fqa3n3wmYVnrJmvTtp2y7IRhGISUhmus5P3vH9FJCfKSk8Zsz38fBIB%2Fv1Rncqh2YkpgFSP0nnf%2BW3zAIYQIFhzxCEKKMNGQTmjcMGotu8V1W9zcW7fdPf%2BGW%2FJBwKSsqc%2Buv8XEdX%2B6cfj2th%2BWvDHvma8%2F%2FgxJoGNiUuoYxgaNTUnDTJhmTNNNSks9kGHYlAAlyZkgRIU91tVNk7Y8n%2Fvp5TN78cY3jj4lZVq9eOPgRwmsr0SrUkyIQHAGgFZXS%2BJxLZUCAEAI2z%2F5RCxtMTChGIcRUhBADWGiIYvSpGnmA6cj8HO%2Bn%2FP9fBD4PvvmuZe%2FePoFJgSCkGKMEV6vNqMTamrUoppFqUU1g1INY7Kic59L6TPmIWCMGiE6c%2FoihLxly73FSylGFGGCEEa44jMfKUFH4C%2Bc%2B3iyLlOGkwOAXEtrzvdrDGtIdmJKYL0nlFYghBsELGZudOLRNB7r7tJXjj89JoRBCiu%2FEAIMIZKhzLSEMAIhAs4DzpngXEgmhRACQEgRQhBihCjGFCGKCUEIw4KXsPSh5ELmAr%2F2F7s27Lh9d23OL%2F7%2BrXNm21QzKCVrWnkri9CL%2BOldD37s5svYXApBwjDHpDNDUl1ACazXhIkHc0EgGzJrdv1BuOXF0%2BcfeVIthCak0cMU9mYAAgSJhoGkUsrCIFMAECa2RwCgwlWF3g901flICXzOWpHcsHt1AQDMuuxWV80GACw89Rzd9U1CK7h9Rsd4fLau7K3bsGobeAYBSmC9QUoQCN7mueNPO86sy%2FbwXVvNPue148%2BgFlp180g0QSqVTjiH6smzF6q9zfO2vOicHjZm0xln%2FrDw9W9uuiumVzJXB4Jq2%2FQKKIGVTbhxuMXNrxoW1LZ06cv33PvkTXdghDCEEoCA82n%2Fvrm2qQkAQAyjnSA7CBy9R0mmynrofc7bIcB6IcfTK%2Ffdf%2B%2BFV1BCpJRCyng69avTThr1001QSZrBzKYT05tsvOCoU5KmqVUiGlBK4Eouja7zTCEIcc6la3mew3JRAiuPzm357iaz%2Fl5qf2feU3eeO8vRdUc3xtU36IRQhAUAOc%2F7x%2B%2F%2Fctq8h8PLJs8656WjTzEorWCn0dl9uZOvLO4mfuKq69ara3B0HQLgC%2B4FwaNnX9DuulzDx%2F7rBrumJrwMYjz%2BlKM%2FOP%2ByGtPqe5Oa3fwml81YzQWCsc9OOU%2F7MWlMCaw8hBQdvj%2F%2B9ONIiVv5tMk%2FSxnmuLqGpGU5um5gTHChR2jzfVPTnrv2hh3%2FfDAAAOt6M2fxICA968R6iMeYaxX7jU9ffnWdmtqRqVRM1yEATErGuctYm%2Bctz%2BWuPuCPwjSm3XdHeHFsWFNyyrbtz74cN8y%2B9GJSgjbP%2FWLhG%2Bl1R3Z3zYs33jSMMyUwRddICTzO2wk2s8V519k77TEimWpK1qQty9Z0LYyLhxACIAEwqSak%2FOCReaHAAAA%2Fv%2Fby%2BX893qxcJ8alaPe9bWeeG1keOveCn9Q3pm3HpDRshhBSSOExlrGdWtte1NI8e5%2F9T7zvzvD6sfvu%2FeTcp3RCMNV63SQIQcaJvX7JnOZ8rks%2FB0RgWCJl1la4wtggRwmsDLgU7Z637ZXFqdcZO%2B46KpMdmaqttWxL0whEYMW5k45JjWlmY87r9z848Rd7hUY%2FbuX9ynRiUgKf8w5UnH29OfexulgiZVkGIajTC48xlBJRjA1KbV2zNe3r5cv%2F8afD%2Fnr9nPBd288%2B563TZ%2BiE9MWpaBIysWnYaraQwiHtMOwStaO5p4SPcq4k%2BfTrD88dnkqPTNVmnVhM1wlEq%2B7PhRCaVEtbzis33hYZp8w6t8VzWZ%2BzuIX5Alo9d9vpZ0TGp6%2B8NmM74Waw0sZEcSQO1euc2MhUiixva%2Fvhh%2FCsUZNs8X2PsTKbsDIIQoy6fa2qLiFXeYE%2B7fIebKgerKdIIPNBMP6QAyPL01ddu0E4EiO0uz%2FMUX6Oulj8tXsf2GzfQj5QVyduJWZiPmPN%2BbwWKyxwv%2F7AA3WxeNIyu9sjHC5wm5TWWnY%2BGVz3h8OOfeTu8FTj1O1yzy%2Fot1owQso2z9vg3FOQqSNCS0%2BNBgAA8PXChf3QjGqjerCewqXM%2BV62M33Nf999ty4WT9vh9pDVPZEIQJPStO0svPmOyFiRTiycfe1yzaWR5blrbs44MUdbQxqpMO9VrWVnY7F8S0to3PDX%2B7V7PuuXutISgB862idcOp3EnJXUFfHmvQ%2F3Z76DKqEE1iOkBIzzdt%2BPLM%2F844aU7TirjMRWBUJAMU4YRjYWn3%2FjLaERa9rywMsFvc9ZHw5Z8xqBnU65T%2Ba%2FUBdPpKw1L2pBCDBEjq6nLfuZK%2BdE9jbPZd2n%2BBZACim5kFwK0LdU%2B1wIY%2FvNAQAfL3jtmC12OHbLHcPXUZtvN%2BeYEwsXffNdpepxDiBqiNhTfM5xbTI6bPt60cjGJg33aDwFATSpVmvZ794%2Fd7s%2F%2FF9o3OMfl75wxEkmpb1L%2FBSGbuxY4nF5cMZFGzUM62EqDggBRThuGO8tfDcy0mzK85lJV04DvOiDDxrHj%2F%2FZ9VdW6ma6jI3ZZSoA4PFzZv16sy3C78%2BF9IbXTT71RADARfscsPOIdYeAR2St%2FwvRPwggPc42%2FcvBkSVmGhalPazICiGgCCVMI%2BvEX7v7ntCICHEtw%2B1VJyYl8DjL68UFpfeefrYulqgxjR5qHgCAEbQ0LWEWs82M2nmSx9hKw1aD0BuPObmy95MLEUp4nVSqMZaoj8UzdsxZf1Sorqv%2FcuSGqXRcHwppcJTAegQXwguCmlEjw8PA8xxN18upVxJ2YhnHfu3WuyPj1ItntPZqJsal7PC8bc49PbI8fuEVWcex9TIySUEANUwczVjembZx7K5T836wUmssqm25zshZu%2B598rY7T9t2p2nb7nTC1pPffurpitxYBAp9V2utM%2BHowwEA1xx21EhfjK5ND4HuC6ghYk%2BIAudhZ39127En1VOtrBlC2InFDSPrxBfe9%2BCm%2B3SuicXKXhMLA%2BfbpKCdmXNef%2FDhuni8xrR0XMZ%2FaOjhNDX61gNzJx3xl9DYEQQB56WL4AiCUanaxnjCDYJQefkgoJV7%2BrkUS2ucLaYdBwC45aRT1w3A6Ey2IsXaBwND5GtUFQkk48LHxXuV%2B98SS6PlVlQIO7G0Zb264ppYWZ1YFHm4%2Fexi4Pyz%2F7ghazuOvmaPy0pgiExCv3j%2BpeJXC3wmVi4nhCC0KE1ZVm3nC1co3IlL%2BbXbscUpxwMArvnbUekfWkanaoeMuoASWI%2BQwOds%2FK%2F2jAwWJgah5Y5hOtfEzLpY%2FMV%2F3R7Z2xFwyymB6THWgWDUfX08f342lkiaVi8i4iEEBiFWiVo2%2Fu1%2BLgv6ba2XZVOTL58FALjtzHPq2%2Fyx6cxQUhdQAusJQsp8wEZP3Tk8bPv%2BB0fXddIb11%2Fnmpj99t0PRsapl8xscXvaiYVrX5MuLaa%2BeHjmJVknZutaLxoEAaQY21oxUHj4Vpu7jHHZo8bkpOzw%2FV688iwAAAIA9rtwBgDghuOm6Z%2F%2Fd4O6ejLk4oDVHGwNhOFILgsiy8K77nZ0XcO9qcga5khMmGY2Fnvl9n9vecCvAQBY0zowyvcgsCNc%2B3J1Gs0GP3r%2BhfpYImWZZc2%2BSsEYW5S%2BcM312x76JwCAlUrlfJ8JQVG3zzoE8Lmbbhu74w47XTS973f4jtPPamzuGN3QOCS3iqkebM0wwRkpcYg%2F%2FmzooO%2FdPB9BaBJaazmv33lfZNz1ytktbj5YUydWiDaecWZkeXjmRV1GHvYQCAGB0KTa5%2FNfiYw5xpjgqxmyUozsnP%2BPI4%2Ft4419dM4%2F%2Fz5lt%2BSipeulM0N1D4vqwdaABDLgPLv5xMhi67rR4xWwVYkCO%2Bqc%2BDuPP7nRrlNDux%2BzvCCg3Xdi4dpXm%2BRR4PwbjzxaF0sky1n7WhUEoE4I9otdtDNymLe83aagu94UQfTTpmGfL1syZ%2B%2FfcNHL0CpKSEM8vtdPNk6ZFlr7Q6K6QwlsDQgpPcYmHlAoBsuDwNF1vVfjwwgIoEVpxrFfmHNDJLDJM8968chpq9nszKXo8Lztzi%2FupH7mqms3bGgqa%2B2ri8ZAqGFsaTrzfaJpAICdzzz5xSOmCUNi0G0Es0XpBtn6cem6vtxbjIawsgqoIeIaEFLmgoB2luh%2Be%2B7jFtUoxn15MMJOLG4Y2Vh84b33h0ZESAeG%2BW7cieHsq42zKHD%2B%2FaeeroslwrWvPi5KUYxtqi3%2F5r9RS3JBsEY%2FB4KQYtSX15BXF1ACWz1hjG8uKA6f3rr%2FYYtqfS%2FKCkE4E7Neuak0xP6ctq7ciVHSqClzLo6Mj118VcYprH31qSUQYIgsjT585nmRMRf4Aef9c5OHNkpgq0MCEAiR3XTDyMJa201K%2Bl7YLuzEkoZZF4svuKsQPEUta2k%2B3%2BWamMdZ6V7Pr99%2BJ%2BvEakyzL7OvCISgQQgOioqyRzT5nPU60l8RoQS2OqSULmNjdt81sjiarpPKxAnBzjWxhbfeExn3uvHq1lU6MS5lh%2Bdvd%2F5ZkeXuk%2F%2BedWKVqmGJANQIKV0NG7vbzqtG%2FSp6gRJYt4QDM5cFNaNGhZYPn3nG1jQN44okhArXxJKGmY3FPn7%2B%2Bcju2YbHir1HGHnYwgLSWWT13aeeqYsnU6al96ruUZcQjG1N%2B%2Fbtd8LDEdtsnQ8C1lsPoSJCCWx1MCHyJZssX73zPlvTKhjLgyA0KU1Z9pOzr4qMk2ae1ezmw06sGHl4fnHt64mLrsjYtl1%2B5GF3QAgIRJamvffI45GxIwh4n7OGKJTAukUCyQR3S55gd%2FGSQs2EyhVMIIWZWOydx54MjYjSvE6imZjH2fJ8PqrI%2FPajj2ZjiZpeRR6uBgyRQci3C9%2BKLFynAedqGtZHlMC6RUrgM77jGSdEx7auG4SiiiZfD6MTM47z%2FJzrI%2BMOZ5%2Fa4npMiHDta%2Bc5F0Wn5l1xXdaJOb2KPFwNEAKdUFsvTsM22n9flzGh9NU3lMC6RUjpsiCxzjrhodeRs6muYVzZCnYFd6Jp1sXibz8yNzTqiURL4OWDwA2CHEFY00L7Fwteq4vHe5J1o%2BxmAEgRsmlRYE2bbpJngehZ1K%2BiO5TAumbVTZYPnnWepWnVCEhFAJqEpm17%2FjU3R8Zdr5y9LJ9rdvM7Xnp%2BZLz3zOkZu2LOw1JCj4ul0efnXBtajEQi7%2FvKz9FHlMC6hQkOnGIC%2Bh8%2B%2BcKipBd%2BhdBXsZoXAAAjFNeNjBP77KXC3kdiGM1ALBPFTKAfzX8xG0skDIMiVKhV24NP7jkYQZPSbxa8Hlk6Aj9Qq2F9Q8Uido0E0uN8%2BKStI0sY49tzeYXPt5CSS8HlGkZaQkoAgaNpD5574bFzC8tiv%2FjnZV5bW3TNPWfPHF%2FfiCB0OUNiDX8ZEYQYwvDPQQ%2FLWCIIdUJg3ossmQnj%2FW8Wh3UA%2B%2FXuDyGUwLpGSOkGwcR9Col4WxcvdjRdIz2a%2BYRlyJkUPmPM1Bp23zW5wTg9lerJ791txUM9VqxJe%2BqTD%2FW8%2Fd7SJcveen%2FRo%2FOoz3VSqDq7hmSJAGqY2JouOA%2FLiG19xF9fOe50YcihuZOkX1AC6wIpARMiXxKC%2BM7cx21NowivcUNkuL0lzwJzwrgND%2F79QH0FvTbdMGWHhik7AAA%2Bv%2Bfe5ucWWJqmY7z63owgZFG67Muv0qNHAQA0y8oFAROi3Owjigg1B%2BsaJnheFGPz3nhgrknp6tNIhR1XngVtOtn40hljB05dKzHql%2FtOvHwmH9nY5nmrSUwQLjeblD54erESUk7Fc%2FQNJbAukED6nK8zZYfIYhFqELqaUVbodWz3PWenbTYtqXXSaz549rnTJ%2B92%2BuTdXn%2BojJHhavjJEX8Ze%2FqxLW4%2BELx7jUGdUMKLitKztR5XQYm9Rw0Ru0BI6QXBBpO3iyy2phuUrl5dbZ43%2FOADajfeqPTUm08%2BdfvZM0xNDydCoCeL1BBgiAxKxqQzEMBXr7%2FtuTk39jALTdgcLqTHgkCIX51%2B0sY7T4lOGOn0hJmnvXHyeTWm2eW2TgiBtmIOnHF7TP3fXQ8L0O3mS8XqUQLrAi5lLmDxxsbwcMGdd9maRlHXm%2FmlBFzKDt9vOHCfUnUt%2BvCjOX89OmXZ4%2BubYoZhENLzlEkIQg1jnVAIgMeZz7kQZcRUcC5czto997lL59w%2F46KfH3v4pnvuEZ6iTmzirL%2B%2FOe3shNGFxsIkUxbVfvj0s8yY0QCA0ZMnfXnbfVwIUqG4xx8bSmAr07nJshjj%2B8G854Z3v8lSAunxIB%2Bz6rbcPDLeefb0r15aMK6uIeM4CcMwCaUYw3JiQBCECEIIoRDdD%2Bm6bD8AUkomRJ4F7a63NJd78Zob511%2F87T7CwVjiWUNP3j%2Fb%2F%2FfXQnDWLWeZZjr952HHply7FGhJef7TPBeZ636kaPu2spIAALBreH1kcVbutxoaOwyiD70Nzbn8ttcVHQMXH3IYXzx0vWz9dlYPKbrOulVCkUAwg4TYdi7%2FyRb0%2BK6kTTNpGl%2B29I8%2FWe%2FOO2x%2B8NTdT%2Bd%2BNGt92ossKlW2i2HVTBNQt%2Bd%2FyrozBnlYxRwLqmsYNX2Hw9KYCsjpXAZ2%2BrowyOLres6IV32XxLIXBCsd9hBkeWVex%2BQ3y9bL5Oti8UcTScIhWNIJoSQoj%2BCImC4yozCAHkNY4MSnRCC0Yyf7X3qYw%2BEV%2B1w4XkvHHa8gQlccaAYLjeXRv2u97Odc8%2B9FJc9mj8qVkIJbGW4lF4QWLW14WHzt9%2FatOtNllKCgPPmfH7jzrKXfi73wnU3r19X3xCPO5oOAQw4zzOW2Pqn6%2By6k5as6Z%2BvkFu06L%2BPPN763icWoQRhi2pZByEIuBCvPfDQZnsXcoDzdDLf7jnaCnNLCKCGcWnU73pTJ7361PNcCgzUgnPZKDf9CoRDvlwQRMFBN%2F7tOEvTukxzK4F0GRv3599Fltn7HLBOTao%2BFgvV5XHWStHGl04fuf9%2B%2FaYuAIDV2Dj2z3%2Fc5NIZSz3X4wwAYBCStp3hyZpXrv9XdNk2p524anoCCAFGyNboglsL2XjMmho38JkcUrXJ%2Bw0lsBWQQDLOQcyJLDpAJu16BYwL2eZ59ZsVcpIy38%2FaTl2nulwWBA21m838e49%2FeeXZ%2BooL2gwShqTomNRadmMi%2BcTlhd3TxDBa3Ly%2FSvYogpBB6RcvvBxZOgKfcdbjX6soogS2AmH23J%2F8Zq%2FIYuu62VUhFSlBIHib50aW6w75W10sljRNijETfHk%2BP%2BGEowf6C4Etpp%2B5LJ8LOA%2BzhaZt%2B4tnXih%2Bu7EjXLZyxT0EoUFIsKwlspiN9T7n%2FTKDHGqoOdgKCCndgA3fepvwcMmXXzlU07ryAkogfcb0YdmipaWtpqHRIFRKkAv88UcfEp16%2F%2Fn5%2Fzr1bFvXaTfOkgq2P2As5%2FtHXn9V%2FXrrhcZRf9j%2Fu3%2FdW2NaFOGYYaQsWzCGCAEAbHfCsS8deXJCX2EdOYr6jSzbHPnXd6dfJHTZt4SrP0aUwIqEhVRK04y%2BevudtqYR1LWHw%2Bd8y6MKzkbu%2BwnTtDUNQ8SlaPW81Prrh6eWfvPN%2FedcMK6%2BMWmaOiGo0nslSxFS%2BJw353M3H3HiEXf8P6umBgDQuOUWH153a5jx28AkYRhLvvwqO2Y0AAATkmcBl4LIFYRPMLYobVv8fawuCwCINzWEuX5XukyxRpTAVoAJLq3iX%2B7PX3ptQuOwLpeYJZCB4FY6HR56uZyl6eFO%2FoDxNq%2B4q%2Bqfhx45Kp0dXlMT13RS6YwDK7ZJSgAY5%2B2OY2vadYceedRdBZdGi%2BelGdMwJgiZlL74z%2Bt%2FMXsGAABA6DHGhSh1EIYlVwxK5553wf5XXAQAgBDm%2FIAJoSs%2FYpkogRUJR33DJ20bWWzdCGN8u7hYgtLCIoJxHeNwMZoJER%2BzTnQqoen18XjatLRyiqb3%2FlsQohMipFz%2Bv1xkjK07zF%2FWLsMgLEKWfPZ1dMpnfNUwRwihQUj%2B%2B%2B8jC9epz5lFqVpuLgvl5CgSFlIZt%2Bfu4SHzfUfTDEJgN0vMpQJb9tVXtDNiI%2BArOOaShhXXDY0QBCGEoNovBCHF2NH0hFnMd%2BA0NXEROikggYiWlDuToIsox1CHVkli01GTt%2BlSiorVowRWhAuRD4IohdPLt99lUZ10Na%2BXEkgpgxKB5ZYsoQhBCMPIerszUBgAYGqUVigZcA8JU0SV5v2VUoapNWBnPFTpd%2BnyEzSMbap1LF0aWjY58Der%2BhsVa0QJrEC4xNxRUofu3UcetzVKu43xBaVPm5QSwcKlQghRoj2KKlGgoUwgAN27I2BP1E4gMjXtw3lPR5ZwGqYkVhZKYAXCrf7DJxez3GhcGFRbjdes9FH7%2FuNPuqt2haro1uiWlX6nXrJ03rO3A4yQSegbJcXaXcGZyvVbJkpgBYSULmOjd905sji6YdJeLltFxewAAACUtU%2BlYpT%2BSjudlqA8ZSAIDUosTCNL7YbjPF7W1hmFEhgAoDOdhsuCWENDaHnrwQdtTa9UIZUBAZXsr5FACiHKypVYmIZ1zkgBAGN329llgYrnKAslsAJ8xTRSC%2B552KQUr53ZlCAEEMLSFD1CSibKC9ct5Pql9IuXCkGJ9Rtu6KqSK2WiBFaAS%2BnLomdCduR7vVFyMIAALF2%2Bk1IKWXZyKAyhTuhXr70ZWVxVla9MlMAA6FzUCkoWhCiEOlmLx4er%2BuJ7UScFQaQT3FYyn%2FQ55yqLWzkogRXgUrCSRIga7k0a%2BiEGhAAjrJWspzGu1prLQwkMABBmigGlARjdpJD60YEgNBPx6FDKXlSV%2BFGjBAYAAAACiGBpICuNOVysxXt4V1oH7zVciPoJG0aHBCOoKkGUgxIYAABAAAlEWklmsm0OP9hfmyv3iBW9GhBChMrWBZcyEHz0TpPCQz%2BXo5iQypWo%2FjGgblYBjJBJ6dIvvgwPGzbeuMPzgx67pOs7d38NBlYNlUSh176cvifcLpDz%2FSg489U77tYJQUpg5aBuVgGCkEm1x2YWqyGTxmw%2B6OW6qlWTHOgvtMIQMSwXVpbCJJBuEIzYc2pkeefhx0xKycDEpaytKIEB0Bl6Z2maaC4WvJt0zmmtbj7oVXCQ7pQX%2B1cNSmeQode%2BDHVJEHDe6rnrdeZ4AwA4RDMJreqO7KGHulkFEIAWpUnTev6Gm0ILhHDk%2Fnu3r7bkz9pDeYNDJkWr504866TIeO0f%2F5KyLKucGp8KoAQWERYWqbHMDx56IjKOmDJJjKxv891yipusjASFErJc9NNLSMk7N4CV3VoJmODtnte4%2F152fSF%2FuNfRAVs6kqZVusdM0RPU%2FSpCEIrrRn0sdsX%2BBx15582hcfPjj%2Fngtn83v%2FS6o%2BsUY9SzeseldHh%2Bcz7n9uNm%2B3D61OH55b2rszxnm%2B%2BNOerPiTGjo1OX7nvgBvWNcUPHSHVg5aEEVgQCaFGacWItrvvSrbdv%2FdsDQvv4A3%2FNfvHzl6ed5WBiYBLWU%2BVCyG6j%2B6Bgxbjh%2FW%2B%2FfqC%2FGcgvW9bdKSElEzwQPMyYwGucTc88q9QbcsPfjm1KpjKOYxKVkKNslMCKhK6OpGk2JZPv3POQk8lstEthexixrO2umAUAWPTss989%2Fh%2Fgep7ndfjFLuJ%2FH35YuJUQYIQ%2Beu6lrf9ySPlNqBafPPv8cKx1ecplrI0zQaym3SfVb7%2F9SmdvOeEU8b8fhtWmE4apKjX3AiWwFUAQ6phkbIdx8cLV13%2F%2B%2Bpt7n3xC6QWNkyY1Tpq06hthyQ86IRbC373%2FQcMG4wf6CwEAQPuSJf7yVprNQtjFpsuD%2Fn1jd2%2B84qA%2F6W35UbWZtOPomCh19QIlsJXBCNpUa4jFAABfL3jz7Cm7n%2FLw3Zplrf5dH7%2BwYIPaDAAAAqgTUmvbc8%2BY%2Fs3yZRN3nTKAAVcQwlceeaIhkVwvW2cQAgGUUKIVt4p1Sa65%2BcJ9D2yqqR1Rm66LxSyi4fIDQRRACaxLEISWpjfGoU5wTNev%2BtX%2FdXD%2Bi2nHbDh5UpfX%2B%2Fm8JkGhhiUEGsYpy1o3Veto%2BpJX3%2BL9UxZsVSBAEI5vaErbdsZ2dFLY%2FE8xtjXt7YcemdBZV7aU1%2Bc%2Bdt%2BsS2ttZ2x9Q0MsXmvZFqVKXb0GfjntnIFuw2AkTCLgc9bme8tyuSUd7cs7OlrdvMsYoGTY6HXX2WAcAGDxl19%2F%2B%2BkXFhNjM9l1ampszUAwfK9wGcuzIBjQ%2FR0QQIyRRYhBaDiDkhIEnC3uaP9syZLv2ltrR40Yvv56X7%2F%2F0beffyn9QCckZhhp20nbsRrTjBmGjjEs33GqiFACWx1CSiGky4OcH7T7Xrvntfu%2BGwRM8HDgByHUCam17LpYLFniBghd3nIw1NQqxHAURSKkzAX%2BDx0d37e1t3l5LgQEkGBsUGJpekzTHF13tEJRT%2BWV7yNqiLg6EIQQQRvpBqFxQw%2B48DkPwuxlEoQruQRhgxKTahBCsfLq7qD4219oaknDdEwytm1TzedMSIAgwAhRjDWMKSYU4TCuajA0fm1HCWwNhA8ZgQhDpGFphYHqUviM%2BZwBXYMQAABdCDxYbma0foXni6XMZGekokEIxSQsCoEgghCoAWFlUQLrKeHDJwFgQHp%2BMP6sk7RBEDLfd3KLvvvogsvjmoFUmHwVULGI5RFGIQ0%2F9LdDQ10AAKuxQY5syjF%2F7d1dOphRAisPIWW779eMHxQryJWidotNO3x%2F4P0xQxE1RCwDKQGXMh%2F4sHOh9qnrb3j9yWcJLm%2BzcP%2BjG3rDqJHFLwIA5%2FxXZ5xWOJuIeYxzKTBQBfYqjBJYmUjJSrbie80tqLXd0o0BqfBQBjl%2F6bJ3Ct8AAC5ku5uPTgopVbbDKqEEVjalQynL0EfVZtK2vRalgpEAcCG%2Bb28f6Ib8KFAC6xOUkJRlZWyHorVpcOUJ7pdW4VSzr6qhBNZHYFjqbpCPEFdisA9ohxBKYH2COnaQcFzbJGtPDyYBYJxLyAa6IT8KlMB6g5Qy7AO2%2BO2B4LcD3Zo%2Bk29tHegmDFnWmqn54AEh6LUNKQ%2FBovc%2B7EXeX0VPUAIrAwgBgsgk5JY%2FHjbQbakkHz%2FxrIGxCpyvBmqIWB4YQVvTMrZzyR6%2FXNre5gVsEOxI6SUQQkOjaSc2Op21dF0JrBoogZUHBNCiWmM8QTFuduLe2lzxESFoEFpjWRlbZYyqFkpg5QEh0DCpMU2TkqwTY5yvzatIkGJsEKITQlXGqOqgBFY2EAKKMNGQTdfe4WHxu8AV9zsrKosSWG8I94YN8gBfxWBAeREViiqiBKZQVBElMIWiiiiBKRRVRAlMoagiSmAKRRVRAlMoqogSmEJRRZTAFIoqogSmUFQRJTCFoooogSkUVUQJTKGoIkpgCkUVUQJTKKqIEphCUUXgWr8pV6EYxPx%2FAoZncEr7y%2B8AAAAldEVYdGRhdGU6Y3JlYXRlADIwMTgtMDctMTNUMTY6NTg6NDEtMDc6MDARs4HCAAAAJXRFWHRkYXRlOm1vZGlmeQAyMDE4LTA3LTEzVDE2OjU4OjQxLTA3OjAwYO45fgAAAABJRU5ErkJggg%3D%3D")),
            );
          }
      ),
    );
  }
}



Widget _SwiperImages(List<dynamic> listImages){
  return Swiper(
    controller: SwiperController(),
    autoplay: true,
    loop: true,
    itemCount: listImages?.length,
    itemBuilder: (context, index){
      return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: CachedNetworkImage(
          imageUrl: listImages[index],
          fit: BoxFit.cover,
          placeholder: (context, url) => Image.asset(
            'image/loading.gif',
            fit: BoxFit.cover,
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
      );
    },
  );
}