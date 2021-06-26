$(function() {
  w = $(window).width();
  if (w >= 600) {
    $('.slider').slick({
      prevArrow: '<i class="fas fa-chevron-left"></i>',
      nextArrow: '<i class="fas fa-chevron-right"></i>',
      dots: true,
    })
  } else {
    $('.slider').slick({
      dots: true,
    })
  }
});