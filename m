Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C80A27ED69C
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 23:02:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343760AbjKOWCb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 17:02:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343766AbjKOWC3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 17:02:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E4619D
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 14:02:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E694EC433CB;
        Wed, 15 Nov 2023 22:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700085745;
        bh=864vxmJ5jEyiN9U6JU1io9YfMb2x9f/zsVWbYRBOBJs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RlLj4TviSTM6rP0YEVh95wf4eT6HxgZBEM3DMiVAfHZxIQeI/dciCMnhfAxwBxTTs
         zm+LN1IOU7C6YYw5m4FzX9CnA2n/4laO5lnuNyww0kuswnSFFqVFnGDPpYumnoJe6N
         HRT5CCEu2pn7pN9XifOuUBeXCQuHEwBhQwlOQ5UU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 025/119] clk: qcom: gcc-sm8150: use ARRAY_SIZE instead of specifying num_parents
Date:   Wed, 15 Nov 2023 17:00:15 -0500
Message-ID: <20231115220133.408351078@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115220132.607437515@linuxfoundation.org>
References: <20231115220132.607437515@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

[ Upstream commit 60ca4670fd6436c07cea38472ebcee3b00f03bc7 ]

Use ARRAY_SIZE() instead of manually specifying num_parents. This makes
adding/removing entries to/from parent_data easy and errorproof.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Link: https://lore.kernel.org/r/20210405224743.590029-32-dmitry.baryshkov@linaro.org
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Stable-dep-of: 7138c244fb29 ("clk: qcom: gcc-sm8150: Fix gcc_sdcc2_apps_clk_src")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/qcom/gcc-sm8150.c | 96 +++++++++++++++++------------------
 1 file changed, 48 insertions(+), 48 deletions(-)

diff --git a/drivers/clk/qcom/gcc-sm8150.c b/drivers/clk/qcom/gcc-sm8150.c
index ee908fbfeab17..f18502cdc46e0 100644
--- a/drivers/clk/qcom/gcc-sm8150.c
+++ b/drivers/clk/qcom/gcc-sm8150.c
@@ -250,7 +250,7 @@ static struct clk_rcg2 gcc_cpuss_ahb_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_cpuss_ahb_clk_src",
 		.parent_data = gcc_parents_0,
-		.num_parents = 4,
+		.num_parents = ARRAY_SIZE(gcc_parents_0),
 		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_rcg2_ops,
 	},
@@ -273,7 +273,7 @@ static struct clk_rcg2 gcc_emac_ptp_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_emac_ptp_clk_src",
 		.parent_data = gcc_parents_5,
-		.num_parents = 5,
+		.num_parents = ARRAY_SIZE(gcc_parents_5),
 		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_rcg2_ops,
 	},
@@ -299,7 +299,7 @@ static struct clk_rcg2 gcc_emac_rgmii_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_emac_rgmii_clk_src",
 		.parent_data = gcc_parents_5,
-		.num_parents = 5,
+		.num_parents = ARRAY_SIZE(gcc_parents_5),
 		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_rcg2_ops,
 	},
@@ -323,7 +323,7 @@ static struct clk_rcg2 gcc_gp1_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_gp1_clk_src",
 		.parent_data = gcc_parents_1,
-		.num_parents = 5,
+		.num_parents = ARRAY_SIZE(gcc_parents_1),
 		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_rcg2_ops,
 	},
@@ -338,7 +338,7 @@ static struct clk_rcg2 gcc_gp2_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_gp2_clk_src",
 		.parent_data = gcc_parents_1,
-		.num_parents = 5,
+		.num_parents = ARRAY_SIZE(gcc_parents_1),
 		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_rcg2_ops,
 	},
@@ -353,7 +353,7 @@ static struct clk_rcg2 gcc_gp3_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_gp3_clk_src",
 		.parent_data = gcc_parents_1,
-		.num_parents = 5,
+		.num_parents = ARRAY_SIZE(gcc_parents_1),
 		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_rcg2_ops,
 	},
@@ -374,7 +374,7 @@ static struct clk_rcg2 gcc_pcie_0_aux_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_pcie_0_aux_clk_src",
 		.parent_data = gcc_parents_2,
-		.num_parents = 3,
+		.num_parents = ARRAY_SIZE(gcc_parents_2),
 		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_rcg2_ops,
 	},
@@ -389,7 +389,7 @@ static struct clk_rcg2 gcc_pcie_1_aux_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_pcie_1_aux_clk_src",
 		.parent_data = gcc_parents_2,
-		.num_parents = 3,
+		.num_parents = ARRAY_SIZE(gcc_parents_2),
 		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_rcg2_ops,
 	},
