Return-Path: <stable+bounces-25179-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E42869823
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 15:29:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9E70294417
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 14:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45378145B06;
	Tue, 27 Feb 2024 14:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Qcamb1SR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C7713B798;
	Tue, 27 Feb 2024 14:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709044084; cv=none; b=nna/HuzRsL8KRelY2H7Sf6qg5m+k7Trp/pqPUeQ5Lgxa/FRsdzvZrHhmED/4qCKSwVScQuoNqq4QXtyOco/YJHYXMVAPDlviJpVaptWrj9WD4ATSh8Q+d6+RIZk5TpX7s9AEMMxX07GRM0XQkHvyk+/z8vqFv64Jd/F39KOiggY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709044084; c=relaxed/simple;
	bh=VUef1WufJQ0BIPJWsvixcZmm9Z4p4bPU/+s5L5hcw5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R2vpuT2HEjFOILJn5qFn3MkFyLPhNR+rWxoidCl8Ffn+iYqctIZNhV7BdFi+dzqhyEBuzvsjJVhGKNCb7xx+1K81usj9b3VjMfheMI0y0n6tWirjHNwZkWyAi4ozD4rBtYqvSpeyrjJ9vuhXr+zqbz9QlD2FMb7mNJk+QidW46g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Qcamb1SR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 863FEC43390;
	Tue, 27 Feb 2024 14:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709044083;
	bh=VUef1WufJQ0BIPJWsvixcZmm9Z4p4bPU/+s5L5hcw5A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qcamb1SRNm6+oBrebF4ka9devVy4s52GeE/E/GDcrq2DbfP/ujzBLAgTz78M/L2pW
	 X48CQhYmRIOVq5pPR4eJowuEXexGUcTVaVtojMec/U2h0u2th4DctJ2Cqusb4mIsFn
	 saH5nMTBQgKlprmRIATuzr6krvyxSMCNDxGwk+Lc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 057/122] ASoC: Intel: boards: harden codec property handling
Date: Tue, 27 Feb 2024 14:26:58 +0100
Message-ID: <20240227131600.573230546@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240227131558.694096204@linuxfoundation.org>
References: <20240227131558.694096204@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

[ Upstream commit c50f126b3c9ebb77585838726a3a490ad33b92cd ]

In current ACPI-based devices, the DSDT does not include any of the
properties required by the codec driver. This is not an ACPI
limitation proper since the _DSD method could be used, as done for
Camera and SoundWire in newer platforms. For legacy devices, there is
unfortunately no other option than using a work-around: we add
properties to the codec device from the machine driver.

To avoid any issues with the codec driver being unbound, we need to
keep a reference to the codec device until the card is removed.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Co-developed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20210813151116.23931-2-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: 721858823d7c ("ASoC: Intel: bytcr_rt5651: Drop reference count of ACPI device after use")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/boards/bytcht_es8316.c | 12 +++++--
 sound/soc/intel/boards/bytcr_rt5640.c  | 47 +++++++++++++++++---------
 sound/soc/intel/boards/bytcr_rt5651.c  | 37 +++++++++++++-------
 3 files changed, 64 insertions(+), 32 deletions(-)

diff --git a/sound/soc/intel/boards/bytcht_es8316.c b/sound/soc/intel/boards/bytcht_es8316.c
index 81269ed5a2aaa..91351b8536aa1 100644
--- a/sound/soc/intel/boards/bytcht_es8316.c
+++ b/sound/soc/intel/boards/bytcht_es8316.c
@@ -37,6 +37,7 @@ struct byt_cht_es8316_private {
 	struct clk *mclk;
 	struct snd_soc_jack jack;
 	struct gpio_desc *speaker_en_gpio;
+	struct device *codec_dev;
 	bool speaker_en;
 };
 
@@ -569,7 +570,7 @@ static int snd_byt_cht_es8316_mc_probe(struct platform_device *pdev)
 		gpiod_get_index(codec_dev, "speaker-enable", 0,
 				/* see comment in byt_cht_es8316_resume */
 				GPIOD_OUT_LOW | GPIOD_FLAGS_BIT_NONEXCLUSIVE);
-	put_device(codec_dev);
+	priv->codec_dev = codec_dev;
 
 	if (IS_ERR(priv->speaker_en_gpio)) {
 		ret = PTR_ERR(priv->speaker_en_gpio);
@@ -581,7 +582,7 @@ static int snd_byt_cht_es8316_mc_probe(struct platform_device *pdev)
 			dev_err(dev, "get speaker GPIO failed: %d\n", ret);
 			fallthrough;
 		case -EPROBE_DEFER:
-			return ret;
+			goto err_put_codec;
 		}
 	}
 
