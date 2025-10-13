Return-Path: <stable+bounces-185508-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E889BD6070
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 22:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BCD4C35041B
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 20:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FBAE2DCBEC;
	Mon, 13 Oct 2025 20:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="unA1kFyR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA612D46C6
	for <stable@vger.kernel.org>; Mon, 13 Oct 2025 20:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760385923; cv=none; b=FnVIsDgFDWT6De48TO9YSGHH400nwhbrQ+1yqtrx9qc6eyF9xdah2Qtz7J179itnIqFYPz30reKmgHM74TjwNkxfnlk3xeaHALRCw2U50u6O8N7yA/roLoT/L7SiQyoIzEc235PQLe/2lr4OJc2b/g7unXOvrRMvE5M55OfA480=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760385923; c=relaxed/simple;
	bh=iaAd4nE9ZnETQSBVMunq3lCud+BTEOd94IySW1iQVuI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dUoKULIzszgVz+wkx2ANOQbbeesf9RXh+vM9vPHylHhCH0TeGQFLplhXGrXV2Leoa3YgklDmN60YklhVabZzjVHNze1oGOQ1y11fcygw1IUlGo2YI9vsIxQGRuWdkzRxi2yW327oaWpfGl2ZYivVyV6i0w9qENb1hJWPEu8khA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=unA1kFyR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C86A1C4CEF8;
	Mon, 13 Oct 2025 20:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760385922;
	bh=iaAd4nE9ZnETQSBVMunq3lCud+BTEOd94IySW1iQVuI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=unA1kFyRWjWghodU/Qwliv/5fQQRYSdeQBo6bXSROPzmWO4PPjxtS26Zmw1py3AyB
	 DLKVzDD1pu+6kHldkCFLot2/QbMhse/g0/WyKJT3xPTTfSu35kh77HmgebVDdGzX+Y
	 j4Cun8GBEsdrc/7wsDIoE3V3mnKaKmD0bvr1FYPUX8ojKTQIrWCpxCO4FYsYwNT8Ts
	 szDMNkriAscDp/DEpsveKEnXaisyR2zfEoT0g2eLcIGrUw+wGdoWh/FChv0cF9jji3
	 W28Jj4WAePizoXeRo0w132Y2q+TqqbIrZZ6YNsrZzm6GmDsliBJgPlLExKDEX6PvXE
	 zWFaGzxKWyQwA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	=?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] ASoC: SOF: ipc4-pcm: fix delay calculation when DSP resamples
Date: Mon, 13 Oct 2025 16:05:19 -0400
Message-ID: <20251013200519.3580966-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013200519.3580966-1-sashal@kernel.org>
References: <2025101352-joylessly-yoyo-b1e8@gregkh>
 <20251013200519.3580966-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kai Vehmanen <kai.vehmanen@linux.intel.com>

[ Upstream commit bcd1383516bb5a6f72b2d1e7f7ad42c4a14837d1 ]

When the sampling rates going in (host) and out (dai) from the DSP
are different, the IPC4 delay reporting does not work correctly.
Add support for this case by scaling the all raw position values to
a common timebase before calculating real-time delay for the PCM.

Cc: stable@vger.kernel.org
Fixes: 0ea06680dfcb ("ASoC: SOF: ipc4-pcm: Correct the delay calculation")
Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Link: https://patch.msgid.link/20251002074719.2084-2-peter.ujfalusi@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/ipc4-pcm.c | 83 ++++++++++++++++++++++++++++++----------
 1 file changed, 62 insertions(+), 21 deletions(-)

diff --git a/sound/soc/sof/ipc4-pcm.c b/sound/soc/sof/ipc4-pcm.c
index 2a08aa80e1de5..a08f8a71fd097 100644
--- a/sound/soc/sof/ipc4-pcm.c
+++ b/sound/soc/sof/ipc4-pcm.c
@@ -19,12 +19,14 @@
  * struct sof_ipc4_timestamp_info - IPC4 timestamp info
  * @host_copier: the host copier of the pcm stream
  * @dai_copier: the dai copier of the pcm stream
- * @stream_start_offset: reported by fw in memory window (converted to frames)
- * @stream_end_offset: reported by fw in memory window (converted to frames)
+ * @stream_start_offset: reported by fw in memory window (converted to
+ *                       frames at host_copier sampling rate)
+ * @stream_end_offset: reported by fw in memory window (converted to
+ *                     frames at host_copier sampling rate)
  * @llp_offset: llp offset in memory window
- * @boundary: wrap boundary should be used for the LLP frame counter
  * @delay: Calculated and stored in pointer callback. The stored value is
