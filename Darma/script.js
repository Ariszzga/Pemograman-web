const faqHeaders = document.querySelectorAll('.faq-header');

faqHeaders.forEach(function(header) {
    header.addEventListener('click', function() {
        const content = header.nextElementSibling;
        header.classList.toggle('active');
        content.classList.toggle('active');
    });
});

const topButton = document.getElementById('back-to-top');

window.addEventListener('scroll', function() {
    if (window.pageYOffset > 300) {
        topButton.style.display = "block";
    } else {
        topButton.style.display = "none";
    }
});

topButton.addEventListener('click', function() {
    window.scrollTo({
        top: 0,
        behavior: 'smooth'
    });
});

const modeBtn = document.getElementById('dark-mode-toggle');

if (localStorage.getItem('tema') === 'gelap') {
    document.body.classList.add('dark-theme');
}

modeBtn.addEventListener('click', function() {
    document.body.classList.toggle('dark-theme');
    if (document.body.classList.contains('dark-theme')) {
        localStorage.setItem('tema', 'gelap');
    } else {
        localStorage.setItem('tema', 'terang');
    }
});

const slides = document.querySelectorAll('.slide-item');
const nextButton = document.getElementById('next-btn');
const prevButton = document.getElementById('prev-btn');
let indexSekarang = 0;

function tampilkanSlide(index) {
    slides.forEach(function(slide) {
        slide.style.display = 'none';
    });
    slides[index].style.display = 'block';
}

if (slides.length > 0) {
    tampilkanSlide(indexSekarang);
}

nextButton.addEventListener('click', function() {
    indexSekarang++;
    if (indexSekarang >= slides.length) {
        indexSekarang = 0;
    }
    tampilkanSlide(indexSekarang);
});

prevButton.addEventListener('click', function() {
    indexSekarang--;
    if (indexSekarang < 0) {
        indexSekarang = slides.length - 1;
    }
    tampilkanSlide(indexSekarang);
});

const counters = document.querySelectorAll('.counter-number');

counters.forEach(function(counter) {
    counter.innerText = '0';
    const target = parseInt(counter.getAttribute('data-target'));
    const hitung = function() {
        const angkaSekarang = parseInt(counter.innerText);
        const kecepatan = target / 100;
        if (angkaSekarang < target) {
            counter.innerText = Math.ceil(angkaSekarang + kecepatan);
            setTimeout(hitung, 20);
        } else {
            counter.innerText = target + "+";
        }
    };
    hitung();
});