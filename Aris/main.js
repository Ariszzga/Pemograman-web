/**
 * assets/js/main.js
 * Semua interaksi halaman utama: navbar (scroll + scroll-spy + mobile menu),
 * hero slider, counter statistik, newsletter AJAX, back-to-top.
 * Dibungkus dalam IIFE terpisah supaya satu modul error tidak mematikan modul lain.
 */

/* ---------------- NAVBAR ---------------- */
(function navbar() {
  const nav = document.getElementById('siteNav');
  const toggle = document.getElementById('navToggle');
  const navRight = document.getElementById('navRight');
  if (!nav) return;

  window.addEventListener('scroll', () => {
    nav.classList.toggle('scrolled', window.scrollY > 40);
  }, { passive: true });

  if (toggle && navRight) {
    toggle.addEventListener('click', () => {
      const isOpen = navRight.classList.toggle('open');
      toggle.setAttribute('aria-expanded', String(isOpen));
    });
  }

  const navLinks = document.querySelectorAll('.nav-link[data-section]');
  if (!navLinks.length) return;

  function setActive(sectionId) {
    navLinks.forEach((link) => {
      link.classList.toggle('current', link.dataset.section === sectionId);
    });
  }

  navLinks.forEach((link) => {
    link.addEventListener('click', () => {
      setActive(link.dataset.section);
      if (navRight) {
        navRight.classList.remove('open');
        toggle && toggle.setAttribute('aria-expanded', 'false');
      }
    });
  });

  const sections = [...navLinks]
    .map((link) => document.getElementById(link.dataset.section))
    .filter(Boolean);

  if (!sections.length) return;

  const observer = new IntersectionObserver(
    (entries) => {
      entries.forEach((entry) => {
        if (entry.isIntersecting) setActive(entry.target.id);
      });
    },
    { rootMargin: '-40% 0px -55% 0px', threshold: 0 }
  );

  sections.forEach((section) => observer.observe(section));
})();

/* ---------------- HERO SLIDER ---------------- */
(function heroSlider() {
  const slides = document.querySelectorAll('.hero-slide');
  const dotsContainer = document.getElementById('dots');
  const currentNum = document.getElementById('currentNum');
  const progress = document.getElementById('progress');
  const prevBtn = document.getElementById('prevBtn');
  const nextBtn = document.getElementById('nextBtn');

  if (!slides.length || !dotsContainer) return;

  let current = 0;
  let timer;

  slides.forEach((_, i) => {
    const dot = document.createElement('button');
    dot.type = 'button';
    dot.className = 'dot' + (i === 0 ? ' active' : '');
    dot.setAttribute('aria-label', `Ke slide ${i + 1}`);
    dot.addEventListener('click', () => goTo(i));
    dotsContainer.appendChild(dot);
  });

  function goTo(index) {
    slides[current].classList.remove('active');
    dotsContainer.children[current].classList.remove('active');
    current = (index + slides.length) % slides.length;
    slides[current].classList.add('active');
    dotsContainer.children[current].classList.add('active');
    if (currentNum) currentNum.textContent = String(current + 1).padStart(2, '0');
    resetProgress();
  }

  function resetProgress() {
    if (!progress) return;
    progress.style.transition = 'none';
    progress.style.width = '0%';
    requestAnimationFrame(() => {
      requestAnimationFrame(() => {
        progress.style.transition = 'width 5s linear';
        progress.style.width = '100%';
      });
    });
    clearInterval(timer);
    timer = setInterval(() => goTo(current + 1), 5000);
  }

  prevBtn && prevBtn.addEventListener('click', () => goTo(current - 1));
  nextBtn && nextBtn.addEventListener('click', () => goTo(current + 1));

  resetProgress();
})();

