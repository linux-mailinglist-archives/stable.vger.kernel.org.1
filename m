Return-Path: <stable+bounces-188999-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 51905BFC93F
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 16:37:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CAC2C35701A
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 14:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA48734CFAF;
	Wed, 22 Oct 2025 14:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dy30tpnQ"
X-Original-To: Stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1333491F8
	for <Stable@vger.kernel.org>; Wed, 22 Oct 2025 14:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761143646; cv=none; b=HUA71Y0tPX5NxtRKPQaL7OgSi9ToGhOcpAvQfOC82PUz3VUZem0uR9D8Ur6bXjXUNKTql37bg+zmx7JxV6sCkM7oKbiiCRrxvEa/jASEdwnddCPq2B0xRDx2HQ0pgLffM4qv9iZFHalaLT7DY1JeOpM1PkyGT2bbY+aoFmKkexU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761143646; c=relaxed/simple;
	bh=lhxTLcb/X+R0W0b3tDUVNgpKKlGRY+Qpo1UN7CrZMXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m0/swaUlEP0v/j5z2nPG7CLkafyCmsW19JsFyCJXwwuQP/wHDwDjBiZioIBDAgFofOINl72zPe+rEN1LdepkI7waSDEBxzKiHItzdZyRszWNdIywcckE2D5u4zY9bifb/gTVSP2dW8PSoSvFGmSW+y5dFCq9ESc2CE3cudwTknE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dy30tpnQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59M9qq7m018736
	for <Stable@vger.kernel.org>; Wed, 22 Oct 2025 14:34:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=QX+/j6ug5Bp
	ZFxeqiWYjDUw7viVbs6iAE/eqbzDRJuU=; b=dy30tpnQHfVD+4IuX6H+jk7NY8G
	ifaXmBJeoLpgm+oQ4Hs4mFbMNuKbmZ4+abxBOUnH+la7nSwXl9l71wc8LNwaLmcr
	PjRSfmAJZl770fBH1NzPelM9YFG78tqGIKjb0s/EYlfs78OTZ/GU1l+icZkgQXE/
	uI1Z/8K+xasyiBWNwbeMOQ9hScWGXGinGCbsY02MMFnK3WxJmKuBwKhSWE3xXOok
	XV9pwN7AktzVcKH6mi14OKkRM6Br23Qewu2PvlIPtflUUYAyONazKQEVn7Ez/jsO
	9Z+/IhbD8G9aUTi3k0jQ5U4l09odtfmOb32Sbj17MG14kCSLL+utnFIIMSQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v469mxck-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <Stable@vger.kernel.org>; Wed, 22 Oct 2025 14:34:03 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4e894937010so38216561cf.3
        for <Stable@vger.kernel.org>; Wed, 22 Oct 2025 07:34:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761143642; x=1761748442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QX+/j6ug5BpZFxeqiWYjDUw7viVbs6iAE/eqbzDRJuU=;
        b=PqE+AdauxHLK/MM+S8XJemN1R5W8mDXlk/O4xPGvVS2kRtlQtHFs7eAjrgPduQ+uD8
         MUSmSp/9IN3TxMCcy6fsQOT1ldb30XjtR70LBv0BQ2fpWWrzgHYo6FgNAnFZrfsrstzQ
         337JzAL2frENrV/kzO4uvxEOfGuSc0ZbqsTl5tcdIl3cac7PeI84HWBV9q+0nw68opPt
         0Fg2of8SkJa1B1SAcXLGicCe237JJ3f6FgHQGTQt04DyyuSDoUj9LWzfco3NJzYz5CY5
         lsP4CBbMbUus4DzcAAXs9MGiNORDICmyIsxpRvSNpi39MKJzXE2rvm950r/27V7YVuO4
         tVjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXg9GKMLZvh1ZCfjBF+w6VSy2fXzdzpxCtOxQW5L2Nvdo2IZNTjxGE9+VAi1ZMvtZM7PsWvo+k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz38ZtxcmWaWW5XWa53k7n1Up9dNHLcy1/H/wVrDN8tYExhW0kO
	VsOd8b+xPFueiYsBJBPA4INzEUENMy3DFWWA9wafx/EgL4JDrqwRr1mIDOGMjOM7NtHfGlohE6s
	a5+eAJnDrGKTxhEB0p9GrIVRHMp/4/dWHBeV1nwRyOHNqRNUGgEG0/hS7ymQ=