@@ -410,7 +410,7 @@ static struct clk_rcg2 gcc_pcie_phy_refgen_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_pcie_phy_refgen_clk_src",
 		.parent_data = gcc_parents_0,
-		.num_parents = 4,
+		.num_parents = ARRAY_SIZE(gcc_parents_0),
 		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_rcg2_ops,
 	},
@@ -432,7 +432,7 @@ static struct clk_rcg2 gcc_pdm2_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_pdm2_clk_src",
 		.parent_data = gcc_parents_0,
-		.num_parents = 4,
+		.num_parents = ARRAY_SIZE(gcc_parents_0),
 		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_rcg2_ops,
 	},
@@ -455,7 +455,7 @@ static struct clk_rcg2 gcc_qspi_core_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_qspi_core_clk_src",
 		.parent_data = gcc_parents_0,
-		.num_parents = 4,
+		.num_parents = ARRAY_SIZE(gcc_parents_0),
 		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_rcg2_ops,
 	},
@@ -489,7 +489,7 @@ static struct clk_rcg2 gcc_qupv3_wrap0_s0_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_qupv3_wrap0_s0_clk_src",
 		.parent_data = gcc_parents_0,
-		.num_parents = 4,
+		.num_parents = ARRAY_SIZE(gcc_parents_0),
 		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_rcg2_ops,
 	},
@@ -504,7 +504,7 @@ static struct clk_rcg2 gcc_qupv3_wrap0_s1_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_qupv3_wrap0_s1_clk_src",
 		.parent_data = gcc_parents_0,
-		.num_parents = 4,
+		.num_parents = ARRAY_SIZE(gcc_parents_0),
 		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_rcg2_ops,
 	},
@@ -519,7 +519,7 @@ static struct clk_rcg2 gcc_qupv3_wrap0_s2_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_qupv3_wrap0_s2_clk_src",
 		.parent_data = gcc_parents_0,
-		.num_parents = 4,
+		.num_parents = ARRAY_SIZE(gcc_parents_0),
 		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_rcg2_ops,
 	},
@@ -534,7 +534,7 @@ static struct clk_rcg2 gcc_qupv3_wrap0_s3_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_qupv3_wrap0_s3_clk_src",
 		.parent_data = gcc_parents_0,
-		.num_parents = 4,
+		.num_parents = ARRAY_SIZE(gcc_parents_0),
 		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_rcg2_ops,
 	},
@@ -549,7 +549,7 @@ static struct clk_rcg2 gcc_qupv3_wrap0_s4_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_qupv3_wrap0_s4_clk_src",
 		.parent_data = gcc_parents_0,
-		.num_parents = 4,
+		.num_parents = ARRAY_SIZE(gcc_parents_0),
 		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_rcg2_ops,
 	},
@@ -564,7 +564,7 @@ static struct clk_rcg2 gcc_qupv3_wrap0_s5_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_qupv3_wrap0_s5_clk_src",
 		.parent_data = gcc_parents_0,
-		.num_parents = 4,
+		.num_parents = ARRAY_SIZE(gcc_parents_0),
 		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_rcg2_ops,
 	},
@@ -579,7 +579,7 @@ static struct clk_rcg2 gcc_qupv3_wrap0_s6_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_qupv3_wrap0_s6_clk_src",
 		.parent_data = gcc_parents_0,
-		.num_parents = 4,
+		.num_parents = ARRAY_SIZE(gcc_parents_0),
 		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_rcg2_ops,
 	},
@@ -594,7 +594,7 @@ static struct clk_rcg2 gcc_qupv3_wrap0_s7_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_qupv3_wrap0_s7_clk_src",
 		.parent_data = gcc_parents_0,
-		.num_parents = 4,
+		.num_parents = ARRAY_SIZE(gcc_parents_0),
 		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_rcg2_ops,
 	},
@@ -609,7 +609,7 @@ static struct clk_rcg2 gcc_qupv3_wrap1_s0_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_qupv3_wrap1_s0_clk_src",
 		.parent_data = gcc_parents_0,
-		.num_parents = 4,
+		.num_parents = ARRAY_SIZE(gcc_parents_0),
 		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_rcg2_ops,
 	},
@@ -624,7 +624,7 @@ static struct clk_rcg2 gcc_qupv3_wrap1_s1_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_qupv3_wrap1_s1_clk_src",
 		.parent_data = gcc_parents_0,
-		.num_parents = 4,
+		.num_parents = ARRAY_SIZE(gcc_parents_0),
 		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_rcg2_ops,
 	},
@@ -639,7 +639,7 @@ static struct clk_rcg2 gcc_qupv3_wrap1_s2_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_qupv3_wrap1_s2_clk_src",
 		.parent_data = gcc_parents_0,
