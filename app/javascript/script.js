/*global $*/
$(document).ready(function () {
  $('.complete').hide().fadeIn(1000);
});

$(document).ready(function () {
  $('.about').hide().fadeIn(1000);
});

$(document).ready(function() {
    var rotate = $(".about_image");
    var hover = false;
    var roop;
    var count = 0;

    //回転させる
    function start(){
        roop = setInterval(function(){
            count++;
            if(count > 360){
                count = 0;
            }else{
                rotate.css("transform", "rotate("+ count +"deg)");
            }
        }, 10);
    }

    //クリックされた時の処理
    rotate.hover(function(){
        toggle();
    });

    //ループ中かどうか判断する
    function toggle(){
        if(hover){
            clearInterval(roop);
            hover = false;
        }else{
            start();
            hover = true;
        }
    }
});