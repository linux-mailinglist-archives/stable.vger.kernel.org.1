Return-Path: <stable+bounces-43431-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECBAD8BF2B9
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:56:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7A4B283034
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4426B1459FE;
	Tue,  7 May 2024 23:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hEXEVGqP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518B7145A1F;
	Tue,  7 May 2024 23:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715123679; cv=none; b=Li4ut6/rz9cvF7B6pZ4C2BwI1X9SajIU62fEePVDSxtw0HIghDQ32qAcoNxRItadSDg9mfpUBRwsV1OiHkkiAN7GYrxqUsP7ydfTmabRmsTHFvr7K6NQCsFSPzIpCsOxTNbYYFJOA4qy5TiXDcwXFTnhZ2z/9sdSH4xJcuBE1P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715123679; c=relaxed/simple;
	bh=P8V3GOo/h8bmeAg7hfbBx+6HSjURKTYsAeCydLGVJ9k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S4c2gsGHhhbV1y1a6X7qSDqIG5ZpP9NHyUpg5wyhfBHTMFez2Tvx56ZeKUqWZ20iC5w1vRWna/aMg93mrLTrZaMiRg8RAFmd9S1vDbXZYw7dJy9zrRcb0esgc4CkGQWPwPpqb/SLzdQYqXwc67E/cITpBhKCJUzW3HvNP90WOJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hEXEVGqP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FACDC4AF63;
	Tue,  7 May 2024 23:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715123679;
	bh=P8V3GOo/h8bmeAg7hfbBx+6HSjURKTYsAeCydLGVJ9k=;
	h=From:To:Cc:Subject:Date:From;
	b=hEXEVGqP1ZdeouT95/0+beRSpUdcY8K46RnpcL7TFXgn7AtYcKj5u3RIPYKbDoyKy
	 rv+5uhZFZN+A2KHNjbk4SLbhWnZ3wl8ipDGwhevG9XgIggr2A4zlOiGJwtmbTXoSpR
	 Lb0E/k9NTqvOpuW/fFXURoS7S/38iUindIi8sEHwQoDlTXlB0J+FoPrg48DrJGj+YU
	 HW5RD1ZiyGlMjhcrHlp0l/PsJtJFmZJs5lwIuEJbJkxuG3qkSOTPx1kL/WBsy9eLKN
	 FrNBL9lVhQ821jbkHyt7hSy0EhEwVfNvUczXwfwxRcj4K6H2YGsCwOWmrlh+nWxOs+
	 IBFmXBewz+MaQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Derek Fang <derek.fang@realtek.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	oder_chiou@realtek.com,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 1/4] ASoC: rt5645: Fix the electric noise due to the CBJ contacts floating
Date: Tue,  7 May 2024 19:14:32 -0400
Message-ID: <20240507231436.395448-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.313
Content-Transfer-Encoding: 8bit

From: Derek Fang <derek.fang@realtek.com>

[ Upstream commit 103abab975087e1f01b76fcb54c91dbb65dbc249 ]

The codec leaves tie combo jack's sleeve/ring2 to floating status
default. It would cause electric noise while connecting the active
speaker jack during boot or shutdown.
This patch requests a gpio to control the additional jack circuit
to tie the contacts to the ground or floating.

Signed-off-by: Derek Fang <derek.fang@realtek.com>

Link: https://msgid.link/r/20240408091057.14165-1-derek.fang@realtek.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/rt5645.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 5f23369d7ccad..fbb3fca59c8cb 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -412,6 +412,7 @@ struct rt5645_priv {
 	struct regmap *regmap;
 	struct i2c_client *i2c;
 	struct gpio_desc *gpiod_hp_det;
+	struct gpio_desc *gpiod_cbj_sleeve;
 	struct snd_soc_jack *hp_jack;
 	struct snd_soc_jack *mic_jack;
 	struct snd_soc_jack *btn_jack;
@@ -3206,6 +3207,9 @@ static int rt5645_jack_detect(struct snd_soc_component *component, int jack_inse
 		regmap_update_bits(rt5645->regmap, RT5645_IN1_CTRL2,
 			RT5645_CBJ_MN_JD, 0);
 
+		if (rt5645->gpiod_cbj_sleeve)
+			gpiod_set_value(rt5645->gpiod_cbj_sleeve, 1);
+
 		msleep(600);
 		regmap_read(rt5645->regmap, RT5645_IN1_CTRL3, &val);
 		val &= 0x7;
@@ -3222,6 +3226,8 @@ static int rt5645_jack_detect(struct snd_soc_component *component, int jack_inse
 			snd_soc_dapm_disable_pin(dapm, "Mic Det Power");
 			snd_soc_dapm_sync(dapm);
 			rt5645->jack_type = SND_JACK_HEADPHONE;
+			if (rt5645->gpiod_cbj_sleeve)
+				gpiod_set_value(rt5645->gpiod_cbj_sleeve, 0);
 		}
 		if (rt5645->pdata.level_trigger_irq)
 			regmap_update_bits(rt5645->regmap, RT5645_IRQ_CTRL2,
@@ -3247,6 +3253,9 @@ static int rt5645_jack_detect(struct snd_soc_component *component, int jack_inse
 		if (rt5645->pdata.level_trigger_irq)
 			regmap_update_bits(rt5645->regmap, RT5645_IRQ_CTRL2,
 				RT5645_JD_1_1_MASK, RT5645_JD_1_1_INV);
+
+		if (rt5645->gpiod_cbj_sleeve)
+			gpiod_set_value(rt5645->gpiod_cbj_sleeve, 0);
 	}
 
 	return rt5645->jack_type;
@@ -3892,6 +3901,16 @@ static int rt5645_i2c_probe(struct i2c_client *i2c,
 			return ret;
 	}
 
+	rt5645->gpiod_cbj_sleeve = devm_gpiod_get_optional(&i2c->dev, "cbj-sleeve",
+							   GPIOD_OUT_LOW);
+
+	if (IS_ERR(rt5645->gpiod_cbj_sleeve)) {
+		ret = PTR_ERR(rt5645->gpiod_cbj_sleeve);
+		dev_info(&i2c->dev, "failed to initialize gpiod, ret=%d\n", ret);
+		if (ret != -ENOENT)
+			return ret;
+	}
+
 	for (i = 0; i < ARRAY_SIZE(rt5645->supplies); i++)
 		rt5645->supplies[i].supply = rt5645_supply_names[i];
 
@@ -4135,6 +4154,9 @@ static int rt5645_i2c_remove(struct i2c_client *i2c)
 	cancel_delayed_work_sync(&rt5645->jack_detect_work);
 	cancel_delayed_work_sync(&rt5645->rcclock_work);
 
+	if (rt5645->gpiod_cbj_sleeve)
+		gpiod_set_value(rt5645->gpiod_cbj_sleeve, 0);
+
 	regulator_bulk_disable(ARRAY_SIZE(rt5645->supplies), rt5645->supplies);
 
 	return 0;
@@ -4152,6 +4174,9 @@ static void rt5645_i2c_shutdown(struct i2c_client *i2c)
 		0);
 	msleep(20);
 	regmap_write(rt5645->regmap, RT5645_RESET, 0);
+
+	if (rt5645->gpiod_cbj_sleeve)
+		gpiod_set_value(rt5645->gpiod_cbj_sleeve, 0);
 }
 
 static struct i2c_driver rt5645_i2c_driver = {
-- 
2.43.0