X-Gm-Gg: ASbGnctezKZ2/djNBuPhytMW/lQz8kGxDNzFmUtiryOo2V9vPHuVMsGHe7rodSy+/v7
	F3fbiQjmU6uVKTUJYtJBwa7AUmVs/sS3HZnoe3Ybj9/wFgaPEGcXWR8UNHd2zAH6H4Y1vlZIYGp
	euoRRjASWrW+lbDUBcZLZjUZOxdeNF6pX3a2UyvVWGA/Si5U0GD4Lh3mjQfs0j+mvy6kUay4GuR
	VY1E5pa276TQTjfKhjzoqU7EnjzbPgqtWJ+uxvP8qKYoYYY3W3+u3gAvpMJS/kgYKbMQb1i/8Wv
	Yf7xY+h1b9oXPxnYYV+q3QmuzPxeI+butsZlN4yt1ioR/RVYYV6593SiTZOQzW6WpnTq99TN2dD
	3TTlLpWtCuWpL
X-Received: by 2002:ac8:598b:0:b0:4e5:6cf8:289 with SMTP id d75a77b69052e-4e89d29bab9mr248332481cf.29.1761143641928;
        Wed, 22 Oct 2025 07:34:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZXiC6dm1aJzPYIm80nJKiwk9U83kUHT9S3LNgQ5bVxeCwtXipr7lRzWEi+/7qed69ffam1w==
X-Received: by 2002:ac8:598b:0:b0:4e5:6cf8:289 with SMTP id d75a77b69052e-4e89d29bab9mr248331991cf.29.1761143641431;
        Wed, 22 Oct 2025 07:34:01 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f009a993sm25544910f8f.24.2025.10.22.07.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 07:34:01 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: broonie@kernel.org
Cc: perex@perex.cz, tiwai@suse.com, srini@kernel.org, alexey.klimov@linaro.org,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Stable@vger.kernel.org, Steev Klimaszewski <threeway@gmail.com>
Subject: [PATCH v3 1/4] ASoC: qcom: sdw: fix memory leak for sdw_stream_runtime
Date: Wed, 22 Oct 2025 15:33:46 +0100
Message-ID: <20251022143349.1081513-2-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251022143349.1081513-1-srinivas.kandagatla@oss.qualcomm.com>
References: <20251022143349.1081513-1-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: u9GE8oWwsVoS_ssJ682vdni5NWRmJ0Gh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAzMiBTYWx0ZWRfX9Ff0KsJZeo4Z
 PgGNJKgpVwu9ZbtmkTYZHylQ5Aa081Wl+XC/BWIiiQ0bOBy3ptZv1XwFrcgL7ZuhHHfK5TWjgFE
 hSWaGAu2zr5Me39uvePsK3nczSxmNobzhomH4mXknITo5ImhpLWdc44fX5d3TcY0ejigikpkoI/
 iPnne/sof/HPjEnJi9USE5CG5t5e+Io4vZ+SX2+g6r5BWnAAIYE37IChxfK856NP553mLCAG9TO
 Uw/TOWdcYLlQmXv8pe28LeIXkNAf/BIKTgZegt9BSXdlONRrl5CpzTnRqktojzFS9mc0TQGb3xs
 H1DdBI3imt+YD61xOB0K2Hk/5wp4378Y7PmG3jYNDBu69qF00IDr8WXtRbc4dO73UiniG/XfSnG
 64jQmI83Vg8Puo7kAuCsyEBTBiJ4yg==