-		.num_parents = 4,
+		.num_parents = ARRAY_SIZE(gcc_parents_0),
 		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_rcg2_ops,
 	},
@@ -654,7 +654,7 @@ static struct clk_rcg2 gcc_qupv3_wrap1_s3_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_qupv3_wrap1_s3_clk_src",
 		.parent_data = gcc_parents_0,
-		.num_parents = 4,
+		.num_parents = ARRAY_SIZE(gcc_parents_0),
 		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_rcg2_ops,
 	},
@@ -669,7 +669,7 @@ static struct clk_rcg2 gcc_qupv3_wrap1_s4_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_qupv3_wrap1_s4_clk_src",
 		.parent_data = gcc_parents_0,
-		.num_parents = 4,
+		.num_parents = ARRAY_SIZE(gcc_parents_0),
 		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_rcg2_ops,
 	},
@@ -684,7 +684,7 @@ static struct clk_rcg2 gcc_qupv3_wrap1_s5_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_qupv3_wrap1_s5_clk_src",
 		.parent_data = gcc_parents_0,
-		.num_parents = 4,
+		.num_parents = ARRAY_SIZE(gcc_parents_0),
 		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_rcg2_ops,
 	},
@@ -699,7 +699,7 @@ static struct clk_rcg2 gcc_qupv3_wrap2_s0_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_qupv3_wrap2_s0_clk_src",
 		.parent_data = gcc_parents_0,
-		.num_parents = 4,
+		.num_parents = ARRAY_SIZE(gcc_parents_0),
 		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_rcg2_ops,
 	},
@@ -714,7 +714,7 @@ static struct clk_rcg2 gcc_qupv3_wrap2_s1_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_qupv3_wrap2_s1_clk_src",
 		.parent_data = gcc_parents_0,
-		.num_parents = 4,
+		.num_parents = ARRAY_SIZE(gcc_parents_0),
 		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_rcg2_ops,
 	},
@@ -729,7 +729,7 @@ static struct clk_rcg2 gcc_qupv3_wrap2_s2_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_qupv3_wrap2_s2_clk_src",
 		.parent_data = gcc_parents_0,
-		.num_parents = 4,
+		.num_parents = ARRAY_SIZE(gcc_parents_0),
 		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_rcg2_ops,
 	},
@@ -744,7 +744,7 @@ static struct clk_rcg2 gcc_qupv3_wrap2_s3_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_qupv3_wrap2_s3_clk_src",
 		.parent_data = gcc_parents_0,
-		.num_parents = 4,
+		.num_parents = ARRAY_SIZE(gcc_parents_0),
 		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_rcg2_ops,
 	},
@@ -759,7 +759,7 @@ static struct clk_rcg2 gcc_qupv3_wrap2_s4_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_qupv3_wrap2_s4_clk_src",
 		.parent_data = gcc_parents_0,
-		.num_parents = 4,
+		.num_parents = ARRAY_SIZE(gcc_parents_0),
 		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_rcg2_ops,
 	},
@@ -774,7 +774,7 @@ static struct clk_rcg2 gcc_qupv3_wrap2_s5_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_qupv3_wrap2_s5_clk_src",
 		.parent_data = gcc_parents_0,
-		.num_parents = 4,
+		.num_parents = ARRAY_SIZE(gcc_parents_0),
 		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_rcg2_ops,
 	},
@@ -800,7 +800,7 @@ static struct clk_rcg2 gcc_sdcc2_apps_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_sdcc2_apps_clk_src",
 		.parent_data = gcc_parents_6,
-		.num_parents = 5,
+		.num_parents = ARRAY_SIZE(gcc_parents_6),
 		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_rcg2_floor_ops,
 	},
@@ -825,7 +825,7 @@ static struct clk_rcg2 gcc_sdcc4_apps_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_sdcc4_apps_clk_src",
 		.parent_data = gcc_parents_3,
-		.num_parents = 3,
+		.num_parents = ARRAY_SIZE(gcc_parents_3),
 		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_rcg2_floor_ops,
 	},
@@ -845,7 +845,7 @@ static struct clk_rcg2 gcc_tsif_ref_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_tsif_ref_clk_src",
 		.parent_data = gcc_parents_7,
-		.num_parents = 5,
+		.num_parents = ARRAY_SIZE(gcc_parents_7),
 		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_rcg2_ops,
 	},
@@ -869,7 +869,7 @@ static struct clk_rcg2 gcc_ufs_card_axi_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_ufs_card_axi_clk_src",
 		.parent_data = gcc_parents_0,
-		.num_parents = 4,
+		.num_parents = ARRAY_SIZE(gcc_parents_0),
 		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_rcg2_ops,
 	},
