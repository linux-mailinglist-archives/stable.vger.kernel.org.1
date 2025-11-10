Return-Path: <stable+bounces-192943-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5764C46717
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 13:05:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECEF61886551
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 12:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B858E30E0DC;
	Mon, 10 Nov 2025 11:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JiaVybCw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771C830E0E7
	for <stable@vger.kernel.org>; Mon, 10 Nov 2025 11:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762775943; cv=none; b=kNMt0Qf2m8TPdB4vJXjKqZpO8G/wCJtUvJjI0khVlc9j2nMMBNCUcod77l83YCRQdwmhsjKXxQPDaVbRkmq9+hPAGZPbh1+fOfQstXRkRETGm8nciHwxwfZ6qjHfXSMMAVOxETmDy35UxILlMYf5xzJYWsinCs3Zny6D4M78bYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762775943; c=relaxed/simple;
	bh=/GHjXDTqz1FVGqdLso1Ws7f8fTefoWsMIlO8N9tBCd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zss2VUR8dStHQLLWzqV/0EYCXUabbUxsGfVF49sPh1WLdvXDpBlJxvNNKk7pw23MPDZCz/sr6IFaE8K+uM2BqJ/OMUsq/1eqkmNydG6D3m88o2KMStB77WTFSS5t8hB+Dod3BkrmmqP1dYjNZ89ITMTgLxno13wPg/RKXfZnUg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JiaVybCw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3B2DC19425;
	Mon, 10 Nov 2025 11:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762775943;
	bh=/GHjXDTqz1FVGqdLso1Ws7f8fTefoWsMIlO8N9tBCd4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JiaVybCw+sdrsvPG3lYRIwQ/yGhQJ6Zlr0jDZOQcoZ8XqN2YyDwVNqxZnU/BucVHa
	 iF60bL+a+12uH2uF5PE1xMPZjXxsO1PSvSWn8TuSQ/2vwlhK9D3yOwU4GhxK2p3XOS
	 n0P1fBByYx3AfN16Be0RWd5pkXORbXXJFKkVFU1c9nzwt1dBE3KJo3F/VZTrvsLBKl
	 zJMEEvyI8b2KCWVNf8R5tgf7SMt5xT63zjCHfpeqg22b6BLJmnAlvue1IVC2vkryEQ
	 iUPytg9e4IX1ibitdHGGrmCM51lD6CM+dmBdEY/LcIxGAS2q+mT6RxA6T1EN2Rz5YS
	 Iww7uU5BS/UHw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/3] [AUTOMATED CONFLICT RESOLUTION] Documentation for d968e99488c4b08259a324a89e4ed17bf36561a4
Date: Mon, 10 Nov 2025 06:58:59 -0500
Message-ID: <20251110115859.651217-3-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251110115859.651217-1-sashal@kernel.org>
References: <2025110916-yummy-cane-0741@gregkh>
 <20251110115859.651217-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This commit documents the automated conflict resolution performed by Claude
for upstream commit d968e99488c4b08259a324a89e4ed17bf36561a4.

Claude's resolution process:
================================================================================
## Conflict Resolution Summary

Successfully resolved the conflict and applied commit d968e99488c4b! Here's the detailed explanation:

### The Problem
The original commit d968e99488c4b attempted to use `UFSHCD_QUIRK_PERFORM_LINK_STARTUP_ONCE`, but this quirk constant didn't exist in kernel 6.1, causing a build failure:
```
error: 'UFSHCD_QUIRK_PERFORM_LINK_STARTUP_ONCE' undeclared
```

### Root Cause Analysis
The commit had an unmet dependency: it required commit d34caa89a132c which introduces the `UFSHCD_QUIRK_PERFORM_LINK_STARTUP_ONCE` quirk definition. However, that prerequisite commit had merge conflicts because:
- Mainline kernel added many additional quirks (bits 19-26) between kernel 6.1 and the target version
- Kernel 6.1 only has quirks up to bit 18 (`UFSHCD_QUIRK_HIBERN_FASTAUTO`)

### Resolution Strategy
I manually backported the prerequisite changes with minimal modifications:

**Commit 1 (Prerequisite - 4b8ed7e65f99d):** "scsi: ufs: core: Add a quirk to suppress link_startup_again"
- Added `UFSHCD_QUIRK_PERFORM_LINK_STARTUP_ONCE` definition at bit 19 (next available position) in include/ufs/ufshcd.h:601
- Modified drivers/ufs/core/ufshcd.c:4781 to check the quirk before setting `link_startup_again`
- This prevents the 2nd DME_LINKSTARTUP when the quirk is set

