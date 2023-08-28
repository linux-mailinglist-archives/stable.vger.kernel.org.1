Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2288C78AC83
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231722AbjH1Kkg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231536AbjH1KkQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:40:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B510493
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:40:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C7656402B
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:40:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CF0DC433C8;
        Mon, 28 Aug 2023 10:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693219212;
        bh=S8T13xVrvB2f0FTKHsL/fIxgFkOmmsivTI2WlkJ4XRk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RtvtTyowhFBA2u7x5WhcztTMDcWJNxcDpDpDWd+nOV1DZNofvZWI4HMtvbGLwSXy3
         KdzzNPl+koH6XWpYYne43rtagz7hsIG2OfStWo6O52CzVupQv17ugBGcaMtp99luEJ
         uzu9BzeHcM9h+DKQ44z26tf6Cu4uCW0MWfOjW+iA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Shengjiu Wang <shengjiu.wang@nxp.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 114/158] ASoC: fsl_sai: Add new added registers and new bit definition
Date:   Mon, 28 Aug 2023 12:13:31 +0200
Message-ID: <20230828101201.159383895@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101157.322319621@linuxfoundation.org>
References: <20230828101157.322319621@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shengjiu Wang <shengjiu.wang@nxp.com>

[ Upstream commit 0b2cbce6898600aae5e87285f1c2000162d59c76 ]

On i.MX8MQ/i.MX8MN/i.MX8MM platform, the sai IP is upgraded.
There are some new registers and new bit definition. This
patch is to complete the register list.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
Link: https://lore.kernel.org/r/1600323079-5317-2-git-send-email-shengjiu.wang@nxp.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: 269f399dc19f ("ASoC: fsl_sai: Disable bit clock with transmitter")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/fsl/fsl_sai.c | 23 ++++++++++++++++
 sound/soc/fsl/fsl_sai.h | 59 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 82 insertions(+)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 23f0b5ee000c3..ebca0778d3f57 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -810,6 +810,8 @@ static struct reg_default fsl_sai_reg_defaults_ofs8[] = {
 	{FSL_SAI_RCR4(8), 0},
 	{FSL_SAI_RCR5(8), 0},
 	{FSL_SAI_RMR, 0},
+	{FSL_SAI_MCTL, 0},
+	{FSL_SAI_MDIV, 0},
 };
 
 static bool fsl_sai_readable_reg(struct device *dev, unsigned int reg)
@@ -850,6 +852,18 @@ static bool fsl_sai_readable_reg(struct device *dev, unsigned int reg)
 	case FSL_SAI_RFR6:
 	case FSL_SAI_RFR7:
 	case FSL_SAI_RMR:
+	case FSL_SAI_MCTL:
+	case FSL_SAI_MDIV:
+	case FSL_SAI_VERID:
+	case FSL_SAI_PARAM:
+	case FSL_SAI_TTCTN:
+	case FSL_SAI_RTCTN:
+	case FSL_SAI_TTCTL:
+	case FSL_SAI_TBCTN:
+	case FSL_SAI_TTCAP:
+	case FSL_SAI_RTCTL:
+	case FSL_SAI_RBCTN:
+	case FSL_SAI_RTCAP:
 		return true;
 	default:
 		return false;
@@ -864,6 +878,10 @@ static bool fsl_sai_volatile_reg(struct device *dev, unsigned int reg)
 	if (reg == FSL_SAI_TCSR(ofs) || reg == FSL_SAI_RCSR(ofs))
 		return true;
 
