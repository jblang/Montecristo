# Dependency Upgrade Sequence

## Upgrade Order (Priority-Based)

This document outlines the recommended sequence for upgrading dependencies to fix security vulnerabilities.

```mermaid
graph TD
    A[Start: 115 Vulnerabilities] --> B[Phase 1: Critical CVSS 9.1-9.8]
    B --> C[1. Logback 1.1.8/1.2.9 → 1.3.16]
    C --> D[2. Cassandra-all 3.11.11/4.0.9 → 3.11.18/4.0.16]
    D --> E[3. LZ4 via cassandra or explicit]
    E --> F[4. Netty via cassandra upgrade]
    
    F --> G[Phase 2: High CVSS 7.1-8.8]
    G --> H[5. SQLite JDBC 3.41.0.0 → 3.41.2.2+]
    H --> I[6. SnakeYAML 1.x → 2.0]
    I --> J[7. JCommander 1.72 → 1.75+]
    J --> K[8. Jackson 2.x → 2.15.0+]
    K --> L[9. Snappy-java via cassandra]
    L --> M[10. Guava 19.0/27.0 → 32.0.1]
    M --> N[11. Commons-lang3 3.8.1 → 3.18.0]
    N --> O[12. Commons-io 2.6 → 2.14.0]
    O --> P[13. Kotlin 1.4.21 → 1.6.0+]
    
    P --> Q[Phase 3: Medium Optional]
    Q --> R[14-17. HTTPClient, Commons-codec, etc.]
    
    R --> S[Complete: All Critical & High Fixed]
    
    style A fill:#ff6b6b
    style B fill:#ff8787
    style G fill:#ffa94d
    style Q fill:#ffd43b
    style S fill:#51cf66
```

## Dependency Relationships

```mermaid
graph LR
    subgraph "Direct Dependencies"
        MC[montecristo/build.gradle]
        DSE[dse-stats-converter/build.gradle]
    end
    
    subgraph "Critical Issues"
        LB[Logback 1.1.8]
        CA[Cassandra-all 4.0.9]
        CA2[Cassandra-all 3.11.11]
    end
    
    subgraph "Transitive via Cassandra"
        NT[Netty 4.0.44]
        LZ4[LZ4 1.3.0]
        SY[SnakeYAML 1.12]
        SJ[Snappy-java 1.1.x]
        TH[Libthrift 0.9.2]
    end
    
    MC --> LB
    MC --> CA
    DSE --> LB
    DSE --> CA2
    
    CA --> NT
    CA --> LZ4
    CA --> SY
    CA --> SJ
    CA --> TH
    
    CA2 --> NT
    CA2 --> LZ4
    CA2 --> SY
    CA2 --> SJ
    CA2 --> TH
    
    style LB fill:#ff6b6b
    style CA fill:#ff6b6b
    style CA2 fill:#ff6b6b
    style NT fill:#ff8787
    style LZ4 fill:#ff8787
```

## Risk vs Impact Matrix

```mermaid
quadrantChart
    title Dependency Upgrade Risk Assessment
    x-axis Low Risk --> High Risk
    y-axis Low Impact --> High Impact
    quadrant-1 High Priority
    quadrant-2 Critical Priority
    quadrant-3 Low Priority
    quadrant-4 Medium Priority
    
    Logback: [0.2, 0.7]
    Cassandra-all: [0.8, 0.9]
    SnakeYAML: [0.7, 0.8]
    Jackson: [0.6, 0.8]
    SQLite: [0.2, 0.5]
    JCommander: [0.2, 0.4]
    Guava: [0.5, 0.7]
    Kotlin: [0.6, 0.9]
    Commons-io: [0.2, 0.3]
    Commons-lang3: [0.2, 0.3]
```

## Testing Strategy Per Phase

```mermaid
flowchart LR
    A[Upgrade Dependency] --> B[Build Test]
    B --> C{Build Success?}
    C -->|No| D[Rollback & Document]
    C -->|Yes| E[Unit Tests]
    E --> F{Tests Pass?}
    F -->|No| D
    F -->|Yes| G[Integration Test]
    G --> H{Integration OK?}
    H -->|No| D
    H -->|Yes| I[Commit Changes]
    I --> J[Next Dependency]
    
    style A fill:#4dabf7
    style I fill:#51cf66
    style D fill:#ff6b6b
```

## Estimated Timeline

| Phase | Dependencies | Est. Time | Cumulative |
|-------|-------------|-----------|------------|
| Phase 1: Critical | 4 upgrades | 6-12 hours | 6-12 hours |
| Phase 2: High | 9 upgrades | 9-18 hours | 15-30 hours |
| Phase 3: Medium | 4 upgrades | 2-4 hours | 17-34 hours |

## Key Decision Points

### 1. Cassandra-all Version Choice
- **Option A**: Stay on 3.11.x → 3.11.18 (safer, fewer changes)
- **Option B**: Upgrade to 4.0.16 (more fixes, more testing needed)
- **Option C**: Upgrade to 4.1.8 or 5.0.3 (most fixes, highest risk)

**Recommendation**: Option A for dse-stats-converter, Option B for montecristo

### 2. SnakeYAML Major Version Upgrade
- **Challenge**: 1.x → 2.0 is a major version change
- **Impact**: May require code changes in YAML parsing
- **Mitigation**: Thorough testing of cassandra.yaml and dse.yaml parsing

### 3. Kotlin Version Upgrade
- **Challenge**: Language version upgrade affects entire codebase
- **Impact**: May require syntax updates
- **Mitigation**: Incremental upgrade (1.4.21 → 1.6.0 → 1.7.x if needed)

### 4. Java 8 Constraint
- **Limitation**: Must maintain Java 8 compatibility
- **Impact**: Cannot use latest versions of some libraries
- **Mitigation**: Choose highest Java 8-compatible versions

## Success Metrics

- ✅ **Critical vulnerabilities**: 0 remaining (currently 8)
- ✅ **High vulnerabilities**: 0 remaining (currently 59)
- ⚠️ **Medium vulnerabilities**: Best effort (currently 47)
- ✅ **Build**: Successful with Java 8
- ✅ **Tests**: All passing
- ✅ **Functionality**: No regressions

## Rollback Strategy

Each upgrade will be done in a separate git commit:
1. Create branch: `fix/upgrade-<dependency>-<version>`
2. Make changes
3. Test thoroughly
4. If successful: commit and continue
5. If failed: `git reset --hard HEAD` and document issue

## Next Steps

1. **Review this plan** - Confirm approach and priorities
2. **Approve to proceed** - Get sign-off to start implementation
3. **Switch to Code mode** - Begin implementing upgrades
4. **Test incrementally** - Verify each change before proceeding
5. **Document results** - Track what worked and what didn't