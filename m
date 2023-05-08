Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4A786FAE7B
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236297AbjEHLpJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236327AbjEHLoq (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:44:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12110106F8
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:44:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B77216364B
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:44:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8BE2C4339B;
        Mon,  8 May 2023 11:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683546257;
        bh=90zX2WFuHLUVSnIDmF7uXt7LzTvQVSSNS10UQl57M1o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bAkwIaoq2PPrsfLs4/Nxp3lP+Z+LCRlBJ5M3LdX5Ei9U+eyIgv7+/JLyCl7mMy7Dg
         fJyAer7PrCK6pViCLoRxu8rRCnoEzdKfWhgliT/oSO8KA4QOE0C4fmn392hsAbVyC7
         pnh2xd0A1oB/2/tR5Wk0lBMzarG3eY+VqeiHNqM4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 308/371] clk: qcom: gcc-sm6115: Mark RCGs shared where applicable
Date:   Mon,  8 May 2023 11:48:29 +0200
Message-Id: <20230508094824.279500724@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094811.912279944@linuxfoundation.org>
References: <20230508094811.912279944@linuxfoundation.org>
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

From: Konrad Dybcio <konrad.dybcio@linaro.org>

[ Upstream commit 996c32b745a15a637e8244a25f06b74acce98976 ]

The vast majority of shared RCGs were not marked as such. Fix it.

