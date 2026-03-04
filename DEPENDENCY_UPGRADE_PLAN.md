# Montecristo Dependency Vulnerability Remediation Plan

## Executive Summary

Mend vulnerability scanner identified **115 vulnerabilities** across Montecristo's dependencies:
- **8 Critical** (CVSS 9.1-9.8)
- **59 High** (CVSS 7.1-8.8)
- **47 Medium** (CVSS 4.0-6.9)
- **1 Low** (CVSS 3.3-3.7)

This plan addresses all Critical and High vulnerabilities systematically, upgrading one dependency at a time with testing at each step.

## Vulnerability Analysis by Dependency

### Critical Vulnerabilities (CVSS 9.1-9.8)

#### 1. Logback (CVSS 9.8)
**Current Versions:**
- `logback-classic:1.1.8` (montecristo, dse-stats-converter)
- `logback-core:1.1.8` (montecristo, dse-stats-converter)
- `logback-classic:1.2.9` (montecristo)
- `logback-core:1.2.9` (montecristo)

**Vulnerabilities:**
- CVE-2017-5929 (CVSS 9.8) - Remote code execution

**Target Version:** `1.3.16` (fixes all CVEs including CVE-2024-12798, CVE-2023-6378, CVE-2025-11226, CVE-2026-1225, CVE-2024-12801, CVE-2021-42550)

**Impact:** Both projects affected

---

#### 2. LZ4 (CVSS 9.1)
**Current Versions:**
- `lz4:1.3.0` (transitive via cassandra-all)
- `lz4-java:1.8.0` (transitive via cassandra-all)

**Vulnerabilities:**
- CVE-2025-12183 (CVSS 9.1) - Critical security flaw
- CVE-2025-66566 (CVSS 7.5) - High severity issue

**Target Version:** `org.lz4:lz4-java:1.10.1`

**Impact:** Transitive dependency - may require cassandra-all upgrade or explicit dependency management

---

#### 3. Cassandra-all (CVSS 9.1)
**Current Versions:**
- `cassandra-all:3.11.11` (dse-stats-converter)
- `cassandra-all:4.0.9` (montecristo)

**Vulnerabilities:**
- CVE-2021-44521 (CVSS 9.1) - Critical security issue
- CVE-2025-23015 (CVSS 8.8) - High severity
- CVE-2025-24860 (CVSS 8.1) - High severity
- CVE-2023-30601 (CVSS 7.8) - High severity
- CVE-2024-27137 (CVSS 5.3) - Medium severity

**Target Versions:**
- For 3.11.x: `3.11.18` or `3.0.31`
- For 4.0.x: `4.0.16`
- Alternative: `4.1.8` or `5.0.3`

**Impact:** Core dependency - requires careful testing

---

#### 4. Netty (CVSS 9.1)
**Current Versions:**
- `netty-all:4.0.44.Final` (montecristo, dse-stats-converter)
- `netty-all:4.1.58.Final` (montecristo)
- `netty-codec:4.1.39.Final` (montecristo)
- `netty-handler:4.1.39.Final` (montecristo)
- `netty-common:4.1.39.Final` (montecristo)

**Vulnerabilities:**
- CVE-2019-20445 (CVSS 9.1)
- CVE-2019-20444 (CVSS 9.1)
- Plus 15+ additional High/Medium CVEs

**Target Version:** `4.1.125.Final` (fixes all known CVEs)

**Impact:** Multiple modules affected - transitive via cassandra-all and DSE jars

---

### High Vulnerabilities (CVSS 7.1-8.8)

#### 5. SnakeYAML (CVSS 8.3)
**Current Versions:**
- `snakeyaml:1.12` (transitive via cassandra-all)
- `snakeyaml:1.30` (transitive via cassandra-all)
- `snakeyaml:1.17` (montecristo direct)

**Vulnerabilities:**
- CVE-2022-1471 (CVSS 8.3) - Remote code execution
- Plus 8+ additional CVEs

**Target Version:** `2.0` (major version upgrade required)

**Impact:** Breaking changes expected - requires code review

---

