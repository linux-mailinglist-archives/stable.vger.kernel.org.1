Return-Path: <stable+bounces-120101-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 833CCA4C741
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 17:32:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9E711885AE1
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 16:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2EDF21B9EC;
	Mon,  3 Mar 2025 16:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IFFM+Irh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B7221ADAB;
	Mon,  3 Mar 2025 16:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741019400; cv=none; b=drSBc2BFl2Yj4SPRfWk60AcYwaDJAoxj66ilO16GCXovmMMAZL91YfNajIxiUCb+ap5vYSe062/llg5/X7x2Fu684qXXsjsKqSt9VpoYIX8sJYbSFPOvgiK7MxjqxYvCnGDeUimI+JHX1qsv4aAfQmGgdS0NG/Zdo+JiAo6tE5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741019400; c=relaxed/simple;
	bh=+rFti7JLUng9uHNaMUDth1nB7fGY2RDLZ1u53Q8SCPM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fRCHvaV5PZolRsDyoct3ViTQTsTBChzZamqtIZbuLD0FGYq3Iuw5wS66Qwnc/IKcL7uFl3iiMCGqmGwlS8xOEd1AU5LieXTR0iESneSCD8yNkZQ1Ws0NYEUHVEYyfbVZ5hpJP3AEijYf+Z5zAYUcCUegOqhpFZux9Ig7RIJgdrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IFFM+Irh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C97ADC4CED6;
	Mon,  3 Mar 2025 16:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741019400;
	bh=+rFti7JLUng9uHNaMUDth1nB7fGY2RDLZ1u53Q8SCPM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IFFM+IrhVk5ifguH4KiX9LHkqoWqYv7CJXgXEO56HcUMbXzKBJHIUQ1RuCpv4ObhH
	 +k0AQWkEHDXxJGqYxkCyYR43/zxVVpJ8xiE9AZlTpa4XaEiNwVhjuJNm7pXLnjcQO3
	 t6D3ETpvonoUCqWZrRZT5CdJq+sixp4dZZ0Fldx9K5OgCyXUpXC8JFtfiAHuGG20rd
	 y0DwJUqBiwz91cmbP0i33mOCEzpqK2P3E76g4b+nK2y+u34x3xQC7uklRlU7EWIQO2
	 UJuaxsfmrfrCb3akOMFnoo7v0+ki/UVGofrPCFCDOxwk2rc5b8tE1E+Zqbw9xXtKEm
	 W2EN7ILQ1763w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hector Martin <marcan@marcan.st>,
	Neal Gompa <neal@gompa.dev>,
	James Calligeros <jcalligeros99@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	shenghao-ding@ti.com,
	kevin-lu@ti.com,
	baojun.xu@ti.com,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.13 04/17] ASoC: tas2764: Set the SDOUT polarity correctly
Date: Mon,  3 Mar 2025 11:29:36 -0500
Message-Id: <20250303162951.3763346-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250303162951.3763346-1-sashal@kernel.org>
References: <20250303162951.3763346-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.5
Content-Transfer-Encoding: 8bit

From: Hector Martin <marcan@marcan.st>

[ Upstream commit f5468beeab1b1adfc63c2717b1f29ef3f49a5fab ]

TX launch polarity needs to be the opposite of RX capture polarity, to
generate the right bit slot alignment.

Reviewed-by: Neal Gompa <neal@gompa.dev>
Signed-off-by: Hector Martin <marcan@marcan.st>
Signed-off-by: James Calligeros <jcalligeros99@gmail.com>
Link: https://patch.msgid.link/20250218-apple-codec-changes-v2-28-932760fd7e07@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/tas2764.c | 10 +++++++++-
 sound/soc/codecs/tas2764.h |  6 ++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tas2764.c b/sound/soc/codecs/tas2764.c
index d482cd194c08c..58315eab492a1 100644
--- a/sound/soc/codecs/tas2764.c
+++ b/sound/soc/codecs/tas2764.c
@@ -365,7 +365,7 @@ static int tas2764_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 {
 	struct snd_soc_component *component = dai->component;
 	struct tas2764_priv *tas2764 = snd_soc_component_get_drvdata(component);
-	u8 tdm_rx_start_slot = 0, asi_cfg_0 = 0, asi_cfg_1 = 0;
+	u8 tdm_rx_start_slot = 0, asi_cfg_0 = 0, asi_cfg_1 = 0, asi_cfg_4 = 0;
 	int ret;
 
 	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
@@ -374,12 +374,14 @@ static int tas2764_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 		fallthrough;
 	case SND_SOC_DAIFMT_NB_NF:
 		asi_cfg_1 = TAS2764_TDM_CFG1_RX_RISING;
+		asi_cfg_4 = TAS2764_TDM_CFG4_TX_FALLING;
 		break;
 	case SND_SOC_DAIFMT_IB_IF:
 		asi_cfg_0 ^= TAS2764_TDM_CFG0_FRAME_START;
 		fallthrough;
 	case SND_SOC_DAIFMT_IB_NF:
 		asi_cfg_1 = TAS2764_TDM_CFG1_RX_FALLING;
+		asi_cfg_4 = TAS2764_TDM_CFG4_TX_RISING;
 		break;
 	}
 
@@ -389,6 +391,12 @@ static int tas2764_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	if (ret < 0)
 		return ret;
 
+	ret = snd_soc_component_update_bits(component, TAS2764_TDM_CFG4,
+					    TAS2764_TDM_CFG4_TX_MASK,
+					    asi_cfg_4);
+	if (ret < 0)
+		return ret;
+
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_I2S:
 		asi_cfg_0 ^= TAS2764_TDM_CFG0_FRAME_START;
diff --git a/sound/soc/codecs/tas2764.h b/sound/soc/codecs/tas2764.h
index d13ecae9c9c2f..9490f2686e389 100644
--- a/sound/soc/codecs/tas2764.h
+++ b/sound/soc/codecs/tas2764.h
@@ -79,6 +79,12 @@
 #define TAS2764_TDM_CFG3_RXS_SHIFT	0x4
 #define TAS2764_TDM_CFG3_MASK		GENMASK(3, 0)
 
+/* TDM Configuration Reg4 */
+#define TAS2764_TDM_CFG4		TAS2764_REG(0X0, 0x0d)
+#define TAS2764_TDM_CFG4_TX_MASK	BIT(0)
+#define TAS2764_TDM_CFG4_TX_RISING	0x0
+#define TAS2764_TDM_CFG4_TX_FALLING	BIT(0)
+
 /* TDM Configuration Reg5 */
 #define TAS2764_TDM_CFG5		TAS2764_REG(0X0, 0x0e)
 #define TAS2764_TDM_CFG5_VSNS_MASK	BIT(6)
-- 
2.39.5


