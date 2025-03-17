Return-Path: <stable+bounces-124658-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71BAFA65850
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 17:39:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D2883AA5F5
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 16:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49FC1A8404;
	Mon, 17 Mar 2025 16:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WF9NKgxo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DAB01A7045;
	Mon, 17 Mar 2025 16:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742229454; cv=none; b=htxjsiA00Ovum34nTniY1nxfrO4tIX0TAXqhgp3Ff75HRbCjMKBxoLvGJCCSa/vRsUoTns7zg4SQOgWrW+jmvaWedIh5lSoYGafdO13pb3UdRk/YPQLniINchvQFEM5sVPdu98Ef0HIErsUYXE1y/QTskvpwFAaUKFyropOe1Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742229454; c=relaxed/simple;
	bh=BdPd/8xmw8nASahU/AiRG6UvdqfzhLI4h9OC0X2eXKw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K2Si/wcu1MnyT9g+ZdZCBc4BzTWkBeFPOgXvguUYz4TTeVgmvYFGYQz1rlUPhS729xBpUbOCgGYEPcQx0ok7ofMCglt54YZcgy1mfHfKivaDWFW8N99su97zlJyagWXBaagY/6K0IqmxNZ1P8b8UPVYboPRx1vNyk5JVaWBcGa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WF9NKgxo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D08FC4CEE3;
	Mon, 17 Mar 2025 16:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742229453;
	bh=BdPd/8xmw8nASahU/AiRG6UvdqfzhLI4h9OC0X2eXKw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WF9NKgxop7i4eyU3IJDPnPDisA5j1BkMvcYS5VKNS91ogZZ6iayapTIvT0YifKB0w
	 Mmbsljif0bE/0AnI7Eh71NtKmSMUqiR21TqbUYV4OOr0YVBxmba8h6jRaJCNHdH6UV
	 +27wwC7GK1CSPc3QAXOCxDeMYduUbAuueb0Ujno4iyVPbKTNeaX4PzQRaN2iSbgVd5
	 9o/G1kFNzOZ4Cs0YKWSTGdbByODAun7ptRSvWac1HjhZ/WIB9clkinbK6TwRmvkxgt
	 ivq9+2KqmpEQWy2u1hklKXwDWVC1+irRJsHsYhGy7StxmN1Cl7va+PR8gLLjXKpioI
	 B3z3DHAVrVSAQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Maciej Strozek <mstrozek@opensource.cirrus.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	david.rhodes@cirrus.com,
	rf@opensource.cirrus.com,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	patches@opensource.cirrus.com
Subject: [PATCH AUTOSEL 6.13 03/16] ASoC: cs42l43: Add jack delay debounce after suspend
Date: Mon, 17 Mar 2025 12:37:12 -0400
Message-Id: <20250317163725.1892824-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250317163725.1892824-1-sashal@kernel.org>
References: <20250317163725.1892824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.7
Content-Transfer-Encoding: 8bit

From: Maciej Strozek <mstrozek@opensource.cirrus.com>

[ Upstream commit 164b7dd4546b57c08b373e9e3cf315ff98cb032d ]

Hardware reports jack absent after reset/suspension regardless of jack
state, so introduce an additional delay only in suspension case to allow
proper detection to take place after a short delay.

Signed-off-by: Maciej Strozek <mstrozek@opensource.cirrus.com>
Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Link: https://patch.msgid.link/20250304140504.139245-1-mstrozek@opensource.cirrus.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/cs42l43-jack.c | 13 ++++++++++---
 sound/soc/codecs/cs42l43.c      | 15 ++++++++++++++-
 sound/soc/codecs/cs42l43.h      |  3 +++
 3 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/cs42l43-jack.c b/sound/soc/codecs/cs42l43-jack.c
