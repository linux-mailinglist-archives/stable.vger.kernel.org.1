Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDA44735230
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbjFSKcO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbjFSKcH (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:32:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 662DFCD
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:32:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 01E2160B58
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:32:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A32FC433C0;
        Mon, 19 Jun 2023 10:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687170724;
        bh=rjphmveVVDBW/9tQdQ/djMSipoj0l/D+o5wS52LQsic=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iMprirlxpbaBHHSN+n/SKRJdQnheMGVMCv5Y22spQjXprkKwvPyOPCIESsweZE/RV
         hJ74PwlusVQk+G6PU6mXuCY6DcPVbeO2C6SqEj5PHCB2CS2lRihlCVpRBT4xEeHoON
         dVQ6zev4NmYmeyL0zjafIhBvcetofy8HCQueF/Hw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Parikshit Pareek <quic_ppareek@quicinc.com>,
        Luca Weiss <luca.weiss@fairphone.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        Steev Klimaszewski <steev@kali.org>,
        Andrew Halaney <ahalaney@redhat.com>
Subject: [PATCH 6.3 005/187] qcom: llcc/edac: Fix the base address used for accessing LLCC banks
Date:   Mon, 19 Jun 2023 12:27:03 +0200
Message-ID: <20230619102157.875675863@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102157.579823843@linuxfoundation.org>
References: <20230619102157.579823843@linuxfoundation.org>
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

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

[ Upstream commit ee13b5008707948d3052c1b5aab485c6cd53658e ]

The Qualcomm LLCC/EDAC drivers were using a fixed register stride for
accessing the (Control and Status Registers) CSRs of each LLCC bank.
This stride only works for some SoCs like SDM845 for which driver
support was initially added.

But the later SoCs use different register stride that vary between the
banks with holes in-between. So it is not possible to use a single register
stride for accessing the CSRs of each bank. By doing so could result in a
crash.

For fixing this issue, let's obtain the base address of each LLCC bank from
devicetree and get rid of the fixed stride. This also means, there is no
need to rely on reg-names property and the base addresses can be obtained
using the index.

First index is LLCC bank 0 and last index is LLCC broadcast. If the SoC
supports more than one bank, then those need to be defined in devicetree
for index from 1..N-1.

Reported-by: Parikshit Pareek <quic_ppareek@quicinc.com>
Tested-by: Luca Weiss <luca.weiss@fairphone.com>
Tested-by: Steev Klimaszewski <steev@kali.org> # Thinkpad X13s
Tested-by: Andrew Halaney <ahalaney@redhat.com> # sa8540p-ride
Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Link: https://lore.kernel.org/r/20230314080443.64635-13-manivannan.sadhasivam@linaro.org
Stable-dep-of: cbd77119b635 ("EDAC/qcom: Get rid of hardcoded register offsets")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/edac/qcom_edac.c           | 14 +++---
 drivers/soc/qcom/llcc-qcom.c       | 72 +++++++++++++++++-------------
 include/linux/soc/qcom/llcc-qcom.h |  6 +--
 3 files changed, 48 insertions(+), 44 deletions(-)

diff --git a/drivers/edac/qcom_edac.c b/drivers/edac/qcom_edac.c
index a7158b570ddd0..265e0fb39bc7d 100644
--- a/drivers/edac/qcom_edac.c
+++ b/drivers/edac/qcom_edac.c
@@ -215,7 +215,7 @@ dump_syn_reg_values(struct llcc_drv_data *drv, u32 bank, int err_type)
 
 	for (i = 0; i < reg_data.reg_cnt; i++) {
 		synd_reg = reg_data.synd_reg + (i * 4);
-		ret = regmap_read(drv->regmap, drv->offsets[bank] + synd_reg,
+		ret = regmap_read(drv->regmaps[bank], synd_reg,
 				  &synd_val);
 		if (ret)
 			goto clear;
@@ -224,8 +224,7 @@ dump_syn_reg_values(struct llcc_drv_data *drv, u32 bank, int err_type)
 			    reg_data.name, i, synd_val);
 	}
 
-	ret = regmap_read(drv->regmap,
-			  drv->offsets[bank] + reg_data.count_status_reg,
+	ret = regmap_read(drv->regmaps[bank], reg_data.count_status_reg,
 			  &err_cnt);
 	if (ret)
 		goto clear;
@@ -235,8 +234,7 @@ dump_syn_reg_values(struct llcc_drv_data *drv, u32 bank, int err_type)
 	edac_printk(KERN_CRIT, EDAC_LLCC, "%s: Error count: 0x%4x\n",
 		    reg_data.name, err_cnt);
 
-	ret = regmap_read(drv->regmap,
-			  drv->offsets[bank] + reg_data.ways_status_reg,
+	ret = regmap_read(drv->regmaps[bank], reg_data.ways_status_reg,
 			  &err_ways);
 	if (ret)
 		goto clear;
@@ -297,8 +295,7 @@ static irqreturn_t llcc_ecc_irq_handler(int irq, void *edev_ctl)
 
 	/* Iterate over the banks and look for Tag RAM or Data RAM errors */
 	for (i = 0; i < drv->num_banks; i++) {
-		ret = regmap_read(drv->regmap,
-				  drv->offsets[i] + DRP_INTERRUPT_STATUS,
+		ret = regmap_read(drv->regmaps[i], DRP_INTERRUPT_STATUS,
 				  &drp_error);
 
 		if (!ret && (drp_error & SB_ECC_ERROR)) {
@@ -313,8 +310,7 @@ static irqreturn_t llcc_ecc_irq_handler(int irq, void *edev_ctl)
 		if (!ret)
 			irq_rc = IRQ_HANDLED;
 
-		ret = regmap_read(drv->regmap,
-				  drv->offsets[i] + TRP_INTERRUPT_0_STATUS,
+		ret = regmap_read(drv->regmaps[i], TRP_INTERRUPT_0_STATUS,
 				  &trp_error);
 
 		if (!ret && (trp_error & SB_ECC_ERROR)) {
diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
index d4d3eced52f35..8298decc518e3 100644
--- a/drivers/soc/qcom/llcc-qcom.c
+++ b/drivers/soc/qcom/llcc-qcom.c
@@ -62,8 +62,6 @@
 #define LLCC_TRP_WRSC_CACHEABLE_EN    0x21f2c
 #define LLCC_TRP_ALGO_CFG8	      0x21f30
 
-#define BANK_OFFSET_STRIDE	      0x80000
-
 #define LLCC_VERSION_2_0_0_0          0x02000000
 #define LLCC_VERSION_2_1_0_0          0x02010000
 #define LLCC_VERSION_4_1_0_0          0x04010000
@@ -900,8 +898,8 @@ static int qcom_llcc_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static struct regmap *qcom_llcc_init_mmio(struct platform_device *pdev,
-		const char *name)
+static struct regmap *qcom_llcc_init_mmio(struct platform_device *pdev, u8 index,
+					  const char *name)
 {
 	void __iomem *base;
 	struct regmap_config llcc_regmap_config = {
@@ -911,7 +909,7 @@ static struct regmap *qcom_llcc_init_mmio(struct platform_device *pdev,
 		.fast_io = true,
 	};
 
-	base = devm_platform_ioremap_resource_byname(pdev, name);
+	base = devm_platform_ioremap_resource(pdev, index);
 	if (IS_ERR(base))
 		return ERR_CAST(base);
 
@@ -929,6 +927,7 @@ static int qcom_llcc_probe(struct platform_device *pdev)
 	const struct llcc_slice_config *llcc_cfg;
 	u32 sz;
 	u32 version;
+	struct regmap *regmap;
 
 	drv_data = devm_kzalloc(dev, sizeof(*drv_data), GFP_KERNEL);
 	if (!drv_data) {
@@ -936,21 +935,51 @@ static int qcom_llcc_probe(struct platform_device *pdev)
 		goto err;
 	}
 
-	drv_data->regmap = qcom_llcc_init_mmio(pdev, "llcc_base");
-	if (IS_ERR(drv_data->regmap)) {
-		ret = PTR_ERR(drv_data->regmap);
+	/* Initialize the first LLCC bank regmap */
+	regmap = qcom_llcc_init_mmio(pdev, 0, "llcc0_base");
+	if (IS_ERR(regmap)) {
+		ret = PTR_ERR(regmap);
 		goto err;
 	}
 
-	drv_data->bcast_regmap =
-		qcom_llcc_init_mmio(pdev, "llcc_broadcast_base");
+	cfg = of_device_get_match_data(&pdev->dev);
+
+	ret = regmap_read(regmap, cfg->reg_offset[LLCC_COMMON_STATUS0], &num_banks);
+	if (ret)
+		goto err;
+
+	num_banks &= LLCC_LB_CNT_MASK;
+	num_banks >>= LLCC_LB_CNT_SHIFT;
+	drv_data->num_banks = num_banks;
+
+	drv_data->regmaps = devm_kcalloc(dev, num_banks, sizeof(*drv_data->regmaps), GFP_KERNEL);
+	if (!drv_data->regmaps) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	drv_data->regmaps[0] = regmap;
+
+	/* Initialize rest of LLCC bank regmaps */
+	for (i = 1; i < num_banks; i++) {
+		char *base = kasprintf(GFP_KERNEL, "llcc%d_base", i);
+
+		drv_data->regmaps[i] = qcom_llcc_init_mmio(pdev, i, base);
+		if (IS_ERR(drv_data->regmaps[i])) {
+			ret = PTR_ERR(drv_data->regmaps[i]);
+			kfree(base);
+			goto err;
+		}
+
+		kfree(base);
+	}
+
+	drv_data->bcast_regmap = qcom_llcc_init_mmio(pdev, i, "llcc_broadcast_base");
 	if (IS_ERR(drv_data->bcast_regmap)) {
 		ret = PTR_ERR(drv_data->bcast_regmap);
 		goto err;
 	}
 
-	cfg = of_device_get_match_data(&pdev->dev);
-
 	/* Extract version of the IP */
 	ret = regmap_read(drv_data->bcast_regmap, cfg->reg_offset[LLCC_COMMON_HW_INFO],
 			  &version);
@@ -959,15 +988,6 @@ static int qcom_llcc_probe(struct platform_device *pdev)
 
 	drv_data->version = version;
 
-	ret = regmap_read(drv_data->regmap, cfg->reg_offset[LLCC_COMMON_STATUS0],
-			  &num_banks);
-	if (ret)
-		goto err;
-
-	num_banks &= LLCC_LB_CNT_MASK;
-	num_banks >>= LLCC_LB_CNT_SHIFT;
-	drv_data->num_banks = num_banks;
-
 	llcc_cfg = cfg->sct_data;
 	sz = cfg->size;
 
@@ -975,16 +995,6 @@ static int qcom_llcc_probe(struct platform_device *pdev)
 		if (llcc_cfg[i].slice_id > drv_data->max_slices)
 			drv_data->max_slices = llcc_cfg[i].slice_id;
 
-	drv_data->offsets = devm_kcalloc(dev, num_banks, sizeof(u32),
-							GFP_KERNEL);
-	if (!drv_data->offsets) {
-		ret = -ENOMEM;
-		goto err;
-	}
-
-	for (i = 0; i < num_banks; i++)
-		drv_data->offsets[i] = i * BANK_OFFSET_STRIDE;
-
 	drv_data->bitmap = devm_bitmap_zalloc(dev, drv_data->max_slices,
 					      GFP_KERNEL);
 	if (!drv_data->bitmap) {
diff --git a/include/linux/soc/qcom/llcc-qcom.h b/include/linux/soc/qcom/llcc-qcom.h
index ad1fd718169d9..423220e660262 100644
--- a/include/linux/soc/qcom/llcc-qcom.h
+++ b/include/linux/soc/qcom/llcc-qcom.h
@@ -120,7 +120,7 @@ struct llcc_edac_reg_offset {
 
 /**
  * struct llcc_drv_data - Data associated with the llcc driver
- * @regmap: regmap associated with the llcc device
+ * @regmaps: regmaps associated with the llcc device
  * @bcast_regmap: regmap associated with llcc broadcast offset
  * @cfg: pointer to the data structure for slice configuration
  * @edac_reg_offset: Offset of the LLCC EDAC registers
@@ -129,12 +129,11 @@ struct llcc_edac_reg_offset {
  * @max_slices: max slices as read from device tree
  * @num_banks: Number of llcc banks
  * @bitmap: Bit map to track the active slice ids
- * @offsets: Pointer to the bank offsets array
  * @ecc_irq: interrupt for llcc cache error detection and reporting
  * @version: Indicates the LLCC version
  */
 struct llcc_drv_data {
-	struct regmap *regmap;
+	struct regmap **regmaps;
 	struct regmap *bcast_regmap;
 	const struct llcc_slice_config *cfg;
 	const struct llcc_edac_reg_offset *edac_reg_offset;
@@ -143,7 +142,6 @@ struct llcc_drv_data {
 	u32 max_slices;
 	u32 num_banks;
 	unsigned long *bitmap;
-	u32 *offsets;
 	int ecc_irq;
 	u32 version;
 };
-- 
2.39.2