X-Authority-Analysis: v=2.4 cv=U8qfzOru c=1 sm=1 tr=0 ts=68f8eb5b cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=N47DpUgmF8P8R7KZyx8A:9
 a=dawVfQjAaf238kedN5IG:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: u9GE8oWwsVoS_ssJ682vdni5NWRmJ0Gh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_06,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 spamscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180032

For some reason we endedup allocating sdw_stream_runtime for every cpu dai,
this has two issues.
1. we never set snd_soc_dai_set_stream for non soundwire dai, which
   means there is no way that we can free this, resulting in memory leak
2. startup and shutdown callbacks can be called without
   hw_params callback called. This combination results in memory leak
because machine driver sruntime array pointer is only set in hw_params
callback.

Fix this by
 1. adding a helper function to get sdw_runtime for substream
which can be used by shutdown callback to get hold of sruntime to free.
 2. only allocate sdw_runtime for soundwire dais.

Fixes: d32bac9cb09c ("ASoC: qcom: Add helper for allocating Soundwire stream runtime")
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Tested-by: Steev Klimaszewski <threeway@gmail.com> # Thinkpad X13s
---
 sound/soc/qcom/sc7280.c   |   2 +-
 sound/soc/qcom/sc8280xp.c |   2 +-
 sound/soc/qcom/sdw.c      | 105 +++++++++++++++++++++-----------------
 sound/soc/qcom/sdw.h      |   1 +
 sound/soc/qcom/sm8250.c   |   2 +-
 sound/soc/qcom/x1e80100.c |   2 +-
 6 files changed, 64 insertions(+), 50 deletions(-)

diff --git a/sound/soc/qcom/sc7280.c b/sound/soc/qcom/sc7280.c
index af412bd0c89f..c444dae563c7 100644
--- a/sound/soc/qcom/sc7280.c
+++ b/sound/soc/qcom/sc7280.c
@@ -317,7 +317,7 @@ static void sc7280_snd_shutdown(struct snd_pcm_substream *substream)
 	struct snd_soc_card *card = rtd->card;
 	struct sc7280_snd_data *data = snd_soc_card_get_drvdata(card);
 	struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