index d9ab003e166bf..ac19a572fe70c 100644
--- a/sound/soc/codecs/cs42l43-jack.c
+++ b/sound/soc/codecs/cs42l43-jack.c
@@ -167,7 +167,7 @@ int cs42l43_set_jack(struct snd_soc_component *component,
 		autocontrol |= 0x3 << CS42L43_JACKDET_MODE_SHIFT;
 
 	ret = cs42l43_find_index(priv, "cirrus,tip-fall-db-ms", 500,
-				 NULL, cs42l43_accdet_db_ms,
+				 &priv->tip_fall_db_ms, cs42l43_accdet_db_ms,
 				 ARRAY_SIZE(cs42l43_accdet_db_ms));
 	if (ret < 0)
 		goto error;
@@ -175,7 +175,7 @@ int cs42l43_set_jack(struct snd_soc_component *component,
 	tip_deb |= ret << CS42L43_TIPSENSE_FALLING_DB_TIME_SHIFT;
 
 	ret = cs42l43_find_index(priv, "cirrus,tip-rise-db-ms", 500,
-				 NULL, cs42l43_accdet_db_ms,
+				 &priv->tip_rise_db_ms, cs42l43_accdet_db_ms,
 				 ARRAY_SIZE(cs42l43_accdet_db_ms));
 	if (ret < 0)
 		goto error;
@@ -764,6 +764,8 @@ void cs42l43_tip_sense_work(struct work_struct *work)
 error:
 	mutex_unlock(&priv->jack_lock);
 
+	priv->suspend_jack_debounce = false;
+
 	pm_runtime_mark_last_busy(priv->dev);
 	pm_runtime_put_autosuspend(priv->dev);
 }
@@ -771,14 +773,19 @@ void cs42l43_tip_sense_work(struct work_struct *work)
 irqreturn_t cs42l43_tip_sense(int irq, void *data)
 {
 	struct cs42l43_codec *priv = data;
+	unsigned int db_delay = priv->tip_debounce_ms;
 
 	cancel_delayed_work(&priv->bias_sense_timeout);
 	cancel_delayed_work(&priv->tip_sense_work);
 	cancel_delayed_work(&priv->button_press_work);
 	cancel_work(&priv->button_release_work);
 
+	// Ensure delay after suspend is long enough to avoid false detection
+	if (priv->suspend_jack_debounce)
+		db_delay += priv->tip_fall_db_ms + priv->tip_rise_db_ms;
+
 	queue_delayed_work(system_long_wq, &priv->tip_sense_work,
-			   msecs_to_jiffies(priv->tip_debounce_ms));
+			   msecs_to_jiffies(db_delay));
 
 	return IRQ_HANDLED;
 }
diff --git a/sound/soc/codecs/cs42l43.c b/sound/soc/codecs/cs42l43.c
index 83c21c17fb80b..4e3d9c1d87d42 100644
--- a/sound/soc/codecs/cs42l43.c
+++ b/sound/soc/codecs/cs42l43.c
@@ -2402,9 +2402,22 @@ static int cs42l43_codec_runtime_resume(struct device *dev)
 	return 0;
 }
 
+static int cs42l43_codec_runtime_force_suspend(struct device *dev)
+{
+	struct cs42l43_codec *priv = dev_get_drvdata(dev);
+
+	dev_dbg(priv->dev, "Runtime suspend\n");
+
+	priv->suspend_jack_debounce = true;
+
+	pm_runtime_force_suspend(dev);
+
+	return 0;
+}
+
 static const struct dev_pm_ops cs42l43_codec_pm_ops = {
 	RUNTIME_PM_OPS(NULL, cs42l43_codec_runtime_resume, NULL)
-	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
+	SET_SYSTEM_SLEEP_PM_OPS(cs42l43_codec_runtime_force_suspend, pm_runtime_force_resume)
 };
 
 static const struct platform_device_id cs42l43_codec_id_table[] = {
diff --git a/sound/soc/codecs/cs42l43.h b/sound/soc/codecs/cs42l43.h
index 9c144e129535f..1cd9d8a71c439 100644
--- a/sound/soc/codecs/cs42l43.h
+++ b/sound/soc/codecs/cs42l43.h
@@ -78,6 +78,8 @@ struct cs42l43_codec {
 
 	bool use_ring_sense;
 	unsigned int tip_debounce_ms;
+	unsigned int tip_fall_db_ms;
+	unsigned int tip_rise_db_ms;
 	unsigned int bias_low;
 	unsigned int bias_sense_ua;
 	unsigned int bias_ramp_ms;
@@ -95,6 +97,7 @@ struct cs42l43_codec {
 	bool button_detect_running;
 	bool jack_present;
 	int jack_override;
+	bool suspend_jack_debounce;
 
 	struct work_struct hp_ilimit_work;
 	struct delayed_work hp_ilimit_clear_work;
-- 
2.39.5


