Return-Path: <stable+bounces-110512-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20499A1C9AC
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 16:05:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F28243AAA37
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E477519FA92;
	Sun, 26 Jan 2025 14:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tEugaBrd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9771A0728;
	Sun, 26 Jan 2025 14:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903230; cv=none; b=OfqK5pD1wIKcDM/YCiaDR9LzuVu2jtSs+xzGU3M9w8yDcB8JuvEbd1Je57DDcMd6NvaHmAgLN+9LAVM4p+/R/Aff8SAM2fGsoNBPHvmfdB66KtVKwoWLriNuF/jDyvxaSTt/pfawKbGH/uhvLNDi1AFucK0AXOUsg/KpYXinE+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903230; c=relaxed/simple;
	bh=/Vj9PjC7BZIjNtXGoymmTdhL0TXpRGwQj6u87iCc8GA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pACGz7pEkIuchyR5JOwHgu/tUHQf/htRL2ml9VxKSrL5OVuHRQ/exRHJsPfUK8kDxWn6bu18BsqTq/n8h6KCwIryMzhNBcybptUu43/htmPQRThqoWh4yXC9ykaTDw8OmKg0NyE26sOPOUqERf4+iygF9CdTBzMnsSnpS87rnDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tEugaBrd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D20DC4CED3;
	Sun, 26 Jan 2025 14:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903230;
	bh=/Vj9PjC7BZIjNtXGoymmTdhL0TXpRGwQj6u87iCc8GA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tEugaBrdMBdR2Y7IOd/ebKXin2swkiYitwbejWhFxGUbLA40sTw95HpLJ0R2y+XlH
	 QrMSk5yyyVgZ6hMGpNyynMRgGzvEKzRjv9Ch5WA82Q9xXQWXWbDyAc8MLDQDTlJsa4
	 5b7TD14AQ9wpdetD6kyINtyk8dANQFsWfjUsPm608jH0hVVPu8ylKH3aOwvEhnMo69
	 33pTxrf54uTrYrjwkhhQGY2Lx61ulS194KINfvv9A3Fhfx3t6q8mfj9hwJJmSf95cN
	 UqUYGtsudSOxhBZOUnhk8sGoou/ny/HQUr2v6V1usWrVEWK415wTw2zoK5OVv8zByI
	 F8k6k0657u4Fg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ausef Yousof <Ausef.Yousof@amd.com>,
	Charlene Liu <charlene.liu@amd.com>,
	Fangzhi Zuo <jerry.zuo@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	chaitanya.dhere@amd.com,
	jun.lei@amd.com,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.13 10/34] drm/amd/display: Populate chroma prefetch parameters, DET buffer fix
Date: Sun, 26 Jan 2025 09:52:46 -0500
Message-Id: <20250126145310.926311-10-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126145310.926311-1-sashal@kernel.org>
References: <20250126145310.926311-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13
Content-Transfer-Encoding: 8bit

From: Ausef Yousof <Ausef.Yousof@amd.com>

[ Upstream commit 70fec46519fca859aa209f5f02e7e0a0123aca4a ]

[WHY]
Soft hang/lag observed during 10bit playback + moving cursor, corruption
observed in other tickets for same reason, also failing MPO.

1. Currently, we are always running
   calculate_lowest_supported_state_for_temp_read which is only
   necessary on dGPU
2. Fast validate path does not apply DET buffer allocation policy
3. Prefetch UrgBFactor chroma parameter not populated in prefetch
   calculation

[HOW]
1. Add a check to see if we are on APU, if so, skip the code
2. Add det buffer alloc policy checks to fast validate path
3. Populate UrgentBurstChroma param in call to calculate
   UrgBChroma prefetch values

-revision commits: small formatting/brackets/null check addition + remove test change + dGPU code

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Signed-off-by: Ausef Yousof <Ausef.Yousof@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../amd/display/dc/dml2/display_mode_core.c   |  5 ++-
 .../drm/amd/display/dc/dml2/dml2_wrapper.c    | 35 +++++++++++++------
 2 files changed, 29 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c b/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c
index 8dabb1ac0b684..be87dc0f07799 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c
@@ -6434,7 +6434,7 @@ static void dml_prefetch_check(struct display_mode_lib_st *mode_lib)
 							/* Output */
 							&mode_lib->ms.UrgentBurstFactorCursorPre[k],
 							&mode_lib->ms.UrgentBurstFactorLumaPre[k],
-							&mode_lib->ms.UrgentBurstFactorChroma[k],
+							&mode_lib->ms.UrgentBurstFactorChromaPre[k],
 							&mode_lib->ms.NotUrgentLatencyHidingPre[k]);
 
 					mode_lib->ms.cursor_bw_pre[k] = mode_lib->ms.cache_display_cfg.plane.NumberOfCursors[k] * mode_lib->ms.cache_display_cfg.plane.CursorWidth[k] *
