Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8DA7CA2BB
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 10:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232831AbjJPIxq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 04:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232905AbjJPIxo (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 04:53:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 804B5E5
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 01:53:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4EFDC433C8;
        Mon, 16 Oct 2023 08:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697446422;
        bh=orytIJYUn33n3LDOuOIkdU7JEZMA/oTFmTT+48uVgYc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UYdCi+nNI6K0dY/x7/pizTzMNJdKdvk1xImjT+fM3o4WQ++oI2rPvYvEq0ZxQmVq5
         nFqE4/Rt1/0m9fLydVgigTajHcV8n0fGMDOagksRgPl1pLyuMvgREuLd7ROXZH3Lfu
         f7ToB5uKYZZEaHCG9yKeSUEqBInXtZkyBmbLUctg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Rob Herring <robh@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 026/131] ASoC: Use of_property_read_bool() for boolean properties
Date:   Mon, 16 Oct 2023 10:40:09 +0200
Message-ID: <20231016084000.716672842@linuxfoundation.org>
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

From: Rob Herring <robh@kernel.org>

[ Upstream commit 2d2998b84330899bf88a0414f3356869be4a69eb ]

It is preferred to use typed property access functions (i.e.
of_property_read_<type> functions) rather than low-level
of_get_property/of_find_property functions for reading properties.
Convert reading boolean properties to to of_property_read_bool().

Signed-off-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/20230310144733.1546413-1-robh@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: 197c53c8ecb3 ("ASoC: fsl_sai: Don't disable bitclock for i.MX8MP")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/sta32x.c  | 39 +++++++++++------------
 sound/soc/codecs/sta350.c  | 63 +++++++++++++++++---------------------
 sound/soc/codecs/tas5086.c |  2 +-
 sound/soc/fsl/fsl_sai.c    | 12 ++++----
 sound/soc/fsl/fsl_ssi.c    |  2 +-
 sound/soc/fsl/imx-card.c   |  2 +-
 sound/soc/sh/rcar/ssi.c    |  4 +--
 7 files changed, 57 insertions(+), 67 deletions(-)

diff --git a/sound/soc/codecs/sta32x.c b/sound/soc/codecs/sta32x.c
index 8c86b578eba83..29af9595dac19 100644
--- a/sound/soc/codecs/sta32x.c
+++ b/sound/soc/codecs/sta32x.c
@@ -1054,35 +1054,32 @@ static int sta32x_probe_dt(struct device *dev, struct sta32x_priv *sta32x)
 	of_property_read_u8(np, "st,ch3-output-mapping",
 			    &pdata->ch3_output_mapping);
 
-	if (of_get_property(np, "st,fault-detect-recovery", NULL))
-		pdata->fault_detect_recovery = 1;
-	if (of_get_property(np, "st,thermal-warning-recovery", NULL))
-		pdata->thermal_warning_recovery = 1;
-	if (of_get_property(np, "st,thermal-warning-adjustment", NULL))
-		pdata->thermal_warning_adjustment = 1;
-	if (of_get_property(np, "st,needs_esd_watchdog", NULL))
-		pdata->needs_esd_watchdog = 1;
+	pdata->fault_detect_recovery =
+		of_property_read_bool(np, "st,fault-detect-recovery");
+	pdata->thermal_warning_recovery =
+		of_property_read_bool(np, "st,thermal-warning-recovery");
+	pdata->thermal_warning_adjustment =
+		of_property_read_bool(np, "st,thermal-warning-adjustment");
+	pdata->needs_esd_watchdog =
+		of_property_read_bool(np, "st,needs_esd_watchdog");
 
 	tmp = 140;
 	of_property_read_u16(np, "st,drop-compensation-ns", &tmp);
 	pdata->drop_compensation_ns = clamp_t(u16, tmp, 0, 300) / 20;
 
 	/* CONFE */
-	if (of_get_property(np, "st,max-power-use-mpcc", NULL))
-		pdata->max_power_use_mpcc = 1;
-
-	if (of_get_property(np, "st,max-power-correction", NULL))
-		pdata->max_power_correction = 1;
-
-	if (of_get_property(np, "st,am-reduction-mode", NULL))
-		pdata->am_reduction_mode = 1;
-
-	if (of_get_property(np, "st,odd-pwm-speed-mode", NULL))
-		pdata->odd_pwm_speed_mode = 1;
+	pdata->max_power_use_mpcc =
+		of_property_read_bool(np, "st,max-power-use-mpcc");
+	pdata->max_power_correction =
+		of_property_read_bool(np, "st,max-power-correction");
+	pdata->am_reduction_mode =
+		of_property_read_bool(np, "st,am-reduction-mode");
+	pdata->odd_pwm_speed_mode =
+		of_property_read_bool(np, "st,odd-pwm-speed-mode");
 
 	/* CONFF */
-	if (of_get_property(np, "st,invalid-input-detect-mute", NULL))
-		pdata->invalid_input_detect_mute = 1;
+	pdata->invalid_input_detect_mute =
+		of_property_read_bool(np, "st,invalid-input-detect-mute");
 
 	sta32x->pdata = pdata;
 
