Return-Path: <stable+bounces-66640-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E911494F084
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 16:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A26D0282C5E
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 14:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 032CB184526;
	Mon, 12 Aug 2024 14:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IpHrsfxQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93325336D
	for <stable@vger.kernel.org>; Mon, 12 Aug 2024 14:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723474246; cv=none; b=oajYUdpMnpM182dsuFa7kaGhe5KuwMK7iNMFePwEUSEbuZWoJXuBLHhT/m2kBBFEIBpO5SO4/Wi7ozpvWypdGSbTtf56Qg6dYvb2lT/xHOpGoP3Ug3YKQAwx1Hj1R4zuhTrVF984UDQF1MkuXNubE/e5CBJHjjMzNAgfz15Fqss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723474246; c=relaxed/simple;
	bh=E6sgPAEpcepu0vkYuQt7UFprMT7Vo6gWrZMB3dOBomA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=MEwUQitkfKyxz49x2uhk8+bicZYqcsYjT0Sz8TNzOvLhWzi1Q9MYdUKOi8v2St6vYeaLFbB5Z6eWMertSMpF4VAYr7M6Ktk2MKdECiujMMu7Hi/4aaithe+R73xKtUGJrOZ8LLJ3wtgx3jKQ+ocBADA0xaAozKS8USTUty9DgDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IpHrsfxQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22DF6C32782;
	Mon, 12 Aug 2024 14:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723474246;
	bh=E6sgPAEpcepu0vkYuQt7UFprMT7Vo6gWrZMB3dOBomA=;
	h=Subject:To:Cc:From:Date:From;
	b=IpHrsfxQbv0ok0cArluW4LK3+L4J2LWakhOVgo6LTacf9SlHrtxYg25mzBZgmR0sK
	 gIjgThZYiRLDCwqLl9ZgGZQKrB9CSzjoFXV51tvgH9oytKFxDTAbaFoUoCvrU1VJRf
	 r0nU5LuWzB+7sagVMuHhXDI0/7SaEoPiDgpMvbss=
Subject: FAILED: patch "[PATCH] drm/amd/display: Use periodic detection for ipx/headless" failed to apply to 6.10-stable tree
To: roman.li@amd.com,alex.hung@amd.com,alexander.deucher@amd.com,aurabindo.pillai@amd.com,daniel.wheeler@amd.com,mario.limonciello@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Aug 2024 16:48:57 +0200
Message-ID: <2024081257-commute-zone-b217@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.10.y
git checkout FETCH_HEAD
git cherry-pick -x 9862ef7bae47b9292a38a0a1b30bff7f56d7815b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081257-commute-zone-b217@gregkh' --subject-prefix 'PATCH 6.10.y' HEAD^..

Possible dependencies:

9862ef7bae47 ("drm/amd/display: Use periodic detection for ipx/headless")
234e94555800 ("drm/amd/display: Enable copying of bounding box data from VBIOS DMUB")
afca033f10d3 ("drm/amd/display: Add periodic detection for IPS")
05c5ffaac770 ("drm/amd/display: gpuvm handling in DML21")
70839da63605 ("drm/amd/display: Add new DCN401 sources")

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


