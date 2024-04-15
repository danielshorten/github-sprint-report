mkdir -p reports

# This works in macOS on zsh
START_DATE=`printf $(date -v-30d +%F)`

for REPO in "AdRetriever" "Spiders"
do
    gh issue list --state=all --limit 1000 --repo AdRetriever/$REPO --search 'label:issue,bug created:>2024-03-15 ' --json=number,title,labels,createdAt,closedAt,projectItems,id > reports/$REPO
done

python scripts/stats.py
