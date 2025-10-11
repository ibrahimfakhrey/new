#!/usr/bin/env python3
"""
Insert Google Ads tag snippet into all HTML files (except index.html and index-en.html).
- Skips files that already contain the tag ID AW-17631507239
- Inserts the snippet immediately before the closing </head> tag (case-insensitive)
Usage:
  python3 add_gtag_snippet.py [root_directory]
If no directory is provided, the current working directory is used.
"""
import os
import re
import sys

def main():
    root = sys.argv[1] if len(sys.argv) > 1 else os.getcwd()
    excluded_basenames = {"index.html", "index-en.html"}

    snippet = (
        "  <!-- Google tag (gtag.js) -->\n"
        "  <script async src=\"https://www.googletagmanager.com/gtag/js?id=AW-17631507239\"></script>\n"
        "  <script>\n"
        "    window.dataLayer = window.dataLayer || [];\n"
        "    function gtag(){dataLayer.push(arguments);} \n"
        "    gtag('js', new Date());\n\n"
        "    gtag('config', 'AW-17631507239');\n"
        "  </script>\n"
    )

    updated = []
    skipped_existing = []
    skipped_excluded = []
    skipped_no_head = []

    for dp, dn, files in os.walk(root):
        for name in files:
            if not name.endswith(".html"):
                continue
            if name in excluded_basenames:
                skipped_excluded.append(os.path.join(dp, name))
                continue
            fpath = os.path.join(dp, name)
            try:
                with open(fpath, "r", encoding="utf-8") as f:
                    content = f.read()
            except Exception as e:
                print(f"Error reading {fpath}: {e}")
                continue

            if "AW-17631507239" in content:
                skipped_existing.append(fpath)
                continue

            # Insert before </head> (case-insensitive)
            new_content, n = re.subn(r"</head>", snippet + "\n</head>", content, flags=re.IGNORECASE)
            if n == 0:
                skipped_no_head.append(fpath)
                continue

            try:
                with open(fpath, "w", encoding="utf-8") as f:
                    f.write(new_content)
                updated.append(fpath)
            except Exception as e:
                print(f"Error writing {fpath}: {e}")

    print("Root:", root)
    print("Updated files:", len(updated))
    for p in updated:
        print(p)
    print("Skipped (already had tag):", len(skipped_existing))
    print("Skipped (excluded basenames):", len(skipped_excluded))
    print("Skipped (no </head> found):", len(skipped_no_head))
    if skipped_no_head:
        print("Note: These files do not contain a closing </head> tag and were left unchanged:")
        for p in skipped_no_head:
            print("  ", p)

if __name__ == "__main__":
    main()