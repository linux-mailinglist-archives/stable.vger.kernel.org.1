Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 072596FAC65
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235639AbjEHLYM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235664AbjEHLXx (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:23:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E11439B93
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:23:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1476262C45
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:23:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02310C433EF;
        Mon,  8 May 2023 11:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683545029;
        bh=abqzOjqBnXKXcKJNOweSZvKSDdSrbf8PH07ibMpKtRU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gW3cmbs1lsglvJ4+zLt8aTnEKpgSdXsunz5g6c8Eh18k0hEF0MFLxcTfpc3WFZPhS
         ynMmihBAWo6FY3fQaqAM8ybyXb60m2k4civhCW/mwFiaC3I4HHcGDaSm/O858RYhlR
         qfFklBjpRgOBV1Xg5yU6xsJ8PTlilXY6b3dIhqno=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 601/694] clk: qcom: gcc-sm6115: Mark RCGs shared where applicable
Date:   Mon,  8 May 2023 11:47:16 +0200
Message-Id: <20230508094454.758852770@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
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
index 5b8222fea2f71..5f09aefa7fb92 100644
--- a/drivers/clk/qcom/gcc-sm6115.c
+++ b/drivers/clk/qcom/gcc-sm6115.c
@@ -694,7 +694,7 @@ static struct clk_rcg2 gcc_camss_axi_clk_src = {
 		.parent_data = gcc_parents_7,
 		.num_parents = ARRAY_SIZE(gcc_parents_7),
 		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -715,7 +715,7 @@ static struct clk_rcg2 gcc_camss_cci_clk_src = {
 		.parent_data = gcc_parents_9,
 		.num_parents = ARRAY_SIZE(gcc_parents_9),
 		.flags = CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -738,7 +738,7 @@ static struct clk_rcg2 gcc_camss_csi0phytimer_clk_src = {
 		.parent_data = gcc_parents_4,
 		.num_parents = ARRAY_SIZE(gcc_parents_4),
 		.flags = CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -753,7 +753,7 @@ static struct clk_rcg2 gcc_camss_csi1phytimer_clk_src = {
 		.parent_data = gcc_parents_4,
 		.num_parents = ARRAY_SIZE(gcc_parents_4),
 		.flags = CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -768,7 +768,7 @@ static struct clk_rcg2 gcc_camss_csi2phytimer_clk_src = {
 		.parent_data = gcc_parents_4,
 		.num_parents = ARRAY_SIZE(gcc_parents_4),
 		.flags = CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -790,7 +790,7 @@ static struct clk_rcg2 gcc_camss_mclk0_clk_src = {
 		.parent_data = gcc_parents_3,
 		.num_parents = ARRAY_SIZE(gcc_parents_3),
 		.flags = CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -805,7 +805,7 @@ static struct clk_rcg2 gcc_camss_mclk1_clk_src = {
 		.parent_data = gcc_parents_3,
 		.num_parents = ARRAY_SIZE(gcc_parents_3),
 		.flags = CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -820,7 +820,7 @@ static struct clk_rcg2 gcc_camss_mclk2_clk_src = {
 		.parent_data = gcc_parents_3,
 		.num_parents = ARRAY_SIZE(gcc_parents_3),
 		.flags = CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -835,7 +835,7 @@ static struct clk_rcg2 gcc_camss_mclk3_clk_src = {
 		.parent_data = gcc_parents_3,
 		.num_parents = ARRAY_SIZE(gcc_parents_3),
 		.flags = CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -857,7 +857,7 @@ static struct clk_rcg2 gcc_camss_ope_ahb_clk_src = {
 		.parent_data = gcc_parents_8,
 		.num_parents = ARRAY_SIZE(gcc_parents_8),
 		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -881,7 +881,7 @@ static struct clk_rcg2 gcc_camss_ope_clk_src = {
 		.parent_data = gcc_parents_8,
 		.num_parents = ARRAY_SIZE(gcc_parents_8),
 		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -916,7 +916,7 @@ static struct clk_rcg2 gcc_camss_tfe_0_clk_src = {
 		.parent_data = gcc_parents_5,
 		.num_parents = ARRAY_SIZE(gcc_parents_5),
 		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -941,7 +941,7 @@ static struct clk_rcg2 gcc_camss_tfe_0_csid_clk_src = {
 		.parent_data = gcc_parents_6,
 		.num_parents = ARRAY_SIZE(gcc_parents_6),
 		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -956,7 +956,7 @@ static struct clk_rcg2 gcc_camss_tfe_1_clk_src = {
 		.parent_data = gcc_parents_5,
 		.num_parents = ARRAY_SIZE(gcc_parents_5),
 		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -971,7 +971,7 @@ static struct clk_rcg2 gcc_camss_tfe_1_csid_clk_src = {
 		.parent_data = gcc_parents_6,
 		.num_parents = ARRAY_SIZE(gcc_parents_6),
 		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -986,7 +986,7 @@ static struct clk_rcg2 gcc_camss_tfe_2_clk_src = {
 		.parent_data = gcc_parents_5,
 		.num_parents = ARRAY_SIZE(gcc_parents_5),
 		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -1001,7 +1001,7 @@ static struct clk_rcg2 gcc_camss_tfe_2_csid_clk_src = {
 		.parent_data = gcc_parents_6,
 		.num_parents = ARRAY_SIZE(gcc_parents_6),
 		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -1024,7 +1024,7 @@ static struct clk_rcg2 gcc_camss_tfe_cphy_rx_clk_src = {
 		.parent_data = gcc_parents_10,
 		.num_parents = ARRAY_SIZE(gcc_parents_10),
 		.flags = CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -1046,7 +1046,7 @@ static struct clk_rcg2 gcc_camss_top_ahb_clk_src = {
 		.parent_data = gcc_parents_7,
 		.num_parents = ARRAY_SIZE(gcc_parents_7),
 		.flags = CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -1116,7 +1116,7 @@ static struct clk_rcg2 gcc_pdm2_clk_src = {
 		.name = "gcc_pdm2_clk_src",
 		.parent_data = gcc_parents_0,
 		.num_parents = ARRAY_SIZE(gcc_parents_0),
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -1329,7 +1329,7 @@ static struct clk_rcg2 gcc_ufs_phy_axi_clk_src = {
 		.name = "gcc_ufs_phy_axi_clk_src",
 		.parent_data = gcc_parents_0,
 		.num_parents = ARRAY_SIZE(gcc_parents_0),
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -1351,7 +1351,7 @@ static struct clk_rcg2 gcc_ufs_phy_ice_core_clk_src = {
 		.name = "gcc_ufs_phy_ice_core_clk_src",
 		.parent_data = gcc_parents_0,
 		.num_parents = ARRAY_SIZE(gcc_parents_0),
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -1392,7 +1392,7 @@ static struct clk_rcg2 gcc_ufs_phy_unipro_core_clk_src = {
 		.name = "gcc_ufs_phy_unipro_core_clk_src",
 		.parent_data = gcc_parents_0,
 		.num_parents = ARRAY_SIZE(gcc_parents_0),
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -1414,7 +1414,7 @@ static struct clk_rcg2 gcc_usb30_prim_master_clk_src = {
 		.name = "gcc_usb30_prim_master_clk_src",
 		.parent_data = gcc_parents_0,
 		.num_parents = ARRAY_SIZE(gcc_parents_0),
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -1483,7 +1483,7 @@ static struct clk_rcg2 gcc_video_venus_clk_src = {
 		.parent_data = gcc_parents_13,
 		.num_parents = ARRAY_SIZE(gcc_parents_13),
 		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
-- 
2.39.2



