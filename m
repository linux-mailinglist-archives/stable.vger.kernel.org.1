Return-Path: <stable+bounces-183062-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F79EBB41BE
	for <lists+stable@lfdr.de>; Thu, 02 Oct 2025 15:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E88119E04F1
	for <lists+stable@lfdr.de>; Thu,  2 Oct 2025 13:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62160312804;
	Thu,  2 Oct 2025 13:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QODcRsHj"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B0B79CD;
	Thu,  2 Oct 2025 13:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759413429; cv=none; b=AsH8jNC5XPb1vdYQxm1bnOWQe5k5awRjY3xm4bZdqE00S+oMh2BoxzeY7K9D0JuaSUdxKPBb+ZqZYvI0P8QA94cdpwRMioOrsbZnKOctbDTT9aDUxYjm0BAO34R3iwof9bWv2lspVqVxzXtOK6YZ5EdZhyzyo6eQoN0+WytuRQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759413429; c=relaxed/simple;
	bh=eyDXzoowK29aHblXiqXcGbJd0/Lf6qeO3yHaMKfkXtk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lrw6x0fSsHlbEaGOZjTvhds3SYO8HhG1AOegMRRm3Fwq+9zEMPhZlaTDs0+Z/es61qpqSS7EiQ1TXfXQwaiszjABLo+obpUJEGKpXgi+Kl3lF36r5kidokals7UXVGA2CP6HRRufSTvOTYe9XhGzcuKupKTB6gf1ZZICBfEAjBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QODcRsHj; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759413427; x=1790949427;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eyDXzoowK29aHblXiqXcGbJd0/Lf6qeO3yHaMKfkXtk=;
  b=QODcRsHjPTYyCcuSX71sMvgMOr+m8eRnGRl8TSjq+6dzkDCTwytnlNzd
   sYbY584uBZmDgdBmW+QsnrYFJnfu5ldHjBZIdrRhmj96w7hHleuATWtkv
   zpQ/cbEx4dW1YcWslSLtzKTJ87krKt7oPs6pUv3tSFjZdf0KJ8nM1Peo4
   TJytWmFw86JGCQ5vgjwZsPdAjFA87LM5wdw1A1316a3VvCoeGb3mpCdtO
   EJSLkZfBEVm8DfpmPT9CgOnjOgsiNMaf0dTJw8HybePIX0qAJLSdk8Fj4
   4EO6KEGok3Z3Fvq1wX+0/8/+AfGhTkw6pnQwXjBWyurCQL1AyvBRnE/Bc
   Q==;
X-CSE-ConnectionGUID: OOKCSPVqTyKibzX2Gakvhw==
X-CSE-MsgGUID: IcdVzYa2S0Kb+1LxmVWOdg==
X-IronPort-AV: E=McAfee;i="6800,10657,11570"; a="49251151"
X-IronPort-AV: E=Sophos;i="6.18,309,1751266800"; 
   d="scan'208";a="49251151"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2025 06:57:07 -0700
X-CSE-ConnectionGUID: KjmF2Q0ZSpe31OAnKHdBOw==
X-CSE-MsgGUID: nGG2hZFpTHWcmiAFou0o9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,309,1751266800"; 
   d="scan'208";a="179460671"
Received: from slindbla-desk.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.8])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2025 06:57:05 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Cc: linux-sound@vger.kernel.org,
	kai.vehmanen@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	pierre-louis.bossart@linux.dev,
	stable@vger.kernel.org
Subject: [PATCH v3 3/3] ASoC: SOF: Intel: hda-pcm: Place the constraint on period time instead of buffer time
Date: Thu,  2 Oct 2025 16:57:52 +0300
Message-ID: <20251002135752.2430-4-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002135752.2430-1-peter.ujfalusi@linux.intel.com>
References: <20251002135752.2430-1-peter.ujfalusi@linux.intel.com>
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

Fixes: fe76d2e75a6d ("ASoC: SOF: Intel: hda-pcm: Use dsp_max_burst_size_in_ms to place constraint")
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


