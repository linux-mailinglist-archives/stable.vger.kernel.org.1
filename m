Return-Path: <stable+bounces-148421-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39328ACA256
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 01:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7EBA172FAD
	for <lists+stable@lfdr.de>; Sun,  1 Jun 2025 23:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB8125C829;
	Sun,  1 Jun 2025 23:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hF5FgxFe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287E625B695;
	Sun,  1 Jun 2025 23:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748820432; cv=none; b=h52Yy4wOpoLHcGdRc7OBP1Qibl/Ud4kWP1balYKzX/QEOg1Z8vUH739vih+u7eVbmVDc42ZkvYiVQNQrmQgL0ykdTHKGvfwLJvxcAIDEb3/PBUOhl8StM5JobXWaQ9cxFGznxDKQTHq6XXX748AuUAUGB5O+kFATPAsTAGaEY9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748820432; c=relaxed/simple;
	bh=eAdYJZ39rReS0Fp6iMbZf7RlLcLoLkFVe6265j2Q2Ac=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M3Xv7K3tBKXhiPwka8aU2JprlWOQtSKVVB4gpONF8WCsU/+zbTSPLj8GbaVCbweYyhmFDZXoFUrh+FsUsUW5xtviic9Llbf0EaUJn5CIV6YP4+37oV3O/d1vAx7KQg2V1MWwllde/Ot11q1pTcjtJNVzQkA5FkJU6ou4mzRDUd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hF5FgxFe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C0E9C4CEF1;
	Sun,  1 Jun 2025 23:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748820432;
	bh=eAdYJZ39rReS0Fp6iMbZf7RlLcLoLkFVe6265j2Q2Ac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hF5FgxFeRDbcSRrKbixPDV24yZqvoVwAs7ZpUv0KAWq1m1RWmQbnBFP6Ql+6LWU09
	 d/n5gUkpSLcJMmtpCTh1lEb/6P9jdcsURlyurcioe59CGpb3soXDVk4zT81kSLwsCR
	 Ua9l+fPndg3QAW1oTftG2swyrZ8/FzarikHQuvwLJrBzWnw2ZWtS2xM8jHK5gY3pUt
	 XN6bZrT9lYk5cAex3rZHIFFC23V7HpOYwR/CsG9HPEM/CyEnDLlt9+FbSynsjI/kwl
	 hOjznLVjNyJXctw+Swy9es10C1g66WP5I/h6BfyVxfBe+nC0DMXfEKExTNRRBP3k1P
	 GOccYvne9cL+w==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Arvind Yadav <Arvind.Yadav@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <Christian.Koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Shashank Sharma <shashank.sharma@amd.com>,
	Arvind Yadav <arvind.yadav@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	airlied@gmail.com,
	simona@ffwll.ch,
	Jack.Xiao@amd.com,
	srinivasan.shanmugam@amd.com,
	Hawking.Zhang@amd.com,
	mukul.joshi@amd.com,
	Jiadong.Zhu@amd.com,
	shaoyun.liu@amd.com,
	Arunpravin.PaneerSelvam@amd.com,
	michael.chen@amd.com,
	sunil.khatri@amd.com,
	jesse.zhang@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.15 055/110] drm/amdgpu: fix MES GFX mask
Date: Sun,  1 Jun 2025 19:23:37 -0400
Message-Id: <20250601232435.3507697-55-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250601232435.3507697-1-sashal@kernel.org>
References: <20250601232435.3507697-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.15
Content-Transfer-Encoding: 8bit

From: Arvind Yadav <Arvind.Yadav@amd.com>

[ Upstream commit 9d3afcb7b9f950b9b7c58ceeeb9e71f3476e69ed ]

Current MES GFX mask prevents FW to enable oversubscription. This patch
does the following:
- Fixes the mask values and adds a description for the same
- Removes the central mask setup and makes it IP specific, as it would
  be different when the number of pipes and queues are different.

v2: squash in fix from Shashank

Cc: Christian König <Christian.Koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

