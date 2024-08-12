Return-Path: <stable+bounces-66599-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4BFB94F04F
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 16:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70C631F214D7
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 14:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62DB1184536;
	Mon, 12 Aug 2024 14:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GHWUeZ0G"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24302184524
	for <stable@vger.kernel.org>; Mon, 12 Aug 2024 14:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723474109; cv=none; b=k7UbD+0NeFm5f3BSRcMQEfnHVljqmh8l8pfCtDEKw74z/c052oMAJe0oRC0u9RDlO1KBw1JGo21v3N2rh6WSz5bJeKmNVbc8tw151O584MQgt/Iopqgg/Yvu7GRetO/tWdZAFbkN6uKPWEnbjrzunpxlwmWRb4gZ8aEdfGDuox4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723474109; c=relaxed/simple;
	bh=QsSBmNFRe69RXDIOSzD1OAud8D0ybiup5GOLg+KzDG4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=oFnJBrmHNsEByXty3QB/ZYh943cIJrn/w/m9FqMax7dlBkZ+Q2+yzph9eaeI2cqCTIOSPRBQEBMnVAGGIAvlG5Y72hcJ2HAo4JJJ6TXhlGLrv9MZ9yYhEujN6nvbaHiz8NH4fdE007qRNKh6eVQvayKE2bvlueVf6JCWvtDBiXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GHWUeZ0G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F81EC4AF09;
	Mon, 12 Aug 2024 14:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723474109;
	bh=QsSBmNFRe69RXDIOSzD1OAud8D0ybiup5GOLg+KzDG4=;
	h=Subject:To:Cc:From:Date:From;
	b=GHWUeZ0Gg2Oma5T52lXHKieo3K6dvqjMXKms1BcgnK3ZYhHSyM5nwdw762vmyS9WT
	 CJABO4pMqbpunbmqpYoNI6LhpxRl6bnkr4QeFk2R4wGFcUaoP+U4L9Seuj5RagxBar
	 k458lijcHanin3AOAY00maqs2zng7Fy5tWWk8sfI=
Subject: FAILED: patch "[PATCH] drm/amd/display: Make DML2.1 P-State method force per stream" failed to apply to 6.1-stable tree
To: dillon.varone@amd.com,alex.hung@amd.com,alexander.deucher@amd.com,alvin.lee2@amd.com,daniel.wheeler@amd.com,mario.limonciello@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Aug 2024 16:47:55 +0200
Message-ID: <2024081255-simply-improve-7b84@gregkh>
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
git cherry-pick -x 020fccbe8fe7552e57804bba0c7578d227f561c2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081255-simply-improve-7b84@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

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
 


