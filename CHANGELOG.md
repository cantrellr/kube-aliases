# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [1.0.0] - 2025-11-29

### Added

- ✈️ Initial release - cleared for takeoff!
- 50+ kubectl aliases for PowerShell and CMD
- Automated installer script (`install.cmd`)
- PowerShell profile integration with auto-load
- CMD AutoRun registry configuration
- Printable HTML cheat sheet with K8s humor
- Core verb shortcuts: `k`, `kg`, `kd`, `ke`, `ka`, `kc`, `krm`, `kl`, `kx`
- Resource shortcuts: `kgp`, `kgd`, `kgs`, `kgn`, `kgi`, `kga`, `kgpa`, `kgaa`
- Watch mode aliases: `kgpw`, `kgdw`
- Log and exec helpers: `klo`, `kexec`, `kpf`
- Describe helpers: `kdp`, `kdd`, `kds`, `kdsec`, `kdcm`
- Output format aliases: `kgy`, `kgj`, `kgw`
- File operations: `kaf`, `kdf`
- Rollout and scale: `krollout`, `krestart`, `kscale`
- Node operations: `kdrain`, `kunc`, `kcord`
- Metrics and events: `ktop`, `ktopn`, `kev`
- Context and namespace switching: `kx`, `kn`, `kinfo`
- CRD and API helpers: `kgc`, `kap`, `kav`
- PowerShell-only functions: `klogs`, `kxpod`, `kinfo`, `kh`

### Security

- No sensitive data stored
- Registry changes limited to HKCU (user-level only)

---

[Unreleased]: https://github.com/cantrellr/kube-aliases/compare/v1.0.0...HEAD
[1.0.0]: https://github.com/cantrellr/kube-aliases/releases/tag/v1.0.0
