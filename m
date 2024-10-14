Return-Path: <stable+bounces-84046-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD01F99CDDF
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 16:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81435283A2E
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 14:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF91025632;
	Mon, 14 Oct 2024 14:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Hp1mveYk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4164A24;
	Mon, 14 Oct 2024 14:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728916631; cv=none; b=kW7gUl3J0fGCS/yxRwC/JOZIl4kbDgYPXo2eHjwA8OPLbsnjxMT4MX8X3tFFa4akQ1TbkkX/znkOYP1WhwABLx1F/VJaiqLcVZbXklJhsadXpQT7UInSx/EhfrX+7wNm6WpEW5+96MDiokoTwOHsYBNyxpS5Fr8uVnbg1EPDDQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728916631; c=relaxed/simple;
	bh=bpsadeTKxXgrb6YPCMZ9uG3kJHlXHq9+Uyv1V32z4vg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=flXUvX1Obut9le0aOKaxGcjMNYA7rZttAop1jyE+lFKGvvyGA/gWwO7V5Y78a6HjKe7IDSyIfFYut8XqDZcNBeBlKSLgTIqzHQkJIIxYi/AqjWcXvkiHQimqlD5BTreKXpIJXWs1DFW5DmA+MhM+4TEssdJk9lTdJJefYfRH3go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Hp1mveYk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2DE2C4CEC3;
	Mon, 14 Oct 2024 14:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728916631;
	bh=bpsadeTKxXgrb6YPCMZ9uG3kJHlXHq9+Uyv1V32z4vg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hp1mveYkK6FTh7tf17p8L75/AldADqfM0HeKMf8hR65In+IqQEKRApakqOh7kwgKo
	 +HzHDvq4EdA4d/RPDD1NBf1beeR6XXjWvR6iH9rJ07OsYQrCtWIuVpQshadVL75TyZ
	 P5+nm0BwKqQWiyR1sJjh3h5wGx1OTdrv8lQB8EVc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 004/213] ASoC: cs35l56: Load tunings for the correct speaker models
Date: Mon, 14 Oct 2024 16:18:30 +0200
Message-ID: <20241014141043.146437222@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241014141042.954319779@linuxfoundation.org>
References: <20241014141042.954319779@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Richard Fitzgerald <rf@opensource.cirrus.com>

[ Upstream commit 245eeff18d7a37693815250ae15979ce98c3d190 ]

If the "spk-id-gpios" property is present it points to GPIOs whose
value must be used to select the correct bin file to match the
speakers.

Some manufacturers use multiple sources of speakers, which need
different tunings for best performance. On these models the type of
speaker fitted is indicated by the values of one or more GPIOs. The
number formed by the GPIOs identifies the tuning required.

The speaker ID must be used in combination with the subsystem ID
(either from PCI SSID or cirrus,firmware-uid property), because the
GPIOs can only indicate variants of a specific model.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Fixes: 1a1c3d794ef6 ("ASoC: cs35l56: Use PCI SSID as the firmware UID")
Link: https://msgid.link/r/20240129162737.497-14-rf@opensource.cirrus.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/sound/cs35l56.h           |  1 +
 sound/soc/codecs/cs35l56-shared.c | 36 +++++++++++++++++++++++++++++++
 sound/soc/codecs/cs35l56.c        | 32 ++++++++++++++++++++++-----
 sound/soc/codecs/cs35l56.h        |  1 +
 4 files changed, 65 insertions(+), 5 deletions(-)

diff --git a/include/sound/cs35l56.h b/include/sound/cs35l56.h
index 4e5f35dc042a1..c0f2135968fec 100644
--- a/include/sound/cs35l56.h
+++ b/include/sound/cs35l56.h
@@ -287,6 +287,7 @@ int cs35l56_runtime_suspend_common(struct cs35l56_base *cs35l56_base);
 int cs35l56_runtime_resume_common(struct cs35l56_base *cs35l56_base, bool is_soundwire);
 void cs35l56_init_cs_dsp(struct cs35l56_base *cs35l56_base, struct cs_dsp *cs_dsp);
 int cs35l56_hw_init(struct cs35l56_base *cs35l56_base);
+int cs35l56_get_speaker_id(struct cs35l56_base *cs35l56_base);
 int cs35l56_get_bclk_freq_id(unsigned int freq);
 void cs35l56_fill_supply_names(struct regulator_bulk_data *data);
 
diff --git a/sound/soc/codecs/cs35l56-shared.c b/sound/soc/codecs/cs35l56-shared.c
index 69c951e305842..d3db89c93b331 100644
--- a/sound/soc/codecs/cs35l56-shared.c
+++ b/sound/soc/codecs/cs35l56-shared.c
@@ -5,6 +5,7 @@
 // Copyright (C) 2023 Cirrus Logic, Inc. and
 //                    Cirrus Logic International Semiconductor Ltd.
 
+#include <linux/gpio/consumer.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/types.h>
@@ -695,6 +696,41 @@ int cs35l56_hw_init(struct cs35l56_base *cs35l56_base)
 }
 EXPORT_SYMBOL_NS_GPL(cs35l56_hw_init, SND_SOC_CS35L56_SHARED);
 
