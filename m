Return-Path: <stable+bounces-120163-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A36CA4C858
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 17:56:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42057174CDC
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 16:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED1FD270048;
	Mon,  3 Mar 2025 16:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VZlypjLA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A688526FDA6;
	Mon,  3 Mar 2025 16:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741019538; cv=none; b=Y2LAnyfv72K91zQDBf7ZCoz+SDrL7njJtIjwIuPP1S5i4cXixkgymxMt5m5lkrr/wgB0LthS/BHfdhQZpBh74CNlC8iu3S7yvGLl6jSKTrH5bS22mL7TmSgaygQtQhK2sKiaJLB6z/Fixe+w10P9Pk/3uXGY01TgvTbXhn7kUsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741019538; c=relaxed/simple;
	bh=CCUwxqKobXieSTyYaGeyLx8VcuRA9frHOzOZcR1ixYI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HkgwlknSsvj4H5DjVe9zUJ4HXQi3s9sxnFHqQRBVJw4PbjW8TGmZWNu+9NDGjGOsjzYYQyTgnWWkCS+6a9FRj82Y8RLOVpa3zgmjJA2BWWyXOXS82YSQsLcDTPd0nYpG5wR98e/criLN2BHMSJ9aJNYWV37e8l5oYC2vBpZ4wgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VZlypjLA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FA6CC4CED6;
	Mon,  3 Mar 2025 16:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741019538;
	bh=CCUwxqKobXieSTyYaGeyLx8VcuRA9frHOzOZcR1ixYI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VZlypjLAc9jlkbcdMkaVW0UX0+H0EawFcXez9kPG/mBP0RXqJoaZ1c9VsxMLQZioI
	 r/aMhd8aR5divrSA1CYuq9/oIu5t8sx9bZVX+VWs1H7cH3AJi815fSj5Reg547wtgg
	 +XsHRZA7Sq8JtPdgjFh3mxFHzO8KQgUoOvm9G7omkc+M+QyfutuAp342XLmK6UANcT
	 L3KGKHy5AFSnrk+Hg+q2fowbmfqOeNmyxNeE532mLujXL7XBLFUnNSHpH+AXrFRJr8
	 yPzVq2n68As5ds/OBtUeumpa3LgvuzKkvLWzUcEvpN2Sfk7yXv9dD82A79U8U1ksD7
	 Th7EWQEqHmIMA==
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
Subject: [PATCH AUTOSEL 5.10 3/8] ASoC: tas2764: Set the SDOUT polarity correctly
Date: Mon,  3 Mar 2025 11:32:06 -0500
Message-Id: <20250303163211.3764282-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250303163211.3764282-1-sashal@kernel.org>
References: <20250303163211.3764282-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.234
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
index c8f6f5122cacb..dd8eeafa223e8 100644
--- a/sound/soc/codecs/tas2764.c
+++ b/sound/soc/codecs/tas2764.c
@@ -315,7 +315,7 @@ static int tas2764_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 {
 	struct snd_soc_component *component = dai->component;
 	struct tas2764_priv *tas2764 = snd_soc_component_get_drvdata(component);
-	u8 tdm_rx_start_slot = 0, asi_cfg_0 = 0, asi_cfg_1 = 0;
+	u8 tdm_rx_start_slot = 0, asi_cfg_0 = 0, asi_cfg_1 = 0, asi_cfg_4 = 0;
 	int ret;
 
 	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
@@ -324,12 +324,14 @@ static int tas2764_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
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
 
@@ -339,6 +341,12 @@ static int tas2764_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
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
index b18a637bd9fa3..337bc611bee96 100644
--- a/sound/soc/codecs/tas2764.h
+++ b/sound/soc/codecs/tas2764.h
@@ -75,6 +75,12 @@
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


