Return-Path: <stable+bounces-54335-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2076190EDB6
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 15:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17FA31C20F64
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 13:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E978F14D2A2;
	Wed, 19 Jun 2024 13:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="G6WX4lFa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FC714C581;
	Wed, 19 Jun 2024 13:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718803275; cv=none; b=VTc+B5AaRoOTZ7kwC5mwF+sYxvSnrl9ij+KfGSZxRjCfSKUnxHpLMfUeiMY4xx6r9fQBARPwz5NxOMuXfpnziA1CTIOcuk724v78NoDLlyi+L5EtfxNg4yhWD39eldloKb15ab0ibcO4d34wPvv0d/wTCtjaN0AlKBBbdoA5UGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718803275; c=relaxed/simple;
	bh=hN+EQmiIWCoFqG2rYJDoMATczmzfElQFx9sCgdvY0AA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YeS6qT51kV+Lf1qQD33eDV2wz+F1IOeT/CYVq648zW/bojTScitdvVWzAKyCmWiD5stsz3A7dIb41QToqMwyqDwfLILxSBFgyQCaBVaqEO2yGdkU9iaM9BE1MkoL04WFbtBHqDgBhquscXTmhTliYvlrqL+bMVm9BCdazIC4BRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=G6WX4lFa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CA5FC4AF1A;
	Wed, 19 Jun 2024 13:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718803275;
	bh=hN+EQmiIWCoFqG2rYJDoMATczmzfElQFx9sCgdvY0AA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G6WX4lFa6Ss4OUwsyEPZ+4nA0pfVKMObapvH6IU++F5qO2q/7gb/o0sYhSVL684R5
	 Av/GusgD7os7X3b7pam17orLWhZRklUfDObYatZOlKwAEc5kzx4j0hpROF5WQ2zM7L
	 R9ZE9gDR0YCCfun5FhyFjWabK738kiclWdBxaXiw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Matthew Auld <matthew.auld@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.9 181/281] drm/xe: Remove mem_access from guc_pc calls
Date: Wed, 19 Jun 2024 14:55:40 +0200
Message-ID: <20240619125616.801930231@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240619125609.836313103@linuxfoundation.org>
References: <20240619125609.836313103@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rodrigo Vivi <rodrigo.vivi@intel.com>

[ Upstream commit 1e941c9881ec20f6d0173bcd344a605bb89cb121 ]

We are now protected by init, sysfs, or removal and don't
need these mem_access protections around GuC_PC anymore.

Reviewed-by: Matthew Auld <matthew.auld@intel.com>
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240222163937.138342-6-rodrigo.vivi@intel.com
Stable-dep-of: 2470b141bfae ("drm/xe: move disable_c6 call")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_guc_pc.c | 64 ++++++----------------------------
 1 file changed, 10 insertions(+), 54 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_guc_pc.c b/drivers/gpu/drm/xe/xe_guc_pc.c
index 2839d685631bc..f4b031b8d9deb 100644
--- a/drivers/gpu/drm/xe/xe_guc_pc.c
+++ b/drivers/gpu/drm/xe/xe_guc_pc.c
@@ -381,8 +381,6 @@ u32 xe_guc_pc_get_act_freq(struct xe_guc_pc *pc)
 	struct xe_device *xe = gt_to_xe(gt);
 	u32 freq;
 
-	xe_device_mem_access_get(gt_to_xe(gt));
-
 	/* When in RC6, actual frequency reported will be 0. */
 	if (GRAPHICS_VERx100(xe) >= 1270) {
 		freq = xe_mmio_read32(gt, MTL_MIRROR_TARGET_WP1);
@@ -394,8 +392,6 @@ u32 xe_guc_pc_get_act_freq(struct xe_guc_pc *pc)
 
 	freq = decode_freq(freq);
 
-	xe_device_mem_access_put(gt_to_xe(gt));
-
 	return freq;
 }
 
@@ -412,14 +408,13 @@ int xe_guc_pc_get_cur_freq(struct xe_guc_pc *pc, u32 *freq)
 	struct xe_gt *gt = pc_to_gt(pc);
 	int ret;
 
-	xe_device_mem_access_get(gt_to_xe(gt));
 	/*
 	 * GuC SLPC plays with cur freq request when GuCRC is enabled
 	 * Block RC6 for a more reliable read.
 	 */
 	ret = xe_force_wake_get(gt_to_fw(gt), XE_FORCEWAKE_ALL);
 	if (ret)
-		goto out;
+		return ret;
 
 	*freq = xe_mmio_read32(gt, RPNSWREQ);
 