+int cs35l56_get_speaker_id(struct cs35l56_base *cs35l56_base)
+{
+	struct gpio_descs *descs;
+	int speaker_id;
+	int i, ret;
+
+	/* Read the speaker type qualifier from the motherboard GPIOs */
+	descs = gpiod_get_array_optional(cs35l56_base->dev, "spk-id", GPIOD_IN);
+	if (!descs) {
+		return -ENOENT;
+	} else if (IS_ERR(descs)) {
+		ret = PTR_ERR(descs);
+		return dev_err_probe(cs35l56_base->dev, ret, "Failed to get spk-id-gpios\n");
+	}
+
+	speaker_id = 0;
+	for (i = 0; i < descs->ndescs; i++) {
+		ret = gpiod_get_value_cansleep(descs->desc[i]);
+		if (ret < 0) {
+			dev_err_probe(cs35l56_base->dev, ret, "Failed to read spk-id[%d]\n", i);
+			goto err;
+		}
+
+		speaker_id |= (ret << i);
+	}
+
+	dev_dbg(cs35l56_base->dev, "Speaker ID = %d\n", speaker_id);
+	ret = speaker_id;
+err:
+	gpiod_put_array(descs);
+
+	return ret;
+}
+EXPORT_SYMBOL_NS_GPL(cs35l56_get_speaker_id, SND_SOC_CS35L56_SHARED);
+
 static const u32 cs35l56_bclk_valid_for_pll_freq_table[] = {
 	[0x0C] = 128000,
 	[0x0F] = 256000,
diff --git a/sound/soc/codecs/cs35l56.c b/sound/soc/codecs/cs35l56.c
index c855ef3ec665e..015269f0db54c 100644
--- a/sound/soc/codecs/cs35l56.c
+++ b/sound/soc/codecs/cs35l56.c
@@ -941,10 +941,19 @@ static int cs35l56_component_probe(struct snd_soc_component *component)
 
 	if (!cs35l56->dsp.system_name &&
 	    (snd_soc_card_get_pci_ssid(component->card, &vendor, &device) == 0)) {
-		cs35l56->dsp.system_name = devm_kasprintf(cs35l56->base.dev,
-							  GFP_KERNEL,
-							  "%04x%04x",
-							  vendor, device);
+		/* Append a speaker qualifier if there is a speaker ID */
+		if (cs35l56->speaker_id >= 0) {
+			cs35l56->dsp.system_name = devm_kasprintf(cs35l56->base.dev,
+								  GFP_KERNEL,
+								  "%04x%04x-spkid%d",
+								  vendor, device,
+								  cs35l56->speaker_id);
+		} else {
+			cs35l56->dsp.system_name = devm_kasprintf(cs35l56->base.dev,
+								  GFP_KERNEL,
+								  "%04x%04x",
+								  vendor, device);
+		}
 		if (!cs35l56->dsp.system_name)
 			return -ENOMEM;
 	}
@@ -1230,7 +1239,13 @@ static int cs35l56_get_firmware_uid(struct cs35l56_private *cs35l56)
 	if (ret < 0)
 		return 0;
 
-	cs35l56->dsp.system_name = devm_kstrdup(dev, prop, GFP_KERNEL);
+	/* Append a speaker qualifier if there is a speaker ID */
+	if (cs35l56->speaker_id >= 0)
+		cs35l56->dsp.system_name = devm_kasprintf(dev, GFP_KERNEL, "%s-spkid%d",
+							  prop, cs35l56->speaker_id);
+	else
+		cs35l56->dsp.system_name = devm_kstrdup(dev, prop, GFP_KERNEL);
+
 	if (cs35l56->dsp.system_name == NULL)
 		return -ENOMEM;
 
@@ -1245,6 +1260,7 @@ int cs35l56_common_probe(struct cs35l56_private *cs35l56)
 
 	init_completion(&cs35l56->init_completion);
 	mutex_init(&cs35l56->base.irq_lock);
+	cs35l56->speaker_id = -ENOENT;
 
 	dev_set_drvdata(cs35l56->base.dev, cs35l56);
 
@@ -1281,6 +1297,12 @@ int cs35l56_common_probe(struct cs35l56_private *cs35l56)
 		gpiod_set_value_cansleep(cs35l56->base.reset_gpio, 1);
 	}
 
+	ret = cs35l56_get_speaker_id(&cs35l56->base);
+	if ((ret < 0) && (ret != -ENOENT))
+		goto err;
+
+	cs35l56->speaker_id = ret;
+
 	ret = cs35l56_get_firmware_uid(cs35l56);
 	if (ret != 0)
 		goto err;
diff --git a/sound/soc/codecs/cs35l56.h b/sound/soc/codecs/cs35l56.h
index d9fbf568a1958..b000e7365e406 100644
--- a/sound/soc/codecs/cs35l56.h
+++ b/sound/soc/codecs/cs35l56.h
@@ -44,6 +44,7 @@ struct cs35l56_private {
 	bool sdw_attached;
 	struct completion init_completion;
 
+	int speaker_id;
 	u32 rx_mask;
 	u32 tx_mask;
 	u8 asp_slot_width;
-- 
2.43.0




