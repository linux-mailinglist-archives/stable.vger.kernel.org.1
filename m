Return-Path: <stable+bounces-66641-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52F9794F086
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 16:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08983280E92
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 14:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5996A153BF6;
	Mon, 12 Aug 2024 14:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="l6OE7pz0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1953517995B
	for <stable@vger.kernel.org>; Mon, 12 Aug 2024 14:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723474250; cv=none; b=LKFeow5r6ueGslje0oK5A70d8aH4pGEgBDNy83Tzxq0bpQLpYULzZFOhs7hlkC1pjOttpf8KBpdzBSRw9xrBlNn/G1nCfEu8pvkFKw0VIbxqMU6CffqrtUBCs1a3/XwKCXeyAQxTj9FZQ31YFFI/jV9cQQEyAYk2HUT2TPsFG7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723474250; c=relaxed/simple;
	bh=/FIQXMoQ0Ukcv0XjPizBi0s1rHxm88apbFeVI5itZhQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=WExgnJJi6Nx4/IoOZJ6ePqFNnQuIP53FsKQlZcmR25DNCV8Zz//A3lb5veJI7dpaW5dTck1tZgAoTeZoD3wBYQ0FcZIB5OsgaaXbW2b4xrg3mAEiga8yUsmuFnTS9MsnWWotnyhc2trHsdnGAu0wy9DCk+Vt4sbqgkyx3HCFgN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=l6OE7pz0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D69DC32782;
	Mon, 12 Aug 2024 14:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723474250;
	bh=/FIQXMoQ0Ukcv0XjPizBi0s1rHxm88apbFeVI5itZhQ=;
	h=Subject:To:Cc:From:Date:From;
	b=l6OE7pz0Atf6NLLV6allHfp4kf28Oyyg4x75CCAEPbWMWZ5t8LVCO0j0LYj1Ol1r3
	 kZDmvKpJSh6uwUlI1yzsLJnenKxspLYR6Ja82BbfBJ/d8NopwXzPJlVwMkLZgJistw
	 j6mxFtYYW5q4+sELnjVcIAeVwbaSNpbhlQyOf3/U=
Subject: FAILED: patch "[PATCH] drm/amd/display: Use periodic detection for ipx/headless" failed to apply to 6.6-stable tree
To: roman.li@amd.com,alex.hung@amd.com,alexander.deucher@amd.com,aurabindo.pillai@amd.com,daniel.wheeler@amd.com,mario.limonciello@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Aug 2024 16:48:58 +0200
Message-ID: <2024081258-knee-fastness-2603@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 9862ef7bae47b9292a38a0a1b30bff7f56d7815b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081258-knee-fastness-2603@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

9862ef7bae47 ("drm/amd/display: Use periodic detection for ipx/headless")
234e94555800 ("drm/amd/display: Enable copying of bounding box data from VBIOS DMUB")
afca033f10d3 ("drm/amd/display: Add periodic detection for IPS")
05c5ffaac770 ("drm/amd/display: gpuvm handling in DML21")
70839da63605 ("drm/amd/display: Add new DCN401 sources")
e779f4587f61 ("drm/amd/display: Add handling for DC power mode")
cc263c3a0c9f ("drm/amd/display: remove context->dml2 dependency from DML21 wrapper")
d62d5551dd61 ("drm/amd/display: Backup and restore only on full updates")
2d5bb791e24f ("drm/amd/display: Implement update_planes_and_stream_v3 sequence")
4f5b8d78ca43 ("drm/amd/display: Init DPPCLK from SMU on dcn32")
2728e9c7c842 ("drm/amd/display: add DC changes for DCN351")
d2dea1f14038 ("drm/amd/display: Generalize new minimal transition path")
0701117efd1e ("Revert "drm/amd/display: For FPO and SubVP/DRR configs program vmin/max sel"")
a9b1a4f684b3 ("drm/amd/display: Add more checks for exiting idle in DC")
13b3d6bdbeb4 ("drm/amd/display: add debugfs disallow edp psr")
dcbf438d4834 ("drm/amd/display: Unify optimize_required flags and VRR adjustments")
8457bddc266c ("drm/amd/display: Revert "Rework DC Z10 restore"")
2a8e918f48bd ("drm/amd/display: add power_state and pme_pending flag")
e6f82bd44b40 ("drm/amd/display: Rework DC Z10 restore")
5950efe25ee0 ("drm/amd/display: Enable Panel Replay for static screen use case")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9862ef7bae47b9292a38a0a1b30bff7f56d7815b Mon Sep 17 00:00:00 2001
From: Roman Li <roman.li@amd.com>
Date: Thu, 13 Jun 2024 10:41:51 -0400
Subject: [PATCH] drm/amd/display: Use periodic detection for ipx/headless

