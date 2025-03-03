Return-Path: <stable+bounces-120154-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D52A4C83D
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 17:53:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C756616666D
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 16:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C732676CA;
	Mon,  3 Mar 2025 16:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Em3ZTT/7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806D822DFFA;
	Mon,  3 Mar 2025 16:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741019519; cv=none; b=VShV2UL0THLkPxox3X4Ecg1wwmHd9jE4tXSc6HBu7WT2Z/3fwS8L3at6i6G6RRR9dAvGh7dL+NdugyDy6of40oI1m1iKyC8Cz2yEt8GvchqjtF7E1vPRk7d6GvIsH19PN3NtmYM0bcAiTw5/r1veKJZSB1i8iPtxiiuKMMX6unI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741019519; c=relaxed/simple;
	bh=72HzNSmwxNQD2NBbRp2lzFjeU8fCpMlOt13oP3mSagg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hX/EXBGNnDTimKHH0IMfhRxz9fSYdoOa+1BrR7rBDb9jNoPwnub7jUFOZfUxRjs54trhBA6zg8ksoXLEIa9zhIBPpcawuAAaLsIHSfWYmLthpvGvcGMl/sqQh+QcDT/jx9eBafPVU9uqVWjAoUwEuzYRfIvvYvmGJvMDQtQUvKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Em3ZTT/7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB438C4CED6;
	Mon,  3 Mar 2025 16:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741019519;
	bh=72HzNSmwxNQD2NBbRp2lzFjeU8fCpMlOt13oP3mSagg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Em3ZTT/7t3kb2E7m/NQtaE5F1MCjcXnQgCXq0IUB7p6ddZlYGu31ybQ+7crv+LYTN
	 /MYaubcyVIPJWw3mqSTRXiM2tc/wH1Sjy3LkzrcEy7HToZU+ZvHYMwD1o4iWH79L/K
	 6uMpQS/ep6Sw32yUPNjAyjszSlUC/hK2ZzXrGKHDyyRtvXJEjzxE/Fjw2MhEDdfAwC
	 ypYeZCtr8jHnjYGqxC9ZcHe1GQPmKvHur4B192p4RhXaL11mBEml5EAf6JZKE/o+qQ
	 uZYz+jDDfQjyYXrv1Ga5Gb6oq9+EdDRjJvUqPkmfCvtqKquAoeruTZYH+32gSlPzAa
	 bzMdfoqlu1sdg==
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
Subject: [PATCH AUTOSEL 5.15 3/9] ASoC: tas2764: Set the SDOUT polarity correctly
Date: Mon,  3 Mar 2025 11:31:46 -0500
Message-Id: <20250303163152.3764156-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250303163152.3764156-1-sashal@kernel.org>
References: <20250303163152.3764156-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.178
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
index 1951bae95b315..273bf4027a6e5 100644
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


