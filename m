Return-Path: <stable+bounces-89619-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECFEA9BB19C
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 11:52:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25EFB1C21AE8
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 10:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614021B6D1D;
	Mon,  4 Nov 2024 10:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VmzFaW8W"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1919B1B6D17;
	Mon,  4 Nov 2024 10:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730717462; cv=none; b=r/fhO1Cg/qbsWklQBhn+aRkpu0o22KKIS40cSqzqRhHNAAa/KwD51VHhr5ARAHbHSFOoht4yT3LvO+ny3RZdG/8XJFM0nQG7fYfbtSv18fEbBhN8GmbU69Dt9a1sIVESz5v575S8x8OK2C1v1a3OYQ0x5pOIWYhbBVUV/7ArBj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730717462; c=relaxed/simple;
	bh=iTGqIO9Es4XecuyLxjDR+ZPOneoUJN9I9mMLnY1w8JY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PjAYmwFoqvu7Zp5Eq1QbTKYzX2lFKV+yzNZsHfKINKdWEv5BLRsb3uQsjzBKG3k7gz6gIMOQqP7Ds9UAfMkSng5CCcQOYgW0p2hJGsB+Ii0mFqFvWsnmXCRYwu/ZoPd+DBTNujG81XmpgjcMiIs5C7mTBigB2juUJUJnT/mLOWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VmzFaW8W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA338C4CED1;
	Mon,  4 Nov 2024 10:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730717461;
	bh=iTGqIO9Es4XecuyLxjDR+ZPOneoUJN9I9mMLnY1w8JY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VmzFaW8WzDHNcmx6GL9rpiIPTuABJIg63A50jb36S8MYlkW2OBcbth4UMMfoB3dC3
	 hItUsPoGdp0yqvQQv2Z4AGgYD05l/Fa5Wmth2jgFhZxScd8OX13q9/8hyCrAwQW8ws
	 rBporr4jMncVCwGgOyIVoqFahEVxHSodnMaSW0hgYo//GgkKPnlZB3LYur170UPAKJ
	 QrntzWPcATFXH9F58XBADMT9qUVSu2CRsHbBC67PWpAjUoyTBDXFH24q9809Modfwt
	 hpxTfekLntdpGTAXjaA/HxrTRFQEq5sngBBA+ho++DFbY+7MTU83JVExEB6H+uvg1d
	 25Wme756zmOZw==
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
Subject: [PATCH AUTOSEL 6.11 06/21] ASoC: codecs: rt5640: Always disable IRQs from rt5640_cancel_work()
Date: Mon,  4 Nov 2024 05:49:42 -0500
Message-ID: <20241104105048.96444-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241104105048.96444-1-sashal@kernel.org>
References: <20241104105048.96444-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.6
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
index 16f3425a3e35c..855139348edb4 100644
--- a/sound/soc/codecs/rt5640.c
+++ b/sound/soc/codecs/rt5640.c
@@ -2419,10 +2419,20 @@ static irqreturn_t rt5640_jd_gpio_irq(int irq, void *data)
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
@@ -2463,13 +2473,7 @@ static void rt5640_disable_jack_detect(struct snd_soc_component *component)
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
@@ -2477,8 +2481,6 @@ static void rt5640_disable_jack_detect(struct snd_soc_component *component)
 		snd_soc_jack_report(rt5640->jack, 0, SND_JACK_BTN_0);
 	}
 
-	rt5640->jd_gpio_irq_requested = false;
-	rt5640->irq_requested = false;
 	rt5640->jd_gpio = NULL;
 	rt5640->jack = NULL;
 }
@@ -2798,7 +2800,8 @@ static int rt5640_suspend(struct snd_soc_component *component)
 	if (rt5640->jack) {
 		/* disable jack interrupts during system suspend */
 		disable_irq(rt5640->irq);
-		rt5640_cancel_work(rt5640);
+		cancel_delayed_work_sync(&rt5640->jack_work);
+		cancel_delayed_work_sync(&rt5640->bp_work);
 	}
 
 	snd_soc_component_force_bias_level(component, SND_SOC_BIAS_OFF);
@@ -3032,7 +3035,7 @@ static int rt5640_i2c_probe(struct i2c_client *i2c)
 	INIT_DELAYED_WORK(&rt5640->jack_work, rt5640_jack_work);
 
 	/* Make sure work is stopped on probe-error / remove */
-	ret = devm_add_action_or_reset(&i2c->dev, rt5640_cancel_work, rt5640);
+	ret = devm_add_action_or_reset(&i2c->dev, rt5640_disable_irq_and_cancel_work, rt5640);
 	if (ret)
 		return ret;
 
-- 
2.43.0


