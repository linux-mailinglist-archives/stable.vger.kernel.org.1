Return-Path: <stable+bounces-28557-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECFE78859A3
	for <lists+stable@lfdr.de>; Thu, 21 Mar 2024 14:08:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 199CB1C21115
	for <lists+stable@lfdr.de>; Thu, 21 Mar 2024 13:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BEDE84A37;
	Thu, 21 Mar 2024 13:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GWabU9m9"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E2883CAA;
	Thu, 21 Mar 2024 13:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711026515; cv=none; b=BBxbOdDpUpoFkV9c2YJJg6u5D3DiNFtNUBurakcjqtPjFTF6QkDhsqQQ+4xxqjJEaIOy6ag6fYyyDe0+tC+9Ut8Kj3HUO5pK/U+uLTvh5N+11QR5pzvy0EngfCLPECHLX/GUKgFgYQKi0F1vzzUaCdQGUYDnYAdklKK8Z3h2aAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711026515; c=relaxed/simple;
	bh=zAswIAhw088DZTVhXeA7+578dtBcFkjjc3KaMdQgXG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B36pT8Px+SIC9KvUNvVkbtj85ltTWYC0tcbKDU9EI+vHrqU4hOitJflpcvAlLzOiEiHFcUaeXjc5z0i/9syn/c66GQI6e8U7V6R1B7VTwwGD2kTkdTUFV+rfLw+CkX07dd/wznTCcPNoiuG5zt+4ZzAVjxao9cbepMyeu37uo64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GWabU9m9; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711026514; x=1742562514;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zAswIAhw088DZTVhXeA7+578dtBcFkjjc3KaMdQgXG0=;
  b=GWabU9m9yrJy30s9x+vfmDr0D1iT0GJa7rAT7zhTkLIxS86YD/hJQlIV
   5avWu2XFQu/fD1swVjH4+HhRyhwWGgkvbRpj0dt8B04o0bxrUbmMZn1HF
   Bsg+8hIQBuGgHR26BsLwEiXvs759HDlpOaaG38x0fS155D6fsZJJJv4gY
   LYu5QgVU2laT3FPru5XcnugCf7SJq0sPLYYoQQrVvO7t0goR/8450qrIq
   PJxWcMx+dG4IrHgjmzG76PBRseqgPeL1HRplQv+l8rvctO+BOfyAHJTcf
   DGd3OlXZi9EFE6kYH3rk7C8afPLIcw/bKcDNrVH0xWUBoFwjwV9T7OXba
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="6127261"
X-IronPort-AV: E=Sophos;i="6.07,142,1708416000"; 
   d="scan'208";a="6127261"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 06:08:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,142,1708416000"; 
   d="scan'208";a="51923316"
Received: from vyakovle-mobl2.ger.corp.intel.com (HELO pujfalus-desk.ger.corp.intel.com) ([10.252.54.189])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 06:08:25 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	tiwai@suse.de
Cc: linux-sound@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com,
	kai.vehmanen@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	stable@vger.kernel.org
Subject: [PATCH 15/17] ASoC: SOF: ipc4-pcm: Correct the delay calculation
Date: Thu, 21 Mar 2024 15:08:12 +0200
Message-ID: <20240321130814.4412-16-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240321130814.4412-1-peter.ujfalusi@linux.intel.com>
References: <20240321130814.4412-1-peter.ujfalusi@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch improves the delay calculation by relying on the
LLP (Linear Link Position) on the DAI side and the
LDP (Linear Data Pointer) on the host side. The LDP provides the same DMA
position as LPIB, but with a linear count instead of a position in the
ALSA ring buffer. The LDP values are provided in bytes and must be
converted to frames. The difference in units means that the host counter
will wrap earlier than the LLP. We need to wrap the LLP at the same
boundary as the host counter.

The ASoC framework relies on separate pointer and delay callback.
Measurement errors can be reduced by processing all the counter values in
the pointer callback. The delay value is stored, and will be reported to
higher levels in the delay callback.

