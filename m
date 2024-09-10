Return-Path: <stable+bounces-75407-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B88197346A
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 12:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AC5128E148
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 10:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ECAA1922CA;
	Tue, 10 Sep 2024 10:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ae3ADJAK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15D214D280;
	Tue, 10 Sep 2024 10:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725964642; cv=none; b=eCnROWuKgKTR/UGnaf8kJayyRiAF2AkbPeLnBJ4AsysegRRCdcSAXpH4X6iv4lPZnx9Q6A8JC3iKBgy1V5kMec3Rlf/JPW018a3/7Njxz974TyS8tSt+9yyq8IPLAGckVnHMliGLo0WSogPoLr2xMbFaozwvPTL0Yv2sr93wAaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725964642; c=relaxed/simple;
	bh=+NexW2TSgi+Yi6qKjNSebbjVF08kb5HHLJeYxBLj2Os=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Evn0cGZu1Ps77HUmJYMBRe2xbGqOrhL5HlVo8JoZoYGcRwQTiHO2xamLww9Kq1KVxTZiLeELd+Et4/oRz87wn2qwT+7oDFHOl4tyky2QZzPtC1cQ5ZBEYkyB5DSwPXSW9taCjzZxlHQPPPht79MwDrU3hxn0Na8A3QPasieuWBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ae3ADJAK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66B0CC4CEC3;
	Tue, 10 Sep 2024 10:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725964641;
	bh=+NexW2TSgi+Yi6qKjNSebbjVF08kb5HHLJeYxBLj2Os=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ae3ADJAKl1wsX4Eah548tXXLPfkgYSxgW8ufWB+FrDEPFXdvh1Qm87vj/UvrwFiPZ
	 eswPlBoHorN6gYYKYvOig5EzMpvBUK7hmBJmC8G8jjIZSqi7HpWpznZcZG76t7kvBt
	 zmNeZt1Zt+OKRcGSHIpDQzpIZtrweOaarIptJi2Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Matteo Martelli <matteomartelli3@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 252/269] ASoC: sunxi: sun4i-i2s: fix LRCLK polarity in i2s mode
Date: Tue, 10 Sep 2024 11:33:59 +0200
Message-ID: <20240910092616.789885845@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910092608.225137854@linuxfoundation.org>
References: <20240910092608.225137854@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matteo Martelli <matteomartelli3@gmail.com>

[ Upstream commit 3e83957e8dd7433a69116780d9bad217b00913ea ]

This fixes the LRCLK polarity for sun8i-h3 and sun50i-h6 in i2s mode
which was wrongly inverted.

The LRCLK was being set in reversed logic compared to the DAI format:
inverted LRCLK for SND_SOC_DAIFMT_IB_NF and SND_SOC_DAIFMT_NB_NF; normal
LRCLK for SND_SOC_DAIFMT_IB_IF and SND_SOC_DAIFMT_NB_IF. Such reversed
logic applies properly for DSP_A, DSP_B, LEFT_J and RIGHT_J modes but
not for I2S mode, for which the LRCLK signal results reversed to what
expected on the bus. The issue is due to a misinterpretation of the
LRCLK polarity bit of the H3 and H6 i2s controllers. Such bit in this
case does not mean "0 => normal" or "1 => inverted" according to the
expected bus operation, but it means "0 => frame starts on low edge" and
"1 => frame starts on high edge" (from the User Manuals).

This commit fixes the LRCLK polarity by setting the LRCLK polarity bit
according to the selected bus mode and renames the LRCLK polarity bit
definition to avoid further confusion.

Fixes: dd657eae8164 ("ASoC: sun4i-i2s: Fix the LRCK polarity")
Fixes: 73adf87b7a58 ("ASoC: sun4i-i2s: Add support for H6 I2S")
Signed-off-by: Matteo Martelli <matteomartelli3@gmail.com>
Link: https://patch.msgid.link/20240801-asoc-fix-sun4i-i2s-v2-1-a8e4e9daa363@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sunxi/sun4i-i2s.c | 143 ++++++++++++++++++------------------
 1 file changed, 73 insertions(+), 70 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index 5124b6c9ceb4..d1cb49d54f00 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -100,8 +100,8 @@
 #define SUN8I_I2S_CTRL_MODE_PCM			(0 << 4)
 
 #define SUN8I_I2S_FMT0_LRCLK_POLARITY_MASK	BIT(19)
-#define SUN8I_I2S_FMT0_LRCLK_POLARITY_INVERTED		(1 << 19)
-#define SUN8I_I2S_FMT0_LRCLK_POLARITY_NORMAL		(0 << 19)
+#define SUN8I_I2S_FMT0_LRCLK_POLARITY_START_HIGH	(1 << 19)
+#define SUN8I_I2S_FMT0_LRCLK_POLARITY_START_LOW		(0 << 19)
 #define SUN8I_I2S_FMT0_LRCK_PERIOD_MASK		GENMASK(17, 8)
 #define SUN8I_I2S_FMT0_LRCK_PERIOD(period)	((period - 1) << 8)
 #define SUN8I_I2S_FMT0_BCLK_POLARITY_MASK	BIT(7)
