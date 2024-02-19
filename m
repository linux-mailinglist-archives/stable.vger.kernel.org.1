Return-Path: <stable+bounces-20650-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E8E85AAC5
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 19:18:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A18BF282E6A
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 18:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD04481B3;
	Mon, 19 Feb 2024 18:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="B2pMEYQ6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC1647F79
	for <stable@vger.kernel.org>; Mon, 19 Feb 2024 18:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708366706; cv=none; b=beXNNXnRBy/IMJP1hu1sH7+7hbnyj8RHxESZVFLxe28w3zJJ0fpiAqWTCaKgdNeaF0i0WFILUgtuYACRj8I8arAw2v2dySgdhPWNCjkCG2G+QCYLOJiTK3arnnzVPh3t7PuxZypI5ZQwYDqFqZ+LhOnDU0duH1ierFkqtJ4aHAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708366706; c=relaxed/simple;
	bh=p0lnwmh6wwyIRyOc3A4gCKsV2gU4AeLMT2bnEqOeC6o=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=O5Jjsu9hyf5WZW+eELg4etwoPXVFsDsLyqxGnMxRcpwQXfvDrB8cMlWMxNnxjYCJwUBfJN09Dbh78Urx7KoKnRxVmjkbqtAJqgv+zJjCUIZoagOoxGm1Ikyar8wvYantz/QLCVpston6ZVKDqr8U1Y2T/A64QMQVNO6XPYEL4W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=B2pMEYQ6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55B1DC433F1;
	Mon, 19 Feb 2024 18:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708366706;
	bh=p0lnwmh6wwyIRyOc3A4gCKsV2gU4AeLMT2bnEqOeC6o=;
	h=Subject:To:Cc:From:Date:From;
	b=B2pMEYQ6C36CjYQD+RSatqkrryXmSLITdnvLsxgkWn7gnUKAmkVx2XaGqm5v1IXtt
	 xS6EHbttA4W0jo7xqaMM+6bHfALVFDObkFUg2xblzIdxBe4Hqz1S1AuxM3hihTn9Y4
	 O/OgKwlA11Pb7RcUSs+jfpskFmbjUnYL/cl1DSHE=
Subject: FAILED: patch "[PATCH] drm/amdgpu: make damage clips support configurable" failed to apply to 6.6-stable tree
To: hamza.mahfooz@amd.com,alexander.deucher@amd.com,mario.limonciello@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 Feb 2024 19:18:17 +0100
Message-ID: <2024021917-swarm-federal-1cdf@gregkh>
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
git cherry-pick -x d16df040c8dad25c962b4404d2d534bfea327c6a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024021917-swarm-federal-1cdf@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

d16df040c8da ("drm/amdgpu: make damage clips support configurable")
b8b39de64627 ("drm/amd/pm: setup the framework to support Wifi RFI mitigation feature")
2e9b152325f6 ("drm/amdgpu: optimize RLC powerdown notification on Vangogh")
6ba5b613837c ("drm/amdgpu: add a module parameter to control the AGP aperture")
564ca1b53ece ("drm/amdgpu/gmc11: fix logic typo in AGP check")
56d3de7da67a ("drm/amdgpu: add power up/down UMSCH ppt callback")
fe6cd9152464 ("drm/amd/swsmu: add smu14 ip support")
67318cb84341 ("drm/amdgpu/gmc11: set gart placement GC11")
917f91d8d8e8 ("drm/amdgpu/gmc: add a way to force a particular placement for GART")
d07f1c20dd7c ("drm/amd/pm: add xgmi plpd mode selecting interface for smu v13.0.6")
10d9ee96ce05 ("drm/amd/pm: add plpd_mode in smu_context to indicate current mode")
b2e1cbe6281f ("drm/amdgpu/gmc11: disable AGP on GC 11.5")
de59b69932e6 ("drm/amdgpu/gmc: set a default disable value for AGP")
29495d81457a ("drm/amdgpu/gmc6-8: properly disable the AGP aperture")
25396684b57f ("drm/amd/pm: add smu_13_0_6 mca dump support")
bcd8dc49c0b9 ("drm/amd/pm: update smu_v13_0_6 ppsmc header")
cad2fb19bbfa ("drm/amd/pm: Fix clock reporting for SMUv13.0.6")
4e8303cf2c4d ("drm/amdgpu: Use function for IP version check")
887db1e49a73 ("drm/amdgpu: Merge debug module parameters")
df38fe12a22c ("drm/amd/pm: enable smu_v13_0_6 mca debug mode when UMC RAS feature is enabled")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d16df040c8dad25c962b4404d2d534bfea327c6a Mon Sep 17 00:00:00 2001
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
Date: Thu, 8 Feb 2024 16:23:29 -0500
Subject: [PATCH] drm/amdgpu: make damage clips support configurable

