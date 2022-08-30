if [[ "x$_NENO_ENVSETUP" == "x" ]]; then
  echo "Getting ready!"
  git pull --rebase >/dev/null
  export _NENO_ENVSETUP=progress
  source envsetup.sh
else
  unset _NENO_ENVSETUP
  export NENO_ROOT="$(pwd)"
  if [[ ! -d "$(pwd)/depot_tools" ]]; then
    git clone https://github.com/nift4/chromium.git --depth 1 -b neno_build/depot_tools depot_tools >/dev/null
  else
    cd depot_tools
    git config --local advice.detachedHead false
    git fetch origin neno_build/depot_tools --depth 1 >/dev/null
    git checkout FETCH_HEAD >/dev/null
    git branch -D neno_build/depot_tools >/dev/null
    git checkout neno_build/depot_tools >/dev/null
    cd - >/dev/null
  fi
  export PATH="$PATH:$(pwd)/depot_tools"
  echo "To download source:"
  echo "  fetch android"
  echo "  gclient sync --with_branch_heads --with_tags"
  echo "  cd src"
  echo "  git checkout neno2"
  echo
  echo "To update source (from src/ directory):"
  echo "  gclient sync --with_branch_heads --with_tags"
  echo
  echo "To build (from src/ directory):"
  echo "  gn gen out/neno"
  echo "  ninja -C out/neno chrome_public_apk"
  echo
  echo "Enjoy!"
  echo "~ nift4"
fi
