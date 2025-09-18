Return-Path: <stable+bounces-165387-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68DD8B15D0F
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 11:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D28C3AA899
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 09:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5AEE2741BC;
	Wed, 30 Jul 2025 09:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="w5mVFMji"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30A726F461;
	Wed, 30 Jul 2025 09:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753868930; cv=none; b=NSuWgyAGJT25wCRiUl6EHixfwdcA9kyGFkuUtKgUbK0H5kB3GtCT3enU+2/2vaYs/1/HxY2y+3Fb/3n4MUnysNiEPZ+GaxshnVv5rxXsWBY01pao27N8RoPiPcVo4FgmsRR8gAdj4Ms+uWi/cFtAs5m3ThXtqiW+ylrRK6OGKP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753868930; c=relaxed/simple;
	bh=2TLEhFdyebrn6gi2yhL7UqmJ07VUxwIgm3H+j8ephV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WOWqawjO3TGEusgKjglRYrVsGEPeN2Uf/thc9xv7fweAT4ljnV5T/mt13iQq9vrDzL8qqvdqqFzTncbbrET3AetyKuraUo36/L7U393MO/xNE+724i5nwzOhPdqIP3dr/nn/bcyMH2F3HMydTMsR4xock7+Eqqdb74kZ3d76ah8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=w5mVFMji; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4252C4CEF5;
	Wed, 30 Jul 2025 09:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753868930;
	bh=2TLEhFdyebrn6gi2yhL7UqmJ07VUxwIgm3H+j8ephV0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=w5mVFMjiXMuX3U9Rf77WAEaZENCAPZxui1vI4CZQMHFSJLzw+9w/QuQjYs0AC2uzj
	 +2zEyrfw32/q/6iFLE34DUH4DQ68dI4dtIUyQvBz6sKzGn3ExNAuvU50yI83gXGdJI
	 oXiNvXYOkTgNHCgDDrdsoRa7zfZKB3tiA3axQHYc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Badal Nilawar <badal.nilawar@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>,
	Nirmoy Das <nirmoy.das@intel.com>,
	Tomita Moeko <tomitamoeko@gmail.com>
Subject: [PATCH 6.12 112/117] Revert "drm/xe/gt: Update handling of xe_force_wake_get return"
Date: Wed, 30 Jul 2025 11:36:21 +0200
Message-ID: <20250730093238.168218935@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250730093233.592541778@linuxfoundation.org>
References: <20250730093233.592541778@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tomita Moeko <tomitamoeko@gmail.com>

This reverts commit d42b44736ea29fa6d0c3cb9c75569314134b7732.

The reverted commit updated the handling of xe_force_wake_get to match
the new "return refcounted domain mask" semantics introduced in commit
a7ddcea1f5ac ("drm/xe: Error handling in xe_force_wake_get()"). However,
that API change only exists in 6.13 and later.

In 6.12 stable kernel, xe_force_wake_get still returns a status code.
The update incorrectly treats the return value as a mask, causing the
return value of 0 to be misinterpreted as an error. As a result, the
driver probe fails with -ETIMEDOUT in xe_pci_probe -> xe_device_probe
-> xe_gt_init_hwconfig -> xe_force_wake_get.

[ 1254.323172] xe 0000:00:02.0: [drm] Found ALDERLAKE_P (device ID 46a6) display version 13.00 stepping D0
[ 1254.323175] xe 0000:00:02.0: [drm:xe_pci_probe [xe]] ALDERLAKE_P  46a6:000c dgfx:0 gfx:Xe_LP (12.00) media:Xe_M (12.00) display:yes dma_m_s:39 tc:1 gscfi:0 cscfi:0
[ 1254.323275] xe 0000:00:02.0: [drm:xe_pci_probe [xe]] Stepping = (G:C0, M:C0, B:**)
[ 1254.323328] xe 0000:00:02.0: [drm:xe_pci_probe [xe]] SR-IOV support: no (mode: none)
[ 1254.323379] xe 0000:00:02.0: [drm:intel_pch_type [xe]] Found Alder Lake PCH
[ 1254.323475] xe 0000:00:02.0: probe with driver xe failed with error -110

Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/5373
Cc: Badal Nilawar <badal.nilawar@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Cc: Nirmoy Das <nirmoy.das@intel.com>
Acked-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/xe/xe_gt.c |  105 ++++++++++++++++++++-------------------------
 1 file changed, 47 insertions(+), 58 deletions(-)