@@ -427,9 +422,7 @@ int xe_guc_pc_get_cur_freq(struct xe_guc_pc *pc, u32 *freq)
 	*freq = decode_freq(*freq);
 
 	XE_WARN_ON(xe_force_wake_put(gt_to_fw(gt), XE_FORCEWAKE_ALL));
-out:
-	xe_device_mem_access_put(gt_to_xe(gt));
-	return ret;
+	return 0;
 }
 
 /**
@@ -451,12 +444,7 @@ u32 xe_guc_pc_get_rp0_freq(struct xe_guc_pc *pc)
  */
 u32 xe_guc_pc_get_rpe_freq(struct xe_guc_pc *pc)
 {
-	struct xe_gt *gt = pc_to_gt(pc);
-	struct xe_device *xe = gt_to_xe(gt);
-
-	xe_device_mem_access_get(xe);
 	pc_update_rp_values(pc);
-	xe_device_mem_access_put(xe);
 
 	return pc->rpe_freq;
 }
@@ -485,7 +473,6 @@ int xe_guc_pc_get_min_freq(struct xe_guc_pc *pc, u32 *freq)
 	struct xe_gt *gt = pc_to_gt(pc);
 	int ret;
 
-	xe_device_mem_access_get(pc_to_xe(pc));
 	mutex_lock(&pc->freq_lock);
 	if (!pc->freq_ready) {
 		/* Might be in the middle of a gt reset */
@@ -511,7 +498,6 @@ int xe_guc_pc_get_min_freq(struct xe_guc_pc *pc, u32 *freq)
 	XE_WARN_ON(xe_force_wake_put(gt_to_fw(gt), XE_FORCEWAKE_ALL));
 out:
 	mutex_unlock(&pc->freq_lock);
-	xe_device_mem_access_put(pc_to_xe(pc));
 	return ret;
 }
 
