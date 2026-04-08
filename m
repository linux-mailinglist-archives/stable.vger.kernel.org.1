Return-Path: <stable+bounces-233881-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KMRMHAtI1mkFCwgAu9opvQ
	(envelope-from <stable+bounces-233881-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 14:20:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E013BBE7C
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 14:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 77BD83060293
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 12:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7223C13FE;
	Wed,  8 Apr 2026 12:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D7bf+X4c"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9063BFE4D;
	Wed,  8 Apr 2026 12:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775650478; cv=none; b=XWaVxhhVaeMmEoUYxzUyY4X2L3/irF8HbCLTaxSKHB9nY3V/bw+xxvUC4KePmzyMLM/2MjoPP1ROTAy8pYnw1WKHqFo9Zq+SwcnApZ06LVhpzZLcPZk/bevfLUZcArVPiULGHSE2uQc4eThyXiUS32y3ec9RESZmgRbtJZyXTaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775650478; c=relaxed/simple;
	bh=U5Sz2J4O67dwks/060Ky8B13jv1hb/lEfq65R7J6iac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c1TAzh8IjR7adU6xr2UTObrg5w4JCSDxZwn8NYM1Rno4HbbjlmqUMv24VIaUuGOltXrH0NVMZLZe7SbeHvmKeF8UrvghCRJEHnloJ1kOd7b1AYeu6ipVwhpNSWd8o1uyxJVO+ZHr1C5J3KMuQDz8J+mGbPI/VSOZg1n4lqEZySU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D7bf+X4c; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775650477; x=1807186477;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=U5Sz2J4O67dwks/060Ky8B13jv1hb/lEfq65R7J6iac=;
  b=D7bf+X4cfgL2p3md3WKCKorBYlpyTVoj+tgY4rPTQUp5lOMf3dVuxjg/
   UGZpodZO609IGOszqpFym5kayf3SBFjoo/678tSrjeygyuT5repEv69g1
   5ysGImD11EzavTIp0r1Yei+ygQ9JiPMfbJiqKzY4D6dq7VgF5K6JYKTdo
   lpZNWuzpxuquG7WipbaanscxtHPrfGcn8Z+GD6CKZJpzB0sbABv1hQKgt
   eFnTlKCidjT46TVyakd6TSWE3H9F69rePd8SdZNmPQET5M6mQyy5zqeBL
   SkEyFAScIrCUhvP3GHucjRenqKozKJq2LAxXpuA5LYQ5V3D28ATL3b+2b
   w==;
X-CSE-ConnectionGUID: 7TbBQ/4jTm2dhaeCqJO95g==
X-CSE-MsgGUID: 7v354dJpSL2BKa1mbbHwag==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="80225538"
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; 
   d="scan'208";a="80225538"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 05:14:36 -0700
X-CSE-ConnectionGUID: M/aKrpD7TgeCRxHZwkRy8A==
X-CSE-MsgGUID: /gMqW74DSNG8ofwshG1p2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; 
   d="scan'208";a="233405341"
Received: from rvuia-mobl.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.244.250])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 05:14:34 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	tiwai@suse.de
Cc: linux-sound@vger.kernel.org,
	kai.vehmanen@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	pierre-louis.bossart@linux.dev,
	stable@vger.kernel.org,
	liam.r.girdwood@intel.com
Subject: [PATCH for 7.0 v2 2/2] ASoC: SOF: Intel: hda: modify period size constraints for ACE4
Date: Wed,  8 Apr 2026 15:14:48 +0300
Message-ID: <20260408121448.31130-3-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408121448.31130-1-peter.ujfalusi@linux.intel.com>
References: <20260408121448.31130-1-peter.ujfalusi@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,suse.de];
	TAGGED_FROM(0.00)[bounces-233881-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peter.ujfalusi@linux.intel.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 50E013BBE7C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Kai Vehmanen <kai.vehmanen@linux.intel.com>

Intel ACE4 based products set more strict constraints on HDA BDLE start
address and length alignment. Add a constraint to align period size to
128 bytes.

The commit removes the "minimum as per HDA spec" comment. This comment
was misleading as spec actually does allow a 2 byte BDLE length, and
more importantly, period size also directly impacts how the BDLE start
addresses are aligned, so it is not sufficient just to consider allowed
buffer length.

Fixes: d3df422f66e8 ("ASoC: SOF: Intel: add initial support for NVL-S")
Reported-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Liam Girdwood <liam.r.girdwood@intel.com>
---
 sound/soc/sof/intel/hda-pcm.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sof/intel/hda-pcm.c b/sound/soc/sof/intel/hda-pcm.c
index da6c1e7263cd..16a364072821 100644
--- a/sound/soc/sof/intel/hda-pcm.c
+++ b/sound/soc/sof/intel/hda-pcm.c
@@ -219,6 +219,7 @@ EXPORT_SYMBOL_NS(hda_dsp_pcm_pointer, "SND_SOC_SOF_INTEL_HDA_COMMON");
 int hda_dsp_pcm_open(struct snd_sof_dev *sdev,
 		     struct snd_pcm_substream *substream)
 {
+	const struct sof_intel_dsp_desc *chip_info = get_chip_info(sdev->pdata);
 	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_soc_component *scomp = sdev->component;
@@ -268,8 +269,17 @@ int hda_dsp_pcm_open(struct snd_sof_dev *sdev,
 		return -ENODEV;
 	}
 
-	/* minimum as per HDA spec */
-	snd_pcm_hw_constraint_step(substream->runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_BYTES, 4);
+	/*
+	 * Set period size constraint to ensure BDLE buffer length and
+	 * start address alignment requirements are met. Align to 128
+	 * bytes for newer Intel platforms, with older ones using 4 byte alignment.
+	 */
+	if (chip_info->hw_ip_version >= SOF_INTEL_ACE_4_0)
+		snd_pcm_hw_constraint_step(substream->runtime, 0,
+					   SNDRV_PCM_HW_PARAM_PERIOD_BYTES, 128);
+	else
+		snd_pcm_hw_constraint_step(substream->runtime, 0,
+					   SNDRV_PCM_HW_PARAM_PERIOD_BYTES, 4);
 
 	/* avoid circular buffer wrap in middle of period */
 	snd_pcm_hw_constraint_integer(substream->runtime,
-- 
2.53.0


