String getIosTutorialHTML(
    String link, String title, String? description, String imageUrl,
    {String? shareButtonDescription,
    String? addToHomescreenButtonDescription,
    String? tutorialBackgroundColor,}) {
  return '''
      <html>
      <head>
        <title>$title</title>
        <meta name="apple-mobile-web-app-capable" content="yes">
        <meta name="apple-mobile-web-app-status-bar-style" content="#ffffff">
        <meta name="apple-mobile-web-app-title" content="$title">
        <link rel="apple-touch-icon" href="$imageUrl">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <style>
          * {
              box-sizing: border-box;
              font-family: Arial, Helvetica, sans-serif;
          }
          html, body {
              height: 100%;
              margin: 0;
          }
          body {
              background-color: ${tutorialBackgroundColor ?? '#FFF'};
          }
          .container {
              display: flex;
              height: 100%;
              flex-direction: column;
              align-items: center;
              justify-content: space-evenly;
          }
          .header {
              display: flex;
              flex-direction: column;
              align-items: center;
          }
          .logo {
              height: 36vw;
              width: 36vw;
              border-radius: 16px;
          }
          .instruction-image {
              width: 100%;
              padding: 0 .6em;
              border-radius: 16px;
          }
          .description {
              opacity: .6;
              text-align: center;
          }
      </style>
      </head>
        <body>
          <a id="redirect" href="$link"></a>
        </body>
        
        <template id="instructions-template">
        <div class="container">
          <div class="header">
              <img class="logo" src="$imageUrl">
              <h3 class="title">$title</h3>
              <p class="description">
                  ${description ?? ''}
              </p>
          </div>
          ${shareButtonDescription ?? '1. Click the share button'}
          <img class="instruction-image" src="data:image/webp;base64,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">
          ${addToHomescreenButtonDescription ?? '2. Add the page to your home screen'}
          <img class="instruction-image share-image" src="data:image/webp;base64,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">
        </div>
    </template>
      </html>
      <script type="text/javascript">
        const redirect = document.getElementById('redirect');
        const template = document.querySelector('template');
        if (window.navigator.standalone) {
            var event = document.createEvent('MouseEvents');
            event.initEvent('click', true, true, document.defaultView, 1, 0, 0, 0, 0, false, false, false, false, 0, null);
            setTimeout(function() { redirect.dispatchEvent(event); }, 25);
        } else {
            redirect.hidden = true;
            document.body.appendChild(template.content.cloneNode(true));
        }
      </script>
    ''';
}
