#!/usr/bin/env python3
"""
GB2MIDI - Apple Silicon friendly rewrite (no dependencies).
Converts GarageBand loop .aif/.aiff files to .mid by extracting the MIDI
chunk between the MIDI header and the "CHS" marker.
"""

import sys
from pathlib import Path

MIDI_HEADER = b"MThd\x00\x00\x00\x06\x00\x00\x00\x01\x01\xE0MTrk"
END_MARKER = b"CHS"


def convert_one(path: Path) -> Path | None:
    data = path.read_bytes()
    start = data.rfind(MIDI_HEADER)
    end = data.rfind(END_MARKER)
    if start < 0 or end < 0 or end <= start:
        return None

    out_path = path.with_suffix(".mid")
    out_path.write_bytes(data[start:end])
    return out_path


def main(argv: list[str]) -> int:
    if len(argv) < 2:
        print("Usage: gb2midi.py <file1.aif> [file2.aif ...]", file=sys.stderr)
        return 2

    ok = 0
    for raw in argv[1:]:
        path = Path(raw)
        if not path.exists():
            print(f"Not found: {path}", file=sys.stderr)
            continue
        if path.suffix.lower() not in {".aif", ".aiff"}:
            print(f"Skipping (not .aif/.aiff): {path}", file=sys.stderr)
            continue
        out = convert_one(path)
        if out is None:
            print(f"Failed to extract MIDI from: {path}", file=sys.stderr)
            continue
        print(f"Wrote: {out}")
        ok += 1

    return 0 if ok > 0 else 1


if __name__ == "__main__":
    raise SystemExit(main(sys.argv))