Fixes: cbe63bfdc54f ("clk: qcom: Add Global Clock controller (GCC) driver for SM6115")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Link: https://lore.kernel.org/r/20230404224719.909746-1-konrad.dybcio@linaro.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/qcom/gcc-sm6115.c | 50 +++++++++++++++++------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/clk/qcom/gcc-sm6115.c b/drivers/clk/qcom/gcc-sm6115.c
index e24a977c25806..1c3be4e07d5bc 100644
--- a/drivers/clk/qcom/gcc-sm6115.c
+++ b/drivers/clk/qcom/gcc-sm6115.c
@@ -720,7 +720,7 @@ static struct clk_rcg2 gcc_camss_axi_clk_src = {
 		.parent_data = gcc_parents_7,
 		.num_parents = ARRAY_SIZE(gcc_parents_7),
 		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -741,7 +741,7 @@ static struct clk_rcg2 gcc_camss_cci_clk_src = {
 		.parent_data = gcc_parents_9,
 		.num_parents = ARRAY_SIZE(gcc_parents_9),
 		.flags = CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -764,7 +764,7 @@ static struct clk_rcg2 gcc_camss_csi0phytimer_clk_src = {
 		.parent_data = gcc_parents_4,
 		.num_parents = ARRAY_SIZE(gcc_parents_4),
 		.flags = CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -779,7 +779,7 @@ static struct clk_rcg2 gcc_camss_csi1phytimer_clk_src = {
 		.parent_data = gcc_parents_4,
 		.num_parents = ARRAY_SIZE(gcc_parents_4),
 		.flags = CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -794,7 +794,7 @@ static struct clk_rcg2 gcc_camss_csi2phytimer_clk_src = {
 		.parent_data = gcc_parents_4,
 		.num_parents = ARRAY_SIZE(gcc_parents_4),
 		.flags = CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -816,7 +816,7 @@ static struct clk_rcg2 gcc_camss_mclk0_clk_src = {
 		.parent_data = gcc_parents_3,
 		.num_parents = ARRAY_SIZE(gcc_parents_3),
 		.flags = CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -831,7 +831,7 @@ static struct clk_rcg2 gcc_camss_mclk1_clk_src = {
 		.parent_data = gcc_parents_3,
 		.num_parents = ARRAY_SIZE(gcc_parents_3),
 		.flags = CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -846,7 +846,7 @@ static struct clk_rcg2 gcc_camss_mclk2_clk_src = {
 		.parent_data = gcc_parents_3,
 		.num_parents = ARRAY_SIZE(gcc_parents_3),
 		.flags = CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -861,7 +861,7 @@ static struct clk_rcg2 gcc_camss_mclk3_clk_src = {
 		.parent_data = gcc_parents_3,
 		.num_parents = ARRAY_SIZE(gcc_parents_3),
 		.flags = CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -883,7 +883,7 @@ static struct clk_rcg2 gcc_camss_ope_ahb_clk_src = {
 		.parent_data = gcc_parents_8,
 		.num_parents = ARRAY_SIZE(gcc_parents_8),
 		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -907,7 +907,7 @@ static struct clk_rcg2 gcc_camss_ope_clk_src = {
 		.parent_data = gcc_parents_8,
 		.num_parents = ARRAY_SIZE(gcc_parents_8),
 		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -942,7 +942,7 @@ static struct clk_rcg2 gcc_camss_tfe_0_clk_src = {
 		.parent_data = gcc_parents_5,
 		.num_parents = ARRAY_SIZE(gcc_parents_5),
 		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -967,7 +967,7 @@ static struct clk_rcg2 gcc_camss_tfe_0_csid_clk_src = {
 		.parent_data = gcc_parents_6,
 		.num_parents = ARRAY_SIZE(gcc_parents_6),
 		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -982,7 +982,7 @@ static struct clk_rcg2 gcc_camss_tfe_1_clk_src = {
 		.parent_data = gcc_parents_5,
 		.num_parents = ARRAY_SIZE(gcc_parents_5),
 		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -997,7 +997,7 @@ static struct clk_rcg2 gcc_camss_tfe_1_csid_clk_src = {
 		.parent_data = gcc_parents_6,
 		.num_parents = ARRAY_SIZE(gcc_parents_6),
 		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -1012,7 +1012,7 @@ static struct clk_rcg2 gcc_camss_tfe_2_clk_src = {
 		.parent_data = gcc_parents_5,
 		.num_parents = ARRAY_SIZE(gcc_parents_5),
 		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -1027,7 +1027,7 @@ static struct clk_rcg2 gcc_camss_tfe_2_csid_clk_src = {
 		.parent_data = gcc_parents_6,
 		.num_parents = ARRAY_SIZE(gcc_parents_6),
 		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -1050,7 +1050,7 @@ static struct clk_rcg2 gcc_camss_tfe_cphy_rx_clk_src = {
 		.parent_data = gcc_parents_10,
 		.num_parents = ARRAY_SIZE(gcc_parents_10),
 		.flags = CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -1072,7 +1072,7 @@ static struct clk_rcg2 gcc_camss_top_ahb_clk_src = {
 		.parent_data = gcc_parents_7,
 		.num_parents = ARRAY_SIZE(gcc_parents_7),
 		.flags = CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -1142,7 +1142,7 @@ static struct clk_rcg2 gcc_pdm2_clk_src = {
 		.name = "gcc_pdm2_clk_src",
 		.parent_data = gcc_parents_0,
 		.num_parents = ARRAY_SIZE(gcc_parents_0),
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -1355,7 +1355,7 @@ static struct clk_rcg2 gcc_ufs_phy_axi_clk_src = {
 		.name = "gcc_ufs_phy_axi_clk_src",
 		.parent_data = gcc_parents_0,
 		.num_parents = ARRAY_SIZE(gcc_parents_0),
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -1377,7 +1377,7 @@ static struct clk_rcg2 gcc_ufs_phy_ice_core_clk_src = {
 		.name = "gcc_ufs_phy_ice_core_clk_src",
 		.parent_data = gcc_parents_0,
 		.num_parents = ARRAY_SIZE(gcc_parents_0),
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -1418,7 +1418,7 @@ static struct clk_rcg2 gcc_ufs_phy_unipro_core_clk_src = {
 		.name = "gcc_ufs_phy_unipro_core_clk_src",
 		.parent_data = gcc_parents_0,
 		.num_parents = ARRAY_SIZE(gcc_parents_0),
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -1440,7 +1440,7 @@ static struct clk_rcg2 gcc_usb30_prim_master_clk_src = {
 		.name = "gcc_usb30_prim_master_clk_src",
 		.parent_data = gcc_parents_0,
 		.num_parents = ARRAY_SIZE(gcc_parents_0),
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -1509,7 +1509,7 @@ static struct clk_rcg2 gcc_video_venus_clk_src = {
 		.parent_data = gcc_parents_13,
 		.num_parents = ARRAY_SIZE(gcc_parents_13),
 		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
-- 
2.39.2



