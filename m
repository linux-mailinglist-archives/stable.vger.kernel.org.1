Return-Path: <stable+bounces-183043-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A65BB3F08
	for <lists+stable@lfdr.de>; Thu, 02 Oct 2025 14:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E898B19C5C49
	for <lists+stable@lfdr.de>; Thu,  2 Oct 2025 12:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7194B3112A9;
	Thu,  2 Oct 2025 12:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dB+1T9SA"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E2B30DED8;
	Thu,  2 Oct 2025 12:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759409560; cv=none; b=L+GKhgjZb3y6PP2exDPzgG0265yDO4QKMXaTn0tlRkVRD3hmGEQ5tLBclsKibSsVlXAhPX4+ILIb6KyP21jLp/A1LY/PL00jcA2k5v3SvYSInYX2wXKEgS+mmexiNXw7+PZPSSgyzGnfMN/8ZYEl/PTYnZWcSclvAWiIWoTHbqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759409560; c=relaxed/simple;
	bh=7YK17TT4KKtXP/Wx43pfHfhnohIva9mei4XSixDtkgc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k8+9A8RMkGPVYJ0ORfzPNwt6nGL3ttNNwsLQjba/Dpd4ke2GtpccrL8LkorJeOtcXzABUhGYj8GhLo4Ps0zAvSSLeHlRvR4r2CPgWw1xOshYG+CMgNJFX0QmRbO9oEOJ/b5YF/ZHS/ukcuvVvuFHxI615ZdJI6k/g74zAULYheI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dB+1T9SA; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759409559; x=1790945559;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7YK17TT4KKtXP/Wx43pfHfhnohIva9mei4XSixDtkgc=;
  b=dB+1T9SAPAjKIiwydIXKH4zf8qp3MX3Xs3GYvJa/49BDuQV0K8nrs65X
   BX8hrFjIcSMnYFlGu656I1wo8uwJ8lO7/MTOB5ZrmquAUz30lVaCB8vqG
   P0qeNFeFua9XQgHv9HWuZInY7qzDRO5kmeBgwvKRTw4wAIQOoMgWyEWzi
   HMJVomgQz+peza/yqDdTk1cyTZ6njlMDeJPEZZfSqd5+lT+jetQTGX2r5
   v5jc6Kjs+CEooOSk2xqZ4zpA59w7/Vkj8e0+ZrZ9LevAFjuZjsMu5EVRM
   3wUCgAbgWjGuwGAkvnVmTD0m3pe3r9v17tDIs64lRlqeegc5tFhYJ/HUf
   w==;
X-CSE-ConnectionGUID: CLn7xRzLS46KsJRrAJoIBw==
X-CSE-MsgGUID: bsi2SFqORHCVabLHW6CXqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="61579812"
X-IronPort-AV: E=Sophos;i="6.18,309,1751266800"; 
   d="scan'208";a="61579812"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2025 05:52:38 -0700
X-CSE-ConnectionGUID: C3STtGykR6mluyJ3SuuIUA==
X-CSE-MsgGUID: GEVhNOExROGBS4LXniX+2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,309,1751266800"; 
   d="scan'208";a="179057612"
Received: from slindbla-desk.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.8])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2025 05:52:36 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Cc: linux-sound@vger.kernel.org,
	kai.vehmanen@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	pierre-louis.bossart@linux.dev,
	stable@vger.kernel.org
Subject: [PATCH v2 3/3] ASoC: SOF: Intel: hda-pcm: Place the constraint on period time instead of buffer time
Date: Thu,  2 Oct 2025 15:53:22 +0300
Message-ID: <20251002125322.15692-4-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002125322.15692-1-peter.ujfalusi@linux.intel.com>
References: <20251002125322.15692-1-peter.ujfalusi@linux.intel.com>
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

Fixes: 842bb8b62cc6 ("ASoC: SOF: Intel: hda-pcm: Use dsp_max_burst_size_in_ms to place constraint")
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


