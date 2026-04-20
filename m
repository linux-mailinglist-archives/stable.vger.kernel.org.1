Return-Path: <stable+bounces-239006-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2F0DMM405mmOtQEAu9opvQ
	(envelope-from <stable+bounces-239006-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 16:14:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CB5E942CCA8
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 16:14:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 92CB430FF0CF
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 13:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D823FD156;
	Mon, 20 Apr 2026 13:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gKvyc+gj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6ED23FD14C;
	Mon, 20 Apr 2026 13:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776691591; cv=none; b=Q5DCSCDDC9ZDsBA5VVI1NZ0gvL80AFt26k228AWs9gRMw4YX4yRHaO7mhlJZjnXVD4lQLFv/qBXp2REGJcDeqmjbT9ESQZyC9bL6uVw0jJuymVimhsfyZheJjK4NI1tW62HkiehUkGLohs/V1tt0XiKvHboBhFWz/9bHInXRsNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776691591; c=relaxed/simple;
	bh=m5QEVKm030ElDj9lg8EY1wI7itCIqVkRRRQ2p0XlGck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cyjScZkttsU9PN1ZUHXwT4854lemrBuySxhFRQ3iicL0s9ZrCMLMwYUPfYchhh4Uk+yILTImFZ5hTvri8lpPWpKcCu0al49qXm590BTk3Noo1nBYuu7u3x96xdjPVcAW/ru12qgrtdE7CMqL32s3/1cKw1cL342Z3FM85bYZS5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gKvyc+gj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6514EC2BCB6;
	Mon, 20 Apr 2026 13:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776691590;
	bh=m5QEVKm030ElDj9lg8EY1wI7itCIqVkRRRQ2p0XlGck=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gKvyc+gjjt6Ak7MFltDV+dlIIbVjnyP5QThlin9bGR0N0Pf85x8ITp3G/J11gYZBX
	 KlZLETl8F7mDwi0vhNLi/G5Mk2s5VAcIFbr64mBUB/PtT7O3VPcPEoB/pwYyldnVLD
	 Iv+rCKd4H4jHpEi2i9LBSs1vzjQ3hU1ES8kxUYW8Z5Uf5hK3Hl+UAAf57nzITzuWXQ
	 emAXb6r/p8ZCXCcGtkWx5HluLD74KsaArgQ+6qLu7nKKN9LhsHaUbK4cO4W6huvvPB
	 JpFXF+cwSIUDjWuSobrIrmx0YJgycvJsDLVcX4P/N9+dtiHR+K1X+5f8qj8yQF0HIL
	 teD78Ct+K/5fw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	Frank.Li@nxp.com,
	linux-sound@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 7.0-6.1] ASoC: mxs-sgtl5000: disable MCLK on error paths of mxs_sgtl5000_probe()
