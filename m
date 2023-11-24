Return-Path: <stable+bounces-257-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6132C7F7609
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 15:14:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 929601C20936
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 14:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 703A92C1BE;
	Fri, 24 Nov 2023 14:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HZbi1EsX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0CF28E25
	for <stable@vger.kernel.org>; Fri, 24 Nov 2023 14:13:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AFFCC43391;
	Fri, 24 Nov 2023 14:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700835239;
	bh=kI8umhBAjByI8R/VBH87uRNwnkQANbPvJMm3wY1ayIQ=;
	h=Subject:To:Cc:From:Date:From;
	b=HZbi1EsXqErsNC+fcMeqi1l1DmX0pDH+JltlvBGL/NslnnIl+bSHhWOOHkwNMvxFt
	 VeUtSAUHDtEb9mo5MAjp54ZIaRomeWbohhiKvGvZBgFwzDG9J2eu1A019WMgnNKAuP
	 IJ9UwCdDwBAYOmXmq4W7L7qfBodgiXtZwSLwHiM0=
Subject: FAILED: patch "[PATCH] drm/amd/display: limit the v_startup workaround to ASICs" failed to apply to 6.6-stable tree
To: hamza.mahfooz@amd.com,alexander.deucher@amd.com,jerry.zuo@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 24 Nov 2023 14:13:57 +0000
Message-ID: <2023112457-stillness-wildcat-9d9e@gregkh>
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
git cherry-pick -x 813ba1ff8484e801d2ef155e0e5388b8a7691788
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023112457-stillness-wildcat-9d9e@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

813ba1ff8484 ("drm/amd/display: limit the v_startup workaround to ASICs older than DCN3.1")
63461ea3fb40 ("Revert "drm/amd/display: Remove v_startup workaround for dcn3+"")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 813ba1ff8484e801d2ef155e0e5388b8a7691788 Mon Sep 17 00:00:00 2001
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
Date: Thu, 31 Aug 2023 15:22:35 -0400
Subject: [PATCH] drm/amd/display: limit the v_startup workaround to ASICs
 older than DCN3.1

Since, calling dcn20_adjust_freesync_v_startup() on DCN3.1+ ASICs
can cause the display to flicker and underflow to occur, we shouldn't
call it for them. So, ensure that the DCN version is less than
DCN_VERSION_3_1 before calling dcn20_adjust_freesync_v_startup().

Cc: stable@vger.kernel.org
Reviewed-by: Fangzhi Zuo <jerry.zuo@amd.com>
Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
index 1bfdf0271fdf..a68fb45ed487 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
@@ -1099,7 +1099,8 @@ void dcn20_calculate_dlg_params(struct dc *dc,
 		context->res_ctx.pipe_ctx[i].plane_res.bw.dppclk_khz =
 						pipes[pipe_idx].clks_cfg.dppclk_mhz * 1000;
 		context->res_ctx.pipe_ctx[i].pipe_dlg_param = pipes[pipe_idx].pipe.dest;
-		if (context->res_ctx.pipe_ctx[i].stream->adaptive_sync_infopacket.valid)
+		if (dc->ctx->dce_version < DCN_VERSION_3_1 &&
+		    context->res_ctx.pipe_ctx[i].stream->adaptive_sync_infopacket.valid)
 			dcn20_adjust_freesync_v_startup(
 				&context->res_ctx.pipe_ctx[i].stream->timing,
 				&context->res_ctx.pipe_ctx[i].pipe_dlg_param.vstartup_start);