+	/* Set VERID and PARAM be volatile for reading value in probe */
+	if (ofs == 8 && (reg == FSL_SAI_VERID || reg == FSL_SAI_PARAM))
+		return true;
+
 	switch (reg) {
 	case FSL_SAI_TFR0:
 	case FSL_SAI_TFR1:
@@ -917,6 +935,10 @@ static bool fsl_sai_writeable_reg(struct device *dev, unsigned int reg)
 	case FSL_SAI_TDR7:
 	case FSL_SAI_TMR:
 	case FSL_SAI_RMR:
+	case FSL_SAI_MCTL:
+	case FSL_SAI_MDIV:
+	case FSL_SAI_TTCTL:
+	case FSL_SAI_RTCTL:
 		return true;
 	default:
 		return false;
@@ -965,6 +987,7 @@ static int fsl_sai_probe(struct platform_device *pdev)
 
 	if (sai->soc_data->reg_offset == 8) {
 		fsl_sai_regmap_config.reg_defaults = fsl_sai_reg_defaults_ofs8;
+		fsl_sai_regmap_config.max_register = FSL_SAI_MDIV;
 		fsl_sai_regmap_config.num_reg_defaults =
 			ARRAY_SIZE(fsl_sai_reg_defaults_ofs8);
 	}
diff --git a/sound/soc/fsl/fsl_sai.h b/sound/soc/fsl/fsl_sai.h
index afaef20272342..156ee28077b76 100644
--- a/sound/soc/fsl/fsl_sai.h
+++ b/sound/soc/fsl/fsl_sai.h
@@ -14,6 +14,8 @@
 			 SNDRV_PCM_FMTBIT_S32_LE)
 
 /* SAI Register Map Register */
+#define FSL_SAI_VERID	0x00 /* SAI Version ID Register */
+#define FSL_SAI_PARAM	0x04 /* SAI Parameter Register */
 #define FSL_SAI_TCSR(ofs)	(0x00 + ofs) /* SAI Transmit Control */
 #define FSL_SAI_TCR1(ofs)	(0x04 + ofs) /* SAI Transmit Configuration 1 */
 #define FSL_SAI_TCR2(ofs)	(0x08 + ofs) /* SAI Transmit Configuration 2 */
@@ -37,6 +39,10 @@
 #define FSL_SAI_TFR6	0x58 /* SAI Transmit FIFO 6 */
 #define FSL_SAI_TFR7	0x5C /* SAI Transmit FIFO 7 */
 #define FSL_SAI_TMR	0x60 /* SAI Transmit Mask */
+#define FSL_SAI_TTCTL	0x70 /* SAI Transmit Timestamp Control Register */
+#define FSL_SAI_TTCTN	0x74 /* SAI Transmit Timestamp Counter Register */
+#define FSL_SAI_TBCTN	0x78 /* SAI Transmit Bit Counter Register */
+#define FSL_SAI_TTCAP	0x7C /* SAI Transmit Timestamp Capture */
 #define FSL_SAI_RCSR(ofs)	(0x80 + ofs) /* SAI Receive Control */
 #define FSL_SAI_RCR1(ofs)	(0x84 + ofs)/* SAI Receive Configuration 1 */
 #define FSL_SAI_RCR2(ofs)	(0x88 + ofs) /* SAI Receive Configuration 2 */
@@ -60,6 +66,13 @@
 #define FSL_SAI_RFR6	0xd8 /* SAI Receive FIFO 6 */
 #define FSL_SAI_RFR7	0xdc /* SAI Receive FIFO 7 */
 #define FSL_SAI_RMR	0xe0 /* SAI Receive Mask */
+#define FSL_SAI_RTCTL	0xf0 /* SAI Receive Timestamp Control Register */
+#define FSL_SAI_RTCTN	0xf4 /* SAI Receive Timestamp Counter Register */
+#define FSL_SAI_RBCTN	0xf8 /* SAI Receive Bit Counter Register */
+#define FSL_SAI_RTCAP	0xfc /* SAI Receive Timestamp Capture */
+
+#define FSL_SAI_MCTL	0x100 /* SAI MCLK Control Register */
+#define FSL_SAI_MDIV	0x104 /* SAI MCLK Divide Register */
 
 #define FSL_SAI_xCSR(tx, ofs)	(tx ? FSL_SAI_TCSR(ofs) : FSL_SAI_RCSR(ofs))
 #define FSL_SAI_xCR1(tx, ofs)	(tx ? FSL_SAI_TCR1(ofs) : FSL_SAI_RCR1(ofs))
@@ -73,6 +86,7 @@
 
 /* SAI Transmit/Receive Control Register */
 #define FSL_SAI_CSR_TERE	BIT(31)
+#define FSL_SAI_CSR_SE		BIT(30)
 #define FSL_SAI_CSR_FR		BIT(25)
 #define FSL_SAI_CSR_SR		BIT(24)
 #define FSL_SAI_CSR_xF_SHIFT	16
