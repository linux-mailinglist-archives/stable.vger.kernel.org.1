Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29E6276ADF1
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbjHAJeq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbjHAJeX (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:34:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CDDF5258
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:32:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F08E4614B2
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:32:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F84CC433C7;
        Tue,  1 Aug 2023 09:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690882338;
        bh=shXgfbM8H6NuSZc1HISNrn4zgbDQ2Qpl/nmlbKhYE+0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=egSYv/+qqgtPoZDvenHZBb+EroMA5+gQ6CBGBr7igNTB3izlX7Cpu8Zh/R2BUex+v
         o/NkBeSHT5L6z1QW9kwEBnQ1nD9ww0TT+4HOOMcwiUaLgzSFdmKNN4h2EdfbteIeYw
         outzDewKkGQgFiTPqZl1onuBho6F5XAP6+NX+AY8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jun Lei <jun.lei@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Daniel Miess <daniel.miess@amd.com>,
        Daniel Wheeler <daniel.wheeler@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 069/228] drm/amd/display: Fix possible underflow for displays with large vblank
Date:   Tue,  1 Aug 2023 11:18:47 +0200
Message-ID: <20230801091925.319149599@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091922.799813980@linuxfoundation.org>
References: <20230801091922.799813980@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Daniel Miess <daniel.miess@amd.com>

[ Upstream commit 1a4bcdbea4319efeb26cc4b05be859a7867e02dc ]

[Why]
Underflow observed when using a display with a large vblank region
and low refresh rate

[How]
Simplify calculation of vblank_nom

Increase value for VBlankNomDefaultUS to 800us

Reviewed-by: Jun Lei <jun.lei@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Daniel Miess <daniel.miess@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Stable-dep-of: 2a9482e55968 ("drm/amd/display: Prevent vtotal from being set to 0")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../amd/display/dc/dml/dcn314/dcn314_fpu.c    | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
index 395eed9f6b1be..a2a32cb9d5710 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
@@ -32,7 +32,7 @@
 #include "dml/display_mode_vba.h"
 
 struct _vcs_dpi_ip_params_st dcn3_14_ip = {
-	.VBlankNomDefaultUS = 668,
+	.VBlankNomDefaultUS = 800,
 	.gpuvm_enable = 1,
 	.gpuvm_max_page_table_levels = 1,
 	.hostvm_enable = 1,
@@ -288,7 +288,7 @@ int dcn314_populate_dml_pipes_from_context_fpu(struct dc *dc, struct dc_state *c
 	struct resource_context *res_ctx = &context->res_ctx;
 	struct pipe_ctx *pipe;
 	bool upscaled = false;
-	bool isFreesyncVideo = false;
+	const unsigned int max_allowed_vblank_nom = 1023;
 
 	dc_assert_fp_enabled();
 
@@ -302,16 +302,11 @@ int dcn314_populate_dml_pipes_from_context_fpu(struct dc *dc, struct dc_state *c
 		pipe = &res_ctx->pipe_ctx[i];
 		timing = &pipe->stream->timing;
 
-		isFreesyncVideo = pipe->stream->adjust.v_total_max == pipe->stream->adjust.v_total_min;
-		isFreesyncVideo = isFreesyncVideo && pipe->stream->adjust.v_total_min > timing->v_total;
-
-		if (!isFreesyncVideo) {
-			pipes[pipe_cnt].pipe.dest.vblank_nom =
-				dcn3_14_ip.VBlankNomDefaultUS / (timing->h_total / (timing->pix_clk_100hz / 10000.0));
-		} else {
-			pipes[pipe_cnt].pipe.dest.vtotal = pipe->stream->adjust.v_total_min;
-			pipes[pipe_cnt].pipe.dest.vblank_nom = timing->v_total - pipes[pipe_cnt].pipe.dest.vactive;
-		}
+		pipes[pipe_cnt].pipe.dest.vtotal = pipe->stream->adjust.v_total_min;
+		pipes[pipe_cnt].pipe.dest.vblank_nom = timing->v_total - pipes[pipe_cnt].pipe.dest.vactive;
+		pipes[pipe_cnt].pipe.dest.vblank_nom = min(pipes[pipe_cnt].pipe.dest.vblank_nom, dcn3_14_ip.VBlankNomDefaultUS);
+		pipes[pipe_cnt].pipe.dest.vblank_nom = max(pipes[pipe_cnt].pipe.dest.vblank_nom, timing->v_sync_width);
+		pipes[pipe_cnt].pipe.dest.vblank_nom = min(pipes[pipe_cnt].pipe.dest.vblank_nom, max_allowed_vblank_nom);
 
 		if (pipe->plane_state &&
 				(pipe->plane_state->src_rect.height < pipe->plane_state->dst_rect.height ||
-- 
2.39.2



