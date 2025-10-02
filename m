Return-Path: <stable+bounces-183022-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FAF0BB2BB3
	for <lists+stable@lfdr.de>; Thu, 02 Oct 2025 09:46:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 311B33C54E3
	for <lists+stable@lfdr.de>; Thu,  2 Oct 2025 07:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3832BE641;
	Thu,  2 Oct 2025 07:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GjEaCyBr"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744322BE651;
	Thu,  2 Oct 2025 07:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759391201; cv=none; b=X0yQ30XElq/skJnxJZY3Zq6dkwa4b4Um5KAf8ftP0N5CqyR24cXEh7vJQXuS+Lxzqkt7eqqN/it5wbePrkDpwfoF/ePmRk7XPlST+49jGb4Cav87mGDH7hFM+wTWxYDRQ96Xkgg8FwHqS0tJoUCLnDNECv6CVYXBogcQ48yzlGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759391201; c=relaxed/simple;
	bh=oxlxQBx7AOuv58GBhyA9JkmYZXrlCQwiWlBiLd3JTpI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AtlB24t3Y2nhOXvpbUeLFDBPuJBcDmWHyILu/zVqNFGtWqxIPSzb1juvadY2tDlkKTNJraMaZFezqzMzNDWrNs7a2u6Zk/SpAOms4C2p8PYpRjHsH4gcBtr1Hwf1PCkPFoGZAsQWc2Qy+l6qH3l9PUm6lRxpG2wscnUye1Wp/ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GjEaCyBr; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759391200; x=1790927200;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oxlxQBx7AOuv58GBhyA9JkmYZXrlCQwiWlBiLd3JTpI=;
  b=GjEaCyBroAT205tZS0I0Z72h+FH+RO/mfdLqTyfXeE2cy8sQcxIq97vE
   ZDPXhJfVLhRJ3Fr2VUs9jcNbuxw61JDWam2AoS06Y0vrePoEj+by7DSVa
   S4FwwpEJs+4F5ukFM67fu4c1AHkVGYP+h/y3EGfIu2CXUPWO0TOZ7v19K
   1DEVsFdpkpoRA1BPWNOumjBJ5CA17ho7MzgRRmcuufjxZzZ1hdbKLzP19
   Q2FuWRmaCLKF3M+ilN2IuigF1p0HW0y+ULugqvPofxMFH1AQyMOsR1cev
   1z9xWw+/6yzYZGxwqxmY9VOtYuneqMPz4Vb8lXyN8zCOh2z/yFASnTWnU
   g==;
X-CSE-ConnectionGUID: 93YwNKnqTyCNTxwRpdlZVw==
X-CSE-MsgGUID: kW8CBhScSKyBXO2dxvDdvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="61631004"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="61631004"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2025 00:46:39 -0700
X-CSE-ConnectionGUID: rq4mr2KwTe6ypdWIdBlSEQ==
X-CSE-MsgGUID: Yx+utI0iTA2fRBwpWP+JTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,308,1751266800"; 
   d="scan'208";a="179760351"
Received: from slindbla-desk.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.8])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2025 00:46:37 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Cc: linux-sound@vger.kernel.org,
	kai.vehmanen@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	pierre-louis.bossart@linux.dev,
	stable@vger.kernel.org
Subject: [PATCH 5/5] ASoC: SOF: Intel: Read the LLP via the associated Link DMA channel
Date: Thu,  2 Oct 2025 10:47:19 +0300
Message-ID: <20251002074719.2084-6-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002074719.2084-1-peter.ujfalusi@linux.intel.com>
References: <20251002074719.2084-1-peter.ujfalusi@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is allowed to mix Link and Host DMA channels in a way that their index
is different. In this case we would read the LLP from a channel which is
not used or used for other operation.

Such case can be reproduced on cAVS2.5 or ACE1 platforms with soundwire
configuration:
playback to SDW would take Host channel 0 (stream_tag 1) and no Link DMA
used
Second playback to HDMI (HDA) would use Host channel 1 (stream_tag 2) and
Link channel 0 (stream_tag 1).

In this case reading the LLP from channel 2 is incorrect as that is not the
Link channel used for the HDMI playback.

To correct this, we should look up the BE and get the channel used on the
Link side.

Fixes: 67b182bea08a ("ASoC: SOF: Intel: hda: Implement get_stream_position (Linear Link Position)")
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 sound/soc/sof/intel/hda-stream.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sof/intel/hda-stream.c b/sound/soc/sof/intel/hda-stream.c
index a34f472ef175..9c3b3a9aaf83 100644
--- a/sound/soc/sof/intel/hda-stream.c
+++ b/sound/soc/sof/intel/hda-stream.c
@@ -1129,10 +1129,35 @@ u64 hda_dsp_get_stream_llp(struct snd_sof_dev *sdev,
 			   struct snd_soc_component *component,
 			   struct snd_pcm_substream *substream)
 {
-	struct hdac_stream *hstream = substream->runtime->private_data;
-	struct hdac_ext_stream *hext_stream = stream_to_hdac_ext_stream(hstream);
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
+	struct snd_soc_pcm_runtime *be_rtd = NULL;
+	struct hdac_ext_stream *hext_stream;
+	struct snd_soc_dai *cpu_dai;
+	struct snd_soc_dpcm *dpcm;
 	u32 llp_l, llp_u;
 
+	/*
+	 * The LLP needs to be read from the Link DMA used for this FE as it is
+	 * allowed to use any combination of Link and Host channels
+	 */
+	for_each_dpcm_be(rtd, substream->stream, dpcm) {
+		if (dpcm->fe != rtd)
+			continue;
+
+		be_rtd = dpcm->be;
+	}
+
+	if (!be_rtd)
+		return 0;
+
+	cpu_dai = snd_soc_rtd_to_cpu(be_rtd, 0);
+	if (!cpu_dai)
+		return 0;
+
+	hext_stream = snd_soc_dai_get_dma_data(cpu_dai, substream);
+	if (!hext_stream)
+		return 0;
+
 	/*
 	 * The pplc_addr have been calculated during probe in
 	 * hda_dsp_stream_init():
-- 
2.51.0