**Commit 2 (Target - 72c00712c6cdb):** "scsi: ufs: ufs-pci: Set UFSHCD_QUIRK_PERFORM_LINK_STARTUP_ONCE for Intel ADL"
- Modified drivers/ufs/host/ufshcd-pci.c:463 in `ufs_intel_adl_init()` function
- Added `| UFSHCD_QUIRK_PERFORM_LINK_STARTUP_ONCE` to the quirks assignment
- This enables the quirk for Intel Alder Lake UFS controllers

### Changes Made
1. **include/ufs/ufshcd.h**: Added quirk definition (7 lines added)
2. **drivers/ufs/core/ufshcd.c**: Added quirk check in link startup logic (1 line modified to 2 lines)
3. **drivers/ufs/host/ufshcd-pci.c**: Applied quirk to Intel ADL controllers (1 line modified to 2 lines)

### Build Status
✅ **Build successful** - Exit code 0 with no new warnings or errors

### Divergence from Original
- **Minimal**: The quirk is defined at bit position 19 instead of 26 (as in mainline), but this is necessary because kernel 6.1 doesn't have the intermediate quirks (bits 19-25)
- All other aspects match the original commits exactly (logic, comments, author, commit messages)
- No functions added, no major modifications

Both commits have been successfully applied with original authorship preserved.
================================================================================

Backport verification analysis (via Codex):
================================================================================
2025-11-10T01:29:25.908288Z ERROR rmcp::transport::async_rw: Error reading from stream: serde error data did not match any variant of untagged enum JsonRpcMessage
OpenAI Codex v0.50.0 (research preview)
--------
workdir: /home/sasha/tmp/stable-parse-fail-6.1-1762735681
model: gpt-5-codex
provider: openai
approval: never
sandbox: workspace-write [workdir, /tmp, $TMPDIR]
reasoning effort: high
reasoning summaries: auto
session id: 019a6b61-d889-7a80-a813-ac37cc87e1c4
--------
user
ultrathink: Please analyze the following diff between the upstream commit and the backport of it in HEAD to verify that the backport is correct and doesn't contain any issues.

Original commit that was being applied: d968e99488c4b08259a324a89e4ed17bf36561a4
Newly created commit with resolved conflicts: ade2adc85103868e458c74524453de1baa72b17d

Output from compare-upstream-patches.sh:
================================================================================
Found upstream SHA in commit message: d968e99488c4b08259a324a89e4ed17bf36561a4

Local commit message:
====================
  scsi: ufs: ufs-pci: Set UFSHCD_QUIRK_PERFORM_LINK_STARTUP_ONCE for Intel ADL

  [ Upstream commit d968e99488c4b08259a324a89e4ed17bf36561a4 ]

  Link startup becomes unreliable for Intel Alder Lake based host
  controllers when a 2nd DME_LINKSTARTUP is issued unnecessarily.  Employ
  UFSHCD_QUIRK_PERFORM_LINK_STARTUP_ONCE to suppress that from happening.

  Fixes: 7dc9fb47bc9a ("scsi: ufs: ufs-pci: Add support for Intel ADL")
  Cc: stable@vger.kernel.org
  Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
  Reviewed-by: Bart Van Assche <bvanassche@acm.org>
  Link: https://patch.msgid.link/20251024085918.31825-4-adrian.hunter@intel.com
  Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
  Signed-off-by: Sasha Levin <sashal@kernel.org>

Comparing patches between:
  Local:    HEAD
  Upstream: d968e99488c4b08259a324a89e4ed17bf36561a4

Patches differ. Showing differences:
==================================================
--- upstream
+++ local
@@ -1,8 +1,8 @@
 diff --git a/drivers/ufs/host/ufshcd-pci.c b/drivers/ufs/host/ufshcd-pci.c
-index 89f88b6938502..5f65dfad1a71a 100644
+index c548c726e7f63..4efac5d6796e5 100644
 --- a/drivers/ufs/host/ufshcd-pci.c
 +++ b/drivers/ufs/host/ufshcd-pci.c
