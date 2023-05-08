Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAAA56FA5F9
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234273AbjEHKOy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234299AbjEHKOt (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:14:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B88C219413
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:14:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E72C62461
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:14:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6099AC433EF;
        Mon,  8 May 2023 10:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683540886;
        bh=1bM7GDM268V3JwW9V+XQq64HRE/lwIG0oDu5w9HEcTs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jvh3Az1zmC5mCiUbMeRwPUMZG1aQyXBhdfMu81Ob1ztvxavIqTYrz8AW3NA0dLWrq
         eraHykMmy8+y0b6aFPHM7kjFWvvX/BaDFJTaYBz+LOkIovAI2FFOQrced40HPFQHlJ
         kD2Ee8enBu4Wv6gC/gbEiEoPno+kP02EkNekhu+Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        =?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 536/611] soundwire: cadence: rename sdw_cdns_dai_dma_data as sdw_cdns_dai_runtime
Date:   Mon,  8 May 2023 11:46:18 +0200
Message-Id: <20230508094439.424807634@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

[ Upstream commit e0767e391079687081c5564b1390983c36b49cd1 ]

The existing 'struct sdw_cdns_dma_data' has really nothing to do with
DMAs. The information is stored in the dai->dma_data, but this is
really private data that should be stored in a different context.

Beyond the academic elegance discussion, using dma_data is a problem
for new Intel hardware where the dma_data structure is already used
for true DMA handling performed by other parts of the code.

