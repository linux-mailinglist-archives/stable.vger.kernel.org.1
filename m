Return-Path: <stable+bounces-6955-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6018D816746
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 08:19:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 160311F223F1
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 07:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF7C79E2;
	Mon, 18 Dec 2023 07:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PEFhEIvy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA15279D1
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:19:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB3EAC433C8;
	Mon, 18 Dec 2023 07:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702883993;
	bh=k9QRdMHCJZTf1Sd6y+Ot12hBypIv9AvsVf4rCQny79M=;
	h=Subject:To:Cc:From:Date:From;
	b=PEFhEIvy+h7STpGwCQ+TuHpLh4K0PLGD+7QjBRiX4j9xfTwxsSybRLprzHiu3WRls
	 HBWQdkT9SbqKbBNwG49aWTtWOLpiOgPDBPSinuWPD4zwBTC6aW3lDoGjMr3SxeGtuF
	 V7JZ+3LEDgVCGvXa4Abhm5tUodWJnLcP1YjY2XJE=
Subject: FAILED: patch "[PATCH] drm/i915/edp: don't write to DP_LINK_BW_SET when using rate" failed to apply to 6.1-stable tree
To: jani.nikula@intel.com,animesh.manna@intel.com,uma.shankar@intel.com,ville.syrjala@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 18 Dec 2023 08:19:42 +0100
Message-ID: <2023121842-qualm-bootie-5c96@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x e6861d8264cd43c5eb20196e53df36fd71ec5698
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023121842-qualm-bootie-5c96@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

e6861d8264cd ("drm/i915/edp: don't write to DP_LINK_BW_SET when using rate select")
3072a24c778a ("drm/i915: Introduce crtc_state->enhanced_framing")
3dfeb80b3088 ("drm/i915: Fix FEC state dump")
f60500f31e99 ("drm/i915/display/dp: 128/132b LT requirement")
23ef61946374 ("drm/i915/mtl/display: Implement DisplayPort sequences")
51390cc0e00a ("drm/i915/mtl: Add Support for C10 PHY message bus and pll programming")
a42e65f33c38 ("drm/i915/mtl: Create separate reg file for PICA registers")
99cfbed19d06 ("drm/i915/vrr: Relocate VRR enable/disable")
ecaeecea9263 ("drm/i915/vrr: Tell intel_crtc_update_active_timings() about VRR explicitly")
fa9e4fce52ec ("drm/i915/vrr: Make delayed vblank operational in VRR mode on adl/dg2")
b25e07419fee ("drm/i915/vrr: Eliminate redundant function arguments")
6a9856075563 ("drm/i915: Generalize planes_{enabling,disabling}()")
57b5482bff9e ("drm/i915: Introduce intel_csc_matrix struct")
c5de248484af ("drm/i915/dpt: Add a modparam to disable DPT via the chicken bit")
5a08585d38d6 ("drm/i915: Add PLANE_CHICKEN registers")
1a324a40b452 ("i915/display/dp: SDP CRC16 for 128b132b link layer")
b5202a93cd37 ("drm/i915: Extract intel_crtc_scanline_offset()")
84f4ebe8c1ab ("drm/i915: Relocate intel_crtc_update_active_timings()")
6e8acb6686d8 ("drm/i915: Add belts and suspenders locking for seamless M/N changes")
8cb1f95cca68 ("drm/i915: Update vblank timestamping stuff on seamless M/N change")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e6861d8264cd43c5eb20196e53df36fd71ec5698 Mon Sep 17 00:00:00 2001
From: Jani Nikula <jani.nikula@intel.com>
Date: Tue, 5 Dec 2023 20:05:51 +0200
Subject: [PATCH] drm/i915/edp: don't write to DP_LINK_BW_SET when using rate
 select
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The eDP 1.5 spec adds a clarification for eDP 1.4x:

> For eDP v1.4x, if the Source device chooses the Main-Link rate by way
> of DPCD 00100h, the Sink device shall ignore DPCD 00115h[2:0].

We write 0 to DP_LINK_BW_SET (DPCD 100h) even when using
DP_LINK_RATE_SET (DPCD 114h). Stop doing that, as it can cause the panel
to ignore the rate set method.

Moreover, 0 is a reserved value for DP_LINK_BW_SET, and should not be
used.

v2: Improve the comments (Ville)

Closes: https://gitlab.freedesktop.org/drm/intel/-/issues/9081
Tested-by: Animesh Manna <animesh.manna@intel.com>
Reviewed-by: Uma Shankar <uma.shankar@intel.com>
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20231205180551.2476228-1-jani.nikula@intel.com
(cherry picked from commit 23b392b94acb0499f69706c5808c099f590ebcf4)
Cc: stable@vger.kernel.org
Signed-off-by: Jani Nikula <jani.nikula@intel.com>

diff --git a/drivers/gpu/drm/i915/display/intel_dp_link_training.c b/drivers/gpu/drm/i915/display/intel_dp_link_training.c
index dbc1b66c8ee4..1abfafbbfa75 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_link_training.c
+++ b/drivers/gpu/drm/i915/display/intel_dp_link_training.c
@@ -650,19 +650,30 @@ intel_dp_update_link_bw_set(struct intel_dp *intel_dp,
 			    const struct intel_crtc_state *crtc_state,
 			    u8 link_bw, u8 rate_select)
 {
-	u8 link_config[2];
+	u8 lane_count = crtc_state->lane_count;
 
-	/* Write the link configuration data */
-	link_config[0] = link_bw;
-	link_config[1] = crtc_state->lane_count;
 	if (crtc_state->enhanced_framing)
-		link_config[1] |= DP_LANE_COUNT_ENHANCED_FRAME_EN;
-	drm_dp_dpcd_write(&intel_dp->aux, DP_LINK_BW_SET, link_config, 2);
+		lane_count |= DP_LANE_COUNT_ENHANCED_FRAME_EN;
 
-	/* eDP 1.4 rate select method. */
-	if (!link_bw)
-		drm_dp_dpcd_write(&intel_dp->aux, DP_LINK_RATE_SET,
-				  &rate_select, 1);
+	if (link_bw) {
+		/* DP and eDP v1.3 and earlier link bw set method. */
+		u8 link_config[] = { link_bw, lane_count };
+
+		drm_dp_dpcd_write(&intel_dp->aux, DP_LINK_BW_SET, link_config,
+				  ARRAY_SIZE(link_config));
+	} else {
+		/*
+		 * eDP v1.4 and later link rate set method.
+		 *
+		 * eDP v1.4x sinks shall ignore DP_LINK_RATE_SET if
+		 * DP_LINK_BW_SET is set. Avoid writing DP_LINK_BW_SET.
+		 *
+		 * eDP v1.5 sinks allow choosing either, and the last choice
+		 * shall be active.
+		 */
+		drm_dp_dpcd_writeb(&intel_dp->aux, DP_LANE_COUNT_SET, lane_count);
+		drm_dp_dpcd_writeb(&intel_dp->aux, DP_LINK_RATE_SET, rate_select);
+	}
 }
 
 /*


