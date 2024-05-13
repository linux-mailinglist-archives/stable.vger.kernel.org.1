Return-Path: <stable+bounces-43708-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DDA38C4402
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 17:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91B04B23F58
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 15:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988835672;
	Mon, 13 May 2024 15:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wFkSadLs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563944C84
	for <stable@vger.kernel.org>; Mon, 13 May 2024 15:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715613443; cv=none; b=hP+XyDUWpOxEHwBsAkFE3hzXfP4QHMPrHqoD5yiwnOja6ysgQ7vehLD3pvEXIpXkuXvRc7qBvHrpyZ3zx5zVzyV45wcrntI5nD9hrkURK95VuYMay3bfQeZkmb84yMpyufBoS4nmK1XYtIM9ArnUud/H0BRYpcTe6lh/g0M/sQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715613443; c=relaxed/simple;
	bh=Gcf321kD3rpsAFqShMA78qsH84tglcrOgKBtfjwAuBY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=I2wKYxT5M6j1iPITPrBh5wKSlTJmipcXx2oi4X7crG3DmJu0H8ps+hA5Hw4r/AV8qe2VzD1DPuAieN4w6y74jKt3NpSxPLBSWugkCaFPrHNQpQxp/Z+p2MX81a7U9+/L2LRo9+17FxBdFk3MROeVGwWoSfTrnbCNf2DA1hiGzkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wFkSadLs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69E91C113CC;
	Mon, 13 May 2024 15:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715613443;
	bh=Gcf321kD3rpsAFqShMA78qsH84tglcrOgKBtfjwAuBY=;
	h=Subject:To:Cc:From:Date:From;
	b=wFkSadLshxs5lKWFhf+8nu6Fu7YaH/Ay/Masjr0k+zVxJF231iue02Sm8jm9TxwtJ
	 ht7NwZk/AqQTfkHKLWk2inwdDvuC8LgDhiNs2hrsUcyIpjSqHV5ezO+vW/zDU0rSik
	 v22ANesbjvxiRsfOKwciIlse+cvtMPBOYKEQ5vxE=
Subject: FAILED: patch "[PATCH] drm/amd/display: Fix incorrect DSC instance for MST" failed to apply to 4.19-stable tree
To: hersenxs.wu@amd.com,alexander.deucher@amd.com,aurabindo.pillai@amd.com,daniel.wheeler@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 May 2024 17:17:06 +0200
Message-ID: <2024051306-spender-monotone-7bf7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x 892b41b16f6163e6556545835abba668fcab4eea
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024051306-spender-monotone-7bf7@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

892b41b16f61 ("drm/amd/display: Fix incorrect DSC instance for MST")
f8e12e770e80 ("drm/amd/display: drop unnecessary NULL checks in debugfs")
e3b0079be8f0 ("drm/amd/display: Clean up some inconsistent indenting")
5d5c6dba2b43 ("drm/amd/display: Fix memory leak")
712343cd21ea ("drm/amd/display: Add function and debugfs to dump DCC_EN bit")
46a83eba276c ("drm/amd/display: Add debugfs to control DMUB trace buffer events")
0dd795323405 ("drm/amdgpu/display: Implement functions to let DC allocate GPU memory")
0b7421f0a6a4 ("drm/amd/display: Old sequence for HUBP blank")
e7a30ade740f ("Revert "drm/amd/display: Unblank hubp based on plane visibility"")
afd3a359c452 ("drm/amd/display: do not use drm middle layer for debugfs")
dbb7898ac1bc ("drm/amd/display: Drop SOC bounding box hookup in DM/DC")
d209124ddae3 ("drm/amd/display: enable HUBP blank behaviour")
985faf2c4ecb ("drm/amd/display: New sequence for HUBP blank")
fd1c85d3ac2c ("drm/amd/display: Unblank hubp based on plane visibility")
5a83bf80723d ("drm/amd/display: Use provided offset for DPG generation")
9a3e698c0758 ("drm/amd/display: init soc bounding box for dcn3.01.")
20f2ffe50472 ("drm/amdgpu: fold CONFIG_DRM_AMD_DC_DCN3* into CONFIG_DRM_AMD_DC_DCN (v3)")
4dbcdc9cada2 ("drm/amd/display: fix the NULL pointer that missed set_disp_pattern_generator callback")
b15bfd0d8613 ("drm/amd/display: Revert HUBP blank behaviour for now")
dbf5256bbf19 ("drm/amd/display: Blank HUBP during pixel data blank for DCN30 v2")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 892b41b16f6163e6556545835abba668fcab4eea Mon Sep 17 00:00:00 2001
From: Hersen Wu <hersenxs.wu@amd.com>
Date: Tue, 13 Feb 2024 14:26:06 -0500
Subject: [PATCH] drm/amd/display: Fix incorrect DSC instance for MST

