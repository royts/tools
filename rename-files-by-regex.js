'use strict';

const fs = require('fs'),
  p = require('path');

const PATH = '/Users/roy-work/videos/python-fundamentals';

const files = fs.readdirSync(PATH);
for (const file of files) {
  const matches = file.match(/.*-m([0-9]*)-.*-([0-9].*)\.mp4/);
  const module = matches[1];
  const episode = matches[2];
  if (!(module && episode)) {
    continue;
  }
  const newName = `m${module}-e${episode}-${file}`;
  fs.renameSync(p.join(PATH, file), p.join(PATH, newName));
}
