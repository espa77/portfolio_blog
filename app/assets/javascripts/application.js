// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//

//= require SplitText.js
//= require jquery
//= require jquery_ujs
//= require_tree


(function($) {
    var $window = $(window),
        $cols = $('.col-1, .col-2, .col-3'),
        $wrapper = $('.wrapper_padding');

    function resize() {
        if ($window.width() < 801) {
            return $cols.addClass('mobile'), $wrapper.addClass('mobile');
        }

        $cols.removeClass('mobile');
        $wrapper.removeClass('mobile');
    }

    $window
        .load(resize)
        .resize(resize)
        .trigger('resize');
})(jQuery);

// animation

var introTextTitle = new SplitText("#about_title",{
  type:"chars"
});

var introTextOne = new SplitText("#intro_text_1", {
  type: "words,chars"
});

var introTextTwo = new SplitText("#intro_text_2", {
  type: "words,chars"
});

TweenMax.staggerFrom(introTextTitle.chars, 1.2,
  {
    autoAlpha:0,
    opacity:0,
    scale:0,
    rotationX:90,
    y:-50,
    transformOrigin:"0% 75% -100%",
    ease:Back.easeIn,
    delay:0.5
},
0.1);

TweenMax.staggerFrom(introTextOne.chars, 1.2,
  {
    autoAlpha:0,
    opacity:0,
    scale:0,
    rotationX:180,
    y:80,
    transformOrigin:"0% 50% -50%",
    ease:Back.easeIn,
    delay:1.2
  },
  0.013);


TweenMax.staggerFrom(introTextTwo.chars, 1.1,
  {
    autoAlpha:0,
    opacity:0,
    scale:0,
    rotationX:180,
    y:80,
    transformOrigin:"0% 50% -50%",
    ease:Back.easeIn,
    delay:2.3
  },
  0.013, allDone);

TweenMax.from(".col-2", 1.3, {
  autoAlpha:0,
  opacity:0,
  scale:1.8,
  ease:Bounce.easeOut,
  delay:5
});

TweenMax.from(".col-3", 1.3, {
  autoAlpha:0,
  opacity:0,
  scale:1.8,
  ease:Bounce.easeOut,
  delay:5.2
});

function allDone(){
  introTextTitle.revert();
  introTextOne.revert();
  introTextTwo.revert();
}
