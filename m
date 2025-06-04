Return-Path: <stable+bounces-150979-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F58ACD2DE
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 03:11:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1303C18872BB
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 01:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDFE62580CA;
	Wed,  4 Jun 2025 00:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NFanMBCe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F711F5F6;
	Wed,  4 Jun 2025 00:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748998716; cv=none; b=dxYlfjR0jmTFlWuiXWpZvfw5E/zbaiosvYc9fyHL4IDJoTKXV1jXFuizHRALyMG84ahtkS2M2yLVxR5Qz1SNd0yIKq5rS37o7aT65dNMC4QCdcPrezhiUggWPLGECNCO/HNYpxCfQ+0YQ22u8N1BEhRqQUpvrpPHcgIdrzlzBNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748998716; c=relaxed/simple;
	bh=ovsf5GtaY/VVKUIYJfgF8E3h064oPlR2YLGzYGLhdIU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cFLSwpIKzjp2j+EqYQewvRH2tjM4UWYpmKsmXMly04zQSOGFWnQJVV0a3Ub/RCoMgeKNOr6xPTPJnIhb1kjsnIkRU/gKUsKCvDmjdhYXpNpN/Ww7EsIjm7fImugn2gkeKSGfKV94vV28A3nQsNUvqJ1HqNX6N7ChyMf9JW5drMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NFanMBCe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AFE9C4CEED;
	Wed,  4 Jun 2025 00:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748998716;
	bh=ovsf5GtaY/VVKUIYJfgF8E3h064oPlR2YLGzYGLhdIU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NFanMBCenqYLGrMu/bgDKgjk4dwvFoW5wqhRsiYlzZI+owpdPDCmE7ekAkQ66T2gF
	 aDtEaBf05YwyJf3hX/+ANOvSRkJUK3U9GKu4tq+7jide87X+Aolu7Tlvp/o6l1J2d9
	 noN6EPEp2lSy/e2qUw2PwTAvgtFWIivwt6w4q/UkJDEK25b+LIxiltME/pifjFAAIy
	 4zdzMYMm+ikAwYUXb0ueuaJSVSaKszkuz0cx8nZDmuGFIqiivm1fG+TvEdWdnM/Xzr
	 vSrW7aIHANdelmxVODMF5DwFJ4leBMr6M8rqWn1SCey8pQzwC8R7onuBmx3kQqnQSP
	 ht8umFXHOtj6A==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Daniel Wagner <wagi@kernel.org>,
	Justin Tee <justin.tee@broadcom.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	james.smart@broadcom.com,
	dick.kennedy@broadcom.com,
	linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 090/108] scsi: lpfc: Use memcpy() for BIOS version
Date: Tue,  3 Jun 2025 20:55:13 -0400
Message-Id: <20250604005531.4178547-90-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250604005531.4178547-1-sashal@kernel.org>
References: <20250604005531.4178547-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.9
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Daniel Wagner <wagi@kernel.org>

[ Upstream commit ae82eaf4aeea060bb736c3e20c0568b67c701d7d ]

The strlcat() with FORTIFY support is triggering a panic because it
thinks the target buffer will overflow although the correct target
buffer size is passed in.

Anyway, instead of memset() with 0 followed by a strlcat(), just use
memcpy() and ensure that the resulting buffer is NULL terminated.

BIOSVersion is only used for the lpfc_printf_log() which expects a
properly terminated string.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
Link: https://lore.kernel.org/r/20250409-fix-lpfc-bios-str-v1-1-05dac9e51e13@kernel.org
Reviewed-by: Justin Tee <justin.tee@broadcom.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

Let me understand the actual problem by examining the function more
carefully. Based on the commit message, this is about a FORTIFY panic
when using strlcat(): **YES** This commit should be backported to stable
kernel trees. Here's my extensive analysis: ## Bug Analysis **Root
Cause:** The commit fixes a kernel panic triggered by FORTIFY_SOURCE
when using `strlcat()`. The FORTIFY infrastructure incorrectly detected
a potential buffer overflow in the BIOS version string handling code.
**The Problem Code:** ```c memset(phba->BIOSVersion, 0,
sizeof(phba->BIOSVersion)); strlcat(phba->BIOSVersion, (char
*)cntl_attr->bios_ver_str, sizeof(phba->BIOSVersion)); ``` **The Fix:**
```c memcpy(phba->BIOSVersion, cntl_attr->bios_ver_str,
sizeof(phba->BIOSVersion)); phba->BIOSVersion[sizeof(phba->BIOSVersion)
- 1] = '\0'; ``` ## Technical Details 1. **Buffer Sizes:** `BIOSVersion`
is a 16-byte character array (`char BIOSVersion[16]` in lpfc.h:1267),
while `bios_ver_str` is a 32-byte array (`uint32_t bios_ver_str[8]` in
lpfc_hw4.h:3798). 2. **FORTIFY Issue:** The `strlcat()` function with
FORTIFY enabled was triggering a false positive, causing kernel panics
when it incorrectly calculated potential overflow conditions. 3. **Safe
Solution:** The fix uses `memcpy()` for the exact buffer size and
explicitly null-terminates the string, which is simpler and avoids the
FORTIFY false positive. ## Backport Criteria Analysis ✅ **Fixes
Important Bug:** This resolves kernel panics in production systems with
FORTIFY enabled ✅ **Small & Contained:** Only 3 lines changed in a
single function ✅ **Minimal Risk:** The change is functionally
equivalent but safer ✅ **No Architectural Changes:** Simple string
handling improvement ✅ **Clear Side Effects:** No behavioral changes
beyond fixing the panic ✅ **Critical Subsystem:** SCSI driver stability
is important for storage ## Comparison with Similar Commits This closely
resembles **Similar Commit #2** (marked YES for backport) which fixed an
overflow build issue with FORTIFY. Both commits: - Address FORTIFY-
related compilation/runtime issues - Make minimal, safe code changes -
Fix real problems affecting users - Have low regression risk ## Risk
Assessment **Low Risk:** The change maintains identical functionality
while eliminating the false positive. Both code paths copy BIOS version
data into a 16-byte buffer and ensure null termination. The `memcpy()`
approach is actually more predictable than `strlcat()` with an empty
target buffer. ## Conclusion This commit fixes a real kernel panic issue
that affects users running kernels with FORTIFY_SOURCE enabled. The fix
is minimal, safe, and follows stable tree guidelines perfectly. It
should definitely be backported to prevent production systems from
experiencing these panics.

 drivers/scsi/lpfc/lpfc_sli.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
index 92f3d44237290..b83700cce6c52 100644
--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -6006,9 +6006,9 @@ lpfc_sli4_get_ctl_attr(struct lpfc_hba *phba)
 	phba->sli4_hba.flash_id = bf_get(lpfc_cntl_attr_flash_id, cntl_attr);
 	phba->sli4_hba.asic_rev = bf_get(lpfc_cntl_attr_asic_rev, cntl_attr);
 
-	memset(phba->BIOSVersion, 0, sizeof(phba->BIOSVersion));
-	strlcat(phba->BIOSVersion, (char *)cntl_attr->bios_ver_str,
+	memcpy(phba->BIOSVersion, cntl_attr->bios_ver_str,
 		sizeof(phba->BIOSVersion));
+	phba->BIOSVersion[sizeof(phba->BIOSVersion) - 1] = '\0';
 
 	lpfc_printf_log(phba, KERN_INFO, LOG_SLI,
 			"3086 lnk_type:%d, lnk_numb:%d, bios_ver:%s, "
-- 
2.39.5


