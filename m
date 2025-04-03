Return-Path: <stable+bounces-127514-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A259A7A30B
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 14:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D917A1749F8
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 12:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D45A24E018;
	Thu,  3 Apr 2025 12:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vbG62oQW"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D84F24CED7
	for <stable@vger.kernel.org>; Thu,  3 Apr 2025 12:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743684184; cv=none; b=hQnFU3n+XX2rwF1+Mnsb9OiLptDDtO/Q3OnFvB8IYdOQ8WYW2Tn5MV+euNMxW/Obwd5rUWKv3CQRuHrRj6rb5nqPVUcQDkLafleWHDGY8s2smTVudEHw3hFz7mO0zGPjLCFVCzNaTBAnkUw5vSgXUkc0Ufwzb8WeobLbiLWDqDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743684184; c=relaxed/simple;
	bh=D3YRzj3mCAmvwT1dNDp/XxMgwKsjJtdp0ijI+8PtraA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bhg07WquiQu7q25DUKLsnLNRh9wEs6gfKYkMkLrVk5mgaMgQPgk0IucwyQYbmgbOzBpwnFTLuLoE6pTxWm8Eq6U5K7s2WFMk7e/ROxlCz+A/G9XKdv1Wg5Vny4T6oPh8tTl1sxJU6G66D75eLSa62BLMKiNH2IDk3LQf7+kgaEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vbG62oQW; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-39c13fa05ebso552535f8f.0
        for <stable@vger.kernel.org>; Thu, 03 Apr 2025 05:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743684179; x=1744288979; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K8Lmy7xC4akxbC/rSRpm6p7I4pTGlGcGr5of77/sByw=;
        b=vbG62oQWlblgZWd4xgjQtNUMurIWjhC/katsMMcEcC1xnBLmgEOdUFS3U0X6n/i2M+
         k8Rdw0Id3N7hv6abG/HQlf19iohMIEZitGvv85XSYjUvam3DRPSLUEKyHd19iuPPNs0l
         u19/6eSu+A2n6qF9NC/BrY2ZtrXJiuiAXt8Za0yZLUSQhWHvDEyHVXQdk/ANabsh7Qi1
         KJ9jYJQxyRWwkwnF8280jXqjflnaza5HSjaI5almeZlj4lhCIYuX1ufbG1xP2JsTllcf
         R+1rUhYT817Tpx3ONKMOLVcq56HfX420ydO+VSCv8DtiYpXShnz52BNCNWAJPInGjYMC
         bgKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743684179; x=1744288979;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K8Lmy7xC4akxbC/rSRpm6p7I4pTGlGcGr5of77/sByw=;
        b=o5AS4H5KlWvUMmjC9Tb2f2CcXrCJu4RCmwTl24lo4rUZ2F3h8UkEp8UDEaMYn7S/dq
         AxewpD6tunf4ATBzzj3GEFU2+Zho6GC5yIbeOIayxSx+TYL8lNBOCFalwpO020Gv4UWh
         xMXJnGbKhMCR9ax6gUxReuucpzpt0sNQ4yZ1nNBrzfRi4p4AHSVKQcQ+nht1Nzx8dvJO
         u+fSnOMUvC011fsdyzh03EBYVB8MwwNkAjd+THZqxXk08GRs7ugrG6zruEnVthP6N8HY
         OSco/zmUZwkOrkDUElU/6YgFmErPBj1HQVQtYunzFII/e5B+RD/jDKRwIhUQiwq+Inua
         OkBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWRyrTzBFm3iUyZtaiGGKPyAFiyLGy4lRHD7JRPm7f3GpYv5hFCkH1DoK+erhUJoQrPoCHMaM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywfw7h+mLIYKZnzhmtuAKPdl8Jv7X3Fi5Zvq8xxhyq1CezqxMzp
	L86rbsqqdRpweWfEGNl4i78b9tv4YdiqVzFqWH1vhtvOzJq8CkVkPeW172d030o=