[Why] DSC debugfs, such as dp_dsc_clock_en_read,
use aconnector->dc_link to find pipe_ctx for display.
Displays connected to MST hub share the same dc_link.
DSC instance is from pipe_ctx. This causes incorrect
DSC instance for display connected to MST hub.

[How] Add aconnector->sink check to find pipe_ctx.

CC: stable@vger.kernel.org
Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Hersen Wu <hersenxs.wu@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index eee4945653e2..c7715a17f388 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -1495,7 +1495,9 @@ static ssize_t dp_dsc_clock_en_read(struct file *f, char __user *buf,
 	for (i = 0; i < MAX_PIPES; i++) {
 		pipe_ctx = &aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i];
 		if (pipe_ctx->stream &&
-		    pipe_ctx->stream->link == aconnector->dc_link)
+		    pipe_ctx->stream->link == aconnector->dc_link &&
+		    pipe_ctx->stream->sink &&
+		    pipe_ctx->stream->sink == aconnector->dc_sink)
 			break;
 	}
 
@@ -1596,7 +1598,9 @@ static ssize_t dp_dsc_clock_en_write(struct file *f, const char __user *buf,
 	for (i = 0; i < MAX_PIPES; i++) {
 		pipe_ctx = &aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i];
 		if (pipe_ctx->stream &&
-		    pipe_ctx->stream->link == aconnector->dc_link)
+		    pipe_ctx->stream->link == aconnector->dc_link &&
+		    pipe_ctx->stream->sink &&
+		    pipe_ctx->stream->sink == aconnector->dc_sink)
 			break;
 	}
 
@@ -1681,7 +1685,9 @@ static ssize_t dp_dsc_slice_width_read(struct file *f, char __user *buf,
 	for (i = 0; i < MAX_PIPES; i++) {
 		pipe_ctx = &aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i];
 		if (pipe_ctx->stream &&
-		    pipe_ctx->stream->link == aconnector->dc_link)
+		    pipe_ctx->stream->link == aconnector->dc_link &&
+		    pipe_ctx->stream->sink &&
+		    pipe_ctx->stream->sink == aconnector->dc_sink)
 			break;
 	}
 
@@ -1780,7 +1786,9 @@ static ssize_t dp_dsc_slice_width_write(struct file *f, const char __user *buf,
 	for (i = 0; i < MAX_PIPES; i++) {
 		pipe_ctx = &aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i];
 		if (pipe_ctx->stream &&
-		    pipe_ctx->stream->link == aconnector->dc_link)
+		    pipe_ctx->stream->link == aconnector->dc_link &&
+		    pipe_ctx->stream->sink &&
+		    pipe_ctx->stream->sink == aconnector->dc_sink)
 			break;
 	}
 
@@ -1865,7 +1873,9 @@ static ssize_t dp_dsc_slice_height_read(struct file *f, char __user *buf,
 	for (i = 0; i < MAX_PIPES; i++) {
 		pipe_ctx = &aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i];
 		if (pipe_ctx->stream &&
-		    pipe_ctx->stream->link == aconnector->dc_link)
+		    pipe_ctx->stream->link == aconnector->dc_link &&
+		    pipe_ctx->stream->sink &&
+		    pipe_ctx->stream->sink == aconnector->dc_sink)
 			break;
 	}
 
