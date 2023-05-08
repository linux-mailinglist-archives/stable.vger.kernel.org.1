Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6064A6FA3F7
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 11:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233558AbjEHJxk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 05:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233419AbjEHJxj (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 05:53:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED1FC24520
        for <stable@vger.kernel.org>; Mon,  8 May 2023 02:53:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 747456220B
        for <stable@vger.kernel.org>; Mon,  8 May 2023 09:53:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61F63C433D2;
        Mon,  8 May 2023 09:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683539616;
        bh=s+OHNWOwVkT+p2BPInHcHgJgMrJofYfYEvwPmc805eA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ihC2kLEdiVAWEakhVwp8e9yR3ueG6TdMwEyMxVWKw0qEo2AtNnrOdHjdRvKuU2a3z
         CRKXFs27qJ6STz/MfBhKlFjU1X6bAjenRvy9NwigtX48MI2Cehq0VNS2/Z6UEPNWsL
         5i/luYfT6Hnl8vxYc/Ogn4A85zF9IaP+z1xz7Gxo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
        Qingqing Zhuo <qingqing.zhuo@amd.com>,
        Nasir Osman <nasir.osman@amd.com>,
        Daniel Wheeler <daniel.wheeler@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 082/611] drm/amd/display: Remove stutter only configurations
Date:   Mon,  8 May 2023 11:38:44 +0200
Message-Id: <20230508094424.768134136@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Nasir Osman <nasir.osman@amd.com>

[ Upstream commit 71c4ca2d3b079d0ba4d9b3033641fea906cebfb6 ]

[why]
Newer ASICs such as DCN314 needs to allow for both self refresh and mem
clk switching rather than just self refresh only. Otherwise, we can see
some p-state hangs on ASICs that do support mem clk switching.

[how]
Added an allow_self_refresh_only flag for dcn30_internal_validate_bw
and created a validate_bw method for DCN314 with the allow_self_refresh_only
flag set to false (to support mem clk switching).

Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Nasir Osman <nasir.osman@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Stable-dep-of: 1e994cc0956b ("drm/amd/display: limit timing for single dimm memory")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../drm/amd/display/dc/dcn30/dcn30_resource.c | 16 +++---
 .../drm/amd/display/dc/dcn30/dcn30_resource.h |  3 +-
 .../drm/amd/display/dc/dcn31/dcn31_resource.c |  2 +-
 .../amd/display/dc/dcn314/dcn314_resource.c   | 57 ++++++++++++++++++-
 .../amd/display/dc/dcn314/dcn314_resource.h   |  4 ++
 .../drm/amd/display/dc/dml/dcn30/dcn30_fpu.c  |  2 +-
 6 files changed, 73 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
