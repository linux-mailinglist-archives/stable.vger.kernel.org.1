Return-Path: <stable+bounces-150206-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42036ACB68B
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 17:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED1D6A21104
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 15:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1EE6239E92;
	Mon,  2 Jun 2025 14:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="o74E1Kz6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8E522156E;
	Mon,  2 Jun 2025 14:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748876373; cv=none; b=lzAF86Ku2WA3jNBskzeAxC2yKc2H99KTlU2O38B6tN3zmomLjWmy2oRm7J96b5znAbDlRzeHc3Jlt7IX1BAbRLrxwsK9flXHs5XCeL7lgfknoe8mqvwnRQulW4fhbkwpRfbAiiUrkvaGWW0M4eERktY0h0L15OK8kFdklWNL3xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748876373; c=relaxed/simple;
	bh=VylnrdA5jKCZiPrJwr9Na3/etvIxbQ8K/LeGX4ecR1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qlqg6olMbyFo2QZG6X8Fye/YkY1aYHBYz1WNJmIYFNf1/h2rIKlQ2F1X5RzPRokKCyRpuJoC8UwfwWKftB1V23POzhUtF0Js321kLqGToLlS2GvuhXrHpZP4SadymWz/ACneMwRDHc41OX7LccUj55szVoExcmZbc1T7YQRV75Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=o74E1Kz6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6E74C4CEEE;
	Mon,  2 Jun 2025 14:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748876373;
	bh=VylnrdA5jKCZiPrJwr9Na3/etvIxbQ8K/LeGX4ecR1E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o74E1Kz6MIkGpGoHiFJ5gbti24/16zQ9e2iGAz7CjVT4chIZCMUo7SMtPuZbwP04X
	 SviGAKswkQPgQiqhoh0wzEJ/cbOOvflh7YwNOyFqwO+45DUF+j141otwkxMY6J2uBR
	 VbE/2i4EwmQderI/ituqbvimM+mAOXpEw+jrfNJU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hector Martin <marcan@marcan.st>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 116/207] ASoC: tas2764: Power up/down amp on mute ops
Date: Mon,  2 Jun 2025 15:48:08 +0200
Message-ID: <20250602134303.267264752@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602134258.769974467@linuxfoundation.org>
References: <20250602134258.769974467@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 273bf4027a6e5..559a160e1f4d9 100644
--- a/sound/soc/codecs/tas2764.c
+++ b/sound/soc/codecs/tas2764.c
@@ -130,33 +130,6 @@ static SOC_ENUM_SINGLE_DECL(
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
@@ -169,8 +142,7 @@ static const struct snd_soc_dapm_widget tas2764_dapm_widgets[] = {
 			    1, &isense_switch),
 	SND_SOC_DAPM_SWITCH("VSENSE", TAS2764_PWR_CTRL, TAS2764_VSENSE_POWER_EN,
 			    1, &vsense_switch),
-	SND_SOC_DAPM_DAC_E("DAC", NULL, SND_SOC_NOPM, 0, 0, tas2764_dac_event,
-			   SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
+	SND_SOC_DAPM_DAC("DAC", NULL, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_OUTPUT("OUT"),
 	SND_SOC_DAPM_SIGGEN("VMON"),
 	SND_SOC_DAPM_SIGGEN("IMON")
@@ -191,9 +163,28 @@ static int tas2764_mute(struct snd_soc_dai *dai, int mute, int direction)
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




