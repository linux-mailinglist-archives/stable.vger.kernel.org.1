Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1D09782925
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 14:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234975AbjHUMbp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 08:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234953AbjHUMbh (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 08:31:37 -0400
X-Greylist: delayed 537 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 21 Aug 2023 05:31:30 PDT
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BFBC123
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 05:31:30 -0700 (PDT)
Received: from mail1.perex.cz (localhost [127.0.0.1])
        by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 2438E11F1;
        Mon, 21 Aug 2023 14:22:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 2438E11F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
        t=1692620550; bh=xfeW/55pMYyoFksGvZS1EkAq4WvE8kmBbiBaPF1+Xw4=;
        h=From:To:Cc:Subject:Date:From;
        b=dH7PdGnL3seioLQX/h85J/6OInirgGu4yuj3D4tZ2zGH2xlC3nTd3y/NXVGVhwqy+
         4WfDaA97pEL+TaPLZS971gjcfK8y6VUTlkIctI3B60fF8WnqIxQ/TwIagI2zQZphJQ
         SQpZgR6NuwbDU0JE0CTGMFCLKY0jmn2dThP6X/+Q=
Received: from p1gen4.perex-int.cz (unknown [192.168.100.98])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: perex)
        by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
        Mon, 21 Aug 2023 14:22:20 +0200 (CEST)
From:   Jaroslav Kysela <perex@perex.cz>
To:     ALSA development <alsa-devel@alsa-project.org>
Cc:     stable@vger.kernel.org,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Rander Wang <rander.wang@intel.com>,
        =?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>
Subject: [PATCH] [6.4.y] ASoC: SOF: intel: hda: Clean up link DMA for IPC3 during stop
Date:   Mon, 21 Aug 2023 14:22:09 +0200
Message-ID: <20230821122209.20139-1-perex@perex.cz>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>

commit 90219f1bd273055f1dc1d7bdc0965755b992c045 upstream.

With IPC3, we reset hw_params during the stop trigger, so we should also
clean up the link DMA during the stop trigger.

Cc: <stable@vger.kernel.org> # 6.4.x
Fixes: 1bf83fa6654c ("ASoC: SOF: Intel: hda-dai: Do not perform DMA cleanup during stop")
Closes: https://github.com/thesofproject/linux/issues/4455
Closes: https://github.com/thesofproject/linux/issues/4482
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217673
Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Link: https://lore.kernel.org/r/20230808110627.32375-1-peter.ujfalusi@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>

Note that many recent Intel based laptops are affected.

Added missing code for 6.4 kernels to keep the fix simple not depending
on the other changes. This commit is present in 6.5 tree already.

Signed-off-by: Jaroslav Kysela <perex@perex.cz>
---
 sound/soc/sof/intel/hda-dai-ops.c | 13 ++++++++++++-
 sound/soc/sof/intel/hda-dai.c     |  8 ++++----
 sound/soc/sof/intel/hda.h         |  2 ++
 3 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/sound/soc/sof/intel/hda-dai-ops.c b/sound/soc/sof/intel/hda-dai-ops.c
index 4b39cecacd68..5938046f46b2 100644
--- a/sound/soc/sof/intel/hda-dai-ops.c
+++ b/sound/soc/sof/intel/hda-dai-ops.c
@@ -289,16 +289,27 @@ static const struct hda_dai_widget_dma_ops hda_ipc4_chain_dma_ops = {
 static int hda_ipc3_post_trigger(struct snd_sof_dev *sdev, struct snd_soc_dai *cpu_dai,
 				 struct snd_pcm_substream *substream, int cmd)
 {
+	struct hdac_ext_stream *hext_stream = hda_get_hext_stream(sdev, cpu_dai, substream);
 	struct snd_soc_dapm_widget *w = snd_soc_dai_get_widget(cpu_dai, substream->stream);
+	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
+	struct snd_soc_dai *codec_dai = asoc_rtd_to_codec(rtd, 0);
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_SUSPEND:
 	case SNDRV_PCM_TRIGGER_STOP:
 	{
 		struct snd_sof_dai_config_data data = { 0 };
+		int ret;
 
 		data.dai_data = DMA_CHAN_INVALID;
-		return hda_dai_config(w, SOF_DAI_CONFIG_FLAGS_HW_FREE, &data);
+		ret = hda_dai_config(w, SOF_DAI_CONFIG_FLAGS_HW_FREE, &data);
+		if (ret < 0)
+			return ret;
+
+		if (cmd == SNDRV_PCM_TRIGGER_STOP)
+			return hda_link_dma_cleanup(substream, hext_stream, cpu_dai, codec_dai);
+
+		break;
 	}
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
 		return hda_dai_config(w, SOF_DAI_CONFIG_FLAGS_PAUSE, NULL);
diff --git a/sound/soc/sof/intel/hda-dai.c b/sound/soc/sof/intel/hda-dai.c
index 44a5d94c5050..8a76320c3b99 100644
--- a/sound/soc/sof/intel/hda-dai.c
+++ b/sound/soc/sof/intel/hda-dai.c
@@ -91,10 +91,10 @@ hda_dai_get_ops(struct snd_pcm_substream *substream, struct snd_soc_dai *cpu_dai
 	return sdai->platform_private;
 }
 
-static int hda_link_dma_cleanup(struct snd_pcm_substream *substream,
-				struct hdac_ext_stream *hext_stream,
-				struct snd_soc_dai *cpu_dai,
-				struct snd_soc_dai *codec_dai)
+int hda_link_dma_cleanup(struct snd_pcm_substream *substream,
+			 struct hdac_ext_stream *hext_stream,
+			 struct snd_soc_dai *cpu_dai,
+			 struct snd_soc_dai *codec_dai)
 {
 	struct snd_sof_dev *sdev = snd_soc_component_get_drvdata(cpu_dai->component);
 	const struct hda_dai_widget_dma_ops *ops = hda_dai_get_ops(substream, cpu_dai);
diff --git a/sound/soc/sof/intel/hda.h b/sound/soc/sof/intel/hda.h
index c4befacde23e..94c738eae751 100644
--- a/sound/soc/sof/intel/hda.h
+++ b/sound/soc/sof/intel/hda.h
@@ -942,5 +942,7 @@ const struct hda_dai_widget_dma_ops *
 hda_select_dai_widget_ops(struct snd_sof_dev *sdev, struct snd_sof_widget *swidget);
 int hda_dai_config(struct snd_soc_dapm_widget *w, unsigned int flags,
 		   struct snd_sof_dai_config_data *data);
+int hda_link_dma_cleanup(struct snd_pcm_substream *substream, struct hdac_ext_stream *hext_stream,
+			 struct snd_soc_dai *cpu_dai, struct snd_soc_dai *codec_dai);
 
 #endif
-- 
2.41.0

