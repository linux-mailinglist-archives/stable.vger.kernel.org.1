Return-Path: <stable+bounces-89636-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96AE39BB1E3
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 11:57:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42B091F220A0
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 10:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB01F1B85D4;
	Mon,  4 Nov 2024 10:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rBCi5B5O"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644FD1B3923;
	Mon,  4 Nov 2024 10:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730717553; cv=none; b=mE9kuUvJrbxz+DhZNHp7bUMxH4LDMlW2ulqZV5z+4QaVxs+/CIJ52tg+Y18sIweiM3iG72lEdnbokULgsKbt5wgmAnA8jas4Qht//3Y8fcEXCkCW2SLDQQj87D2Ar+FMRI20I7cML/DESl5uJ3bpKIEwOUoo5brTdaAxi5HaNFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730717553; c=relaxed/simple;
	bh=/CqpRmaAXfpMm+eLl6GaZN+LR/GNS0Wg/hggFubOTl0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m7I5bDAhx7JC3V+CdRHMz0Hm10MpOqY8nEkx4Ox0wRgOUJM9uAu+Gdc+dUoRf487kBVwZK7IX3oa56klxTkl2iJOXC6mKVKwe/mUItem9teyUJgXiM3/axJ8j+tZwb4RQ9XN5dn/nx8C/C7xM3h8ctwQc+2se8vCAxy3WwPliqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rBCi5B5O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEB2BC4CED5;
	Mon,  4 Nov 2024 10:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730717553;
	bh=/CqpRmaAXfpMm+eLl6GaZN+LR/GNS0Wg/hggFubOTl0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rBCi5B5ObQEGlkt77vJpE+EyMUflvnMbIRu9H8vdGtyFj1lqcL/IpxBy64fiIR/zp
	 NQNjP6JcW8Xz14BBgPQvKLA6MqZmsL1xuJljAlxftHLHcLN7TVetbqwf2jmtvw/rks
	 zO6YdBMkqKj8xKjbjCkd0zDxcdsVs55DTzOefyT1WswMk56y53EER0J2bph8MtLZUV
	 dpBeqF/wH2C7LGVO9K2TV6VbfiynxN7bfltFuucflu5KI68JMFpl3GZd7S6sLRpQXS
	 lN2uwW76ocAUdkRi+A/XX5zkLXC2gWVWTUtarlDNm6VX5w06vSTUZbwJdL3N51wbvX
	 JPXCGwBnFKIuQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	oder_chiou@realtek.com,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 02/14] ASoC: codecs: rt5640: Always disable IRQs from rt5640_cancel_work()
Date: Mon,  4 Nov 2024 05:51:54 -0500
Message-ID: <20241104105228.97053-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241104105228.97053-1-sashal@kernel.org>
References: <20241104105228.97053-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.59
Content-Transfer-Encoding: 8bit

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 032532f91a1d06d0750f16c49a9698ef5374a68f ]

Disable IRQs from rt5640_cancel_work(), this fixes a crash caused by
the IRQ never getting freed when the driver is unbound from the i2c_client
with jack-detection active:

[  193.138780] rt5640 i2c-rt5640: ASoC: unknown pin LDO2
[  193.138830] rt5640 i2c-rt5640: ASoC: unknown pin MICBIAS1
[  193.671218] BUG: kernel NULL pointer dereference, address: 0000000000000078
[  193.671239] #PF: supervisor read access in kernel mode
[  193.671248] #PF: error_code(0x0000) - not-present page
...
[  193.671531]  ? asm_exc_page_fault+0x22/0x30
[  193.671551]  ? rt5640_jack_inserted+0x10/0x80 [snd_soc_rt5640]
[  193.671574]  rt5640_detect_headset+0x93/0x130 [snd_soc_rt5640]
[  193.671596]  rt5640_jack_work+0x93/0x355 [snd_soc_rt5640]

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Link: https://patch.msgid.link/20241024215612.92147-1-hdegoede@redhat.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/rt5640.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
index e8cdc166bdaa9..1955d77cffd99 100644
--- a/sound/soc/codecs/rt5640.c
+++ b/sound/soc/codecs/rt5640.c
@@ -2422,10 +2422,20 @@ static irqreturn_t rt5640_jd_gpio_irq(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static void rt5640_cancel_work(void *data)
+static void rt5640_disable_irq_and_cancel_work(void *data)
 {
 	struct rt5640_priv *rt5640 = data;
 
+	if (rt5640->jd_gpio_irq_requested) {
+		free_irq(rt5640->jd_gpio_irq, rt5640);
+		rt5640->jd_gpio_irq_requested = false;
+	}
+
+	if (rt5640->irq_requested) {
+		free_irq(rt5640->irq, rt5640);
+		rt5640->irq_requested = false;
+	}
+
 	cancel_delayed_work_sync(&rt5640->jack_work);
 	cancel_delayed_work_sync(&rt5640->bp_work);
 }
@@ -2466,13 +2476,7 @@ static void rt5640_disable_jack_detect(struct snd_soc_component *component)
 	if (!rt5640->jack)
 		return;
 
-	if (rt5640->jd_gpio_irq_requested)
-		free_irq(rt5640->jd_gpio_irq, rt5640);
-
-	if (rt5640->irq_requested)
-		free_irq(rt5640->irq, rt5640);
-
-	rt5640_cancel_work(rt5640);
+	rt5640_disable_irq_and_cancel_work(rt5640);
 
 	if (rt5640->jack->status & SND_JACK_MICROPHONE) {
 		rt5640_disable_micbias1_ovcd_irq(component);
@@ -2480,8 +2484,6 @@ static void rt5640_disable_jack_detect(struct snd_soc_component *component)
 		snd_soc_jack_report(rt5640->jack, 0, SND_JACK_BTN_0);
 	}
 
-	rt5640->jd_gpio_irq_requested = false;
-	rt5640->irq_requested = false;
 	rt5640->jd_gpio = NULL;
 	rt5640->jack = NULL;
 }
@@ -2801,7 +2803,8 @@ static int rt5640_suspend(struct snd_soc_component *component)
 	if (rt5640->jack) {
 		/* disable jack interrupts during system suspend */
 		disable_irq(rt5640->irq);
-		rt5640_cancel_work(rt5640);
+		cancel_delayed_work_sync(&rt5640->jack_work);
+		cancel_delayed_work_sync(&rt5640->bp_work);
 	}
 
 	snd_soc_component_force_bias_level(component, SND_SOC_BIAS_OFF);
@@ -3035,7 +3038,7 @@ static int rt5640_i2c_probe(struct i2c_client *i2c)
 	INIT_DELAYED_WORK(&rt5640->jack_work, rt5640_jack_work);
 
 	/* Make sure work is stopped on probe-error / remove */
-	ret = devm_add_action_or_reset(&i2c->dev, rt5640_cancel_work, rt5640);
+	ret = devm_add_action_or_reset(&i2c->dev, rt5640_disable_irq_and_cancel_work, rt5640);
 	if (ret)
 		return ret;
 
-- 
2.43.0