@@ -1964,7 +1974,9 @@ static ssize_t dp_dsc_slice_height_write(struct file *f, const char __user *buf,
 	for (i = 0; i < MAX_PIPES; i++) {
 		pipe_ctx = &aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i];
 		if (pipe_ctx->stream &&
-		    pipe_ctx->stream->link == aconnector->dc_link)
+		    pipe_ctx->stream->link == aconnector->dc_link &&
+		    pipe_ctx->stream->sink &&
+		    pipe_ctx->stream->sink == aconnector->dc_sink)
 			break;
 	}
 
@@ -2045,7 +2057,9 @@ static ssize_t dp_dsc_bits_per_pixel_read(struct file *f, char __user *buf,
 	for (i = 0; i < MAX_PIPES; i++) {
 		pipe_ctx = &aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i];
 		if (pipe_ctx->stream &&
-		    pipe_ctx->stream->link == aconnector->dc_link)
+		    pipe_ctx->stream->link == aconnector->dc_link &&
+		    pipe_ctx->stream->sink &&
+		    pipe_ctx->stream->sink == aconnector->dc_sink)
 			break;
 	}
 
@@ -2141,7 +2155,9 @@ static ssize_t dp_dsc_bits_per_pixel_write(struct file *f, const char __user *bu
 	for (i = 0; i < MAX_PIPES; i++) {
 		pipe_ctx = &aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i];
 		if (pipe_ctx->stream &&
-		    pipe_ctx->stream->link == aconnector->dc_link)
+		    pipe_ctx->stream->link == aconnector->dc_link &&
+		    pipe_ctx->stream->sink &&
+		    pipe_ctx->stream->sink == aconnector->dc_sink)
 			break;
 	}
 
@@ -2220,7 +2236,9 @@ static ssize_t dp_dsc_pic_width_read(struct file *f, char __user *buf,
 	for (i = 0; i < MAX_PIPES; i++) {
 		pipe_ctx = &aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i];
 		if (pipe_ctx->stream &&
-		    pipe_ctx->stream->link == aconnector->dc_link)
+		    pipe_ctx->stream->link == aconnector->dc_link &&
+		    pipe_ctx->stream->sink &&
+		    pipe_ctx->stream->sink == aconnector->dc_sink)
 			break;
 	}
 
@@ -2276,7 +2294,9 @@ static ssize_t dp_dsc_pic_height_read(struct file *f, char __user *buf,
 	for (i = 0; i < MAX_PIPES; i++) {
 		pipe_ctx = &aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i];
 		if (pipe_ctx->stream &&
-		    pipe_ctx->stream->link == aconnector->dc_link)
+		    pipe_ctx->stream->link == aconnector->dc_link &&
+		    pipe_ctx->stream->sink &&
+		    pipe_ctx->stream->sink == aconnector->dc_sink)
 			break;
 	}
 
@@ -2347,7 +2367,9 @@ static ssize_t dp_dsc_chunk_size_read(struct file *f, char __user *buf,
 	for (i = 0; i < MAX_PIPES; i++) {
 		pipe_ctx = &aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i];
 		if (pipe_ctx->stream &&
-		    pipe_ctx->stream->link == aconnector->dc_link)
+		    pipe_ctx->stream->link == aconnector->dc_link &&
+		    pipe_ctx->stream->sink &&
+		    pipe_ctx->stream->sink == aconnector->dc_sink)
 			break;
 	}
 
@@ -2418,7 +2440,9 @@ static ssize_t dp_dsc_slice_bpg_offset_read(struct file *f, char __user *buf,
 	for (i = 0; i < MAX_PIPES; i++) {
 		pipe_ctx = &aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i];
 		if (pipe_ctx->stream &&
-		    pipe_ctx->stream->link == aconnector->dc_link)
+		    pipe_ctx->stream->link == aconnector->dc_link &&
+		    pipe_ctx->stream->sink &&
+		    pipe_ctx->stream->sink == aconnector->dc_sink)
 			break;
 	}
 


