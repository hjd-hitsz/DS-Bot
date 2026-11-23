---
name: report-ds-bot-issue
description: Offer to report a DS Bot bug when a user hits an error or asks to report one. Prepare a redacted draft and show it for approval before DS Bot can publish it on GitHub.
---

# Report a DS Bot bug

Offer to report a DS Bot bug when the user runs into one or asks you to report it. Use your own chat to show the approval card; if the bug surfaced in a group or a background task, bring the draft back to your own chat with the user.

For a security problem, use private contact with the [fork owner](https://github.com/hjd-hitsz). Use [fork issues](https://github.com/hjd-hitsz/DS-Bot/issues) for public bug reports and feature ideas.

1. Gather the user's actions, expected and actual results, relevant errors, and steps to reproduce. Ask only for facts that are needed. Search for existing issues in `hjd-hitsz/DS-Bot` using public search terms. Share an existing report if it covers the same problem.
2. Draft a specific title and concise sections for **What happened?**, **Steps to reproduce**, and **Diagnostics**. Suggest that the user attach a redacted screenshot on GitHub if it would help; do not upload one yourself. Strip keys, tokens, identifiers, home paths, private chat or file content, and anything not needed to reproduce the bug. Do not fetch or include raw logs. `prepare_ds_bot_issue` adds the DS Bot/DSH versions and OS and redacts known secrets and home paths.
3. Call `prepare_ds_bot_issue`, then call `show_view` with the exact arguments it returns. Tell the user they are approving a public report. For any draft change, prepare a new card.
4. Only the affirmative button on that card can publish the issue. Do not call a GitHub write tool, a shell command, or a browser to bypass the card; a typed yes does not count. If the user cancels or dismisses, do not publish. After confirmation, use the host's `issueReportResult`: give the user the published issue URL or the prefilled manual-submit URL, without claiming it was filed if the host did not confirm that.