X-Gm-Gg: ASbGncv/W7oVCShX7YJUeh/oObVsaO5/Srnr7m+gPFnsrw0LijVJnJiMLS/mxbLhaDZ
	EshoTosqs6mvDseyBkkUkUp0BYn9fVYKzuAIphnl7PJOnvblrdN7657XcHGlYHyvyl4rGc3zKdQ
	M8rHsR3lp2WwPZgVtPPc/Yvk7GDBoFaR3nVG4Zlix7hkrImzDofKVqXyG0pDpR/mGpq1lvTk9bt
	UiXmgi4oS/vq+vPWfdLyN29XFntW81xneSrHmcEUdetmaUkD96T2009eKmNFWsWLkd8WNXsuFMx
	Aq0dmVlChtFDl0Oog/z7maORrVdX5fA2lMpvFrGGpbmQByrFiwSVYC6v3+8oPJZj/42XXg==
X-Google-Smtp-Source: AGHT+IGE6xylVZSZ796+4B1DhKJi0ahGSGLaNKAnwgsZ5gCFYnuPC7oaNBPI8qkRDECC2cthkSTB+g==
X-Received: by 2002:a05:6000:144b:b0:39a:ca0c:fb0c with SMTP id ffacd0b85a97d-39c2f8e1369mr2190659f8f.28.1743684179389;
        Thu, 03 Apr 2025 05:42:59 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec34a7615sm17312505e9.9.2025.04.03.05.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 05:42:58 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: broonie@kernel.org
Cc: lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	pierre-louis.bossart@linux.dev,
	linux-sound@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dmitry.baryshkov@oss.qualcomm.com,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	stable@vger.kernel.org
Subject: [PATCH v3 1/2] ASoC: codecs:lpass-wsa-macro: Fix vi feedback rate
Date: Thu,  3 Apr 2025 13:42:46 +0100
Message-Id: <20250403124247.7313-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403124247.7313-1-srinivas.kandagatla@linaro.org>
References: <20250403124247.7313-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Currently the VI feedback rate is set to fixed 8K, fix this by getting
the correct rate from params_rate.

Without this patch incorrect rate will be set on the VI feedback
recording resulting in rate miss match and audio artifacts.

Fixes: 2c4066e5d428 ("ASoC: codecs: lpass-wsa-macro: add dapm widgets and route")
Cc: stable@vger.kernel.org
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/lpass-wsa-macro.c | 39 +++++++++++++++++++++++++++---
 1 file changed, 36 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/lpass-wsa-macro.c b/sound/soc/codecs/lpass-wsa-macro.c
index c989d82d1d3c..ac119847bc22 100644
--- a/sound/soc/codecs/lpass-wsa-macro.c
+++ b/sound/soc/codecs/lpass-wsa-macro.c
@@ -63,6 +63,10 @@
 #define CDC_WSA_TX_SPKR_PROT_CLK_DISABLE	0
 #define CDC_WSA_TX_SPKR_PROT_PCM_RATE_MASK	GENMASK(3, 0)
 #define CDC_WSA_TX_SPKR_PROT_PCM_RATE_8K	0
+#define CDC_WSA_TX_SPKR_PROT_PCM_RATE_16K	1
+#define CDC_WSA_TX_SPKR_PROT_PCM_RATE_24K	2
+#define CDC_WSA_TX_SPKR_PROT_PCM_RATE_32K	3
+#define CDC_WSA_TX_SPKR_PROT_PCM_RATE_48K	4
 #define CDC_WSA_TX0_SPKR_PROT_PATH_CFG0		(0x0248)
 #define CDC_WSA_TX1_SPKR_PROT_PATH_CTL		(0x0264)
 #define CDC_WSA_TX1_SPKR_PROT_PATH_CFG0		(0x0268)
