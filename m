Return-Path: <stable+bounces-127702-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC79BA7A77B
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 18:04:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B439C18983AF
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 16:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C1C12512DA;
	Thu,  3 Apr 2025 16:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QACvxo3h"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24EC62505C5
	for <stable@vger.kernel.org>; Thu,  3 Apr 2025 16:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743696158; cv=none; b=Vyfou21cyGNzgz4iheCq3sAFE+qyF6KvuJvF5gd0l0rZkVZ/J8K4u6T+rH3U1btuMofJk/0dv4VysxgV/QaISYhLYUMHsa20K4qbt2yENn1FL5biAgd+M01WOdrhPe8fWRqs/ySO0B5EqLgiCZwS2Gswa1ys6DSMdoueCAHKp9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743696158; c=relaxed/simple;
	bh=prWl/oKjeICCpY8NVeCuorCzG8tznA9V1MVAwdGvN7I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oMonU/BNUv6Ns3lZAIET23N+04Ambp3lOjUWCRHfcX2g+goHHGFI3HUVRixJb0I+Ri5i1UpkwnnUZ1wALpeylmt1JBZmzdSNGe98obcvNzQo8TFZLQsTMVx5Y1AUOuAOiFKxk2PZ28104VMt4rNR78v9bSsExjoJI389ZGA0jbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QACvxo3h; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43cf06eabdaso9454215e9.2
        for <stable@vger.kernel.org>; Thu, 03 Apr 2025 09:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743696154; x=1744300954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BGxHCbeyYb+MzV1Ab/qs9UuRGLyJNxdDlt8RO81d10Q=;
        b=QACvxo3hUWmo7bF0hEi98HCr59fO8fHhk95yiHsCU1HoN9riiN4kLIbJ4BYzC7Wzpn
         DT/xrraiveqtZ3S7sB7XQprADdD3dQcamA9fHpcIYrvJz7FIgzIb4ixWtng4JN3XkZ0W
         Keg35bOjugX23ADS9KTcdPEwv6YL0PtLC8ektDLKeMN0RQI1txJwfCzyoOQEp1Wg/rhF
         yJ80QF67hNLg/3C2HJHarvl9/gB+7BDLihEgzmnBAg7skq3vKynH/vHFoIRDDHT+YU0h
         qd8f7fpLJmL7+L1tQn6OqWe/lKPE6mNpF57jyQ6dD8L7+hBDDx9YmP6QPBnKdo4am2vN
         8Pbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743696154; x=1744300954;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BGxHCbeyYb+MzV1Ab/qs9UuRGLyJNxdDlt8RO81d10Q=;
        b=FeyVtyOAb4uzV2749XqrB5XerinayIcLkyLsAARNelzIAdKJd82+8XCPT04Ak+0HGF
         TxRS3U+DWUzhjegfFLDRbcoW8M13aFRVApKpSeO4ycdwuJCqRgdICFCCvxycCi/EgZ5I
         1vcbea/66hcM/EvVFOVlWSqchPVDdItteHDc6MpreNmv4g0bQp8d7Qv3wcHnOm2JIm8W
         uMd1Gl7o8POdiGCVNmuuu/NOBRxKKWMpEOzn+tyLqBP4hZlDruqF07qxukCz2k4U9xml
         Z4uYbz2ZSbFwpeG5T+Yr45R9I8zYEfyJnKrk4wqIm6zIgjFGIwGyr5/aJqhSDzTQjv7C
         okSg==
X-Forwarded-Encrypted: i=1; AJvYcCV8A8K+dbLSvvD7O+3lT/8+9lh4Uqrjp3EHk9EL4NH+2gF0DBkIla8VS5wnHVPYRN8vAeF+R6I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuZPFdiXLh2nikctFpcSTenkJCiO0wgGrZ1iX+zORbD337lwkS
	6eDHhQqwT6NeVpdshfJzEb1BVf5y5lBAx8sxTqSyadHsSnj/hRf2XPU16B3b1Dk=
X-Gm-Gg: ASbGncsnnmqS6v0DPX8nqmUDlOlVcuQ56REdtP2KdwHvr8AyIS+YeCK5wor0OzunVtE
	3ZEBldbJ/29TWrB3oaeOeZEC2KWWU2MQ8wMEw3xq7MiInDAMI51dFcvqrfcZ6Wq5y1qD+5l9ZZ1
	CHEvM50HC5ZmertPgbfMrrUzomRR+EY+UkehDbnR/RDZ1lE7ap7CnxP5ss18JeWkuVXqt9n05LZ
	4sQCNR+98yzlLgRauK7u5fNDGJWMTLGc37acVw+dmd9oCYx+Ma+1vLM1eakTuxUb3Z57eDPcDN5
	SJDyMsPuXwB3Kd/JRWTWaq+E8V4U8TCwTxTUSVQ2STIEIAYlJKKj8EOdMRK08S+/rMwUrA==
X-Google-Smtp-Source: AGHT+IHlLfWrjl1pJEbIehA/TvECe+DFfF7GwTjvWr48M60HR1U3VlaUWlMl7YRIt0U7CPSoj1yfHQ==
X-Received: by 2002:a05:600c:4f88:b0:43d:762:e0c4 with SMTP id 5b1f17b1804b1-43ec14e531dmr27974775e9.27.1743696153851;
        Thu, 03 Apr 2025 09:02:33 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec34bbc64sm21811285e9.21.2025.04.03.09.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 09:02:30 -0700 (PDT)
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
Subject: [PATCH v4 1/2] ASoC: codecs:lpass-wsa-macro: Fix vi feedback rate
Date: Thu,  3 Apr 2025 17:02:08 +0100
Message-Id: <20250403160209.21613-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403160209.21613-1-srinivas.kandagatla@linaro.org>
References: <20250403160209.21613-1-srinivas.kandagatla@linaro.org>
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
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
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