@@ -106,6 +120,7 @@
 #define FSL_SAI_CR2_MSEL(ID)	((ID) << 26)
 #define FSL_SAI_CR2_BCP		BIT(25)
 #define FSL_SAI_CR2_BCD_MSTR	BIT(24)
+#define FSL_SAI_CR2_BYP		BIT(23) /* BCLK bypass */
 #define FSL_SAI_CR2_DIV_MASK	0xff
 
 /* SAI Transmit and Receive Configuration 3 Register */
@@ -115,6 +130,13 @@
 #define FSL_SAI_CR3_WDFL_MASK	0x1f
 
 /* SAI Transmit and Receive Configuration 4 Register */
+
+#define FSL_SAI_CR4_FCONT	BIT(28)
+#define FSL_SAI_CR4_FCOMB_SHIFT BIT(26)
+#define FSL_SAI_CR4_FCOMB_SOFT  BIT(27)
+#define FSL_SAI_CR4_FCOMB_MASK  (0x3 << 26)
+#define FSL_SAI_CR4_FPACK_8     (0x2 << 24)
+#define FSL_SAI_CR4_FPACK_16    (0x3 << 24)
 #define FSL_SAI_CR4_FRSZ(x)	(((x) - 1) << 16)
 #define FSL_SAI_CR4_FRSZ_MASK	(0x1f << 16)
 #define FSL_SAI_CR4_SYWD(x)	(((x) - 1) << 8)
@@ -132,6 +154,43 @@
 #define FSL_SAI_CR5_FBT(x)	((x) << 8)
 #define FSL_SAI_CR5_FBT_MASK	(0x1f << 8)
 
+/* SAI MCLK Control Register */
+#define FSL_SAI_MCTL_MCLK_EN	BIT(30)	/* MCLK Enable */
+#define FSL_SAI_MCTL_MSEL_MASK	(0x3 << 24)
+#define FSL_SAI_MCTL_MSEL(ID)   ((ID) << 24)
+#define FSL_SAI_MCTL_MSEL_BUS	0
+#define FSL_SAI_MCTL_MSEL_MCLK1	BIT(24)
+#define FSL_SAI_MCTL_MSEL_MCLK2	BIT(25)
+#define FSL_SAI_MCTL_MSEL_MCLK3	(BIT(24) | BIT(25))
+#define FSL_SAI_MCTL_DIV_EN	BIT(23)
+#define FSL_SAI_MCTL_DIV_MASK	0xFF
+
+/* SAI VERID Register */
+#define FSL_SAI_VERID_MAJOR_SHIFT   24
+#define FSL_SAI_VERID_MAJOR_MASK    GENMASK(31, 24)
+#define FSL_SAI_VERID_MINOR_SHIFT   16
+#define FSL_SAI_VERID_MINOR_MASK    GENMASK(23, 16)
+#define FSL_SAI_VERID_FEATURE_SHIFT 0
+#define FSL_SAI_VERID_FEATURE_MASK  GENMASK(15, 0)
+#define FSL_SAI_VERID_EFIFO_EN	    BIT(0)
+#define FSL_SAI_VERID_TSTMP_EN	    BIT(1)
+
+/* SAI PARAM Register */
+#define FSL_SAI_PARAM_SPF_SHIFT	    16
+#define FSL_SAI_PARAM_SPF_MASK	    GENMASK(19, 16)
+#define FSL_SAI_PARAM_WPF_SHIFT	    8
+#define FSL_SAI_PARAM_WPF_MASK	    GENMASK(11, 8)
+#define FSL_SAI_PARAM_DLN_MASK	    GENMASK(3, 0)
+
+/* SAI MCLK Divide Register */
+#define FSL_SAI_MDIV_MASK	    0xFFFFF
+
+/* SAI timestamp and bitcounter */
+#define FSL_SAI_xTCTL_TSEN         BIT(0)
+#define FSL_SAI_xTCTL_TSINC        BIT(1)
+#define FSL_SAI_xTCTL_RTSC         BIT(8)
+#define FSL_SAI_xTCTL_RBC          BIT(9)
+
 /* SAI type */
 #define FSL_SAI_DMA		BIT(0)
 #define FSL_SAI_USE_AC97	BIT(1)
-- 
2.40.1



