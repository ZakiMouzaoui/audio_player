import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

class DetailController extends GetxController{
  AudioPlayer audioPlayer = AudioPlayer();
  late Duration duration;
  Duration position = Duration.zero;
  var isPlaying = true;
  var isChanging = false;
  double slider = 0;
  var isFastForward = false;
  var isRewind = false;
  var fastForwardFactor = 0;

  playAudio(url) async {
    await audioPlayer.setAsset(
        url,
       preload: true
    ).then((value) {
      audioPlayer.play();
      duration = audioPlayer.duration!;
      position = audioPlayer.position;
      isPlaying = true;
      audioPlayer.positionStream.listen((event)async {
        if(event <= duration){
          position = event;
          update();
        }
        else{
          if(audioPlayer.loopMode == LoopMode.off){
            audioPlayer.pause();
            seekToPos(0);
            update();
          }
        }
      });
    });
  }

  void togglePlayer()async{
    if(audioPlayer.playing){
      audioPlayer.pause();
      update();
    }
    else{
      if(audioPlayer.processingState == ProcessingState.completed){
        seekToPos(0);
      }
      else{
        audioPlayer.play();
        update();
      }
    }
  }

  void seekToPos(position)async{
    audioPlayer.seek(Duration(microseconds: position.toInt()));
  }

  void toggleLooping()async{
    if(audioPlayer.loopMode == LoopMode.one){
      audioPlayer.setLoopMode(LoopMode.off);
      update();
    }
    else{
      if(audioPlayer.processingState == ProcessingState.completed){
        seekToPos(0);
      }
      audioPlayer.setLoopMode(LoopMode.one);
      update();
    }
  }

  void changeChanged(value){
    isChanging = value;
    update();
  }

  void fastForward(){
    if(fastForwardFactor != 0){
      fastForwardFactor *= 2;
    }
    else{
      fastForwardFactor += 10;
    }

    position = position + Duration(seconds: fastForwardFactor);
    if(position >= duration){
      seekToPos(0);
    }
    audioPlayer.seek(position);
    update();
  }

  void changeFastForward(value){
    isFastForward = value;
    update();
  }

  void changeFastForwardFactor(value){
    fastForwardFactor = value;
  }

  void rewind(){
    position = position - const Duration(seconds: 10);
    if(position < Duration.zero){
      position = Duration.zero;
    }

    audioPlayer.seek(position);
    update();
  }

  void changeRewind(value){
    isRewind = value;
    update();
  }

  void changeSlider(value){
    slider = value;
    position = Duration(microseconds: value.toInt());
    update();
  }
  disposePlayer(){
    audioPlayer.stop();
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }
}