-	struct sdw_stream_runtime *sruntime = data->sruntime[cpu_dai->id];
+	struct sdw_stream_runtime *sruntime = qcom_snd_sdw_get_stream(substream);
 
 	switch (cpu_dai->id) {
 	case MI2S_PRIMARY:
diff --git a/sound/soc/qcom/sc8280xp.c b/sound/soc/qcom/sc8280xp.c
index 78e327bc2f07..9ba536dff667 100644
--- a/sound/soc/qcom/sc8280xp.c
+++ b/sound/soc/qcom/sc8280xp.c
@@ -73,7 +73,7 @@ static void sc8280xp_snd_shutdown(struct snd_pcm_substream *substream)
 	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
 	struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
 	struct sc8280xp_snd_data *pdata = snd_soc_card_get_drvdata(rtd->card);
-	struct sdw_stream_runtime *sruntime = pdata->sruntime[cpu_dai->id];
+	struct sdw_stream_runtime *sruntime = qcom_snd_sdw_get_stream(substream);
 
 	pdata->sruntime[cpu_dai->id] = NULL;
 	sdw_release_stream(sruntime);
diff --git a/sound/soc/qcom/sdw.c b/sound/soc/qcom/sdw.c
index 7d7981d4295b..7b2cae92c812 100644
--- a/sound/soc/qcom/sdw.c
+++ b/sound/soc/qcom/sdw.c
@@ -7,6 +7,37 @@
 #include <sound/soc.h>
 #include "sdw.h"
 
+static bool qcom_snd_is_sdw_dai(int id)
+{
+	switch (id) {
+	case WSA_CODEC_DMA_RX_0:
+	case WSA_CODEC_DMA_TX_0:
+	case WSA_CODEC_DMA_RX_1:
+	case WSA_CODEC_DMA_TX_1:
+	case WSA_CODEC_DMA_TX_2:
+	case RX_CODEC_DMA_RX_0:
+	case TX_CODEC_DMA_TX_0:
+	case RX_CODEC_DMA_RX_1:
+	case TX_CODEC_DMA_TX_1:
+	case RX_CODEC_DMA_RX_2:
+	case TX_CODEC_DMA_TX_2:
+	case RX_CODEC_DMA_RX_3:
+	case TX_CODEC_DMA_TX_3:
+	case RX_CODEC_DMA_RX_4:
+	case TX_CODEC_DMA_TX_4:
+	case RX_CODEC_DMA_RX_5:
+	case TX_CODEC_DMA_TX_5:
+	case RX_CODEC_DMA_RX_6:
+	case RX_CODEC_DMA_RX_7:
+	case SLIMBUS_0_RX...SLIMBUS_6_TX:
+		return true;
+	default:
+		break;
+	}
+
+	return false;
+}
+
 /**
  * qcom_snd_sdw_startup() - Helper to start Soundwire stream for SoC audio card
  * @substream: The PCM substream from audio, as passed to snd_soc_ops->startup()
@@ -29,6 +60,9 @@ int qcom_snd_sdw_startup(struct snd_pcm_substream *substream)
 	u32 rx_ch_cnt = 0, tx_ch_cnt = 0;
 	int ret, i, j;
 
+	if (!qcom_snd_is_sdw_dai(cpu_dai->id))
+		return 0;
+
 	sruntime = sdw_alloc_stream(cpu_dai->name, SDW_STREAM_PCM);
 	if (!sruntime)
 		return -ENOMEM;
@@ -89,19 +123,8 @@ int qcom_snd_sdw_prepare(struct snd_pcm_substream *substream,
 	if (!sruntime)
 		return 0;
 
-	switch (cpu_dai->id) {
-	case WSA_CODEC_DMA_RX_0:
-	case WSA_CODEC_DMA_RX_1:
-	case RX_CODEC_DMA_RX_0:
-	case RX_CODEC_DMA_RX_1:
-	case TX_CODEC_DMA_TX_0:
-	case TX_CODEC_DMA_TX_1:
-	case TX_CODEC_DMA_TX_2:
-	case TX_CODEC_DMA_TX_3:
-		break;
-	default:
+	if (!qcom_snd_is_sdw_dai(cpu_dai->id))
 		return 0;
-	}
 
 	if (*stream_prepared)
 		return 0;
@@ -129,9 +152,7 @@ int qcom_snd_sdw_prepare(struct snd_pcm_substream *substream,
 }
 EXPORT_SYMBOL_GPL(qcom_snd_sdw_prepare);
 
-int qcom_snd_sdw_hw_params(struct snd_pcm_substream *substream,
-			   struct snd_pcm_hw_params *params,
-			   struct sdw_stream_runtime **psruntime)
+struct sdw_stream_runtime *qcom_snd_sdw_get_stream(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
 	struct snd_soc_dai *codec_dai;
@@ -139,21 +160,23 @@ int qcom_snd_sdw_hw_params(struct snd_pcm_substream *substream,
 	struct sdw_stream_runtime *sruntime;
 	int i;
 
-	switch (cpu_dai->id) {
-	case WSA_CODEC_DMA_RX_0:
-	case RX_CODEC_DMA_RX_0:
-	case RX_CODEC_DMA_RX_1:
-	case TX_CODEC_DMA_TX_0:
-	case TX_CODEC_DMA_TX_1:
-	case TX_CODEC_DMA_TX_2:
-	case TX_CODEC_DMA_TX_3:
-		for_each_rtd_codec_dais(rtd, i, codec_dai) {
-			sruntime = snd_soc_dai_get_stream(codec_dai, substream->stream);
-			if (sruntime != ERR_PTR(-ENOTSUPP))
-				*psruntime = sruntime;
-		}
-		break;
+	if (!qcom_snd_is_sdw_dai(cpu_dai->id))
+		return NULL;
+
+	for_each_rtd_codec_dais(rtd, i, codec_dai) {
+		sruntime = snd_soc_dai_get_stream(codec_dai, substream->stream);
+		if (sruntime != ERR_PTR(-ENOTSUPP))
+			return sruntime;
 	}
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(qcom_snd_sdw_get_stream);
+
+int qcom_snd_sdw_hw_params(struct snd_pcm_substream *substream,
+			   struct snd_pcm_hw_params *params,
+			   struct sdw_stream_runtime **psruntime)
+{
+	*psruntime = qcom_snd_sdw_get_stream(substream);
 
 	return 0;
 
@@ -166,23 +189,13 @@ int qcom_snd_sdw_hw_free(struct snd_pcm_substream *substream,
 	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
 	struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
 
-	switch (cpu_dai->id) {
-	case WSA_CODEC_DMA_RX_0:
-	case WSA_CODEC_DMA_RX_1:
-	case RX_CODEC_DMA_RX_0:
-	case RX_CODEC_DMA_RX_1:
-	case TX_CODEC_DMA_TX_0:
-	case TX_CODEC_DMA_TX_1:
-	case TX_CODEC_DMA_TX_2:
-	case TX_CODEC_DMA_TX_3:
-		if (sruntime && *stream_prepared) {
-			sdw_disable_stream(sruntime);
-			sdw_deprepare_stream(sruntime);
-			*stream_prepared = false;
-		}
-		break;
-	default:
-		break;
+	if (!qcom_snd_is_sdw_dai(cpu_dai->id))
+		return 0;
+
+	if (sruntime && *stream_prepared) {
+		sdw_disable_stream(sruntime);
+		sdw_deprepare_stream(sruntime);
+		*stream_prepared = false;
 	}
 
 	return 0;
diff --git a/sound/soc/qcom/sdw.h b/sound/soc/qcom/sdw.h
index 392e3455f1b1..b8bc5beb0522 100644
--- a/sound/soc/qcom/sdw.h
+++ b/sound/soc/qcom/sdw.h
@@ -10,6 +10,7 @@ int qcom_snd_sdw_startup(struct snd_pcm_substream *substream);
 int qcom_snd_sdw_prepare(struct snd_pcm_substream *substream,
 			 struct sdw_stream_runtime *runtime,
 			 bool *stream_prepared);
+struct sdw_stream_runtime *qcom_snd_sdw_get_stream(struct snd_pcm_substream *stream);
 int qcom_snd_sdw_hw_params(struct snd_pcm_substream *substream,
 			   struct snd_pcm_hw_params *params,
 			   struct sdw_stream_runtime **psruntime);
diff --git a/sound/soc/qcom/sm8250.c b/sound/soc/qcom/sm8250.c
index f5b75a06e5bd..ce5b0059207f 100644
--- a/sound/soc/qcom/sm8250.c
+++ b/sound/soc/qcom/sm8250.c
@@ -117,7 +117,7 @@ static void sm8250_snd_shutdown(struct snd_pcm_substream *substream)
 	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
 	struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
 	struct sm8250_snd_data *data = snd_soc_card_get_drvdata(rtd->card);
-	struct sdw_stream_runtime *sruntime = data->sruntime[cpu_dai->id];
+	struct sdw_stream_runtime *sruntime = qcom_snd_sdw_get_stream(substream);
 
 	data->sruntime[cpu_dai->id] = NULL;
 	sdw_release_stream(sruntime);
diff --git a/sound/soc/qcom/x1e80100.c b/sound/soc/qcom/x1e80100.c
index 444f2162889f..2e3599516aa2 100644
--- a/sound/soc/qcom/x1e80100.c
+++ b/sound/soc/qcom/x1e80100.c
@@ -55,7 +55,7 @@ static void x1e80100_snd_shutdown(struct snd_pcm_substream *substream)
 	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
 	struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
 	struct x1e80100_snd_data *data = snd_soc_card_get_drvdata(rtd->card);
-	struct sdw_stream_runtime *sruntime = data->sruntime[cpu_dai->id];
+	struct sdw_stream_runtime *sruntime = qcom_snd_sdw_get_stream(substream);
 
 	data->sruntime[cpu_dai->id] = NULL;
 	sdw_release_stream(sruntime);
-- 
2.51.0


