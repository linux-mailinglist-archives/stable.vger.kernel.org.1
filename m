Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FAD479BA9B
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377592AbjIKW13 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240385AbjIKOm6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:42:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A16A12A
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:42:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DAEAC433C8;
        Mon, 11 Sep 2023 14:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694443372;
        bh=rhBwCmZuY8zx0HZEtQxepkwjSAjV+pOfJYRSX70X1sQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XVCoIfMfNLUlizaN2zJOiwBSDed5CDOvndkwKi9IG6gpVxMdCTynlb+3zI6u/WBIt
         2qWfAUdOF2hgJPbRIQdXIFERat8NVXRSo8lxKmNjYoe4hJEl/Sof4A02MQ1/719UNb
         SbHUS7d1DvGp3JXYHZyZnDhiswEF/QOKdgKKM1r0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 354/737] drm/msm/dpu: drop the regdma configuration
Date:   Mon, 11 Sep 2023 15:43:33 +0200
Message-ID: <20230911134700.404917894@linuxfoundation.org>
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

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

[ Upstream commit 078f766e165097c03629cc1a8f7e1a7b7ec0e79b ]

The regdma is currently not used by the current driver. We have no way
to practically verify that the regdma is described correctly. Drop it
now.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>
Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Patchwork: https://patchwork.freedesktop.org/patch/533148/
Link: https://lore.kernel.org/r/20230420222558.1208887-1-dmitry.baryshkov@linaro.org
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Stable-dep-of: 42d0d253ed03 ("drm/msm/dpu: increase memtype count to 16 for sm8550")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../msm/disp/dpu1/catalog/dpu_3_0_msm8998.h   |  1 -
 .../msm/disp/dpu1/catalog/dpu_4_0_sdm845.h    |  2 -
 .../msm/disp/dpu1/catalog/dpu_5_0_sm8150.h    |  2 -
 .../msm/disp/dpu1/catalog/dpu_5_1_sc8180x.h   |  2 -
 .../msm/disp/dpu1/catalog/dpu_6_0_sm8250.h    |  2 -
 .../msm/disp/dpu1/catalog/dpu_6_2_sc7180.h    |  2 -
 .../msm/disp/dpu1/catalog/dpu_7_0_sm8350.h    |  2 -
 .../msm/disp/dpu1/catalog/dpu_8_0_sc8280xp.h  |  2 -
 .../msm/disp/dpu1/catalog/dpu_8_1_sm8450.h    |  2 -
 .../msm/disp/dpu1/catalog/dpu_9_0_sm8550.h    |  2 -
 .../gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c    | 40 -------------------
 .../gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h    | 18 ---------
 12 files changed, 77 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h
