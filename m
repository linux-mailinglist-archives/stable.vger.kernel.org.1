Return-Path: <stable+bounces-28544-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0809885996
	for <lists+stable@lfdr.de>; Thu, 21 Mar 2024 14:08:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52D182832D4
	for <lists+stable@lfdr.de>; Thu, 21 Mar 2024 13:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B6F284A4D;
	Thu, 21 Mar 2024 13:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BfEMGV/C"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7258383CD7;
	Thu, 21 Mar 2024 13:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711026477; cv=none; b=OTH4rYXCHEu4VemMn5CbF5HVyqsEzJ3skDZs07WXwHx4exwmZd66UgY8zEMWSeB5awZERHjWFdoUXAN8FhR50hrWuvqIvrp3Gf3YmiRoTV2qCZI9xdlNP0ArMD+/3Oh22RVitIjJUa7gccdTUVMFZeueqwN5T5oDnHLbAXPHKt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711026477; c=relaxed/simple;
	bh=FkMA/M2i7a6VpMd1kOZNQKCsrFoOKNqdFhzidgFZ694=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=el9dNmXk+NhT7a6+kQJk60sp2/Y6FNIGcy/157J/2zVF9NITU8QoH+TkPFKfQuo/OB4Qb3LDWhdkatEgpPP/roJELiJyo6+aG/RHdiwTgolFj4ehM8PUwlZNKqe9K/iiO2kTAZpKBYWNx3uJ7PLrYSuH2H5V3akxNBpcQnp1beI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BfEMGV/C; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711026476; x=1742562476;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FkMA/M2i7a6VpMd1kOZNQKCsrFoOKNqdFhzidgFZ694=;
  b=BfEMGV/CHxgzhLAYM7jHRNraqReE8EE4jFxpt0eo2H9LnAmmylOQSCzn
   KliwP/4O+SsDrHkBrnJVxNmfyTluoZdLFCZqd83f6vNcK4WNNa0lgC/U6
   GXZG510NWv5sSvNyYvaQz7uFKexUvhX48VWTyiWtOxx1Pma5LG+ReCXdG
   oWb5rcgbHe23QKsGIKE9h4Ma+s6euPiNfaDcnVq6J5TqNMooSZwH8vdi1
   yQqN4RUqyqWqZxown+/XwojPXtWkVQh6/C4tIAkPPeDdgAkfJLoNGarRk
   M2FEyhglv1T3KtYjyrlJxOCaVS1BVkbtMrCXo6NKaRb3/Q7Yj0srkFkBH
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="6127163"
X-IronPort-AV: E=Sophos;i="6.07,142,1708416000"; 
   d="scan'208";a="6127163"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 06:07:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,142,1708416000"; 
   d="scan'208";a="51923228"
Received: from vyakovle-mobl2.ger.corp.intel.com (HELO pujfalus-desk.ger.corp.intel.com) ([10.252.54.189])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 06:07:54 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	tiwai@suse.de
Cc: linux-sound@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com,
	kai.vehmanen@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	stable@vger.kernel.org
Subject: [PATCH 03/17] ASoC: SOF: Intel: hda-pcm: Use dsp_max_burst_size_in_ms to place constraint
Date: Thu, 21 Mar 2024 15:08:00 +0200
Message-ID: <20240321130814.4412-4-peter.ujfalusi@linux.intel.com>
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

If the PCM have the dsp_max_burst_size_in_ms set then place a constraint
to limit the minimum buffer time to avoid xruns caused by DMA bursts
spinning on the ALSA buffer.

Cc: stable@vger.kernel.org # 6.8
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/intel/hda-pcm.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/sound/soc/sof/intel/hda-pcm.c b/sound/soc/sof/intel/hda-pcm.c
index 18f07364d219..69fefcd1abc5 100644
--- a/sound/soc/sof/intel/hda-pcm.c
+++ b/sound/soc/sof/intel/hda-pcm.c
@@ -259,6 +259,27 @@ int hda_dsp_pcm_open(struct snd_sof_dev *sdev,
 		snd_pcm_hw_constraint_mask64(substream->runtime, SNDRV_PCM_HW_PARAM_FORMAT,
 					     SNDRV_PCM_FMTBIT_S16 | SNDRV_PCM_FMTBIT_S32);
 
+	/*
+	 * The dsp_max_burst_size_in_ms is the length of the maximum burst size
+	 * of the host DMA in the ALSA buffer.
+	 *
+	 * On playback start the DMA will transfer dsp_max_burst_size_in_ms
+	 * amount of data in one initial burst to fill up the host DMA buffer.
+	 * Consequent DMA burst sizes are shorter and their length can vary.
+	 * To make sure that userspace allocate large enough ALSA buffer we need
+	 * to place a constraint on the buffer time.
+	 *
+	 * On capture the DMA will transfer 1ms chunks.
+	 *
+	 * Exact dsp_max_burst_size_in_ms constraint is racy, so set the
+	 * constraint to a minimum of 2x dsp_max_burst_size_in_ms.
+	 */
+	if (spcm->stream[direction].dsp_max_burst_size_in_ms)
+		snd_pcm_hw_constraint_minmax(substream->runtime,
+			SNDRV_PCM_HW_PARAM_BUFFER_TIME,
+			spcm->stream[direction].dsp_max_burst_size_in_ms * USEC_PER_MSEC * 2,
+			UINT_MAX);
+
 	/* binding pcm substream to hda stream */
 	substream->runtime->private_data = &dsp_stream->hstream;
 	return 0;
-- 
2.44.0