- *	   returned in the delay callback.
+ *         returned in the delay callback. Expressed in frames at host copier
+ *         sampling rate.
  */
 struct sof_ipc4_timestamp_info {
 	struct sof_ipc4_copier *host_copier;
@@ -33,7 +35,6 @@ struct sof_ipc4_timestamp_info {
 	u64 stream_end_offset;
 	u32 llp_offset;
 
-	u64 boundary;
 	snd_pcm_sframes_t delay;
 };
 
@@ -48,6 +49,16 @@ struct sof_ipc4_pcm_stream_priv {
 	bool chain_dma_allocated;
 };
 
+/*
+ * Modulus to use to compare host and link position counters. The sampling
+ * rates may be different, so the raw hardware counters will wrap
+ * around at different times. To calculate differences, use
+ * DELAY_BOUNDARY as a common modulus. This value must be smaller than
+ * the wrap-around point of any hardware counter, and larger than any
+ * valid delay measurement.
+ */
+#define DELAY_BOUNDARY		U32_MAX
+
 static inline struct sof_ipc4_timestamp_info *
 sof_ipc4_sps_to_time_info(struct snd_sof_pcm_stream *sps)
 {
@@ -933,6 +944,35 @@ static int sof_ipc4_pcm_hw_params(struct snd_soc_component *component,
 	return 0;
 }
 
+static u64 sof_ipc4_frames_dai_to_host(struct sof_ipc4_timestamp_info *time_info, u64 value)
+{
+	u64 dai_rate, host_rate;
+
+	if (!time_info->dai_copier || !time_info->host_copier)
+		return value;
+
+	/*
+	 * copiers do not change sampling rate, so we can use the
+	 * out_format independently of stream direction
+	 */
+	dai_rate = time_info->dai_copier->data.out_format.sampling_frequency;
+	host_rate = time_info->host_copier->data.out_format.sampling_frequency;
+
+	if (!dai_rate || !host_rate || dai_rate == host_rate)
+		return value;
+
+	/* take care not to overflow u64, rates can be up to 768000 */
+	if (value > U32_MAX) {
+		value = div64_u64(value, dai_rate);
+		value *= host_rate;
+	} else {
+		value *= host_rate;
+		value = div64_u64(value, dai_rate);
+	}
+
+	return value;
+}
+
 static int sof_ipc4_get_stream_start_offset(struct snd_sof_dev *sdev,
 					    struct snd_pcm_substream *substream,
 					    struct snd_sof_pcm_stream *sps,
@@ -983,14 +1023,13 @@ static int sof_ipc4_get_stream_start_offset(struct snd_sof_dev *sdev,
 	time_info->stream_end_offset = ppl_reg.stream_end_offset;
 	do_div(time_info->stream_end_offset, dai_sample_size);
 
+	/* convert to host frame time */
+	time_info->stream_start_offset =
+		sof_ipc4_frames_dai_to_host(time_info, time_info->stream_start_offset);
+	time_info->stream_end_offset =
+		sof_ipc4_frames_dai_to_host(time_info, time_info->stream_end_offset);
+
 out:
-	/*
-	 * Calculate the wrap boundary need to be used for delay calculation
-	 * The host counter is in bytes, it will wrap earlier than the frames
-	 * based link counter.
-	 */
-	time_info->boundary = div64_u64(~((u64)0),
-					frames_to_bytes(substream->runtime, 1));
 	/* Initialize the delay value to 0 (no delay) */
 	time_info->delay = 0;
 
@@ -1033,6 +1072,8 @@ static int sof_ipc4_pcm_pointer(struct snd_soc_component *component,
 
 	/* For delay calculation we need the host counter */
 	host_cnt = snd_sof_pcm_get_host_byte_counter(sdev, component, substream);
+
+	/* Store the original value to host_ptr */
 	host_ptr = host_cnt;
 
 	/* convert the host_cnt to frames */
@@ -1051,6 +1092,8 @@ static int sof_ipc4_pcm_pointer(struct snd_soc_component *component,
 		sof_mailbox_read(sdev, time_info->llp_offset, &llp, sizeof(llp));
 		dai_cnt = ((u64)llp.reading.llp_u << 32) | llp.reading.llp_l;
 	}
+
+	dai_cnt = sof_ipc4_frames_dai_to_host(time_info, dai_cnt);
 	dai_cnt += time_info->stream_end_offset;
 
 	/* In two cases dai dma counter is not accurate
@@ -1084,8 +1127,9 @@ static int sof_ipc4_pcm_pointer(struct snd_soc_component *component,
 		dai_cnt -= time_info->stream_start_offset;
 	}
 
-	/* Wrap the dai counter at the boundary where the host counter wraps */
-	div64_u64_rem(dai_cnt, time_info->boundary, &dai_cnt);
+	/* Convert to a common base before comparisons */
+	dai_cnt &= DELAY_BOUNDARY;
+	host_cnt &= DELAY_BOUNDARY;
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		head_cnt = host_cnt;
@@ -1095,14 +1139,11 @@ static int sof_ipc4_pcm_pointer(struct snd_soc_component *component,
 		tail_cnt = host_cnt;
 	}
 
-	if (head_cnt < tail_cnt) {
-		time_info->delay = time_info->boundary - tail_cnt + head_cnt;
-		goto out;
-	}
-
-	time_info->delay =  head_cnt - tail_cnt;
+	if (unlikely(head_cnt < tail_cnt))
+		time_info->delay = DELAY_BOUNDARY - tail_cnt + head_cnt;
+	else
+		time_info->delay = head_cnt - tail_cnt;
 
-out:
 	/*
 	 * Convert the host byte counter to PCM pointer which wraps in buffer
 	 * and it is in frames
-- 
2.51.0


