Return-Path: <stable+bounces-28548-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5563F885999
	for <lists+stable@lfdr.de>; Thu, 21 Mar 2024 14:08:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86FB21C213DC
	for <lists+stable@lfdr.de>; Thu, 21 Mar 2024 13:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D96D84A35;
	Thu, 21 Mar 2024 13:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ENciAFbl"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D472D84039;
	Thu, 21 Mar 2024 13:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711026488; cv=none; b=pR/8X3g5qdUaMv0LkDv5dAirCCTNFr/cymjUWEIfm2kDOZtggZeT3IsQbUyOlfMd+T5e5hZIwxn7NYM4pP4Bdqln4cTIJNknxTyjMxy3hclFXKtfiTTDEKrSDy4spTmiSL1haU3NNbtCUrzKrfOjxW2/1f2uEbfQS5Z1VVicaHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711026488; c=relaxed/simple;
	bh=aKfiUQtOllQNC+BcnqfFelbbkVkMg1jilJqkihqXcog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FHVf0TuIKfjJJZsYvtp98UngRb5YYUhFbg+gbRLERsSiGcnQxnNDRy/tgTANKSj5EZXbk5XfBmox36YHp6MgIoE+T7iRFoUAZAmKQtT1BTFOcieqNqZ75rr4tX1h6OYjpwn4g7tQChqgm7+ky1/+innAyg2VwcIisGb3240b+cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ENciAFbl; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711026487; x=1742562487;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aKfiUQtOllQNC+BcnqfFelbbkVkMg1jilJqkihqXcog=;
  b=ENciAFblsAvrygyPUtG3IcBp2bpIvFxLqcZnJvfP0Sh8uQuJ6p22ZbE7
   FYRL74QfCqerDBGxx7eU1spG0jcqTJwA1nqVV2Bskh2i0zseWIO0u81zb
   HP0R/XbC+je5W8AXUhj+m4WV4bMW2OP0B7PnkNFhKFwDFNAv3fVUHEJMi
   8pq+DnkfuMNll2sTT/DujYZZr1U9IYv9a1acNOg4/Y74qs2YB0DfBuDuj
   7pcuPcZESKCvX1CseCPGlJjsDtiHfWYdmtQThzFKoF5KEw5kjhW6fOciz
   LqTcfjEELqc3MPWhfNuRbFnQvHOCZEeE2Lhc8GXb4y/QhUKQfj8N8z399
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="6127191"
X-IronPort-AV: E=Sophos;i="6.07,142,1708416000"; 
   d="scan'208";a="6127191"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 06:08:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,142,1708416000"; 
   d="scan'208";a="51923259"
Received: from vyakovle-mobl2.ger.corp.intel.com (HELO pujfalus-desk.ger.corp.intel.com) ([10.252.54.189])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 06:08:04 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	tiwai@suse.de
Cc: linux-sound@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com,
	kai.vehmanen@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	stable@vger.kernel.org
Subject: [PATCH 07/17] ASoC: SOF: Intel: Set the dai/host get frame/byte counter callbacks
Date: Thu, 21 Mar 2024 15:08:04 +0200
Message-ID: <20240321130814.4412-8-peter.ujfalusi@linux.intel.com>
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

Add implementation for reading the LDP (Linear DMA Position) to be used as
get_host_byte_counter().
The LDP is counting the number of bytes moved between the DSP and host
memory.

Set the get_dai_frame_counter to hda_dsp_get_stream_llp, which is counting
the frames on the link side of the DSP.

Cc: stable@vger.kernel.org # 6.8
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/intel/hda-common-ops.c |  2 ++
 sound/soc/sof/intel/hda-stream.c     | 31 ++++++++++++++++++++++++++++
 sound/soc/sof/intel/hda.h            |  3 +++
 3 files changed, 36 insertions(+)

diff --git a/sound/soc/sof/intel/hda-common-ops.c b/sound/soc/sof/intel/hda-common-ops.c
index 80a69599a8c3..4d7ea18604ee 100644
--- a/sound/soc/sof/intel/hda-common-ops.c
+++ b/sound/soc/sof/intel/hda-common-ops.c
@@ -58,6 +58,8 @@ struct snd_sof_dsp_ops sof_hda_common_ops = {
 	.pcm_ack	= hda_dsp_pcm_ack,
 
 	.get_stream_position = hda_dsp_get_stream_llp,
+	.get_dai_frame_counter = hda_dsp_get_stream_llp,
+	.get_host_byte_counter = hda_dsp_get_stream_ldp,
 
 	/* firmware loading */
 	.load_firmware = snd_sof_load_firmware_raw,
diff --git a/sound/soc/sof/intel/hda-stream.c b/sound/soc/sof/intel/hda-stream.c
index 48ea187f7230..8504a4f27b60 100644
--- a/sound/soc/sof/intel/hda-stream.c
+++ b/sound/soc/sof/intel/hda-stream.c
@@ -1095,3 +1095,34 @@ u64 hda_dsp_get_stream_llp(struct snd_sof_dev *sdev,
 
 	return ((u64)llp_u << 32) | llp_l;
 }
+
+/**
+ * hda_dsp_get_stream_ldp - Retrieve the LDP (Linear DMA Position) of the stream
+ * @sdev: SOF device
+ * @component: ASoC component
+ * @substream: PCM substream
+ *
+ * Returns the raw Linear Link Position value
+ */
+u64 hda_dsp_get_stream_ldp(struct snd_sof_dev *sdev,
+			   struct snd_soc_component *component,
+			   struct snd_pcm_substream *substream)
+{
+	struct hdac_stream *hstream = substream->runtime->private_data;
+	struct hdac_ext_stream *hext_stream = stream_to_hdac_ext_stream(hstream);
+	u32 ldp_l, ldp_u;
+
+	/*
+	 * The pphc_addr have been calculated during probe in
+	 * hda_dsp_stream_init():
+	 * pphc_addr = sdev->bar[HDA_DSP_PP_BAR] +
+	 *	       SOF_HDA_PPHC_BASE +
+	 *	       SOF_HDA_PPHC_INTERVAL * stream_index
+	 *
+	 * Use this pre-calculated address to avoid repeated re-calculation.
+	 */
+	ldp_l = readl(hext_stream->pphc_addr + AZX_REG_PPHCLDPL);
+	ldp_u = readl(hext_stream->pphc_addr + AZX_REG_PPHCLDPU);
+
+	return ((u64)ldp_u << 32) | ldp_l;
+}
diff --git a/sound/soc/sof/intel/hda.h b/sound/soc/sof/intel/hda.h
index 9d26cad785fe..81a1d4606d3c 100644
--- a/sound/soc/sof/intel/hda.h
+++ b/sound/soc/sof/intel/hda.h
@@ -665,6 +665,9 @@ snd_pcm_uframes_t hda_dsp_stream_get_position(struct hdac_stream *hstream,
 u64 hda_dsp_get_stream_llp(struct snd_sof_dev *sdev,
 			   struct snd_soc_component *component,
 			   struct snd_pcm_substream *substream);
+u64 hda_dsp_get_stream_ldp(struct snd_sof_dev *sdev,
+			   struct snd_soc_component *component,
+			   struct snd_pcm_substream *substream);
 
 struct hdac_ext_stream *
 	hda_dsp_stream_get(struct snd_sof_dev *sdev, int direction, u32 flags);
-- 
2.44.0