/* ---------------- COUNTER STATISTIK ---------------- */
(function statCounters() {
  const counters = document.querySelectorAll('.counter');
  if (!counters.length) return;

  function animate(el) {
    const finalText = el.dataset.final || el.textContent.trim();
    const match = finalText.match(/([\d.,]+)/);
    if (!match) return; // nilai non-numerik (mis. teks kosong), biarkan apa adanya

    const numericPart = parseFloat(match[1].replace(/\./g, '').replace(',', '.'));
    if (Number.isNaN(numericPart)) return;

    const prefix = finalText.slice(0, match.index);
    const suffix = finalText.slice(match.index + match[1].length);
    const isDecimal = finalText.includes(',') && match[1].split(',')[1]?.length;

    const duration = 1400;
    const start = performance.now();

    function step(now) {
      const progressRatio = Math.min((now - start) / duration, 1);
      const current = numericPart * progressRatio;
      const displayValue = isDecimal
        ? current.toFixed(1).replace('.', ',')
        : Math.round(current).toLocaleString('id-ID');
      el.textContent = `${prefix}${displayValue}${suffix}`;
      if (progressRatio < 1) requestAnimationFrame(step);
      else el.textContent = finalText;
    }
    requestAnimationFrame(step);
  }

  const io = new IntersectionObserver((entries, obs) => {
    entries.forEach((entry) => {
      if (entry.isIntersecting) {
        animate(entry.target);
        obs.unobserve(entry.target);
      }
    });
  }, { threshold: 0.4 });

  counters.forEach((c) => io.observe(c));
})();

/* ---------------- NEWSLETTER (AJAX) ---------------- */
(function newsletter() {
  const form = document.getElementById('newsletterForm');
  if (!form) return;

  const btn = document.getElementById('subscribeBtn');
  const success = document.getElementById('successMsg');
  const errorMsg = document.getElementById('errorMsg');
  const emailInput = document.getElementById('emailInput');

  form.addEventListener('submit', (e) => {
    e.preventDefault();
    const email = emailInput.value.trim();

    errorMsg.style.display = 'none';
    btn.textContent = 'Loading...';
    btn.disabled = true;

    fetch('backend/api/newsletter.php', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ email }),
    })
      .then((r) => r.json())
      .then((res) => {
        if (res.status === 'success') {
          form.style.display = 'none';
          success.style.display = 'block';
        } else {
          errorMsg.textContent = res.message || 'Terjadi kesalahan.';
          errorMsg.style.display = 'block';
          btn.textContent = 'Subscribe';
          btn.disabled = false;
        }
      })
      .catch(() => {
        errorMsg.textContent = 'Terjadi kesalahan jaringan, coba lagi.';
        errorMsg.style.display = 'block';
        btn.textContent = 'Subscribe';
        btn.disabled = false;
      });
  });
})();

/* ---------------- BACK TO TOP ---------------- */
(function backToTop() {
  const btn = document.getElementById('backToTop');
  if (!btn) return;

  window.addEventListener('scroll', () => {
    btn.classList.toggle('show', window.scrollY > 400);
  }, { passive: true });

  btn.addEventListener('click', () => {
    window.scrollTo({ top: 0, behavior: 'smooth' });
  });
})();

// (dijalankan setelah seluruh DOM siap)
fetch('backend/api/products.php')
  .then(r => r.json())
  .then(res => {
    const grid = document.getElementById('productsGrid');
    if (!grid || !res.data || res.data.length === 0) return;

    const items = res.data;
    const hero = items[0];
    const rest = items.slice(1);

    const rupiah = (n) => 'Rp' + parseInt(n).toLocaleString('id-ID');

    const heroHTML = `
      <div class="produk-hero">
        <img src="${hero.image_url}" alt="${hero.name}">
        <div class="produk-overlay">
          <h2>${hero.name}</h2>
          <p>Kerajinan anyaman khas Bali yang dibuat secara handmade oleh
             pengrajin lokal. Cocok digunakan sebagai perlengkapan upacara
             maupun dekorasi rumah.</p>
        </div>
      </div>
    `;

    const cardsHTML = rest.map(p => `
      <div class="produk-card">
        <img src="${p.image_url}" alt="${p.name}">
        <div class="produk-info">
          <h3>${p.name}</h3>
          <span>${rupiah(p.price)}</span>
        </div>
      </div>
    `).join('');

    grid.innerHTML = heroHTML + cardsHTML;
  })
  .catch(err => console.error('Gagal load produk:', err));