@@ -528,7 +514,6 @@ int xe_guc_pc_set_min_freq(struct xe_guc_pc *pc, u32 freq)
 {
 	int ret;
 
-	xe_device_mem_access_get(pc_to_xe(pc));
 	mutex_lock(&pc->freq_lock);
 	if (!pc->freq_ready) {
 		/* Might be in the middle of a gt reset */
@@ -544,8 +529,6 @@ int xe_guc_pc_set_min_freq(struct xe_guc_pc *pc, u32 freq)
 
 out:
 	mutex_unlock(&pc->freq_lock);
-	xe_device_mem_access_put(pc_to_xe(pc));
-
 	return ret;
 }
 
@@ -561,7 +544,6 @@ int xe_guc_pc_get_max_freq(struct xe_guc_pc *pc, u32 *freq)
 {
 	int ret;
 
-	xe_device_mem_access_get(pc_to_xe(pc));
 	mutex_lock(&pc->freq_lock);
 	if (!pc->freq_ready) {
 		/* Might be in the middle of a gt reset */
@@ -577,7 +559,6 @@ int xe_guc_pc_get_max_freq(struct xe_guc_pc *pc, u32 *freq)
 
 out:
 	mutex_unlock(&pc->freq_lock);
-	xe_device_mem_access_put(pc_to_xe(pc));
 	return ret;
 }
 
@@ -594,7 +575,6 @@ int xe_guc_pc_set_max_freq(struct xe_guc_pc *pc, u32 freq)
 {
 	int ret;
 
-	xe_device_mem_access_get(pc_to_xe(pc));
 	mutex_lock(&pc->freq_lock);
 	if (!pc->freq_ready) {
 		/* Might be in the middle of a gt reset */
@@ -610,7 +590,6 @@ int xe_guc_pc_set_max_freq(struct xe_guc_pc *pc, u32 freq)
 
 out:
 	mutex_unlock(&pc->freq_lock);
-	xe_device_mem_access_put(pc_to_xe(pc));
 	return ret;
 }
 
@@ -623,8 +602,6 @@ enum xe_gt_idle_state xe_guc_pc_c_status(struct xe_guc_pc *pc)
 	struct xe_gt *gt = pc_to_gt(pc);
 	u32 reg, gt_c_state;
 
-	xe_device_mem_access_get(gt_to_xe(gt));
-
 	if (GRAPHICS_VERx100(gt_to_xe(gt)) >= 1270) {
 		reg = xe_mmio_read32(gt, MTL_MIRROR_TARGET_WP1);
 		gt_c_state = REG_FIELD_GET(MTL_CC_MASK, reg);
@@ -633,8 +610,6 @@ enum xe_gt_idle_state xe_guc_pc_c_status(struct xe_guc_pc *pc)
 		gt_c_state = REG_FIELD_GET(RCN_MASK, reg);
 	}
 
-	xe_device_mem_access_put(gt_to_xe(gt));
-
 	switch (gt_c_state) {
 	case GT_C6:
 		return GT_IDLE_C6;
@@ -654,9 +629,7 @@ u64 xe_guc_pc_rc6_residency(struct xe_guc_pc *pc)
 	struct xe_gt *gt = pc_to_gt(pc);
 	u32 reg;
 
-	xe_device_mem_access_get(gt_to_xe(gt));
 	reg = xe_mmio_read32(gt, GT_GFX_RC6);
-	xe_device_mem_access_put(gt_to_xe(gt));
 
 	return reg;
 }
@@ -670,9 +643,7 @@ u64 xe_guc_pc_mc6_residency(struct xe_guc_pc *pc)
 	struct xe_gt *gt = pc_to_gt(pc);
 	u64 reg;
 
-	xe_device_mem_access_get(gt_to_xe(gt));
 	reg = xe_mmio_read32(gt, MTL_MEDIA_MC6);
-	xe_device_mem_access_put(gt_to_xe(gt));
 
 	return reg;
 }
@@ -801,23 +772,19 @@ int xe_guc_pc_gucrc_disable(struct xe_guc_pc *pc)
 	if (xe->info.skip_guc_pc)
 		return 0;
 
-	xe_device_mem_access_get(pc_to_xe(pc));
-
 	ret = pc_action_setup_gucrc(pc, XE_GUCRC_HOST_CONTROL);
 	if (ret)
-		goto out;
+		return ret;
 
 	ret = xe_force_wake_get(gt_to_fw(gt), XE_FORCEWAKE_ALL);
 	if (ret)
-		goto out;
+		return ret;
 
 	xe_gt_idle_disable_c6(gt);
 
 	XE_WARN_ON(xe_force_wake_put(gt_to_fw(gt), XE_FORCEWAKE_ALL));
 
-out:
-	xe_device_mem_access_put(pc_to_xe(pc));
-	return ret;
+	return 0;
 }
 
 static void pc_init_pcode_freq(struct xe_guc_pc *pc)
@@ -870,11 +837,9 @@ int xe_guc_pc_start(struct xe_guc_pc *pc)
 
 	xe_gt_assert(gt, xe_device_uc_enabled(xe));
 
-	xe_device_mem_access_get(pc_to_xe(pc));
-
 	ret = xe_force_wake_get(gt_to_fw(gt), XE_FORCEWAKE_ALL);
 	if (ret)
-		goto out_fail_force_wake;
+		return ret;
 
 	if (xe->info.skip_guc_pc) {
 		if (xe->info.platform != XE_PVC)
@@ -914,8 +879,6 @@ int xe_guc_pc_start(struct xe_guc_pc *pc)
 
 out:
 	XE_WARN_ON(xe_force_wake_put(gt_to_fw(gt), XE_FORCEWAKE_ALL));
-out_fail_force_wake:
-	xe_device_mem_access_put(pc_to_xe(pc));
 	return ret;
 }
 
@@ -928,12 +891,9 @@ int xe_guc_pc_stop(struct xe_guc_pc *pc)
 	struct xe_device *xe = pc_to_xe(pc);
 	int ret;
 
-	xe_device_mem_access_get(pc_to_xe(pc));
-
 	if (xe->info.skip_guc_pc) {
 		xe_gt_idle_disable_c6(pc_to_gt(pc));
-		ret = 0;
-		goto out;
+		return 0;
 	}
 
 	mutex_lock(&pc->freq_lock);
@@ -942,16 +902,14 @@ int xe_guc_pc_stop(struct xe_guc_pc *pc)
 
 	ret = pc_action_shutdown(pc);
 	if (ret)
-		goto out;
+		return ret;
 
 	if (wait_for_pc_state(pc, SLPC_GLOBAL_STATE_NOT_RUNNING)) {
 		drm_err(&pc_to_xe(pc)->drm, "GuC PC Shutdown failed\n");
-		ret = -EIO;
+		return -EIO;
 	}
 
-out:
-	xe_device_mem_access_put(pc_to_xe(pc));
-	return ret;
+	return 0;
 }
 
 /**
@@ -965,9 +923,7 @@ static void xe_guc_pc_fini(struct drm_device *drm, void *arg)
 	struct xe_device *xe = pc_to_xe(pc);
 
 	if (xe->info.skip_guc_pc) {
-		xe_device_mem_access_get(xe);
 		xe_gt_idle_disable_c6(pc_to_gt(pc));
-		xe_device_mem_access_put(xe);
 		return;
 	}
 
-- 
2.43.0