@@ -892,7 +892,7 @@ static struct clk_rcg2 gcc_ufs_card_ice_core_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_ufs_card_ice_core_clk_src",
 		.parent_data = gcc_parents_0,
-		.num_parents = 4,
+		.num_parents = ARRAY_SIZE(gcc_parents_0),
 		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_rcg2_ops,
 	},
@@ -912,7 +912,7 @@ static struct clk_rcg2 gcc_ufs_card_phy_aux_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_ufs_card_phy_aux_clk_src",
 		.parent_data = gcc_parents_4,
-		.num_parents = 2,
+		.num_parents = ARRAY_SIZE(gcc_parents_4),
 		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_rcg2_ops,
 	},
@@ -934,7 +934,7 @@ static struct clk_rcg2 gcc_ufs_card_unipro_core_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_ufs_card_unipro_core_clk_src",
 		.parent_data = gcc_parents_0,
-		.num_parents = 4,
+		.num_parents = ARRAY_SIZE(gcc_parents_0),
 		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_rcg2_ops,
 	},
@@ -958,7 +958,7 @@ static struct clk_rcg2 gcc_ufs_phy_axi_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_ufs_phy_axi_clk_src",
 		.parent_data = gcc_parents_0,
-		.num_parents = 4,
+		.num_parents = ARRAY_SIZE(gcc_parents_0),
 		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_rcg2_ops,
 	},
@@ -973,7 +973,7 @@ static struct clk_rcg2 gcc_ufs_phy_ice_core_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_ufs_phy_ice_core_clk_src",
 		.parent_data = gcc_parents_0,
-		.num_parents = 4,
+		.num_parents = ARRAY_SIZE(gcc_parents_0),
 		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_rcg2_ops,
 	},
@@ -988,7 +988,7 @@ static struct clk_rcg2 gcc_ufs_phy_phy_aux_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_ufs_phy_phy_aux_clk_src",
 		.parent_data = gcc_parents_4,
-		.num_parents = 2,
+		.num_parents = ARRAY_SIZE(gcc_parents_4),
 		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_rcg2_ops,
 	},
@@ -1003,7 +1003,7 @@ static struct clk_rcg2 gcc_ufs_phy_unipro_core_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_ufs_phy_unipro_core_clk_src",
 		.parent_data = gcc_parents_0,
-		.num_parents = 4,
+		.num_parents = ARRAY_SIZE(gcc_parents_0),
 		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_rcg2_ops,
 	},
@@ -1027,7 +1027,7 @@ static struct clk_rcg2 gcc_usb30_prim_master_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_usb30_prim_master_clk_src",
 		.parent_data = gcc_parents_0,
-		.num_parents = 4,
+		.num_parents = ARRAY_SIZE(gcc_parents_0),
 		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_rcg2_ops,
 	},
@@ -1049,7 +1049,7 @@ static struct clk_rcg2 gcc_usb30_prim_mock_utmi_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_usb30_prim_mock_utmi_clk_src",
 		.parent_data = gcc_parents_0,
-		.num_parents = 4,
+		.num_parents = ARRAY_SIZE(gcc_parents_0),
 		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_rcg2_ops,
 	},
@@ -1064,7 +1064,7 @@ static struct clk_rcg2 gcc_usb30_sec_master_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_usb30_sec_master_clk_src",
 		.parent_data = gcc_parents_0,
-		.num_parents = 4,
+		.num_parents = ARRAY_SIZE(gcc_parents_0),
 		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_rcg2_ops,
 	},
@@ -1079,7 +1079,7 @@ static struct clk_rcg2 gcc_usb30_sec_mock_utmi_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_usb30_sec_mock_utmi_clk_src",
 		.parent_data = gcc_parents_0,
-		.num_parents = 4,
+		.num_parents = ARRAY_SIZE(gcc_parents_0),
 		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_rcg2_ops,
 	},
@@ -1094,7 +1094,7 @@ static struct clk_rcg2 gcc_usb3_prim_phy_aux_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_usb3_prim_phy_aux_clk_src",
 		.parent_data = gcc_parents_2,
-		.num_parents = 3,
+		.num_parents = ARRAY_SIZE(gcc_parents_2),
 		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_rcg2_ops,
 	},
@@ -1109,7 +1109,7 @@ static struct clk_rcg2 gcc_usb3_sec_phy_aux_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_usb3_sec_phy_aux_clk_src",
 		.parent_data = gcc_parents_2,
-		.num_parents = 3,
+		.num_parents = ARRAY_SIZE(gcc_parents_2),
 		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_rcg2_ops,
 	},
-- 
2.42.0



