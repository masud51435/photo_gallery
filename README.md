<h1 align="center">📸 Image Gallery App</h1>
<p align="center">
  A simple and elegant image gallery app built with Flutter, featuring smooth scrolling, offline data storage using Hive, and integration with the Unsplash API.
</p>
<p align="center">
  <img src="https://img.shields.io/badge/Flutter-v3.0.0-blue" alt="Flutter">
  <img src="https://img.shields.io/badge/GetX-v4.6.5-green" alt="GetX">
  <img src="https://img.shields.io/badge/Dio-v5.0.0-yellow" alt="Dio">
  <img src="https://img.shields.io/badge/Hive-v2.2.3-orange" alt="Hive">
</p>

---

<h2>📖 Overview</h2>
<p>
The Image Gallery App is a Flutter-based application that showcases images from the Unsplash API. It implements state management using GetX and ensures a smooth and intuitive user experience with offline data caching via Hive. The app dynamically loads images as users scroll and supports detailed photo views, image downloads, and sharing functionality.
</p>

---

<h2>🎯 Features</h2>
<ul>
  <li>✨ Fetch images from the <a href="https://unsplash.com/developers">Unsplash API</a></li>
  <li>📥 Caches data offline using <strong>Hive</strong> for faster subsequent loads</li>
  <li>🎨 Stunning grid layout with staggered image patterns</li>
  <li>🔍 Lazy loading and smooth scrolling for an optimized experience</li>
  <li>👁️ Full-screen image preview with <code>Hero</code> animations</li>
  <li>📤 <strong>Share</strong> images directly from the app</li>
  <li>⬇️ <strong>Download</strong> images to your device</li>
</ul>

---

<h2>🚀 Installation</h2>
<ol>
  <li>Clone the repository:</li>

  <pre><code>https://github.com/masud51435/photo_gallery.git</code></pre>

  <li>Navigate to the project directory:</li>

  <pre><code>cd image_gallery_app</code></pre>

  <li>Get the dependencies:</li>

  <pre><code>flutter pub get</code></pre>

  <li>Set up the Unsplash API Key:</li>
  <p>
    Open <code>lib/backend/api_keys.dart</code> and replace <code>'YOUR_API_KEY'</code> with your Unsplash API Key:
  </p>

  <pre><code>const String ApiKeys = 'YOUR_API_KEY';</code></pre>

  <li>Run the app:</li>

  <pre><code>flutter run</code></pre>
</ol>

---

<h2>📁 Folder Structure</h2>
<pre>
image_gallery_app/
├── lib/
│   ├── backend/           # API handling logic
│   │   ├── api_keys.dart
│   │   └── photo_service.dart
│   ├── controller/        # GetX controller for state management
│   │   └── photo_controller.dart
│   ├── features/          # UI screens
│   │   ├── gallery_screen.dart
│   │   └── photo_view_screen.dart
│   ├── model/             # Data models
│   │   └── photo_model.dart
│   └── main.dart          # App entry point
├── test/                  # Unit tests
│   └── photo_controller_test.dart
├── assets/                # Static assets (if any)
├── pubspec.yaml           # Dependencies and configurations
├── .gitignore             # Git ignore rules
├── README.md              # Project documentation
└── LICENSE                # License file
</pre>

---

<h2>🛠️ Technologies Used</h2>
<ul>
  <li><strong>Flutter</strong> - Cross-platform mobile app development</li>
  <li><strong>GetX</strong> - State management and navigation</li>
  <li><strong>Dio</strong> - Networking library</li>
  <li><strong>Hive</strong> - Local data storage</li>
  <li><strong>Unsplash API</strong> - Image data source</li>
  <li><strong>Shimmer</strong> - Loading animations</li>
</ul>

---

<h2>📜 License</h2>
<p>
This project is licensed under the <a href="https://opensource.org/licenses/MIT">MIT License</a>. Feel free to use and modify it as per your needs.
</p>

---

<h2>📧 Contact</h2>
<p>
For any inquiries or feedback, reach out via email at <strong>your-masudrana82955@gmail.com</strong> or connect with me on <a href="https://www.linkedin.com/in/masud-rana-582243227/">LinkedIn</a>.
</p>

