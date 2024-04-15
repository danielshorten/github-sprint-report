from datetime import datetime, timedelta
from functools import reduce
import json
from os import walk, path
import pytz

def is_critical(issue):
    def critical_label(label):
        return label["name"] == "critical"
        
    return any([critical_label(label) for label in issue["labels"]])

issues = []
for filename in next(walk("reports"), (None, None, []))[2]:
    with open(path.join("reports", filename), "r") as file:
        issues.extend(json.load(file))

critical_issues = [
    issue for issue in issues if is_critical(issue)
]

def time_to_fix_avg(issues):
    total_seconds = 0
    for issue in issues:
        created_at = datetime.fromisoformat(issue["createdAt"].replace("Z", "+00:00"))
        closed_at = datetime.fromisoformat(issue["closedAt"].replace("Z", "+00:00")) if issue["closedAt"] else datetime.now(pytz.utc)
        time_to_fix = closed_at - created_at
        total_seconds += time_to_fix.total_seconds()
    
    return timedelta(seconds=total_seconds/len(issues))

print(f"""
ISSUES: {len(issues)}
CRITICAL: {len(critical_issues)}
AVG. TIME TO FIX: {time_to_fix_avg(issues)}
AVG. CRITICAL TIME TO FIX: {time_to_fix_avg(critical_issues)}
""")