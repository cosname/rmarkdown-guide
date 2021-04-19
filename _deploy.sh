#!/bin/sh

set -e

[ "${BRANCH}" != "master" ] && exit 0

git config --global user.email "xie@yihui.name"
git config --global user.name "Yihui Xie"

git clone -b gh-pages https://github.com/${REPO}.git book-output
cd book-output

ls | xargs rm -rf
git ls-files --deleted -z | xargs -0 git rm

cp -r ../_book/* ./
git add --all *
git commit -m "Update the book" || true
git reset $(git commit-tree HEAD^{tree} -m "Update the book")
git push -f -q origin gh-pages