@@ -604,10 +605,14 @@ static int snd_byt_cht_es8316_mc_probe(struct platform_device *pdev)
 	if (ret) {
 		gpiod_put(priv->speaker_en_gpio);
 		dev_err(dev, "snd_soc_register_card failed: %d\n", ret);
-		return ret;
+		goto err_put_codec;
 	}
 	platform_set_drvdata(pdev, &byt_cht_es8316_card);
 	return 0;
+
+err_put_codec:
+	put_device(priv->codec_dev);
+	return ret;
 }
 
 static int snd_byt_cht_es8316_mc_remove(struct platform_device *pdev)
@@ -616,6 +621,7 @@ static int snd_byt_cht_es8316_mc_remove(struct platform_device *pdev)
 	struct byt_cht_es8316_private *priv = snd_soc_card_get_drvdata(card);
 
 	gpiod_put(priv->speaker_en_gpio);
+	put_device(priv->codec_dev);
 	return 0;
 }
 
diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index 9a5ab96f917d3..b531c348fb697 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -86,6 +86,7 @@ enum {
 struct byt_rt5640_private {
 	struct snd_soc_jack jack;
 	struct clk *mclk;
+	struct device *codec_dev;
 };
 static bool is_bytcr;
 
@@ -941,15 +942,11 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
  * Note this MUST be called before snd_soc_register_card(), so that the props
  * are in place before the codec component driver's probe function parses them.
  */
-static int byt_rt5640_add_codec_device_props(const char *i2c_dev_name)
+static int byt_rt5640_add_codec_device_props(struct device *i2c_dev,
+					     struct byt_rt5640_private *priv)
 {
 	struct property_entry props[MAX_NO_PROPS] = {};
-	struct device *i2c_dev;
-	int ret, cnt = 0;
-
-	i2c_dev = bus_find_device_by_name(&i2c_bus_type, NULL, i2c_dev_name);
-	if (!i2c_dev)
-		return -EPROBE_DEFER;
+	int cnt = 0;
 
 	switch (BYT_RT5640_MAP(byt_rt5640_quirk)) {
 	case BYT_RT5640_DMIC1_MAP:
@@ -989,10 +986,7 @@ static int byt_rt5640_add_codec_device_props(const char *i2c_dev_name)
 	if (byt_rt5640_quirk & BYT_RT5640_JD_NOT_INV)
 		props[cnt++] = PROPERTY_ENTRY_BOOL("realtek,jack-detect-not-inverted");
 
-	ret = device_add_properties(i2c_dev, props);
-	put_device(i2c_dev);
-
-	return ret;
+	return device_add_properties(i2c_dev, props);
 }
 
 static int byt_rt5640_init(struct snd_soc_pcm_runtime *runtime)
@@ -1324,6 +1318,7 @@ static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
 	struct snd_soc_acpi_mach *mach;
 	const char *platform_name;
 	struct acpi_device *adev;
+	struct device *codec_dev;
 	int ret_val = 0;
 	int dai_index = 0;
 	int i, cfg_spk;
@@ -1430,10 +1425,16 @@ static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
 		byt_rt5640_quirk = quirk_override;
 	}
 
+	codec_dev = bus_find_device_by_name(&i2c_bus_type, NULL, byt_rt5640_codec_name);
+	if (!codec_dev)
+		return -EPROBE_DEFER;
+
+	priv->codec_dev = codec_dev;
+
 	/* Must be called before register_card, also see declaration comment. */
-	ret_val = byt_rt5640_add_codec_device_props(byt_rt5640_codec_name);
+	ret_val = byt_rt5640_add_codec_device_props(codec_dev, priv);
 	if (ret_val)
-		return ret_val;
+		goto err;
 
 	log_quirks(&pdev->dev);
 
@@ -1460,7 +1461,7 @@ static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
 			 * for all other errors, including -EPROBE_DEFER
 			 */
 			if (ret_val != -ENOENT)
-				return ret_val;
+				goto err;
 			byt_rt5640_quirk &= ~BYT_RT5640_MCLK_EN;
 		}
 	}
@@ -1493,17 +1494,30 @@ static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
 	ret_val = snd_soc_fixup_dai_links_platform_name(&byt_rt5640_card,
 							platform_name);
 	if (ret_val)
-		return ret_val;
+		goto err;
 
 	ret_val = devm_snd_soc_register_card(&pdev->dev, &byt_rt5640_card);
 
 	if (ret_val) {
 		dev_err(&pdev->dev, "devm_snd_soc_register_card failed %d\n",
 			ret_val);
-		return ret_val;
+		goto err;
 	}
 	platform_set_drvdata(pdev, &byt_rt5640_card);
 	return ret_val;
