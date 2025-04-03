Return-Path: <stable+bounces-127515-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1C1A7A30D
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 14:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7413618962AA
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 12:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE6D24E4A4;
	Thu,  3 Apr 2025 12:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uuUdfwDM"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E2724C09A
	for <stable@vger.kernel.org>; Thu,  3 Apr 2025 12:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743684184; cv=none; b=TdwdhLR3+46ZWV6N6891kbgK0mPnt4CWFgcgG1VVzsI9Zv+nQQ+dVpproQj+WM1CwQ1jBfyLDQUz82dvsBp7FCopsAY5LODIqN9Ku+3OBQ9k1W7SD8F/p8ssx7jFacGoYF5DKox92uekl12peDAUzRKMpVfzPgdWkCId7TG0J90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743684184; c=relaxed/simple;
	bh=sb2QRnB7188NOtda5DPHBASrexKmkSX9VEuesDDtB+M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DnQyPFMiMrk6770YsXjRK3x7bPCtudF0i2Yh35xEmaywB7w8WPmAPy7zyURFH7ma8NN/ztFIwQ4uvujkPhkloqxp1FGJs2QmoxsZY256SXtCC/RmAVVuiGEROdeRcQ/p/No8Y0/gweAsqs8850QSNzjJH1CZwYQnm/AXpC9k1QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uuUdfwDM; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-39ac8e7688aso650335f8f.2
        for <stable@vger.kernel.org>; Thu, 03 Apr 2025 05:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743684180; x=1744288980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X2gzGEzgiKIa4EMF6KQg0t5+kh4IPdUUyGlnfc/EwEw=;
        b=uuUdfwDMWKADYPr6aBZDzW3ukiuKhdz/AoR2O2HkWY0WBxV2FWYAaQQJdsR0ZwvuDG
         tKBKbuBsHjIbYAaKlSq1hx4nxfpVQemL3ZCAzUiPw92zwqI5vPnWtm3N+2qkmqJH7wbA
         D0bFQBbBbcbMJlatV8xv4r1CzRnDY2oOP054TDP3tYkfG2bMb9lZ0rDe+w5S+QbDDI1v
         xZntQCEHIcHKkcnZIVUZCoxZzK/KymKE+UESvZV52oF/ZtwzkWn/HbWfQINUvg3Z3D1q
         mCCqku6yhH0aA7P7q0q9RrU1maCoWdpIrK+LC3sfJYQQhMP8n9ACWdqmz69GOx062YQe
         5kww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743684181; x=1744288981;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X2gzGEzgiKIa4EMF6KQg0t5+kh4IPdUUyGlnfc/EwEw=;
        b=M+v1Ub0s0hCd9uA7eiKh4Cdc2529EkSgkMiZbTeRGwpVL/mPudYd33K8wbd1nU8Esz
         I06pG6m3u6q6kVFo2aqNEDYBeLvVqw1LXUFoj1ftyL9CpXWO9tXFxU4/YMXI1Zd6dIXz
         9cfkN9Kwwtrty2MHO6wT0nySnMLOoM/j5mWgr+4tKeyR5MRK+0h60Fod0WlXnSg4FJND
         hDBw1YQmlIlfIimAjDHvkkkVs0Vk/t/d3ROAeCgHOvUPcXUdD/msBXiXpJO1tBuk23Xd
         srNAKIElBtjc+EVuhthzWDAT8Z6KHcsLvpOW+T33TDV1BDnQFAuNLTME2vNywbUpfIzf
         E8+g==
X-Forwarded-Encrypted: i=1; AJvYcCVzzr68DOjUz8VIEacSLU7uQi47H1vBx6eAP44CLe7GD7/XNJ/vLmFvwz50WYppRgAPGFsYPic=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxDw+EguP4Syl2oDoaOD4FNRiUxfxzRexCKuEgDubBz4YqrEmL
	qd7PGqcEsDfQFOcdX7pV4dScJTXf88RYxtMjxVJ7RM1eve/bWHFkojs4tF4IVCQ=
