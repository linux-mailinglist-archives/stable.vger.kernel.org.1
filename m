Return-Path: <stable+bounces-225819-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AG+EG4k8uWkowQEAu9opvQ
	(envelope-from <stable+bounces-225819-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 12:35:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DC9572A8EF7
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 12:35:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BA9183090FF5
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 11:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A003AE6E8;
	Tue, 17 Mar 2026 11:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="frSNhP1J"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E133ACF19;
	Tue, 17 Mar 2026 11:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773747178; cv=none; b=n9QL4gs3XVn2gXt5pHDOSQa4GzJJJQhCUx+EjB4F0XwH1rF0dmzMlyo9YjBi2Tac/nC+5WUKOcvEE1njdMLV6TO2ySHyLc5M4YRktJmLQpjjCQAlrmgFH7S6HVO+BmS2enAHf3BHkuoo+WNYecRABmGbRqZkMzKfZDsyM3burK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773747178; c=relaxed/simple;
	bh=HVIi7RFu9oTi3bTwhaiRIMmCFs5v2RD14fg/Ytl+ROU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TavVHlCRT2++7V6FA4DK5EaelngUtl9Ws9GXwlc62DgI6JO1FER+pnVwpBS23lwEDGwjGBPJANFyM53pJL1FtMN6rnPLmnfXHThdLFukiaEM9hDssPKqqCpzeuVF35YyouKBs4Oem7nBZJ92+emYOG1lmZFtmGJIGuSuMLgtnd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=frSNhP1J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 452A2C19425;
	Tue, 17 Mar 2026 11:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773747178;
	bh=HVIi7RFu9oTi3bTwhaiRIMmCFs5v2RD14fg/Ytl+ROU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=frSNhP1JGkkQUFTd5OZrVmc63bZdK+4NyWApgLLx6msx1B9SFjn5kBX0uHcefiUfr
	 SBSf+SnYR8xwWd0vOew2SsvN42l66NUW8hDTXRZskwLVLJxjh+IZ2k8fy7cVDRkthl
	 iXa5hMB36brGrRvn7NBp9RdNH6C8x0jzL82beB/eVVEXzAhG5twd1QTtRK+h6LH7sA
	 lrpRDG+DQabNKFJdq33OB5L7DjiGM4KjwXisjQqsHQbYKJJBZPh/zgTbxIRakImp6C
	 8dxXTX0wPcZw+SWd2Z7tK55Uez2R6SGKltGZxfPPkIRFDP1T5/b7r8CJ8oT7Gm9EqH
	 b+jbMq1TdHdSw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Yang Wang <kevinyang.wang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.19-6.12] drm/amdgpu: fix gpu idle power consumption issue for gfx v12
Date: Tue, 17 Mar 2026 07:32:37 -0400
Message-ID: <20260317113249.117771-6-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260317113249.117771-1-sashal@kernel.org>
References: <20260317113249.117771-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.19.8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[amd.com,kernel.org,gmail.com,ffwll.ch,lists.freedesktop.org,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225819-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,amd.com:email]
X-Rspamd-Queue-Id: DC9572A8EF7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Yang Wang <kevinyang.wang@amd.com>

[ Upstream commit a6571045cf06c4aa749b4801382ae96650e2f0e1 ]

Older versions of the MES firmware may cause abnormal GPU power consumption.
When performing inference tasks on the GPU (e.g., with Ollama using ROCm),
the GPU may show abnormal power consumption in idle state and incorrect GPU load information.
This issue has been fixed in firmware version 0x8b and newer.

Closes: https://github.com/ROCm/ROCm/issues/5706
Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 4e22a5fe6ea6e0b057e7f246df4ac3ff8bfbc46a)
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

## Analysis

### What the commit fixes

This commit fixes abnormal GPU power consumption in idle state for AMD
gfx v12 hardware when running with MES firmware versions older than
0x8b. Users running GPU inference workloads (e.g., Ollama with ROCm)
experience the GPU staying in high power state even when idle, with
incorrect GPU load reporting. The fix is tracked in a real bug report:
ROCm/ROCm#5706.

### Code change analysis

The change is minimal and surgical:

