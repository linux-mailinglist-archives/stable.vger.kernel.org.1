Return-Path: <stable+bounces-56600-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A3692452D
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 19:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC39BB2763B
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 17:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9F41C0DCD;
	Tue,  2 Jul 2024 17:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RrWeOCag"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF7439847;
	Tue,  2 Jul 2024 17:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719940723; cv=none; b=XeFug3mZCsfTRGYTbCrKiG2v76Wv9aCJvpbniJkhXPm6dFqWDgSJsRoFQag9Hoxelrk9vQnkY3c2M1vpVskervmAOAMKtpHijCUULfK4Q1oxKQzPoIftt1sHlFHGdKkaYsDyf+yyM2NsjiBYQHtvO3BtgIjbNXbkzGG6kI3rR+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719940723; c=relaxed/simple;
	bh=gkeZxMsp5fUFDY9pn1vHZax5JsR+MJissmdgFnwNBIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eYTbHKZaHPtIZiPOxNzoX1wlWjYGC3jElXOIjD0RhbC8O+e2Yrvd0N4JoZFl9ijeJQaq8ZazrPIpzi17DJINWztglB1I2Av9G2UU3580xisFhKGp2ApuczdodkcNZNDTM1ADz62HaJ+mHClMckJJlu8FO4EfYASDSyJSuMx8bWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RrWeOCag; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F7A4C116B1;
	Tue,  2 Jul 2024 17:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719940722;
	bh=gkeZxMsp5fUFDY9pn1vHZax5JsR+MJissmdgFnwNBIM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RrWeOCagwvfG6YqZAW0T61Qd8AZ4r3vZmE9l5mBdLvMRLU580fSb+U9VptE8qyaJo
	 vb7/KVUT8+w3gal2sPLhlU1nbc9z4LvJ3bKR+kGZa2dBI0fnHLPHKxG+GNkovh+LqJ
	 qs4wbgRD/ri/LHCzFdFaiLRKTojgyUeFg8XoPk6E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 018/163] ASoC: atmel: convert not to use asoc_xxx()
Date: Tue,  2 Jul 2024 19:02:12 +0200
Message-ID: <20240702170233.748833906@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240702170233.048122282@linuxfoundation.org>
References: <20240702170233.048122282@linuxfoundation.org>
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

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

[ Upstream commit 6547effc3aea50cc3c60874f9a65a19f4919ef9d ]

ASoC is now unified asoc_xxx() into snd_soc_xxx().
This patch convert asoc_xxx() to snd_soc_xxx().

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Link: https://lore.kernel.org/r/87r0n4qniq.wl-kuninori.morimoto.gx@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: 2ed22161b19b ("ASoC: atmel: atmel-classd: Re-add dai_link->platform to fix card init")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/atmel/atmel-classd.c   | 10 +++++-----
 sound/soc/atmel/atmel-pcm-dma.c  |  8 ++++----
 sound/soc/atmel/atmel-pcm-pdc.c  |  4 ++--
 sound/soc/atmel/atmel-pdmic.c    | 12 ++++++------
 sound/soc/atmel/atmel_wm8904.c   |  4 ++--
 sound/soc/atmel/mikroe-proto.c   |  2 +-
 sound/soc/atmel/sam9g20_wm8731.c |  2 +-
 sound/soc/atmel/sam9x5_wm8731.c  |  2 +-
 8 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/sound/soc/atmel/atmel-classd.c b/sound/soc/atmel/atmel-classd.c
