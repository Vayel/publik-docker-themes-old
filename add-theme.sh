#!/bin/bash

set -eu

if [ "$#" -ne 2 ]; then
  echo "Illegal number of parameters"
  echo "Help: ./add-theme.sh SLUG TITLE"
  echo "Examples:"
  echo '  ./add-org.sh lyon Lyon'
  exit 1
fi

export SLUG=$1
export TITLE="$2"
THEME_DIR="$SLUG"

if [ -d "$THEME_DIR" ]; then
  echo "Theme $THEME_DIR already exists"
  exit 1
fi

echo "Creating theme in $THEME_DIR..."
mkdir -p $THEME_DIR
cp -R publik-base/* $THEME_DIR
sed -i "s/Publik/$TITLE/g" "$THEME_DIR/desc.xml"
sed -i "s/publik-base/$SLUG/g" "$THEME_DIR/desc.xml"
sed -i "s/publik/$SLUG/g" "$THEME_DIR/themes.json"
sed -i "s/Publik/$TITLE/g" "$THEME_DIR/themes.json"
mv "$THEME_DIR/static/publik" "$THEME_DIR/static/$SLUG"