diff --git a/sound/soc/codecs/sta350.c b/sound/soc/codecs/sta350.c
index 9ed13aeb3cbdc..b033a5fcd6c04 100644
--- a/sound/soc/codecs/sta350.c
+++ b/sound/soc/codecs/sta350.c
@@ -1106,12 +1106,12 @@ static int sta350_probe_dt(struct device *dev, struct sta350_priv *sta350)
 	of_property_read_u8(np, "st,ch3-output-mapping",
 			    &pdata->ch3_output_mapping);
 
-	if (of_get_property(np, "st,thermal-warning-recovery", NULL))
-		pdata->thermal_warning_recovery = 1;
-	if (of_get_property(np, "st,thermal-warning-adjustment", NULL))
-		pdata->thermal_warning_adjustment = 1;
-	if (of_get_property(np, "st,fault-detect-recovery", NULL))
-		pdata->fault_detect_recovery = 1;
+	pdata->thermal_warning_recovery =
+		of_property_read_bool(np, "st,thermal-warning-recovery");
+	pdata->thermal_warning_adjustment =
+		of_property_read_bool(np, "st,thermal-warning-adjustment");
+	pdata->fault_detect_recovery =
+		of_property_read_bool(np, "st,fault-detect-recovery");
 
 	pdata->ffx_power_output_mode = STA350_FFX_PM_VARIABLE_DROP_COMP;
 	if (!of_property_read_string(np, "st,ffx-power-output-mode",
@@ -1133,41 +1133,34 @@ static int sta350_probe_dt(struct device *dev, struct sta350_priv *sta350)
 	of_property_read_u16(np, "st,drop-compensation-ns", &tmp);
 	pdata->drop_compensation_ns = clamp_t(u16, tmp, 0, 300) / 20;
 
-	if (of_get_property(np, "st,overcurrent-warning-adjustment", NULL))
-		pdata->oc_warning_adjustment = 1;
+	pdata->oc_warning_adjustment =
+		of_property_read_bool(np, "st,overcurrent-warning-adjustment");
 
 	/* CONFE */
-	if (of_get_property(np, "st,max-power-use-mpcc", NULL))
-		pdata->max_power_use_mpcc = 1;
-
-	if (of_get_property(np, "st,max-power-correction", NULL))
-		pdata->max_power_correction = 1;
-
-	if (of_get_property(np, "st,am-reduction-mode", NULL))
-		pdata->am_reduction_mode = 1;
-
-	if (of_get_property(np, "st,odd-pwm-speed-mode", NULL))
-		pdata->odd_pwm_speed_mode = 1;
-
-	if (of_get_property(np, "st,distortion-compensation", NULL))
-		pdata->distortion_compensation = 1;
+	pdata->max_power_use_mpcc =
+		of_property_read_bool(np, "st,max-power-use-mpcc");
+	pdata->max_power_correction =
+		of_property_read_bool(np, "st,max-power-correction");
+	pdata->am_reduction_mode =
+		of_property_read_bool(np, "st,am-reduction-mode");
+	pdata->odd_pwm_speed_mode =
+		of_property_read_bool(np, "st,odd-pwm-speed-mode");
+	pdata->distortion_compensation =
+		of_property_read_bool(np, "st,distortion-compensation");
 
 	/* CONFF */
-	if (of_get_property(np, "st,invalid-input-detect-mute", NULL))
-		pdata->invalid_input_detect_mute = 1;
+	pdata->invalid_input_detect_mute =
+		of_property_read_bool(np, "st,invalid-input-detect-mute");
 
 	/* MISC */
-	if (of_get_property(np, "st,activate-mute-output", NULL))
-		pdata->activate_mute_output = 1;
-
-	if (of_get_property(np, "st,bridge-immediate-off", NULL))
-		pdata->bridge_immediate_off = 1;
-
-	if (of_get_property(np, "st,noise-shape-dc-cut", NULL))
-		pdata->noise_shape_dc_cut = 1;
-
-	if (of_get_property(np, "st,powerdown-master-volume", NULL))
-		pdata->powerdown_master_vol = 1;
+	pdata->activate_mute_output =
+		of_property_read_bool(np, "st,activate-mute-output");
+	pdata->bridge_immediate_off =
+		of_property_read_bool(np, "st,bridge-immediate-off");
+	pdata->noise_shape_dc_cut =
+		of_property_read_bool(np, "st,noise-shape-dc-cut");
+	pdata->powerdown_master_vol =
+		of_property_read_bool(np, "st,powerdown-master-volume");
 
 	if (!of_property_read_u8(np, "st,powerdown-delay-divider", &tmp8)) {
 		if (is_power_of_2(tmp8) && tmp8 >= 1 && tmp8 <= 128)
diff --git a/sound/soc/codecs/tas5086.c b/sound/soc/codecs/tas5086.c
index 22143cc5afa70..f9e7122894bd2 100644
--- a/sound/soc/codecs/tas5086.c
+++ b/sound/soc/codecs/tas5086.c
@@ -840,7 +840,7 @@ static int tas5086_probe(struct snd_soc_component *component)
 			snprintf(name, sizeof(name),
 				 "ti,mid-z-channel-%d", i + 1);
 
-			if (of_get_property(of_node, name, NULL) != NULL)
+			if (of_property_read_bool(of_node, name))
 				priv->pwm_start_mid_z |= 1 << i;
 		}
 	}
diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index b7552b0df7c3c..2c17d16f842ea 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -1381,18 +1381,18 @@ static int fsl_sai_probe(struct platform_device *pdev)
 	sai->cpu_dai_drv.symmetric_channels = 1;
 	sai->cpu_dai_drv.symmetric_sample_bits = 1;
 
-	if (of_find_property(np, "fsl,sai-synchronous-rx", NULL) &&
-	    of_find_property(np, "fsl,sai-asynchronous", NULL)) {
+	if (of_property_read_bool(np, "fsl,sai-synchronous-rx") &&
+	    of_property_read_bool(np, "fsl,sai-asynchronous")) {
 		/* error out if both synchronous and asynchronous are present */
 		dev_err(dev, "invalid binding for synchronous mode\n");
 		return -EINVAL;
 	}
 
-	if (of_find_property(np, "fsl,sai-synchronous-rx", NULL)) {
+	if (of_property_read_bool(np, "fsl,sai-synchronous-rx")) {
 		/* Sync Rx with Tx */
 		sai->synchronous[RX] = false;
 		sai->synchronous[TX] = true;
-	} else if (of_find_property(np, "fsl,sai-asynchronous", NULL)) {
+	} else if (of_property_read_bool(np, "fsl,sai-asynchronous")) {
 		/* Discard all settings for asynchronous mode */
 		sai->synchronous[RX] = false;
 		sai->synchronous[TX] = false;
@@ -1401,7 +1401,7 @@ static int fsl_sai_probe(struct platform_device *pdev)
 		sai->cpu_dai_drv.symmetric_sample_bits = 0;
 	}
 
-	if (of_find_property(np, "fsl,sai-mclk-direction-output", NULL) &&
+	if (of_property_read_bool(np, "fsl,sai-mclk-direction-output") &&
 	    of_device_is_compatible(np, "fsl,imx6ul-sai")) {
 		gpr = syscon_regmap_lookup_by_compatible("fsl,imx6ul-iomuxc-gpr");
 		if (IS_ERR(gpr)) {
@@ -1442,7 +1442,7 @@ static int fsl_sai_probe(struct platform_device *pdev)
 		dev_warn(dev, "Error reading SAI version: %d\n", ret);
 
 	/* Select MCLK direction */
-	if (of_find_property(np, "fsl,sai-mclk-direction-output", NULL) &&
+	if (of_property_read_bool(np, "fsl,sai-mclk-direction-output") &&
 	    sai->soc_data->max_register >= FSL_SAI_MCTL) {
 		regmap_update_bits(sai->regmap, FSL_SAI_MCTL,
 				   FSL_SAI_MCTL_MCLK_EN, FSL_SAI_MCTL_MCLK_EN);
diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 46a53551b955c..6af00b62a60fa 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -1447,7 +1447,7 @@ static int fsl_ssi_probe_from_dt(struct fsl_ssi *ssi)
 			return -EINVAL;
 		}
 		strcpy(ssi->card_name, "ac97-codec");
-	} else if (!of_find_property(np, "fsl,ssi-asynchronous", NULL)) {
+	} else if (!of_property_read_bool(np, "fsl,ssi-asynchronous")) {
 		/*
 		 * In synchronous mode, STCK and STFS ports are used by RX
 		 * as well. So the software should limit the sample rates,
diff --git a/sound/soc/fsl/imx-card.c b/sound/soc/fsl/imx-card.c
index 3f128ced41809..64a4d7e9db603 100644
--- a/sound/soc/fsl/imx-card.c
+++ b/sound/soc/fsl/imx-card.c
@@ -563,7 +563,7 @@ static int imx_card_parse_of(struct imx_card_data *data)
 			link_data->cpu_sysclk_id = FSL_SAI_CLK_MAST1;
 
 			/* sai may support mclk/bclk = 1 */
-			if (of_find_property(np, "fsl,mclk-equal-bclk", NULL)) {
+			if (of_property_read_bool(np, "fsl,mclk-equal-bclk")) {
 				link_data->one2one_ratio = true;
 			} else {
 				int i;
diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index 7ade6c5ed96ff..cb7fff48959a2 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -1208,10 +1208,10 @@ int rsnd_ssi_probe(struct rsnd_priv *priv)
 			goto rsnd_ssi_probe_done;
 		}
 
-		if (of_get_property(np, "shared-pin", NULL))
+		if (of_property_read_bool(np, "shared-pin"))
 			rsnd_flags_set(ssi, RSND_SSI_CLK_PIN_SHARE);
 
-		if (of_get_property(np, "no-busif", NULL))
+		if (of_property_read_bool(np, "no-busif"))
 			rsnd_flags_set(ssi, RSND_SSI_NO_BUSIF);
 
 		ssi->irq = irq_of_parse_and_map(np, 0);
-- 
2.40.1



