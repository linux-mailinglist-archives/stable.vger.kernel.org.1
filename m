Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38425703476
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 18:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243033AbjEOQtF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 12:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243039AbjEOQsb (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 12:48:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD1AE40C5
        for <stable@vger.kernel.org>; Mon, 15 May 2023 09:48:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE08062925
        for <stable@vger.kernel.org>; Mon, 15 May 2023 16:48:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5675C433D2;
        Mon, 15 May 2023 16:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684169309;
        bh=7wfe8MJ732zoSb3PdLj2xb6XHuuTP6qtzA4NYhHfhAM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=itul9UdN8gtwnAB/gUzzoI0FvrV9aGoNmizOPLVI4uT+XkuQEpmZlKSmn7gC1rtjD
         LHIfrxg06wCIHWWqnzw26dV2HNfazpawLQhNbXPYyar2Oefs2yq1+yTBLobweBxl9m
         ZkuKvFRiMqmBH+EgjnWAPR+tqzJvte9A4ftDuikc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Leo Li <sunpeng.li@amd.com>,
        Qingqing Zhuo <qingqing.zhuo@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Daniel Wheeler <daniel.wheeler@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 018/246] drm/amd/display: Fixes for dcn32_clk_mgr implementation
Date:   Mon, 15 May 2023 18:23:50 +0200
Message-Id: <20230515161723.157422741@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161722.610123835@linuxfoundation.org>
References: <20230515161722.610123835@linuxfoundation.org>
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

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

[ Upstream commit d1c5c3e252b8a911a524e6ee33b82aca81397745 ]

[Why&How]
Fix CLK MGR early initialization and add logging.

Fixes: 265280b99822 ("drm/amd/display: add CLKMGR changes for DCN32/321")
Reviewed-by: Leo Li <sunpeng.li@amd.com>
Reviewed-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
index 61768bf726f8c..31ee81ebb4ea2 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
@@ -805,6 +805,8 @@ void dcn32_clk_mgr_construct(
 		struct pp_smu_funcs *pp_smu,
 		struct dccg *dccg)
 {
+	struct clk_log_info log_info = {0};
+
 	clk_mgr->base.ctx = ctx;
 	clk_mgr->base.funcs = &dcn32_funcs;
 	if (ASICREV_IS_GC_11_0_2(clk_mgr->base.ctx->asic_id.hw_internal_rev)) {
@@ -838,6 +840,7 @@ void dcn32_clk_mgr_construct(
 			clk_mgr->base.clks.ref_dtbclk_khz = 268750;
 	}
 
+
 	/* integer part is now VCO frequency in kHz */
 	clk_mgr->base.dentist_vco_freq_khz = dcn32_get_vco_frequency_from_reg(clk_mgr);
 
@@ -845,6 +848,8 @@ void dcn32_clk_mgr_construct(
 	if (clk_mgr->base.dentist_vco_freq_khz == 0)
 		clk_mgr->base.dentist_vco_freq_khz = 4300000; /* Updated as per HW docs */
 
+	dcn32_dump_clk_registers(&clk_mgr->base.boot_snapshot, &clk_mgr->base, &log_info);
+
 	if (ctx->dc->debug.disable_dtb_ref_clk_switch &&
 			clk_mgr->base.clks.ref_dtbclk_khz != clk_mgr->base.boot_snapshot.dtbclk) {
 		clk_mgr->base.clks.ref_dtbclk_khz = clk_mgr->base.boot_snapshot.dtbclk;
-- 
2.39.2