X-Gm-Gg: ASbGnctpXcJKmSE0zdofSiEc0dD6buTMcCRrY3OMwVENIGb63KSHvbhSObBu4vDdqPY
	qq1vu+3P/9BwZsTkQS78cf3pbppcCvSr6B+jQP8vagiyc3COfZ3MYFNNmCK2jaKvi2YmephhGiu
	acYJyx53zZYmQ+Sc9No5R3UXI9eXDnHSTVY3DuOaviJY0fg9NzqfQGNhKPpTXs0NbvZLPN2jLvW
	yan2XpA0tPJmHxgUwiWKz7N6z25rpKfgtEbqQuqP5AY7s56zYQuGRDaIehm909sUTRx7dxEoBvZ
	ilwRe8oFugFC0/i8zlS1RCTac2F9J6Gz1I9s4wtOnDhYxPumDhMWQlK2c2j+uYvbHCLlZxwJCyj
	bRsS/
X-Google-Smtp-Source: AGHT+IEbPg8+OB+t29rOtNL2QkkFRiJ5r3Z4JpZaekYA6Sh1gaBggQto/hs6PTOfMoriK53k96kgHg==
X-Received: by 2002:a05:6000:4023:b0:39c:119f:27c4 with SMTP id ffacd0b85a97d-39c29767c83mr5503332f8f.30.1743684180601;
        Thu, 03 Apr 2025 05:43:00 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec34a7615sm17312505e9.9.2025.04.03.05.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 05:42:59 -0700 (PDT)
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
	stable@vger.kernel.org,
	Manikantan R <quic_manrav@quicinc.com>
Subject: [PATCH v3 2/2] ASoC: codecs:lpass-wsa-macro: Fix logic of enabling vi channels
Date: Thu,  3 Apr 2025 13:42:47 +0100
Message-Id: <20250403124247.7313-3-srinivas.kandagatla@linaro.org>
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

Existing code only configures one of WSA_MACRO_TX0 or WSA_MACRO_TX1
paths eventhough we enable both of them. Fix this bug by adding proper
checks and rearranging some of the common code to able to allow setting
both TX0 and TX1 paths

Without this patch only one channel gets enabled in VI path instead of 2
channels. End result would be 1 channel recording instead of 2.

Fixes: 2c4066e5d428 ("ASoC: codecs: lpass-wsa-macro: add dapm widgets and route")
Cc: stable@vger.kernel.org
Co-developed-by: Manikantan R <quic_manrav@quicinc.com>
Signed-off-by: Manikantan R <quic_manrav@quicinc.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/lpass-wsa-macro.c | 112 +++++++++++++++++------------
 1 file changed, 68 insertions(+), 44 deletions(-)

diff --git a/sound/soc/codecs/lpass-wsa-macro.c b/sound/soc/codecs/lpass-wsa-macro.c
index ac119847bc22..c9e7f185f2bc 100644
--- a/sound/soc/codecs/lpass-wsa-macro.c
+++ b/sound/soc/codecs/lpass-wsa-macro.c
@@ -1469,46 +1469,11 @@ static int wsa_macro_mclk_event(struct snd_soc_dapm_widget *w,
 	return 0;
 }
 
