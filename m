Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEE2D7A80C3
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236096AbjITMkc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236364AbjITMj7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:39:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72CECF9
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:39:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE5F4C433C8;
        Wed, 20 Sep 2023 12:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695213592;
        bh=mSxVKNCTgzXSCvtief7/H8oJXKwW0MyMNuIeaZUt+08=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=goT5ZxX9PYS9vsumpvN2gjJTrarBtfLeOQar3owlt646kq2b6Z9h7rlUSCmLtLg0X
         C1zQbsEoCaSySu93ym7YnmSqoBqwxnEuNVG23N0qmmIT77bbzLAEioYW5MXBeGZiGF
         q+Kl3gfQFnQajldMCSbE/9SJwKpobIPP4KsGOZIM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Anson Huang <Anson.Huang@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 293/367] clk: imx8mm: Move 1443X/1416X PLL clock structure to common place
Date:   Wed, 20 Sep 2023 13:31:10 +0200
Message-ID: <20230920112906.136955593@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112858.471730572@linuxfoundation.org>
References: <20230920112858.471730572@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Anson Huang <Anson.Huang@nxp.com>

[ Upstream commit 43cdaa1567ad3931fbde438853947d45238cc040 ]

Many i.MX8M SoCs use same 1443X/1416X PLL, such as i.MX8MM,
i.MX8MN and later i.MX8M SoCs, moving these PLL definitions
to pll14xx driver can save a lot of duplicated code on each
platform.

Meanwhile, no need to define PLL clock structure for every
module which uses same type of PLL, e.g., audio/video/dram use
1443X PLL, arm/gpu/vpu/sys use 1416X PLL, define 2 PLL clock
structure for each group is enough.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Reviewed-by: Leonard Crestez <leonard.crestez@nxp.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Stable-dep-of: 72d00e560d10 ("clk: imx: pll14xx: dynamically configure PLL for 393216000/361267200Hz")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/imx/clk-imx8mm.c  | 87 ++++-------------------------------
 drivers/clk/imx/clk-pll14xx.c | 30 ++++++++++++
 drivers/clk/imx/clk.h         |  3 ++
 3 files changed, 43 insertions(+), 77 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8mm.c b/drivers/clk/imx/clk-imx8mm.c
index 172589e94f60e..ec34c52416369 100644
--- a/drivers/clk/imx/clk-imx8mm.c
+++ b/drivers/clk/imx/clk-imx8mm.c
@@ -26,73 +26,6 @@ static u32 share_count_disp;
 static u32 share_count_pdm;
 static u32 share_count_nand;
 
-static const struct imx_pll14xx_rate_table imx8mm_pll1416x_tbl[] = {
-	PLL_1416X_RATE(1800000000U, 225, 3, 0),
-	PLL_1416X_RATE(1600000000U, 200, 3, 0),
-	PLL_1416X_RATE(1200000000U, 300, 3, 1),
-	PLL_1416X_RATE(1000000000U, 250, 3, 1),
-	PLL_1416X_RATE(800000000U,  200, 3, 1),
-	PLL_1416X_RATE(750000000U,  250, 2, 2),
-	PLL_1416X_RATE(700000000U,  350, 3, 2),
-	PLL_1416X_RATE(600000000U,  300, 3, 2),
-};
-
-static const struct imx_pll14xx_rate_table imx8mm_audiopll_tbl[] = {
-	PLL_1443X_RATE(393216000U, 262, 2, 3, 9437),
-	PLL_1443X_RATE(361267200U, 361, 3, 3, 17511),
-};
-
-static const struct imx_pll14xx_rate_table imx8mm_videopll_tbl[] = {
-	PLL_1443X_RATE(650000000U, 325, 3, 2, 0),
-	PLL_1443X_RATE(594000000U, 198, 2, 2, 0),
-};
-
-static const struct imx_pll14xx_rate_table imx8mm_drampll_tbl[] = {
-	PLL_1443X_RATE(650000000U, 325, 3, 2, 0),
-};
-
-static struct imx_pll14xx_clk imx8mm_audio_pll = {
-		.type = PLL_1443X,
-		.rate_table = imx8mm_audiopll_tbl,
-		.rate_count = ARRAY_SIZE(imx8mm_audiopll_tbl),
-};
-
-static struct imx_pll14xx_clk imx8mm_video_pll = {
-		.type = PLL_1443X,
-		.rate_table = imx8mm_videopll_tbl,
-		.rate_count = ARRAY_SIZE(imx8mm_videopll_tbl),
-};
-
-static struct imx_pll14xx_clk imx8mm_dram_pll = {
-		.type = PLL_1443X,
-		.rate_table = imx8mm_drampll_tbl,
-		.rate_count = ARRAY_SIZE(imx8mm_drampll_tbl),
-};
-
-static struct imx_pll14xx_clk imx8mm_arm_pll = {
-		.type = PLL_1416X,
-		.rate_table = imx8mm_pll1416x_tbl,
-		.rate_count = ARRAY_SIZE(imx8mm_pll1416x_tbl),
-};
-
-static struct imx_pll14xx_clk imx8mm_gpu_pll = {
-		.type = PLL_1416X,
-		.rate_table = imx8mm_pll1416x_tbl,
-		.rate_count = ARRAY_SIZE(imx8mm_pll1416x_tbl),
-};
-
-static struct imx_pll14xx_clk imx8mm_vpu_pll = {
-		.type = PLL_1416X,
-		.rate_table = imx8mm_pll1416x_tbl,
-		.rate_count = ARRAY_SIZE(imx8mm_pll1416x_tbl),
-};
-
-static struct imx_pll14xx_clk imx8mm_sys_pll = {
-		.type = PLL_1416X,
-		.rate_table = imx8mm_pll1416x_tbl,
-		.rate_count = ARRAY_SIZE(imx8mm_pll1416x_tbl),
-};
-
 static const char *pll_ref_sels[] = { "osc_24m", "dummy", "dummy", "dummy", };
 static const char *audio_pll1_bypass_sels[] = {"audio_pll1", "audio_pll1_ref_sel", };
 static const char *audio_pll2_bypass_sels[] = {"audio_pll2", "audio_pll2_ref_sel", };
