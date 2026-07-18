(function () {
  "use strict";

  window.onload = function () {
    // Header Sticky
    const getHeaderId = document.getElementById("navbar");
    if (getHeaderId) {
      window.addEventListener("scroll", (event) => {
        const height = 200;
        const { scrollTop } = event.target.scrollingElement;
        document
          .querySelector("#navbar")
          .classList.toggle("sticky", scrollTop >= height);
      });
    }

    // Back to Top JS
    const getId = document.getElementById("backtotop");
    if (getId) {
      const topbutton = document.getElementById("backtotop");
      topbutton.onclick = function (e) {
        window.scrollTo({ top: 0, behavior: "smooth" });
      };
      window.onscroll = function () {
        if (
          document.body.scrollTop > 200 ||
          document.documentElement.scrollTop > 200
        ) {
          topbutton.style.opacity = "1";
        } else {
          topbutton.style.opacity = "0";
        }
      };
    }

    // Preloader JS
    const getPreloaderId = document.getElementById("preloader");
    if (getPreloaderId) {
      getPreloaderId.style.display = "none";
    }
  };

  // Text Limit
  const paragraphs = document.querySelectorAll(".text_limit"); // Select all paragraphs with class
  paragraphs.forEach((paragraph) => {
    const fullText = paragraph.textContent.trim();
    const words = fullText.split(/\s+/);
    const limit = 20;

    if (words.length > limit) {
      const shortText = words.slice(0, limit).join(" ") + "...";
      paragraph.innerHTML = `${shortText} <span class="less-show-btn">Show</span>`;
      let expanded = false;

      paragraph.addEventListener("click", (e) => {
        if (e.target.classList.contains("less-show-btn")) {
          expanded = !expanded;

          if (expanded) {
            paragraph.innerHTML = `${fullText} <span class="less-show-btn">Less</span>`;
          } else {
            paragraph.innerHTML = `${shortText} <span class="less-show-btn">Show</span>`;
          }
        }
      });
    }
  });

  // Services BG Hover Animation JS
  const cards = document.querySelectorAll(".services-single-item");
  let activeCard = null;
  cards.forEach((card) => {
    const liquid = document.createElement("span");
    liquid.classList.add("liquid");
    card.appendChild(liquid);

    card.addEventListener("mouseenter", (e) => {
      // Remove previous active card
      if (activeCard && activeCard !== card) {
        activeCard.classList.remove("active");
        const prevLiquid = activeCard.querySelector(".liquid");
        prevLiquid.style.transform = "scale(0)";
        prevLiquid.style.opacity = "0";
      }

      // Set new active card
      activeCard = card;
      card.classList.add("active");

      const rect = card.getBoundingClientRect();
      const x = e.clientX - rect.left;
      const y = e.clientY - rect.top;

      liquid.style.left = `${x}px`;
      liquid.style.top = `${y}px`;
      liquid.style.transform = "scale(80)";
      liquid.style.opacity = "1";
    });

    card.addEventListener("mouseleave", (e) => {
      // Keep it active if needed — or uncomment below to remove after leave:
      // card.classList.remove('active');
      // liquid.style.transform = 'scale(0)';
      // liquid.style.opacity = '0';
    });
  });

  // Odometer JS
  if ("IntersectionObserver" in window) {
    let counterObserver = new IntersectionObserver(function (
      entries,
      observer,
    ) {
      entries.forEach(function (entry) {
        if (entry.isIntersecting) {
          let counter = entry.target;
          let target = parseInt(counter.innerText, 10); // ✅ Added radix 10
          let step = target / 200;
          let current = 0;
          let timer = setInterval(function () {
            current += step;
            counter.innerText = Math.floor(current);
            if (parseInt(counter.innerText, 10) >= target) {
              // ✅ Added radix 10
              clearInterval(timer);
            }
          }, 10);
          counterObserver.unobserve(counter);
        }
      });
    });
    let counters = document.querySelectorAll(".counter");
    counters.forEach(function (counter) {
      counterObserver.observe(counter);
    });
  }

  // Partner Slide JS
  var swiper = new Swiper(".partner-slide", {
    slidesPerView: 1,
    spaceBetween: 30,
    centeredSlides: false,
    preventClicks: true,
    loop: false,
    autoHeight: true,
    autoplay: {
      delay: 5000,
      disableOnInteraction: false,
      pauseOnMouseEnter: true,
    },
    pagination: {
      clickable: true,
    },
    breakpoints: {
      0: {
        slidesPerView: 2,
      },
      475: {
        slidesPerView: 3,
      },
      768: {
        slidesPerView: 4,
      },
      992: {
        slidesPerView: 5,
      },
      1200: {
        slidesPerView: 5,
      },
      1600: {
        slidesPerView: 6,
      },
    },
  });

  // Testimonial Slide JS
  var swiper = new Swiper(".testimonial-slide", {
    slidesPerView: 1,
    spaceBetween: 0,
    centeredSlides: false,
    preventClicks: true,
    loop: false,
    autoHeight: true,
    autoplay: {
      delay: 5000,
      disableOnInteraction: false,
      pauseOnMouseEnter: true,
    },
    pagination: {
      el: ".swiper-pagination-testimonial",
      clickable: true,
    },
  });

  // Case Study Mouse Hover JS
  const serviceImgItem = document.querySelectorAll(
    ".case-study-single-item-two",
  );
  function followImageCursor(event, serviceImgItem) {
    const contentBox = serviceImgItem.getBoundingClientRect();
    const dx = event.clientX - contentBox.x;
    const dy = event.clientY - contentBox.y;
    serviceImgItem.children[3].style.transform = `translate(${dx}px, ${dy}px)`;
  }
  serviceImgItem.forEach((item, i) => {
    item.addEventListener("mousemove", (event) => {
      setInterval(followImageCursor(event, item), 1000);
    });
  });

  // Banner Slide JS
  var swiper = new Swiper(".banner-slide", {
    slidesPerView: 1,
    spaceBetween: 0,
    centeredSlides: false,
    preventClicks: true,
    loop: false,
    autoHeight: true,
    effect: "fade",
    speed: 1000,
    autoplay: {
      delay: 5000,
      disableOnInteraction: false,
      pauseOnMouseEnter: true,
    },
    pagination: {
      el: ".swiper-pagination-banner",
      clickable: true,
    },
  });

  // Case Study Slide JS
  var swiper = new Swiper(".case-study-slide", {
    slidesPerView: 1,
    spaceBetween: 30,
    centeredSlides: false,
    preventClicks: true,
    loop: false,
    autoHeight: true,
    autoplay: {
      delay: 5000,
      disableOnInteraction: false,
      pauseOnMouseEnter: true,
    },
    pagination: {
      clickable: true,
      el: ".swiper-pagination-case-study",
    },
    breakpoints: {
      0: {
        slidesPerView: 1,
      },
      576: {
        slidesPerView: 1,
      },
      768: {
        slidesPerView: 2,
      },
      992: {
        slidesPerView: 3,
      },
      1200: {
        slidesPerView: 4,
      },
    },
  });

  // Ukiyo.js
  const parallax = new Ukiyo(".ukiyo", {
    externalRAF: true,
  });

  //smooth scroll
  const lenis = new Lenis({
    duration: 0.75,
    smoothWheel: true,
    smoothTouch: false,
  });

  // animate
  function raf(time) {
    parallax.animate();

    lenis.raf(time);
    requestAnimationFrame(raf);
  }
  requestAnimationFrame(raf);

  // ScrollCue JS
  scrollCue.init();

  // Only For Light & Dark
  const toggleButton = document.getElementById("for-light-dark");
  if (toggleButton) {
    const savedMode = localStorage.getItem("for_mode");

    // Apply saved mode on load
    if (savedMode) {
      document.body.setAttribute("for-dark-light-data-mode", savedMode);
      toggleButton.textContent =
        savedMode === "for-dark" ? "Switch To Light" : "Switch To Dark";
    } else {
      document.body.setAttribute("for-dark-light-data-mode", "for-light");
      toggleButton.textContent = "Switch To Dark";
    }

    // Add event listener
    toggleButton.addEventListener("click", () => {
      const currentMode = document.body.getAttribute(
        "for-dark-light-data-mode",
      );
      const newMode = currentMode === "for-dark" ? "for-light" : "for-dark";

      document.body.setAttribute("for-dark-light-data-mode", newMode);
      localStorage.setItem("for_mode", newMode);

      toggleButton.textContent =
        newMode === "for-dark" ? "Switch To Light" : "Switch To Dark";
    });
  }

  // Only For RTL & LTR
  try {
    function setMode(modeName) {
      localStorage.setItem("for_rtl", modeName);
      document.documentElement.className = modeName;

      // Update button text dynamically
      const btn = document.getElementById("rtlToggleBtn");
      if (btn) {
        btn.textContent =
          modeName === "rtl" ? "Switch To LTR" : "Switch To RTL";
      }
    }

    function toggleMode() {
      if (localStorage.getItem("for_rtl") === "rtl") {
        // ✅ fixed strict equality
        setMode("ltr");
      } else {
        setMode("rtl");
      }
    }

    // Run on load
    (function () {
      if (localStorage.getItem("for_rtl") === "rtl") {
        // ✅ fixed strict equality
        setMode("rtl");
      } else {
        setMode("ltr");
      }

      // Add event listener instead of onclick
      const btn = document.getElementById("rtlToggleBtn");
      if (btn) {
        btn.addEventListener("click", toggleMode);
      }
    })();
  } catch (e) {}

  // Select all buttons with the class 'like-button' Favorite Button
  document.querySelectorAll(".slide-active").forEach((button) => {
    // Add click event listener to each button
    button.addEventListener("click", () => {
      // Toggle 'liked' class
      button.classList.toggle("active");
    });
  });

  // Close modal if click is outside the input
  const getCloseModalId = document.getElementById("staticBackdrop");
  if (getCloseModalId) {
    document.addEventListener("click", function (e) {
      const modal = document.querySelector("#staticBackdrop");
      const input = document.querySelector("#searchInput");

      if (modal.classList.contains("show")) {
        // if click is inside input → do nothing
        if (input.contains(e.target)) return;

        // if click is inside modal-content → prevent closing only for input
        if (
          modal.querySelector(".modal-content").contains(e.target) &&
          !input.contains(e.target)
        ) {
          bootstrap.Modal.getInstance(modal).hide();
        }
      }
    });
  }
})();

// For Mobile Navbar JS
const list = document.querySelectorAll(".mobile-menu-list");
function accordion(e) {
  e.stopPropagation();
  if (this.classList.contains("active")) {
    this.classList.remove("active");
  } else if (this.parentElement.parentElement.classList.contains("active")) {
    this.classList.add("active");
  } else {
    for (i = 0; i < list.length; i++) {
      list[i].classList.remove("active");
    }
    this.classList.add("active");
  }
}
for (i = 0; i < list.length; i++) {
  list[i].addEventListener("click", accordion);
}
