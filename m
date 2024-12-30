Return-Path: <stable+bounces-106470-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FDF09FE876
	for <lists+stable@lfdr.de>; Mon, 30 Dec 2024 16:55:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 206B57A10DA
	for <lists+stable@lfdr.de>; Mon, 30 Dec 2024 15:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498D81537C8;
	Mon, 30 Dec 2024 15:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sKytHhiK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061602E414;
	Mon, 30 Dec 2024 15:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735574093; cv=none; b=A+W3RzUzFkuHDXxDjCYv2LA5IqHG2GteilOfrfIuLi88s0fjnAAlfsr0UiRVTv8eSbw54w0HJBjKpJy21jpAA8aet/FeAeN4pIHiHTyH4mrvHBs4xGupxrxFgmcQJ0eXJP7ugqdCP8ql1fK9bdZ293fXs6vR8ZbrVjqS9c5SV1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735574093; c=relaxed/simple;
	bh=hjtPhQ8YxlWF2t+fa/HjHqMW6hM0ieB3lWKHs6XxzXs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FwTv2KOXI6pbXu5SwYO9RtukjpdyHYNEKJ9paXPnDK0Z68jpU4/CFj1DeYjB3SGfuxstadQRjJFIwihXxXYWigNt39l++4rZoGLfAveIszyt3CayRwA0ErOFMgUdLd/PXrIDZ9sFEFuoVeeKPs4JAqNiwy216px/136xfUc2S9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sKytHhiK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67797C4CED0;
	Mon, 30 Dec 2024 15:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1735574092;
	bh=hjtPhQ8YxlWF2t+fa/HjHqMW6hM0ieB3lWKHs6XxzXs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sKytHhiKci7FUwQplEpYqpn19Gj4EHH8zXDFP/yRVTv2jMx9dbnxnM0lZ0aDSIlmW
	 safwlFhXi1oN80oR7/FG5+lrrQDLXFkczTVQTlrLMIJAnO2RVqwFuGUucIxogqwnCS
	 pei+dBv4aWQ7LaKVhIidQKd80RilkKtHgeelIQ+g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Liam Girdwood <liam.r.girdwood@intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.12 035/114] ASoC: SOF: Intel: hda-dai: Do not release the link DMA on STOP
Date: Mon, 30 Dec 2024 16:42:32 +0100
Message-ID: <20241230154219.413902951@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241230154218.044787220@linuxfoundation.org>
References: <20241230154218.044787220@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>

commit e8d0ba147d901022bcb69da8d8fd817f84e9f3ca upstream.

The linkDMA should not be released on stop trigger since a stream re-start
might happen without closing of the stream. This leaves a short time for
other streams to 'steal' the linkDMA since it has been released.

This issue is not easy to reproduce under normal conditions as usually
after stop the stream is closed, or the same stream is restarted, but if
another stream got in between the stop and start, like this:
aplay -Dhw:0,3 -c2 -r48000 -fS32_LE /dev/zero -d 120
CTRL+z
aplay -Dhw:0,0 -c2 -r48000 -fS32_LE /dev/zero -d 120

then the link DMA channels will be mixed up, resulting firmware error or
crash.

Fixes: ab5593793e90 ("ASoC: SOF: Intel: hda: Always clean up link DMA during stop")
Cc: stable@vger.kernel.org
Closes: https://github.com/thesofproject/sof/issues/9695
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Liam Girdwood <liam.r.girdwood@intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Link: https://patch.msgid.link/20241217091019.31798-1-peter.ujfalusi@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/sof/intel/hda-dai.c |   25 +++++++++++++++++++------
 sound/soc/sof/intel/hda.h     |    2 --
 2 files changed, 19 insertions(+), 8 deletions(-)

--- a/sound/soc/sof/intel/hda-dai.c
+++ b/sound/soc/sof/intel/hda-dai.c
@@ -103,8 +103,10 @@ hda_dai_get_ops(struct snd_pcm_substream
 	return sdai->platform_private;
 }
 
-int hda_link_dma_cleanup(struct snd_pcm_substream *substream, struct hdac_ext_stream *hext_stream,
-			 struct snd_soc_dai *cpu_dai)
+static int
+hda_link_dma_cleanup(struct snd_pcm_substream *substream,
+		     struct hdac_ext_stream *hext_stream,
+		     struct snd_soc_dai *cpu_dai, bool release)
 {
 	const struct hda_dai_widget_dma_ops *ops = hda_dai_get_ops(substream, cpu_dai);
 	struct sof_intel_hda_stream *hda_stream;
@@ -128,6 +130,17 @@ int hda_link_dma_cleanup(struct snd_pcm_
 		snd_hdac_ext_bus_link_clear_stream_id(hlink, stream_tag);
 	}
 
+	if (!release) {
+		/*
+		 * Force stream reconfiguration without releasing the channel on
+		 * subsequent stream restart (without free), including LinkDMA
+		 * reset.
+		 * The stream is released via hda_dai_hw_free()
+		 */
+		hext_stream->link_prepared = 0;
+		return 0;
+	}
+
 	if (ops->release_hext_stream)
 		ops->release_hext_stream(sdev, cpu_dai, substream);
 
@@ -211,7 +224,7 @@ static int __maybe_unused hda_dai_hw_fre
 	if (!hext_stream)
 		return 0;
 
-	return hda_link_dma_cleanup(substream, hext_stream, cpu_dai);
+	return hda_link_dma_cleanup(substream, hext_stream, cpu_dai, true);
 }
 
 static int __maybe_unused hda_dai_hw_params_data(struct snd_pcm_substream *substream,
@@ -304,7 +317,8 @@ static int __maybe_unused hda_dai_trigge
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_SUSPEND:
-		ret = hda_link_dma_cleanup(substream, hext_stream, dai);
+		ret = hda_link_dma_cleanup(substream, hext_stream, dai,
+					   cmd == SNDRV_PCM_TRIGGER_STOP ? false : true);
 		if (ret < 0) {
 			dev_err(sdev->dev, "%s: failed to clean up link DMA\n", __func__);
 			return ret;
@@ -656,8 +670,7 @@ static int hda_dai_suspend(struct hdac_b
 			}
 
 			ret = hda_link_dma_cleanup(hext_stream->link_substream,
-						   hext_stream,
-						   cpu_dai);
+						   hext_stream, cpu_dai, true);
 			if (ret < 0)
 				return ret;
 		}
--- a/sound/soc/sof/intel/hda.h
+++ b/sound/soc/sof/intel/hda.h
@@ -1028,8 +1028,6 @@ const struct hda_dai_widget_dma_ops *
 hda_select_dai_widget_ops(struct snd_sof_dev *sdev, struct snd_sof_widget *swidget);
 int hda_dai_config(struct snd_soc_dapm_widget *w, unsigned int flags,
 		   struct snd_sof_dai_config_data *data);
-int hda_link_dma_cleanup(struct snd_pcm_substream *substream, struct hdac_ext_stream *hext_stream,
-			 struct snd_soc_dai *cpu_dai);
 
 static inline struct snd_sof_dev *widget_to_sdev(struct snd_soc_dapm_widget *w)
 {