This patch prepares a transition away from the use of dma_data, for
now with a rename-only change.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Link: https://lore.kernel.org/r/20221101023521.2384586-2-yung-chuan.liao@linux.intel.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Stable-dep-of: 0a0d1740bd8f ("soundwire: intel: don't save hw_params for use in prepare")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soundwire/cadence_master.c | 30 +++++-----
 drivers/soundwire/cadence_master.h |  4 +-
 drivers/soundwire/intel.c          | 96 +++++++++++++++---------------
 3 files changed, 65 insertions(+), 65 deletions(-)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index e7da7d7b213fb..7286c9b3be691 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -1719,40 +1719,40 @@ int cdns_set_sdw_stream(struct snd_soc_dai *dai,
 			void *stream, int direction)
 {
 	struct sdw_cdns *cdns = snd_soc_dai_get_drvdata(dai);
-	struct sdw_cdns_dma_data *dma;
+	struct sdw_cdns_dai_runtime *dai_runtime;
 
 	if (stream) {
 		/* first paranoia check */
 		if (direction == SNDRV_PCM_STREAM_PLAYBACK)
-			dma = dai->playback_dma_data;
+			dai_runtime = dai->playback_dma_data;
 		else
-			dma = dai->capture_dma_data;
+			dai_runtime = dai->capture_dma_data;
 
-		if (dma) {
+		if (dai_runtime) {
 			dev_err(dai->dev,
-				"dma_data already allocated for dai %s\n",
+				"dai_runtime already allocated for dai %s\n",
 				dai->name);
 			return -EINVAL;
 		}
 
-		/* allocate and set dma info */
-		dma = kzalloc(sizeof(*dma), GFP_KERNEL);
-		if (!dma)
+		/* allocate and set dai_runtime info */
+		dai_runtime = kzalloc(sizeof(*dai_runtime), GFP_KERNEL);
+		if (!dai_runtime)
 			return -ENOMEM;
 
-		dma->stream_type = SDW_STREAM_PCM;
+		dai_runtime->stream_type = SDW_STREAM_PCM;
 
-		dma->bus = &cdns->bus;
-		dma->link_id = cdns->instance;
+		dai_runtime->bus = &cdns->bus;
+		dai_runtime->link_id = cdns->instance;
 
-		dma->stream = stream;
+		dai_runtime->stream = stream;
 
 		if (direction == SNDRV_PCM_STREAM_PLAYBACK)
-			dai->playback_dma_data = dma;
+			dai->playback_dma_data = dai_runtime;
 		else
-			dai->capture_dma_data = dma;
+			dai->capture_dma_data = dai_runtime;
 	} else {
-		/* for NULL stream we release allocated dma_data */
+		/* for NULL stream we release allocated dai_runtime */
 		if (direction == SNDRV_PCM_STREAM_PLAYBACK) {
 			kfree(dai->playback_dma_data);
 			dai->playback_dma_data = NULL;
diff --git a/drivers/soundwire/cadence_master.h b/drivers/soundwire/cadence_master.h
index 51e6ecc027cbc..9b0113d48e419 100644
--- a/drivers/soundwire/cadence_master.h
+++ b/drivers/soundwire/cadence_master.h
@@ -76,7 +76,7 @@ struct sdw_cdns_stream_config {
 };
 
 /**
- * struct sdw_cdns_dma_data: Cadence DMA data
+ * struct sdw_cdns_dai_runtime: Cadence DAI runtime data
  *
  * @name: SoundWire stream name
  * @stream: stream runtime
@@ -88,7 +88,7 @@ struct sdw_cdns_stream_config {
  * @suspended: status set when suspended, to be used in .prepare
  * @paused: status set in .trigger, to be used in suspend
  */
-struct sdw_cdns_dma_data {
+struct sdw_cdns_dai_runtime {
 	char *name;
 	struct sdw_stream_runtime *stream;
 	struct sdw_cdns_pdi *pdi;
diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 8c76541d553f1..52e5c54b4f36a 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -824,15 +824,15 @@ static int intel_hw_params(struct snd_pcm_substream *substream,
 {
 	struct sdw_cdns *cdns = snd_soc_dai_get_drvdata(dai);
 	struct sdw_intel *sdw = cdns_to_intel(cdns);
-	struct sdw_cdns_dma_data *dma;
+	struct sdw_cdns_dai_runtime *dai_runtime;
 	struct sdw_cdns_pdi *pdi;
 	struct sdw_stream_config sconfig;
 	struct sdw_port_config *pconfig;
 	int ch, dir;
 	int ret;
 
-	dma = snd_soc_dai_get_dma_data(dai, substream);
-	if (!dma)
+	dai_runtime = snd_soc_dai_get_dma_data(dai, substream);
+	if (!dai_runtime)
 		return -EIO;
 
 	ch = params_channels(params);
@@ -854,10 +854,10 @@ static int intel_hw_params(struct snd_pcm_substream *substream,
 	sdw_cdns_config_stream(cdns, ch, dir, pdi);
 
 	/* store pdi and hw_params, may be needed in prepare step */
-	dma->paused = false;
-	dma->suspended = false;
-	dma->pdi = pdi;
-	dma->hw_params = params;
+	dai_runtime->paused = false;
+	dai_runtime->suspended = false;
+	dai_runtime->pdi = pdi;
+	dai_runtime->hw_params = params;
 
 	/* Inform DSP about PDI stream number */
 	ret = intel_params_stream(sdw, substream->stream, dai, params,
@@ -869,7 +869,7 @@ static int intel_hw_params(struct snd_pcm_substream *substream,
 	sconfig.direction = dir;
 	sconfig.ch_count = ch;
 	sconfig.frame_rate = params_rate(params);
-	sconfig.type = dma->stream_type;
+	sconfig.type = dai_runtime->stream_type;
 
 	sconfig.bps = snd_pcm_format_width(params_format(params));
 
@@ -884,7 +884,7 @@ static int intel_hw_params(struct snd_pcm_substream *substream,
 	pconfig->ch_mask = (1 << ch) - 1;
 
 	ret = sdw_stream_add_master(&cdns->bus, &sconfig,
-				    pconfig, 1, dma->stream);
+				    pconfig, 1, dai_runtime->stream);
 	if (ret)
 		dev_err(cdns->dev, "add master to stream failed:%d\n", ret);
 
@@ -898,19 +898,19 @@ static int intel_prepare(struct snd_pcm_substream *substream,
 {
 	struct sdw_cdns *cdns = snd_soc_dai_get_drvdata(dai);
 	struct sdw_intel *sdw = cdns_to_intel(cdns);
-	struct sdw_cdns_dma_data *dma;
+	struct sdw_cdns_dai_runtime *dai_runtime;
 	int ch, dir;
 	int ret = 0;
 
-	dma = snd_soc_dai_get_dma_data(dai, substream);
-	if (!dma) {
-		dev_err(dai->dev, "failed to get dma data in %s\n",
+	dai_runtime = snd_soc_dai_get_dma_data(dai, substream);
+	if (!dai_runtime) {
+		dev_err(dai->dev, "failed to get dai runtime in %s\n",
 			__func__);
 		return -EIO;
 	}
 
-	if (dma->suspended) {
-		dma->suspended = false;
+	if (dai_runtime->suspended) {
+		dai_runtime->suspended = false;
 
 		/*
 		 * .prepare() is called after system resume, where we
@@ -921,21 +921,21 @@ static int intel_prepare(struct snd_pcm_substream *substream,
 		 */
 
 		/* configure stream */
-		ch = params_channels(dma->hw_params);
+		ch = params_channels(dai_runtime->hw_params);
 		if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
 			dir = SDW_DATA_DIR_RX;
 		else
 			dir = SDW_DATA_DIR_TX;
 
-		intel_pdi_shim_configure(sdw, dma->pdi);
-		intel_pdi_alh_configure(sdw, dma->pdi);
-		sdw_cdns_config_stream(cdns, ch, dir, dma->pdi);
+		intel_pdi_shim_configure(sdw, dai_runtime->pdi);
+		intel_pdi_alh_configure(sdw, dai_runtime->pdi);
+		sdw_cdns_config_stream(cdns, ch, dir, dai_runtime->pdi);
 
 		/* Inform DSP about PDI stream number */
 		ret = intel_params_stream(sdw, substream->stream, dai,
-					  dma->hw_params,
+					  dai_runtime->hw_params,
 					  sdw->instance,
-					  dma->pdi->intel_alh_id);
+					  dai_runtime->pdi->intel_alh_id);
 	}
 
 	return ret;
@@ -946,11 +946,11 @@ intel_hw_free(struct snd_pcm_substream *substream, struct snd_soc_dai *dai)
 {
 	struct sdw_cdns *cdns = snd_soc_dai_get_drvdata(dai);
 	struct sdw_intel *sdw = cdns_to_intel(cdns);
-	struct sdw_cdns_dma_data *dma;
+	struct sdw_cdns_dai_runtime *dai_runtime;
 	int ret;
 
-	dma = snd_soc_dai_get_dma_data(dai, substream);
-	if (!dma)
+	dai_runtime = snd_soc_dai_get_dma_data(dai, substream);
+	if (!dai_runtime)
 		return -EIO;
 
 	/*
@@ -959,10 +959,10 @@ intel_hw_free(struct snd_pcm_substream *substream, struct snd_soc_dai *dai)
 	 * DEPREPARED for the first cpu-dai and to RELEASED for the last
 	 * cpu-dai.
 	 */
-	ret = sdw_stream_remove_master(&cdns->bus, dma->stream);
+	ret = sdw_stream_remove_master(&cdns->bus, dai_runtime->stream);
 	if (ret < 0) {
 		dev_err(dai->dev, "remove master from stream %s failed: %d\n",
-			dma->stream->name, ret);
+			dai_runtime->stream->name, ret);
 		return ret;
 	}
 
@@ -972,8 +972,8 @@ intel_hw_free(struct snd_pcm_substream *substream, struct snd_soc_dai *dai)
 		return ret;
 	}
 
-	dma->hw_params = NULL;
-	dma->pdi = NULL;
+	dai_runtime->hw_params = NULL;
+	dai_runtime->pdi = NULL;
 
 	return 0;
 }
@@ -996,17 +996,17 @@ static int intel_pcm_set_sdw_stream(struct snd_soc_dai *dai,
 static void *intel_get_sdw_stream(struct snd_soc_dai *dai,
 				  int direction)
 {
-	struct sdw_cdns_dma_data *dma;
+	struct sdw_cdns_dai_runtime *dai_runtime;
 
 	if (direction == SNDRV_PCM_STREAM_PLAYBACK)
-		dma = dai->playback_dma_data;
+		dai_runtime = dai->playback_dma_data;
 	else
-		dma = dai->capture_dma_data;
+		dai_runtime = dai->capture_dma_data;
 
-	if (!dma)
+	if (!dai_runtime)
 		return ERR_PTR(-EINVAL);
 
-	return dma->stream;
+	return dai_runtime->stream;
 }
 
 static int intel_trigger(struct snd_pcm_substream *substream, int cmd, struct snd_soc_dai *dai)
@@ -1014,7 +1014,7 @@ static int intel_trigger(struct snd_pcm_substream *substream, int cmd, struct sn
 	struct sdw_cdns *cdns = snd_soc_dai_get_drvdata(dai);
 	struct sdw_intel *sdw = cdns_to_intel(cdns);
 	struct sdw_intel_link_res *res = sdw->link_res;
-	struct sdw_cdns_dma_data *dma;
+	struct sdw_cdns_dai_runtime *dai_runtime;
 	int ret = 0;
 
 	/*
@@ -1025,9 +1025,9 @@ static int intel_trigger(struct snd_pcm_substream *substream, int cmd, struct sn
 	if (res->ops && res->ops->trigger)
 		res->ops->trigger(dai, cmd, substream->stream);
 
-	dma = snd_soc_dai_get_dma_data(dai, substream);
-	if (!dma) {
-		dev_err(dai->dev, "failed to get dma data in %s\n",
+	dai_runtime = snd_soc_dai_get_dma_data(dai, substream);
+	if (!dai_runtime) {
+		dev_err(dai->dev, "failed to get dai runtime in %s\n",
 			__func__);
 		return -EIO;
 	}
@@ -1042,17 +1042,17 @@ static int intel_trigger(struct snd_pcm_substream *substream, int cmd, struct sn
 		 * the .trigger callback is used to track the suspend case only.
 		 */
 
-		dma->suspended = true;
+		dai_runtime->suspended = true;
 
 		ret = intel_free_stream(sdw, substream->stream, dai, sdw->instance);
 		break;
 
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
-		dma->paused = true;
+		dai_runtime->paused = true;
 		break;
 	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-		dma->paused = false;
+		dai_runtime->paused = false;
 		break;
 	default:
 		break;
@@ -1091,25 +1091,25 @@ static int intel_component_dais_suspend(struct snd_soc_component *component)
 	for_each_component_dais(component, dai) {
 		struct sdw_cdns *cdns = snd_soc_dai_get_drvdata(dai);
 		struct sdw_intel *sdw = cdns_to_intel(cdns);
-		struct sdw_cdns_dma_data *dma;
+		struct sdw_cdns_dai_runtime *dai_runtime;
 		int stream;
 		int ret;
 
-		dma = dai->playback_dma_data;
+		dai_runtime = dai->playback_dma_data;
 		stream = SNDRV_PCM_STREAM_PLAYBACK;
-		if (!dma) {
-			dma = dai->capture_dma_data;
+		if (!dai_runtime) {
+			dai_runtime = dai->capture_dma_data;
 			stream = SNDRV_PCM_STREAM_CAPTURE;
 		}
 
-		if (!dma)
+		if (!dai_runtime)
 			continue;
 
-		if (dma->suspended)
+		if (dai_runtime->suspended)
 			continue;
 
-		if (dma->paused) {
-			dma->suspended = true;
+		if (dai_runtime->paused) {
+			dai_runtime->suspended = true;
 
 			ret = intel_free_stream(sdw, stream, dai, sdw->instance);
 			if (ret < 0)
-- 
2.39.2