#### 6. Jackson (CVSS 7.5)
**Current Versions:**
- `jackson-core:2.9.10` (transitive)
- `jackson-core:2.13.2` (transitive)
- `jackson-databind:2.9.10.8` (transitive)
- `jackson-databind:2.13.2.2` (transitive)
- `jackson-databind:2.11.2` (montecristo direct)

**Vulnerabilities:**
- CVE-2025-52999 (CVSS 7.5)
- CVE-2022-42004 (CVSS 7.5)
- CVE-2022-42003 (CVSS 7.5)
- WS-2022-0468 (CVSS 7.5)
- CVE-2025-49128 (CVSS 4.0)

**Target Version:** `2.15.0` or later

**Impact:** Core serialization library - extensive testing needed

---

#### 7. Snappy-java (CVSS 7.5)
**Current Versions:**
- `snappy-java:1.1.1.7` (transitive)
- `snappy-java:1.1.2.6` (transitive)

**Vulnerabilities:**
- CVE-2023-43642 (CVSS 7.5)
- CVE-2023-34455 (CVSS 7.5)
- CVE-2023-34454 (CVSS 5.9)
- CVE-2023-34453 (CVSS 5.9)

**Target Version:** `1.1.10.4`

**Impact:** Transitive dependency via cassandra-all

---

#### 8. SQLite JDBC (CVSS 8.8)
**Current Version:**
- `sqlite-jdbc:3.41.0.0` (montecristo direct)

**Vulnerabilities:**
- CVE-2023-32697 (CVSS 8.8)

**Target Version:** `3.41.2.2` or later

**Impact:** Direct dependency - straightforward upgrade

---

#### 9. JCommander (CVSS 8.1)
**Current Version:**
- `jcommander:1.72` (montecristo direct)

**Vulnerabilities:**
- WS-2019-0490 (CVSS 8.1)

**Target Version:** `1.75` or later

**Impact:** CLI parsing library - test command-line interface

---

#### 10. Guava (CVSS 5.5)
**Current Versions:**
- `guava:19.0` (dse-stats-converter direct)
- `guava:27.0-jre` (transitive)

**Vulnerabilities:**
- CVE-2023-2976 (CVSS 5.5)
- CVE-2020-8908 (CVSS 3.3)

**Target Version:** `32.0.1-android` or `32.0.1-jre`

**Impact:** Widely used utility library - extensive testing needed

---

#### 11. Commons-lang3 (CVSS 5.3)
**Current Versions:**
- `commons-lang3:3.8.1` (montecristo, dse-stats-converter)
- `commons-lang3:3.11` (transitive)

**Vulnerabilities:**
- CVE-2025-48924 (CVSS 5.3)

**Target Version:** `3.18.0`

**Impact:** Utility library - low risk upgrade

---

#### 12. Commons-io (CVSS 4.8)
**Current Version:**
- `commons-io:2.6` (montecristo, dse-stats-converter)

**Vulnerabilities:**
- CVE-2021-29425 (CVSS 4.8)
- CVE-2024-47554 (CVSS 4.3)

**Target Version:** `2.14.0` or later

**Impact:** File I/O library - test file operations

---

#### 13. Kotlin-stdlib (CVSS 5.3)
**Current Version:**
- `kotlin-stdlib:1.4.21` (both projects)
- `kotlin-stdlib:1.5.30` (transitive)

**Vulnerabilities:**
- CVE-2022-24329 (CVSS 5.3)

**Target Version:** `1.6.0` or later

**Impact:** Core language library - requires Kotlin version upgrade

---

### Medium Vulnerabilities

#### 14. HTTPClient (CVSS 5.3)
**Current Version:**
- `httpclient:4.2.5` (transitive)

**Vulnerabilities:**
- CVE-2020-13956 (CVSS 5.3)
- WS-2017-3734 (CVSS 5.3)
- CVE-2015-5262 (CVSS 3.7)

**Target Version:** `4.5.13` or later

**Impact:** HTTP client library - test network operations

---

#### 15. Commons-codec (CVSS 6.5)
**Current Version:**
- `commons-codec:1.9` (transitive)

**Vulnerabilities:**
- WS-2019-0379 (CVSS 6.5)

**Target Version:** Latest stable version

