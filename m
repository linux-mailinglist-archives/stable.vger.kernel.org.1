Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33BBF7ECAEA
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:00:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbjKOTAp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:00:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbjKOTAo (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:00:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18912D48
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:00:37 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66316C433C7;
        Wed, 15 Nov 2023 19:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700074836;
        bh=8rriS3j1O61GvGdi0MTFeF2Z1DsgyIgWE7ydA0JGMJA=;
        h=Subject:To:Cc:From:Date:From;
        b=yuPD6+Kgo7B4oTZEdh9NL0jw8hr3hpsjlW/1SnLbyOwXw+ozrSIqP9XWmIJJ2LEXV
         LnNUxpYTapXz4egnq1V8lqDZLrYS4Czt+bOpuvNAVRfFBRAuLsct39XMOCr/MU2Tdd
         o5lV98SDVxA5UY2ravrJeCXE8TxpIEjF8cyzk+CE=
Subject: FAILED: patch "[PATCH] Revert "drm/amd/display: Enable Replay for static screen use" failed to apply to 6.6-stable tree
To:     ivlipski@amd.com, alexander.deucher@amd.com, hamza.mahfooz@amd.com,
        sunpeng.li@amd.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Wed, 15 Nov 2023 14:00:34 -0500
Message-ID: <2023111533-crestless-obsolete-f27c@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 62e6a28684b21c1c575ddb14938859ba417287ab
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023111533-crestless-obsolete-f27c@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

62e6a28684b2 ("Revert "drm/amd/display: Enable Replay for static screen use cases"")
49a8f94b1fb0 ("drm/amd/display: Enable replay for dcn35")
4e8303cf2c4d ("drm/amdgpu: Use function for IP version check")
6b7d211740da ("drm/amdgpu: Fix refclk reporting for SMU v13.0.6")
1b8e56b99459 ("drm/amdgpu: Restrict bootloader wait to SMUv13.0.6")
983ac45a06ae ("drm/amdgpu: update SET_HW_RESOURCES definition for UMSCH")
822f7808291f ("drm/amdgpu/discovery: enable UMSCH 4.0 in IP discovery")
3488c79beafa ("drm/amdgpu: add initial support for UMSCH")
2da1b04a2096 ("drm/amdgpu: add UMSCH 4.0 api definition")
3ee8fb7005ef ("drm/amdgpu: enable VPE for VPE 6.1.0")
9d4346bdbc64 ("drm/amdgpu: add VPE 6.1.0 support")
e370f8f38976 ("drm/amdgpu: Add bootloader wait for PSP v13")
aba2be41470a ("drm/amdgpu: add mmhub 3.3.0 support")
15e7cbd91de6 ("drm/amdgpu/gfx11: initialize gfx11.5.0")
f56c1941ebb7 ("drm/amdgpu: use 6.1.0 register offset for HDP CLK_CNTL")
15c5c5f57514 ("drm/amdgpu: Add bootloader status check")
3cce0bfcd0f9 ("drm/amd/display: Enable Replay for static screen use cases")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 62e6a28684b21c1c575ddb14938859ba417287ab Mon Sep 17 00:00:00 2001
From: Ivan Lipski <ivlipski@amd.com>
Date: Mon, 2 Oct 2023 13:47:54 -0400
Subject: [PATCH] Revert "drm/amd/display: Enable Replay for static screen use
 cases"

This reverts commit 44e60b14d5a72f91fd0bdeae8da59ae37a3ca8e5.

Since, it causes a regression in which eDP displays with PSR support,
but no Replay support (Sink support <= 0x03), fail to enable PSR and
consequently all IGT amd_psr tests fail. So, revert this until a more
suitable fix can be found.

Cc: stable@vger.kernel.org
Acked-by: Leo Li <sunpeng.li@amd.com>
Signed-off-by: Ivan Lipski <ivlipski@amd.com>
Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 1d8248cb1798..bef17c1519d0 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -66,7 +66,6 @@
 #include "amdgpu_dm_debugfs.h"
 #endif
 #include "amdgpu_dm_psr.h"
-#include "amdgpu_dm_replay.h"
 
 #include "ivsrcid/ivsrcid_vislands30.h"
 
@@ -4423,7 +4422,6 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 	enum dc_connection_type new_connection_type = dc_connection_none;
 	const struct dc_plane_cap *plane;
 	bool psr_feature_enabled = false;
-	bool replay_feature_enabled = false;
 	int max_overlay = dm->dc->caps.max_slave_planes;
 
 	dm->display_indexes_num = dm->dc->caps.max_streams;
@@ -4535,21 +4533,6 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 		}
 	}
 
