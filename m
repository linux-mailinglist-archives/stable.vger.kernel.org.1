Return-Path: <stable+bounces-43704-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B0B8C43FC
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 17:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A787A2874F5
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 15:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4DBB1DDC5;
	Mon, 13 May 2024 15:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BpyO+vya"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A994C84
	for <stable@vger.kernel.org>; Mon, 13 May 2024 15:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715613429; cv=none; b=twPFkk1HGA4lr+SA/oEaTiqLz4q5LpV/uKVPKQhcUWQK0wAfAALGwnRyzV3iKwH8qxRgE3LlR5XpviMOf4Ch379HpwHAjxXbN0kkjZb1XVjGEO3UMnaOm0qPm53GbQwt+4Hh6fd6dUim7idBt1XWGSAietZuo1ig2Q6WxZBEdtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715613429; c=relaxed/simple;
	bh=5TTpls5wGEgHKymlHdAS674hnDvlPRkLsnhPnnVpE2c=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=KEC2vie/EU5IfDmnVdtC6uyTTuTSa+rlt4LG37dwtH+OPQ+sZ3fgPTFz87sdA+f2kibN4z7oKtcgrFcGBmx0Y8d8yAPySaumD/KkzqzeBeU8WwqKh18IUzlduD1eYx+pkHYDrOj+wB3FLgFKzpj8P184x3x+lDad+L/+bwnM9E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BpyO+vya; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CD60C113CC;
	Mon, 13 May 2024 15:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715613429;
	bh=5TTpls5wGEgHKymlHdAS674hnDvlPRkLsnhPnnVpE2c=;
	h=Subject:To:Cc:From:Date:From;
	b=BpyO+vyat0pJJx1c8JUTik4V+HzgTPZiunRI3fu2PNEZEpHRmS6bIqblIdNo9zgpU
	 FUK0mvoZUrVt4o1iRLZXsRGyPUqDhTyJyQa1oTPj3gip4xn2chrQLNp5AgWbQiGDhJ
	 l6k79Jw9t0K2Wx5J/RTNKDE9PB4+RuxaplR2BqZk=
Subject: FAILED: patch "[PATCH] drm/amd/display: Fix incorrect DSC instance for MST" failed to apply to 6.1-stable tree
To: hersenxs.wu@amd.com,alexander.deucher@amd.com,aurabindo.pillai@amd.com,daniel.wheeler@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 May 2024 17:17:03 +0200
Message-ID: <2024051303-ribcage-visor-6e15@gregkh>
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
git cherry-pick -x 892b41b16f6163e6556545835abba668fcab4eea
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024051303-ribcage-visor-6e15@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

892b41b16f61 ("drm/amd/display: Fix incorrect DSC instance for MST")
f8e12e770e80 ("drm/amd/display: drop unnecessary NULL checks in debugfs")

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
 


