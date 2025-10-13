Return-Path: <stable+bounces-185507-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D01BD606F
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 22:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 90A0E4E87F6
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 20:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541722DC79B;
	Mon, 13 Oct 2025 20:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gZhwOaYi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D8F2D46C6
	for <stable@vger.kernel.org>; Mon, 13 Oct 2025 20:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760385922; cv=none; b=ZyMIIpmh+1HPkq2zQBOh4dKMy9nlNppPnz8MF2BY48LbsOCBxxGdcccO5B36yNh6cQgDwip2lXXrGQFs0dZf4RY0v4aHmK/gz2Ta5y+sHKo7uEHVPKJBbnaTIpvcJFbbWpXj+Kg2IQLzLAAyVmZr9mveVGDnm0OnRwfHfQ1PxpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760385922; c=relaxed/simple;
	bh=csHUYEiYPtSXYttk9Q2BK3OtdjP+BxHfVOIaQ3asOOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lDZuCNbWMgmOgQIyITfsP9ZCceQAI+GQsOOiOnyN+vH3hkd7nM/IMyqqGW+1I0Y7iXwHmUDl1tjqK893fe6c1iEMjjmM9LXaBYfJhH3+mbOCpTjAHX4atdVpV7d4+KCi00Yaf2uBxKoFYivjM5UedCU0DcMQh7p2LtPxc38kjD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gZhwOaYi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABB43C4CEE7;
	Mon, 13 Oct 2025 20:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760385921;
	bh=csHUYEiYPtSXYttk9Q2BK3OtdjP+BxHfVOIaQ3asOOw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gZhwOaYiLDj0l4CU+VL9gCjaiWKRUHSYedjTvre9cJF0RtfGSSJBqdRR2Zg2kiKh2
	 kIg1GRUCXfpcDfr3JStG9LT4Y0OOS2WM/xHZw/caDznRdRxh4dOjHee9rxIQvvatOn
	 wSmQ6QFEYS2GVmyKCMDaUc9VieIPmzIrkDCY1xUTmltG9LL1e3joLPXVIw0YIr4UD5
	 a1ufXIImf5Bb6uuUGcZuMwEzddAQq5jDOIUrHPeRaXLGJEggis2Ja5pG+z9tt2zOdC
	 cGmWow5vDl5WcyD1KrE/dhUY1iKIT8ZX/Mv4gesi+hJhUtrJQ5LCotXSTE8bsnAOHq
	 MAaGaIRCKVeSQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Liam Girdwood <liam.r.girdwood@intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] ASoC: SOF: ipc4-pcm: Enable delay reporting for ChainDMA streams
Date: Mon, 13 Oct 2025 16:05:18 -0400
Message-ID: <20251013200519.3580966-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101352-joylessly-yoyo-b1e8@gregkh>
References: <2025101352-joylessly-yoyo-b1e8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>

[ Upstream commit a1d203d390e04798ccc1c3c06019cd4411885d6d ]

All streams (currently) which is configured to use ChainDMA can only work
on Link/host DMA pairs where the link side position can be access via host
registers (like HDA on CAVS 2.5 platforms).

Since the firmware does not provide time_info for ChainDMA, unlike for HDA
stream, the kernel should calculate the start and end offsets that is
needed for the delay calculation.

With this small change we can report accurate delays when the stream is
configured to use ChainDMA.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Liam Girdwood <liam.r.girdwood@intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Link: https://patch.msgid.link/20250619102848.12389-1-peter.ujfalusi@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: bcd1383516bb ("ASoC: SOF: ipc4-pcm: fix delay calculation when DSP resamples")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/ipc4-pcm.c      | 49 ++++++++++++++++++++++++++++++++---
 sound/soc/sof/ipc4-topology.c |  6 ++---
 sound/soc/sof/ipc4-topology.h |  1 +
 3 files changed, 49 insertions(+), 7 deletions(-)