**Impact:** Encoding/decoding library - low risk

---

#### 16. Lucene (CVSS 5.3)
**Current Versions:**
- `lucene-core:7.2.1` (montecristo)
- `lucene-queryparser:7.5.0` (montecristo)

**Vulnerabilities:**
- WS-2021-0646 (CVSS 5.3)

**Target Version:** Latest 7.x or 8.x

**Impact:** Search library - test search functionality

---

#### 17. Pillow (Python - CVSS 9.8)
**Current Version:**
- `pillow:11.3.0` (transitive via iostat-tool)

**Vulnerabilities:**
- CVE-2026-25990 (CVSS 9.8)

**Target Version:** `12.1.1`

**Impact:** Python dependency - may not be directly fixable in Java project

---

#### 18. Libthrift (CVSS 7.5)
**Current Version:**
- `libthrift:0.9.2` (transitive)

**Vulnerabilities:**
- CVE-2019-0205 (CVSS 7.5)
- CVE-2018-11798 (CVSS 6.5)

**Target Version:** `0.13.0` or later

**Impact:** Thrift RPC library - transitive dependency

---

## Upgrade Strategy

### Phase 1: Critical Vulnerabilities (Priority 1)

1. **Logback** (1.1.8/1.2.9 → 1.3.16)
   - Fixes CVE-2017-5929 (CVSS 9.8)
   - Both projects affected
   - Test: Build and run basic operations

2. **Cassandra-all** (3.11.11 → 3.11.18, 4.0.9 → 4.0.16)
   - Fixes CVE-2021-44521 (CVSS 9.1) and others
   - Core dependency - extensive testing required
   - Test: Schema parsing, data model operations

3. **Netty** (via cassandra-all upgrade)
   - Fixes CVE-2019-20445, CVE-2019-20444 (CVSS 9.1)
   - Transitive dependency
   - Test: Network operations, if any

4. **LZ4** (via cassandra-all upgrade or explicit management)
   - Fixes CVE-2025-12183 (CVSS 9.1)
   - May require dependency management block
   - Test: Compression operations

### Phase 2: High Vulnerabilities (Priority 2)

5. **SQLite JDBC** (3.41.0.0 → 3.41.2.2+)
   - Fixes CVE-2023-32697 (CVSS 8.8)
   - Direct dependency
   - Test: Database operations

6. **SnakeYAML** (1.12/1.17/1.30 → 2.0)
   - Fixes CVE-2022-1471 (CVSS 8.3)
   - Breaking changes expected
   - Test: YAML parsing (cassandra.yaml, dse.yaml)

7. **JCommander** (1.72 → 1.75+)
   - Fixes WS-2019-0490 (CVSS 8.1)
   - Direct dependency
   - Test: Command-line parsing

8. **Jackson** (2.9.10/2.11.2/2.13.2 → 2.15.0+)
   - Fixes multiple CVEs (CVSS 7.5)
   - Core serialization library
   - Test: JSON/YAML serialization

9. **Snappy-java** (via cassandra-all or explicit)
   - Fixes CVE-2023-43642 (CVSS 7.5)
   - Transitive dependency
   - Test: Compression operations

10. **Guava** (19.0/27.0 → 32.0.1)
    - Fixes CVE-2023-2976 (CVSS 5.5)
    - Widely used utility library
    - Test: Collection operations, caching

11. **Commons-lang3** (3.8.1/3.11 → 3.18.0)
    - Fixes CVE-2025-48924 (CVSS 5.3)
    - Utility library
    - Test: String operations

12. **Commons-io** (2.6 → 2.14.0)
    - Fixes CVE-2021-29425 (CVSS 4.8)
    - File I/O library
    - Test: File operations

13. **Kotlin** (1.4.21 → 1.6.0+)
    - Fixes CVE-2022-24329 (CVSS 5.3)
    - Core language upgrade
    - Test: Full build and test suite

### Phase 3: Medium Vulnerabilities (Priority 3 - Optional)

14. **HTTPClient** (4.2.5 → 4.5.13+)
15. **Commons-codec** (1.9 → latest)
16. **Lucene** (7.2.1/7.5.0 → latest 7.x or 8.x)
17. **Libthrift** (0.9.2 → 0.13.0+)

