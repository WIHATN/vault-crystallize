param(
    [string]$Root = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
)

$ErrorActionPreference = 'Stop'

$requiredFiles = @(
    '.codex-plugin/plugin.json',
    'SKILL.md',
    'commands/crystallize.md',
    'commands/distill.md',
    'commands/codex/crystallize.md',
    'commands/codex/distill.md',
    'commands/claude/crystallize.md',
    'commands/claude/distill.md',
    'commands/gemini/crystallize.toml',
    'commands/gemini/distill.toml',
    'codex/crystallize/SKILL.md',
    'codex/distill/SKILL.md',
    'skills/crystallize/SKILL.md',
    'skills/distill/SKILL.md'
)

$missing = @()
foreach ($file in $requiredFiles) {
    if (-not (Test-Path -LiteralPath (Join-Path $Root $file))) {
        $missing += $file
    }
}

if ($missing.Count -gt 0) {
    throw "Missing required artifact(s): $($missing -join ', ')"
}

$codexManifest = Get-Content -Raw -LiteralPath (Join-Path $Root '.codex-plugin/plugin.json') | ConvertFrom-Json
if ($codexManifest.name -ne 'vault-crystallize') {
    throw ".codex-plugin/plugin.json name must be vault-crystallize"
}
    if ($codexManifest.skills -ne './skills/') {
    throw ".codex-plugin/plugin.json skills must point to ./skills/"
}

if (Test-Path -LiteralPath (Join-Path $Root '.claude-plugin')) {
    throw ".claude-plugin must not exist; Claude installation uses ordinary skills and command files"
}

$skillNames = @{
    'SKILL.md' = 'vault-crystallize'
    'codex/crystallize/SKILL.md' = 'crystallize'
    'codex/distill/SKILL.md' = 'distill'
    'skills/crystallize/SKILL.md' = 'crystallize'
    'skills/distill/SKILL.md' = 'distill'
}

$ordinaryCodexLayout = @(
    'vault-crystallize/SKILL.md',
    'crystallize/SKILL.md',
    'distill/SKILL.md'
)
foreach ($installPath in $ordinaryCodexLayout) {
    if ($installPath -notmatch '^[a-z0-9-]+/SKILL\.md$') {
        throw "Invalid ordinary Codex skill install path: $installPath"
    }
}

$ordinaryClaudeLayout = @(
    'vault-crystallize/SKILL.md',
    'crystallize/SKILL.md',
    'distill/SKILL.md',
    'commands/crystallize.md',
    'commands/distill.md'
)
foreach ($installPath in $ordinaryClaudeLayout) {
    if ($installPath -notmatch '^([a-z0-9-]+/SKILL\.md|commands/[a-z0-9-]+\.md)$') {
        throw "Invalid ordinary Claude install path: $installPath"
    }
}

$aliases = @{
    'codex/crystallize/SKILL.md' = 'crystallize'
    'codex/distill/SKILL.md' = 'distill'
    'skills/crystallize/SKILL.md' = 'crystallize'
    'skills/distill/SKILL.md' = 'distill'
}

foreach ($entry in $skillNames.GetEnumerator()) {
    $content = Get-Content -Raw -LiteralPath (Join-Path $Root $entry.Key)
    if ($content -notmatch "(?m)^name:\s+$([regex]::Escape($entry.Value))$") {
        throw "$($entry.Key) must declare name: $($entry.Value)"
    }
}

foreach ($entry in $aliases.GetEnumerator()) {
    $content = Get-Content -Raw -LiteralPath (Join-Path $Root $entry.Key)
    if ($content -notmatch "vault-crystallize") {
        throw "$($entry.Key) must route back to vault-crystallize"
    }
    if ($content -match "plugin alias") {
        throw "$($entry.Key) must be plugin-neutral for ordinary skill installation"
    }
}

Write-Output 'artifact validation passed'
