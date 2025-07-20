# 🔍 ShiftCare CLI Challenge

A Ruby command-line app to search and detect duplicate clients from a JSON dataset.

---

## Setup & Usage

### 1. Install dependencies

```bash
bundle install
```

### 2. Make CLI executable (optional)

```bash
chmod +x bin/shiftcare
```

### 3. Run commands

#### Search clients by name (default)

```bash
./bin/shiftcare search john
```

#### Find duplicate emails

```bash
./bin/shiftcare duplicates
```

---

## Assumptions & Decisions
- The API is assumed to always be online and available.
- No retries or fallback logic for failed HTTP requests.
- The JSON structure is assumed to always be valid and consistent.
- Required fields like `full_name` and `email` are always present in every object.

- The remote client dataset is loaded from:
  `https://appassets02.shiftcare.com/manual/clients.json`
- Searching is case-insensitive and partial (`"john"` matches `"John Doe"` and `"Johnny"`).

---

## Limitations & Future Improvements

- Only fields directly on the JSON hash (like `full_name`, `email`) are supported.
- No pagination — all results are printed to STDOUT.
- Doesn’t validate schema or detect corrupted JSON.
- Could add fuzzy matching or regex-based queries.
- No caching: every remote URL request is live.

---

## Tests

To run tests:

```bash
bundle exec rspec
```

Test coverage includes:
- ✅ Search by partial name
- ✅ Case-insensitive search
- ✅ Detection of duplicate emails
- ✅ No matches
- ✅ No duplicates
- ✅ Invalid field search (negative case)

---

## Next Steps

- Accept dynamic fields and files
- Add REST API wrapper (Rails)
- Load large JSON with streaming for scale
- Add web UI for interacting with results
