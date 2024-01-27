Return-Path: <stable+bounces-16145-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC7B83F0FB
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 23:40:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4CFE1F216DA
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 22:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60731DFFB;
	Sat, 27 Jan 2024 22:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="T70OymRe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854A61D6B8
	for <stable@vger.kernel.org>; Sat, 27 Jan 2024 22:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706395240; cv=none; b=WwAllx6FoCsaN75jaAH28hJJPv3/ib0kzY2FHSm1Qeyfeu2+drosAOSloA/0wcbRo3YkpLQNybLiIlgQmHg5b3zwZhY6esuaFK+keSHss+mLqJs0yLjEKxQ+Y2n9amUYgoIuhtmpldbQhWKPkwInGtJLYHHWHXdj1HLxlOedg7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706395240; c=relaxed/simple;
	bh=FcMqYtkzEgqBJHQfVSKCU8X1zWbLUCk/pd6tn/oSQqo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Y1Femk9P4ZPjM+vEh2FMYwb2Yv7LelPkk6mo2l+ofBnO6TiowzYIMau9MhpFeCFK9lbJORNuFo3bdFR/Q0s209EwWc2YBsMj8c5WSmgRtAaZ+Y/H9up+9u4wGH4WTDZVaxXGoe8/E8U1S/pjHElBDAoGUzv01mQ8pBdxYNqxMpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=T70OymRe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA45EC433F1;
	Sat, 27 Jan 2024 22:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706395240;
	bh=FcMqYtkzEgqBJHQfVSKCU8X1zWbLUCk/pd6tn/oSQqo=;
	h=Subject:To:Cc:From:Date:From;
	b=T70OymReJBe7aWowi1xxyudreWZpViI+7k88W3LNqOl46ZzK5XOsW2PMx7fLaMxz5
	 8Jd/nNACL8SBLMqyNBGNKoDKS0X0vu7PbmhFFz8/n1rDXQeehCT/iprpo0uoKRRC8J
	 D8zHamEoB9aC7mNSpirPSgGL/2HE49zWaNC+GcZ0=
Subject: FAILED: patch "[PATCH] drm/amd/display: Remove min_dst_y_next_start check for Z8" failed to apply to 6.1-stable tree
To: nicholas.kazlauskas@amd.com,alexander.deucher@amd.com,hamza.mahfooz@amd.com,syed.hassan@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 27 Jan 2024 14:40:39 -0800
Message-ID: <2024012738-wieldable-playhouse-613e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x fcd94ef1b3e78f7dc76309c9611915018d2d62a3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012738-wieldable-playhouse-613e@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

fcd94ef1b3e7 ("drm/amd/display: Remove min_dst_y_next_start check for Z8")
469a62938a45 ("drm/amd/display: update extended blank for dcn314 onwards")
e3416e872f84 ("drm/amd/display: Add FAMS validation before trying to use it")
0db13eae41fc ("drm/amd/display: Add minimum Z8 residency debug option")
73dd4ca4b5a0 ("drm/amd/display: Fix Z8 support configurations")
db4107e92a81 ("drm/amd/display: fix dc/core/dc.c kernel-doc")
00812bfc7bcb ("drm/amd/display: Add debug option to skip PSR CRTC disable")
80676936805e ("drm/amd/display: Add Z8 allow states to z-state support list")
e366f36958f6 ("drm/amd/display: Rework comments on dc file")
bd829d570773 ("drm/amd/display: Refactor eDP PSR codes")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From fcd94ef1b3e78f7dc76309c9611915018d2d62a3 Mon Sep 17 00:00:00 2001
From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Date: Wed, 8 Nov 2023 10:55:53 -0500
Subject: [PATCH] drm/amd/display: Remove min_dst_y_next_start check for Z8

[Why]
Flickering occurs on DRR supported panels when engaged in DRR due to
min_dst_y_next becoming larger than the frame size itself.

[How]
In general, we should be able to enter Z8 when this is engaged but it
might be a net power loss even if the calculation wasn't bugged.

Don't support enabling Z8 during the DRR region.

Cc: stable@vger.kernel.org # 6.1+
Reviewed-by: Syed Hassan <syed.hassan@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
index 7fc8b18096ba..ec77b2b41ba3 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
@@ -950,10 +950,8 @@ static enum dcn_zstate_support_state  decide_zstate_support(struct dc *dc, struc
 {
 	int plane_count;
 	int i;
-	unsigned int min_dst_y_next_start_us;
 
 	plane_count = 0;
-	min_dst_y_next_start_us = 0;
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
 		if (context->res_ctx.pipe_ctx[i].plane_state)
 			plane_count++;
@@ -975,26 +973,15 @@ static enum dcn_zstate_support_state  decide_zstate_support(struct dc *dc, struc
 	else if (context->stream_count == 1 &&  context->streams[0]->signal == SIGNAL_TYPE_EDP) {
 		struct dc_link *link = context->streams[0]->sink->link;
 		struct dc_stream_status *stream_status = &context->stream_status[0];
-		struct dc_stream_state *current_stream = context->streams[0];
 		int minmum_z8_residency = dc->debug.minimum_z8_residency_time > 0 ? dc->debug.minimum_z8_residency_time : 1000;
 		bool allow_z8 = context->bw_ctx.dml.vba.StutterPeriod > (double)minmum_z8_residency;
 		bool is_pwrseq0 = link->link_index == 0;
-		bool isFreesyncVideo;
-
-		isFreesyncVideo = current_stream->adjust.v_total_min == current_stream->adjust.v_total_max;
-		isFreesyncVideo = isFreesyncVideo && current_stream->timing.v_total < current_stream->adjust.v_total_min;
-		for (i = 0; i < dc->res_pool->pipe_count; i++) {
-			if (context->res_ctx.pipe_ctx[i].stream == current_stream && isFreesyncVideo) {
-				min_dst_y_next_start_us = context->res_ctx.pipe_ctx[i].dlg_regs.min_dst_y_next_start_us;
-				break;
-			}
-		}
 
 		/* Don't support multi-plane configurations */
 		if (stream_status->plane_count > 1)
 			return DCN_ZSTATE_SUPPORT_DISALLOW;
 
-		if (is_pwrseq0 && (context->bw_ctx.dml.vba.StutterPeriod > 5000.0 || min_dst_y_next_start_us > 5000))
+		if (is_pwrseq0 && context->bw_ctx.dml.vba.StutterPeriod > 5000.0)
 			return DCN_ZSTATE_SUPPORT_ALLOW;
 		else if (is_pwrseq0 && link->psr_settings.psr_version == DC_PSR_VERSION_1 && !link->panel_config.psr.disable_psr)
 			return allow_z8 ? DCN_ZSTATE_SUPPORT_ALLOW_Z8_Z10_ONLY : DCN_ZSTATE_SUPPORT_ALLOW_Z10_ONLY;


