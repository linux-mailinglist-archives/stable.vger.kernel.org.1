Return-Path: <stable+bounces-204608-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA89CF2BE4
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 10:27:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D0D79300A91D
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 09:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8494B31AA82;
	Mon,  5 Jan 2026 09:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tr5pqP6y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4B8238C33
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 09:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767605204; cv=none; b=d/AHFebVFHW6h91GlHAQT8itpqIXOoOMAv5N+5nIwfKUIjmVhVPj9WPNtMgfEPkbFaWqZ70kv8Co98AFePvK1bSs7HLvZTVOH70u5JBfapr5Tvh+Yz4rqh1h58fWOeFBcwKKauYDSea1kh/Gy/xEjhpd/xOn++JbKBWQdiG9cc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767605204; c=relaxed/simple;
	bh=IWW+ryIRBV9rFxvuoU1cgAp8zLN2Up7h5GpmRp56XzA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=jpMRwzJUUnwHirnjKLinJrnIlorE8v40r/KExPOzbLx4S/Ju6mOpj3D/7PM1CEbwy1Ka8pmPxkotCMUWe9a9hLkHbl/Zd/H/8kDaXh5zk2LFaev44bX9gxp/ehTz2odc8m1nPlxm3nCLUMy9ROBRl4sFTf1S/Y9jh5r4ytaVcg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tr5pqP6y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8007DC116D0;
	Mon,  5 Jan 2026 09:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767605202;
	bh=IWW+ryIRBV9rFxvuoU1cgAp8zLN2Up7h5GpmRp56XzA=;
	h=Subject:To:Cc:From:Date:From;
	b=tr5pqP6y2KejtfXztGyc9atBUYYnm0PSGD66xIMLqsUXxVznn0wkniNbAq5ro4ynM
	 k+Ev4I7WN2X81VdBHtemCblNA8B10+8tMC2iGRNjW9zY1ZIUifeFRNpghc0Z0COHhB
	 1SEeh6mW8cte5TDGEAwTua5jRWsHN4p2C0TOWceI=
Subject: FAILED: patch "[PATCH] ASoC: qcom: sdw: fix memory leak for sdw_stream_runtime" failed to apply to 6.12-stable tree
To: srinivas.kandagatla@oss.qualcomm.com,broonie@kernel.org,krzysztof.kozlowski@linaro.org,threeway@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Jan 2026 10:26:28 +0100
Message-ID: <2026010528-thesaurus-stoop-f4af@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x bcba17279327c6e85dee6a97014dc642e2dc93cc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026010528-thesaurus-stoop-f4af@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From bcba17279327c6e85dee6a97014dc642e2dc93cc Mon Sep 17 00:00:00 2001
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Date: Wed, 22 Oct 2025 15:33:46 +0100
Subject: [PATCH] ASoC: qcom: sdw: fix memory leak for sdw_stream_runtime

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
Cc: Stable@vger.kernel.org
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Tested-by: Steev Klimaszewski <threeway@gmail.com> # Thinkpad X13s
Link: https://patch.msgid.link/20251022143349.1081513-2-srinivas.kandagatla@oss.qualcomm.com
Signed-off-by: Mark Brown <broonie@kernel.org>

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
index 187f37ffe328..ed8b04c6022e 100644
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


