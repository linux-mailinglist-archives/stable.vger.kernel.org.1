Return-Path: <stable+bounces-148416-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26FA1ACA272
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 01:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B07F91894CAB
	for <lists+stable@lfdr.de>; Sun,  1 Jun 2025 23:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E058A25C6F0;
	Sun,  1 Jun 2025 23:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fDK6gPTy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A61C2580D2;
	Sun,  1 Jun 2025 23:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748820415; cv=none; b=UkC5o9XoTOTzAuXXjJRawlg69z79YN38WKT39nwFhbuzxtlyyiYVo8jcCsSm1p4TGNR9183mOuZu30l6YhW62vqi7/jp2HKApxIY5xHzTvc0nBM/h8yC8oJfPT43yvm/pmEXs9RVKz90hQ4bWr3Hm4jGKVrcgAu8MKNB8yHuNas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748820415; c=relaxed/simple;
	bh=TxuJk5GxpLpTx77pY5+P6gbGNKGRmkCELxsB/g4soGM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R//hgyCyjFWA1df+k2PH31piWsNnvFc5tXW3JuLapfBqXExkkdzE/bKvLuS/jlW7KPxGfvO2pYfSHURGyvPqTpkWiBRm2mhooQVg1qKDyo2514CU4gs90NduKrsRmvL+BZuljNrMAzQVU6cqSWhUtcaFUSQx0SVtrMjKdojNVjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fDK6gPTy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45183C4CEE7;
	Sun,  1 Jun 2025 23:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748820413;
	bh=TxuJk5GxpLpTx77pY5+P6gbGNKGRmkCELxsB/g4soGM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fDK6gPTyhxu1zxVjIPrjC/ULZFv+WHn4hKhYqdl/mD2wp71vV7lRoWn0SDinGJJNg
	 uP2L1/+IQXBMHMwJJb9g1ItHUmKsDna0LIcyOlaGvLMCHur/2snOoxQAwgsnedF4Sy
	 OadAqqpWLDFXQEzAtV4a6VuGSE4TrXo25rROluarW9lp7Nc2EvMHWiAET7zcFLBkI2
	 /zo9jF5gBtHQn3SYT43rHJVNad2tPfSWuXmm844i/apKsRiiFwfL1soMfK8MKwDbQJ
	 ZKIbmrWNmf9XTGNPsig/iXEuMiybyPUiRT3Bj76wDHpkm4tWxZSSHvRkm7VaqGECWR
	 6A775IDbeBpBw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Kevin Gao <kevin.gao3@amd.com>,
	Charlene Liu <charlene.liu@amd.com>,
	Roman Li <roman.li@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	Charlene.Liu@amd.com,
	martin.leung@amd.com,
	nicholas.kazlauskas@amd.com,
	chiahsuan.chung@amd.com,
	alex.hung@amd.com,
	Ausef.Yousof@amd.com,
	Nicholas.Susanto@amd.com,
	sungjoon.kim@amd.com,
	PeiChen.Huang@amd.com,
	alvin.lee2@amd.com,
	wayne.lin@amd.com,
	ryanseto@amd.com,
	dillon.varone@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.15 050/110] drm/amd/display: Correct SSC enable detection for DCN351
Date: Sun,  1 Jun 2025 19:23:32 -0400
Message-Id: <20250601232435.3507697-50-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250601232435.3507697-1-sashal@kernel.org>
References: <20250601232435.3507697-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.15
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kevin Gao <kevin.gao3@amd.com>

[ Upstream commit d01a7306e1bec9c02268793f58144e3e42695bf0 ]

[Why]
Due to very small clock register delta between DCN35 and DCN351, clock
spread is being checked on the wrong register for DCN351, causing the
display driver to believe that DPREFCLK downspread to be disabled when
in some stacks it is enabled. This causes the clock values for audio to
be incorrect.

[How]
Both DCN351 and DCN35 use the same clk_mgr, so we modify the DCN35
function that checks for SSC enable to read CLK6 instead of CLK5 when
using DCN351. This allows us to read for DPREFCLK downspread correctly
so the clock can properly compensate when setting values.

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Signed-off-by: Kevin Gao <kevin.gao3@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

