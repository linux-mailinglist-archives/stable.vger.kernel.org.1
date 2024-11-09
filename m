Return-Path: <stable+bounces-92006-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6583B9C2DDF
	for <lists+stable@lfdr.de>; Sat,  9 Nov 2024 15:51:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAADF282857
	for <lists+stable@lfdr.de>; Sat,  9 Nov 2024 14:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E13261448E4;
	Sat,  9 Nov 2024 14:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WNDebylf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F13D1E4B2
	for <stable@vger.kernel.org>; Sat,  9 Nov 2024 14:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731163866; cv=none; b=IX7hR9mLX8eOMg5SFcl3FoCAsPNGC8fR8C7mjB2Oj2PkFul5hKt3I05abRzhaqChn5X76CFIDW2vywaCVhK5HKSrAUUNMgGTrLIWxbCYaS9rpIoNj9Cf11M8kpRfonh7138hUVaLlE3jOCRYZeOcmpSF1Qrt7iwqjiiQ34QWcf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731163866; c=relaxed/simple;
	bh=/mH+qV0lFuPxFT6/7YWRaEZWBTPy2H2o6bacznPvNHw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=h16T5/5FIC1qBM9mHuqcJLpFfpFV8eQvlMjXPKnmd7VXDu0oUxW2lSZ/KNMPYYuQLo+pDRPONyUUeYXTSeuyrT1WRklQ7VMA0co3ZraDjXUTRYFPQs7tiXHdaxfPQGLeiEuzRjbnf9LHUgtorseeTye61nhe6pag7t8h8y2WGZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WNDebylf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE974C4CECE;
	Sat,  9 Nov 2024 14:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731163866;
	bh=/mH+qV0lFuPxFT6/7YWRaEZWBTPy2H2o6bacznPvNHw=;
	h=Subject:To:Cc:From:Date:From;
	b=WNDebylfqGspJcqRcBuJ+pwOk5NE11A/Iprei7DOd4OHmchsa++a3zJNQcXlYWT1w
	 hrQT3Bshdhz4xxl4Au9qnmeYmErE74w/trhxkyGAaSW4iqZVJzfHZxDJJTf5Fb+4ZD
	 gpYPLLtm5I4wvmOq7zDFa9Xu7R+PE/amNLpPcsaY=
Subject: FAILED: patch "[PATCH] drm/amd/display: Fix brightness level not retained over" failed to apply to 6.6-stable tree
To: chiahsuan.chung@amd.com,alexander.deucher@amd.com,daniel.wheeler@amd.com,mario.limonciello@amd.com,mark.herbert42@gmail.com,sunpeng.li@amd.com,zaeem.mohamed@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 09 Nov 2024 15:51:02 +0100
Message-ID: <2024110902-backslid-snagged-6d02@gregkh>
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
git cherry-pick -x 4f26c95ffc21a91281429ed60180619bae19ae92
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024110902-backslid-snagged-6d02@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4f26c95ffc21a91281429ed60180619bae19ae92 Mon Sep 17 00:00:00 2001
From: Tom Chung <chiahsuan.chung@amd.com>
Date: Wed, 9 Oct 2024 17:09:38 +0800
Subject: [PATCH] drm/amd/display: Fix brightness level not retained over
 reboot

[Why]
During boot up and resume the DC layer will reset the panel
brightness to fix a flicker issue.

It will cause the dm->actual_brightness is not the current panel
brightness level. (the dm->brightness is the correct panel level)

[How]
Set the backlight level after do the set mode.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Fixes: d9e865826c20 ("drm/amd/display: Simplify brightness initialization")
Reported-by: Mark Herbert <mark.herbert42@gmail.com>
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3655
Reviewed-by: Sun peng Li <sunpeng.li@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 7875afafba84817b791be6d2282b836695146060)
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 13421a58210d..07e9ce99694f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -9429,6 +9429,7 @@ static void amdgpu_dm_commit_streams(struct drm_atomic_state *state,
 	bool mode_set_reset_required = false;
 	u32 i;
 	struct dc_commit_streams_params params = {dc_state->streams, dc_state->stream_count};
+	bool set_backlight_level = false;
 
 	/* Disable writeback */
 	for_each_old_connector_in_state(state, connector, old_con_state, i) {
@@ -9548,6 +9549,7 @@ static void amdgpu_dm_commit_streams(struct drm_atomic_state *state,
 			acrtc->hw_mode = new_crtc_state->mode;
 			crtc->hwmode = new_crtc_state->mode;
 			mode_set_reset_required = true;
+			set_backlight_level = true;
 		} else if (modereset_required(new_crtc_state)) {
 			drm_dbg_atomic(dev,
 				       "Atomic commit: RESET. crtc id %d:[%p]\n",
@@ -9599,6 +9601,19 @@ static void amdgpu_dm_commit_streams(struct drm_atomic_state *state,
 				acrtc->otg_inst = status->primary_otg_inst;
 		}
 	}
+
+	/* During boot up and resume the DC layer will reset the panel brightness
+	 * to fix a flicker issue.
+	 * It will cause the dm->actual_brightness is not the current panel brightness
+	 * level. (the dm->brightness is the correct panel level)
+	 * So we set the backlight level with dm->brightness value after set mode
+	 */
+	if (set_backlight_level) {
+		for (i = 0; i < dm->num_of_edps; i++) {
+			if (dm->backlight_dev[i])
+				amdgpu_dm_backlight_set_level(dm, i, dm->brightness[i]);
+		}
+	}
 }
 
 static void dm_set_writeback(struct amdgpu_display_manager *dm,