@@ -727,65 +727,37 @@ static int sun4i_i2s_set_soc_fmt(const struct sun4i_i2s *i2s,
 static int sun8i_i2s_set_soc_fmt(const struct sun4i_i2s *i2s,
 				 unsigned int fmt)
 {
-	u32 mode, val;
+	u32 mode, lrclk_pol, bclk_pol, val;
 	u8 offset;
 
-	/*
-	 * DAI clock polarity
-	 *
-	 * The setup for LRCK contradicts the datasheet, but under a
-	 * scope it's clear that the LRCK polarity is reversed
-	 * compared to the expected polarity on the bus.
-	 */
-	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
-	case SND_SOC_DAIFMT_IB_IF:
-		/* Invert both clocks */
-		val = SUN8I_I2S_FMT0_BCLK_POLARITY_INVERTED;
-		break;
-	case SND_SOC_DAIFMT_IB_NF:
-		/* Invert bit clock */
-		val = SUN8I_I2S_FMT0_BCLK_POLARITY_INVERTED |
-		      SUN8I_I2S_FMT0_LRCLK_POLARITY_INVERTED;
-		break;
-	case SND_SOC_DAIFMT_NB_IF:
-		/* Invert frame clock */
-		val = 0;
-		break;
-	case SND_SOC_DAIFMT_NB_NF:
-		val = SUN8I_I2S_FMT0_LRCLK_POLARITY_INVERTED;
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	regmap_update_bits(i2s->regmap, SUN4I_I2S_FMT0_REG,
-			   SUN8I_I2S_FMT0_LRCLK_POLARITY_MASK |
-			   SUN8I_I2S_FMT0_BCLK_POLARITY_MASK,
-			   val);
-
 	/* DAI Mode */
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_DSP_A:
+		lrclk_pol = SUN8I_I2S_FMT0_LRCLK_POLARITY_START_HIGH;
 		mode = SUN8I_I2S_CTRL_MODE_PCM;
 		offset = 1;
 		break;
 
 	case SND_SOC_DAIFMT_DSP_B:
+		lrclk_pol = SUN8I_I2S_FMT0_LRCLK_POLARITY_START_HIGH;
 		mode = SUN8I_I2S_CTRL_MODE_PCM;
 		offset = 0;
 		break;
 
 	case SND_SOC_DAIFMT_I2S:
+		lrclk_pol = SUN8I_I2S_FMT0_LRCLK_POLARITY_START_LOW;
 		mode = SUN8I_I2S_CTRL_MODE_LEFT;
 		offset = 1;
 		break;
 
 	case SND_SOC_DAIFMT_LEFT_J:
+		lrclk_pol = SUN8I_I2S_FMT0_LRCLK_POLARITY_START_HIGH;
 		mode = SUN8I_I2S_CTRL_MODE_LEFT;
 		offset = 0;
 		break;
 
 	case SND_SOC_DAIFMT_RIGHT_J:
+		lrclk_pol = SUN8I_I2S_FMT0_LRCLK_POLARITY_START_HIGH;
 		mode = SUN8I_I2S_CTRL_MODE_RIGHT;
 		offset = 0;
 		break;
@@ -803,6 +775,35 @@ static int sun8i_i2s_set_soc_fmt(const struct sun4i_i2s *i2s,
 			   SUN8I_I2S_TX_CHAN_OFFSET_MASK,
 			   SUN8I_I2S_TX_CHAN_OFFSET(offset));
 
+	/* DAI clock polarity */
+	bclk_pol = SUN8I_I2S_FMT0_BCLK_POLARITY_NORMAL;
+
+	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
+	case SND_SOC_DAIFMT_IB_IF:
+		/* Invert both clocks */
+		lrclk_pol ^= SUN8I_I2S_FMT0_LRCLK_POLARITY_MASK;
+		bclk_pol = SUN8I_I2S_FMT0_BCLK_POLARITY_INVERTED;
+		break;
+	case SND_SOC_DAIFMT_IB_NF:
+		/* Invert bit clock */
+		bclk_pol = SUN8I_I2S_FMT0_BCLK_POLARITY_INVERTED;
+		break;
+	case SND_SOC_DAIFMT_NB_IF:
+		/* Invert frame clock */
+		lrclk_pol ^= SUN8I_I2S_FMT0_LRCLK_POLARITY_MASK;
+		break;
+	case SND_SOC_DAIFMT_NB_NF:
+		/* No inversion */
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	regmap_update_bits(i2s->regmap, SUN4I_I2S_FMT0_REG,
+			   SUN8I_I2S_FMT0_LRCLK_POLARITY_MASK |
+			   SUN8I_I2S_FMT0_BCLK_POLARITY_MASK,
+			   lrclk_pol | bclk_pol);
+
 	/* DAI clock master masks */
 	switch (fmt & SND_SOC_DAIFMT_CLOCK_PROVIDER_MASK) {
 	case SND_SOC_DAIFMT_BP_FP:
@@ -834,65 +835,37 @@ static int sun8i_i2s_set_soc_fmt(const struct sun4i_i2s *i2s,
 static int sun50i_h6_i2s_set_soc_fmt(const struct sun4i_i2s *i2s,
 				     unsigned int fmt)
 {
-	u32 mode, val;
+	u32 mode, lrclk_pol, bclk_pol, val;
 	u8 offset;
 
-	/*
-	 * DAI clock polarity
-	 *
-	 * The setup for LRCK contradicts the datasheet, but under a
-	 * scope it's clear that the LRCK polarity is reversed
-	 * compared to the expected polarity on the bus.
-	 */
-	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
-	case SND_SOC_DAIFMT_IB_IF:
-		/* Invert both clocks */
-		val = SUN8I_I2S_FMT0_BCLK_POLARITY_INVERTED;
-		break;
-	case SND_SOC_DAIFMT_IB_NF:
-		/* Invert bit clock */
-		val = SUN8I_I2S_FMT0_BCLK_POLARITY_INVERTED |
-		      SUN8I_I2S_FMT0_LRCLK_POLARITY_INVERTED;
-		break;
-	case SND_SOC_DAIFMT_NB_IF:
-		/* Invert frame clock */
-		val = 0;
-		break;
-	case SND_SOC_DAIFMT_NB_NF:
-		val = SUN8I_I2S_FMT0_LRCLK_POLARITY_INVERTED;
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	regmap_update_bits(i2s->regmap, SUN4I_I2S_FMT0_REG,
-			   SUN8I_I2S_FMT0_LRCLK_POLARITY_MASK |
-			   SUN8I_I2S_FMT0_BCLK_POLARITY_MASK,
-			   val);
-
 	/* DAI Mode */
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_DSP_A:
+		lrclk_pol = SUN8I_I2S_FMT0_LRCLK_POLARITY_START_HIGH;
 		mode = SUN8I_I2S_CTRL_MODE_PCM;
 		offset = 1;
 		break;
 
 	case SND_SOC_DAIFMT_DSP_B:
+		lrclk_pol = SUN8I_I2S_FMT0_LRCLK_POLARITY_START_HIGH;
 		mode = SUN8I_I2S_CTRL_MODE_PCM;
 		offset = 0;
 		break;
 
 	case SND_SOC_DAIFMT_I2S:
+		lrclk_pol = SUN8I_I2S_FMT0_LRCLK_POLARITY_START_LOW;
 		mode = SUN8I_I2S_CTRL_MODE_LEFT;
 		offset = 1;
 		break;
 
 	case SND_SOC_DAIFMT_LEFT_J:
+		lrclk_pol = SUN8I_I2S_FMT0_LRCLK_POLARITY_START_HIGH;
 		mode = SUN8I_I2S_CTRL_MODE_LEFT;
 		offset = 0;
 		break;
 
 	case SND_SOC_DAIFMT_RIGHT_J:
+		lrclk_pol = SUN8I_I2S_FMT0_LRCLK_POLARITY_START_HIGH;
 		mode = SUN8I_I2S_CTRL_MODE_RIGHT;
 		offset = 0;
 		break;
@@ -910,6 +883,36 @@ static int sun50i_h6_i2s_set_soc_fmt(const struct sun4i_i2s *i2s,
 			   SUN50I_H6_I2S_TX_CHAN_SEL_OFFSET_MASK,
 			   SUN50I_H6_I2S_TX_CHAN_SEL_OFFSET(offset));
 
+	/* DAI clock polarity */
+	bclk_pol = SUN8I_I2S_FMT0_BCLK_POLARITY_NORMAL;
+
+	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
+	case SND_SOC_DAIFMT_IB_IF:
+		/* Invert both clocks */
+		lrclk_pol ^= SUN8I_I2S_FMT0_LRCLK_POLARITY_MASK;
+		bclk_pol = SUN8I_I2S_FMT0_BCLK_POLARITY_INVERTED;
+		break;
+	case SND_SOC_DAIFMT_IB_NF:
+		/* Invert bit clock */
+		bclk_pol = SUN8I_I2S_FMT0_BCLK_POLARITY_INVERTED;
+		break;
+	case SND_SOC_DAIFMT_NB_IF:
+		/* Invert frame clock */
+		lrclk_pol ^= SUN8I_I2S_FMT0_LRCLK_POLARITY_MASK;
+		break;
+	case SND_SOC_DAIFMT_NB_NF:
+		/* No inversion */
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	regmap_update_bits(i2s->regmap, SUN4I_I2S_FMT0_REG,
+			   SUN8I_I2S_FMT0_LRCLK_POLARITY_MASK |
+			   SUN8I_I2S_FMT0_BCLK_POLARITY_MASK,
+			   lrclk_pol | bclk_pol);
+
+
 	/* DAI clock master masks */
 	switch (fmt & SND_SOC_DAIFMT_CLOCK_PROVIDER_MASK) {
 	case SND_SOC_DAIFMT_BP_FP:
-- 
2.43.0




