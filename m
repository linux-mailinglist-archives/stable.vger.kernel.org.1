Return-Path: <stable+bounces-28547-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D23B88599A
	for <lists+stable@lfdr.de>; Thu, 21 Mar 2024 14:08:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE395B21BCF
	for <lists+stable@lfdr.de>; Thu, 21 Mar 2024 13:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD02084A2C;
	Thu, 21 Mar 2024 13:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MVbmS1jI"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2715083CDD;
	Thu, 21 Mar 2024 13:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711026485; cv=none; b=PznjS2jq5skmZZsgnJ3WPlPrJrowVg3j4R/lyW7JhJMcZaEP5iLpsc28NvcxwEVkBFeqIjfH1LYFA7Gg83+Oj+bWFhNrCDUctjeYky1wuKZdI/u14IittoTZ7GQijomL9oMf+6ut8VXh9XETkYOfr5CiWb7u7Stc4M0ffTZkOHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711026485; c=relaxed/simple;
	bh=YCclC6VgND4VPEMCMuhWZgfGxBGJ1wM4682GxlKtb/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OnvPVzm29mDaelkpMsDxesA4I8/VCmp/+U2Bmf9PFbP/DU3M/dPOdkzcLi6DTjBNJmjQcTL1XfNTQCvomCUriJjr2oVmnMRMefPTirmONvfmeZPq/fd2ShcacQTQoWFljZtI/JSLl6AVAhQ3xMHLxnRj1raN9693JE6ofn6vNfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MVbmS1jI; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711026484; x=1742562484;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YCclC6VgND4VPEMCMuhWZgfGxBGJ1wM4682GxlKtb/U=;
  b=MVbmS1jIMLv1srttjIwEgVWhpIHK3Z7f/vJXXOelp3CeSfc9mOknG/Ul
   YKfg0tfIJPQNwgkT4vQYX/vPK94aQrEKiAgz732GKr3Xz8lNltFwhxUMO
   3gBfcAzk9/mdiYQf0h4IfYP7DaJDKM/hvJle4EmFNDfpYK59pIpj9LsKx
   yUTL+3IQq4RzLbb6XjMTcoPNPEZuwOlU6538pqSl5qmtHQ11MJd8eD66V
   5p0KXwtXB8QMpy/4F3Zb0DuQ2vDcswJmUq85XHas6PsF7p7MPStu1oqWQ
   DNnpS8J//a/bIQ5vjYNB80KIGW3rs6mUYd/ejxtF4+mxNgD+gnapb6Exl
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="6127187"
X-IronPort-AV: E=Sophos;i="6.07,142,1708416000"; 
   d="scan'208";a="6127187"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 06:08:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,142,1708416000"; 
   d="scan'208";a="51923257"
Received: from vyakovle-mobl2.ger.corp.intel.com (HELO pujfalus-desk.ger.corp.intel.com) ([10.252.54.189])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 06:08:01 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	tiwai@suse.de
Cc: linux-sound@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com,
	kai.vehmanen@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	stable@vger.kernel.org
Subject: [PATCH 06/17] ASoC: SOF: Introduce a new callback pair to be used for PCM delay reporting
Date: Thu, 21 Mar 2024 15:08:03 +0200
Message-ID: <20240321130814.4412-7-peter.ujfalusi@linux.intel.com>
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

For delay calculation we need two information:
Number of bytes transferred between the DSP and host memory (ALSA buffer)
Number of frames transferred between the DSP and external device
(link/codec/DMIC/etc).

The reason for the different units (bytes vs frames) on host and dai side
is that the format on the dai side is decided by the firmware and might
not be the same as on the host side, thus the expectation is that the
counter reflects the number of frames.
The kernel know the host side format and in there we have access to the
DMA position which is in bytes.

In a simplified way, the DSP caused delay is the difference between the
two counters.

The existing get_stream_position callback is defined to retrieve the frame
counter on the DAI side but it's name is too generic to be intuitive and
makes it hard to define a callback for the host side.

This patch introduces a new set of callbacks to replace the
get_stream_position and define the host side equivalent:
get_dai_frame_counter
get_host_byte_counter

Subsequent patches will remove the old callback.

Cc: stable@vger.kernel.org # 6.8
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/ops.h      | 24 ++++++++++++++++++++++++
 sound/soc/sof/sof-priv.h | 21 +++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/sound/soc/sof/ops.h b/sound/soc/sof/ops.h
index 6cf21e829e07..d83cd771015c 100644
--- a/sound/soc/sof/ops.h
+++ b/sound/soc/sof/ops.h
@@ -533,6 +533,30 @@ static inline u64 snd_sof_pcm_get_stream_position(struct snd_sof_dev *sdev,
 	return 0;
 }
 
+static inline u64
+snd_sof_pcm_get_dai_frame_counter(struct snd_sof_dev *sdev,
+				  struct snd_soc_component *component,
+				  struct snd_pcm_substream *substream)
+{
+	if (sof_ops(sdev) && sof_ops(sdev)->get_dai_frame_counter)
+		return sof_ops(sdev)->get_dai_frame_counter(sdev, component,
+							    substream);
+
+	return 0;
+}
+
+static inline u64
+snd_sof_pcm_get_host_byte_counter(struct snd_sof_dev *sdev,
+				  struct snd_soc_component *component,
+				  struct snd_pcm_substream *substream)
+{
+	if (sof_ops(sdev) && sof_ops(sdev)->get_host_byte_counter)
+		return sof_ops(sdev)->get_host_byte_counter(sdev, component,
+							    substream);
+
+	return 0;
+}
+
 /* machine driver */
 static inline int
 snd_sof_machine_register(struct snd_sof_dev *sdev, void *pdata)
diff --git a/sound/soc/sof/sof-priv.h b/sound/soc/sof/sof-priv.h
index d453a4ce3b21..91043f177dfa 100644
--- a/sound/soc/sof/sof-priv.h
+++ b/sound/soc/sof/sof-priv.h
@@ -270,6 +270,27 @@ struct snd_sof_dsp_ops {
 				   struct snd_soc_component *component,
 				   struct snd_pcm_substream *substream); /* optional */
 
+	/*
+	 * optional callback to retrieve the number of frames left/arrived from/to
+	 * the DSP on the DAI side (link/codec/DMIC/etc).
+	 *
+	 * The callback is used when the firmware does not provide this information
+	 * via the shared SRAM window and it can be retrieved by host.
+	 */
+	u64 (*get_dai_frame_counter)(struct snd_sof_dev *sdev,
+				     struct snd_soc_component *component,
+				     struct snd_pcm_substream *substream); /* optional */
+
+	/*
+	 * Optional callback to retrieve the number of bytes left/arrived from/to
+	 * the DSP on the host side (bytes between host ALSA buffer and DSP).
+	 *
+	 * The callback is needed for ALSA delay reporting.
+	 */
+	u64 (*get_host_byte_counter)(struct snd_sof_dev *sdev,
+				     struct snd_soc_component *component,
+				     struct snd_pcm_substream *substream); /* optional */
+
 	/* host read DSP stream data */
 	int (*ipc_msg_data)(struct snd_sof_dev *sdev,
 			    struct snd_sof_pcm_stream *sps,
-- 
2.44.0


