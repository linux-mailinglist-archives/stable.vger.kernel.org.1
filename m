Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2E676ADC9
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232265AbjHAJdo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233092AbjHAJdB (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:33:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F531BF9
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:30:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A26B561515
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:30:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B32E5C433C8;
        Tue,  1 Aug 2023 09:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690882259;
        bh=KIpLyrl4ZFhrzX6oWGp8tSYN9SyYTsfjVX4nRfjiO4M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bH/flocc3oWl4nZxNIzAobiY4NmMDwsGhUTotIGAMTORqDSqoqNCM9QLIZNVrVeJM
         SBdaUcXxPfvPAHHnvC2/56V5Y1if3Yyfg5GVboW7jRiUdN+lFdtf/9k3RcNRgDmUoL
         OKwKuRpa59IkYuZg6Z/Mp2+3n/2SccUEbFr2KS1g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Charlene Liu <Charlene.Liu@amd.com>,
        Tom Chung <chiahsuan.chung@amd.com>,
        Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
        Daniel Wheeler <daniel.wheeler@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 041/228] drm/amd/display: use low clocks for no plane configs
Date:   Tue,  1 Aug 2023 11:18:19 +0200
Message-ID: <20230801091924.362986956@linuxfoundation.org>
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

From: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>

[ Upstream commit 2641c7b7808191cba25ba28b82bb73ca294924cc ]

Stream only configurations do not require DCFCLK, SOCCLK, DPPCLK
or FCLK. They also always allow pstate change.

Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Stable-dep-of: 49f26218c344 ("drm/amd/display: fix dcn315 single stream crb allocation")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../drm/amd/display/dc/dml/dcn31/dcn31_fpu.c   | 18 ++++++++++++++----
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c   | 14 +++++++++++++-
 2 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
index 8e416433184cf..aa1c2917a4a1d 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
@@ -483,7 +483,7 @@ void dcn31_calculate_wm_and_dlg_fp(
 		int pipe_cnt,
 		int vlevel)
 {
-	int i, pipe_idx, active_dpp_count = 0;
+	int i, pipe_idx, active_hubp_count = 0;
 	double dcfclk = context->bw_ctx.dml.vba.DCFCLKState[vlevel][context->bw_ctx.dml.vba.maxMpcComb];
 
 	dc_assert_fp_enabled();
@@ -529,7 +529,7 @@ void dcn31_calculate_wm_and_dlg_fp(
 			continue;
 
 		if (context->res_ctx.pipe_ctx[i].plane_state)
-			active_dpp_count++;
+			active_hubp_count++;
 
 		pipes[pipe_idx].clks_cfg.dispclk_mhz = get_dispclk_calculated(&context->bw_ctx.dml, pipes, pipe_cnt);
 		pipes[pipe_idx].clks_cfg.dppclk_mhz = get_dppclk_calculated(&context->bw_ctx.dml, pipes, pipe_cnt, pipe_idx);
@@ -547,9 +547,19 @@ void dcn31_calculate_wm_and_dlg_fp(
 	}
 
 	dcn20_calculate_dlg_params(dc, context, pipes, pipe_cnt, vlevel);
-	/* For 31x apu pstate change is only supported if possible in vactive or if there are no active dpps */
+	/* For 31x apu pstate change is only supported if possible in vactive*/
 	context->bw_ctx.bw.dcn.clk.p_state_change_support =
-			context->bw_ctx.dml.vba.DRAMClockChangeSupport[vlevel][context->bw_ctx.dml.vba.maxMpcComb] == dm_dram_clock_change_vactive || !active_dpp_count;
+			context->bw_ctx.dml.vba.DRAMClockChangeSupport[vlevel][context->bw_ctx.dml.vba.maxMpcComb] == dm_dram_clock_change_vactive;
+	/* If DCN isn't making memory requests we can allow pstate change and lower clocks */
+	if (!active_hubp_count) {
+		context->bw_ctx.bw.dcn.clk.socclk_khz = 0;
+		context->bw_ctx.bw.dcn.clk.dppclk_khz = 0;
+		context->bw_ctx.bw.dcn.clk.dcfclk_khz = 0;
+		context->bw_ctx.bw.dcn.clk.dcfclk_deep_sleep_khz = 0;
+		context->bw_ctx.bw.dcn.clk.dramclk_khz = 0;
+		context->bw_ctx.bw.dcn.clk.fclk_khz = 0;
+		context->bw_ctx.bw.dcn.clk.p_state_change_support = true;
+	}
 }
 
 void dcn31_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params)
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index f28caece5f901..f88c80594bd7e 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -1237,7 +1237,7 @@ static void dcn32_calculate_dlg_params(struct dc *dc, struct dc_state *context,
 				       display_e2e_pipe_params_st *pipes,
 				       int pipe_cnt, int vlevel)
 {
-	int i, pipe_idx;
+	int i, pipe_idx, active_hubp_count = 0;
 	bool usr_retraining_support = false;
 	bool unbounded_req_enabled = false;
 
@@ -1282,6 +1282,8 @@ static void dcn32_calculate_dlg_params(struct dc *dc, struct dc_state *context,
 	for (i = 0, pipe_idx = 0; i < dc->res_pool->pipe_count; i++) {
 		if (!context->res_ctx.pipe_ctx[i].stream)
 			continue;
+		if (context->res_ctx.pipe_ctx[i].plane_state)
+			active_hubp_count++;
 		pipes[pipe_idx].pipe.dest.vstartup_start = get_vstartup(&context->bw_ctx.dml, pipes, pipe_cnt,
 				pipe_idx);
 		pipes[pipe_idx].pipe.dest.vupdate_offset = get_vupdate_offset(&context->bw_ctx.dml, pipes, pipe_cnt,
@@ -1307,6 +1309,16 @@ static void dcn32_calculate_dlg_params(struct dc *dc, struct dc_state *context,
 		context->res_ctx.pipe_ctx[i].pipe_dlg_param = pipes[pipe_idx].pipe.dest;
 		pipe_idx++;
 	}
+	/* If DCN isn't making memory requests we can allow pstate change and lower clocks */
+	if (!active_hubp_count) {
+		context->bw_ctx.bw.dcn.clk.socclk_khz = 0;
+		context->bw_ctx.bw.dcn.clk.dppclk_khz = 0;
+		context->bw_ctx.bw.dcn.clk.dcfclk_khz = 0;
+		context->bw_ctx.bw.dcn.clk.dcfclk_deep_sleep_khz = 0;
+		context->bw_ctx.bw.dcn.clk.dramclk_khz = 0;
+		context->bw_ctx.bw.dcn.clk.fclk_khz = 0;
+		context->bw_ctx.bw.dcn.clk.p_state_change_support = true;
+	}
 	/*save a original dppclock copy*/
 	context->bw_ctx.bw.dcn.clk.bw_dppclk_khz = context->bw_ctx.bw.dcn.clk.dppclk_khz;
 	context->bw_ctx.bw.dcn.clk.bw_dispclk_khz = context->bw_ctx.bw.dcn.clk.dispclk_khz;
-- 
2.39.2



