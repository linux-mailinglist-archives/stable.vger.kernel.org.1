Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2F7F703604
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243598AbjEORFY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243708AbjEORFH (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:05:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 437A083D0
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:03:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D35A662A73
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:03:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8FF2C4339B;
        Mon, 15 May 2023 17:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684170202;
        bh=2fp/UPmWW0ZC9AiW4RG3KHrzk5lQbW1N3cKMC8M7ZS0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=etrStu1xM1yYwgSCilE35KU+gRhkN6qJVlKJhmDPioMcmUpgIKKFYhprrwHtSrnrE
         0fpjaqMYsDY8MsNBbZHphKo1JBs2P6mW5bWG+9j/BmJ61zjMSrWDsF/a7YfQMkkD0N
         8X1JcoX4y6RahRy4xKyk5SewlORWve/fHijihAGs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Daniel Wheeler <daniel.wheeler@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 028/239] drm/amd/display: Add missing WA and MCLK validation
Date:   Mon, 15 May 2023 18:24:51 +0200
Message-Id: <20230515161722.545273895@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161721.545370111@linuxfoundation.org>
References: <20230515161721.545370111@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

[ Upstream commit 822b84ecfc646da0f87fd947fa00dc3be5e45ecc ]

When the commit fff7eb56b376 ("drm/amd/display: Don't set dram clock
change requirement for SubVP") was merged, we missed some parts
associated with the MCLK switch. This commit adds all the missing parts.

Fixes: fff7eb56b376 ("drm/amd/display: Don't set dram clock change requirement for SubVP")
Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c |  1 +
 .../drm/amd/display/dc/dcn32/dcn32_resource.c  |  2 +-
 .../drm/amd/display/dc/dml/dcn30/dcn30_fpu.c   | 18 +++++++++++++++++-
 3 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
index 1a85509c12f23..e9188bce62e0b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
@@ -984,6 +984,7 @@ void dcn32_init_hw(struct dc *dc)
 	if (dc->ctx->dmub_srv) {
 		dc_dmub_srv_query_caps_cmd(dc->ctx->dmub_srv->dmub);
 		dc->caps.dmub_caps.psr = dc->ctx->dmub_srv->dmub->feature_caps.psr;
+		dc->caps.dmub_caps.mclk_sw = dc->ctx->dmub_srv->dmub->feature_caps.fw_assisted_mclk_switch;
 	}
 
 	/* Enable support for ODM and windowed MPO if policy flag is set */
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index a942e2812183a..903f80a8c200c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -1984,7 +1984,7 @@ int dcn32_populate_dml_pipes_from_context(
 	// In general cases we want to keep the dram clock change requirement
 	// (prefer configs that support MCLK switch). Only override to false
 	// for SubVP
-	if (subvp_in_use)
+	if (context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching || subvp_in_use)
 		context->bw_ctx.dml.soc.dram_clock_change_requirement_final = false;
 	else
 		context->bw_ctx.dml.soc.dram_clock_change_requirement_final = true;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
index 4fa6363647937..fdfb19337ea6e 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
@@ -368,7 +368,9 @@ void dcn30_fpu_update_soc_for_wm_a(struct dc *dc, struct dc_state *context)
 	dc_assert_fp_enabled();
 
 	if (dc->clk_mgr->bw_params->wm_table.nv_entries[WM_A].valid) {
-		context->bw_ctx.dml.soc.dram_clock_change_latency_us = dc->clk_mgr->bw_params->wm_table.nv_entries[WM_A].dml_input.pstate_latency_us;
+		if (!context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching ||
+				context->bw_ctx.dml.soc.dram_clock_change_latency_us == 0)
+			context->bw_ctx.dml.soc.dram_clock_change_latency_us = dc->clk_mgr->bw_params->wm_table.nv_entries[WM_A].dml_input.pstate_latency_us;
 		context->bw_ctx.dml.soc.sr_enter_plus_exit_time_us = dc->clk_mgr->bw_params->wm_table.nv_entries[WM_A].dml_input.sr_enter_plus_exit_time_us;
 		context->bw_ctx.dml.soc.sr_exit_time_us = dc->clk_mgr->bw_params->wm_table.nv_entries[WM_A].dml_input.sr_exit_time_us;
 	}
@@ -520,6 +522,20 @@ void dcn30_fpu_calculate_wm_and_dlg(
 		pipe_idx++;
 	}
 
+	// WA: restrict FPO to use first non-strobe mode (NV24 BW issue)
+	if (context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching &&
+			dc->dml.soc.num_chans <= 4 &&
+			context->bw_ctx.dml.vba.DRAMSpeed <= 1700 &&
+			context->bw_ctx.dml.vba.DRAMSpeed >= 1500) {
+
+		for (i = 0; i < dc->dml.soc.num_states; i++) {
+			if (dc->dml.soc.clock_limits[i].dram_speed_mts > 1700) {
+				context->bw_ctx.dml.vba.DRAMSpeed = dc->dml.soc.clock_limits[i].dram_speed_mts;
+				break;
+			}
+		}
+	}
+
 	dcn20_calculate_dlg_params(dc, context, pipes, pipe_cnt, vlevel);
 
 	if (!pstate_en)
-- 
2.39.2



