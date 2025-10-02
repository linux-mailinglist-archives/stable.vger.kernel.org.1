Return-Path: <stable+bounces-183026-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DED89BB2C45
	for <lists+stable@lfdr.de>; Thu, 02 Oct 2025 10:05:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FB081C4DF4
	for <lists+stable@lfdr.de>; Thu,  2 Oct 2025 08:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4ACA2D2394;
	Thu,  2 Oct 2025 08:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JqQaY9bi"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8EBB27281D;
	Thu,  2 Oct 2025 08:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759392295; cv=none; b=X7+VV8FwiMbDQ6bUy93g5zC5mr6yzrFfCJlA5/Tcy6DtXTi8XFSm+WuIP6BHp7nbnyq2ocAq6hHRYFhde+4pYqRUzX8m++Ju6K3H4gfl9kc0vIUthsZlIpmUbMrL+Nb0fm/MPpQ6rEd+OIVJ9AcfS9XyGa8xBySqCOvr35T/OyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759392295; c=relaxed/simple;
	bh=PCk9ZeVV1UHVtDqXJ82bfijyd7gshesDIpbIkMJurSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b4Zelzr1QuweQIIvciLL5+PZD5OxwsqC7GFhVXPiUGlioZoXoB2/SCxBVZ+RDItQHzvaFl13DcK+k9fj5wFzA7/MvNIS9oLyAnfV2gFO+5nbXQIa23Gv8h62Z62AHz5FzEs303nnND1ww9oavUtkl1rJhIu2kY/LhCokBR9h74Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JqQaY9bi; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759392294; x=1790928294;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PCk9ZeVV1UHVtDqXJ82bfijyd7gshesDIpbIkMJurSQ=;
  b=JqQaY9bipdTyvP9blv5yZRK1esN0dYvH2r0E7dstaPLg/GyaFaY2Qvfs
   cI3apMwE4X8t3VOKrTs0q75USIPXR5gnovLe531oJgrQg2mTLd4VKxWiA
   1Px1MGyYgXFbkbSqgvWp08OPXP3JZDHKjZogWxAwJNDhOAsB1yM8SjBHz
   LgzVsQZzhNXugmsWNU42b031quGvua5YciZUF98tmxcpWS8/zvJpUbxmQ
   t+3RNTlIqVA9VKD0GO337DSjrXffYt+EysklTTThmEhS0GN7VS1fBZBxS
   0Mfsu7k1HKo9Mgby1qK0jICL91U9PK7Wia0AfU8S+5aHtmk2We10PUS2+
   w==;
X-CSE-ConnectionGUID: BfGrlP/aRjWpCtRTwDJRGw==
X-CSE-MsgGUID: ugDfeYY/S4SknMsKFEfQfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="65525014"
X-IronPort-AV: E=Sophos;i="6.18,309,1751266800"; 
   d="scan'208";a="65525014"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2025 01:04:53 -0700
X-CSE-ConnectionGUID: kev2kcY1TsG5WCcCebR2lg==
X-CSE-MsgGUID: pqJP4TVxQliQWhPsYp/TUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,309,1751266800"; 
   d="scan'208";a="178268548"
Received: from slindbla-desk.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.8])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2025 01:04:50 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Cc: linux-sound@vger.kernel.org,
	kai.vehmanen@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	pierre-louis.bossart@linux.dev,
	stable@vger.kernel.org
Subject: [PATCH 3/3] ASoC: SOF: Intel: hda-pcm: Place the constraint on period time instead of buffer time
Date: Thu,  2 Oct 2025 11:05:38 +0300
Message-ID: <20251002080538.4418-4-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002080538.4418-1-peter.ujfalusi@linux.intel.com>
References: <20251002080538.4418-1-peter.ujfalusi@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of constraining the ALSA buffer time to be double of the firmware
host buffer size, it is better to set it for the period time.
This will implicitly constrain the buffer time to a safe value
(num_periods is at least 2) and prohibits applications to set smaller
period size than what will be covered by the initial DMA burst.

Cc: stable@vger.kernel.org
Fixes: 02ea2a0364a2 ("ASoC: SOF: Intel: hda-pcm: Use dsp_max_burst_size_in_ms to place constraint")
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 sound/soc/sof/intel/hda-pcm.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/sound/soc/sof/intel/hda-pcm.c b/sound/soc/sof/intel/hda-pcm.c
index 1dd8d2092c3b..da6c1e7263cd 100644
--- a/sound/soc/sof/intel/hda-pcm.c
+++ b/sound/soc/sof/intel/hda-pcm.c
@@ -29,6 +29,8 @@
 #define SDnFMT_BITS(x)	((x) << 4)
 #define SDnFMT_CHAN(x)	((x) << 0)
 
+#define HDA_MAX_PERIOD_TIME_HEADROOM	10
+
 static bool hda_always_enable_dmi_l1;
 module_param_named(always_enable_dmi_l1, hda_always_enable_dmi_l1, bool, 0444);
 MODULE_PARM_DESC(always_enable_dmi_l1, "SOF HDA always enable DMI l1");
@@ -291,19 +293,30 @@ int hda_dsp_pcm_open(struct snd_sof_dev *sdev,
 	 * On playback start the DMA will transfer dsp_max_burst_size_in_ms
 	 * amount of data in one initial burst to fill up the host DMA buffer.
 	 * Consequent DMA burst sizes are shorter and their length can vary.
-	 * To make sure that userspace allocate large enough ALSA buffer we need
-	 * to place a constraint on the buffer time.
+	 * To avoid immediate xrun by the initial burst we need to place
+	 * constraint on the period size (via PERIOD_TIME) to cover the size of
+	 * the host buffer.
+	 * We need to add headroom of max 10ms as the firmware needs time to
+	 * settle to the 1ms pacing and initially it can run faster for few
+	 * internal periods.
 	 *
 	 * On capture the DMA will transfer 1ms chunks.
-	 *
-	 * Exact dsp_max_burst_size_in_ms constraint is racy, so set the
-	 * constraint to a minimum of 2x dsp_max_burst_size_in_ms.
 	 */
-	if (spcm->stream[direction].dsp_max_burst_size_in_ms)
+	if (spcm->stream[direction].dsp_max_burst_size_in_ms) {
+		unsigned int period_time = spcm->stream[direction].dsp_max_burst_size_in_ms;
+
+		/*
+		 * add headroom over the maximum burst size to cover the time
+		 * needed for the DMA pace to settle.
+		 * Limit the headroom time to HDA_MAX_PERIOD_TIME_HEADROOM
+		 */
+		period_time += min(period_time, HDA_MAX_PERIOD_TIME_HEADROOM);
+
 		snd_pcm_hw_constraint_minmax(substream->runtime,
-			SNDRV_PCM_HW_PARAM_BUFFER_TIME,
-			spcm->stream[direction].dsp_max_burst_size_in_ms * USEC_PER_MSEC * 2,
+			SNDRV_PCM_HW_PARAM_PERIOD_TIME,
+			period_time * USEC_PER_MSEC,
 			UINT_MAX);
+	}
 
 	/* binding pcm substream to hda stream */
 	substream->runtime->private_data = &dsp_stream->hstream;
-- 
2.51.0


