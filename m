Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8CCA78A64E
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 09:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbjH1HMo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 03:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjH1HMj (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 03:12:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B8B49B
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 00:12:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1305663214
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 07:12:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23A15C433C7;
        Mon, 28 Aug 2023 07:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693206755;
        bh=kHm0jAfRnoBJpDud9QGVKB+1vcIs7XKAhvFiUCcfTbU=;
        h=Subject:To:Cc:From:Date:From;
        b=iBX99RxYFNMarSmdGLEt/cB0qnelkRoG7OP7Mo50BpIVoDCZT4G5umY7JgI8N5kP5
         2I94pTLnIU060ScVBGjSSGQ82sf/c1Tporyp9ovjXoqA3yUWwB9cL2200c60ZzjymI
         UeLRAsnrByQDFx6s9V0ChiVr490MWR1EsRi/ite4=
Subject: FAILED: patch "[PATCH] drm/amd/display: Revert vblank change that causes null" failed to apply to 6.1-stable tree
To:     daniel.miess@amd.com, alexander.deucher@amd.com,
        chiahsuan.chung@amd.com, daniel.wheeler@amd.com,
        nicholas.kazlauskas@amd.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Mon, 28 Aug 2023 09:12:24 +0200
Message-ID: <2023082824-june-curable-f704@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x c02b04633c4f4654331c53966cb937df1c73a9bb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023082824-june-curable-f704@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

c02b04633c4f ("drm/amd/display: Revert vblank change that causes null pointer crash")
1a4bcdbea431 ("drm/amd/display: Fix possible underflow for displays with large vblank")
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

From c02b04633c4f4654331c53966cb937df1c73a9bb Mon Sep 17 00:00:00 2001
From: Daniel Miess <daniel.miess@amd.com>
Date: Thu, 11 May 2023 09:12:09 -0400
Subject: [PATCH] drm/amd/display: Revert vblank change that causes null
 pointer crash

Revert commit 1a4bcdbea431 ("drm/amd/display: Fix possible underflow for displays with large vblank")
Because it cause some regression

Fixes: 1a4bcdbea431 ("drm/amd/display: Fix possible underflow for displays with large vblank")
Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Daniel Miess <daniel.miess@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
index 554152371eb5..1d00eb9e73c6 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
@@ -33,7 +33,7 @@
 #include "dml/display_mode_vba.h"
 
 struct _vcs_dpi_ip_params_st dcn3_14_ip = {
-	.VBlankNomDefaultUS = 800,
+	.VBlankNomDefaultUS = 668,
 	.gpuvm_enable = 1,
 	.gpuvm_max_page_table_levels = 1,
 	.hostvm_enable = 1,
@@ -286,7 +286,7 @@ int dcn314_populate_dml_pipes_from_context_fpu(struct dc *dc, struct dc_state *c
 	struct resource_context *res_ctx = &context->res_ctx;
 	struct pipe_ctx *pipe;
 	bool upscaled = false;
-	const unsigned int max_allowed_vblank_nom = 1023;
+	bool isFreesyncVideo = false;
 
 	dc_assert_fp_enabled();
 
@@ -300,11 +300,16 @@ int dcn314_populate_dml_pipes_from_context_fpu(struct dc *dc, struct dc_state *c
 		pipe = &res_ctx->pipe_ctx[i];
 		timing = &pipe->stream->timing;
 
-		pipes[pipe_cnt].pipe.dest.vtotal = pipe->stream->adjust.v_total_min;
-		pipes[pipe_cnt].pipe.dest.vblank_nom = timing->v_total - pipes[pipe_cnt].pipe.dest.vactive;
-		pipes[pipe_cnt].pipe.dest.vblank_nom = min(pipes[pipe_cnt].pipe.dest.vblank_nom, dcn3_14_ip.VBlankNomDefaultUS);
-		pipes[pipe_cnt].pipe.dest.vblank_nom = max(pipes[pipe_cnt].pipe.dest.vblank_nom, timing->v_sync_width);
-		pipes[pipe_cnt].pipe.dest.vblank_nom = min(pipes[pipe_cnt].pipe.dest.vblank_nom, max_allowed_vblank_nom);
+		isFreesyncVideo = pipe->stream->adjust.v_total_max == pipe->stream->adjust.v_total_min;
+		isFreesyncVideo = isFreesyncVideo && pipe->stream->adjust.v_total_min > timing->v_total;
+
+		if (!isFreesyncVideo) {
+			pipes[pipe_cnt].pipe.dest.vblank_nom =
+				dcn3_14_ip.VBlankNomDefaultUS / (timing->h_total / (timing->pix_clk_100hz / 10000.0));
+		} else {
+			pipes[pipe_cnt].pipe.dest.vtotal = pipe->stream->adjust.v_total_min;
+			pipes[pipe_cnt].pipe.dest.vblank_nom = timing->v_total - pipes[pipe_cnt].pipe.dest.vactive;
+		}
 
 		if (pipe->plane_state &&
 				(pipe->plane_state->src_rect.height < pipe->plane_state->dst_rect.height ||

