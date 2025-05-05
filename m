Return-Path: <stable+bounces-140770-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14546AAAB11
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F153D4A3AC7
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934462853EA;
	Mon,  5 May 2025 23:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DqqfD4Vs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2813D37110E;
	Mon,  5 May 2025 23:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486203; cv=none; b=HdSzHbw2Upy/v+bhAtUS72Cj+0g+bcW0pDJrZ8ceMcZCQW/2p692I8mmCglKsC/DN+0pRsIwdtObIUoYdzFE/F9ByV+FHprRt3g2vtyt7p8FwP5qxmdasl9SjQUrGv23rP4OU+0inBA1S+GKBpnTd+1Odf1YDBuW0IsEFBLzHJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486203; c=relaxed/simple;
	bh=VANGKJ/hWRZQE3K4azUCQVQX14rz4VpksVyyQjJ1Szo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t26GFdL8iEGJtgoGBGeF40+6dRDy66zjFytyrRSkCI9gH7cSvzEiqYPO05HC7AEcpInW0DJjhlmvaVM7VU7gBYKS2Mb3o2wFSbbTFmirj5rROfTVsKK49ejCdMi8bVYvrYA32AncHPsXI9rBjqunVVuY1XX0wWioF7mSigp8QKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DqqfD4Vs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA7BEC4CEED;
	Mon,  5 May 2025 23:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486202;
	bh=VANGKJ/hWRZQE3K4azUCQVQX14rz4VpksVyyQjJ1Szo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DqqfD4VsJ1YgjFOmm0JyjBcMnTMq2RD1gOK9IsMgrrhBn+LJE+7bKVAlSi6IHW4WP
	 XgLxnev4ZFDAmsdv3uMi1SJTjT+NyisWYFW0CH8motKdZRqeyHNlG4pp8R6ZOeucdn
	 mjKlkwIJwCupK1YjAv+GXL8ZrlilUqCjSoCeVBCZ/LZt74CkyGAV8BiO3bQ+z1nWjr
	 QUWRuc5M/CRlnAcTwX9w5n3TJYRpAMsYTatOrqbmTOHx0oNgDYC37rh4dkmSdLLr87
	 HE5AOCnUtktm7osIDb6MqLcwNUAC4KAbderojg+Tge4HV6ZhMBV/xFjDPRLTrO4a71
	 5Cyl+WHqMHv7w==
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
Subject: [PATCH AUTOSEL 6.6 202/294] ASoC: tas2764: Power up/down amp on mute ops
Date: Mon,  5 May 2025 18:55:02 -0400
Message-Id: <20250505225634.2688578-202-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
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
index 3f622d629f77a..72d6356b89814 100644
--- a/sound/soc/codecs/tas2764.c
+++ b/sound/soc/codecs/tas2764.c
@@ -182,33 +182,6 @@ static SOC_ENUM_SINGLE_DECL(
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
@@ -221,8 +194,7 @@ static const struct snd_soc_dapm_widget tas2764_dapm_widgets[] = {
 			    1, &isense_switch),
 	SND_SOC_DAPM_SWITCH("VSENSE", TAS2764_PWR_CTRL, TAS2764_VSENSE_POWER_EN,
 			    1, &vsense_switch),
-	SND_SOC_DAPM_DAC_E("DAC", NULL, SND_SOC_NOPM, 0, 0, tas2764_dac_event,
-			   SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
+	SND_SOC_DAPM_DAC("DAC", NULL, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_OUTPUT("OUT"),
 	SND_SOC_DAPM_SIGGEN("VMON"),
 	SND_SOC_DAPM_SIGGEN("IMON")
@@ -243,9 +215,28 @@ static int tas2764_mute(struct snd_soc_dai *dai, int mute, int direction)
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