--- a/drivers/gpu/drm/xe/xe_gt.c
+++ b/drivers/gpu/drm/xe/xe_gt.c
@@ -98,14 +98,14 @@ void xe_gt_sanitize(struct xe_gt *gt)
 
 static void xe_gt_enable_host_l2_vram(struct xe_gt *gt)
 {
-	unsigned int fw_ref;
 	u32 reg;
+	int err;
 
 	if (!XE_WA(gt, 16023588340))
 		return;
 
-	fw_ref = xe_force_wake_get(gt_to_fw(gt), XE_FW_GT);
-	if (!fw_ref)
+	err = xe_force_wake_get(gt_to_fw(gt), XE_FW_GT);
+	if (WARN_ON(err))
 		return;
 
 	if (!xe_gt_is_media_type(gt)) {
@@ -115,13 +115,13 @@ static void xe_gt_enable_host_l2_vram(st
 	}
 
 	xe_gt_mcr_multicast_write(gt, XEHPC_L3CLOS_MASK(3), 0xF);
-	xe_force_wake_put(gt_to_fw(gt), fw_ref);
+	xe_force_wake_put(gt_to_fw(gt), XE_FW_GT);
 }
 
 static void xe_gt_disable_host_l2_vram(struct xe_gt *gt)
 {
-	unsigned int fw_ref;
 	u32 reg;
+	int err;
 
 	if (!XE_WA(gt, 16023588340))
 		return;
@@ -129,15 +129,15 @@ static void xe_gt_disable_host_l2_vram(s
 	if (xe_gt_is_media_type(gt))
 		return;
 
-	fw_ref = xe_force_wake_get(gt_to_fw(gt), XE_FW_GT);
-	if (!fw_ref)
+	err = xe_force_wake_get(gt_to_fw(gt), XE_FW_GT);
+	if (WARN_ON(err))
 		return;
 
 	reg = xe_gt_mcr_unicast_read_any(gt, XE2_GAMREQSTRM_CTRL);
 	reg &= ~CG_DIS_CNTLBUS;
 	xe_gt_mcr_multicast_write(gt, XE2_GAMREQSTRM_CTRL, reg);
 
-	xe_force_wake_put(gt_to_fw(gt), fw_ref);
+	xe_force_wake_put(gt_to_fw(gt), XE_FW_GT);
 }
 
 /**
@@ -407,14 +407,11 @@ static void dump_pat_on_error(struct xe_
 
 static int gt_fw_domain_init(struct xe_gt *gt)
 {
-	unsigned int fw_ref;
 	int err, i;
 
-	fw_ref = xe_force_wake_get(gt_to_fw(gt), XE_FW_GT);
-	if (!fw_ref) {
-		err = -ETIMEDOUT;
+	err = xe_force_wake_get(gt_to_fw(gt), XE_FW_GT);
+	if (err)
 		goto err_hw_fence_irq;
-	}
 
 	if (!xe_gt_is_media_type(gt)) {
 		err = xe_ggtt_init(gt_to_tile(gt)->mem.ggtt);
@@ -449,12 +446,14 @@ static int gt_fw_domain_init(struct xe_g
 	 */
 	gt->info.gmdid = xe_mmio_read32(gt, GMD_ID);
 
-	xe_force_wake_put(gt_to_fw(gt), fw_ref);
+	err = xe_force_wake_put(gt_to_fw(gt), XE_FW_GT);
+	XE_WARN_ON(err);
+
 	return 0;
 
 err_force_wake:
 	dump_pat_on_error(gt);
-	xe_force_wake_put(gt_to_fw(gt), fw_ref);
+	xe_force_wake_put(gt_to_fw(gt), XE_FW_GT);
 err_hw_fence_irq:
 	for (i = 0; i < XE_ENGINE_CLASS_MAX; ++i)
 		xe_hw_fence_irq_finish(&gt->fence_irq[i]);
@@ -464,14 +463,11 @@ err_hw_fence_irq:
 
 static int all_fw_domain_init(struct xe_gt *gt)
 {
-	unsigned int fw_ref;
 	int err, i;
 
-	fw_ref = xe_force_wake_get(gt_to_fw(gt), XE_FORCEWAKE_ALL);
-	if (!xe_force_wake_ref_has_domain(fw_ref, XE_FORCEWAKE_ALL)) {
-		err = -ETIMEDOUT;
-		goto err_force_wake;
-	}
+	err = xe_force_wake_get(gt_to_fw(gt), XE_FORCEWAKE_ALL);
+	if (err)
+		goto err_hw_fence_irq;
 
 	xe_gt_mcr_set_implicit_defaults(gt);
 	xe_wa_process_gt(gt);
@@ -537,12 +533,14 @@ static int all_fw_domain_init(struct xe_
 	if (IS_SRIOV_PF(gt_to_xe(gt)))
 		xe_gt_sriov_pf_init_hw(gt);
 
-	xe_force_wake_put(gt_to_fw(gt), fw_ref);
+	err = xe_force_wake_put(gt_to_fw(gt), XE_FORCEWAKE_ALL);
+	XE_WARN_ON(err);
 
 	return 0;
 
 err_force_wake:
-	xe_force_wake_put(gt_to_fw(gt), fw_ref);
+	xe_force_wake_put(gt_to_fw(gt), XE_FORCEWAKE_ALL);
+err_hw_fence_irq:
 	for (i = 0; i < XE_ENGINE_CLASS_MAX; ++i)
 		xe_hw_fence_irq_finish(&gt->fence_irq[i]);
 
@@ -555,12 +553,11 @@ err_force_wake:
  */
 int xe_gt_init_hwconfig(struct xe_gt *gt)
 {
-	unsigned int fw_ref;
 	int err;
 
-	fw_ref = xe_force_wake_get(gt_to_fw(gt), XE_FW_GT);
-	if (!fw_ref)
-		return -ETIMEDOUT;
+	err = xe_force_wake_get(gt_to_fw(gt), XE_FW_GT);
+	if (err)
+		goto out;
 
 	xe_gt_mcr_init_early(gt);
 	xe_pat_init(gt);
@@ -578,7 +575,8 @@ int xe_gt_init_hwconfig(struct xe_gt *gt
 	xe_gt_enable_host_l2_vram(gt);
 
 out_fw:
-	xe_force_wake_put(gt_to_fw(gt), fw_ref);
+	xe_force_wake_put(gt_to_fw(gt), XE_FW_GT);
+out:
 	return err;
 }
 
@@ -746,7 +744,6 @@ static int do_gt_restart(struct xe_gt *g
 
 static int gt_reset(struct xe_gt *gt)
 {
-	unsigned int fw_ref;
 	int err;
 
 	if (xe_device_wedged(gt_to_xe(gt)))
@@ -767,11 +764,9 @@ static int gt_reset(struct xe_gt *gt)
 
 	xe_gt_sanitize(gt);
 
-	fw_ref = xe_force_wake_get(gt_to_fw(gt), XE_FORCEWAKE_ALL);
-	if (!xe_force_wake_ref_has_domain(fw_ref, XE_FORCEWAKE_ALL)) {
-		err = -ETIMEDOUT;
-		goto err_out;
-	}
+	err = xe_force_wake_get(gt_to_fw(gt), XE_FORCEWAKE_ALL);
+	if (err)
+		goto err_msg;
 
 	if (IS_SRIOV_PF(gt_to_xe(gt)))
 		xe_gt_sriov_pf_stop_prepare(gt);
@@ -792,7 +787,8 @@ static int gt_reset(struct xe_gt *gt)
 	if (err)
 		goto err_out;
 
-	xe_force_wake_put(gt_to_fw(gt), fw_ref);
+	err = xe_force_wake_put(gt_to_fw(gt), XE_FORCEWAKE_ALL);
+	XE_WARN_ON(err);
 	xe_pm_runtime_put(gt_to_xe(gt));
 
 	xe_gt_info(gt, "reset done\n");
@@ -800,7 +796,8 @@ static int gt_reset(struct xe_gt *gt)
 	return 0;
 
 err_out:
-	xe_force_wake_put(gt_to_fw(gt), fw_ref);
+	XE_WARN_ON(xe_force_wake_put(gt_to_fw(gt), XE_FORCEWAKE_ALL));
+err_msg:
 	XE_WARN_ON(xe_uc_start(&gt->uc));
 err_fail:
 	xe_gt_err(gt, "reset failed (%pe)\n", ERR_PTR(err));
@@ -832,25 +829,22 @@ void xe_gt_reset_async(struct xe_gt *gt)
 
 void xe_gt_suspend_prepare(struct xe_gt *gt)
 {
-	unsigned int fw_ref;
-
-	fw_ref = xe_force_wake_get(gt_to_fw(gt), XE_FORCEWAKE_ALL);
+	XE_WARN_ON(xe_force_wake_get(gt_to_fw(gt), XE_FORCEWAKE_ALL));
 
 	xe_uc_suspend_prepare(&gt->uc);
 
-	xe_force_wake_put(gt_to_fw(gt), fw_ref);
+	XE_WARN_ON(xe_force_wake_put(gt_to_fw(gt), XE_FORCEWAKE_ALL));
 }
 
 int xe_gt_suspend(struct xe_gt *gt)
 {
-	unsigned int fw_ref;
 	int err;
 
 	xe_gt_dbg(gt, "suspending\n");
 	xe_gt_sanitize(gt);
 
-	fw_ref = xe_force_wake_get(gt_to_fw(gt), XE_FORCEWAKE_ALL);
-	if (!xe_force_wake_ref_has_domain(fw_ref, XE_FORCEWAKE_ALL))
+	err = xe_force_wake_get(gt_to_fw(gt), XE_FORCEWAKE_ALL);
+	if (err)
 		goto err_msg;
 
 	err = xe_uc_suspend(&gt->uc);
@@ -861,15 +855,14 @@ int xe_gt_suspend(struct xe_gt *gt)
 
 	xe_gt_disable_host_l2_vram(gt);
 
-	xe_force_wake_put(gt_to_fw(gt), fw_ref);
+	XE_WARN_ON(xe_force_wake_put(gt_to_fw(gt), XE_FORCEWAKE_ALL));
 	xe_gt_dbg(gt, "suspended\n");
 
 	return 0;
 
-err_msg:
-	err = -ETIMEDOUT;
 err_force_wake:
-	xe_force_wake_put(gt_to_fw(gt), fw_ref);
+	XE_WARN_ON(xe_force_wake_put(gt_to_fw(gt), XE_FORCEWAKE_ALL));
+err_msg:
 	xe_gt_err(gt, "suspend failed (%pe)\n", ERR_PTR(err));
 
 	return err;
@@ -877,11 +870,9 @@ err_force_wake:
 
 void xe_gt_shutdown(struct xe_gt *gt)
 {
-	unsigned int fw_ref;
-
-	fw_ref = xe_force_wake_get(gt_to_fw(gt), XE_FORCEWAKE_ALL);
+	xe_force_wake_get(gt_to_fw(gt), XE_FORCEWAKE_ALL);
 	do_gt_reset(gt);
-	xe_force_wake_put(gt_to_fw(gt), fw_ref);
+	xe_force_wake_put(gt_to_fw(gt), XE_FORCEWAKE_ALL);
 }
 
 /**
@@ -906,12 +897,11 @@ int xe_gt_sanitize_freq(struct xe_gt *gt
 
 int xe_gt_resume(struct xe_gt *gt)
 {
-	unsigned int fw_ref;
 	int err;
 
 	xe_gt_dbg(gt, "resuming\n");
-	fw_ref = xe_force_wake_get(gt_to_fw(gt), XE_FORCEWAKE_ALL);
-	if (!xe_force_wake_ref_has_domain(fw_ref, XE_FORCEWAKE_ALL))
+	err = xe_force_wake_get(gt_to_fw(gt), XE_FORCEWAKE_ALL);
+	if (err)
 		goto err_msg;
 
 	err = do_gt_restart(gt);
@@ -920,15 +910,14 @@ int xe_gt_resume(struct xe_gt *gt)
 
 	xe_gt_idle_enable_pg(gt);
 
-	xe_force_wake_put(gt_to_fw(gt), fw_ref);
+	XE_WARN_ON(xe_force_wake_put(gt_to_fw(gt), XE_FORCEWAKE_ALL));
 	xe_gt_dbg(gt, "resumed\n");
 
 	return 0;
 
-err_msg:
-	err = -ETIMEDOUT;
 err_force_wake:
-	xe_force_wake_put(gt_to_fw(gt), fw_ref);
+	XE_WARN_ON(xe_force_wake_put(gt_to_fw(gt), XE_FORCEWAKE_ALL));
+err_msg:
 	xe_gt_err(gt, "resume failed (%pe)\n", ERR_PTR(err));
 
 	return err;



