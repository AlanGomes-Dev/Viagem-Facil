// Script para fazer o carousel funcionar automaticamente
document.addEventListener('DOMContentLoaded', function () {
    var myCarousel = new bootstrap.Carousel(document.getElementById('destinationsCarousel'), {
        interval: 5000, // Tempo em milissegundos entre os slides
        wrap: true, // Permite que o carousel continue infinitamente
        keyboard: true // Permite controle pelo teclado
    });
});

// Script para navbar transparente/colorida ao rolar
window.addEventListener('scroll', function () {
    if (window.scrollY > 700) {
        document.querySelector('.navbar').classList.add('scrolled');
    } else {
        document.querySelector('.navbar').classList.remove('scrolled');
    }
});