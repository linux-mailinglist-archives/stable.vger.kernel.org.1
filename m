Return-Path: <stable+bounces-28555-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF80D8859A0
	for <lists+stable@lfdr.de>; Thu, 21 Mar 2024 14:08:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BBE02825AC
	for <lists+stable@lfdr.de>; Thu, 21 Mar 2024 13:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF0684A2A;
	Thu, 21 Mar 2024 13:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jeydZim7"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE63783CD6;
	Thu, 21 Mar 2024 13:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711026514; cv=none; b=OQlmQ9gx30G+QNyw8F05Oi1/tBRrH+61eL39TBryDuGIUBsw67UWXgPCmyzCT5jQvkASrv3yDp8d6RQ16gWmqDf6ar8shcus1X1Ln1UCDSiaYfNiz5pt0BkJKtvLa2HVjMrFP3ai96+MUXjPTpfXkESi7/8HtboPr4ydN8duUXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711026514; c=relaxed/simple;
	bh=ORaWkE27cCIRkjidNjEIlsBLNgSeV1yAAIRoIlSWZbg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fa8ZRSe+Ags/aFCB3+a8xHTut2gev5sCbP5DgZ2ww/UGuYEcNjoW/YmURYBCL5vid1Z+R428IcYroHT1BkXGGuBZoP4Zgf9Znv/qMB5d5qtWDip7U5nFFzPO9TgnTQjP8Z14cRJyrIqJb9yFZzMxCKEd40+dOEvkCrYahxXhvZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jeydZim7; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711026513; x=1742562513;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ORaWkE27cCIRkjidNjEIlsBLNgSeV1yAAIRoIlSWZbg=;
  b=jeydZim73Qih/IqqSwBfXIAK6UIcUjT0NfidcTop0R4iaQ2uiaTqA+Od
   BFTw48rUI9pxFSAEbNNsDHGLwRo5YoRIJA5WXtf0H9hitEX1vf/NQ+rLc
   oUv4N4YEodsQoqKokkkSrNLxWLmKD00XFZelST58BWdxk2Ri0JQwql4av
   m4IMX7UWLzKQYEQpt8a8xECg5U8Gvon7SEPCE2ylL5vUzLYQ/GJNy3bQ9
   0E/OBW8xYvq2rtOAMGLpSMw1EqyudvkqPu1JDW2cA+bXtMMRKbLoipzUw
   gtpuXG+8wHo4RSFmOP9baVGXqQRB4Fzf3mNuGEtXcTubB+Z+OJ+79xat9
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="6127256"
X-IronPort-AV: E=Sophos;i="6.07,142,1708416000"; 
   d="scan'208";a="6127256"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 06:08:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,142,1708416000"; 
   d="scan'208";a="51923308"
Received: from vyakovle-mobl2.ger.corp.intel.com (HELO pujfalus-desk.ger.corp.intel.com) ([10.252.54.189])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 06:08:22 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	tiwai@suse.de
Cc: linux-sound@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com,
	kai.vehmanen@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	stable@vger.kernel.org
Subject: [PATCH 14/17] ASoC: SOF: sof-pcm: Add pointer callback to sof_ipc_pcm_ops
Date: Thu, 21 Mar 2024 15:08:11 +0200
Message-ID: <20240321130814.4412-15-peter.ujfalusi@linux.intel.com>
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

The IPC specific pointer callback can be used when additional or custom
handling is needed during the pointer calculation, like executing a delay
calculation at the same time to minimize drift between the reported pointer
and the calculated delay.

Cc: stable@vger.kernel.org # 6.8
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/pcm.c       | 8 ++++++++
 sound/soc/sof/sof-audio.h | 8 +++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sof/pcm.c b/sound/soc/sof/pcm.c
index 33d576b17647..f03cee94bce6 100644
--- a/sound/soc/sof/pcm.c
+++ b/sound/soc/sof/pcm.c
@@ -388,13 +388,21 @@ static snd_pcm_uframes_t sof_pcm_pointer(struct snd_soc_component *component,
 {
 	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
 	struct snd_sof_dev *sdev = snd_soc_component_get_drvdata(component);
+	const struct sof_ipc_pcm_ops *pcm_ops = sof_ipc_get_ops(sdev, pcm);
 	struct snd_sof_pcm *spcm;
 	snd_pcm_uframes_t host, dai;
+	int ret = -EOPNOTSUPP;
 
 	/* nothing to do for BE */
 	if (rtd->dai_link->no_pcm)
 		return 0;
 
+	if (pcm_ops && pcm_ops->pointer)
+		ret = pcm_ops->pointer(component, substream, &host);
+
+	if (ret != -EOPNOTSUPP)
+		return ret ? ret : host;
+
 	/* use dsp ops pointer callback directly if set */
 	if (sof_ops(sdev)->pcm_pointer)
 		return sof_ops(sdev)->pcm_pointer(sdev, substream);
diff --git a/sound/soc/sof/sof-audio.h b/sound/soc/sof/sof-audio.h
index 04e5cb2c70a7..86bbb531e142 100644
--- a/sound/soc/sof/sof-audio.h
+++ b/sound/soc/sof/sof-audio.h
@@ -103,7 +103,10 @@ struct snd_sof_dai_config_data {
  *	       additional memory in the SOF PCM stream structure
  * @pcm_free: Function pointer for PCM free that can be used for freeing any
  *	       additional memory in the SOF PCM stream structure
- * @delay: Function pointer for pcm delay calculation
+ * @pointer: Function pointer for pcm pointer
+ *	     Note: the @pointer callback may return -EOPNOTSUPP which should be
+ *		   handled in a same way as if the callback is not provided
+ * @delay: Function pointer for pcm delay reporting
  * @reset_hw_params_during_stop: Flag indicating whether the hw_params should be reset during the
  *				 STOP pcm trigger
  * @ipc_first_on_start: Send IPC before invoking platform trigger during
@@ -124,6 +127,9 @@ struct sof_ipc_pcm_ops {
 	int (*dai_link_fixup)(struct snd_soc_pcm_runtime *rtd, struct snd_pcm_hw_params *params);
 	int (*pcm_setup)(struct snd_sof_dev *sdev, struct snd_sof_pcm *spcm);
 	void (*pcm_free)(struct snd_sof_dev *sdev, struct snd_sof_pcm *spcm);
+	int (*pointer)(struct snd_soc_component *component,
+		       struct snd_pcm_substream *substream,
+		       snd_pcm_uframes_t *pointer);
 	snd_pcm_sframes_t (*delay)(struct snd_soc_component *component,
 				   struct snd_pcm_substream *substream);
 	bool reset_hw_params_during_stop;
-- 
2.44.0


