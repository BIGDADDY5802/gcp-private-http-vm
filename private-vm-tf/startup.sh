#!/bin/bash
apt update -y
apt install -y apache2
cat <<'EOF' > /var/www/html/index.html
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8"/>
  <title>SEIR Lab Node</title>
  <style>
    body {
      background-color: black;
      color: lime;
      font-family: monospace;
      max-width: 800px;
      margin: 40px auto;
      padding: 24px;
    }
    h1 {
      color: lime;
      border-bottom: 1px solid lime;
      padding-bottom: 10px;
    }
    pre {
      font-size: 14px;
      line-height: 1.2;
    }
    p {
      font-size: 15px;
      margin: 8px 0;
    }
    img.gif {
      display: block;
      margin: 20px 0;
      border: 1px solid lime;
      max-width: 100%;
    }
  </style>
</head>
<body>
  <h1>SEIR Infrastructure Node Online</h1>
  <pre>
                ▄████████████████████████▄
             ▄████████████████████████████▄
           ▄████████████████████████████████▄
          ████████████████████████████████████
         ██████████████████████████████████████
        ████████████████████████████████████████
        ████████████████████████████████████████
        ████████████████████████████████████████
         ██████████████████████████████████████
          ████████████████████████████████████
           ██████████████████████████████████
            ████████████████████████████████
              ████████████████████████████
                ████████████████████████
                 ██████████████████████
                  ████████████████████
                    ████████████████
                      ████████████
                        ████████
                          ████
  </pre>
  <p>The infrastructure is operational.</p>
  <p>Terraform is watching.</p>
  <p>Do not anger the state file — or this is your future wife.</p>
  <img class="gif" src="https://media.giphy.com/media/U2OtLSzLYujRK/giphy.gif" alt="your future wife"/>
  <p>Still not convinced? Have you considered the alternative?</p>
  <img class="gif" src="https://media.giphy.com/media/ZpHo8PxOtUTU4/giphy.gif" alt="the alternative"/>
</body>
</html>
EOF
systemctl enable apache2
systemctl restart apache2