<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>bday</title>
  <style>
    body {
      margin: 0;
      padding: 0;
      background: radial-gradient(ellipse at center, #10141c 0%, #0a0c10 100%);
      font-family: 'Segoe UI', sans-serif;
      color: #e6c373;
      overflow: hidden;
    }

    /* Starry Night Background */
    .stars {
      position: fixed;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      z-index: 1;
    }

    .star {
      position: absolute;
      background: radial-gradient(circle, #ffffff, #b88a44);
      border-radius: 50%;
      box-shadow: 0 0 6px #ffffff80, 0 0 10px #b88a4460;
      animation: twinkle var(--duration) infinite ease-in-out;
      opacity: var(--opacity);
    }

    @keyframes twinkle {
      0%, 100% { opacity: 0.2; }
      50% { opacity: 1; }
    }

    .scene {
      position: relative;
      width: 100vw;
      height: 100vh;
      display: flex;
      justify-content: center;
      align-items: center;
      perspective: 1200px;
      overflow: hidden;
      z-index: 2;
    }

    .floating-text {
      position: absolute;
      top: 8%;
      left: -100%;
      font-size: 2rem;
      color: #e6c373;
      font-weight: 600;
      text-shadow: 0 0 20px #b88a44aa;
      animation: floatAcross 15s linear infinite;
      z-index: 20;
    }

    @keyframes floatAcross {
      0% { left: -100%; opacity: 0; }
      10% { opacity: 1; }
      90% { opacity: 1; }
      100% { left: 100%; opacity: 0; }
    }

    .gift-container {
      position: relative;
      width: 240px;
      height: 200px;
      transform-style: preserve-3d;
      cursor: pointer;
      z-index: 10;
      margin-top: 120px;
    }

    .gift-container.hidden {
      display: none;
    }

    .box {
      width: 100%;
      height: 100%;
      background: #1a202c;
      border: 3px solid #ffffff9d;
      border-radius: 12px;
      box-shadow: 0 0 25px rgba(184, 138, 68, 0.3);
      position: relative;
      transform: rotateY(0);
    }

    .lid {
      position: absolute;
      top: -45px;
      left: -10px;
      width: 260px;
      height: 50px;
      background: linear-gradient(to right, #1a202c 0%, #ffffffcb 50%, #1a202c 100%);
      border: 3px solid #ffffff9d;
      border-radius: 10px;
      box-shadow: 0 0 15px #b88a4480;
      transform-origin: bottom center;
      animation: boxWiggle 1.5s ease-in-out infinite;
      z-index: 3;
    }

    @keyframes boxWiggle {
      0%, 100% { transform: rotate(0deg); }
      50% { transform: rotate(2deg); }
    }

    .poster {
      position: absolute;
      top: 50%;
      left: 50%;
      width: 180px;
      transform: translate(-50%, -50%) scale(0.8);
      opacity: 0;
      border-radius: 12px;
      box-shadow: 0 12px 30px rgba(0, 0, 0, 0.8);
      transition: all 1.2s ease-out;
      z-index: 1;
    }

    .poster.reveal {
      opacity: 1;
      transform: translate(-50%, -50%) scale(1.05);
      filter: drop-shadow(0 0 25px rgba(255, 255, 255, 0.15));
    }

    .birthday-message {
      position: absolute;
      top: 70%;
      left: 50%;
      transform: translateX(-50%);
      color: #ffffff9d;
      font-size: 1.5rem;
      text-align: center;
      text-shadow: 0 0 10px #ffffffcb;
      opacity: 0;
      transition: opacity 1s ease 1s;
      z-index: 5;
      width: 100%;
      max-width: 300px;
    }

    .reveal-message {
      opacity: 1;
    }

    .confetti {
      position: absolute;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      pointer-events: none;
      z-index: 30;
    }

    .confetti span {
      position: absolute;
      width: 8px;
      height: 8px;
      background: var(--color);
      top: 50%;
      left: 50%;
      animation: explode 1.5s ease-out forwards;
      opacity: 1;
    }

    @keyframes explode {
      to {
        transform: translate(var(--x), var(--y)) rotate(1080deg);
        opacity: 0;
      }
    }
  </style>
</head>
<body>
  <div class="stars" id="stars"></div>

  <div class="scene">
    <div class="floating-text"></div>

    <div class="gift-container" onclick="openGift()" id="gift">
      <div class="box">
        <div class="ribbon-vertical"></div>
        <div class="ribbon-horizontal"></div>
      </div>
      <div class="lid"></div>
    </div>

    <img id="poster" class="poster" src="https://m.media-amazon.com/images/M/MV5BNjE2Y2UyNmItZDQyZS00ZjE1LThmMWMtNTVmYzMxOTgwNmVlXkEyXkFqcGc@._V1_FMjpg_UX1000_.jpg" alt="The Shawshank Redemption" />

    <div class="birthday-message" id="message">
      happy birthday naj!<br>this movie is my treat!!
    </div>

    <div class="confetti" id="confetti"></div>
  </div>

  <script>
    function createStars() {
      const stars = document.getElementById('stars');
      const count = 400; // doubled from 200 to 400
  
      for (let i = 0; i < count; i++) {
        const star = document.createElement('div');
        star.classList.add('star');
  
        const size = Math.random() * 2.5 + 0.5; // smaller overall size range
        const x = Math.random() * 100;
        const y = Math.random() * 100;
        const duration = `${Math.random() * 4 + 2}s`;
        const opacity = Math.random() * 0.9 + 0.1;
  
        star.style.width = `${size}px`;
        star.style.height = `${size}px`;
        star.style.left = `${x}%`;
        star.style.top = `${y}%`;
        star.style.setProperty('--duration', duration);
        star.style.setProperty('--opacity', opacity);
  
        stars.appendChild(star);
      }
    }
  
    function openGift() {
      const gift = document.getElementById('gift');
      gift.classList.add('hidden');
  
      document.getElementById('poster').classList.add('reveal');
      document.querySelector('.floating-text').style.display = 'none';
  
      setTimeout(() => {
        document.getElementById('message').classList.add('reveal-message');
      }, 1000);
  
      launchConfetti();
    }
  
    function launchConfetti() {
      const container = document.getElementById('confetti');
      const colors = ['#b88a44', '#000000', '#c0c0c0'];
      for (let i = 0; i < 200; i++) {
        const span = document.createElement('span');
        const angle = Math.random() * 2 * Math.PI;
        const radius = Math.random() * 240;
        const x = Math.cos(angle) * radius + 'px';
        const y = Math.sin(angle) * radius + 'px';
        span.style.setProperty('--x', x);
        span.style.setProperty('--y', y);
        span.style.setProperty('--color', colors[Math.floor(Math.random() * colors.length)]);
        container.appendChild(span);
        setTimeout(() => span.remove(), 1500);
      }
    }
  
    window.onload = createStars;
  </script>
  
</body>
</html>