For playback, the firmware provides a stream_start offset to handle
mixing/pause usages, where the DAI might have started earlier than the
PCM device. The delay calculation must be special-cased when the link
counter has not reached the start offset value, i.e. no valid audio has
left the DSP.

Cc: stable@vger.kernel.org # 6.8
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/ipc4-pcm.c | 159 +++++++++++++++++++++++++++++++--------
 1 file changed, 127 insertions(+), 32 deletions(-)

diff --git a/sound/soc/sof/ipc4-pcm.c b/sound/soc/sof/ipc4-pcm.c
index 905dbc4852b1..e915f9f87a6c 100644
--- a/sound/soc/sof/ipc4-pcm.c
+++ b/sound/soc/sof/ipc4-pcm.c
@@ -19,14 +19,22 @@
  * struct sof_ipc4_timestamp_info - IPC4 timestamp info
  * @host_copier: the host copier of the pcm stream
  * @dai_copier: the dai copier of the pcm stream
- * @stream_start_offset: reported by fw in memory window
+ * @stream_start_offset: reported by fw in memory window (converted to frames)
+ * @stream_end_offset: reported by fw in memory window (converted to frames)
  * @llp_offset: llp offset in memory window
+ * @boundary: wrap boundary should be used for the LLP frame counter
+ * @delay: Calculated and stored in pointer callback. The stored value is
+ *	   returned in the delay callback.
  */
 struct sof_ipc4_timestamp_info {
 	struct sof_ipc4_copier *host_copier;
 	struct sof_ipc4_copier *dai_copier;
 	u64 stream_start_offset;
+	u64 stream_end_offset;
 	u32 llp_offset;
+
+	u64 boundary;
+	snd_pcm_sframes_t delay;
 };
 
 static int sof_ipc4_set_multi_pipeline_state(struct snd_sof_dev *sdev, u32 state,
@@ -726,6 +734,10 @@ static int sof_ipc4_pcm_setup(struct snd_sof_dev *sdev, struct snd_sof_pcm *spcm
 	if (abi_version < SOF_IPC4_FW_REGS_ABI_VER)
 		support_info = false;
 
+	/* For delay reporting the get_host_byte_counter callback is needed */
+	if (!sof_ops(sdev) || !sof_ops(sdev)->get_host_byte_counter)
+		support_info = false;
+
 	for_each_pcm_streams(stream) {
 		pipeline_list = &spcm->stream[stream].pipeline_list;
 
@@ -858,7 +870,6 @@ static int sof_ipc4_get_stream_start_offset(struct snd_sof_dev *sdev,
 	struct sof_ipc4_copier *host_copier = time_info->host_copier;
 	struct sof_ipc4_copier *dai_copier = time_info->dai_copier;
 	struct sof_ipc4_pipeline_registers ppl_reg;
-	u64 stream_start_position;
 	u32 dai_sample_size;
 	u32 ch, node_index;
 	u32 offset;
@@ -875,38 +886,51 @@ static int sof_ipc4_get_stream_start_offset(struct snd_sof_dev *sdev,
 	if (ppl_reg.stream_start_offset == SOF_IPC4_INVALID_STREAM_POSITION)
 		return -EINVAL;
 
-	stream_start_position = ppl_reg.stream_start_offset;
 	ch = dai_copier->data.out_format.fmt_cfg;
 	ch = SOF_IPC4_AUDIO_FORMAT_CFG_CHANNELS_COUNT(ch);
 	dai_sample_size = (dai_copier->data.out_format.bit_depth >> 3) * ch;
-	/* convert offset to sample count */
-	do_div(stream_start_position, dai_sample_size);
-	time_info->stream_start_offset = stream_start_position;
+
+	/* convert offsets to frame count */
+	time_info->stream_start_offset = ppl_reg.stream_start_offset;
+	do_div(time_info->stream_start_offset, dai_sample_size);
+	time_info->stream_end_offset = ppl_reg.stream_end_offset;
+	do_div(time_info->stream_end_offset, dai_sample_size);
+
+	/*
+	 * Calculate the wrap boundary need to be used for delay calculation
+	 * The host counter is in bytes, it will wrap earlier than the frames
+	 * based link counter.
+	 */
+	time_info->boundary = div64_u64(~((u64)0),
+					frames_to_bytes(substream->runtime, 1));
+	/* Initialize the delay value to 0 (no delay) */
+	time_info->delay = 0;
 
 	return 0;
 }
 
-static snd_pcm_sframes_t sof_ipc4_pcm_delay(struct snd_soc_component *component,
-					    struct snd_pcm_substream *substream)
+static int sof_ipc4_pcm_pointer(struct snd_soc_component *component,
+				struct snd_pcm_substream *substream,
+				snd_pcm_uframes_t *pointer)
 {
 	struct snd_sof_dev *sdev = snd_soc_component_get_drvdata(component);
 	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
 	struct sof_ipc4_timestamp_info *time_info;
 	struct sof_ipc4_llp_reading_slot llp;
-	snd_pcm_uframes_t head_ptr, tail_ptr;
+	snd_pcm_uframes_t head_cnt, tail_cnt;
 	struct snd_sof_pcm_stream *stream;
+	u64 dai_cnt, host_cnt, host_ptr;
 	struct snd_sof_pcm *spcm;
-	u64 tmp_ptr;
 	int ret;
 
 	spcm = snd_sof_find_spcm_dai(component, rtd);
 	if (!spcm)
-		return 0;
+		return -EOPNOTSUPP;
 
 	stream = &spcm->stream[substream->stream];
 	time_info = stream->private;
 	if (!time_info)
-		return 0;
+		return -EOPNOTSUPP;
 
 	/*
 	 * stream_start_offset is updated to memory window by FW based on
@@ -916,46 +940,116 @@ static snd_pcm_sframes_t sof_ipc4_pcm_delay(struct snd_soc_component *component,
 	if (time_info->stream_start_offset == SOF_IPC4_INVALID_STREAM_POSITION) {
 		ret = sof_ipc4_get_stream_start_offset(sdev, substream, stream, time_info);
 		if (ret < 0)
-			return 0;
+			return -EOPNOTSUPP;
 	}
 
+	/* For delay calculation we need the host counter */
+	host_cnt = snd_sof_pcm_get_host_byte_counter(sdev, component, substream);
+	host_ptr = host_cnt;
+
+	/* convert the host_cnt to frames */
+	host_cnt = div64_u64(host_cnt, frames_to_bytes(substream->runtime, 1));
+
 	/*
 	 * If the LLP counter is not reported by firmware in the SRAM window
-	 * then read the dai (link) position via host accessible means if
+	 * then read the dai (link) counter via host accessible means if
 	 * available.
 	 */
 	if (!time_info->llp_offset) {
-		tmp_ptr = snd_sof_pcm_get_dai_frame_counter(sdev, component, substream);
-		if (!tmp_ptr)
-			return 0;
+		dai_cnt = snd_sof_pcm_get_dai_frame_counter(sdev, component, substream);
+		if (!dai_cnt)
+			return -EOPNOTSUPP;
 	} else {
 		sof_mailbox_read(sdev, time_info->llp_offset, &llp, sizeof(llp));
-		tmp_ptr = ((u64)llp.reading.llp_u << 32) | llp.reading.llp_l;
+		dai_cnt = ((u64)llp.reading.llp_u << 32) | llp.reading.llp_l;
 	}
+	dai_cnt += time_info->stream_end_offset;
 
-	/* In two cases dai dma position is not accurate
+	/* In two cases dai dma counter is not accurate
 	 * (1) dai pipeline is started before host pipeline
-	 * (2) multiple streams mixed into one. Each stream has the same dai dma position
+	 * (2) multiple streams mixed into one. Each stream has the same dai dma
+	 *     counter
+	 *
+	 * Firmware calculates correct stream_start_offset for all cases
+	 * including above two.
+	 * Driver subtracts stream_start_offset from dai dma counter to get
+	 * accurate one
+	 */
+
+	/*
+	 * On stream start the dai counter might not yet have reached the
+	 * stream_start_offset value which means that no frames have left the
+	 * DSP yet from the audio stream (on playback, capture streams have
+	 * offset of 0 as we start capturing right away).
+	 * In this case we need to adjust the distance between the counters by
+	 * increasing the host counter by (offset - dai_counter).
+	 * Otherwise the dai_counter needs to be adjusted to reflect the number
+	 * of valid frames passed on the DAI side.
 	 *
-	 * Firmware calculates correct stream_start_offset for all cases including above two.
-	 * Driver subtracts stream_start_offset from dai dma position to get accurate one
+	 * The delay is the difference between the counters on the two
+	 * sides of the DSP.
 	 */
-	tmp_ptr -= time_info->stream_start_offset;
+	if (dai_cnt < time_info->stream_start_offset) {
+		host_cnt += time_info->stream_start_offset - dai_cnt;
+		dai_cnt = 0;
+	} else {
+		dai_cnt -= time_info->stream_start_offset;
+	}
+
+	/* Wrap the dai counter at the boundary where the host counter wraps */
+	div64_u64_rem(dai_cnt, time_info->boundary, &dai_cnt);
 
-	/* Calculate the delay taking into account that both pointer can wrap */
-	div64_u64_rem(tmp_ptr, substream->runtime->boundary, &tmp_ptr);
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		head_ptr = substream->runtime->status->hw_ptr;
-		tail_ptr = tmp_ptr;
+		head_cnt = host_cnt;
+		tail_cnt = dai_cnt;
 	} else {
-		head_ptr = tmp_ptr;
-		tail_ptr = substream->runtime->status->hw_ptr;
+		head_cnt = dai_cnt;
+		tail_cnt = host_cnt;
+	}
+
+	if (head_cnt < tail_cnt) {
+		time_info->delay = time_info->boundary - tail_cnt + head_cnt;
+		goto out;
 	}
 
-	if (head_ptr < tail_ptr)
-		return substream->runtime->boundary - tail_ptr + head_ptr;
+	time_info->delay =  head_cnt - tail_cnt;
+
+out:
+	/*
+	 * Convert the host byte counter to PCM pointer which wraps in buffer
+	 * and it is in frames
+	 */
+	div64_u64_rem(host_ptr, snd_pcm_lib_buffer_bytes(substream), &host_ptr);
+	*pointer = bytes_to_frames(substream->runtime, host_ptr);
+
+	return 0;
+}
+
+static snd_pcm_sframes_t sof_ipc4_pcm_delay(struct snd_soc_component *component,
+					    struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
+	struct sof_ipc4_timestamp_info *time_info;
+	struct snd_sof_pcm_stream *stream;
+	struct snd_sof_pcm *spcm;
+
+	spcm = snd_sof_find_spcm_dai(component, rtd);
+	if (!spcm)
+		return 0;
+
+	stream = &spcm->stream[substream->stream];
+	time_info = stream->private;
+	/*
+	 * Report the stored delay value calculated in the pointer callback.
+	 * In the unlikely event that the calculation was skipped/aborted, the
+	 * default 0 delay returned.
+	 */
+	if (time_info)
+		return time_info->delay;
+
+	/* No delay information available, report 0 as delay */
+	return 0;
 
-	return head_ptr - tail_ptr;
 }
 
 const struct sof_ipc_pcm_ops ipc4_pcm_ops = {
@@ -965,6 +1059,7 @@ const struct sof_ipc_pcm_ops ipc4_pcm_ops = {
 	.dai_link_fixup = sof_ipc4_pcm_dai_link_fixup,
 	.pcm_setup = sof_ipc4_pcm_setup,
 	.pcm_free = sof_ipc4_pcm_free,
+	.pointer = sof_ipc4_pcm_pointer,
 	.delay = sof_ipc4_pcm_delay,
 	.ipc_first_on_start = true,
 	.platform_stop_during_hw_free = true,
-- 
2.44.0