index ff9ccf72a4bf9..6560eeef00143 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h
@@ -195,7 +195,6 @@ const struct dpu_mdss_cfg dpu_msm8998_cfg = {
 	.intf = msm8998_intf,
 	.vbif_count = ARRAY_SIZE(msm8998_vbif),
 	.vbif = msm8998_vbif,
-	.reg_dma_count = 0,
 	.perf = &msm8998_perf_data,
 	.mdss_irqs = BIT(MDP_SSPP_TOP0_INTR) | \
 		     BIT(MDP_SSPP_TOP0_INTR2) | \
diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_4_0_sdm845.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_4_0_sdm845.h
index 5b9b3b99f1b5f..84159f8cbdaeb 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_4_0_sdm845.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_4_0_sdm845.h
@@ -193,8 +193,6 @@ const struct dpu_mdss_cfg dpu_sdm845_cfg = {
 	.intf = sdm845_intf,
 	.vbif_count = ARRAY_SIZE(sdm845_vbif),
 	.vbif = sdm845_vbif,
-	.reg_dma_count = 1,
-	.dma_cfg = &sdm845_regdma,
 	.perf = &sdm845_perf_data,
 	.mdss_irqs = BIT(MDP_SSPP_TOP0_INTR) | \
 		     BIT(MDP_SSPP_TOP0_INTR2) | \
diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_0_sm8150.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_0_sm8150.h
index 074ba54d420f4..266c525f8daaf 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_0_sm8150.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_0_sm8150.h
@@ -220,8 +220,6 @@ const struct dpu_mdss_cfg dpu_sm8150_cfg = {
 	.intf = sm8150_intf,
 	.vbif_count = ARRAY_SIZE(sdm845_vbif),
 	.vbif = sdm845_vbif,
-	.reg_dma_count = 1,
-	.dma_cfg = &sm8150_regdma,
 	.perf = &sm8150_perf_data,
 	.mdss_irqs = BIT(MDP_SSPP_TOP0_INTR) | \
 		     BIT(MDP_SSPP_TOP0_INTR2) | \
diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_1_sc8180x.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_1_sc8180x.h
index 0540d21810857..76c5745c2fa1f 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_1_sc8180x.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_1_sc8180x.h
@@ -198,8 +198,6 @@ const struct dpu_mdss_cfg dpu_sc8180x_cfg = {
 	.intf = sc8180x_intf,
 	.vbif_count = ARRAY_SIZE(sdm845_vbif),
 	.vbif = sdm845_vbif,
-	.reg_dma_count = 1,
-	.dma_cfg = &sm8150_regdma,
 	.perf = &sc8180x_perf_data,
 	.mdss_irqs = BIT(MDP_SSPP_TOP0_INTR) | \
 		     BIT(MDP_SSPP_TOP0_INTR2) | \
diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_0_sm8250.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_0_sm8250.h
index b3284de35b8fa..8660d04d0f589 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_0_sm8250.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_0_sm8250.h
@@ -228,8 +228,6 @@ const struct dpu_mdss_cfg dpu_sm8250_cfg = {
 	.vbif = sdm845_vbif,
 	.wb_count = ARRAY_SIZE(sm8250_wb),
 	.wb = sm8250_wb,
-	.reg_dma_count = 1,
-	.dma_cfg = &sm8250_regdma,
 	.perf = &sm8250_perf_data,
 	.mdss_irqs = BIT(MDP_SSPP_TOP0_INTR) | \
 		     BIT(MDP_SSPP_TOP0_INTR2) | \
diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_2_sc7180.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_2_sc7180.h
index 88c211876516a..9631116f99e9b 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_2_sc7180.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_2_sc7180.h
@@ -147,8 +147,6 @@ const struct dpu_mdss_cfg dpu_sc7180_cfg = {
 	.wb = sc7180_wb,
 	.vbif_count = ARRAY_SIZE(sdm845_vbif),
 	.vbif = sdm845_vbif,
-	.reg_dma_count = 1,
-	.dma_cfg = &sdm845_regdma,
 	.perf = &sc7180_perf_data,
 	.mdss_irqs = BIT(MDP_SSPP_TOP0_INTR) | \
 		     BIT(MDP_SSPP_TOP0_INTR2) | \
diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_7_0_sm8350.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_7_0_sm8350.h
index 4f6a965bcd90b..9e8d6632a1927 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_7_0_sm8350.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_7_0_sm8350.h
@@ -211,8 +211,6 @@ const struct dpu_mdss_cfg dpu_sm8350_cfg = {
 	.intf = sm8350_intf,
 	.vbif_count = ARRAY_SIZE(sdm845_vbif),
 	.vbif = sdm845_vbif,
-	.reg_dma_count = 1,
-	.dma_cfg = &sm8350_regdma,
 	.perf = &sm8350_perf_data,
 	.mdss_irqs = BIT(MDP_SSPP_TOP0_INTR) | \
 		     BIT(MDP_SSPP_TOP0_INTR2) | \
diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_0_sc8280xp.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_0_sc8280xp.h
index 706d0f13b598e..cb58b4ec97db4 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_0_sc8280xp.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_0_sc8280xp.h
@@ -202,8 +202,6 @@ const struct dpu_mdss_cfg dpu_sc8280xp_cfg = {
 	.intf = sc8280xp_intf,
 	.vbif_count = ARRAY_SIZE(sdm845_vbif),
 	.vbif = sdm845_vbif,
-	.reg_dma_count = 1,
-	.dma_cfg = &sc8280xp_regdma,
 	.perf = &sc8280xp_perf_data,
 	.mdss_irqs = BIT(MDP_SSPP_TOP0_INTR) | \
 		     BIT(MDP_SSPP_TOP0_INTR2) | \
diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_1_sm8450.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_1_sm8450.h
index 8bd4bb97e639c..905b403ffb0fb 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_1_sm8450.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_1_sm8450.h
@@ -219,8 +219,6 @@ const struct dpu_mdss_cfg dpu_sm8450_cfg = {
 	.intf = sm8450_intf,
 	.vbif_count = ARRAY_SIZE(sdm845_vbif),
 	.vbif = sdm845_vbif,
-	.reg_dma_count = 1,
-	.dma_cfg = &sm8450_regdma,
 	.perf = &sm8450_perf_data,
 	.mdss_irqs = BIT(MDP_SSPP_TOP0_INTR) | \
 		     BIT(MDP_SSPP_TOP0_INTR2) | \
diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_0_sm8550.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_0_sm8550.h
index d0ab351b6a8b9..be2f37728aa0c 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_0_sm8550.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_0_sm8550.h
@@ -224,8 +224,6 @@ const struct dpu_mdss_cfg dpu_sm8550_cfg = {
 	.intf = sm8550_intf,
 	.vbif_count = ARRAY_SIZE(sdm845_vbif),
 	.vbif = sdm845_vbif,
-	.reg_dma_count = 1,
-	.dma_cfg = &sm8450_regdma,
 	.perf = &sm8550_perf_data,
 	.mdss_irqs = BIT(MDP_SSPP_TOP0_INTR) | \
 		     BIT(MDP_SSPP_TOP0_INTR2) | \
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
index 0b604f31197bb..fc9d2c56d0e11 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
@@ -642,46 +642,6 @@ static const struct dpu_vbif_cfg sdm845_vbif[] = {
 	},
 };
 
-static const struct dpu_reg_dma_cfg sc8280xp_regdma = {
-	.base = 0x0,
-	.version = 0x00020000,
-	.trigger_sel_off = 0x119c,
-	.xin_id = 7,
-	.clk_ctrl = DPU_CLK_CTRL_REG_DMA,
-};
-
-static const struct dpu_reg_dma_cfg sdm845_regdma = {
-	.base = 0x0, .version = 0x1, .trigger_sel_off = 0x119c
-};
-
-static const struct dpu_reg_dma_cfg sm8150_regdma = {
-	.base = 0x0, .version = 0x00010001, .trigger_sel_off = 0x119c
-};
-
-static const struct dpu_reg_dma_cfg sm8250_regdma = {
-	.base = 0x0,
-	.version = 0x00010002,
-	.trigger_sel_off = 0x119c,
-	.xin_id = 7,
-	.clk_ctrl = DPU_CLK_CTRL_REG_DMA,
-};
-
-static const struct dpu_reg_dma_cfg sm8350_regdma = {
-	.base = 0x400,
-	.version = 0x00020000,
-	.trigger_sel_off = 0x119c,
-	.xin_id = 7,
-	.clk_ctrl = DPU_CLK_CTRL_REG_DMA,
-};
-
-static const struct dpu_reg_dma_cfg sm8450_regdma = {
-	.base = 0x0,
-	.version = 0x00020000,
-	.trigger_sel_off = 0x119c,
-	.xin_id = 7,
-	.clk_ctrl = DPU_CLK_CTRL_REG_DMA,
-};
-
 /*************************************************************
  * PERF data config
  *************************************************************/
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
index 71584cd56fd75..8d62c21b051a8 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
@@ -720,21 +720,6 @@ struct dpu_vbif_cfg {
 	u32 memtype_count;
 	u32 memtype[MAX_XIN_COUNT];
 };
-/**
- * struct dpu_reg_dma_cfg - information of lut dma blocks
- * @id                 enum identifying this block
- * @base               register offset of this block
- * @features           bit mask identifying sub-blocks/features
- * @version            version of lutdma hw block
- * @trigger_sel_off    offset to trigger select registers of lutdma
- */
-struct dpu_reg_dma_cfg {
-	DPU_HW_BLK_INFO;
-	u32 version;
-	u32 trigger_sel_off;
-	u32 xin_id;
-	enum dpu_clk_ctrl_type clk_ctrl;
-};
 
 /**
  * Define CDP use cases
@@ -850,9 +835,6 @@ struct dpu_mdss_cfg {
 	u32 wb_count;
 	const struct dpu_wb_cfg *wb;
 
-	u32 reg_dma_count;
-	const struct dpu_reg_dma_cfg *dma_cfg;
-
 	u32 ad_count;
 
 	u32 dspp_count;
-- 
2.40.1



