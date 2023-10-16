Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDB377CA2BE
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 10:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233018AbjJPIxw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 04:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232905AbjJPIxv (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 04:53:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B26AB
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 01:53:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7E92C433C7;
        Mon, 16 Oct 2023 08:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697446429;
        bh=YRpAhBF2FvZ0cSTiB9E/extVul1ezAlTPoDsQGSxYBQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QPHTExd/cliwmGGs40lLuBir7hravpO5hx4BwQtWXgy3jbc45AifTP7om7tjQKb5r
         nicYFto2gka4/NTEc4jNzWjknCZa6YUaLl5e7Mkmf9njvYcbwUL296nXziMS98RZNF
         f8Le64S/lrbWg/rUqdzdQDbAcvJ4vPSbDuNJcQfs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 027/131] ASoC: fsl_sai: MCLK bind with TX/RX enable bit
Date:   Mon, 16 Oct 2023 10:40:10 +0200
Message-ID: <20231016084000.740860323@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016084000.050926073@linuxfoundation.org>
References: <20231016084000.050926073@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shengjiu Wang <shengjiu.wang@nxp.com>

[ Upstream commit 3e4a826129980fed0e3e746a7822f2f204dfc24a ]

On i.MX8MP, the sai MCLK is bound with TX/RX enable bit,
which means the TX/RE enable bit need to be enabled then
MCLK can be output on PAD.

Some codec (for example: WM8962) needs the MCLK output
earlier, otherwise there will be issue for codec
configuration.

Add new soc data "mclk_with_tere" for this platform and
enable the MCLK output in startup stage.

As "mclk_with_tere" only applied to i.MX8MP, currently
The soc data is shared with i.MX8MN, so need to add
an i.MX8MN own soc data with "mclk_with_tere" disabled.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com
Link: https://lore.kernel.org/r/1683273322-2525-1-git-send-email-shengjiu.wang@nxp.com
Signed-off-by: Mark Brown <broonie@kernel.org
Stable-dep-of: 197c53c8ecb3 ("ASoC: fsl_sai: Don't disable bitclock for i.MX8MP")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/fsl/fsl_sai.c | 24 +++++++++++++++++++++---
 sound/soc/fsl/fsl_sai.h |  2 ++
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 2c17d16f842ea..08a33832f6b3f 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -1401,7 +1401,9 @@ static int fsl_sai_probe(struct platform_device *pdev)
 		sai->cpu_dai_drv.symmetric_sample_bits = 0;
 	}
 
-	if (of_property_read_bool(np, "fsl,sai-mclk-direction-output") &&
+	sai->mclk_direction_output = of_property_read_bool(np, "fsl,sai-mclk-direction-output");
+
+	if (sai->mclk_direction_output &&
 	    of_device_is_compatible(np, "fsl,imx6ul-sai")) {
 		gpr = syscon_regmap_lookup_by_compatible("fsl,imx6ul-iomuxc-gpr");
 		if (IS_ERR(gpr)) {
@@ -1442,7 +1444,7 @@ static int fsl_sai_probe(struct platform_device *pdev)
 		dev_warn(dev, "Error reading SAI version: %d\n", ret);
 
 	/* Select MCLK direction */
-	if (of_property_read_bool(np, "fsl,sai-mclk-direction-output") &&
+	if (sai->mclk_direction_output &&
 	    sai->soc_data->max_register >= FSL_SAI_MCTL) {
 		regmap_update_bits(sai->regmap, FSL_SAI_MCTL,
 				   FSL_SAI_MCTL_MCLK_EN, FSL_SAI_MCTL_MCLK_EN);
@@ -1560,6 +1562,17 @@ static const struct fsl_sai_soc_data fsl_sai_imx8mm_data = {
 	.max_register = FSL_SAI_MCTL,
 };
 
+static const struct fsl_sai_soc_data fsl_sai_imx8mn_data = {
+	.use_imx_pcm = true,
+	.use_edma = false,
+	.fifo_depth = 128,
+	.reg_offset = 8,
+	.mclk0_is_mclk1 = false,
+	.pins = 8,
+	.flags = 0,
+	.max_register = FSL_SAI_MDIV,
+};
+
 static const struct fsl_sai_soc_data fsl_sai_imx8mp_data = {
 	.use_imx_pcm = true,
 	.use_edma = false,
@@ -1569,6 +1582,7 @@ static const struct fsl_sai_soc_data fsl_sai_imx8mp_data = {
 	.pins = 8,
 	.flags = 0,
 	.max_register = FSL_SAI_MDIV,
+	.mclk_with_tere = true,
 };
 
 static const struct fsl_sai_soc_data fsl_sai_imx8ulp_data = {
@@ -1592,7 +1606,7 @@ static const struct of_device_id fsl_sai_ids[] = {
 	{ .compatible = "fsl,imx8mm-sai", .data = &fsl_sai_imx8mm_data },
 	{ .compatible = "fsl,imx8mp-sai", .data = &fsl_sai_imx8mp_data },
 	{ .compatible = "fsl,imx8ulp-sai", .data = &fsl_sai_imx8ulp_data },
-	{ .compatible = "fsl,imx8mn-sai", .data = &fsl_sai_imx8mp_data },
+	{ .compatible = "fsl,imx8mn-sai", .data = &fsl_sai_imx8mn_data },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, fsl_sai_ids);
@@ -1656,6 +1670,10 @@ static int fsl_sai_runtime_resume(struct device *dev)
 	if (ret)
 		goto disable_rx_clk;
 
+	if (sai->soc_data->mclk_with_tere && sai->mclk_direction_output)
+		regmap_update_bits(sai->regmap, FSL_SAI_TCSR(ofs),
+				   FSL_SAI_CSR_TERE, FSL_SAI_CSR_TERE);
+
 	return 0;
 
 disable_rx_clk:
diff --git a/sound/soc/fsl/fsl_sai.h b/sound/soc/fsl/fsl_sai.h
index caad5b0ac4ff4..b4d616a44023c 100644
--- a/sound/soc/fsl/fsl_sai.h
+++ b/sound/soc/fsl/fsl_sai.h
@@ -232,6 +232,7 @@ struct fsl_sai_soc_data {
 	bool use_imx_pcm;
 	bool use_edma;
 	bool mclk0_is_mclk1;
+	bool mclk_with_tere;
 	unsigned int fifo_depth;
 	unsigned int pins;
 	unsigned int reg_offset;
@@ -288,6 +289,7 @@ struct fsl_sai {
 	bool synchronous[2];
 	struct fsl_sai_dl_cfg *dl_cfg;
 	unsigned int dl_cfg_cnt;
+	bool mclk_direction_output;
 
 	unsigned int mclk_id[2];
 	unsigned int mclk_streams;
-- 
2.40.1