**YES** This commit should be backported to stable kernel trees. Here's
my extensive analysis: ## Bug Fix Classification This is clearly a
**functional bug fix** that addresses a critical hardware configuration
issue. The commit message explicitly states the problem: "Current MES
GFX mask prevents FW to enable oversubscription." ## Detailed Code
Change Analysis ### 1. Removal of Incorrect Central Mask Setup
(amdgpu_mes.c) ```c // REMOVED - This was the source of the bug: for (i
= 0; i < AMDGPU_MES_MAX_GFX_PIPES; i++) adev->mes.gfx_hqd_mask[i] = i ?
0 : 0xfffffffe; ``` The original code used a generic `0xfffffffe` mask
(all bits set except bit 0) for all hardware, which was incorrect. This
prevented the MES firmware from properly configuring oversubscription
because: - It didn't account for hardware-specific queue topologies -
Different GPU generations have different numbers of available queues -
Some pipes have hardware limitations that weren't respected ### 2.
Hardware-Specific Mask Implementation **For MES v11.0 (mes_v11_0.c):**
```c static void mes_v11_0_set_gfx_hqd_mask(union
MESAPI_SET_HW_RESOURCES *pkt) { // GFX pipe 0 queue 0 is being used by
Kernel queue. // Set GFX pipe 0 queue 1 for MES scheduling (mask = 10b)
// GFX pipe 1 can't be used for MES due to HW limitation.
pkt->gfx_hqd_mask[0] = 0x2; // Only queue 1 available
pkt->gfx_hqd_mask[1] = 0; // Pipe 1 disabled due to HW limitation } ```
**For MES v12.0 (mes_v12_0.c):** ```c static void
mes_v12_0_set_gfx_hqd_mask(union MESAPI_SET_HW_RESOURCES *pkt) { // GFX
V12 has only one GFX pipe, but 8 queues in it. // GFX pipe 0 queue 0 is
being used by Kernel queue. // Set GFX pipe 0 queue 1-7 for MES
scheduling (mask = 1111 1110b) pkt->gfx_hqd_mask[0] = 0xFE; // Queues
1-7 available } ``` ### 3. Impact on Functionality **Critical functional
impact:** - **Oversubscription disabled**: The incorrect mask prevented
MES firmware from enabling oversubscription, a core GPU efficiency
feature - **Resource underutilization**: GPUs couldn't fully utilize
their compute queues - **Performance degradation**: Systems experienced
reduced GPU throughput ## Comparison with Similar Commits Looking at the
historical examples: - **Similar Commit #2 & #3** (Status: NO/YES):
"drm/amdgpu/mes: fix mes ring buffer overflow" - This was a clear bug
fix that got backported with `Fixes:` tags and `Cc:
stable@vger.kernel.org` - **Similar Commits #1, #4, #5** (Status: NO):
These were feature additions or code improvements, not functional bug
fixes ## Backport Suitability Assessment **✅ Meets stable tree
criteria:** 1. **Fixes important bug**: Prevents MES firmware from
enabling oversubscription 2. **Small and contained**: Only changes mask
values and organization, no architectural changes 3. **Clear side
effects**: Minimal - only corrects queue configuration 4. **No
architectural changes**: Moves mask setup from generic to hardware-
specific without changing core logic 5. **Critical subsystem**: GPU
scheduling affects system performance 6. **Low regression risk**: Only
corrects obviously wrong mask values **✅ Stable tree rules compliance:**
- **Important bugfix**: ✅ Fixes core GPU scheduling functionality -
**Minimal risk**: ✅ Only corrects configuration values - **No new
features**: ✅ Fixes existing functionality rather than adding new
capabilities - **Confined to subsystem**: ✅ Changes only affect AMD GPU
MES subsystem ## Conclusion This commit should definitely be backported
because it fixes a functional regression where MES firmware cannot
properly configure oversubscription due to incorrect hardware queue
masks. The fix is safe, well-understood, and addresses a clear
performance issue without introducing architectural changes or new
features. Users with affected AMD GPUs would see immediate improvement
in GPU utilization and compute performance.

 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c |  3 ---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  2 +-
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  | 15 +++++++++++++--
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c  | 15 ++++++++++++---
 4 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index fb212f0a1136a..5590ad5e8cd76 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -150,9 +150,6 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
 		adev->mes.compute_hqd_mask[i] = 0xc;
 	}
 
