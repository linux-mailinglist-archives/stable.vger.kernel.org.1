Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 352F0783235
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 22:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbjHUUCJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 16:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjHUUCI (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 16:02:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA5E312C
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 13:02:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F55F647C7
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 20:02:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46745C433C8;
        Mon, 21 Aug 2023 20:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692648124;
        bh=JMLoq4aLoGXDgpOCCg5x5qe/UkAXo8/Wq5NDWNHFfA8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UL5Y39VKU7T2TWlBBDdzmqCxMCbjzh92QJG5xB4LZ1l87QXkJmqbVo/qngTzaeRNy
         EAROf1Y2TuuFfiyAsmG7nRrsFCbc/wZ31N2uTvYG5OtvdBRgkX//mEhwG8cl3mjCGn
         oTWa5ZUr0rUuOgxsfN5+OgSkqvQX7Q4JdzEzqx1U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jun Lei <jun.lei@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Daniel Miess <daniel.miess@amd.com>,
        Daniel Wheeler <daniel.wheeler@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 034/234] drm/amd/display: Remove v_startup workaround for dcn3+
Date:   Mon, 21 Aug 2023 21:39:57 +0200
Message-ID: <20230821194130.243855217@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821194128.754601642@linuxfoundation.org>
References: <20230821194128.754601642@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Daniel Miess <daniel.miess@amd.com>

[ Upstream commit 3a31e8b89b7240d9a17ace8a1ed050bdcb560f9e ]

[Why]
Calls to dcn20_adjust_freesync_v_startup are no longer
needed as of dcn3+ and can cause underflow in some cases

[How]
Move calls to dcn20_adjust_freesync_v_startup up into
validate_bandwidth for dcn2.x

Reviewed-by: Jun Lei <jun.lei@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Daniel Miess <daniel.miess@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../drm/amd/display/dc/dml/dcn20/dcn20_fpu.c  | 24 +++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
index 7661f8946aa31..9ec767ebf5d16 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
@@ -1097,10 +1097,6 @@ void dcn20_calculate_dlg_params(struct dc *dc,
 		context->res_ctx.pipe_ctx[i].plane_res.bw.dppclk_khz =
 						pipes[pipe_idx].clks_cfg.dppclk_mhz * 1000;
 		context->res_ctx.pipe_ctx[i].pipe_dlg_param = pipes[pipe_idx].pipe.dest;
-		if (context->res_ctx.pipe_ctx[i].stream->adaptive_sync_infopacket.valid)
-			dcn20_adjust_freesync_v_startup(
-				&context->res_ctx.pipe_ctx[i].stream->timing,
-				&context->res_ctx.pipe_ctx[i].pipe_dlg_param.vstartup_start);
 
 		pipe_idx++;
 	}
@@ -1914,6 +1910,7 @@ static bool dcn20_validate_bandwidth_internal(struct dc *dc, struct dc_state *co
 	int vlevel = 0;
 	int pipe_split_from[MAX_PIPES];
 	int pipe_cnt = 0;
+	int i = 0;
 	display_e2e_pipe_params_st *pipes = kzalloc(dc->res_pool->pipe_count * sizeof(display_e2e_pipe_params_st), GFP_ATOMIC);
 	DC_LOGGER_INIT(dc->ctx->logger);
 
@@ -1937,6 +1934,15 @@ static bool dcn20_validate_bandwidth_internal(struct dc *dc, struct dc_state *co
 	dcn20_calculate_wm(dc, context, pipes, &pipe_cnt, pipe_split_from, vlevel, fast_validate);
 	dcn20_calculate_dlg_params(dc, context, pipes, pipe_cnt, vlevel);
 
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		if (!context->res_ctx.pipe_ctx[i].stream)
+			continue;
+		if (context->res_ctx.pipe_ctx[i].stream->adaptive_sync_infopacket.valid)
+			dcn20_adjust_freesync_v_startup(
+				&context->res_ctx.pipe_ctx[i].stream->timing,
+				&context->res_ctx.pipe_ctx[i].pipe_dlg_param.vstartup_start);
+	}
+
 	BW_VAL_TRACE_END_WATERMARKS();
 
 	goto validate_out;
@@ -2209,6 +2215,7 @@ bool dcn21_validate_bandwidth_fp(struct dc *dc,
 	int vlevel = 0;
 	int pipe_split_from[MAX_PIPES];
 	int pipe_cnt = 0;
+	int i = 0;
 	display_e2e_pipe_params_st *pipes = kzalloc(dc->res_pool->pipe_count * sizeof(display_e2e_pipe_params_st), GFP_ATOMIC);
 	DC_LOGGER_INIT(dc->ctx->logger);
 
@@ -2237,6 +2244,15 @@ bool dcn21_validate_bandwidth_fp(struct dc *dc,
 	dcn21_calculate_wm(dc, context, pipes, &pipe_cnt, pipe_split_from, vlevel, fast_validate);
 	dcn20_calculate_dlg_params(dc, context, pipes, pipe_cnt, vlevel);
 
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		if (!context->res_ctx.pipe_ctx[i].stream)
+			continue;
+		if (context->res_ctx.pipe_ctx[i].stream->adaptive_sync_infopacket.valid)
+			dcn20_adjust_freesync_v_startup(
+				&context->res_ctx.pipe_ctx[i].stream->timing,
+				&context->res_ctx.pipe_ctx[i].pipe_dlg_param.vstartup_start);
+	}
+
 	BW_VAL_TRACE_END_WATERMARKS();
 
 	goto validate_out;
-- 
2.40.1



