Return-Path: <stable+bounces-183018-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C28FBB2BA7
	for <lists+stable@lfdr.de>; Thu, 02 Oct 2025 09:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9F3B19C3696
	for <lists+stable@lfdr.de>; Thu,  2 Oct 2025 07:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3A02C159A;
	Thu,  2 Oct 2025 07:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="USv0++2+"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6572BE651;
	Thu,  2 Oct 2025 07:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759391191; cv=none; b=s0vtDEr2jHxnN4UqFWjZuAeEXeUE0T46Qt62dDqPjViHnmIwm2eCuBRda5Gr+hOoX5w5C/edVemGRWRP+D3MxGj1nbcF1oALbJZkbOQWT0guLpxtf3RvQAio304yPDi97B3ztVsbOjQ6hJL0+zV0GIn20DgRF3r/Czb9wQsQxnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759391191; c=relaxed/simple;
	bh=SFprVhCbZawAdBURzmQovlNRs1NUVUe1/t7xFEnTRVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NtA7ETt+tZA9xYZ2LCRrefChouVrWN1Q3kDFQnbgT3QVkfxq4MK4jRt98fhmPk+Gl5DlP8h3y3xAs7TGOdzbo74ZR/F/n7yEpUQbMQtlBfL5uPy4pH/uxlhYburdIxJ7+gNWSRWwG6SCGpIc6WYe5IXWbtC/2MnIiltOZ4HMl24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=USv0++2+; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759391189; x=1790927189;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SFprVhCbZawAdBURzmQovlNRs1NUVUe1/t7xFEnTRVw=;
  b=USv0++2+5Seqf1cYmoKjnRLqAI4jAfW29J/svjnEQeS9B8+Nrf+vrZXY
   FGaUL5N2BQkEA7nsdFJbFdpet9XleoM2QPzlfCKD7nm2yaSAkTKBLqMs1
   3X9qskC5qfmunvD/CnbaIWv9loNDZFs99DpB0w4HrKSF2lQYLC3xNE8IV
   hIlY+SeS0wr/vlUqjevM7DZ6ThK0zS7bsaoXfULkZ2CLlJChXwi1m2yhz
   7kEVp8rbsfPGLQUs6s8hA3nwUUm6ITxdd0P3Ys0dNskHepjFmhfvzXaCB
   QA1aMZxlG7Nn9GtqkDqHg1m9KOlornrs0+6TO+lGNAHuFK3PY2d4fe42t
   A==;
X-CSE-ConnectionGUID: /S7TB0KgQ8iQdhm9dawqmQ==
X-CSE-MsgGUID: tjze1MqRSJaCZ//ubop5Vw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="61630973"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="61630973"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2025 00:46:29 -0700
X-CSE-ConnectionGUID: oOv+ks77RLOuQkT6sn1OaQ==
X-CSE-MsgGUID: s/GTmk32TfeeBeum+L3JVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,308,1751266800"; 
   d="scan'208";a="179760345"
Received: from slindbla-desk.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.8])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2025 00:46:26 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Cc: linux-sound@vger.kernel.org,
	kai.vehmanen@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	pierre-louis.bossart@linux.dev,
	stable@vger.kernel.org
Subject: [PATCH 1/5] ASoC: SOF: ipc4-pcm: fix delay calculation when DSP resamples
Date: Thu,  2 Oct 2025 10:47:15 +0300
Message-ID: <20251002074719.2084-2-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002074719.2084-1-peter.ujfalusi@linux.intel.com>
References: <20251002074719.2084-1-peter.ujfalusi@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kai Vehmanen <kai.vehmanen@linux.intel.com>

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
---
 sound/soc/sof/ipc4-pcm.c | 83 ++++++++++++++++++++++++++++++----------
 1 file changed, 62 insertions(+), 21 deletions(-)

diff --git a/sound/soc/sof/ipc4-pcm.c b/sound/soc/sof/ipc4-pcm.c
index 24f82a6f3610..075388d5cb3c 100644
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
@@ -1049,6 +1060,35 @@ static int sof_ipc4_pcm_hw_params(struct snd_soc_component *component,
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
@@ -1099,14 +1139,13 @@ static int sof_ipc4_get_stream_start_offset(struct snd_sof_dev *sdev,
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
 
@@ -1149,6 +1188,8 @@ static int sof_ipc4_pcm_pointer(struct snd_soc_component *component,
 
 	/* For delay calculation we need the host counter */
 	host_cnt = snd_sof_pcm_get_host_byte_counter(sdev, component, substream);
+
+	/* Store the original value to host_ptr */
 	host_ptr = host_cnt;
 
 	/* convert the host_cnt to frames */
@@ -1167,6 +1208,8 @@ static int sof_ipc4_pcm_pointer(struct snd_soc_component *component,
 		sof_mailbox_read(sdev, time_info->llp_offset, &llp, sizeof(llp));
 		dai_cnt = ((u64)llp.reading.llp_u << 32) | llp.reading.llp_l;
 	}
+
+	dai_cnt = sof_ipc4_frames_dai_to_host(time_info, dai_cnt);
 	dai_cnt += time_info->stream_end_offset;
 
 	/* In two cases dai dma counter is not accurate
@@ -1200,8 +1243,9 @@ static int sof_ipc4_pcm_pointer(struct snd_soc_component *component,
 		dai_cnt -= time_info->stream_start_offset;
 	}
 
-	/* Wrap the dai counter at the boundary where the host counter wraps */
-	div64_u64_rem(dai_cnt, time_info->boundary, &dai_cnt);
+	/* Convert to a common base before comparisons */
+	dai_cnt &= DELAY_BOUNDARY;
+	host_cnt &= DELAY_BOUNDARY;
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		head_cnt = host_cnt;
@@ -1211,14 +1255,11 @@ static int sof_ipc4_pcm_pointer(struct snd_soc_component *component,
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


