#!/usr/bin/env python3
"""Compare Oracle vs PostgreSQL T_PRD_DO_RESULT CSV exports."""

import csv
import re
from collections import defaultdict

ORA_FILE = "/home/user/DOSYSTEM/ora_t_prd_do_result.csv"
PG_FILE = "/home/user/DOSYSTEM/pg_t_prd_do_result.csv"

# Composite key columns (uppercased)
KEY_COLS = [
    "FACTORY_CD", "PART_NO", "DIM", "SUPPLIER_CD", "RATIO",
    "CLASS", "LOGIC", "CD_SPLY_FACT", "PLAN_DATE", "PLAN_TIME",
    "DELIVERY_DATE", "DELIVERY_TIME", "RESULT"
]

def normalize_value(val, col_name=""):
    """Normalize a single value for comparison."""
    if val is None:
        return ""
    val = str(val).strip().strip('"')
    # NULL string -> empty
    if val.upper() == "NULL":
        return ""
    # Normalize decimals: "20.00" -> "20", "100.00" -> "100"
    # But keep actual fractional parts: "20.50" -> "20.5"
    if re.match(r'^-?\d+\.\d+$', val):
        try:
            f = float(val)
            if f == int(f):
                val = str(int(f))
            else:
                val = str(f)
        except ValueError:
            pass
    # Normalize date formats: "13-MAR-26" -> "2026-03-13", "2026-03-13 00:00:00" -> "2026-03-13"
    month_map = {
        'JAN': '01', 'FEB': '02', 'MAR': '03', 'APR': '04',
        'MAY': '05', 'JUN': '06', 'JUL': '07', 'AUG': '08',
        'SEP': '09', 'OCT': '10', 'NOV': '11', 'DEC': '12'
    }
    # Oracle format: DD-MON-YY (e.g., 13-MAR-26)
    m = re.match(r'^(\d{1,2})-([A-Z]{3})-(\d{2})$', val.upper())
    if m:
        day, mon, yr = m.groups()
        yr_full = "20" + yr if int(yr) < 80 else "19" + yr
        val = f"{yr_full}-{month_map.get(mon, '00')}-{int(day):02d}"
    # PG format: 2026-03-13 00:00:00
    m2 = re.match(r'^(\d{4}-\d{2}-\d{2})\s+\d{2}:\d{2}:\d{2}$', val)
    if m2:
        val = m2.group(1)
    return val


def load_csv(filepath, source_name):
    """Load CSV and return list of dicts with uppercased column names."""
    rows = []
    with open(filepath, 'r', encoding='utf-8') as f:
        reader = csv.DictReader(f)
        # Uppercase all field names
        reader.fieldnames = [fn.strip().strip('"').upper() for fn in reader.fieldnames]
        for row in reader:
            normalized = {}
            for col in reader.fieldnames:
                normalized[col] = normalize_value(row.get(col, ""), col)
            rows.append(normalized)
    print(f"Loaded {len(rows)} rows from {source_name} ({filepath})")
    return rows, reader.fieldnames


def make_key(row):
    """Create composite key tuple from a row."""
    return tuple(row.get(c, "") for c in KEY_COLS)


