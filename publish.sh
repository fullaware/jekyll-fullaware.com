git add -A
git commit -m "Updated postings"
git push
bundle exec jekyll build --destination ../www.fullaware.com/
cd ../www.fullaware.com/
git add -A
git commit -m "Updated postings"
git push
