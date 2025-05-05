Return-Path: <stable+bounces-140340-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D15AAA795
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D2F97AB2A9
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D793C33D7D4;
	Mon,  5 May 2025 22:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VJCuFm06"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BEB233DE0D;
	Mon,  5 May 2025 22:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484660; cv=none; b=OFyM3o/xi8btreefA+n/20pV8myB7y8S5NU9FzaqvTXFrA8oIewkLbAfwobiJT7PuVyRO5v82378IuQdVxhfnSAH+NF4jm20VlUUa9HIY/aJEtySXaaqGmWO/UUS3Wjt0Mcx05UMHbS07k4gZa+TeA/WI5UG2b0ggGVX/7Sy9Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484660; c=relaxed/simple;
	bh=SaAZ5YJkRyvfrSgUrMmePOISIBScFqRsqLDvQq2gi5w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D/LeR34RZopoNb/KNwjJYarGTeggFY6iuuM6kXxYa3UT6idq1DE7gOJ8dYh2AoPgoP5HMeOPv3VCPv+eld6BjKONRjOYTO5cEgYcIV0yuwPBfT53l1QpbSCbdOSkeYZ4zx6RDbr5qm1pviOAlI9idFusbUoWEtgY2HyK4l38fOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VJCuFm06; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AD6EC4CEEE;
	Mon,  5 May 2025 22:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484660;
	bh=SaAZ5YJkRyvfrSgUrMmePOISIBScFqRsqLDvQq2gi5w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VJCuFm06qgEWn/IqTW5ZpIPvsAc/HOIYejMfXXhq9fcJ86Lh7vSlQ8axItNHR7eMf
	 gF0zwVN/lnb1k0YJqzHSS/KYtyh3zqtQC4uTtt3McT7GISGjoS5DPYQS+iubw8brFl
	 KNOmms0HXi2BR5w3LXqysSucfcHTBzi8RhixqGlH9JqMCCq1g+Z8i7dAAWPwIhZb1a
	 l7Sxb5P8c9RgP4AiFuZrkFQNRnUGzHQIUGnufh46f+DCAeZ1j+VNaltjwE1UYSnhty
	 oM7v3YG7bXq/4RKUjoFVcmz4PNLe+j8CNzkub2hosHksKDzkDqZy+H917cM/uNYwL8
	 Qwpdne2vvH+ng==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	javier.carrasco.cruz@gmail.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 591/642] ASoC: cpcap: Implement .set_bias_level
Date: Mon,  5 May 2025 18:13:27 -0400
Message-Id: <20250505221419.2672473-591-sashal@kernel.org>
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

From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>

[ Upstream commit 5b4288792ff246cf2bda0c81cebcc02d1f631ca3 ]

With VAUDIO regulator being always on, we have to put it in low-power mode
when codec is not in use to decrease power usage.

Do so by implementing driver .set_bias_level callback.

Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Link: https://patch.msgid.link/20250122164129.807247-3-ivo.g.dimitrov.75@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/cpcap.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/sound/soc/codecs/cpcap.c b/sound/soc/codecs/cpcap.c
index 04304a7ad9153..53f549ede6a6f 100644
--- a/sound/soc/codecs/cpcap.c
+++ b/sound/soc/codecs/cpcap.c
@@ -11,6 +11,7 @@
 #include <linux/module.h>
 #include <linux/regmap.h>
 #include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
 #include <linux/mfd/motorola-cpcap.h>
 #include <sound/core.h>
 #include <sound/soc.h>
@@ -260,6 +261,7 @@ struct cpcap_audio {
 	int codec_clk_id;
 	int codec_freq;
 	int codec_format;
+	struct regulator *vaudio;
 };
 
 static int cpcap_st_workaround(struct snd_soc_dapm_widget *w,
@@ -1637,6 +1639,11 @@ static int cpcap_soc_probe(struct snd_soc_component *component)
 	snd_soc_component_set_drvdata(component, cpcap);
 	cpcap->component = component;
 
+	cpcap->vaudio = devm_regulator_get(component->dev, "VAUDIO");
+	if (IS_ERR(cpcap->vaudio))
+		return dev_err_probe(component->dev, PTR_ERR(cpcap->vaudio),
+				     "Cannot get VAUDIO regulator\n");
+
 	cpcap->regmap = dev_get_regmap(component->dev->parent, NULL);
 	if (!cpcap->regmap)
 		return -ENODEV;
@@ -1649,6 +1656,27 @@ static int cpcap_soc_probe(struct snd_soc_component *component)
 	return cpcap_audio_reset(component, false);
 }
 
+static int cpcap_set_bias_level(struct snd_soc_component *component,
+		enum snd_soc_bias_level level)
+{
+	struct cpcap_audio *cpcap = snd_soc_component_get_drvdata(component);
+
+	switch (level) {
+	case SND_SOC_BIAS_OFF:
+		break;
+	case SND_SOC_BIAS_PREPARE:
+		regulator_set_mode(cpcap->vaudio, REGULATOR_MODE_NORMAL);
+		break;
+	case SND_SOC_BIAS_STANDBY:
+		regulator_set_mode(cpcap->vaudio, REGULATOR_MODE_STANDBY);
+		break;
+	case SND_SOC_BIAS_ON:
+		break;
+	}
+
+	return 0;
+}
+
 static const struct snd_soc_component_driver soc_codec_dev_cpcap = {
 	.probe			= cpcap_soc_probe,
 	.controls		= cpcap_snd_controls,
@@ -1657,6 +1685,7 @@ static const struct snd_soc_component_driver soc_codec_dev_cpcap = {
 	.num_dapm_widgets	= ARRAY_SIZE(cpcap_dapm_widgets),
 	.dapm_routes		= intercon,
 	.num_dapm_routes	= ARRAY_SIZE(intercon),
+	.set_bias_level		= cpcap_set_bias_level,
 	.idle_bias_on		= 1,
 	.use_pmdown_time	= 1,
 	.endianness		= 1,
-- 
2.39.5