We have observed that there are quite a number of PSR-SU panels on the
market that are unable to keep up with what user space throws at them,
resulting in hangs and random black screens. So, make damage clips
support configurable and disable it by default for PSR-SU displays.

Cc: stable@vger.kernel.org
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 6dce81a061ab..517117a0796f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -200,6 +200,7 @@ extern uint amdgpu_dc_debug_mask;
 extern uint amdgpu_dc_visual_confirm;
 extern uint amdgpu_dm_abm_level;
 extern int amdgpu_backlight;
+extern int amdgpu_damage_clips;
 extern struct amdgpu_mgpu_info mgpu_info;
 extern int amdgpu_ras_enable;
 extern uint amdgpu_ras_mask;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 211501ea9169..586f4d03039d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -211,6 +211,7 @@ int amdgpu_seamless = -1; /* auto */
 uint amdgpu_debug_mask;
 int amdgpu_agp = -1; /* auto */
 int amdgpu_wbrf = -1;
+int amdgpu_damage_clips = -1; /* auto */
 
 static void amdgpu_drv_delayed_reset_work_handler(struct work_struct *work);
 
@@ -859,6 +860,18 @@ int amdgpu_backlight = -1;
 MODULE_PARM_DESC(backlight, "Backlight control (0 = pwm, 1 = aux, -1 auto (default))");
 module_param_named(backlight, amdgpu_backlight, bint, 0444);
 
+/**
+ * DOC: damageclips (int)
+ * Enable or disable damage clips support. If damage clips support is disabled,
+ * we will force full frame updates, irrespective of what user space sends to
+ * us.
+ *
+ * Defaults to -1 (where it is enabled unless a PSR-SU display is detected).
+ */
+MODULE_PARM_DESC(damageclips,
+		 "Damage clips support (0 = disable, 1 = enable, -1 auto (default))");
+module_param_named(damageclips, amdgpu_damage_clips, int, 0444);
+
 /**
  * DOC: tmz (int)
  * Trusted Memory Zone (TMZ) is a method to protect data being written
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 59d2eee72a32..d5ef07af9906 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5219,6 +5219,7 @@ static void fill_dc_dirty_rects(struct drm_plane *plane,
 				struct drm_plane_state *new_plane_state,
 				struct drm_crtc_state *crtc_state,
 				struct dc_flip_addrs *flip_addrs,
+				bool is_psr_su,
 				bool *dirty_regions_changed)
 {
 	struct dm_crtc_state *dm_crtc_state = to_dm_crtc_state(crtc_state);
@@ -5243,6 +5244,10 @@ static void fill_dc_dirty_rects(struct drm_plane *plane,
 	num_clips = drm_plane_get_damage_clips_count(new_plane_state);
 	clips = drm_plane_get_damage_clips(new_plane_state);
 
+	if (num_clips && (!amdgpu_damage_clips || (amdgpu_damage_clips < 0 &&
+						   is_psr_su)))
+		goto ffu;
+
 	if (!dm_crtc_state->mpo_requested) {
 		if (!num_clips || num_clips > DC_MAX_DIRTY_RECTS)
 			goto ffu;
@@ -8298,6 +8303,8 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 			fill_dc_dirty_rects(plane, old_plane_state,
 					    new_plane_state, new_crtc_state,
 					    &bundle->flip_addrs[planes_count],
+					    acrtc_state->stream->link->psr_settings.psr_version ==
+					    DC_PSR_VERSION_SU_1,
 					    &dirty_rects_changed);
 
 			/*