@@ -407,6 +411,7 @@ struct wsa_macro {
 	int ear_spkr_gain;
 	int spkr_gain_offset;
 	int spkr_mode;
+	u32 pcm_rate_vi;
 	int is_softclip_on[WSA_MACRO_SOFTCLIP_MAX];
 	int softclip_clk_users[WSA_MACRO_SOFTCLIP_MAX];
 	struct regmap *regmap;
@@ -1280,6 +1285,7 @@ static int wsa_macro_hw_params(struct snd_pcm_substream *substream,
 			       struct snd_soc_dai *dai)
 {
 	struct snd_soc_component *component = dai->component;
+	struct wsa_macro *wsa = snd_soc_component_get_drvdata(component);
 	int ret;
 
 	switch (substream->stream) {
@@ -1291,6 +1297,11 @@ static int wsa_macro_hw_params(struct snd_pcm_substream *substream,
 				__func__, params_rate(params));
 			return ret;
 		}
+		break;
+	case SNDRV_PCM_STREAM_CAPTURE:
+		if (dai->id == WSA_MACRO_AIF_VI)
+			wsa->pcm_rate_vi = params_rate(params);
+
 		break;
 	default:
 		break;
@@ -1465,6 +1476,28 @@ static int wsa_macro_enable_vi_feedback(struct snd_soc_dapm_widget *w,
 	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
 	struct wsa_macro *wsa = snd_soc_component_get_drvdata(component);
 	u32 tx_reg0, tx_reg1;
+	u32 rate_val;
+
+	switch (wsa->pcm_rate_vi) {
+	case 8000:
+		rate_val = CDC_WSA_TX_SPKR_PROT_PCM_RATE_8K;
+		break;
+	case 16000:
+		rate_val = CDC_WSA_TX_SPKR_PROT_PCM_RATE_16K;
+		break;
+	case 24000:
+		rate_val = CDC_WSA_TX_SPKR_PROT_PCM_RATE_24K;
+		break;
+	case 32000:
+		rate_val = CDC_WSA_TX_SPKR_PROT_PCM_RATE_32K;
+		break;
+	case 48000:
+		rate_val = CDC_WSA_TX_SPKR_PROT_PCM_RATE_48K;
+		break;
+	default:
+		rate_val = CDC_WSA_TX_SPKR_PROT_PCM_RATE_8K;
+		break;
+	}
 
 	if (test_bit(WSA_MACRO_TX0, &wsa->active_ch_mask[WSA_MACRO_AIF_VI])) {
 		tx_reg0 = CDC_WSA_TX0_SPKR_PROT_PATH_CTL;
@@ -1476,7 +1509,7 @@ static int wsa_macro_enable_vi_feedback(struct snd_soc_dapm_widget *w,
 
 	switch (event) {
 	case SND_SOC_DAPM_POST_PMU:
-			/* Enable V&I sensing */
+		/* Enable V&I sensing */
 		snd_soc_component_update_bits(component, tx_reg0,
 					      CDC_WSA_TX_SPKR_PROT_RESET_MASK,
 					      CDC_WSA_TX_SPKR_PROT_RESET);
@@ -1485,10 +1518,10 @@ static int wsa_macro_enable_vi_feedback(struct snd_soc_dapm_widget *w,
 					      CDC_WSA_TX_SPKR_PROT_RESET);
 		snd_soc_component_update_bits(component, tx_reg0,
 					      CDC_WSA_TX_SPKR_PROT_PCM_RATE_MASK,
-					      CDC_WSA_TX_SPKR_PROT_PCM_RATE_8K);
+					      rate_val);
 		snd_soc_component_update_bits(component, tx_reg1,
 					      CDC_WSA_TX_SPKR_PROT_PCM_RATE_MASK,
-					      CDC_WSA_TX_SPKR_PROT_PCM_RATE_8K);
+					      rate_val);
 		snd_soc_component_update_bits(component, tx_reg0,
 					      CDC_WSA_TX_SPKR_PROT_CLK_EN_MASK,
 					      CDC_WSA_TX_SPKR_PROT_CLK_ENABLE);
-- 
2.39.5