**YES** This commit should be backported to stable kernel trees. Here's
my detailed analysis: ## Bug Fix Classification This is a clear bug fix
that addresses incorrect register reading for SSC (Spread Spectrum
Clock) detection in DCN351. The commit fixes a fundamental hardware
register access issue that causes incorrect audio clock values. ## Issue
Severity The bug has significant functional impact: - **Audio
functionality broken**: Incorrect clock values cause audio issues when
DPREFCLK downspread is enabled - **Hardware-specific regression**:
Affects DCN351 specifically due to register differences from DCN35 -
**Silent failure**: The driver believes downspread is disabled when it's
actually enabled, causing subtle but important timing issues ## Code
Analysis The fix is minimal and targeted: 1. **New register
definition**: Adds `mmCLK6_spll_field_8` for DCN351 in
`dcn351_clk_mgr.c` 2. **Conditional logic**: In `dcn35_clk_mgr.c`, adds
a DCN version check: ```c if (clk_mgr_base->ctx->dce_version ==
DCN_VERSION_3_51) { ssc_enable = REG_READ(CLK6_spll_field_8) &
CLK6_spll_field_8__spll_ssc_en_MASK; } else { ssc_enable =
REG_READ(CLK5_spll_field_8) & CLK5_spll_field_8__spll_ssc_en_MASK; } ```
3. **Register addition**: Updates `clk_mgr_internal.h` to include the
new register ## Risk Assessment - **Low regression risk**: The change is
conditional based on DCN version, so it only affects DCN351 hardware -
**Minimal code impact**: Very small, targeted change that doesn't affect
other subsystems - **Hardware-specific**: Only impacts specific AMD
DCN351 display hardware ## Comparison with Similar Commits Looking at
the provided similar commits: - **Similar Commit #2 (YES)**: Also fixes
incorrect register addresses causing SSC issues - very similar pattern -
**Similar Commit #3 (YES)**: Addresses dprefclk adjustment with SS
percentage - related audio timing issue This commit follows the exact
same pattern as Similar Commit #2, which was marked for backporting and
addresses nearly identical issues (incorrect register offset for SSC
functionality). ## Stable Tree Criteria Met ✅ **Fixes important user-
facing bug** (broken audio on DCN351) ✅ **Small, contained change**
(minimal lines of code) ✅ **Low regression risk** (hardware-specific,
conditional logic) ✅ **Clear hardware issue** (register offset
correction) ✅ **Affects real users** (anyone with DCN351 hardware
experiencing audio issues) The commit represents a critical hardware
compatibility fix that should be available in stable kernels to ensure
proper audio functionality on affected AMD hardware.

 .../gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn351_clk_mgr.c | 1 +
 .../gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  | 8 +++++++-
 drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h  | 3 ++-
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn351_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn351_clk_mgr.c
index 6a6ae618650b6..4607eff07253c 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn351_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn351_clk_mgr.c
@@ -65,6 +65,7 @@
 #define mmCLK1_CLK5_ALLOW_DS 0x16EB1
 
 #define mmCLK5_spll_field_8 0x1B04B
+#define mmCLK6_spll_field_8 0x1B24B
 #define mmDENTIST_DISPCLK_CNTL 0x0124
 #define regDENTIST_DISPCLK_CNTL 0x0064
 #define regDENTIST_DISPCLK_CNTL_BASE_IDX 1
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
index 142de8938d7c3..bb1ac12a2b095 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
@@ -90,6 +90,7 @@
 #define mmCLK1_CLK5_ALLOW_DS 0x16EB1
 
 #define mmCLK5_spll_field_8 0x1B24B
+#define mmCLK6_spll_field_8 0x1B24B
 #define mmDENTIST_DISPCLK_CNTL 0x0124
 #define regDENTIST_DISPCLK_CNTL 0x0064
 #define regDENTIST_DISPCLK_CNTL_BASE_IDX 1
@@ -116,6 +117,7 @@
 #define DENTIST_DISPCLK_CNTL__DENTIST_DPPCLK_WDIVIDER_MASK 0x7F000000L
 
 #define CLK5_spll_field_8__spll_ssc_en_MASK 0x00002000L
+#define CLK6_spll_field_8__spll_ssc_en_MASK 0x00002000L
 
 #define SMU_VER_THRESHOLD 0x5D4A00 //93.74.0
 #undef FN
@@ -596,7 +598,11 @@ static bool dcn35_is_spll_ssc_enabled(struct clk_mgr *clk_mgr_base)
 
 	uint32_t ssc_enable;
 
-	ssc_enable = REG_READ(CLK5_spll_field_8) & CLK5_spll_field_8__spll_ssc_en_MASK;
+	if (clk_mgr_base->ctx->dce_version == DCN_VERSION_3_51) {
+		ssc_enable = REG_READ(CLK6_spll_field_8) & CLK6_spll_field_8__spll_ssc_en_MASK;
+	} else {
+		ssc_enable = REG_READ(CLK5_spll_field_8) & CLK5_spll_field_8__spll_ssc_en_MASK;
+	}
 
 	return ssc_enable != 0;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h
index 221645c023b50..bac8febad69a5 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h
@@ -199,6 +199,7 @@ enum dentist_divider_range {
 	CLK_SR_DCN35(CLK1_CLK4_ALLOW_DS), \
 	CLK_SR_DCN35(CLK1_CLK5_ALLOW_DS), \
 	CLK_SR_DCN35(CLK5_spll_field_8), \
+	CLK_SR_DCN35(CLK6_spll_field_8), \
 	SR(DENTIST_DISPCLK_CNTL), \
 
 #define CLK_COMMON_MASK_SH_LIST_DCN32(mask_sh) \
@@ -307,7 +308,7 @@ struct clk_mgr_registers {
 	uint32_t CLK1_CLK4_ALLOW_DS;
 	uint32_t CLK1_CLK5_ALLOW_DS;
 	uint32_t CLK5_spll_field_8;
-
+	uint32_t CLK6_spll_field_8;
 };
 
 struct clk_mgr_shift {
-- 
2.39.5


