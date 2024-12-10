Return-Path: <stable+bounces-100359-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD97B9EAC2D
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 10:34:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2910218828CD
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 09:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D63C223E67;
	Tue, 10 Dec 2024 09:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="brZgMaf3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D230D223E60
	for <stable@vger.kernel.org>; Tue, 10 Dec 2024 09:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733823028; cv=none; b=G8TakXfyXHvWftW5g6rPagxdH2ZoBH82uWrT97J173xHKhoGq87joFs6gIrk9YES5xpd0A/2eTkDyWxgPRDi49xnEOfwy/a2+zlIQGPuGOdx9j9EQ9pzA37TRUDXHO4louEaq1AcWUST0xPPONZpd85SugeLYNfghWU/PxNvHFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733823028; c=relaxed/simple;
	bh=IFU3XDZtIzskMLZGdyYwcoQS3UX5FfBDq3U/xN0iRtw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=qrB7YNqWTfPH6k0E1SILRAI8ryKTDsavb1irCYAiwz/Ycf8xogLDEf58SguNE6RqPSOInuLX1vU6a7+omgsIiouOsGbxRysK9Yh92dElBF7YSJIZqpf36CcuGDJQJZvFsR8EEyMOk+Mr6tY7mUeqesPTCFu13PpH7aWfjeJwDIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=brZgMaf3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E754C4CED6;
	Tue, 10 Dec 2024 09:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733823026;
	bh=IFU3XDZtIzskMLZGdyYwcoQS3UX5FfBDq3U/xN0iRtw=;
	h=Subject:To:Cc:From:Date:From;
	b=brZgMaf3wAoMmOvTm8mebuF1BV97qXtgtjFBrm5ugcWhAxF2o0BBSRh8Mz/2Tm30y
	 ezHUSqTIAUMMRoI66XzCzHta6iJjmXh2Y652HTCdvKgcnrDHQhtILyiVY0El3o6xA8
	 BKIpPn703GZRCs4m9QqZlFzsygaro6/n+sovojAY=
Subject: FAILED: patch "[PATCH] drm/amd/display: Add option to retrieve detile buffer size" failed to apply to 6.6-stable tree
To: Sung.Lee@amd.com,alex.hung@amd.com,alexander.deucher@amd.com,aric.cyr@amd.com,daniel.wheeler@amd.com,mario.limonciello@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 10 Dec 2024 10:29:42 +0100
Message-ID: <2024121042-mortally-luckless-e866@gregkh>
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
git cherry-pick -x 6a7fd76b949efe40fb6d6677f480e624e0cb6e40
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024121042-mortally-luckless-e866@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6a7fd76b949efe40fb6d6677f480e624e0cb6e40 Mon Sep 17 00:00:00 2001
From: Sung Lee <Sung.Lee@amd.com>
Date: Thu, 14 Nov 2024 14:18:13 -0500
Subject: [PATCH] drm/amd/display: Add option to retrieve detile buffer size

[WHY]
For better power profiling knowing the detile
buffer size at a given point in time
would be useful.

[HOW]
Add interface to retrieve detile buffer from
dc state.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Signed-off-by: Sung Lee <Sung.Lee@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 1dd26d5df6b9..49fe7dcf9372 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -6109,3 +6109,21 @@ struct dc_power_profile dc_get_power_profile_for_dc_state(const struct dc_state
 		profile.power_level = dc->res_pool->funcs->get_power_profile(context);
 	return profile;
 }