[WHY]
Hotplug is not detected in headless (no eDP) mode on dcn35x.
With no display dcn35x goes to IPS2 powersaving state where HPD interrupt
is not handled.

[HOW]
Use idle worker thread for periodic detection of HPD in headless mode.

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index dfcbc1970fe6..5fd1b6b44577 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -989,4 +989,7 @@ void *dm_allocate_gpu_mem(struct amdgpu_device *adev,
 						  enum dc_gpu_mem_alloc_type type,
 						  size_t size,
 						  long long *addr);
+
+bool amdgpu_dm_is_headless(struct amdgpu_device *adev);
+
 #endif /* __AMDGPU_DM_H__ */
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
index e16eecb146fd..99014339aaa3 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
@@ -162,33 +162,63 @@ static void amdgpu_dm_crtc_set_panel_sr_feature(
 	}
 }
 
+bool amdgpu_dm_is_headless(struct amdgpu_device *adev)
+{
+	struct drm_connector *connector;
+	struct drm_connector_list_iter iter;
+	struct drm_device *dev;
+	bool is_headless = true;
+
+	if (adev == NULL)
+		return true;
+
+	dev = adev->dm.ddev;
+
+	drm_connector_list_iter_begin(dev, &iter);
+	drm_for_each_connector_iter(connector, &iter) {
+
+		if (connector->connector_type == DRM_MODE_CONNECTOR_WRITEBACK)
+			continue;
+
+		if (connector->status == connector_status_connected) {
+			is_headless = false;
+			break;
+		}
+	}
+	drm_connector_list_iter_end(&iter);
+	return is_headless;
+}
+
 static void amdgpu_dm_idle_worker(struct work_struct *work)
 {
 	struct idle_workqueue *idle_work;
 
 	idle_work = container_of(work, struct idle_workqueue, work);
 	idle_work->dm->idle_workqueue->running = true;
-	fsleep(HPD_DETECTION_PERIOD_uS);
-	mutex_lock(&idle_work->dm->dc_lock);
-	while (idle_work->enable) {
-		if (!idle_work->dm->dc->idle_optimizations_allowed)
-			break;
 
+	while (idle_work->enable) {
+		fsleep(HPD_DETECTION_PERIOD_uS);
+		mutex_lock(&idle_work->dm->dc_lock);
+		if (!idle_work->dm->dc->idle_optimizations_allowed) {
+			mutex_unlock(&idle_work->dm->dc_lock);
+			break;
+		}
 		dc_allow_idle_optimizations(idle_work->dm->dc, false);
 
 		mutex_unlock(&idle_work->dm->dc_lock);
 		fsleep(HPD_DETECTION_TIME_uS);
 		mutex_lock(&idle_work->dm->dc_lock);
 
-		if (!amdgpu_dm_psr_is_active_allowed(idle_work->dm))
+		if (!amdgpu_dm_is_headless(idle_work->dm->adev) &&
+		    !amdgpu_dm_psr_is_active_allowed(idle_work->dm)) {
+			mutex_unlock(&idle_work->dm->dc_lock);
 			break;
+		}
 
-		dc_allow_idle_optimizations(idle_work->dm->dc, true);
+		if (idle_work->enable)
+			dc_allow_idle_optimizations(idle_work->dm->dc, true);
 		mutex_unlock(&idle_work->dm->dc_lock);
-		fsleep(HPD_DETECTION_PERIOD_uS);
-		mutex_lock(&idle_work->dm->dc_lock);
 	}
-	mutex_unlock(&idle_work->dm->dc_lock);
 	idle_work->dm->idle_workqueue->running = false;
 }
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index adbf560d6a74..97614947d75b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -1239,8 +1239,11 @@ void dm_helpers_enable_periodic_detection(struct dc_context *ctx, bool enable)
 {
 	struct amdgpu_device *adev = ctx->driver_context;
 
-	if (adev->dm.idle_workqueue)
+	if (adev->dm.idle_workqueue) {
 		adev->dm.idle_workqueue->enable = enable;
+		if (enable && !adev->dm.idle_workqueue->running && amdgpu_dm_is_headless(adev))
+			schedule_work(&adev->dm.idle_workqueue->work);
+	}
 }
 
 void dm_helpers_dp_mst_update_branch_bandwidth(


