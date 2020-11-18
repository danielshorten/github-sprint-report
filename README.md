# GitHub Sprint Report

Download a comma-separated values report about issues tagged with `sprint` in multiple repositories.

## Prerequisites
1. Install `hub` (https://github.com/github/hub)

    `brew install hub`
2. Create a GitHub personal access token to allow `hub` to access your repos (https://github.com/settings/tokens)
3. Create a config file for hub at `~/.config/hub`:

    ```
    github.com:
    - user: <username>
      oauth_token: "<token>"
      protocol: https
    ```

## Installation
2. Clone this repository
3. Ensure the report script is executable
    
    `chmod 755 report.sh`
4. (Recommended) Set up a shell profile to add the `report.sh` script to your `PATH`
    
    `export PATH=$HOME/src/github-sprint-report:$PATH`
5. (Recommended) Add an alias to generate a sprint report

    `alias sprint-report="report.sh Retriever Rover Spiders machine-learning"
    In this example, all the repositories with sprint issues are checked out in the same directory.  The
    script will iterate through each subdirectory and output a report for all of the issues tagged with `sprint`