+
+/*
+ **********************************************************************************
+ * dc_get_det_buffer_size_from_state() - extracts detile buffer size from dc state
+ *
+ * Called when DM wants to log detile buffer size from dc_state
+ *
+ **********************************************************************************
+ */
+unsigned int dc_get_det_buffer_size_from_state(const struct dc_state *context)
+{
+	struct dc *dc = context->clk_mgr->ctx->dc;
+
+	if (dc->res_pool->funcs->get_det_buffer_size)
+		return dc->res_pool->funcs->get_det_buffer_size(context);
+	else
+		return 0;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 104051935884..49a31598bb88 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -2550,6 +2550,8 @@ struct dc_power_profile {
 
 struct dc_power_profile dc_get_power_profile_for_dc_state(const struct dc_state *context);
 
+unsigned int dc_get_det_buffer_size_from_state(const struct dc_state *context);
+
 /* DSC Interfaces */
 #include "dc_dsc.h"
 
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index 8597e866bfe6..3061dca47dd2 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -219,6 +219,7 @@ struct resource_funcs {
 	 * Get indicator of power from a context that went through full validation
 	 */
 	int (*get_power_profile)(const struct dc_state *context);
+	unsigned int (*get_det_buffer_size)(const struct dc_state *context);
 };
 
 struct audio_support{
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
index c16cf1c8f7f9..54ec3d8e920c 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
@@ -1720,6 +1720,12 @@ int dcn31_populate_dml_pipes_from_context(
 	return pipe_cnt;
 }
 
+unsigned int dcn31_get_det_buffer_size(
+	const struct dc_state *context)
+{
+	return context->bw_ctx.dml.ip.det_buffer_size_kbytes;
+}
+
 void dcn31_calculate_wm_and_dlg(
 		struct dc *dc, struct dc_state *context,
 		display_e2e_pipe_params_st *pipes,
@@ -1842,6 +1848,7 @@ static struct resource_funcs dcn31_res_pool_funcs = {
 	.update_bw_bounding_box = dcn31_update_bw_bounding_box,
 	.patch_unknown_plane_state = dcn20_patch_unknown_plane_state,
 	.get_panel_config_defaults = dcn31_get_panel_config_defaults,
+	.get_det_buffer_size = dcn31_get_det_buffer_size,
 };
 
 static struct clock_source *dcn30_clock_source_create(
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.h b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.h
index 901436591ed4..551ad912f7be 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.h
@@ -63,6 +63,9 @@ struct resource_pool *dcn31_create_resource_pool(
 		const struct dc_init_data *init_data,
 		struct dc *dc);
 
+unsigned int dcn31_get_det_buffer_size(
+	const struct dc_state *context);
+
 /*temp: B0 specific before switch to dcn313 headers*/
 #ifndef regPHYPLLF_PIXCLK_RESYNC_CNTL
 #define regPHYPLLF_PIXCLK_RESYNC_CNTL 0x007e
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c
index c0f48c78e968..2794473f2aff 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c
@@ -1777,6 +1777,7 @@ static struct resource_funcs dcn314_res_pool_funcs = {
 	.patch_unknown_plane_state = dcn20_patch_unknown_plane_state,
 	.get_panel_config_defaults = dcn314_get_panel_config_defaults,
 	.get_preferred_eng_id_dpia = dcn314_get_preferred_eng_id_dpia,
+	.get_det_buffer_size = dcn31_get_det_buffer_size,
 };
 
 static struct clock_source *dcn30_clock_source_create(
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
index 6c3295259a81..4ee33eb3381d 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
@@ -1845,6 +1845,7 @@ static struct resource_funcs dcn315_res_pool_funcs = {
 	.patch_unknown_plane_state = dcn20_patch_unknown_plane_state,
 	.get_panel_config_defaults = dcn315_get_panel_config_defaults,
 	.get_power_profile = dcn315_get_power_profile,
+	.get_det_buffer_size = dcn31_get_det_buffer_size,
 };
 
 static bool dcn315_resource_construct(
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c
index 6edaaadcb173..79eddbafe3c2 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c
@@ -1719,6 +1719,7 @@ static struct resource_funcs dcn316_res_pool_funcs = {
 	.update_bw_bounding_box = dcn316_update_bw_bounding_box,
 	.patch_unknown_plane_state = dcn20_patch_unknown_plane_state,
 	.get_panel_config_defaults = dcn316_get_panel_config_defaults,
+	.get_det_buffer_size = dcn31_get_det_buffer_size,
 };
 
 static bool dcn316_resource_construct(
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
index 6cc2960b6104..09a5a9474903 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
@@ -1778,6 +1778,7 @@ static struct resource_funcs dcn35_res_pool_funcs = {
 	.patch_unknown_plane_state = dcn20_patch_unknown_plane_state,
 	.get_panel_config_defaults = dcn35_get_panel_config_defaults,
 	.get_preferred_eng_id_dpia = dcn35_get_preferred_eng_id_dpia,
+	.get_det_buffer_size = dcn31_get_det_buffer_size,
 };
 
 static bool dcn35_resource_construct(
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
index d87e2641cda1..fe382f9b6ff2 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
@@ -1757,6 +1757,7 @@ static struct resource_funcs dcn351_res_pool_funcs = {
 	.patch_unknown_plane_state = dcn20_patch_unknown_plane_state,
 	.get_panel_config_defaults = dcn35_get_panel_config_defaults,
 	.get_preferred_eng_id_dpia = dcn351_get_preferred_eng_id_dpia,
+	.get_det_buffer_size = dcn31_get_det_buffer_size,
 };
 
 static bool dcn351_resource_construct(


