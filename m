Return-Path: <stable+bounces-6954-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 487A9816745
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 08:19:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC47E1F22432
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 07:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D7979EB;
	Mon, 18 Dec 2023 07:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tUbmdhMx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11C979D9
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:19:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0778FC433C8;
	Mon, 18 Dec 2023 07:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702883984;
	bh=9W9HWWihUgSsJkiw+fLZg06wJqa8AEasutmNpAPf/d0=;
	h=Subject:To:Cc:From:Date:From;
	b=tUbmdhMx8Mz2jiutLsSKtugkimUYHF+AYYmzBHXrQ5G/wCvTgwnL7g52cAMjtgBjm
	 dFx3JdfAwGjV07wEvmVTP1wMJA5beHX4TqhamGCPN+nbyys/obTynz1lXW9q8cKH8G
	 QV9RXp/lrgeR/YYGdODwQTSNbQdiZvzT/BZv9Tss=
Subject: FAILED: patch "[PATCH] drm/i915/edp: don't write to DP_LINK_BW_SET when using rate" failed to apply to 6.6-stable tree
To: jani.nikula@intel.com,animesh.manna@intel.com,uma.shankar@intel.com,ville.syrjala@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 18 Dec 2023 08:19:41 +0100
Message-ID: <2023121841-backspin-troubling-44cf@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x e6861d8264cd43c5eb20196e53df36fd71ec5698
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023121841-backspin-troubling-44cf@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

e6861d8264cd ("drm/i915/edp: don't write to DP_LINK_BW_SET when using rate select")
3072a24c778a ("drm/i915: Introduce crtc_state->enhanced_framing")
3dfeb80b3088 ("drm/i915: Fix FEC state dump")

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