-	if (!(amdgpu_dc_debug_mask & DC_DISABLE_REPLAY)) {
-		switch (amdgpu_ip_version(adev, DCE_HWIP, 0)) {
-		case IP_VERSION(3, 1, 4):
-		case IP_VERSION(3, 1, 5):
-		case IP_VERSION(3, 1, 6):
-		case IP_VERSION(3, 2, 0):
-		case IP_VERSION(3, 2, 1):
-		case IP_VERSION(3, 5, 0):
-			replay_feature_enabled = true;
-			break;
-		default:
-			replay_feature_enabled = amdgpu_dc_feature_mask & DC_REPLAY_MASK;
-			break;
-		}
-	}
 	/* loops over all connectors on the board */
 	for (i = 0; i < link_cnt; i++) {
 		struct dc_link *link = NULL;
@@ -4618,12 +4601,6 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 				amdgpu_dm_update_connector_after_detect(aconnector);
 				setup_backlight_device(dm, aconnector);
 
-				/*
-				 * Disable psr if replay can be enabled
-				 */
-				if (replay_feature_enabled && amdgpu_dm_setup_replay(link, aconnector))
-					psr_feature_enabled = false;
-
 				if (psr_feature_enabled)
 					amdgpu_dm_set_psr_caps(link);
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
index 97b7a0b8a1c2..30d4c6fd95f5 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
@@ -29,7 +29,6 @@
 #include "dc.h"
 #include "amdgpu.h"
 #include "amdgpu_dm_psr.h"
-#include "amdgpu_dm_replay.h"
 #include "amdgpu_dm_crtc.h"
 #include "amdgpu_dm_plane.h"
 #include "amdgpu_dm_trace.h"
@@ -124,12 +123,7 @@ static void vblank_control_worker(struct work_struct *work)
 	 * fill_dc_dirty_rects().
 	 */
 	if (vblank_work->stream && vblank_work->stream->link) {
-		/*
-		 * Prioritize replay, instead of psr
-		 */
-		if (vblank_work->stream->link->replay_settings.replay_feature_enabled)
-			amdgpu_dm_replay_enable(vblank_work->stream, false);
-		else if (vblank_work->enable) {
+		if (vblank_work->enable) {
 			if (vblank_work->stream->link->psr_settings.psr_version < DC_PSR_VERSION_SU_1 &&
 			    vblank_work->stream->link->psr_settings.psr_allow_active)
 				amdgpu_dm_psr_disable(vblank_work->stream);
@@ -138,7 +132,6 @@ static void vblank_control_worker(struct work_struct *work)
 #ifdef CONFIG_DRM_AMD_SECURE_DISPLAY
 			   !amdgpu_dm_crc_window_is_activated(&vblank_work->acrtc->base) &&
 #endif
-			   vblank_work->stream->link->panel_config.psr.disallow_replay &&
 			   vblank_work->acrtc->dm_irq_params.allow_psr_entry) {
 			amdgpu_dm_psr_enable(vblank_work->stream);
 		}
diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index 314fd44ec018..ce75351204bb 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -244,7 +244,6 @@ enum DC_FEATURE_MASK {
 	DC_DISABLE_LTTPR_DP2_0 = (1 << 6), //0x40, disabled by default
 	DC_PSR_ALLOW_SMU_OPT = (1 << 7), //0x80, disabled by default
 	DC_PSR_ALLOW_MULTI_DISP_OPT = (1 << 8), //0x100, disabled by default
-	DC_REPLAY_MASK = (1 << 9), //0x200, disabled by default for dcn < 3.1.4
 };
 
 enum DC_DEBUG_MASK {
@@ -255,7 +254,6 @@ enum DC_DEBUG_MASK {
 	DC_DISABLE_PSR = 0x10,
 	DC_FORCE_SUBVP_MCLK_SWITCH = 0x20,
 	DC_DISABLE_MPO = 0x40,
-	DC_DISABLE_REPLAY = 0x50,
 	DC_ENABLE_DPIA_TRACE = 0x80,
 };
 

