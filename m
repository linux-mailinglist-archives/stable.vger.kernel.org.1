Return-Path: <stable+bounces-185757-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD7FBDCF7D
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 09:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56A4618969BE
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 07:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5624D313E3D;
	Wed, 15 Oct 2025 07:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e+Aeqoqh"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D16316919
	for <stable@vger.kernel.org>; Wed, 15 Oct 2025 07:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760512732; cv=none; b=Y5dee7JA6HWyw+Hvv4uQPE8j0sA8yvTqIwpiM9aqp1WoPl10X9BYojjQw5f4UEvQS5qt5WPMgN07NmLTJnA3e4b1j6fkYoOx1nDzyN+CnC2RY7V7xnfkU7mCjUJg92DfRundEASrOIMruVu/TbEZ041gDljYJ7HRMcejLOnBBUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760512732; c=relaxed/simple;
	bh=sRXN3yqoDj2dxOxXn5E60u7SJEHjyJHjjbm/P5ZuIlk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bP00NKO+dTdVGpUwcaHDNeZ41s/GBX9oVCYyeS+21T7zSx5Sdc4UpqNQp/LwYROg5VLmTnmMxN69dKLgZbo2Cq/qZe9ceanvmpeZKp6e1KHyZQ0JG79bYEV1v+FRx29PTViSha+OrZ43Ivd4lkCyMcNYm1ugYOCLvYpzLEBMao4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e+Aeqoqh; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760512730; x=1792048730;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=sRXN3yqoDj2dxOxXn5E60u7SJEHjyJHjjbm/P5ZuIlk=;
  b=e+AeqoqhtyimuDrrpEw/0nfik/GnpZDTx1yUgVGqaHxVahoK4mD5InnV
   +eY8cHe5ySnclG3H0DiVjQ4wN0i2lqSGonLC7YgV+qvo/bmazNP/ZmW7X
   S05S5LmqWid+RmXSeehIfgtfRDsiBOANgQ9dtcD3A+Cmq3oOMqCJgLilr
   aLgaKsDOQgDV1gx8MlwvWgeJIqm6Z/5bHYlDnd+vOgfX5ltjscUeWc4zB
   HH7J1M/6pv5EXG5TOPpZKBiqEBOqRogZcnoI6E7AVbVeabK17Zg2SpQWq
   4ySWxiVvCH/0plNIZN29gj7i00HjGk9PvT5Xok+8T1OSxaZu/E+vqqR19
   Q==;
X-CSE-ConnectionGUID: 4e8dUzbrRTSDOwAj78sGkQ==
X-CSE-MsgGUID: Zq5oI9B/R4GsUplxk4pqGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="74129932"
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; 
   d="scan'208";a="74129932"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 00:18:50 -0700
X-CSE-ConnectionGUID: hW3rpr/YQy66bq36RJmKmA==
X-CSE-MsgGUID: L1aI/SE9TUW10Q8cV2Xmsw==
X-ExtLoop1: 1
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.79])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 00:18:48 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: stable@vger.kernel.org
Subject: [PATCH 6.12.y] ASoC: SOF: ipc4-pcm: fix delay calculation when DSP resamples
Date: Wed, 15 Oct 2025 10:18:49 +0300
Message-ID: <20251015071849.27346-1-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101352-joylessly-yoyo-b1e8@gregkh>
References: <2025101352-joylessly-yoyo-b1e8@gregkh>
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
Link: https://patch.msgid.link/20251002074719.2084-2-peter.ujfalusi@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
(cherry picked from commit bcd1383516bb5a6f72b2d1e7f7ad42c4a14837d1)
---
 sound/soc/sof/ipc4-pcm.c | 83 ++++++++++++++++++++++++++++++----------
 1 file changed, 62 insertions(+), 21 deletions(-)

diff --git a/sound/soc/sof/ipc4-pcm.c b/sound/soc/sof/ipc4-pcm.c
index 9db2cdb32128..a58ab595507b 100644
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
@@ -909,6 +920,35 @@ static int sof_ipc4_pcm_hw_params(struct snd_soc_component *component,
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
@@ -943,13 +983,12 @@ static int sof_ipc4_get_stream_start_offset(struct snd_sof_dev *sdev,
 	time_info->stream_end_offset = ppl_reg.stream_end_offset;
 	do_div(time_info->stream_end_offset, dai_sample_size);
 
-	/*
-	 * Calculate the wrap boundary need to be used for delay calculation
-	 * The host counter is in bytes, it will wrap earlier than the frames
-	 * based link counter.
-	 */
-	time_info->boundary = div64_u64(~((u64)0),
-					frames_to_bytes(substream->runtime, 1));
+	/* convert to host frame time */
+	time_info->stream_start_offset =
+		sof_ipc4_frames_dai_to_host(time_info, time_info->stream_start_offset);
+	time_info->stream_end_offset =
+		sof_ipc4_frames_dai_to_host(time_info, time_info->stream_end_offset);
+
 	/* Initialize the delay value to 0 (no delay) */
 	time_info->delay = 0;
 
@@ -992,6 +1031,8 @@ static int sof_ipc4_pcm_pointer(struct snd_soc_component *component,
 
 	/* For delay calculation we need the host counter */
 	host_cnt = snd_sof_pcm_get_host_byte_counter(sdev, component, substream);
+
+	/* Store the original value to host_ptr */
 	host_ptr = host_cnt;
 
 	/* convert the host_cnt to frames */
@@ -1010,6 +1051,8 @@ static int sof_ipc4_pcm_pointer(struct snd_soc_component *component,
 		sof_mailbox_read(sdev, time_info->llp_offset, &llp, sizeof(llp));
 		dai_cnt = ((u64)llp.reading.llp_u << 32) | llp.reading.llp_l;
 	}
+
+	dai_cnt = sof_ipc4_frames_dai_to_host(time_info, dai_cnt);
 	dai_cnt += time_info->stream_end_offset;
 
 	/* In two cases dai dma counter is not accurate
@@ -1043,8 +1086,9 @@ static int sof_ipc4_pcm_pointer(struct snd_soc_component *component,
 		dai_cnt -= time_info->stream_start_offset;
 	}
 
-	/* Wrap the dai counter at the boundary where the host counter wraps */
-	div64_u64_rem(dai_cnt, time_info->boundary, &dai_cnt);
+	/* Convert to a common base before comparisons */
+	dai_cnt &= DELAY_BOUNDARY;
+	host_cnt &= DELAY_BOUNDARY;
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		head_cnt = host_cnt;
@@ -1054,14 +1098,11 @@ static int sof_ipc4_pcm_pointer(struct snd_soc_component *component,
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


