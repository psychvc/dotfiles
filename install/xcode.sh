init_xcode () {
  if test -f ${HOMEBREW_CACHE}/Cask/xcode*.xip; then
    p="Installing Xcode"
    dest="${HOMEBREW_CACHE}/Cask/xcode"
    if ! test -d "$dest"; then
      xip --expand-full ${HOMEBREW_CACHE}/Cask/xcode*.xip "$dest"
      curl --location --silent \
        "https://gist.githubusercontent.com/pudquick/ff412bcb29c9c1fa4b8d/raw/24b25538ea8df8d0634a2a6189aa581ccc6a5b4b/parse_pbzx2.py" | \
        python3 - "${dest}/Content"
      find "${dest}" -empty -name "*.xz" -type f -print0 | \
        xargs -0 -l 1 rm
      find "${dest}" -name "*.xz" -print0 | \
        xargs -0 -L 1 gunzip
      cat ${dest}/Content.part* > \
        ${dest}/Content.cpio
    fi
    cd /Applications && \
      sudo cpio -dimu --file=${dest}/Content
    for pkg in /Applications/Xcode*.app/Contents/Resources/Packages/*.pkg; do
      sudo installer -pkg "$pkg" -target /
    done
    x="$(find '/Applications' -maxdepth 1 -regex '.*/Xcode[^ ]*.app' -print -quit)"
    if test -n "${x}"; then
      sudo xcode-select -s "${x}"
      sudo xcodebuild -license accept
    fi
  fi
}
