Return-Path: <stable+bounces-43416-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B9728BF297
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94A8FB25A26
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8826183C2C;
	Tue,  7 May 2024 23:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nwTCo7Gz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C0F183C28;
	Tue,  7 May 2024 23:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715123650; cv=none; b=OFc2aWp7SB2tq1eidzZFZyS403kgd9eZzhUegdgieWRYR07ew2gXhgoEIsH9f58r/xaXR4sQ4WlbZcqMzuu7weuoW6TNzuFwDdvrLsDu4pvLMpAKNr8nW8BXHpRZ0J3Wy5iDx/sXDB0Zn+O+SoiIVkuMC1A0Rma6Y+8RKFT1c4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715123650; c=relaxed/simple;
	bh=j6DRlyt+V4SRldi8fPDjSanxQNYW4PLUuoPUdkG7EkM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tQlgFHw9z2bQIGvqtoIvHTt9ilFpXzaRaWBfIWmou1XFLk7EcE+QjtmA3AdCi/uHrwVfEaUP2P4WfRyeNoOpr0otbjZAtKykumsm601SuVs6I4zf7FsioqylhjFUtjiHwJUgUeRnhejaAPhdy74QzNcxe7Evdxvt8oa8kMwnlxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nwTCo7Gz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CF4EC3277B;
	Tue,  7 May 2024 23:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715123649;
	bh=j6DRlyt+V4SRldi8fPDjSanxQNYW4PLUuoPUdkG7EkM=;
	h=From:To:Cc:Subject:Date:From;
	b=nwTCo7Gz74RMjHZ5INynbJtFkz6fguMmFkGad5QYypVTkMPfQQpdRu14qhFVCEoFl
	 GxAqtb9miFf+2wkOBz3zsijjcrEeVf6//4pdlxsWCj0rRWAdl+t0VG/US60e6mmaVd
	 JE65iVuDbHPcVUvA3fNWS5qqaDmH7LC+qwAwVOFGYC3hsiZLXoqM3R5KGaY1I+EkUo
	 kiKNbYvS3MzLub2UhMHU5dJrq6/nJbd7xm3foXlY/99njOJhkfCliLOMEBDTUzMDVl
	 SrwuMetg4y6PKUa5/Mwe+I/s/sXb/xhbkjJRR84c2kRJO4RHfplDX+YWwy80+XAD9U
	 ZFYL7JuGvT5AQ==
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
Subject: [PATCH AUTOSEL 5.10 1/9] ASoC: rt5645: Fix the electric noise due to the CBJ contacts floating
Date: Tue,  7 May 2024 19:13:56 -0400
Message-ID: <20240507231406.395123-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.216
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
index 5db63ef33f1a2..ac403827a2290 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -414,6 +414,7 @@ struct rt5645_priv {
 	struct regmap *regmap;
 	struct i2c_client *i2c;
 	struct gpio_desc *gpiod_hp_det;
+	struct gpio_desc *gpiod_cbj_sleeve;
 	struct snd_soc_jack *hp_jack;
 	struct snd_soc_jack *mic_jack;
 	struct snd_soc_jack *btn_jack;
@@ -3169,6 +3170,9 @@ static int rt5645_jack_detect(struct snd_soc_component *component, int jack_inse
 		regmap_update_bits(rt5645->regmap, RT5645_IN1_CTRL2,
 			RT5645_CBJ_MN_JD, 0);
 
+		if (rt5645->gpiod_cbj_sleeve)
+			gpiod_set_value(rt5645->gpiod_cbj_sleeve, 1);
+
 		msleep(600);
 		regmap_read(rt5645->regmap, RT5645_IN1_CTRL3, &val);
 		val &= 0x7;
@@ -3185,6 +3189,8 @@ static int rt5645_jack_detect(struct snd_soc_component *component, int jack_inse
 			snd_soc_dapm_disable_pin(dapm, "Mic Det Power");
 			snd_soc_dapm_sync(dapm);
 			rt5645->jack_type = SND_JACK_HEADPHONE;
+			if (rt5645->gpiod_cbj_sleeve)
+				gpiod_set_value(rt5645->gpiod_cbj_sleeve, 0);
 		}
 		if (rt5645->pdata.level_trigger_irq)
 			regmap_update_bits(rt5645->regmap, RT5645_IRQ_CTRL2,
@@ -3210,6 +3216,9 @@ static int rt5645_jack_detect(struct snd_soc_component *component, int jack_inse
 		if (rt5645->pdata.level_trigger_irq)
 			regmap_update_bits(rt5645->regmap, RT5645_IRQ_CTRL2,
 				RT5645_JD_1_1_MASK, RT5645_JD_1_1_INV);
+
+		if (rt5645->gpiod_cbj_sleeve)
+			gpiod_set_value(rt5645->gpiod_cbj_sleeve, 0);
 	}
 
 	return rt5645->jack_type;
@@ -3882,6 +3891,16 @@ static int rt5645_i2c_probe(struct i2c_client *i2c,
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
 
@@ -4125,6 +4144,9 @@ static int rt5645_i2c_remove(struct i2c_client *i2c)
 	cancel_delayed_work_sync(&rt5645->jack_detect_work);
 	cancel_delayed_work_sync(&rt5645->rcclock_work);
 
+	if (rt5645->gpiod_cbj_sleeve)
+		gpiod_set_value(rt5645->gpiod_cbj_sleeve, 0);
+
 	regulator_bulk_disable(ARRAY_SIZE(rt5645->supplies), rt5645->supplies);
 
 	return 0;
@@ -4142,6 +4164,9 @@ static void rt5645_i2c_shutdown(struct i2c_client *i2c)
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


