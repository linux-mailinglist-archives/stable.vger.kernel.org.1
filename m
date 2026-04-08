Return-Path: <stable+bounces-233822-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uCpoFGQW1mnwAwgAu9opvQ
	(envelope-from <stable+bounces-233822-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 10:48:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C1C3B94EB
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 10:48:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 44502305D5CE
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 08:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB8A33A784F;
	Wed,  8 Apr 2026 08:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ILcleQ0/"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E103A782E;
	Wed,  8 Apr 2026 08:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775637903; cv=none; b=V7i+F8nyz/O10Nkw/pip77qVLL9oFUtLCbE//D4lW8QZ9LRleR7Y09ivw2MtEamoOtzcxS1G9/uf4aG/9U4kj8vSZQhHxin1RWQgLBB6evEMw3EVFZoTgKKv+j/dnOmzWAMT8c3SBSgfZJTnKYW6mYiLlBOeSGHYkKmvGWpCqhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775637903; c=relaxed/simple;
	bh=TR8jci+eYL1qo8ICwrk5CyT9gpb4wZJEyBDUcoEloh4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=djuw2AjvEqycwfmrMQtBESPd4zZKfSVDZUFU5/XRTRQ9yhqz0Ok2yYGYxE8Y9Foow9vqiOddFB2x5az/8sZ0JEzdTH4eK0DeI+Y5ojwjXGTDTZCCr5Ts5Q58SA1F4YJozdZsRSSG4EndZ2KP2mr9I9S0qgegYlZNTiUOyzsYmI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ILcleQ0/; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775637902; x=1807173902;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TR8jci+eYL1qo8ICwrk5CyT9gpb4wZJEyBDUcoEloh4=;
  b=ILcleQ0/k16FktcwjQpjkr8BzsgJSXmydBOq649uauIxdEEiyA7IbbyD
   1bcZgfI3qJxHdms3VRYUxiQXrep21v6SyJsFDeQP8/7y/5Jj31Z7sr5qh
   VfSWaB+V6nGqmxUX60wVBtnLyfg4ug4nozM4TGidoclXB1xlXdNCTIXa2
   4WaRG3tqls9iBzTFehe58w7LjVKYKxiXwZuGjW9IjeYFhMHUUzIlA14sR
   l6OIDp/G94K1BY6L6DB0nu16WQN0Hw96eubFuXB//FOw+hICaNs4kFd+u
   k1umEV9fBjx7GK6ad12xalMwkvlzlCxfMCkjCIhEgbOe/v86e/FHd2IXC
   Q==;
X-CSE-ConnectionGUID: VMD3Euw4RsWtgX9sIMyi6w==
X-CSE-MsgGUID: huj7S16iTNW3Zc343v5eKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="94003661"
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; 
   d="scan'208";a="94003661"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 01:45:01 -0700
X-CSE-ConnectionGUID: 3VEgT5o9SLOyQpN3uRllUA==
X-CSE-MsgGUID: vth7P5TlQAuf5/hO65Eq4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; 
   d="scan'208";a="251742001"
Received: from rvuia-mobl.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.244.250])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 01:44:59 -0700
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
Subject: [PATCH for 7.0 2/2] ASoC: SOF: Intel: hda: modify period size constraints for ACE4
Date: Wed,  8 Apr 2026 11:45:14 +0300
Message-ID: <20260408084514.24325-3-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408084514.24325-1-peter.ujfalusi@linux.intel.com>
References: <20260408084514.24325-1-peter.ujfalusi@linux.intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,suse.de];
	TAGGED_FROM(0.00)[bounces-233822-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peter.ujfalusi@linux.intel.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.intel.com:mid,intel.com:dkim,intel.com:email]
X-Rspamd-Queue-Id: C3C1C3B94EB
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
Cc: stable@vger.kernel.org
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


