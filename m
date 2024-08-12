Return-Path: <stable+bounces-66601-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F6594F051
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 16:49:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DDAA282A8F
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 14:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B241862BD;
	Mon, 12 Aug 2024 14:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NlrgIKeK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A70518132A
	for <stable@vger.kernel.org>; Mon, 12 Aug 2024 14:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723474115; cv=none; b=b8VfLYD0RrWJvnCl6QT70xDpvB//g485WU8vwwOOn1vvrP7jbOHNw8XPaTRtdwaY6Mq1BOZHrlXvoeDOUIOlsOR+ah0C8eYv/W9EnCBwIM7j09nVVLrXbyrDlzD69t3tMoomDQ2KgK7iZo3M7QC0w2B+L7dKq1QaDNFHDkPtoD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723474115; c=relaxed/simple;
	bh=vPTnH8LPqVnFz/Ao2AQNJOsslsIc7/tF7XLzfYXWA1g=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=hoE5RnxV2f/+rMWNOGYKeHNVgXTes/vPPl30GCsVwo+jswnrt2SUzqbBxkL7HywpFfG/KftZQwlgKRzJROYVdZzjESNPzOpgyqxmJngmJpzdJvVVfNt/o2Zc8g50/0FEHLVJuL2M5BwtwTEwQt/TjUUHM3a3IaJND1+8Ynu87+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NlrgIKeK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0832FC32782;
	Mon, 12 Aug 2024 14:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723474115;
	bh=vPTnH8LPqVnFz/Ao2AQNJOsslsIc7/tF7XLzfYXWA1g=;
	h=Subject:To:Cc:From:Date:From;
	b=NlrgIKeKHe/P9fIsaJcZn5B1sbNiByWqoHLYm+jyA0G0juGaz+QkxnhyUZd9y00ke
	 XsVpLLOMvFpFjfDX1+NFpfS5XugDd4yUBI6G/mvuxixM9wmEMN3+UNPYcSCy/KoG5T
	 dk4h3WHi5qUZxGLxXDCPkhkYlETc8zgFQgGBC3nM=
Subject: FAILED: patch "[PATCH] drm/amd/display: Make DML2.1 P-State method force per stream" failed to apply to 5.15-stable tree
To: dillon.varone@amd.com,alex.hung@amd.com,alexander.deucher@amd.com,alvin.lee2@amd.com,daniel.wheeler@amd.com,mario.limonciello@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Aug 2024 16:47:56 +0200
Message-ID: <2024081256-plop-deferral-3841@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 020fccbe8fe7552e57804bba0c7578d227f561c2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081256-plop-deferral-3841@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

020fccbe8fe7 ("drm/amd/display: Make DML2.1 P-State method force per stream")
00c391102abc ("drm/amd/display: Add misc DC changes for DCN401")
da87132f641e ("drm/amd/display: Add some DCN401 reg name to macro definitions")
70839da63605 ("drm/amd/display: Add new DCN401 sources")
ef319dff5475 ("drm/amd/display: add support for chroma offset")
a41aa6a7d0a6 ("drm/amd/display: Add comments to improve the code readability")
5324e2b205a2 ("drm/amd/display: Add driver support for future FAMS versions")
f3736c0d979a ("drm/amd/display: Add code comments clock and encode code")
8b2cb32cf0c6 ("drm/amd/display: FEC overhead should be checked once for mst slot nums")
4df96ba66760 ("drm/amd/display: Add timing pixel encoding for mst mode validation")
2dbe9c2b2685 ("drm/amd/display: add DCN 351 version for microcode load")
1c5c36530a57 ("drm/amd/display: Set DCN351 BB and IP the same as DCN35")
5034b935f62a ("drm/amd/display: Modify DHCUB waterwark structures and functions")
9d43241953f7 ("drm/amd/display: Refactor DML2 interfaces")
8cffa89bd5e2 ("drm/amd/display: Expand DML2 callbacks")
2d5bb791e24f ("drm/amd/display: Implement update_planes_and_stream_v3 sequence")
88867807564e ("drm/amd/display: Refactor DPP into a component directory")
eed4edda910f ("drm/amd/display: Support long vblank feature")
caef6c453cf2 ("drm/amd/display: Add DML2 folder to include path")
2d7f3d1a5866 ("drm/amd/display: Implement wait_for_odm_update_pending_complete")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 020fccbe8fe7552e57804bba0c7578d227f561c2 Mon Sep 17 00:00:00 2001
From: Dillon Varone <dillon.varone@amd.com>
Date: Thu, 13 Jun 2024 12:08:16 -0400
Subject: [PATCH] drm/amd/display: Make DML2.1 P-State method force per stream

[WHY & HOW]
Currently the force only works for a single display, make it so it can
be forced per stream.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Dillon Varone <dillon.varone@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index d0d1af451b64..e0334b573f2d 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1038,7 +1038,7 @@ struct dc_debug_options {
 	bool force_chroma_subsampling_1tap;
 	bool disable_422_left_edge_pixel;
 	bool dml21_force_pstate_method;
-	uint32_t dml21_force_pstate_method_value;
+	uint32_t dml21_force_pstate_method_values[MAX_PIPES];
 	uint32_t dml21_disable_pstate_method_mask;
 	union dmub_fams2_global_feature_config fams2_config;
 	bool enable_legacy_clock_update;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
index d5ead0205053..06387b8b0aee 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
@@ -1000,7 +1000,7 @@ bool dml21_map_dc_state_into_dml_display_cfg(const struct dc *in_dc, struct dc_s
 				/* apply forced pstate policy */
 				if (dml_ctx->config.pmo.force_pstate_method_enable) {
 					dml_dispcfg->plane_descriptors[disp_cfg_plane_location].overrides.uclk_pstate_change_strategy =
-							dml21_force_pstate_method_to_uclk_state_change_strategy(dml_ctx->config.pmo.force_pstate_method_value);
+							dml21_force_pstate_method_to_uclk_state_change_strategy(dml_ctx->config.pmo.force_pstate_method_values[stream_index]);
 				}
 			}
 		}
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c
index 9c28304568d2..c310354cd5fc 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c
@@ -47,7 +47,8 @@ static void dml21_apply_debug_options(const struct dc *in_dc, struct dml2_contex
 	/* UCLK P-State options */
 	if (in_dc->debug.dml21_force_pstate_method) {
 		dml_ctx->config.pmo.force_pstate_method_enable = true;
-		dml_ctx->config.pmo.force_pstate_method_value = in_dc->debug.dml21_force_pstate_method_value;
+		for (int i = 0; i < MAX_PIPES; i++)
+			dml_ctx->config.pmo.force_pstate_method_values[i] = in_dc->debug.dml21_force_pstate_method_values[i];
 	} else {
 		dml_ctx->config.pmo.force_pstate_method_enable = false;
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h
index 79bf2d757804..1e891a3297c2 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h
@@ -230,7 +230,7 @@ struct dml2_configuration_options {
 	struct socbb_ip_params_external *external_socbb_ip_params;
 	struct {
 		bool force_pstate_method_enable;
-		enum dml2_force_pstate_methods force_pstate_method_value;
+		enum dml2_force_pstate_methods force_pstate_method_values[MAX_PIPES];
 	} pmo;
 	bool map_dc_pipes_with_callbacks;
 