+
+err:
+	put_device(priv->codec_dev);
+	return ret_val;
+}
+
+static int snd_byt_rt5640_mc_remove(struct platform_device *pdev)
+{
+	struct snd_soc_card *card = platform_get_drvdata(pdev);
+	struct byt_rt5640_private *priv = snd_soc_card_get_drvdata(card);
+
+	put_device(priv->codec_dev);
+	return 0;
 }
 
 static struct platform_driver snd_byt_rt5640_mc_driver = {
@@ -1514,6 +1528,7 @@ static struct platform_driver snd_byt_rt5640_mc_driver = {
 #endif
 	},
 	.probe = snd_byt_rt5640_mc_probe,
+	.remove = snd_byt_rt5640_mc_remove,
 };
 
 module_platform_driver(snd_byt_rt5640_mc_driver);
diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index bf8b87d45cb0a..acea83e814acb 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -85,6 +85,7 @@ struct byt_rt5651_private {
 	struct gpio_desc *ext_amp_gpio;
 	struct gpio_desc *hp_detect;
 	struct snd_soc_jack jack;
+	struct device *codec_dev;
 };
 
 static const struct acpi_gpio_mapping *byt_rt5651_gpios;
@@ -995,12 +996,12 @@ static int snd_byt_rt5651_mc_probe(struct platform_device *pdev)
 		byt_rt5651_quirk = quirk_override;
 	}
 
+	priv->codec_dev = codec_dev;
+
 	/* Must be called before register_card, also see declaration comment. */
 	ret_val = byt_rt5651_add_codec_device_props(codec_dev);
-	if (ret_val) {
-		put_device(codec_dev);
-		return ret_val;
-	}
+	if (ret_val)
+		goto err;
 
 	/* Cherry Trail devices use an external amplifier enable gpio */
 	if (soc_intel_is_cht() && !byt_rt5651_gpios)
@@ -1024,8 +1025,7 @@ static int snd_byt_rt5651_mc_probe(struct platform_device *pdev)
 					ret_val);
 				fallthrough;
 			case -EPROBE_DEFER:
-				put_device(codec_dev);
-				return ret_val;
+				goto err;
 			}
 		}
 		priv->hp_detect = devm_fwnode_gpiod_get(&pdev->dev,
@@ -1044,14 +1044,11 @@ static int snd_byt_rt5651_mc_probe(struct platform_device *pdev)
 					ret_val);
 				fallthrough;
 			case -EPROBE_DEFER:
-				put_device(codec_dev);
-				return ret_val;
+				goto err;
 			}
 		}
 	}
 
-	put_device(codec_dev);
-
 	log_quirks(&pdev->dev);
 
 	if ((byt_rt5651_quirk & BYT_RT5651_SSP2_AIF2) ||
@@ -1075,7 +1072,7 @@ static int snd_byt_rt5651_mc_probe(struct platform_device *pdev)
 			 * for all other errors, including -EPROBE_DEFER
 			 */
 			if (ret_val != -ENOENT)
-				return ret_val;
+				goto err;
 			byt_rt5651_quirk &= ~BYT_RT5651_MCLK_EN;
 		}
 	}
@@ -1104,17 +1101,30 @@ static int snd_byt_rt5651_mc_probe(struct platform_device *pdev)
 	ret_val = snd_soc_fixup_dai_links_platform_name(&byt_rt5651_card,
 							platform_name);
 	if (ret_val)
-		return ret_val;
+		goto err;
 
 	ret_val = devm_snd_soc_register_card(&pdev->dev, &byt_rt5651_card);
 
 	if (ret_val) {
 		dev_err(&pdev->dev, "devm_snd_soc_register_card failed %d\n",
 			ret_val);
-		return ret_val;
+		goto err;
 	}
 	platform_set_drvdata(pdev, &byt_rt5651_card);
 	return ret_val;
+
+err:
+	put_device(priv->codec_dev);
+	return ret_val;
+}
+
+static int snd_byt_rt5651_mc_remove(struct platform_device *pdev)
+{
+	struct snd_soc_card *card = platform_get_drvdata(pdev);
+	struct byt_rt5651_private *priv = snd_soc_card_get_drvdata(card);
+
+	put_device(priv->codec_dev);
+	return 0;
 }
 
 static struct platform_driver snd_byt_rt5651_mc_driver = {
@@ -1125,6 +1135,7 @@ static struct platform_driver snd_byt_rt5651_mc_driver = {
 #endif
 	},
 	.probe = snd_byt_rt5651_mc_probe,
+	.remove = snd_byt_rt5651_mc_remove,
 };
 
 module_platform_driver(snd_byt_rt5651_mc_driver);
-- 
2.43.0