def main():
    print("=" * 80)
    print("T_PRD_DO_RESULT: Oracle vs PostgreSQL Comparison")
    print("=" * 80)
    print()

    ora_rows, ora_cols = load_csv(ORA_FILE, "Oracle")
    pg_rows, pg_cols = load_csv(PG_FILE, "PostgreSQL")

    # Check columns
    ora_col_set = set(ora_cols)
    pg_col_set = set(pg_cols)
    if ora_col_set != pg_col_set:
        print(f"\nColumn differences:")
        print(f"  In Oracle only: {ora_col_set - pg_col_set}")
        print(f"  In PG only:     {pg_col_set - ora_col_set}")
    else:
        print(f"\nColumns match: {len(ora_cols)} columns")

    all_cols = sorted(ora_col_set | pg_col_set)
    print()

    # Build key -> list of rows mappings (handle duplicate keys)
    ora_key_map = defaultdict(list)
    for i, row in enumerate(ora_rows):
        k = make_key(row)
        ora_key_map[k].append((i, row))

    pg_key_map = defaultdict(list)
    for i, row in enumerate(pg_rows):
        k = make_key(row)
        pg_key_map[k].append((i, row))

    ora_keys = set(ora_key_map.keys())
    pg_keys = set(pg_key_map.keys())

    only_ora = ora_keys - pg_keys
    only_pg = pg_keys - ora_keys
    common = ora_keys & pg_keys

    # ---- Missing in PG ----
    print("-" * 80)
    print(f"ROWS IN ORACLE BUT NOT IN PG (missing in PG): {sum(len(ora_key_map[k]) for k in only_ora)}")
    print("-" * 80)
    if only_ora:
        for k in sorted(only_ora):
            for idx, row in ora_key_map[k]:
                print(f"  Oracle row {idx+2}: key = {dict(zip(KEY_COLS, k))}")
                # Show non-key columns for context
                non_key = {c: row[c] for c in all_cols if c not in KEY_COLS and row.get(c, "")}
                if non_key:
                    print(f"    Other cols: {non_key}")
    else:
        print("  (none)")
    print()

    # ---- Extra in PG ----
    print("-" * 80)
    print(f"ROWS IN PG BUT NOT IN ORACLE (extra in PG): {sum(len(pg_key_map[k]) for k in only_pg)}")
    print("-" * 80)
    if only_pg:
        for k in sorted(only_pg):
            for idx, row in pg_key_map[k]:
                print(f"  PG row {idx+2}: key = {dict(zip(KEY_COLS, k))}")
                non_key = {c: row[c] for c in all_cols if c not in KEY_COLS and row.get(c, "")}
                if non_key:
                    print(f"    Other cols: {non_key}")
    else:
        print("  (none)")
    print()

    # ---- Common key differences ----
    print("-" * 80)
    print(f"COMMON KEYS: {len(common)} unique keys")
    print("-" * 80)

    diff_count = 0
    col_diff_summary = defaultdict(int)  # column -> count of differences

    # For common keys, check row count mismatches and column-level diffs
    count_mismatch = 0
    for k in sorted(common):
        ora_list = ora_key_map[k]
        pg_list = pg_key_map[k]

        if len(ora_list) != len(pg_list):
            count_mismatch += 1
            if count_mismatch <= 20:
                print(f"\n  KEY COUNT MISMATCH: Oracle has {len(ora_list)}, PG has {len(pg_list)}")
                print(f"    Key: {dict(zip(KEY_COLS, k))}")

        # Compare row-by-row (match by position within same key group)
        pairs = min(len(ora_list), len(pg_list))
        for p in range(pairs):
            ora_idx, ora_row = ora_list[p]
            pg_idx, pg_row = pg_list[p]
            diffs = []
            for col in all_cols:
                oval = ora_row.get(col, "")
                pval = pg_row.get(col, "")
                if oval != pval:
                    diffs.append((col, oval, pval))
                    col_diff_summary[col] += 1
            if diffs:
                diff_count += 1
                if diff_count <= 30:
                    print(f"\n  DIFF (Oracle row {ora_idx+2} vs PG row {pg_idx+2}):")
                    print(f"    Key: {dict(zip(KEY_COLS, k))}")
                    for col, oval, pval in diffs:
                        print(f"    {col}: Oracle='{oval}' vs PG='{pval}'")

    if count_mismatch > 20:
        print(f"\n  ... and {count_mismatch - 20} more key count mismatches")
    if diff_count > 30:
        print(f"\n  ... and {diff_count - 30} more row differences (showing first 30)")

    # ---- SUMMARY ----
    print()
    print("=" * 80)
    print("SUMMARY")
    print("=" * 80)
    print(f"  Oracle total rows:        {len(ora_rows)}")
    print(f"  PostgreSQL total rows:    {len(pg_rows)}")
    print(f"  Row difference:           {len(ora_rows) - len(pg_rows)}")
    print()
    print(f"  Unique keys in Oracle:    {len(ora_keys)}")
    print(f"  Unique keys in PG:        {len(pg_keys)}")
    print(f"  Keys only in Oracle:      {len(only_ora)} ({sum(len(ora_key_map[k]) for k in only_ora)} rows)")
    print(f"  Keys only in PG:          {len(only_pg)} ({sum(len(pg_key_map[k]) for k in only_pg)} rows)")
    print(f"  Common keys:              {len(common)}")
    print(f"  Key count mismatches:     {count_mismatch}")
    print(f"  Rows with column diffs:   {diff_count}")
    print()
    if col_diff_summary:
        print("  Column-level difference counts (across all common-key rows):")
        for col, cnt in sorted(col_diff_summary.items(), key=lambda x: -x[1]):
            print(f"    {col}: {cnt} differences")
    else:
        print("  No column-level differences in common-key rows.")
    print()
    print("=" * 80)


if __name__ == "__main__":
    main()