-@@ -428,7 +428,8 @@ static int ufs_intel_lkf_init(struct ufs_hba *hba)
+@@ -460,7 +460,8 @@ static int ufs_intel_lkf_init(struct ufs_hba *hba)
  static int ufs_intel_adl_init(struct ufs_hba *hba)
  {
  	hba->nop_out_timeout = 200;
================================================================================

Also review the conflict resolution that was performed:
================================================================================
## Conflict Resolution Summary

Successfully resolved the conflict and applied commit d968e99488c4b! Here's the detailed explanation:

### The Problem
The original commit d968e99488c4b attempted to use `UFSHCD_QUIRK_PERFORM_LINK_STARTUP_ONCE`, but this quirk constant didn't exist in kernel 6.1, causing a build failure:
```
error: 'UFSHCD_QUIRK_PERFORM_LINK_STARTUP_ONCE' undeclared
```

### Root Cause Analysis
The commit had an unmet dependency: it required commit d34caa89a132c which introduces the `UFSHCD_QUIRK_PERFORM_LINK_STARTUP_ONCE` quirk definition. However, that prerequisite commit had merge conflicts because:
- Mainline kernel added many additional quirks (bits 19-26) between kernel 6.1 and the target version
- Kernel 6.1 only has quirks up to bit 18 (`UFSHCD_QUIRK_HIBERN_FASTAUTO`)

### Resolution Strategy
I manually backported the prerequisite changes with minimal modifications:

**Commit 1 (Prerequisite - 4b8ed7e65f99d):** "scsi: ufs: core: Add a quirk to suppress link_startup_again"
- Added `UFSHCD_QUIRK_PERFORM_LINK_STARTUP_ONCE` definition at bit 19 (next available position) in include/ufs/ufshcd.h:601
- Modified drivers/ufs/core/ufshcd.c:4781 to check the quirk before setting `link_startup_again`
- This prevents the 2nd DME_LINKSTARTUP when the quirk is set

**Commit 2 (Target - 72c00712c6cdb):** "scsi: ufs: ufs-pci: Set UFSHCD_QUIRK_PERFORM_LINK_STARTUP_ONCE for Intel ADL"
- Modified drivers/ufs/host/ufshcd-pci.c:463 in `ufs_intel_adl_init()` function
- Added `| UFSHCD_QUIRK_PERFORM_LINK_STARTUP_ONCE` to the quirks assignment
- This enables the quirk for Intel Alder Lake UFS controllers

### Changes Made
1. **include/ufs/ufshcd.h**: Added quirk definition (7 lines added)
2. **drivers/ufs/core/ufshcd.c**: Added quirk check in link startup logic (1 line modified to 2 lines)
3. **drivers/ufs/host/ufshcd-pci.c**: Applied quirk to Intel ADL controllers (1 line modified to 2 lines)

### Build Status
✅ **Build successful** - Exit code 0 with no new warnings or errors

### Divergence from Original
- **Minimal**: The quirk is defined at bit position 19 instead of 26 (as in mainline), but this is necessary because kernel 6.1 doesn't have the intermediate quirks (bits 19-25)
- All other aspects match the original commits exactly (logic, comments, author, commit messages)
- No functions added, no major modifications

Both commits have been successfully applied with original authorship preserved.
================================================================================

Please provide a detailed analysis covering:
1. Whether the backport correctly preserves the intent of the upstream commit
2. Any differences between upstream and backport and whether they are justified
3. Any potential issues or concerns with the backport
4. Overall assessment of the backport quality

Be thorough in your analysis as this will be documented for future reference.
Plan update
  → Inspect repository state and obtain relevant commits for analysis.
  • Compare upstream commit to backport and identify differences.
  • Assess impact, intent preservation, and potential issues; summarize findings.
exec
bash -lc 'cd /home/sasha/tmp/stable-parse-fail-6.1-1762735681 && git status --short' in /home/sasha/tmp/stable-parse-fail-6.1-1762735681 succeeded in 98ms:
?? tmp.cmt
exec
bash -lc 'cd /home/sasha/tmp/stable-parse-fail-6.1-1762735681 && git show d968e99488c4b08259a324a89e4ed17bf36561a4' in /home/sasha/tmp/stable-parse-fail-6.1-1762735681 succeeded in 22ms:
commit d968e99488c4b08259a324a89e4ed17bf36561a4
Author: Adrian Hunter <adrian.hunter@intel.com>
Date:   Fri Oct 24 11:59:17 2025 +0300

    scsi: ufs: ufs-pci: Set UFSHCD_QUIRK_PERFORM_LINK_STARTUP_ONCE for Intel ADL

    Link startup becomes unreliable for Intel Alder Lake based host
    controllers when a 2nd DME_LINKSTARTUP is issued unnecessarily.  Employ
    UFSHCD_QUIRK_PERFORM_LINK_STARTUP_ONCE to suppress that from happening.

    Fixes: 7dc9fb47bc9a ("scsi: ufs: ufs-pci: Add support for Intel ADL")
    Cc: stable@vger.kernel.org
    Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
    Reviewed-by: Bart Van Assche <bvanassche@acm.org>
    Link: https://patch.msgid.link/20251024085918.31825-4-adrian.hunter@intel.com
    Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>

diff --git a/drivers/ufs/host/ufshcd-pci.c b/drivers/ufs/host/ufshcd-pci.c
index 89f88b6938502..5f65dfad1a71a 100644
--- a/drivers/ufs/host/ufshcd-pci.c
exec
bash -lc 'cd /home/sasha/tmp/stable-parse-fail-6.1-1762735681 && git show ade2adc85103868e458c74524453de1baa72b17d' in /home/sasha/tmp/stable-parse-fail-6.1-1762735681 succeeded in 21ms:
commit ade2adc85103868e458c74524453de1baa72b17d
Author: Adrian Hunter <adrian.hunter@intel.com>
Date:   Fri Oct 24 11:59:17 2025 +0300

    scsi: ufs: ufs-pci: Set UFSHCD_QUIRK_PERFORM_LINK_STARTUP_ONCE for Intel ADL

    [ Upstream commit d968e99488c4b08259a324a89e4ed17bf36561a4 ]

    Link startup becomes unreliable for Intel Alder Lake based host
    controllers when a 2nd DME_LINKSTARTUP is issued unnecessarily.  Employ
    UFSHCD_QUIRK_PERFORM_LINK_STARTUP_ONCE to suppress that from happening.

    Fixes: 7dc9fb47bc9a ("scsi: ufs: ufs-pci: Add support for Intel ADL")
    Cc: stable@vger.kernel.org
    Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
    Reviewed-by: Bart Van Assche <bvanassche@acm.org>
    Link: https://patch.msgid.link/20251024085918.31825-4-adrian.hunter@intel.com
    Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
    Signed-off-by: Sasha Levin <sashal@kernel.org>

exec
bash -lc 'cd /home/sasha/tmp/stable-parse-fail-6.1-1762735681 && git log -2 --oneline' in /home/sasha/tmp/stable-parse-fail-6.1-1762735681 succeeded in 19ms:
ade2adc851038 scsi: ufs: ufs-pci: Set UFSHCD_QUIRK_PERFORM_LINK_STARTUP_ONCE for Intel ADL
4b8ed7e65f99d scsi: ufs: core: Add a quirk to suppress link_startup_again
exec
bash -lc 'cd /home/sasha/tmp/stable-parse-fail-6.1-1762735681 && git show 4b8ed7e65f99d' in /home/sasha/tmp/stable-parse-fail-6.1-1762735681 succeeded in 30ms:
commit 4b8ed7e65f99d29a98e83587707474d9407b8266
Author: Adrian Hunter <adrian.hunter@intel.com>
Date:   Fri Oct 24 11:59:16 2025 +0300

    scsi: ufs: core: Add a quirk to suppress link_startup_again

    ufshcd_link_startup() has a facility (link_startup_again) to issue
    DME_LINKSTARTUP a 2nd time even though the 1st time was successful.

    Some older hardware benefits from that, however the behaviour is
    non-standard, and has been found to cause link startup to be unreliable
    for some Intel Alder Lake based host controllers.

    Add UFSHCD_QUIRK_PERFORM_LINK_STARTUP_ONCE to suppress
    link_startup_again, in preparation for setting the quirk for affected
    controllers.

    Fixes: 7dc9fb47bc9a ("scsi: ufs: ufs-pci: Add support for Intel ADL")
    Cc: stable@vger.kernel.org
    Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
exec
bash -lc 'cd /home/sasha/tmp/stable-parse-fail-6.1-1762735681 && git show d34caa89a132c' in /home/sasha/tmp/stable-parse-fail-6.1-1762735681 succeeded in 30ms:
commit d34caa89a132cd69efc48361d4772251546fdb88
Author: Adrian Hunter <adrian.hunter@intel.com>
Date:   Fri Oct 24 11:59:16 2025 +0300

    scsi: ufs: core: Add a quirk to suppress link_startup_again

    ufshcd_link_startup() has a facility (link_startup_again) to issue
    DME_LINKSTARTUP a 2nd time even though the 1st time was successful.

    Some older hardware benefits from that, however the behaviour is
    non-standard, and has been found to cause link startup to be unreliable
    for some Intel Alder Lake based host controllers.

    Add UFSHCD_QUIRK_PERFORM_LINK_STARTUP_ONCE to suppress
    link_startup_again, in preparation for setting the quirk for affected
    controllers.

    Fixes: 7dc9fb47bc9a ("scsi: ufs: ufs-pci: Add support for Intel ADL")
    Cc: stable@vger.kernel.org
    Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
exec
bash -lc "cd /home/sasha/tmp/stable-parse-fail-6.1-1762735681 && sed -n '560,620p' include/ufs/ufshcd.h" in /home/sasha/tmp/stable-parse-fail-6.1-1762735681 succeeded in 12ms:
	UFSHCD_QUIRK_BROKEN_AUTO_HIBERN8		= 1 << 11,

	/*
	 * This quirk needs to disable manual flush for write booster
	 */
	UFSHCI_QUIRK_SKIP_MANUAL_WB_FLUSH_CTRL		= 1 << 12,

	/*
	 * This quirk needs to disable unipro timeout values
	 * before power mode change
	 */
	UFSHCD_QUIRK_SKIP_DEF_UNIPRO_TIMEOUT_SETTING = 1 << 13,

	/*
	 * Align DMA SG entries on a 4 KiB boundary.
	 */
	UFSHCD_QUIRK_4KB_DMA_ALIGNMENT			= 1 << 14,

	/*
	 * This quirk needs to be enabled if the host controller does not
exec
bash -lc "cd /home/sasha/tmp/stable-parse-fail-6.1-1762735681 && sed -n '440,520p' drivers/ufs/host/ufshcd-pci.c" in /home/sasha/tmp/stable-parse-fail-6.1-1762735681 succeeded in 14ms:
	} else {
		hba->spm_lvl = UFS_PM_LVL_5;
		hba->rpm_lvl = UFS_PM_LVL_5;
	}
}

static int ufs_intel_lkf_init(struct ufs_hba *hba)
{
	struct ufs_host *ufs_host;
	int err;

	hba->nop_out_timeout = 200;
	hba->quirks |= UFSHCD_QUIRK_BROKEN_AUTO_HIBERN8;
	hba->caps |= UFSHCD_CAP_CRYPTO;
	err = ufs_intel_common_init(hba);
	ufs_host = ufshcd_get_variant(hba);
	ufs_host->late_init = ufs_intel_lkf_late_init;
	return err;
}

exec
bash -lc 'cd /home/sasha/tmp/stable-parse-fail-6.1-1762735681 && git diff d968e99488c4b08259a324a89e4ed17bf36561a4 ade2adc85103868e458c74524453de1baa72b17d -- drivers/ufs/host/ufshcd-pci.c' in /home/sasha/tmp/stable-parse-fail-6.1-1762735681 succeeded in 28ms:
diff --git a/drivers/ufs/host/ufshcd-pci.c b/drivers/ufs/host/ufshcd-pci.c
index 5f65dfad1a71a..4efac5d6796e5 100644
--- a/drivers/ufs/host/ufshcd-pci.c
+++ b/drivers/ufs/host/ufshcd-pci.c
@@ -15,13 +15,14 @@
 #include <linux/pci.h>
 #include <linux/pm_runtime.h>
 #include <linux/pm_qos.h>
-#include <linux/suspend.h>
 #include <linux/debugfs.h>
 #include <linux/uuid.h>
 #include <linux/acpi.h>
 #include <linux/gpio/consumer.h>

-#define MAX_SUPP_MAC 64
+struct ufs_host {
+	void (*late_init)(struct ufs_hba *hba);
+};

 enum intel_ufs_dsm_func_id {
exec
bash -lc "cd /home/sasha/tmp/stable-parse-fail-6.1-1762735681 && sed -n '4720,4800p' drivers/ufs/core/ufshcd.c" in /home/sasha/tmp/stable-parse-fail-6.1-1762735681 succeeded in 14ms:
		ufshcd_dme_peer_get(hba, UIC_ARG_MIB(PA_CONNECTEDTXDATALANES),
				    &tx_lanes);
	for (i = 0; i < tx_lanes; i++) {
		if (!peer)
			err = ufshcd_dme_set(hba,
				UIC_ARG_MIB_SEL(TX_LCC_ENABLE,
					UIC_ARG_MPHY_TX_GEN_SEL_INDEX(i)),
					0);
		else
			err = ufshcd_dme_peer_set(hba,
				UIC_ARG_MIB_SEL(TX_LCC_ENABLE,
					UIC_ARG_MPHY_TX_GEN_SEL_INDEX(i)),
					0);
		if (err) {
			dev_err(hba->dev, "%s: TX LCC Disable failed, peer = %d, lane = %d, err = %d",
				__func__, peer, i, err);
			break;
		}
	}

exec
bash -lc 'cd /home/sasha/tmp/stable-parse-fail-6.1-1762735681 && rg "PERFORM_LINK_STARTUP_ONCE" -n' in /home/sasha/tmp/stable-parse-fail-6.1-1762735681 succeeded in 131ms:
drivers/ufs/core/ufshcd.c:4781:	if (!(hba->quirks & UFSHCD_QUIRK_PERFORM_LINK_STARTUP_ONCE) &&
drivers/ufs/host/ufshcd-pci.c:464:		       UFSHCD_QUIRK_PERFORM_LINK_STARTUP_ONCE;
tmp.cmt:1:scsi: ufs: ufs-pci: Set UFSHCD_QUIRK_PERFORM_LINK_STARTUP_ONCE for Intel ADL
tmp.cmt:7:UFSHCD_QUIRK_PERFORM_LINK_STARTUP_ONCE to suppress that from happening.
include/ufs/ufshcd.h:601:	UFSHCD_QUIRK_PERFORM_LINK_STARTUP_ONCE		= 1 << 19,
Plan update
  ✓ Inspect repository state and obtain relevant commits for analysis.
  → Compare upstream commit to backport and identify differences.
  • Assess impact, intent preservation, and potential issues; summarize findings.
exec
bash -lc 'cd /home/sasha/tmp/stable-parse-fail-6.1-1762735681 && git diff d34caa89a132cd69efc48361d4772251546fdb88 4b8ed7e65f99d29a98e83587707474d9407b8266' in /home/sasha/tmp/stable-parse-fail-6.1-1762735681 exited 124 in 10.10s:
diff --git a/.clang-format b/.clang-format
index f371a13b4d192..8d01225bfcb7d 100644
--- a/.clang-format
+++ b/.clang-format
@@ -4,7 +4,7 @@
 #
 # For more information, see:
 #
-#   Documentation/dev-tools/clang-format.rst
+#   Documentation/process/clang-format.rst
 #   https://clang.llvm.org/docs/ClangFormat.html
 #   https://clang.llvm.org/docs/ClangFormatStyleOptions.html
 #
@@ -82,17 +82,11 @@ ForEachMacros:
   - '__for_each_thread'
   - '__hlist_for_each_rcu'
   - '__map__for_each_symbol_by_name'
-  - '__pci_bus_for_each_res0'
-  - '__pci_bus_for_each_res1'
-  - '__pci_dev_for_each_res0'
exec
bash -lc 'cd /home/sasha/tmp/stable-parse-fail-6.1-1762735681 && git diff d34caa89a132cd69efc48361d4772251546fdb88 4b8ed7e65f99d29a98e83587707474d9407b8266 -- drivers/ufs/core/ufshcd.c include/ufs/ufshcd.h' in /home/sasha/tmp/stable-parse-fail-6.1-1762735681 succeeded in 40ms:
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 453a99ec6282c..acdad8a79cc10 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -20,7 +20,6 @@
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
-#include <linux/pm_opp.h>
 #include <linux/regulator/consumer.h>
 #include <linux/sched/clock.h>
 #include <linux/iopoll.h>
@@ -36,20 +35,18 @@
 #include "ufs-fault-injection.h"
 #include "ufs_bsg.h"
 #include "ufshcd-crypto.h"
-#include <linux/unaligned.h>
+#include "ufshpb.h"
+#include <asm/unaligned.h>

Plan update
  ✓ Inspect repository state and obtain relevant commits for analysis.
  ✓ Compare upstream commit to backport and identify differences.
  → Assess impact, intent preservation, and potential issues; summarize findings.
exec
bash -lc 'cd /home/sasha/tmp/stable-parse-fail-6.1-1762735681 && rg "1 << 19" include/ufs/ufshcd.h' in /home/sasha/tmp/stable-parse-fail-6.1-1762735681 succeeded in 15ms:
	UFSHCD_QUIRK_PERFORM_LINK_STARTUP_ONCE		= 1 << 19,
exec
bash -lc 'cd /home/sasha/tmp/stable-parse-fail-6.1-1762735681 && rg "link_startup_again" -n' in /home/sasha/tmp/stable-parse-fail-6.1-1762735681 succeeded in 103ms:
drivers/ufs/core/ufshcd.c:4775:	bool link_startup_again = false;
drivers/ufs/core/ufshcd.c:4783:		link_startup_again = true;
drivers/ufs/core/ufshcd.c:4822:	if (link_startup_again) {
drivers/ufs/core/ufshcd.c:4823:		link_startup_again = false;
include/ufs/ufshcd.h:598:	 * time (refer link_startup_again) after the 1st time was successful,
exec
bash -lc "cd /home/sasha/tmp/stable-parse-fail-6.1-1762735681 && sed -n '4800,4860p' drivers/ufs/core/ufshcd.c" in /home/sasha/tmp/stable-parse-fail-6.1-1762735681 succeeded in 14ms:

		/*
		 * DME link lost indication is only received when link is up,
		 * but we can't be sure if the link is up until link startup
		 * succeeds. So reset the local Uni-Pro and try again.
		 */
		if (ret && retries && ufshcd_hba_enable(hba)) {
			ufshcd_update_evt_hist(hba,
					       UFS_EVT_LINK_STARTUP_FAIL,
					       (u32)ret);
			goto out;
		}
	} while (ret && retries--);

	if (ret) {
		/* failed to get the link up... retire */
		ufshcd_update_evt_hist(hba,
				       UFS_EVT_LINK_STARTUP_FAIL,
				       (u32)ret);
		goto out;
exec
bash -lc "cd /home/sasha/tmp/stable-parse-fail-6.1-1762735681 && sed -n '540,620p' include/ufs/ufshcd.h" in /home/sasha/tmp/stable-parse-fail-6.1-1762735681 succeeded in 14ms:
	 * enabled via HCE register.
	 */
	UFSHCI_QUIRK_BROKEN_HCE				= 1 << 8,

	/*
	 * This quirk needs to be enabled if the host controller regards
	 * resolution of the values of PRDTO and PRDTL in UTRD as byte.
	 */
	UFSHCD_QUIRK_PRDT_BYTE_GRAN			= 1 << 9,

	/*
	 * This quirk needs to be enabled if the host controller reports
	 * OCS FATAL ERROR with device error through sense data
	 */
	UFSHCD_QUIRK_BROKEN_OCS_FATAL_ERROR		= 1 << 10,

	/*
	 * This quirk needs to be enabled if the host controller has
	 * auto-hibernate capability but it doesn't work.
	 */
exec
bash -lc "cd /home/sasha/tmp/stable-parse-fail-6.1-1762735681 && nl -ba drivers/ufs/host/ufshcd-pci.c | sed -n '448,480p'" in /home/sasha/tmp/stable-parse-fail-6.1-1762735681 succeeded in 14ms:
   448		struct ufs_host *ufs_host;
   449		int err;
   450
   451		hba->nop_out_timeout = 200;
   452		hba->quirks |= UFSHCD_QUIRK_BROKEN_AUTO_HIBERN8;
   453		hba->caps |= UFSHCD_CAP_CRYPTO;
   454		err = ufs_intel_common_init(hba);
   455		ufs_host = ufshcd_get_variant(hba);
   456		ufs_host->late_init = ufs_intel_lkf_late_init;
   457		return err;
   458	}
   459
   460	static int ufs_intel_adl_init(struct ufs_hba *hba)
   461	{
   462		hba->nop_out_timeout = 200;
   463		hba->quirks |= UFSHCD_QUIRK_BROKEN_AUTO_HIBERN8 |
   464			       UFSHCD_QUIRK_PERFORM_LINK_STARTUP_ONCE;
   465		hba->caps |= UFSHCD_CAP_WB_EN;
   466		return ufs_intel_common_init(hba);
   467	}
