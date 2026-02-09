'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter.js": "76f08d47ff9f5715220992f993002504",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"manifest.json": "777679f298b2ae0a28b874a6bd9530ea",
"index.html": "c5ca035673c3f4cd4baa348c5c731697",
"/": "c5ca035673c3f4cd4baa348c5c731697",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin.json": "b1162d7946895cc526b3f8e49b8324ec",
"assets/assets/icons/home.svg": "26c79113afe6d1dbc67b9f1d93aa27b9",
"assets/assets/icons/completed.svg": "9e9a1e5bd6b95e694a8c83735155f6bd",
"assets/assets/icons/distance.svg": "574362900116eadb18030e8638c1e6cc",
"assets/assets/icons/delete.svg": "f88179ccc3649c47f2264315be6c0421",
"assets/assets/icons/shortlogo_light.svg": "b58f8e05dd8201ff8c78dfdd4e9e26e9",
"assets/assets/icons/immobile_ON.svg": "a5f5cc594eaf2e07e443bd1132017882",
"assets/assets/icons/alert.svg": "ad46e0e5d0d4d7caf533c2bb9a26b7ce",
"assets/assets/icons/resetpwd.svg": "b241dd200ebba644ba82dbeedf4cf712",
"assets/assets/icons/group.svg": "dc497cbfb372166bd393af1bee0ac4f1",
"assets/assets/icons/ongoing.svg": "08c7b9f364fdcf67b3a3da72b75edcf6",
"assets/assets/icons/shortlogo_dark.svg": "0f1713e65981fdd6728ed0b49afefb9d",
"assets/assets/icons/key.svg": "8f1b93e8a2148cfbda2fc5165d6fadaf",
"assets/assets/icons/arrow.svg": "63e7b9f2d3e899f6ee5edba66ebf6d8a",
"assets/assets/icons/summary.svg": "d75066d3dc67161c0c7cfe31b44d2fd7",
"assets/assets/icons/driver.svg": "74da7d8921210b93e66795264651048b",
"assets/assets/icons/language.svg": "f9888dd17a30b79665a0abbc604cef3b",
"assets/assets/icons/fuel.svg": "e8d7f36b366c82fbf255a21a4a6c8987",
"assets/assets/icons/geofence.svg": "a7aa86e282ad2289228d79aa0136114e",
"assets/assets/icons/business.svg": "c8c07d8d28e7947c34311dc7d6e5b70c",
"assets/assets/icons/trip.svg": "e0fea42c504a4c7a4fa55941c847fc3d",
"assets/assets/icons/dashboard.svg": "f74fa54003f05afe63813ffa6559abd9",
"assets/assets/icons/time.svg": "a8b79edfc37cb30ce161fa03681f572d",
"assets/assets/icons/maintenance.svg": "fd7e230b424f5ba39aff50a92f6cf334",
"assets/assets/icons/user.svg": "836e296c1af6485c3bbea800fc9d3299",
"assets/assets/icons/consumedhours.svg": "5ccce444f683383563a9c1fdbb4cc14d",
"assets/assets/icons/monitoring.svg": "288b1b0306138be4e6260b8e6cc4195b",
"assets/assets/icons/tracking.svg": "b22ab96a40b50c68b8a0fe90160c6009",
"assets/assets/icons/commands.svg": "c3859a07f73c6fade1ccd50fb376a21f",
"assets/assets/icons/flagged.svg": "9ef07266e38cbadce0517fb2a1bc5fb1",
"assets/assets/icons/notify.svg": "1b77380abe23a17bdbd5e9197abbf5b6",
"assets/assets/icons/car.svg": "95407180a5fcd8c9e05fa91c16af77b7",
"assets/assets/icons/edit.svg": "c7304c0ed93c9282809556c44f0504a3",
"assets/assets/icons/expand.svg": "577c53fea1fc31a441dd7dcec38deca7",
"assets/assets/icons/sun.svg": "b7d2d59e4c4615ca462774a0292ae819",
"assets/assets/icons/battery.svg": "5db94623c932db5234a30aa2f352fefc",
"assets/assets/icons/settings.svg": "cde9463c5008a6273825a91d149fd3d8",
"assets/assets/icons/alerts.svg": "bb71d97d78ecdf44fb201b066c7d9c16",
"assets/assets/icons/immobilize_ON.svg": "e4f7939af6cf0182169debba9a133ed7",
"assets/assets/icons/avatar.svg": "3622af021ae258dcd1af9b7f372cc0af",
"assets/assets/icons/odo.svg": "a2d06ef52a914f9d086f2866cc9ebd64",
"assets/assets/icons/sale.svg": "0b938c6f76c06bcf230fb6f0a1c52049",
"assets/assets/icons/zoomin.svg": "9eac9c63f112c47935fdd8a22bc0b732",
"assets/assets/icons/moon.svg": "824f036d21bfaf63ec9eb0f8f80bbe58",
"assets/assets/icons/zoomout.svg": "99a616a1b1c41dae06a9c2e0b9797883",
"assets/assets/icons/filter.svg": "4c8d09535803d952dbef330452868edb",
"assets/assets/icons/reports.svg": "0343a7b0bacec10dd259b39f7471d0a0",
"assets/assets/icons/struck1.svg": "2d587f6b97da528ded8d0b43002ad02c",
"assets/assets/icons/enterprise.svg": "e4cafe431a3023ec3f6c9ce379531aae",
"assets/assets/icons/miscellaneous.svg": "ec6908f35f45b8c989da4f4c2235633d",
"assets/assets/icons/device.svg": "035e8e92b11b1bf85486e781b478a75c",
"assets/assets/icons/hybrid.svg": "23e9246cefdcc0507c72be1e936040b1",
"assets/assets/images/truck1.png": "1e54e4275e4625122d91565cabc7b929",
"assets/assets/images/no_details.svg": "314ef5b9bf3e92e9df4c7e1240f9b906",
"assets/assets/gifs/loading.json": "3b5b5ddc391cca7e62bf53af2796991e",
"assets/assets/gifs/loading1.json": "d40b0ed75d0a32138d90cd7d154503cb",
"assets/fonts/MaterialIcons-Regular.otf": "ef8945c0e7f1d29a695c121ee8af3dd1",
"assets/NOTICES": "ca3ce4a3784a6f6e45344f0178043a4c",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "4351fab7478f5c18b3ab71991d106603",
"assets/packages/flutter_map/lib/assets/flutter_map_logo.png": "208d63cc917af9713fc9572bd5c09362",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/AssetManifest.bin": "f1cde84766df0c6f3723d35500137091",
"assets/AssetManifest.json": "1694a0267799562f4f038ad21b05277b",
"canvaskit/skwasm_st.wasm": "56c3973560dfcbf28ce47cebe40f3206",
"canvaskit/chromium/canvaskit.wasm": "64a386c87532ae52ae041d18a32a3635",
"canvaskit/chromium/canvaskit.js": "34beda9f39eb7d992d46125ca868dc61",
"canvaskit/chromium/canvaskit.js.symbols": "5a23598a2a8efd18ec3b60de5d28af8f",
"canvaskit/skwasm_st.js": "d1326ceef381ad382ab492ba5d96f04d",
"canvaskit/skwasm_st.js.symbols": "c7e7aac7cd8b612defd62b43e3050bdd",
"canvaskit/skwasm.js": "f2ad9363618c5f62e813740099a80e63",
"canvaskit/canvaskit.wasm": "efeeba7dcc952dae57870d4df3111fad",
"canvaskit/canvaskit.js": "86e461cf471c1640fd2b461ece4589df",
"canvaskit/skwasm.wasm": "f0dfd99007f989368db17c9abeed5a49",
"canvaskit/canvaskit.js.symbols": "68eb703b9a609baef8ee0e413b442f33",
"canvaskit/skwasm.js.symbols": "80806576fa1056b43dd6d0b445b4b6f7",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter_bootstrap.js": "28af44e97d71f18debfd71c60a3e876d",
"version.json": "3e1002508768f2f73ed1a8edbe5544b3",
"main.dart.js": "8dc2b235dc0cadbfef891cb36d44114e"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
