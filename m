Return-Path: <stable+bounces-204816-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E61CF43FB
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 15:54:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1988C306BC4A
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 14:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 853ED31AAB3;
	Mon,  5 Jan 2026 14:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dU3mdFdH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442AE1D5178
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 14:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767624466; cv=none; b=hCCWs+iPRAyPmM/8PONuJSHrPeIA0OfJ2aDZRluiX/ZiQNiUiaXhk2mEIOiiZVlfOw/uQeX2oHsJZ23dt7LmEyUsavvoGghLoL3MupCjtn1BEya1MsJ4qcLe9AW904Vq0u1HgNWHLVUQIq3KAYB27iVWZXVSNZM6cT5T4hMbbNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767624466; c=relaxed/simple;
	bh=zW8wiKqBpk7al4kBpuU585w5nznaFybkEx8AsygUzG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ku8uMdD+7JR9dPCO4Dd/9/kZxdxYcZctj1Knb8jWiZYCA25p5NB8xixve8/mQOaCWtrrv/e8emx/aQo+e+AKq/q6cfEozlO2sCDKtuAw0u1sivBsPYSqvYKdMderVfqdPmMgm3WTijgnTwCsanZAfZ12vRy1nlQJarqyZ4Vos5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dU3mdFdH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26595C116D0;
	Mon,  5 Jan 2026 14:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767624465;
	bh=zW8wiKqBpk7al4kBpuU585w5nznaFybkEx8AsygUzG0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dU3mdFdHtPLWs0hHYUmlH4hHKu2cdowz4xoNLIIF4XVkm/m+oCmjozSFFcrrib+UP
	 PUN00BGZuloLx+WEC7PrpaXb6haizBMrDbayiBHC14MJpnNVDnla9nqBNJaU4qNPGY
	 qhkJFZliapUYCEsRMjKCh7jCNNzSl5mz2fOv22AxDDkikdZ8tfoTkWMPpTaZPm3CD+
	 /Qx/jmAIlbUHf2rLPXlzs30Ar6AfIe19eMEbCwQksFt6/I8VW3MczgvPD8w/S0Xexv
	 8A0NXl4641E+2fZkwvzOc4qmvk7Y0zA5Bi/qPmm7j72SietkzwX0jXfY2XvDD3/LlQ
	 xUL+SrUV+xo0w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	stable@kernel.org,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] ASoC: renesas: rz-ssi: Fix rz_ssi_priv::hw_params_cache::sample_width
Date: Mon,  5 Jan 2026 09:47:43 -0500
Message-ID: <20260105144743.2610088-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026010516-urologist-conch-2dd6@gregkh>
References: <2026010516-urologist-conch-2dd6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 2bae7beda19f3b2dc6ab2062c94df19c27923712 ]

The strm->sample_width is not filled during rz_ssi_dai_hw_params(). This
wrong value is used for caching sample_width in struct hw_params_cache.
Fix this issue by replacing 'strm->sample_width'->'params_width(params)'
in rz_ssi_dai_hw_params(). After this drop the variable sample_width
from struct rz_ssi_stream as it is unused.

Cc: stable@kernel.org
Fixes: 4f8cd05a4305 ("ASoC: sh: rz-ssi: Add full duplex support")
Reviewed-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://patch.msgid.link/20251114073709.4376-3-biju.das.jz@bp.renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sh/rz-ssi.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/sound/soc/sh/rz-ssi.c b/sound/soc/sh/rz-ssi.c
index 4f483bfa584f..d5be91d86da0 100644
--- a/sound/soc/sh/rz-ssi.c
+++ b/sound/soc/sh/rz-ssi.c
@@ -12,6 +12,7 @@
 #include <linux/module.h>
 #include <linux/pm_runtime.h>
 #include <linux/reset.h>
+#include <sound/pcm_params.h>
 #include <sound/soc.h>
 
 /* REGISTER OFFSET */
@@ -85,7 +86,6 @@ struct rz_ssi_stream {
 	int fifo_sample_size;	/* sample capacity of SSI FIFO */
 	int dma_buffer_pos;	/* The address for the next DMA descriptor */
 	int period_counter;	/* for keeping track of periods transferred */
-	int sample_width;
 	int buffer_pos;		/* current frame position in the buffer */
 	int running;		/* 0=stopped, 1=running */
 
@@ -225,10 +225,7 @@ static inline bool rz_ssi_is_stream_running(struct rz_ssi_stream *strm)
 static void rz_ssi_stream_init(struct rz_ssi_stream *strm,
 			       struct snd_pcm_substream *substream)
 {
-	struct snd_pcm_runtime *runtime = substream->runtime;
-
 	rz_ssi_set_substream(strm, substream);
-	strm->sample_width = samples_to_bytes(runtime, 1);
 	strm->dma_buffer_pos = 0;
 	strm->period_counter = 0;
 	strm->buffer_pos = 0;
@@ -927,9 +924,9 @@ static int rz_ssi_dai_hw_params(struct snd_pcm_substream *substream,
 				struct snd_soc_dai *dai)
 {
 	struct rz_ssi_priv *ssi = snd_soc_dai_get_drvdata(dai);
-	struct rz_ssi_stream *strm = rz_ssi_stream_get(ssi, substream);
 	unsigned int sample_bits = hw_param_interval(params,
 					SNDRV_PCM_HW_PARAM_SAMPLE_BITS)->min;
+	unsigned int sample_width = params_width(params);
 	unsigned int channels = params_channels(params);
 	unsigned int rate = params_rate(params);
 
@@ -947,16 +944,14 @@ static int rz_ssi_dai_hw_params(struct snd_pcm_substream *substream,
 
 	if (rz_ssi_is_stream_running(&ssi->playback) ||
 	    rz_ssi_is_stream_running(&ssi->capture)) {
-		if (rz_ssi_is_valid_hw_params(ssi, rate, channels,
-					      strm->sample_width, sample_bits))
+		if (rz_ssi_is_valid_hw_params(ssi, rate, channels, sample_width, sample_bits))
 			return 0;
 
 		dev_err(ssi->dev, "Full duplex needs same HW params\n");
 		return -EINVAL;
 	}
 
-	rz_ssi_cache_hw_params(ssi, rate, channels, strm->sample_width,
-			       sample_bits);
+	rz_ssi_cache_hw_params(ssi, rate, channels, sample_width, sample_bits);
 
 	return rz_ssi_clk_setup(ssi, rate, channels);
 }
-- 
2.51.0


