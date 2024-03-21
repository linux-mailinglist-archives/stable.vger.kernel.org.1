Return-Path: <stable+bounces-28545-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E3AA885997
	for <lists+stable@lfdr.de>; Thu, 21 Mar 2024 14:08:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D2AC1F21346
	for <lists+stable@lfdr.de>; Thu, 21 Mar 2024 13:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB398405D;
	Thu, 21 Mar 2024 13:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="amIwzlKs"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1488F83CD7;
	Thu, 21 Mar 2024 13:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711026480; cv=none; b=qvM5YFUc9OYeegMmzA8Ay9QSUC8UmJrK9Xlzib49esirC16WJ3ihUSJ1/HOpSmU2OYMYLnjro+16eDD9SODE4/kJaYJ5Z49M3wFmv/OCOu4RPcK1cmKgRo0OAKvdTp7qBGnY7YpGUuDXf/x41zzmO3lWm4mBmXc7Qqfb6lrxu+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711026480; c=relaxed/simple;
	bh=w4CeqR3aNMRunaN5detz8EqRHAic6+sHqj8Oo4B/k2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s6CH0Ff7Rjh9Z5fG3BMj8nFkh4OhSRPGUIligqDZImMUy83o63IC7kVxHlaMgO1Zt7MOjRSCuQqxzWDoC0yXm+bPTzTbVSVC1IKzKeBOldF3kn7T9AT5qz+kzQMD6sfU5JJeYnl0l4hF7cJSNd2DXqLE+B/h9XoAq01TszFmUqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=amIwzlKs; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711026479; x=1742562479;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=w4CeqR3aNMRunaN5detz8EqRHAic6+sHqj8Oo4B/k2s=;
  b=amIwzlKsaRr3zGPmLC1tvwS0btFyadEcUV0jroyyfzn5x7/atO9fM7cY
   TouNLDqPHV5CniljzpUx9hWTBZ9hen/lheb1easZ4WmhtZQvDDm+7viq5
   dvnx8doo7PUviKAydhsq3AsxOpcKc9DLIdusCq8/++hMrwuJIIgEsewvs
   Jv4w5U9Epqtahx+2nhzt1cKMrmF+3Tz82Hv0+SNJ8zuJvFg62s0L8GeFi
   0nbTGQa/zvGm9fLof/r6KWs+6mA4sQxSGz7R1KN6xRTwE05snjcLJIev4
   hEQMuDgZ0Pzkg7txuBoKFqd96V38Ci3i7LXswWAwHUkPsVkp/9EsMPURQ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="6127174"
X-IronPort-AV: E=Sophos;i="6.07,142,1708416000"; 
   d="scan'208";a="6127174"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 06:07:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,142,1708416000"; 
   d="scan'208";a="51923239"
Received: from vyakovle-mobl2.ger.corp.intel.com (HELO pujfalus-desk.ger.corp.intel.com) ([10.252.54.189])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 06:07:56 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	tiwai@suse.de
Cc: linux-sound@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com,
	kai.vehmanen@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	stable@vger.kernel.org
Subject: [PATCH 04/17] ASoC: SOF: Intel: hda: Implement get_stream_position (Linear Link Position)
Date: Thu, 21 Mar 2024 15:08:01 +0200
Message-ID: <20240321130814.4412-5-peter.ujfalusi@linux.intel.com>
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

When the Linear Link Position is not available in firmware SRAM window we
use the host accessible position registers to read it.
The address of the PPLCLLPL/U registers depend on the number of streams
(playback+capture).
At probe time the pplc_addr is calculated for each stream and we can use
it to read the LLP without the need of address re-calculation.

Set the get_stream_position callback in sof_hda_common_ops for all
platforms:
The callback is used for IPC4 delay calculations only but the register is
a generic HDA register, not tied to any specific IPC version.

Cc: stable@vger.kernel.org # 6.8
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/intel/hda-common-ops.c |  2 ++
 sound/soc/sof/intel/hda-stream.c     | 32 ++++++++++++++++++++++++++++
 sound/soc/sof/intel/hda.h            |  3 +++
 3 files changed, 37 insertions(+)

diff --git a/sound/soc/sof/intel/hda-common-ops.c b/sound/soc/sof/intel/hda-common-ops.c
index 2b385cddc385..80a69599a8c3 100644
--- a/sound/soc/sof/intel/hda-common-ops.c
+++ b/sound/soc/sof/intel/hda-common-ops.c
@@ -57,6 +57,8 @@ struct snd_sof_dsp_ops sof_hda_common_ops = {
 	.pcm_pointer	= hda_dsp_pcm_pointer,
 	.pcm_ack	= hda_dsp_pcm_ack,
 
+	.get_stream_position = hda_dsp_get_stream_llp,
+
 	/* firmware loading */
 	.load_firmware = snd_sof_load_firmware_raw,
 
diff --git a/sound/soc/sof/intel/hda-stream.c b/sound/soc/sof/intel/hda-stream.c
index b387b1a69d7e..48ea187f7230 100644
--- a/sound/soc/sof/intel/hda-stream.c
+++ b/sound/soc/sof/intel/hda-stream.c
@@ -1063,3 +1063,35 @@ snd_pcm_uframes_t hda_dsp_stream_get_position(struct hdac_stream *hstream,
 
 	return pos;
 }
+
+/**
+ * hda_dsp_get_stream_llp - Retrieve the LLP (Linear Link Position) of the stream
+ * @sdev: SOF device
+ * @component: ASoC component
+ * @substream: PCM substream
+ *
+ * Returns the raw Linear Link Position value
+ */
+u64 hda_dsp_get_stream_llp(struct snd_sof_dev *sdev,
+			   struct snd_soc_component *component,
+			   struct snd_pcm_substream *substream)
+{
+	struct hdac_stream *hstream = substream->runtime->private_data;
+	struct hdac_ext_stream *hext_stream = stream_to_hdac_ext_stream(hstream);
+	u32 llp_l, llp_u;
+
+	/*
+	 * The pplc_addr have been calculated during probe in
+	 * hda_dsp_stream_init():
+	 * pplc_addr = sdev->bar[HDA_DSP_PP_BAR] +
+	 *	       SOF_HDA_PPLC_BASE +
+	 *	       SOF_HDA_PPLC_MULTI * total_stream +
+	 *	       SOF_HDA_PPLC_INTERVAL * stream_index
+	 *
+	 * Use this pre-calculated address to avoid repeated re-calculation.
+	 */
+	llp_l = readl(hext_stream->pplc_addr + AZX_REG_PPLCLLPL);
+	llp_u = readl(hext_stream->pplc_addr + AZX_REG_PPLCLLPU);
+
+	return ((u64)llp_u << 32) | llp_l;
+}
diff --git a/sound/soc/sof/intel/hda.h b/sound/soc/sof/intel/hda.h
index b36eb7c78913..9d26cad785fe 100644
--- a/sound/soc/sof/intel/hda.h
+++ b/sound/soc/sof/intel/hda.h
@@ -662,6 +662,9 @@ bool hda_dsp_check_stream_irq(struct snd_sof_dev *sdev);
 
 snd_pcm_uframes_t hda_dsp_stream_get_position(struct hdac_stream *hstream,
 					      int direction, bool can_sleep);
+u64 hda_dsp_get_stream_llp(struct snd_sof_dev *sdev,
+			   struct snd_soc_component *component,
+			   struct snd_pcm_substream *substream);
 
 struct hdac_ext_stream *
 	hda_dsp_stream_get(struct snd_sof_dev *sdev, int direction, u32 flags);
-- 
2.44.0


