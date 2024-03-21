Return-Path: <stable+bounces-28543-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99CCD885995
	for <lists+stable@lfdr.de>; Thu, 21 Mar 2024 14:08:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB72C1C213C5
	for <lists+stable@lfdr.de>; Thu, 21 Mar 2024 13:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F086683CD9;
	Thu, 21 Mar 2024 13:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WLaW9anv"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4685384A36;
	Thu, 21 Mar 2024 13:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711026475; cv=none; b=dnGE/3DBrjBV9Fh/B+f+BJXhyg5Z24fr1I3L6ee+tb2isz0CzHLhUmSaTocb/qjJCqKYPNA1tXcmjbLPxgVCg4812TgEAPoK1nPHRTtx7lnOKOPSxd9Q+LAPdAxwUBKBhhOlyFUgWDS3noq4FRlWcAwHG69n7tAzrvAdbBPHQf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711026475; c=relaxed/simple;
	bh=MkxaVPGrS695EKkYca4qYs5F+gu9Pv24jskjKFDG5ho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D6s+0ZTlyjvl+CXLt1uQY8+fFTG8m9nWki1Uqskxq8VKDUR9BM2wmcb6rlVOsm/skwDQ+m9suxtk7+zRi/0aShmFH2tv8AnMCWxplGK1KC8arYUNXUHMaY0Soieh6V3RNnpSZ3lzAHb3yZWsjizh5L2y4e8nBhVpG1P1DcHYTOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WLaW9anv; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711026474; x=1742562474;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MkxaVPGrS695EKkYca4qYs5F+gu9Pv24jskjKFDG5ho=;
  b=WLaW9anvh0Y1mS0r8TC+ZCWcLK8So63WToXxFDawRWQNOLRAsGWt/jAK
   WKpEEsOR3PzT2CaMXskhbbJ7N5/d2V8L5tUhCrvW4vFqhJqYHj8A0WZU2
   DL9o8yJQ/oTX8e0Zie5KSRBQQZzA7BpE/fAHMSopbuAQh5Bj47eFUKfq1
   fdJMyoWbmKjxvaEwbBMHugHxRC9kHKbo49BZ23w+t0mcFj/mlqiRRuUyP
   XzYRE+nPRlS1p7tDNluZY+bNKxrppsTai/s4Loiw38XkaIOrhe22tsU6l
   Cpc7jhfhzRdA6yhdtiY1pUR3qky7UX4bUB6As5fJ8bAxN/l2+MooYwR9J
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="6127149"
X-IronPort-AV: E=Sophos;i="6.07,142,1708416000"; 
   d="scan'208";a="6127149"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 06:07:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,142,1708416000"; 
   d="scan'208";a="51923220"
Received: from vyakovle-mobl2.ger.corp.intel.com (HELO pujfalus-desk.ger.corp.intel.com) ([10.252.54.189])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 06:07:51 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	tiwai@suse.de
Cc: linux-sound@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com,
	kai.vehmanen@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	stable@vger.kernel.org
Subject: [PATCH 02/17] ASoC: SOF: ipc4-topology: Save the DMA maximum burst size for PCMs
Date: Thu, 21 Mar 2024 15:07:59 +0200
Message-ID: <20240321130814.4412-3-peter.ujfalusi@linux.intel.com>
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

When setting up the pcm widget, save the DSP buffer size (in ms) for
platform code to place a constraint on playback.

On playback the DMA will fill the buffer on start and if the period
size is smaller it will immediately overrun.

On capture the DMA will move data in 1ms bursts.

Cc: stable@vger.kernel.org # 6.8
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/ipc4-topology.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sof/ipc4-topology.c b/sound/soc/sof/ipc4-topology.c
index da4a83afb87a..bb4cf6dd1e18 100644
--- a/sound/soc/sof/ipc4-topology.c
+++ b/sound/soc/sof/ipc4-topology.c
@@ -412,8 +412,9 @@ static int sof_ipc4_widget_setup_pcm(struct snd_sof_widget *swidget)
 	struct sof_ipc4_available_audio_format *available_fmt;
 	struct snd_soc_component *scomp = swidget->scomp;
 	struct sof_ipc4_copier *ipc4_copier;
+	struct snd_sof_pcm *spcm;
 	int node_type = 0;
-	int ret;
+	int ret, dir;
 
 	ipc4_copier = kzalloc(sizeof(*ipc4_copier), GFP_KERNEL);
 	if (!ipc4_copier)
@@ -447,6 +448,25 @@ static int sof_ipc4_widget_setup_pcm(struct snd_sof_widget *swidget)
 	}
 	dev_dbg(scomp->dev, "host copier '%s' node_type %u\n", swidget->widget->name, node_type);
 
+	spcm = snd_sof_find_spcm_comp(scomp, swidget->comp_id, &dir);
+	if (!spcm)
+		goto skip_gtw_cfg;
+
+	if (dir == SNDRV_PCM_STREAM_PLAYBACK) {
+		struct snd_sof_pcm_stream *sps = &spcm->stream[dir];
+
+		sof_update_ipc_object(scomp, &sps->dsp_max_burst_size_in_ms,
+				      SOF_COPIER_DEEP_BUFFER_TOKENS,
+				      swidget->tuples,
+				      swidget->num_tuples, sizeof(u32), 1);
+		/* Set default DMA buffer size if it is not specified in topology */
+		if (!sps->dsp_max_burst_size_in_ms)
+			sps->dsp_max_burst_size_in_ms = SOF_IPC4_MIN_DMA_BUFFER_SIZE;
+	} else {
+		/* Capture data is copied from DSP to host in 1ms bursts */
+		spcm->stream[dir].dsp_max_burst_size_in_ms = 1;
+	}
+
 skip_gtw_cfg:
 	ipc4_copier->gtw_attr = kzalloc(sizeof(*ipc4_copier->gtw_attr), GFP_KERNEL);
 	if (!ipc4_copier->gtw_attr) {
-- 
2.44.0