### Phase 4: Special Cases

18. **Pillow** (Python dependency)
    - Not directly fixable in Java project
    - Investigate if iostat-tool can be updated or replaced

## Testing Strategy

For each upgrade:

1. **Build Test**
   ```bash
   ./build.sh -c
   ```

2. **Unit Tests**
   ```bash
   cd montecristo && ./gradlew test
   cd dse-stats-converter && ./gradlew test
   ```

3. **Integration Test**
   - Run montecristo against sample diagnostic data
   - Verify report generation
   - Check for runtime errors

4. **Regression Test**
   - Compare output with previous version
   - Verify no functionality loss

## Dependency Compatibility Matrix

| Dependency | Current | Target | Java 8 Compatible | Breaking Changes |
|------------|---------|--------|-------------------|------------------|
| logback | 1.1.8/1.2.9 | 1.3.16 | ✅ Yes | Minor |
| cassandra-all | 3.11.11/4.0.9 | 3.11.18/4.0.16 | ✅ Yes | Patch |
| sqlite-jdbc | 3.41.0.0 | 3.41.2.2+ | ✅ Yes | Patch |
| snakeyaml | 1.12/1.17/1.30 | 2.0 | ✅ Yes | ⚠️ Major |
| jcommander | 1.72 | 1.75+ | ✅ Yes | Minor |
| jackson | 2.9.10/2.11.2/2.13.2 | 2.15.0+ | ✅ Yes | Minor |
| guava | 19.0/27.0 | 32.0.1 | ✅ Yes | Minor |
| commons-lang3 | 3.8.1/3.11 | 3.18.0 | ✅ Yes | Minor |
| commons-io | 2.6 | 2.14.0 | ✅ Yes | Minor |
| kotlin | 1.4.21 | 1.6.0+ | ✅ Yes | Minor |
| netty | 4.0.44/4.1.58 | 4.1.125 | ✅ Yes | Minor |
| httpclient | 4.2.5 | 4.5.13+ | ✅ Yes | Minor |

## Risk Assessment

### High Risk Upgrades
- **Cassandra-all**: Core dependency, extensive API usage
- **SnakeYAML**: Major version upgrade (1.x → 2.0)
- **Jackson**: Core serialization, used throughout
- **Kotlin**: Language version upgrade

### Medium Risk Upgrades
- **Guava**: Widely used utility library
- **Netty**: Network library (transitive)
- **Logback**: Logging framework

### Low Risk Upgrades
- **SQLite JDBC**: Isolated database driver
- **JCommander**: CLI parsing only
- **Commons-lang3**: Utility library
- **Commons-io**: File I/O utilities

## Rollback Plan

For each upgrade:
1. Create git branch: `fix/upgrade-<dependency>-<version>`
2. Commit changes with clear message
3. If tests fail, revert commit and document issues
4. Move to next dependency

## Success Criteria

- ✅ All Critical vulnerabilities resolved
- ✅ All High vulnerabilities resolved
- ✅ Build succeeds with Java 8
- ✅ All unit tests pass
- ✅ Integration tests pass
- ✅ No regression in functionality
- ⚠️ Medium vulnerabilities: Best effort

## Notes

1. **Java 8 Constraint**: Project requires Java 8, limiting some upgrade options
2. **Transitive Dependencies**: Many vulnerabilities are in transitive dependencies via cassandra-all
3. **DSE Jars**: dse-stats-converter uses proprietary DSE jars that may have their own vulnerabilities
4. **Pillow**: Python dependency not directly fixable in Java project

## Estimated Timeline

- Phase 1 (Critical): 4-6 upgrades × 1-2 hours = 6-12 hours
- Phase 2 (High): 9 upgrades × 1-2 hours = 9-18 hours
- Phase 3 (Medium): 4 upgrades × 0.5-1 hour = 2-4 hours
- **Total**: 17-34 hours of work

## Next Steps

1. Review and approve this plan
2. Create tracking branch: `fix/security-vulnerabilities`
3. Begin Phase 1 upgrades in order
4. Test after each upgrade
5. Document any issues or blockers
6. Create summary report when complete