1. **Adds firmware version detection** (3 lines): Creates a `mes_rev`
   variable that extracts the MES firmware revision from either
   `sched_version` or `kiq_version` depending on the pipe type, masked
   with `AMDGPU_MES_VERSION_MASK` (0x00000fff).

2. **Conditionally sets oversubscription timer** (1 line changed):
   Changes `oversubscription_timer = 50` to `oversubscription_timer =
   mes_rev < 0x8b ? 0 : 50`. For older firmware, the timer is disabled
   (0 = disabled per the comment). For newer firmware (>= 0x8b where the
   bug is fixed), behavior is unchanged.

This follows an established pattern already present in the same function
at line 782, which checks `sched_version >= 0x82` for the LR compute
workaround.

### Stable kernel criteria assessment

- **Fixes a real bug**: Yes - abnormal idle power consumption is a real
  user-facing issue
- **Obviously correct**: Yes - the pattern is well-established in this
  file
- **Small and contained**: Yes - 4 lines added, 1 line modified, single
  file
- **No new features**: Correct - this is a firmware workaround/quirk
- **Risk assessment**: Very low - newer firmware behavior is unchanged;
  only disables the oversubscription timer for older firmware that can't
  handle it properly

### Classification

This is a **firmware quirk/workaround**, which falls under the "QUIRKS
and WORKAROUNDS" exception category for stable trees. It's analogous to
USB quirks or PCI quirks - working around buggy firmware behavior in a
targeted way.

### Applicability

The file `mes_v12_0.c` was introduced in v6.11-rc1, so this fix is
applicable to stable trees 6.11.y and later that support gfx v12
hardware.

### Verification

- Verified `AMDGPU_MES_VERSION_MASK` is defined as `0x00000fff` in
  `amdgpu_mes.h:40`
- Verified `sched_version` and `kiq_version` fields exist in the
  `amdgpu_mes` structure (`amdgpu_mes.h:78-79`)
- Verified the same firmware-version-check pattern already exists at
  `mes_v12_0.c:782` (checks `>= 0x82` for LR compute workaround)
- Verified `mes_v12_0.c` was first added in commit `785f0f9fe7420`
  ("drm/amdgpu: Add mes v12_0 ip block support (v4)"), first present in
  v6.11-rc1
- Verified the current code at line 793 still has the unconditional
  `oversubscription_timer = 50` (the fix is not yet applied on this
  branch)
- Verified the commit was acked by Alex Deucher (AMD GPU maintainer)
- Verified the upstream commit `4e22a5fe6ea6e0b` exists and is authored
  by Yang Wang
- Could NOT directly verify the ROCm issue #5706 content (would require
  web fetch, but the commit message description is clear)

### Conclusion

This is a small, well-scoped firmware workaround that fixes a real user-
facing power consumption bug on AMD gfx v12 hardware. It follows
established patterns in the codebase, carries minimal regression risk,
and is acked by the subsystem maintainer. It meets all stable kernel
criteria as a hardware/firmware quirk.

**YES**

 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index 744e95d3984ad..0d7e2dc414a81 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -731,6 +731,9 @@ static int mes_v12_0_set_hw_resources(struct amdgpu_mes *mes, int pipe)
 	int i;
 	struct amdgpu_device *adev = mes->adev;
 	union MESAPI_SET_HW_RESOURCES mes_set_hw_res_pkt;
+	uint32_t mes_rev = (pipe == AMDGPU_MES_SCHED_PIPE) ?
+		(mes->sched_version & AMDGPU_MES_VERSION_MASK) :
+		(mes->kiq_version & AMDGPU_MES_VERSION_MASK);
 
 	memset(&mes_set_hw_res_pkt, 0, sizeof(mes_set_hw_res_pkt));
 
@@ -790,7 +793,7 @@ static int mes_v12_0_set_hw_resources(struct amdgpu_mes *mes, int pipe)
 	 * handling support, other queue will not use the oversubscribe timer.
 	 * handling  mode - 0: disabled; 1: basic version; 2: basic+ version
 	 */
-	mes_set_hw_res_pkt.oversubscription_timer = 50;
+	mes_set_hw_res_pkt.oversubscription_timer = mes_rev < 0x8b ? 0 : 50;
 	mes_set_hw_res_pkt.unmapped_doorbell_handling = 1;
 
 	if (amdgpu_mes_log_enable) {
-- 
2.51.0