diff --git a/sound/soc/sof/ipc4-pcm.c b/sound/soc/sof/ipc4-pcm.c
index 9db2cdb321282..2a08aa80e1de5 100644
--- a/sound/soc/sof/ipc4-pcm.c
+++ b/sound/soc/sof/ipc4-pcm.c
@@ -409,9 +409,33 @@ static int sof_ipc4_trigger_pipelines(struct snd_soc_component *component,
 	 * If use_chain_dma attribute is set we proceed to chained DMA
 	 * trigger function that handles the rest for the substream.
 	 */
-	if (pipeline->use_chain_dma)
-		return sof_ipc4_chain_dma_trigger(sdev, spcm, substream->stream,
-						  pipeline_list, state, cmd);
+	if (pipeline->use_chain_dma) {
+		struct sof_ipc4_timestamp_info *time_info;
+
+		time_info = sof_ipc4_sps_to_time_info(&spcm->stream[substream->stream]);
+
+		ret = sof_ipc4_chain_dma_trigger(sdev, spcm, substream->stream,
+						 pipeline_list, state, cmd);
+		if (ret || !time_info)
+			return ret;
+
+		if (state == SOF_IPC4_PIPE_PAUSED) {
+			/*
+			 * Record the DAI position for delay reporting
+			 * To handle multiple pause/resume/xrun we need to add
+			 * the positions to simulate how the firmware behaves
+			 */
+			u64 pos = snd_sof_pcm_get_dai_frame_counter(sdev, component,
+								    substream);
+
+			time_info->stream_end_offset += pos;
+		} else if (state == SOF_IPC4_PIPE_RESET) {
+			/* Reset the end offset as the stream is stopped */
+			time_info->stream_end_offset = 0;
+		}
+
+		return 0;
+	}
 
 	/* allocate memory for the pipeline data */
 	trigger_list = kzalloc(struct_size(trigger_list, pipeline_instance_ids,
@@ -924,8 +948,24 @@ static int sof_ipc4_get_stream_start_offset(struct snd_sof_dev *sdev,
 	if (!host_copier || !dai_copier)
 		return -EINVAL;
 
-	if (host_copier->data.gtw_cfg.node_id == SOF_IPC4_INVALID_NODE_ID)
+	if (host_copier->data.gtw_cfg.node_id == SOF_IPC4_INVALID_NODE_ID) {
 		return -EINVAL;
+	} else if (host_copier->data.gtw_cfg.node_id == SOF_IPC4_CHAIN_DMA_NODE_ID) {
+		/*
+		 * While the firmware does not supports time_info reporting for
+		 * streams using ChainDMA, it is granted that ChainDMA can only
+		 * be used on Host+Link pairs where the link position is
+		 * accessible from the host side.
+		 *
+		 * Enable delay calculation in case of ChainDMA via host
+		 * accessible registers.
+		 *
+		 * The ChainDMA uses 2x 1ms ping-pong buffer, dai side starts
+		 * when 1ms data is available
+		 */
+		time_info->stream_start_offset = substream->runtime->rate / MSEC_PER_SEC;
+		goto out;
+	}
 
 	node_index = SOF_IPC4_NODE_INDEX(host_copier->data.gtw_cfg.node_id);
 	offset = offsetof(struct sof_ipc4_fw_registers, pipeline_regs) + node_index * sizeof(ppl_reg);
@@ -943,6 +983,7 @@ static int sof_ipc4_get_stream_start_offset(struct snd_sof_dev *sdev,
 	time_info->stream_end_offset = ppl_reg.stream_end_offset;
 	do_div(time_info->stream_end_offset, dai_sample_size);
 
+out:
 	/*
 	 * Calculate the wrap boundary need to be used for delay calculation
 	 * The host counter is in bytes, it will wrap earlier than the frames
diff --git a/sound/soc/sof/ipc4-topology.c b/sound/soc/sof/ipc4-topology.c
index f82db7f2a6b7e..91d324f973a18 100644
--- a/sound/soc/sof/ipc4-topology.c
+++ b/sound/soc/sof/ipc4-topology.c
@@ -1777,10 +1777,10 @@ sof_ipc4_prepare_copier_module(struct snd_sof_widget *swidget,
 			pipeline->msg.extension |= SOF_IPC4_GLB_EXT_CHAIN_DMA_FIFO_SIZE(fifo_size);
 
 			/*
-			 * Chain DMA does not support stream timestamping, set node_id to invalid
-			 * to skip the code in sof_ipc4_get_stream_start_offset().
+			 * Chain DMA does not support stream timestamping, but it
+			 * can use the host side registers for delay calculation.
 			 */
-			copier_data->gtw_cfg.node_id = SOF_IPC4_INVALID_NODE_ID;
+			copier_data->gtw_cfg.node_id = SOF_IPC4_CHAIN_DMA_NODE_ID;
 
 			return 0;
 		}
diff --git a/sound/soc/sof/ipc4-topology.h b/sound/soc/sof/ipc4-topology.h
index f4dc499c0ffe5..ea1f8dd447339 100644
--- a/sound/soc/sof/ipc4-topology.h
+++ b/sound/soc/sof/ipc4-topology.h
@@ -58,6 +58,7 @@
 
 #define SOF_IPC4_DMA_DEVICE_MAX_COUNT 16
 
+#define SOF_IPC4_CHAIN_DMA_NODE_ID	0x7fffffff
 #define SOF_IPC4_INVALID_NODE_ID	0xffffffff
 
 /* FW requires minimum 2ms DMA buffer size */
-- 
2.51.0