-static int wsa_macro_enable_vi_feedback(struct snd_soc_dapm_widget *w,
-					struct snd_kcontrol *kcontrol,
-					int event)
-{
-	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
-	struct wsa_macro *wsa = snd_soc_component_get_drvdata(component);
-	u32 tx_reg0, tx_reg1;
-	u32 rate_val;
 
-	switch (wsa->pcm_rate_vi) {
-	case 8000:
-		rate_val = CDC_WSA_TX_SPKR_PROT_PCM_RATE_8K;
-		break;
-	case 16000:
-		rate_val = CDC_WSA_TX_SPKR_PROT_PCM_RATE_16K;
-		break;
-	case 24000:
-		rate_val = CDC_WSA_TX_SPKR_PROT_PCM_RATE_24K;
-		break;
-	case 32000:
-		rate_val = CDC_WSA_TX_SPKR_PROT_PCM_RATE_32K;
-		break;
-	case 48000:
-		rate_val = CDC_WSA_TX_SPKR_PROT_PCM_RATE_48K;
-		break;
-	default:
-		rate_val = CDC_WSA_TX_SPKR_PROT_PCM_RATE_8K;
-		break;
-	}
-
-	if (test_bit(WSA_MACRO_TX0, &wsa->active_ch_mask[WSA_MACRO_AIF_VI])) {
-		tx_reg0 = CDC_WSA_TX0_SPKR_PROT_PATH_CTL;
-		tx_reg1 = CDC_WSA_TX1_SPKR_PROT_PATH_CTL;
-	} else if (test_bit(WSA_MACRO_TX1, &wsa->active_ch_mask[WSA_MACRO_AIF_VI])) {
-		tx_reg0 = CDC_WSA_TX2_SPKR_PROT_PATH_CTL;
-		tx_reg1 = CDC_WSA_TX3_SPKR_PROT_PATH_CTL;
-	}
-
-	switch (event) {
-	case SND_SOC_DAPM_POST_PMU:
+static void wsa_macro_enable_disable_vi_sense(struct snd_soc_component *component, bool enable,
+						u32 tx_reg0, u32 tx_reg1, u32 val)
+{
+	if (enable) {
 		/* Enable V&I sensing */
 		snd_soc_component_update_bits(component, tx_reg0,
 					      CDC_WSA_TX_SPKR_PROT_RESET_MASK,
@@ -1518,10 +1483,10 @@ static int wsa_macro_enable_vi_feedback(struct snd_soc_dapm_widget *w,
 					      CDC_WSA_TX_SPKR_PROT_RESET);
 		snd_soc_component_update_bits(component, tx_reg0,
 					      CDC_WSA_TX_SPKR_PROT_PCM_RATE_MASK,
-					      rate_val);
+					      val);
 		snd_soc_component_update_bits(component, tx_reg1,
 					      CDC_WSA_TX_SPKR_PROT_PCM_RATE_MASK,
-					      rate_val);
+					      val);
 		snd_soc_component_update_bits(component, tx_reg0,
 					      CDC_WSA_TX_SPKR_PROT_CLK_EN_MASK,
 					      CDC_WSA_TX_SPKR_PROT_CLK_ENABLE);
@@ -1534,9 +1499,7 @@ static int wsa_macro_enable_vi_feedback(struct snd_soc_dapm_widget *w,
 		snd_soc_component_update_bits(component, tx_reg1,
 					      CDC_WSA_TX_SPKR_PROT_RESET_MASK,
 					      CDC_WSA_TX_SPKR_PROT_NO_RESET);
-		break;
-	case SND_SOC_DAPM_POST_PMD:
-		/* Disable V&I sensing */
+	} else {
 		snd_soc_component_update_bits(component, tx_reg0,
 					      CDC_WSA_TX_SPKR_PROT_RESET_MASK,
 					      CDC_WSA_TX_SPKR_PROT_RESET);
@@ -1549,6 +1512,67 @@ static int wsa_macro_enable_vi_feedback(struct snd_soc_dapm_widget *w,
 		snd_soc_component_update_bits(component, tx_reg1,
 					      CDC_WSA_TX_SPKR_PROT_CLK_EN_MASK,
 					      CDC_WSA_TX_SPKR_PROT_CLK_DISABLE);
+	}
+}
+
+static void wsa_macro_enable_disable_vi_feedback(struct snd_soc_component *component,
+						 bool enable, u32 rate)
+{
+	struct wsa_macro *wsa = snd_soc_component_get_drvdata(component);
+	u32 tx_reg0, tx_reg1;
+
+	if (test_bit(WSA_MACRO_TX0, &wsa->active_ch_mask[WSA_MACRO_AIF_VI])) {
+		tx_reg0 = CDC_WSA_TX0_SPKR_PROT_PATH_CTL;
+		tx_reg1 = CDC_WSA_TX1_SPKR_PROT_PATH_CTL;
+		wsa_macro_enable_disable_vi_sense(component, enable, tx_reg0, tx_reg1, rate);
+	}
+
+	if (test_bit(WSA_MACRO_TX1, &wsa->active_ch_mask[WSA_MACRO_AIF_VI])) {
+		tx_reg0 = CDC_WSA_TX2_SPKR_PROT_PATH_CTL;
+		tx_reg1 = CDC_WSA_TX3_SPKR_PROT_PATH_CTL;
+		wsa_macro_enable_disable_vi_sense(component, enable, tx_reg0, tx_reg1, rate);
+
+	}
+
+}
+
+static int wsa_macro_enable_vi_feedback(struct snd_soc_dapm_widget *w,
+					struct snd_kcontrol *kcontrol,
+					int event)
+{
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+	struct wsa_macro *wsa = snd_soc_component_get_drvdata(component);
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
+
+	switch (event) {
+	case SND_SOC_DAPM_POST_PMU:
+		/* Enable V&I sensing */
+		wsa_macro_enable_disable_vi_feedback(component, true, rate_val);
+		break;
+	case SND_SOC_DAPM_POST_PMD:
+		/* Disable V&I sensing */
+		wsa_macro_enable_disable_vi_feedback(component, false, rate_val);
 		break;
 	}
 
-- 
2.39.5


