Return-Path: <stable+bounces-140164-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB9BAAA5BD
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 307557B04F9
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 23:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93681B07AE;
	Mon,  5 May 2025 22:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QWGQTfkX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6166B316DFB;
	Mon,  5 May 2025 22:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484259; cv=none; b=hqnHoszPMMwAWLwG5GZsOdYOaBT5SrnvyhJcUt1MbuiHC/HM9t9SofkPqADZ3auPB5/IDGLQ6FLarQSeuk+60z40KqDRlle7IdNJ0kVNIkluZ7Y2uX2XtT0FA3d8we2l0V1DzGv+n8yuhhBLUfkl11VghLEW4tEIIifarEnGjjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484259; c=relaxed/simple;
	bh=SjS9+0YGl9gyYeT3aLC2XdlP9I8AVA8D5VN8KpOmoP4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mAzYbnNTOrbxWz/A+Pd+yF14CEHD9YSx39HSj4dSeGmNlWYZRAwK1UwPnQru0+QOChLAxGV+G5Msl5oSAokM+B3eqncGSZ1spePNFnpNLzehaLDbkqzoGFoTbUW7NTMMTkX8u8hH9SXJlegj7P8bG//5Jd55H/9iB4Dg8EK/qf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QWGQTfkX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94668C4CEEF;
	Mon,  5 May 2025 22:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484258;
	bh=SjS9+0YGl9gyYeT3aLC2XdlP9I8AVA8D5VN8KpOmoP4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QWGQTfkX+PBX/6FcLbhQugwYfmIkGxJMquHS7pYKJ2u66QtVrfOSRj33ll6LH9Fax
	 yFKCHa3kTueMd9dBYgEZgL7Ck1ZzVibhssNJtN85FmzjCPwYGrPDn9XJ2BvM23GkEW
	 VQX5gTuBt5Du5Ipwc8J61Agg9lFwFajUiOnC+of+zrIbDvdfJCI+pqYZKa4CS8Bqcu
	 6FKnAo5Yh2T5ch4HNj7kOdTe9lZBMXxOyve7fTRSW6MeNFX7tL2QhYDNFVjAeLTvbL
	 6eUciG/76YXSMkYyivleJjwzqNWaQ3Hh47x6QQBUA9X97Z0RKLCfaZlsMF3eiatkvq
	 ntc+n3BClLYuw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hector Martin <marcan@marcan.st>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	shenghao-ding@ti.com,
	kevin-lu@ti.com,
	baojun.xu@ti.com,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 417/642] ASoC: tas2764: Power up/down amp on mute ops
Date: Mon,  5 May 2025 18:10:33 -0400
Message-Id: <20250505221419.2672473-417-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Hector Martin <marcan@marcan.st>

[ Upstream commit 1c3b5f37409682184669457a5bdf761268eafbe5 ]

The ASoC convention is that clocks are removed after codec mute, and
power up/down is more about top level power management. For these chips,
the "mute" state still expects a TDM clock, and yanking the clock in
this state will trigger clock errors. So, do the full
shutdown<->mute<->active transition on the mute operation, so the amp is
in software shutdown by the time the clocks are removed.

This fixes TDM clock errors when streams are stopped.

Signed-off-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Mark Brown <broonie@kernel.org>
Link: https://patch.msgid.link/20250208-asoc-tas2764-v1-1-dbab892a69b5@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/tas2764.c | 51 ++++++++++++++++----------------------
 1 file changed, 21 insertions(+), 30 deletions(-)

diff --git a/sound/soc/codecs/tas2764.c b/sound/soc/codecs/tas2764.c
index 31f94c8cf2844..39a7d39536fe6 100644
--- a/sound/soc/codecs/tas2764.c
+++ b/sound/soc/codecs/tas2764.c
@@ -180,33 +180,6 @@ static SOC_ENUM_SINGLE_DECL(
 static const struct snd_kcontrol_new tas2764_asi1_mux =
 	SOC_DAPM_ENUM("ASI1 Source", tas2764_ASI1_src_enum);
 
-static int tas2764_dac_event(struct snd_soc_dapm_widget *w,
-			     struct snd_kcontrol *kcontrol, int event)
-{
-	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
-	struct tas2764_priv *tas2764 = snd_soc_component_get_drvdata(component);
-	int ret;
-
-	switch (event) {
-	case SND_SOC_DAPM_POST_PMU:
-		tas2764->dac_powered = true;
-		ret = tas2764_update_pwr_ctrl(tas2764);
-		break;
-	case SND_SOC_DAPM_PRE_PMD:
-		tas2764->dac_powered = false;
-		ret = tas2764_update_pwr_ctrl(tas2764);
-		break;
-	default:
-		dev_err(tas2764->dev, "Unsupported event\n");
-		return -EINVAL;
-	}
-
-	if (ret < 0)
-		return ret;
-
-	return 0;
-}
-
 static const struct snd_kcontrol_new isense_switch =
 	SOC_DAPM_SINGLE("Switch", TAS2764_PWR_CTRL, TAS2764_ISENSE_POWER_EN, 1, 1);
 static const struct snd_kcontrol_new vsense_switch =
@@ -219,8 +192,7 @@ static const struct snd_soc_dapm_widget tas2764_dapm_widgets[] = {
 			    1, &isense_switch),
 	SND_SOC_DAPM_SWITCH("VSENSE", TAS2764_PWR_CTRL, TAS2764_VSENSE_POWER_EN,
 			    1, &vsense_switch),
-	SND_SOC_DAPM_DAC_E("DAC", NULL, SND_SOC_NOPM, 0, 0, tas2764_dac_event,
-			   SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
+	SND_SOC_DAPM_DAC("DAC", NULL, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_OUTPUT("OUT"),
 	SND_SOC_DAPM_SIGGEN("VMON"),
 	SND_SOC_DAPM_SIGGEN("IMON")
@@ -241,9 +213,28 @@ static int tas2764_mute(struct snd_soc_dai *dai, int mute, int direction)
 {
 	struct tas2764_priv *tas2764 =
 			snd_soc_component_get_drvdata(dai->component);
+	int ret;
+
+	if (!mute) {
+		tas2764->dac_powered = true;
+		ret = tas2764_update_pwr_ctrl(tas2764);
+		if (ret)
+			return ret;
+	}
 
 	tas2764->unmuted = !mute;
-	return tas2764_update_pwr_ctrl(tas2764);
+	ret = tas2764_update_pwr_ctrl(tas2764);
+	if (ret)
+		return ret;
+
+	if (mute) {
+		tas2764->dac_powered = false;
+		ret = tas2764_update_pwr_ctrl(tas2764);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
 }
 
 static int tas2764_set_bitwidth(struct tas2764_priv *tas2764, int bitwidth)
-- 
2.39.5


