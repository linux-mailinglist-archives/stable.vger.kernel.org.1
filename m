Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D744379B715
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378786AbjIKWhR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240484AbjIKOpd (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:45:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 268EB12A
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:45:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DA3CC433C8;
        Mon, 11 Sep 2023 14:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694443528;
        bh=jDImVAU/nv1piEZKzyTD86ThHmMxpeCmYvX+aW+7/9Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CjQkfmcKHLc4ucX7yaPWn78D3x2084UQpw37mqw/zgHOo4KAXC+vPRyU2Xqv/GNiN
         zQdKlqlqaxygnC9ySUrIWbxja+oXVzFtCzuw3nwBlfsfhMRzvCOasGsZncpsPu3SC6
         qUrcggkE4jWZQLG857CbuqYgeYckcA475/UCGuwU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 409/737] clk: qcom: gpucc-sm6350: Introduce index-based clk lookup
Date:   Mon, 11 Sep 2023 15:44:28 +0200
Message-ID: <20230911134702.047697988@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Konrad Dybcio <konrad.dybcio@linaro.org>

[ Upstream commit f6f89d194e4ddcfe197ac8a05ed4161f642a5c68 ]

Add the nowadays-prefered and marginally faster way of looking up parent
clocks in the device tree. It also allows for clock-names-independent
operation, so long as the order (which is enforced by schema) is kept.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/20230315-topic-lagoon_gpu-v2-1-afcdfb18bb13@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Stable-dep-of: 743913b343a3 ("clk: qcom: gpucc-sm6350: Fix clock source names")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/qcom/gpucc-sm6350.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/qcom/gpucc-sm6350.c b/drivers/clk/qcom/gpucc-sm6350.c
index ef15185a99c31..a9887d1f0ed71 100644
--- a/drivers/clk/qcom/gpucc-sm6350.c
+++ b/drivers/clk/qcom/gpucc-sm6350.c
@@ -24,6 +24,12 @@
 #define CX_GMU_CBCR_WAKE_MASK		0xF
 #define CX_GMU_CBCR_WAKE_SHIFT		8
 
+enum {
+	DT_BI_TCXO,
+	DT_GPLL0_OUT_MAIN,
+	DT_GPLL0_OUT_MAIN_DIV,
+};
+
 enum {
 	P_BI_TCXO,
 	P_GPLL0_OUT_MAIN,
@@ -61,6 +67,7 @@ static struct clk_alpha_pll gpu_cc_pll0 = {
 		.hw.init = &(struct clk_init_data){
 			.name = "gpu_cc_pll0",
 			.parent_data =  &(const struct clk_parent_data){
+				.index = DT_BI_TCXO,
 				.fw_name = "bi_tcxo",
 			},
 			.num_parents = 1,
@@ -104,6 +111,7 @@ static struct clk_alpha_pll gpu_cc_pll1 = {
 		.hw.init = &(struct clk_init_data){
 			.name = "gpu_cc_pll1",
 			.parent_data =  &(const struct clk_parent_data){
+				.index = DT_BI_TCXO,
 				.fw_name = "bi_tcxo",
 			},
 			.num_parents = 1,
@@ -121,11 +129,11 @@ static const struct parent_map gpu_cc_parent_map_0[] = {
 };
 
 static const struct clk_parent_data gpu_cc_parent_data_0[] = {
-	{ .fw_name = "bi_tcxo" },
+	{ .index = DT_BI_TCXO, .fw_name = "bi_tcxo" },
 	{ .hw = &gpu_cc_pll0.clkr.hw },
 	{ .hw = &gpu_cc_pll1.clkr.hw },
-	{ .fw_name = "gcc_gpu_gpll0_clk" },
-	{ .fw_name = "gcc_gpu_gpll0_div_clk" },
+	{ .index = DT_GPLL0_OUT_MAIN, .fw_name = "gcc_gpu_gpll0_clk" },
+	{ .index = DT_GPLL0_OUT_MAIN_DIV, .fw_name = "gcc_gpu_gpll0_div_clk" },
 };
 
 static const struct parent_map gpu_cc_parent_map_1[] = {
@@ -138,12 +146,12 @@ static const struct parent_map gpu_cc_parent_map_1[] = {
 };
 
 static const struct clk_parent_data gpu_cc_parent_data_1[] = {
-	{ .fw_name = "bi_tcxo" },
+	{ .index = DT_BI_TCXO, .fw_name = "bi_tcxo" },
 	{ .hw = &crc_div.hw },
 	{ .hw = &gpu_cc_pll0.clkr.hw },
 	{ .hw = &gpu_cc_pll1.clkr.hw },
 	{ .hw = &gpu_cc_pll1.clkr.hw },
-	{ .fw_name = "gcc_gpu_gpll0_clk" },
+	{ .index = DT_GPLL0_OUT_MAIN, .fw_name = "gcc_gpu_gpll0_clk" },
 };
 
 static const struct freq_tbl ftbl_gpu_cc_gmu_clk_src[] = {
-- 
2.40.1