Date: Mon, 20 Apr 2026 09:18:33 -0400
Message-ID: <20260420132314.1023554-119-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420132314.1023554-1-sashal@kernel.org>
References: <20260420132314.1023554-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 7.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[isrc.iscas.ac.cn,kernel.org,gmail.com,perex.cz,suse.com,nxp.com,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-239006-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,iscas.ac.cn:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CB5E942CCA8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>

[ Upstream commit c8ef13d692f19cdbbf195fb845421a5b71801704 ]

Call mxs_saif_put_mclk() to disable MCLK on error
paths of mxs_sgtl5000_probe().

Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
Link: https://patch.msgid.link/20260401053051.586290-1-lihaoxiang@isrc.iscas.ac.cn
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Now I have a complete picture. Let me compile the full analysis.

---

## PHASE 1: COMMIT MESSAGE FORENSICS

**Step 1.1: Subject Line**
- Subsystem: `ASoC: mxs-sgtl5000`
- Action verb: "disable" (implies fixing a missing cleanup)
- Summary: Disable MCLK on error paths of `mxs_sgtl5000_probe()`
- Record: [ASoC/mxs-sgtl5000] [disable/fix] [Add missing
  mxs_saif_put_mclk() on probe error paths]

**Step 1.2: Tags**
- Signed-off-by: Haoxiang Li (author) - a contributor focused on error-
  path resource leak fixes
- Link: `https://patch.msgid.link/20260401053051.586290-1-
  lihaoxiang@isrc.iscas.ac.cn`
- Signed-off-by: Mark Brown (ASoC maintainer applied the patch)
- No Fixes: tag, no Reported-by, no Cc: stable (expected for review
  candidates)

**Step 1.3: Commit Body**
The message is concise: call `mxs_saif_put_mclk()` to disable MCLK on
error paths. The bug is a resource leak - `mxs_saif_get_mclk()` enables
a hardware clock, and if probe fails after that point, the clock remains
enabled.

**Step 1.4: Hidden Bug Fix Detection**
This IS a resource leak fix. The wording "disable MCLK on error paths"
is a classic resource-leak-on-error-path fix pattern.

## PHASE 2: DIFF ANALYSIS

**Step 2.1: Inventory**
- 1 file changed: `sound/soc/mxs/mxs-sgtl5000.c`
- 2 lines added: two `mxs_saif_put_mclk(0)` calls + braces adjustment
- Functions modified: `mxs_sgtl5000_probe()`
- Scope: single-file surgical fix

**Step 2.2: Code Flow Change**
Two error paths are fixed:

1. **`snd_soc_of_parse_audio_routing()` failure** (line 160): BEFORE:
   returned directly without disabling MCLK. AFTER: calls
   `mxs_saif_put_mclk(0)` before returning.

2. **`devm_snd_soc_register_card()` failure** (line 165): BEFORE:
   returned directly without disabling MCLK. AFTER: calls
   `mxs_saif_put_mclk(0)` before returning.

**Step 2.3: Bug Mechanism**
Category: **Error path / resource leak fix**.

`mxs_saif_get_mclk()` at line 144:
- Calls `__mxs_saif_get_mclk()` which sets `saif->mclk_in_use = 1`
- Calls `clk_prepare_enable(saif->clk)` to enable the hardware clock
- Writes to SAIF_CTRL to enable MCLK output

When probe fails after this, `mxs_saif_put_mclk()` (which disables the
clock, clears MCLK output, and sets `mclk_in_use = 0`) is never called.
The `remove()` callback only runs if `probe()` succeeded.

**Step 2.4: Fix Quality**
- Obviously correct: mirrors the cleanup done in `mxs_sgtl5000_remove()`
- Minimal/surgical: only 2 meaningful lines added
- Regression risk: essentially zero - only affects error paths
- The fix follows the exact same pattern as the existing `remove()`
  function

## PHASE 3: GIT HISTORY INVESTIGATION

**Step 3.1: Blame Analysis**
- The `mxs_saif_get_mclk()` call was introduced in the original driver
  commit `fcb5e47eff29a1` (2011, v3.2). So the register_card error-path
  leak has existed since 2011.
- The audio-routing error path was introduced by `949293d45d6b09` (2018,
  v4.16) which added `snd_soc_of_parse_audio_routing()` without cleanup
  on failure.
- Both error paths predate all active stable trees.

**Step 3.2: No Fixes: tag** (expected for review candidates)

**Step 3.3: Related Changes**
- `6ae0a4d8fec55` (2022): Fixed a different resource leak (of_node_put)
  in the same probe function - shows this function has a history of
  incomplete error handling.
- `7a17f6a95a613` (2021): Switched to `dev_err_probe()` for
  register_card failure.

**Step 3.4: Author Context**
Haoxiang Li is a prolific error-path/resource-leak fix contributor.
Their commit history shows many similar fixes across kernel subsystems
(PCI, SCSI, media, DRM, clock, bus drivers).

**Step 3.5: Dependencies**
No dependencies. The fix only adds `mxs_saif_put_mclk(0)` calls, which
has existed since the driver was created. Should apply cleanly to all
stable trees.

## PHASE 4: MAILING LIST RESEARCH

Lore was not accessible due to bot protection. However:
- The patch was accepted by Mark Brown (ASoC subsystem maintainer)
  directly
- The Link tag points to the original submission
- Single-version submission (no v2/v3), suggesting it was
  straightforward

## PHASE 5: CODE SEMANTIC ANALYSIS

**Step 5.1: Functions Modified**
Only `mxs_sgtl5000_probe()` is modified.

**Step 5.2: Resource Chain**
- `mxs_saif_get_mclk()` → `__mxs_saif_get_mclk()` → sets
  `mclk_in_use=1`, clears CLKGATE, configures clock rate →
  `clk_prepare_enable()` → writes SAIF_CTRL to enable MCLK RUN
- `mxs_saif_put_mclk()` → `clk_disable_unprepare()` → sets CLKGATE →
  clears RUN → `mclk_in_use=0`

Without the fix, on error: clock stays enabled, hardware MCLK output
stays active, `mclk_in_use` remains 1 (preventing future attempts to get
MCLK).

## PHASE 6: STABLE TREE ANALYSIS

**Step 6.1: Code Presence**
The buggy code exists in ALL active stable trees:
- The register_card error leak exists since v3.2 (2011)
- The audio-routing error leak exists since v4.16 (2018)
- All stable trees (5.4.y, 5.10.y, 5.15.y, 6.1.y, 6.6.y, 6.12.y) contain
  both bugs

**Step 6.2: Backport Difficulty**
The patch should apply cleanly or with trivial fuzz. Stable trees older
than 6.1 use `of_find_property()` instead of `of_property_present()`,
but the error path code is unchanged. The `devm_snd_soc_register_card`
error path in trees before 5.15 uses slightly different error printing
(not `dev_err_probe`), but the fix location is the same.

## PHASE 7: SUBSYSTEM CONTEXT

- Subsystem: ASoC (sound/soc) - audio driver infrastructure
- Criticality: PERIPHERAL (MXS/i.MX28 embedded audio, specific platform)
- The MXS SAIF + SGTL5000 combination is used on Freescale/NXP i.MX28
  boards

## PHASE 8: IMPACT AND RISK ASSESSMENT

**Step 8.1: Affected Users**
Platform-specific: users of i.MX28 boards with SGTL5000 audio codec
(embedded systems).

**Step 8.2: Trigger**
Probe failure on the audio device. This can be triggered by:
- Invalid/malformed audio-routing DT property
- `devm_snd_soc_register_card()` failure (e.g., codec not ready, probe
  deferral errors)

**Step 8.3: Failure Mode**
- Clock resource leak (hardware clock left enabled, consuming power)
- `mclk_in_use` flag remains set, potentially blocking future MCLK
  acquisition
- Severity: MEDIUM (resource leak, not crash)

**Step 8.4: Risk-Benefit**
- BENEFIT: Fixes resource leak on error paths. Clean cleanup of hardware
  state.
- RISK: Very low. Only 2 lines, only error paths, mirrors existing
  remove() logic.
- Ratio: Favorable. Very low risk fix for a real resource leak.

## PHASE 9: FINAL SYNTHESIS

**Evidence FOR backporting:**
- Fixes a real resource leak (hardware clock left enabled on probe
  failure)
- Fixes `mclk_in_use` state leak that can prevent subsequent attempts
- Tiny, surgical fix (2 lines of meaningful code)
- Obviously correct (mirrors the cleanup in `remove()`)
- Accepted by ASoC subsystem maintainer (Mark Brown)
- Bug exists in all stable trees (since v3.2/v4.16)
- Zero regression risk (only error paths affected)
- The same function had a prior similar fix (`6ae0a4d8fec55` for
  of_node_put)

**Evidence AGAINST:**
- Platform-specific driver (limited user base, i.MX28)
- No Reported-by (found by code review, not user complaint)
- Resource leak, not crash/security/corruption
- No Fixes: tag (but expected for review candidates)

**Stable Rules Checklist:**
1. Obviously correct and tested? **YES** - mirrors remove() pattern,
   accepted by maintainer
2. Fixes a real bug? **YES** - clock resource leak on error
3. Important issue? **MEDIUM** - resource leak, not critical severity
4. Small and contained? **YES** - 2 lines, 1 file
5. No new features? **YES** - pure bugfix
6. Can apply to stable? **YES** - should apply cleanly to all active
   trees

## Verification

- [Phase 1] Parsed tags: Link to patch.msgid.link, SOB by Mark Brown
  (maintainer), author Haoxiang Li
- [Phase 2] Diff analysis: 2 lines of `mxs_saif_put_mclk(0)` added to
  two error paths in `mxs_sgtl5000_probe()`
- [Phase 3] git blame: `mxs_saif_get_mclk()` introduced in
  fcb5e47eff29a1 (v3.2, 2011); audio-routing error path introduced in
  949293d45d6b09 (v4.16, 2018)
- [Phase 3] git show 949293d45d6b09: confirmed it added
  `snd_soc_of_parse_audio_routing()` error path without cleanup
- [Phase 3] git show 6ae0a4d8fec55: confirmed prior error-handling fix
  in same function (of_node_put leak)
- [Phase 3] Author commits: Haoxiang Li is a serial error-path leak
  fixer
- [Phase 4] Lore inaccessible due to bot protection; patch accepted by
  Mark Brown directly
- [Phase 5] Read mxs_saif_get_mclk: confirms it enables clock + sets
  mclk_in_use=1; put_mclk disables clock + clears flag
- [Phase 6] Code exists in all stable trees from 5.4.y through 6.12.y
- [Phase 6] git log v6.6..HEAD: only 4 commits to this file since v6.6,
  none conflicting
- [Phase 8] Failure mode: clock resource leak + mclk_in_use state leak
  on probe error, severity MEDIUM

The fix is small, surgical, obviously correct, and fixes a real resource
leak that has existed since 2011/2018. It meets all stable kernel
criteria.

**YES**

 sound/soc/mxs/mxs-sgtl5000.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/mxs/mxs-sgtl5000.c b/sound/soc/mxs/mxs-sgtl5000.c
index 245f174116384..f1c0e612313dd 100644
--- a/sound/soc/mxs/mxs-sgtl5000.c
+++ b/sound/soc/mxs/mxs-sgtl5000.c
@@ -157,13 +157,16 @@ static int mxs_sgtl5000_probe(struct platform_device *pdev)
 		if (ret) {
 			dev_err(&pdev->dev, "failed to parse audio-routing (%d)\n",
 				ret);
+			mxs_saif_put_mclk(0);
 			return ret;
 		}
 	}
 
 	ret = devm_snd_soc_register_card(&pdev->dev, card);
-	if (ret)
+	if (ret) {
+		mxs_saif_put_mclk(0);
 		return dev_err_probe(&pdev->dev, ret, "snd_soc_register_card failed\n");
+	}
 
 	return 0;
 }
-- 
2.53.0