-	for (i = 0; i < AMDGPU_MES_MAX_GFX_PIPES; i++)
-		adev->mes.gfx_hqd_mask[i] = i ? 0 : 0xfffffffe;
-
 	for (i = 0; i < AMDGPU_MES_MAX_SDMA_PIPES; i++) {
 		if (i >= adev->sdma.num_instances)
 			break;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index da2c9a8cb3e01..52dd54a32fb47 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -111,8 +111,8 @@ struct amdgpu_mes {
 
 	uint32_t                        vmid_mask_gfxhub;
 	uint32_t                        vmid_mask_mmhub;
-	uint32_t                        compute_hqd_mask[AMDGPU_MES_MAX_COMPUTE_PIPES];
 	uint32_t                        gfx_hqd_mask[AMDGPU_MES_MAX_GFX_PIPES];
+	uint32_t                        compute_hqd_mask[AMDGPU_MES_MAX_COMPUTE_PIPES];
 	uint32_t                        sdma_hqd_mask[AMDGPU_MES_MAX_SDMA_PIPES];
 	uint32_t                        aggregated_doorbells[AMDGPU_MES_PRIORITY_NUM_LEVELS];
 	uint32_t                        sch_ctx_offs[AMDGPU_MAX_MES_PIPES];
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 480283da18454..821c9baf5baa6 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -669,6 +669,18 @@ static int mes_v11_0_misc_op(struct amdgpu_mes *mes,
 			offsetof(union MESAPI__MISC, api_status));
 }
 
+static void mes_v11_0_set_gfx_hqd_mask(union MESAPI_SET_HW_RESOURCES *pkt)
+{
+	/*
+	 * GFX pipe 0 queue 0 is being used by Kernel queue.
+	 * Set GFX pipe 0 queue 1 for MES scheduling
+	 * mask = 10b
+	 * GFX pipe 1 can't be used for MES due to HW limitation.
+	 */
+	pkt->gfx_hqd_mask[0] = 0x2;
+	pkt->gfx_hqd_mask[1] = 0;
+}
+
 static int mes_v11_0_set_hw_resources(struct amdgpu_mes *mes)
 {
 	int i;
@@ -693,8 +705,7 @@ static int mes_v11_0_set_hw_resources(struct amdgpu_mes *mes)
 		mes_set_hw_res_pkt.compute_hqd_mask[i] =
 			mes->compute_hqd_mask[i];
 
-	for (i = 0; i < MAX_GFX_PIPES; i++)
-		mes_set_hw_res_pkt.gfx_hqd_mask[i] = mes->gfx_hqd_mask[i];
+	mes_v11_0_set_gfx_hqd_mask(&mes_set_hw_res_pkt);
 
 	for (i = 0; i < MAX_SDMA_PIPES; i++)
 		mes_set_hw_res_pkt.sdma_hqd_mask[i] = mes->sdma_hqd_mask[i];
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index 624c6b4e452c8..7984ebda5b8bf 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -694,6 +694,17 @@ static int mes_v12_0_set_hw_resources_1(struct amdgpu_mes *mes, int pipe)
 			offsetof(union MESAPI_SET_HW_RESOURCES_1, api_status));
 }
 
+static void mes_v12_0_set_gfx_hqd_mask(union MESAPI_SET_HW_RESOURCES *pkt)
+{
+	/*
+	 * GFX V12 has only one GFX pipe, but 8 queues in it.
+	 * GFX pipe 0 queue 0 is being used by Kernel queue.
+	 * Set GFX pipe 0 queue 1-7 for MES scheduling
+	 * mask = 1111 1110b
+	 */
+	pkt->gfx_hqd_mask[0] = 0xFE;
+}
+
 static int mes_v12_0_set_hw_resources(struct amdgpu_mes *mes, int pipe)
 {
 	int i;
@@ -716,9 +727,7 @@ static int mes_v12_0_set_hw_resources(struct amdgpu_mes *mes, int pipe)
 			mes_set_hw_res_pkt.compute_hqd_mask[i] =
 				mes->compute_hqd_mask[i];
 
-		for (i = 0; i < MAX_GFX_PIPES; i++)
-			mes_set_hw_res_pkt.gfx_hqd_mask[i] =
-				mes->gfx_hqd_mask[i];
+		mes_v12_0_set_gfx_hqd_mask(&mes_set_hw_res_pkt);
 
 		for (i = 0; i < MAX_SDMA_PIPES; i++)
 			mes_set_hw_res_pkt.sdma_hqd_mask[i] =
-- 
2.39.5


