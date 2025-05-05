Return-Path: <stable+bounces-140511-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA029AAA999
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 403AA5A40FD
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F118E359DF6;
	Mon,  5 May 2025 22:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pl1jHu0r"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D8A299AAE;
	Mon,  5 May 2025 22:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485016; cv=none; b=QkGCtw2syz9GQ4G+Xcosj4ir8lE7XmyV5bfpS4tCuxLrvDLrqnE8Ev/c7q0f+yvobOcYzFMIk760OFOGHJav6RAdGnhWkuqkXeuSTePRiWX8ob06C6Klp7sWK6s754xMvgOsbxy9UqvW5esRdeoJ+sq3ONacXTcLo85lpIvpIgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485016; c=relaxed/simple;
	bh=9nylInJVXm9TVFSZYpUXKz42kDfLqGneBtEXJdGEI/Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NU/H6eyQno2DsKjwUYNEILdM+sCs6SayLwV4d2R6zR6w80ZMrCNcweHTvFQQzVYElDZXgaJiSZlwl1XiA0NVkW1QormZLBHl8YoG9LhDtyWyCitawLXuYOrTg5M2MjFLJ6vWJTAvLdrOdIftTG6jB+Ib45GDe2dM4Uk7Asm0dUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pl1jHu0r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E11CCC4CEED;
	Mon,  5 May 2025 22:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485015;
	bh=9nylInJVXm9TVFSZYpUXKz42kDfLqGneBtEXJdGEI/Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Pl1jHu0r2B9W+SX+SZeUsga/zOxgciePk6V4Vz6G9eWz11WzBJp58bKyLshm1WG6p
	 2F8KcbP2Kbo7cEgVTU4GperkW/FIUB+W4nODrmHWr0mUgxK7I9W3Jyr+ccBOyj6TF1
	 prCYoh3G6eK/7pKy248OmgCNMJUsWrrMO9q9a7LpPJrC1Xb7LcIm4cl/Unzw8TxkVr
	 WQHmSUWTIkwHHUtXVEk4EB6kmhbLkofvrY50dBSHIvxCZE6Jd9Hub7bdr/KSthaikC
	 pPVdPLoKdZM4GDuzJ+pbOs9PKRCwtwg7OwTfhiY9Ah9g6k6MPE6BVgWFlf72YDAHU3
	 bWtdv3nZZ0PhQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ryan Walklin <ryan@testtoast.com>,
	Chris Morgan <macromorgan@hotmail.com>,
	Philippe Simons <simons.philippe@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	wens@csie.org,
	jernej.skrabec@gmail.com,
	samuel@sholland.org,
	csokas.bence@prolan.hu,
	mesihkilinc@gmail.com,
	andre.przywara@arm.com,
	codekipper@gmail.com,
	jbrunet@baylibre.com,
	linux-sound@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev
Subject: [PATCH AUTOSEL 6.12 123/486] ASoC: sun4i-codec: support hp-det-gpios property
Date: Mon,  5 May 2025 18:33:19 -0400
Message-Id: <20250505223922.2682012-123-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: Ryan Walklin <ryan@testtoast.com>

[ Upstream commit a149377c033afe6557c50892ebbfc0e8b7e2e253 ]

Add support for GPIO headphone detection with the hp-det-gpios
property. In order for this to properly disable the path upon
removal of headphones, the output must be labelled Headphone which
is a common sink in the driver.

Describe a headphone jack and detection GPIO in the driver, check for
a corresponding device tree node, and enable jack detection in a new
machine init function if described.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
Signed-off-by: Ryan Walklin <ryan@testtoast.com>

--
Changelog v1..v2:
- Separate DAPM changes into separate patch and add rationale.

Tested-by: Philippe Simons <simons.philippe@gmail.com>
Link: https://patch.msgid.link/20250214220247.10810-4-ryan@testtoast.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sunxi/sun4i-codec.c | 53 +++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index 330bc0c09f56b..93dd88fb805dd 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -21,6 +21,7 @@
 #include <linux/gpio/consumer.h>
 
 #include <sound/core.h>
+#include <sound/jack.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
@@ -235,6 +236,7 @@ struct sun4i_codec {
 	struct clk	*clk_module;
 	struct reset_control *rst;
 	struct gpio_desc *gpio_pa;
+	struct gpio_desc *gpio_hp;
 
 	/* ADC_FIFOC register is at different offset on different SoCs */
 	struct regmap_field *reg_adc_fifoc;
@@ -1263,6 +1265,49 @@ static struct snd_soc_dai_driver dummy_cpu_dai = {
 	.ops = &dummy_dai_ops,
 };
 
+static struct snd_soc_jack sun4i_headphone_jack;
+
+static struct snd_soc_jack_pin sun4i_headphone_jack_pins[] = {
+	{ .pin = "Headphone", .mask = SND_JACK_HEADPHONE },
+};
+
+static struct snd_soc_jack_gpio sun4i_headphone_jack_gpio = {
+	.name = "hp-det",
+	.report = SND_JACK_HEADPHONE,
+	.debounce_time = 150,
+};
+
+static int sun4i_codec_machine_init(struct snd_soc_pcm_runtime *rtd)
+{
+	struct snd_soc_card *card = rtd->card;
+	struct sun4i_codec *scodec = snd_soc_card_get_drvdata(card);
+	int ret;
+
+	if (scodec->gpio_hp) {
+		ret = snd_soc_card_jack_new_pins(card, "Headphone Jack",
+						 SND_JACK_HEADPHONE,
+						 &sun4i_headphone_jack,
+						 sun4i_headphone_jack_pins,
+						 ARRAY_SIZE(sun4i_headphone_jack_pins));
+		if (ret) {
+			dev_err(rtd->dev,
+				"Headphone jack creation failed: %d\n", ret);
+			return ret;
+		}
+
+		sun4i_headphone_jack_gpio.desc = scodec->gpio_hp;
+		ret = snd_soc_jack_add_gpios(&sun4i_headphone_jack, 1,
+					     &sun4i_headphone_jack_gpio);
+
+		if (ret) {
+			dev_err(rtd->dev, "Headphone GPIO not added: %d\n", ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
 static struct snd_soc_dai_link *sun4i_codec_create_link(struct device *dev,
 							int *num_links)
 {
@@ -1288,6 +1333,7 @@ static struct snd_soc_dai_link *sun4i_codec_create_link(struct device *dev,
 	link->codecs->name	= dev_name(dev);
 	link->platforms->name	= dev_name(dev);
 	link->dai_fmt		= SND_SOC_DAIFMT_I2S;
+	link->init		= sun4i_codec_machine_init;
 
 	*num_links = 1;
 
@@ -1728,6 +1774,13 @@ static int sun4i_codec_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	scodec->gpio_hp = devm_gpiod_get_optional(&pdev->dev, "hp-det", GPIOD_IN);
+	if (IS_ERR(scodec->gpio_hp)) {
+		ret = PTR_ERR(scodec->gpio_hp);
+		dev_err_probe(&pdev->dev, ret, "Failed to get hp-det gpio\n");
+		return ret;
+	}
+
 	/* reg_field setup */
 	scodec->reg_adc_fifoc = devm_regmap_field_alloc(&pdev->dev,
 							scodec->regmap,
-- 
2.39.5