@@ -396,16 +329,16 @@ static int imx8mm_clocks_probe(struct platform_device *pdev)
 	clks[IMX8MM_SYS_PLL2_REF_SEL] = imx_clk_mux("sys_pll2_ref_sel", base + 0x104, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
 	clks[IMX8MM_SYS_PLL3_REF_SEL] = imx_clk_mux("sys_pll3_ref_sel", base + 0x114, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
 
-	clks[IMX8MM_AUDIO_PLL1] = imx_clk_pll14xx("audio_pll1", "audio_pll1_ref_sel", base, &imx8mm_audio_pll);
-	clks[IMX8MM_AUDIO_PLL2] = imx_clk_pll14xx("audio_pll2", "audio_pll2_ref_sel", base + 0x14, &imx8mm_audio_pll);
-	clks[IMX8MM_VIDEO_PLL1] = imx_clk_pll14xx("video_pll1", "video_pll1_ref_sel", base + 0x28, &imx8mm_video_pll);
-	clks[IMX8MM_DRAM_PLL] = imx_clk_pll14xx("dram_pll", "dram_pll_ref_sel", base + 0x50, &imx8mm_dram_pll);
-	clks[IMX8MM_GPU_PLL] = imx_clk_pll14xx("gpu_pll", "gpu_pll_ref_sel", base + 0x64, &imx8mm_gpu_pll);
-	clks[IMX8MM_VPU_PLL] = imx_clk_pll14xx("vpu_pll", "vpu_pll_ref_sel", base + 0x74, &imx8mm_vpu_pll);
-	clks[IMX8MM_ARM_PLL] = imx_clk_pll14xx("arm_pll", "arm_pll_ref_sel", base + 0x84, &imx8mm_arm_pll);
-	clks[IMX8MM_SYS_PLL1] = imx_clk_pll14xx("sys_pll1", "sys_pll1_ref_sel", base + 0x94, &imx8mm_sys_pll);
-	clks[IMX8MM_SYS_PLL2] = imx_clk_pll14xx("sys_pll2", "sys_pll2_ref_sel", base + 0x104, &imx8mm_sys_pll);
-	clks[IMX8MM_SYS_PLL3] = imx_clk_pll14xx("sys_pll3", "sys_pll3_ref_sel", base + 0x114, &imx8mm_sys_pll);
+	clks[IMX8MM_AUDIO_PLL1] = imx_clk_pll14xx("audio_pll1", "audio_pll1_ref_sel", base, &imx_1443x_pll);
+	clks[IMX8MM_AUDIO_PLL2] = imx_clk_pll14xx("audio_pll2", "audio_pll2_ref_sel", base + 0x14, &imx_1443x_pll);
+	clks[IMX8MM_VIDEO_PLL1] = imx_clk_pll14xx("video_pll1", "video_pll1_ref_sel", base + 0x28, &imx_1443x_pll);
+	clks[IMX8MM_DRAM_PLL] = imx_clk_pll14xx("dram_pll", "dram_pll_ref_sel", base + 0x50, &imx_1443x_pll);
+	clks[IMX8MM_GPU_PLL] = imx_clk_pll14xx("gpu_pll", "gpu_pll_ref_sel", base + 0x64, &imx_1416x_pll);
+	clks[IMX8MM_VPU_PLL] = imx_clk_pll14xx("vpu_pll", "vpu_pll_ref_sel", base + 0x74, &imx_1416x_pll);
+	clks[IMX8MM_ARM_PLL] = imx_clk_pll14xx("arm_pll", "arm_pll_ref_sel", base + 0x84, &imx_1416x_pll);
+	clks[IMX8MM_SYS_PLL1] = imx_clk_pll14xx("sys_pll1", "sys_pll1_ref_sel", base + 0x94, &imx_1416x_pll);
+	clks[IMX8MM_SYS_PLL2] = imx_clk_pll14xx("sys_pll2", "sys_pll2_ref_sel", base + 0x104, &imx_1416x_pll);
+	clks[IMX8MM_SYS_PLL3] = imx_clk_pll14xx("sys_pll3", "sys_pll3_ref_sel", base + 0x114, &imx_1416x_pll);
 
 	/* PLL bypass out */
 	clks[IMX8MM_AUDIO_PLL1_BYPASS] = imx_clk_mux_flags("audio_pll1_bypass", base, 16, 1, audio_pll1_bypass_sels, ARRAY_SIZE(audio_pll1_bypass_sels), CLK_SET_RATE_PARENT);
diff --git a/drivers/clk/imx/clk-pll14xx.c b/drivers/clk/imx/clk-pll14xx.c
index 047f1d8fe323f..c43e9653b4156 100644
--- a/drivers/clk/imx/clk-pll14xx.c
+++ b/drivers/clk/imx/clk-pll14xx.c
@@ -41,6 +41,36 @@ struct clk_pll14xx {
 
 #define to_clk_pll14xx(_hw) container_of(_hw, struct clk_pll14xx, hw)
 
+const struct imx_pll14xx_rate_table imx_pll1416x_tbl[] = {
+	PLL_1416X_RATE(1800000000U, 225, 3, 0),
+	PLL_1416X_RATE(1600000000U, 200, 3, 0),
+	PLL_1416X_RATE(1200000000U, 300, 3, 1),
+	PLL_1416X_RATE(1000000000U, 250, 3, 1),
+	PLL_1416X_RATE(800000000U,  200, 3, 1),
+	PLL_1416X_RATE(750000000U,  250, 2, 2),
+	PLL_1416X_RATE(700000000U,  350, 3, 2),
+	PLL_1416X_RATE(600000000U,  300, 3, 2),
+};
+
+const struct imx_pll14xx_rate_table imx_pll1443x_tbl[] = {
+	PLL_1443X_RATE(650000000U, 325, 3, 2, 0),
+	PLL_1443X_RATE(594000000U, 198, 2, 2, 0),
+	PLL_1443X_RATE(393216000U, 262, 2, 3, 9437),
+	PLL_1443X_RATE(361267200U, 361, 3, 3, 17511),
+};
+
+struct imx_pll14xx_clk imx_1443x_pll = {
+	.type = PLL_1443X,
+	.rate_table = imx_pll1443x_tbl,
+	.rate_count = ARRAY_SIZE(imx_pll1443x_tbl),
+};
+
+struct imx_pll14xx_clk imx_1416x_pll = {
+	.type = PLL_1416X,
+	.rate_table = imx_pll1416x_tbl,
+	.rate_count = ARRAY_SIZE(imx_pll1416x_tbl),
+};
+
 static const struct imx_pll14xx_rate_table *imx_get_pll_settings(
 		struct clk_pll14xx *pll, unsigned long rate)
 {
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index 6fe64ff8ffa12..30ddbc1ced2ee 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -50,6 +50,9 @@ struct imx_pll14xx_clk {
 	int flags;
 };
 
+extern struct imx_pll14xx_clk imx_1416x_pll;
+extern struct imx_pll14xx_clk imx_1443x_pll;
+
 #define imx_clk_cpu(name, parent_name, div, mux, pll, step) \
 	to_clk(imx_clk_hw_cpu(name, parent_name, div, mux, pll, step))
 
-- 
2.40.1



