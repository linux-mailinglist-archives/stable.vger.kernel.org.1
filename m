Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2923875CF13
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 18:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232912AbjGUQ1P (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 12:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232923AbjGUQ0x (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 12:26:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 957914C17
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 09:23:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A963161D64
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 16:22:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9312C433BD;
        Fri, 21 Jul 2023 16:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689956544;
        bh=ISuzQutGYB3sJG8Lr2mgwtPyX6hrCQyeX8J1UfJWu20=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=isaCMT7hj9MZawgiqC4kfkee0lpAQ3qAUoXU3eD44Eeo7uy6IJFnk0I8wrbaQ/JSz
         xWIexE6+kS1p7i6xlGiZxs2nNJ9a1sN5fzq1sUf/ig2hoKI3QOQ4517Pf7vV97pDG9
         7eyHyMYEMdbHnGyDMlR3k4ND33JCi5xAf9ar1NSg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Daniel Wheeler <daniel.wheeler@amd.com>,
        Saaem Rizvi <SyedSaaem.Rizvi@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alvin Lee <Alvin.Lee2@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.4 197/292] drm/amd/display: Limit DCN32 8 channel or less parts to DPM1 for FPO
Date:   Fri, 21 Jul 2023 18:05:06 +0200
Message-ID: <20230721160537.350546440@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160528.800311148@linuxfoundation.org>
References: <20230721160528.800311148@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Alvin Lee <Alvin.Lee2@amd.com>

commit ee7be8f3de1ccc9665281fe996f9b6d45191ec1a upstream.

- Due to hardware related QoS issues, we need to limit certain
  SKUs with less memory channels to DPM1 and above.
- At DPM0 + workload running, the urgent return latency can
  exceed 15us (the expected maximum is 4us) which results in underflow

Cc: stable@vger.kernel.org
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Reviewed-by: Saaem Rizvi <SyedSaaem.Rizvi@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c |    2 ++
 drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |   15 +++++++++++++++
 drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.h  |    2 ++
 3 files changed, 19 insertions(+)

--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -1888,6 +1888,8 @@ bool dcn32_validate_bandwidth(struct dc
 
 	dc->res_pool->funcs->calculate_wm_and_dlg(dc, context, pipes, pipe_cnt, vlevel);
 
+	dcn32_override_min_req_memclk(dc, context);
+
 	BW_VAL_TRACE_END_WATERMARKS();
 
 	goto validate_out;
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -2882,3 +2882,18 @@ void dcn32_set_clock_limits(const struct
 	dc_assert_fp_enabled();
 	dcn3_2_soc.clock_limits[0].dcfclk_mhz = 1200.0;
 }
+
+void dcn32_override_min_req_memclk(struct dc *dc, struct dc_state *context)
+{
+	// WA: restrict FPO and SubVP to use first non-strobe mode (DCN32 BW issue)
+	if ((context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching || dcn32_subvp_in_use(dc, context)) &&
+			dc->dml.soc.num_chans <= 8) {
+		int num_mclk_levels = dc->clk_mgr->bw_params->clk_table.num_entries_per_clk.num_memclk_levels;
+
+		if (context->bw_ctx.dml.vba.DRAMSpeed <= dc->clk_mgr->bw_params->clk_table.entries[0].memclk_mhz * 16 &&
+				num_mclk_levels > 1) {
+			context->bw_ctx.dml.vba.DRAMSpeed = dc->clk_mgr->bw_params->clk_table.entries[1].memclk_mhz * 16;
+			context->bw_ctx.bw.dcn.clk.dramclk_khz = context->bw_ctx.dml.vba.DRAMSpeed * 1000 / 16;
+		}
+	}
+}
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.h
@@ -80,6 +80,8 @@ void dcn32_assign_fpo_vactive_candidate(
 
 bool dcn32_find_vactive_pipe(struct dc *dc, const struct dc_state *context, uint32_t vactive_margin_req);
 
+void dcn32_override_min_req_memclk(struct dc *dc, struct dc_state *context);
+
 void dcn32_set_clock_limits(const struct _vcs_dpi_soc_bounding_box_st *soc_bb);
 
 #endif