exec
bash -lc "cd /home/sasha/tmp/stable-parse-fail-6.1-1762735681 && nl -ba include/ufs/ufshcd.h | sed -n '580,610p'" in /home/sasha/tmp/stable-parse-fail-6.1-1762735681 succeeded in 16ms:
   580		 * support UIC command
   581		 */
   582		UFSHCD_QUIRK_BROKEN_UIC_CMD			= 1 << 15,
   583
   584		/*
   585		 * This quirk needs to be enabled if the host controller cannot
   586		 * support physical host configuration.
   587		 */
   588		UFSHCD_QUIRK_SKIP_PH_CONFIGURATION		= 1 << 16,
   589
   590		/*
   591		 * This quirk needs to be enabled if the host controller has
   592		 * auto-hibernate capability but it's FASTAUTO only.
   593		 */
   594		UFSHCD_QUIRK_HIBERN_FASTAUTO			= 1 << 18,
   595
   596		/*
   597		 * This quirk indicates that DME_LINKSTARTUP should not be issued a 2nd
   598		 * time (refer link_startup_again) after the 1st time was successful,
   599		 * because it causes link startup to become unreliable.
exec
bash -lc "cd /home/sasha/tmp/stable-parse-fail-6.1-1762735681 && nl -ba drivers/ufs/core/ufshcd.c | sed -n '4760,4800p'" in /home/sasha/tmp/stable-parse-fail-6.1-1762735681 succeeded in 14ms:
  4760
  4761		ufshcd_vops_event_notify(hba, id, &val);
  4762	}
  4763	EXPORT_SYMBOL_GPL(ufshcd_update_evt_hist);
  4764
  4765	/**
  4766	 * ufshcd_link_startup - Initialize unipro link startup
  4767	 * @hba: per adapter instance
  4768	 *
  4769	 * Returns 0 for success, non-zero in case of failure
  4770	 */
  4771	static int ufshcd_link_startup(struct ufs_hba *hba)
  4772	{
  4773		int ret;
  4774		int retries = DME_LINKSTARTUP_RETRIES;
  4775		bool link_startup_again = false;
  4776
  4777		/*
  4778		 * If UFS device isn't active then we will have to issue link startup
  4779		 * 2 times to make sure the device state move to active.
exec
bash -lc 'cd /home/sasha/tmp/stable-parse-fail-6.1-1762735681 && rg "QUIRK.*19" include/ufs -n' in /home/sasha/tmp/stable-parse-fail-6.1-1762735681 succeeded in 18ms:
include/ufs/ufshcd.h:601:	UFSHCD_QUIRK_PERFORM_LINK_STARTUP_ONCE		= 1 << 19,
Plan update
  ✓ Inspect repository state and obtain relevant commits for analysis.
  ✓ Compare upstream commit to backport and identify differences.
  ✓ Assess impact, intent preservation, and potential issues; summarize findings.
codex
**Backport Review**
- Intent preserved: the backported change sets `UFSHCD_QUIRK_PERFORM_LINK_STARTUP_ONCE` alongside the existing `UFSHCD_QUIRK_BROKEN_AUTO_HIBERN8` in `ufs_intel_adl_init()` exactly like upstream, so Intel ADL hosts will skip the second `DME_LINKSTARTUP` attempt (drivers/ufs/host/ufshcd-pci.c:460-465).
- Prerequisite handling: the preceding backport adds the new quirk flag and guards the retry logic in `ufshcd_link_startup()` in the same way as upstream, ensuring the flag actually suppresses the second startup attempt (include/ufs/ufshcd.h:594-601, drivers/ufs/core/ufshcd.c:4771-4783).
- Differences vs upstream: the only intentional divergence is that the quirk uses bit 19 instead of bit 26 because the 6.1 header lacks the newer quirk defines occupying bits 19–25 in mainline; this keeps the bitmap collision-free while preserving semantics.
- Risk assessment: no other code references bit 19, the new guard simply leaves retry behaviour unchanged when the quirk is absent, and the quirk is applied only to ADL hardware, so the change is scoped and matches upstream behaviour.
- Conclusion: the backport faithfully reproduces the upstream fix with the necessary, justified bit-position adjustment; no issues found.
tokens used
33,680
**Backport Review**
- Intent preserved: the backported change sets `UFSHCD_QUIRK_PERFORM_LINK_STARTUP_ONCE` alongside the existing `UFSHCD_QUIRK_BROKEN_AUTO_HIBERN8` in `ufs_intel_adl_init()` exactly like upstream, so Intel ADL hosts will skip the second `DME_LINKSTARTUP` attempt (drivers/ufs/host/ufshcd-pci.c:460-465).
- Prerequisite handling: the preceding backport adds the new quirk flag and guards the retry logic in `ufshcd_link_startup()` in the same way as upstream, ensuring the flag actually suppresses the second startup attempt (include/ufs/ufshcd.h:594-601, drivers/ufs/core/ufshcd.c:4771-4783).
- Differences vs upstream: the only intentional divergence is that the quirk uses bit 19 instead of bit 26 because the 6.1 header lacks the newer quirk defines occupying bits 19–25 in mainline; this keeps the bitmap collision-free while preserving semantics.
- Risk assessment: no other code references bit 19, the new guard simply leaves retry behaviour unchanged when the quirk is absent, and the quirk is applied only to ADL hardware, so the change is scoped and matches upstream behaviour.
- Conclusion: the backport faithfully reproduces the upstream fix with the necessary, justified bit-position adjustment; no issues found.
================================================================================

This is an empty commit for documentation purposes only.
-- 
2.51.0


