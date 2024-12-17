Return-Path: <stable+bounces-104463-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7A09F46EA
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 10:10:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3276188E728
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 09:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D2C71DE3AA;
	Tue, 17 Dec 2024 09:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gsr9rvDN"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE401DDA35;
	Tue, 17 Dec 2024 09:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734426609; cv=none; b=vFz494SGNHfUT+6+dfzl7BxUWLXSycvJFzuOfXMvBFAhEFhkWvg9FCxlFI+re2twQR0Qi4scXP8L6hWWXxXeO577pLXk3eFaAAQLSl73btBp9sWND+vouE+mA6ro7BvZAUmjwYjvP9JCWi08k/oUUV0z0H35AA6CLjMZZGpVzOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734426609; c=relaxed/simple;
	bh=jlcwFC3JQLCv5lJgHAPOErV2JEPUxNk27bQ2DdZgO5o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L52HMPWnHwzS7jcMJyL0sjyGU/BSa4KGPgYXkXNf6BkkHWqcHAlUh1GWs0CzkLuQvXb5+/H16iJYxgacGoR+jeMIgH/1esy5GRQAWDhQIv7SMNh3AvIUkDbteWsnmzi+p7ZJFZ3W5sDwxuGt2Pyx3GOodqgWS4zGl0EtEOoHNqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gsr9rvDN; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734426608; x=1765962608;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jlcwFC3JQLCv5lJgHAPOErV2JEPUxNk27bQ2DdZgO5o=;
  b=gsr9rvDN/MSf7gVESrAqMSv9Et9dIyXbpjkNnSycGbzARYFcff764JpF
   sg6goO2w3Yedj4VqQN09L/A5MoKvrijQuwh/VoUnqIyz+dHMtIAyd8DJS
   kZBM4PV7NZrxUNEmJesjT2OeVYUuwoJbcyh1yRWDPW4f/C7tfw6M3Y8f7
   DO+WXY0V0hr4c5dk67wYNDTlSfSaibCdmwWFPGeD86Pjb8VVvH082ukTU
   TcBuaitde15S3U0z2u1fHoe2wsTYZlecORUc9rPdWCRshyE+XxJXrkdMB
   09obUq480n9iC4x5ElH3Xmwys9tEc2anDwaGAUgHVngSmhoN40rhkPE/F
   Q==;
X-CSE-ConnectionGUID: F/R4D69nQWyX12lbE7+tGA==
X-CSE-MsgGUID: KjoCDxMOQ7Gg7OpJLoZ04w==
X-IronPort-AV: E=McAfee;i="6700,10204,11288"; a="34721568"
X-IronPort-AV: E=Sophos;i="6.12,241,1728975600"; 
   d="scan'208";a="34721568"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2024 01:10:07 -0800
X-CSE-ConnectionGUID: iVmXv1ZdRdSUNjKqNNC45Q==
X-CSE-MsgGUID: RODoHek7Q06bYci/IUDXfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="128452466"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.245.115])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2024 01:10:04 -0800
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Cc: linux-sound@vger.kernel.org,
	kai.vehmanen@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	pierre-louis.bossart@linux.dev,
	liam.r.girdwood@intel.com,
	stable@vger.kernel.org
Subject: [PATCH for v6.13-rc] ASoC: SOF: Intel: hda-dai: Do not release the link DMA on STOP
Date: Tue, 17 Dec 2024 11:10:19 +0200
Message-ID: <20241217091019.31798-1-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
 sound/soc/sof/intel/hda-dai.c | 25 +++++++++++++++++++------
 sound/soc/sof/intel/hda.h     |  2 --
 2 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/sound/soc/sof/intel/hda-dai.c b/sound/soc/sof/intel/hda-dai.c
index 1b218d77f292..da12aabc1bb8 100644
--- a/sound/soc/sof/intel/hda-dai.c
+++ b/sound/soc/sof/intel/hda-dai.c
@@ -103,8 +103,10 @@ hda_dai_get_ops(struct snd_pcm_substream *substream, struct snd_soc_dai *cpu_dai
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
@@ -128,6 +130,17 @@ int hda_link_dma_cleanup(struct snd_pcm_substream *substream, struct hdac_ext_st
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
 
@@ -211,7 +224,7 @@ static int __maybe_unused hda_dai_hw_free(struct snd_pcm_substream *substream,
 	if (!hext_stream)
 		return 0;
 
-	return hda_link_dma_cleanup(substream, hext_stream, cpu_dai);
+	return hda_link_dma_cleanup(substream, hext_stream, cpu_dai, true);
 }
 
 static int __maybe_unused hda_dai_hw_params_data(struct snd_pcm_substream *substream,
@@ -304,7 +317,8 @@ static int __maybe_unused hda_dai_trigger(struct snd_pcm_substream *substream, i
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_SUSPEND:
-		ret = hda_link_dma_cleanup(substream, hext_stream, dai);
+		ret = hda_link_dma_cleanup(substream, hext_stream, dai,
+					   cmd == SNDRV_PCM_TRIGGER_STOP ? false : true);
 		if (ret < 0) {
 			dev_err(sdev->dev, "%s: failed to clean up link DMA\n", __func__);
 			return ret;
@@ -672,8 +686,7 @@ static int hda_dai_suspend(struct hdac_bus *bus)
 			}
 
 			ret = hda_link_dma_cleanup(hext_stream->link_substream,
-						   hext_stream,
-						   cpu_dai);
+						   hext_stream, cpu_dai, true);
 			if (ret < 0)
 				return ret;
 		}
diff --git a/sound/soc/sof/intel/hda.h b/sound/soc/sof/intel/hda.h
index 22bd9c3c8216..ee4ccc1a5490 100644
--- a/sound/soc/sof/intel/hda.h
+++ b/sound/soc/sof/intel/hda.h
@@ -1038,8 +1038,6 @@ const struct hda_dai_widget_dma_ops *
 hda_select_dai_widget_ops(struct snd_sof_dev *sdev, struct snd_sof_widget *swidget);
 int hda_dai_config(struct snd_soc_dapm_widget *w, unsigned int flags,
 		   struct snd_sof_dai_config_data *data);
-int hda_link_dma_cleanup(struct snd_pcm_substream *substream, struct hdac_ext_stream *hext_stream,
-			 struct snd_soc_dai *cpu_dai);
 
 static inline struct snd_sof_dev *widget_to_sdev(struct snd_soc_dapm_widget *w)
 {
-- 
2.47.1