index 020f512e9690e..e958f838c8041 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
@@ -1641,7 +1641,8 @@ noinline bool dcn30_internal_validate_bw(
 		display_e2e_pipe_params_st *pipes,
 		int *pipe_cnt_out,
 		int *vlevel_out,
-		bool fast_validate)
+		bool fast_validate,
+		bool allow_self_refresh_only)
 {
 	bool out = false;
 	bool repopulate_pipes = false;
@@ -1668,7 +1669,7 @@ noinline bool dcn30_internal_validate_bw(
 
 	dml_log_pipe_params(&context->bw_ctx.dml, pipes, pipe_cnt);
 
-	if (!fast_validate) {
+	if (!fast_validate || !allow_self_refresh_only) {
 		/*
 		 * DML favors voltage over p-state, but we're more interested in
 		 * supporting p-state over voltage. We can't support p-state in
@@ -1681,11 +1682,12 @@ noinline bool dcn30_internal_validate_bw(
 		if (vlevel < context->bw_ctx.dml.soc.num_states)
 			vlevel = dcn20_validate_apply_pipe_split_flags(dc, context, vlevel, split, merge);
 	}
-	if (fast_validate || vlevel == context->bw_ctx.dml.soc.num_states ||
-			vba->DRAMClockChangeSupport[vlevel][vba->maxMpcComb] == dm_dram_clock_change_unsupported) {
+	if (allow_self_refresh_only &&
+	    (fast_validate || vlevel == context->bw_ctx.dml.soc.num_states ||
+			vba->DRAMClockChangeSupport[vlevel][vba->maxMpcComb] == dm_dram_clock_change_unsupported)) {
 		/*
-		 * If mode is unsupported or there's still no p-state support then
-		 * fall back to favoring voltage.
+		 * If mode is unsupported or there's still no p-state support
+		 * then fall back to favoring voltage.
 		 *
 		 * We don't actually support prefetch mode 2, so require that we
 		 * at least support prefetch mode 1.
@@ -2056,7 +2058,7 @@ bool dcn30_validate_bandwidth(struct dc *dc,
 	BW_VAL_TRACE_COUNT();
 
 	DC_FP_START();
-	out = dcn30_internal_validate_bw(dc, context, pipes, &pipe_cnt, &vlevel, fast_validate);
+	out = dcn30_internal_validate_bw(dc, context, pipes, &pipe_cnt, &vlevel, fast_validate, true);
 	DC_FP_END();
 
 	if (pipe_cnt == 0)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.h b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.h
index 7d063c7d6a4bf..8e6b8b7368fdb 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.h
@@ -64,7 +64,8 @@ bool dcn30_internal_validate_bw(
 		display_e2e_pipe_params_st *pipes,
 		int *pipe_cnt_out,
 		int *vlevel_out,
-		bool fast_validate);
+		bool fast_validate,
+		bool allow_self_refresh_only);
 void dcn30_calculate_wm_and_dlg(
 		struct dc *dc, struct dc_state *context,
 		display_e2e_pipe_params_st *pipes,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
index fddc21a5a04c4..d825f11b4feaa 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
@@ -1770,7 +1770,7 @@ bool dcn31_validate_bandwidth(struct dc *dc,
 	BW_VAL_TRACE_COUNT();
 
 	DC_FP_START();
-	out = dcn30_internal_validate_bw(dc, context, pipes, &pipe_cnt, &vlevel, fast_validate);
+	out = dcn30_internal_validate_bw(dc, context, pipes, &pipe_cnt, &vlevel, fast_validate, true);
 	DC_FP_END();
 
 	// Disable fast_validate to set min dcfclk in alculate_wm_and_dlg
diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
index 9918bccd6defb..2f9c6d64b98bc 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
@@ -1689,6 +1689,61 @@ static void dcn314_get_panel_config_defaults(struct dc_panel_config *panel_confi
 	*panel_config = panel_config_defaults;
 }
 
+bool dcn314_validate_bandwidth(struct dc *dc,
+		struct dc_state *context,
+		bool fast_validate)
+{
+	bool out = false;
+
+	BW_VAL_TRACE_SETUP();
+
+	int vlevel = 0;
+	int pipe_cnt = 0;
+	display_e2e_pipe_params_st *pipes = kzalloc(dc->res_pool->pipe_count * sizeof(display_e2e_pipe_params_st), GFP_KERNEL);
+	DC_LOGGER_INIT(dc->ctx->logger);
+
+	BW_VAL_TRACE_COUNT();
+
+	DC_FP_START();
+	// do not support self refresh only
+	out = dcn30_internal_validate_bw(dc, context, pipes, &pipe_cnt, &vlevel, fast_validate, false);
+	DC_FP_END();
+
+	// Disable fast_validate to set min dcfclk in calculate_wm_and_dlg
+	if (pipe_cnt == 0)
+		fast_validate = false;
+
+	if (!out)
+		goto validate_fail;
+
+	BW_VAL_TRACE_END_VOLTAGE_LEVEL();
+
+	if (fast_validate) {
+		BW_VAL_TRACE_SKIP(fast);
+		goto validate_out;
+	}
+
+	dc->res_pool->funcs->calculate_wm_and_dlg(dc, context, pipes, pipe_cnt, vlevel);
+
+	BW_VAL_TRACE_END_WATERMARKS();
+
+	goto validate_out;
+
+validate_fail:
+	DC_LOG_WARNING("Mode Validation Warning: %s failed validation.\n",
+		dml_get_status_message(context->bw_ctx.dml.vba.ValidationStatus[context->bw_ctx.dml.vba.soc.num_states]));
+
+	BW_VAL_TRACE_SKIP(fail);
+	out = false;
+
+validate_out:
+	kfree(pipes);
+
+	BW_VAL_TRACE_FINISH();
+
+	return out;
+}
+
 static struct resource_funcs dcn314_res_pool_funcs = {
 	.destroy = dcn314_destroy_resource_pool,
 	.link_enc_create = dcn31_link_encoder_create,
@@ -1696,7 +1751,7 @@ static struct resource_funcs dcn314_res_pool_funcs = {
 	.link_encs_assign = link_enc_cfg_link_encs_assign,
 	.link_enc_unassign = link_enc_cfg_link_enc_unassign,
 	.panel_cntl_create = dcn31_panel_cntl_create,
-	.validate_bandwidth = dcn31_validate_bandwidth,
+	.validate_bandwidth = dcn314_validate_bandwidth,
 	.calculate_wm_and_dlg = dcn31_calculate_wm_and_dlg,
 	.update_soc_for_wm_a = dcn31_update_soc_for_wm_a,
 	.populate_dml_pipes = dcn314_populate_dml_pipes_from_context,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.h b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.h
index 0dd3153aa5c17..49ffe71018dfb 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.h
@@ -39,6 +39,10 @@ struct dcn314_resource_pool {
 	struct resource_pool base;
 };
 
+bool dcn314_validate_bandwidth(struct dc *dc,
+		struct dc_state *context,
+		bool fast_validate);
+
 struct resource_pool *dcn314_create_resource_pool(
 		const struct dc_init_data *init_data,
 		struct dc *dc);
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
index e1e92daba6686..990dbd736e2ce 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
@@ -636,7 +636,7 @@ int dcn30_find_dummy_latency_index_for_fw_based_mclk_switch(struct dc *dc,
 	while (dummy_latency_index < max_latency_table_entries) {
 		context->bw_ctx.dml.soc.dram_clock_change_latency_us =
 				dc->clk_mgr->bw_params->dummy_pstate_table[dummy_latency_index].dummy_pstate_latency_us;
-		dcn30_internal_validate_bw(dc, context, pipes, &pipe_cnt, &vlevel, false);
+		dcn30_internal_validate_bw(dc, context, pipes, &pipe_cnt, &vlevel, false, true);
 
 		if (context->bw_ctx.dml.soc.allow_dram_self_refresh_or_dram_clock_change_in_vblank ==
 			dm_allow_self_refresh_and_mclk_switch)
-- 
2.39.2