index 4c1985711218d..6aed1ee443b44 100644
--- a/sound/soc/atmel/atmel-classd.c
+++ b/sound/soc/atmel/atmel-classd.c
@@ -118,7 +118,7 @@ static const struct snd_pcm_hardware atmel_classd_hw = {
 static int atmel_classd_cpu_dai_startup(struct snd_pcm_substream *substream,
 					struct snd_soc_dai *cpu_dai)
 {
-	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
 	struct atmel_classd *dd = snd_soc_card_get_drvdata(rtd->card);
 	int err;
 
@@ -141,7 +141,7 @@ atmel_classd_platform_configure_dma(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params,
 	struct dma_slave_config *slave_config)
 {
-	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
 	struct atmel_classd *dd = snd_soc_card_get_drvdata(rtd->card);
 
 	if (params_physical_width(params) != 16) {
@@ -338,7 +338,7 @@ atmel_classd_cpu_dai_hw_params(struct snd_pcm_substream *substream,
 			       struct snd_pcm_hw_params *params,
 			       struct snd_soc_dai *cpu_dai)
 {
-	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
 	struct atmel_classd *dd = snd_soc_card_get_drvdata(rtd->card);
 	struct snd_soc_component *component = cpu_dai->component;
 	int fs;
@@ -381,7 +381,7 @@ static void
 atmel_classd_cpu_dai_shutdown(struct snd_pcm_substream *substream,
 			      struct snd_soc_dai *cpu_dai)
 {
-	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
 	struct atmel_classd *dd = snd_soc_card_get_drvdata(rtd->card);
 
 	clk_disable_unprepare(dd->gclk);
@@ -478,7 +478,7 @@ static int atmel_classd_asoc_card_init(struct device *dev,
 		return -ENOMEM;
 
 	dai_link->cpus		= comp;
-	dai_link->codecs	= &asoc_dummy_dlc;
+	dai_link->codecs	= &snd_soc_dummy_dlc;
 
 	dai_link->num_cpus	= 1;
 	dai_link->num_codecs	= 1;
diff --git a/sound/soc/atmel/atmel-pcm-dma.c b/sound/soc/atmel/atmel-pcm-dma.c
index 96a8c7dba98ff..7306e04da513b 100644
--- a/sound/soc/atmel/atmel-pcm-dma.c
+++ b/sound/soc/atmel/atmel-pcm-dma.c
@@ -52,10 +52,10 @@ static const struct snd_pcm_hardware atmel_pcm_dma_hardware = {
 static void atmel_pcm_dma_irq(u32 ssc_sr,
 	struct snd_pcm_substream *substream)
 {
-	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
 	struct atmel_pcm_dma_params *prtd;
 
-	prtd = snd_soc_dai_get_dma_data(asoc_rtd_to_cpu(rtd, 0), substream);
+	prtd = snd_soc_dai_get_dma_data(snd_soc_rtd_to_cpu(rtd, 0), substream);
 
 	if (ssc_sr & prtd->mask->ssc_error) {
 		if (snd_pcm_running(substream))
@@ -77,12 +77,12 @@ static void atmel_pcm_dma_irq(u32 ssc_sr,
 static int atmel_pcm_configure_dma(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params, struct dma_slave_config *slave_config)
 {
-	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
 	struct atmel_pcm_dma_params *prtd;
 	struct ssc_device *ssc;
 	int ret;
 
-	prtd = snd_soc_dai_get_dma_data(asoc_rtd_to_cpu(rtd, 0), substream);
+	prtd = snd_soc_dai_get_dma_data(snd_soc_rtd_to_cpu(rtd, 0), substream);
 	ssc = prtd->ssc;
 
 	ret = snd_hwparams_to_dma_slave_config(substream, params, slave_config);
diff --git a/sound/soc/atmel/atmel-pcm-pdc.c b/sound/soc/atmel/atmel-pcm-pdc.c
index 3e7ea2021b46b..7db8df85c54f3 100644
--- a/sound/soc/atmel/atmel-pcm-pdc.c
+++ b/sound/soc/atmel/atmel-pcm-pdc.c
@@ -140,12 +140,12 @@ static int atmel_pcm_hw_params(struct snd_soc_component *component,
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct atmel_runtime_data *prtd = runtime->private_data;
-	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
 
 	/* this may get called several times by oss emulation
 	 * with different params */
 
-	prtd->params = snd_soc_dai_get_dma_data(asoc_rtd_to_cpu(rtd, 0), substream);
+	prtd->params = snd_soc_dai_get_dma_data(snd_soc_rtd_to_cpu(rtd, 0), substream);
 	prtd->params->dma_intr_handler = atmel_pcm_dma_irq;
 
 	prtd->dma_buffer = runtime->dma_addr;
diff --git a/sound/soc/atmel/atmel-pdmic.c b/sound/soc/atmel/atmel-pdmic.c
index 0db7815d230c3..fa29dd8ef2089 100644
--- a/sound/soc/atmel/atmel-pdmic.c
+++ b/sound/soc/atmel/atmel-pdmic.c
@@ -104,7 +104,7 @@ static struct atmel_pdmic_pdata *atmel_pdmic_dt_init(struct device *dev)
 static int atmel_pdmic_cpu_dai_startup(struct snd_pcm_substream *substream,
 					struct snd_soc_dai *cpu_dai)
 {
-	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
 	struct atmel_pdmic *dd = snd_soc_card_get_drvdata(rtd->card);
 	int ret;
 
@@ -132,7 +132,7 @@ static int atmel_pdmic_cpu_dai_startup(struct snd_pcm_substream *substream,
 static void atmel_pdmic_cpu_dai_shutdown(struct snd_pcm_substream *substream,
 					struct snd_soc_dai *cpu_dai)
 {
-	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
 	struct atmel_pdmic *dd = snd_soc_card_get_drvdata(rtd->card);
 
 	/* Disable the overrun error interrupt */
@@ -145,7 +145,7 @@ static void atmel_pdmic_cpu_dai_shutdown(struct snd_pcm_substream *substream,
 static int atmel_pdmic_cpu_dai_prepare(struct snd_pcm_substream *substream,
 					struct snd_soc_dai *cpu_dai)
 {
-	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
 	struct atmel_pdmic *dd = snd_soc_card_get_drvdata(rtd->card);
 	struct snd_soc_component *component = cpu_dai->component;
 	u32 val;
@@ -191,7 +191,7 @@ atmel_pdmic_platform_configure_dma(struct snd_pcm_substream *substream,
 				struct snd_pcm_hw_params *params,
 				struct dma_slave_config *slave_config)
 {
-	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
 	struct atmel_pdmic *dd = snd_soc_card_get_drvdata(rtd->card);
 	int ret;
 
@@ -356,7 +356,7 @@ atmel_pdmic_cpu_dai_hw_params(struct snd_pcm_substream *substream,
 			      struct snd_pcm_hw_params *params,
 			      struct snd_soc_dai *cpu_dai)
 {
-	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
 	struct atmel_pdmic *dd = snd_soc_card_get_drvdata(rtd->card);
 	struct snd_soc_component *component = cpu_dai->component;
 	unsigned int rate_min = substream->runtime->hw.rate_min;
@@ -501,7 +501,7 @@ static int atmel_pdmic_asoc_card_init(struct device *dev,
 		return -ENOMEM;
 
 	dai_link->cpus		= comp;
-	dai_link->codecs	= &asoc_dummy_dlc;
+	dai_link->codecs	= &snd_soc_dummy_dlc;
 
 	dai_link->num_cpus	= 1;
 	dai_link->num_codecs	= 1;
diff --git a/sound/soc/atmel/atmel_wm8904.c b/sound/soc/atmel/atmel_wm8904.c
index 00e98136bec25..01e944fa11483 100644
--- a/sound/soc/atmel/atmel_wm8904.c
+++ b/sound/soc/atmel/atmel_wm8904.c
@@ -26,8 +26,8 @@ static const struct snd_soc_dapm_widget atmel_asoc_wm8904_dapm_widgets[] = {
 static int atmel_asoc_wm8904_hw_params(struct snd_pcm_substream *substream,
 		struct snd_pcm_hw_params *params)
 {
-	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
-	struct snd_soc_dai *codec_dai = asoc_rtd_to_codec(rtd, 0);
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
+	struct snd_soc_dai *codec_dai = snd_soc_rtd_to_codec(rtd, 0);
 	int ret;
 
 	ret = snd_soc_dai_set_pll(codec_dai, WM8904_FLL_MCLK, WM8904_FLL_MCLK,
diff --git a/sound/soc/atmel/mikroe-proto.c b/sound/soc/atmel/mikroe-proto.c
index 30c87c2c1b0bd..18a8760443ae6 100644
--- a/sound/soc/atmel/mikroe-proto.c
+++ b/sound/soc/atmel/mikroe-proto.c
@@ -21,7 +21,7 @@
 static int snd_proto_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_card *card = rtd->card;
-	struct snd_soc_dai *codec_dai = asoc_rtd_to_codec(rtd, 0);
+	struct snd_soc_dai *codec_dai = snd_soc_rtd_to_codec(rtd, 0);
 
 	/* Set proto sysclk */
 	int ret = snd_soc_dai_set_sysclk(codec_dai, WM8731_SYSCLK_XTAL,
diff --git a/sound/soc/atmel/sam9g20_wm8731.c b/sound/soc/atmel/sam9g20_wm8731.c
index 0405e9e49140e..d3ec9826d505f 100644
--- a/sound/soc/atmel/sam9g20_wm8731.c
+++ b/sound/soc/atmel/sam9g20_wm8731.c
@@ -66,7 +66,7 @@ static const struct snd_soc_dapm_route intercon[] = {
  */
 static int at91sam9g20ek_wm8731_init(struct snd_soc_pcm_runtime *rtd)
 {
-	struct snd_soc_dai *codec_dai = asoc_rtd_to_codec(rtd, 0);
+	struct snd_soc_dai *codec_dai = snd_soc_rtd_to_codec(rtd, 0);
 	struct device *dev = rtd->dev;
 	int ret;
 
diff --git a/sound/soc/atmel/sam9x5_wm8731.c b/sound/soc/atmel/sam9x5_wm8731.c
index cd1d59a90e021..d1c1f370a9cd5 100644
--- a/sound/soc/atmel/sam9x5_wm8731.c
+++ b/sound/soc/atmel/sam9x5_wm8731.c
@@ -40,7 +40,7 @@ struct sam9x5_drvdata {
  */
 static int sam9x5_wm8731_init(struct snd_soc_pcm_runtime *rtd)
 {
-	struct snd_soc_dai *codec_dai = asoc_rtd_to_codec(rtd, 0);
+	struct snd_soc_dai *codec_dai = snd_soc_rtd_to_codec(rtd, 0);
 	struct device *dev = rtd->dev;
 	int ret;
 
-- 
2.43.0