@@ -9190,6 +9190,8 @@ void dml_core_mode_programming(struct display_mode_lib_st *mode_lib, const struc
 			&locals->FractionOfUrgentBandwidth,
 			&s->dummy_boolean[0]); // dml_bool_t *PrefetchBandwidthSupport
 
+
+
 		if (s->VRatioPrefetchMoreThanMax != false || s->DestinationLineTimesForPrefetchLessThan2 != false) {
 			dml_print("DML::%s: VRatioPrefetchMoreThanMax                   = %u\n", __func__, s->VRatioPrefetchMoreThanMax);
 			dml_print("DML::%s: DestinationLineTimesForPrefetchLessThan2    = %u\n", __func__, s->DestinationLineTimesForPrefetchLessThan2);
@@ -9204,6 +9206,7 @@ void dml_core_mode_programming(struct display_mode_lib_st *mode_lib, const struc
 			}
 		}
 
+
 		if (locals->PrefetchModeSupported == true && mode_lib->ms.support.ImmediateFlipSupport == true) {
 			locals->BandwidthAvailableForImmediateFlip = CalculateBandwidthAvailableForImmediateFlip(
 																	mode_lib->ms.num_active_planes,
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
index 9190c1328d5b2..340791d40ecbf 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
@@ -531,14 +531,21 @@ static bool optimize_pstate_with_svp_and_drr(struct dml2_context *dml2, struct d
 static bool call_dml_mode_support_and_programming(struct dc_state *context)
 {
 	unsigned int result = 0;
-	unsigned int min_state;
+	unsigned int min_state = 0;
 	int min_state_for_g6_temp_read = 0;
+
+
+	if (!context)
+		return false;
+
 	struct dml2_context *dml2 = context->bw_ctx.dml2;
 	struct dml2_wrapper_scratch *s = &dml2->v20.scratch;
 
-	min_state_for_g6_temp_read = calculate_lowest_supported_state_for_temp_read(dml2, context);
+	if (!context->streams[0]->sink->link->dc->caps.is_apu) {
+		min_state_for_g6_temp_read = calculate_lowest_supported_state_for_temp_read(dml2, context);
 
-	ASSERT(min_state_for_g6_temp_read >= 0);
+		ASSERT(min_state_for_g6_temp_read >= 0);
+	}
 
 	if (!dml2->config.use_native_pstate_optimization) {
 		result = optimize_pstate_with_svp_and_drr(dml2, context);
@@ -549,14 +556,20 @@ static bool call_dml_mode_support_and_programming(struct dc_state *context)
 	/* Upon trying to sett certain frequencies in FRL, min_state_for_g6_temp_read is reported as -1. This leads to an invalid value of min_state causing crashes later on.
 	 * Use the default logic for min_state only when min_state_for_g6_temp_read is a valid value. In other cases, use the value calculated by the DML directly.
 	 */
-	if (min_state_for_g6_temp_read >= 0)
-		min_state = min_state_for_g6_temp_read > s->mode_support_params.out_lowest_state_idx ? min_state_for_g6_temp_read : s->mode_support_params.out_lowest_state_idx;
-	else
-		min_state = s->mode_support_params.out_lowest_state_idx;
-
-	if (result)
-		result = dml_mode_programming(&dml2->v20.dml_core_ctx, min_state, &s->cur_display_config, true);
+	if (!context->streams[0]->sink->link->dc->caps.is_apu) {
+		if (min_state_for_g6_temp_read >= 0)
+			min_state = min_state_for_g6_temp_read > s->mode_support_params.out_lowest_state_idx ? min_state_for_g6_temp_read : s->mode_support_params.out_lowest_state_idx;
+		else
+			min_state = s->mode_support_params.out_lowest_state_idx;
+	}
 
+	if (result) {
+		if (!context->streams[0]->sink->link->dc->caps.is_apu) {
+			result = dml_mode_programming(&dml2->v20.dml_core_ctx, min_state, &s->cur_display_config, true);
+		} else {
+			result = dml_mode_programming(&dml2->v20.dml_core_ctx, s->mode_support_params.out_lowest_state_idx, &s->cur_display_config, true);
+		}
+	}
 	return result;
 }
 
@@ -685,6 +698,8 @@ static bool dml2_validate_only(struct dc_state *context)
 	build_unoptimized_policy_settings(dml2->v20.dml_core_ctx.project, &dml2->v20.dml_core_ctx.policy);
 
 	map_dc_state_into_dml_display_cfg(dml2, context, &dml2->v20.scratch.cur_display_config);
+	 if (!dml2->config.skip_hw_state_mapping)
+		 dml2_apply_det_buffer_allocation_policy(dml2, &dml2->v20.scratch.cur_display_config);
 
 	result = pack_and_call_dml_mode_support_ex(dml2,
 		&dml2->v20.scratch.cur_display_config,
-- 
2.39.5


