Return-Path: <stable+bounces-28558-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A71D8859A4
	for <lists+stable@lfdr.de>; Thu, 21 Mar 2024 14:08:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3BE1B21D17
	for <lists+stable@lfdr.de>; Thu, 21 Mar 2024 13:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE82984A3E;
	Thu, 21 Mar 2024 13:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LBIwS2J3"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235BE83CD6;
	Thu, 21 Mar 2024 13:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711026516; cv=none; b=FNi68CFLTD0+nD6hVe8fhlWI7ZIZLI04nn6PP6aNmQ2J8YcGHbu6WvhaXDRXm2ZQKGzajmUwkHh9WxDBhIpP30D2ITX6d/0Mg5cyUQa4uex/texWy/4Bw7MutBEzTzoGCOxF+rOIVQzsEviS7lATecH+TctakHYtsMGqUoHpLe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711026516; c=relaxed/simple;
	bh=qg7WTflSgWnykKRCW93DXzCAr6LePwXPuCvvmbMGhHM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LsFah4pQvwuJi716zBIC7TzdtOHdklnlGpV4V4wo0I6bNqH3vohSiGZ6fZSzpvCZPYfPGalUvpsIoTIKEXOlI+jchaPocUrTxmr6LacC9TP/61Rbhn9yKHa64Zz9dSv+jleyDuMSdJ8KXxkMBi5qNuWyKaavppg7OwLSP0nWDxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LBIwS2J3; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711026515; x=1742562515;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qg7WTflSgWnykKRCW93DXzCAr6LePwXPuCvvmbMGhHM=;
  b=LBIwS2J38doSqa1cG7dStV37fLrW1mTu2TG7jpsV+KqpBZZsVpcJzSM7
   b214skkSefvP8cgS0/0Gj5q3OLfeRvjME5BS92y5FkKjBQAEVk/clG1hH
   UswoIbux/4qHoX5f4vjsvwDlNbhMoj99mJMfBOFsOS3H05nHfg6rE5ljH
   nUjsFx/ALd11wxXEmuJuKU2WuSbpbK68Z2ENU3xabx5kwWKh7rewVpowM
   1DmY1Q/wVu0B2a3SAp9s+LoAdMkkBzl79soMn8umXe26HfF9yNkXi4N8w
   sa10er2/WGqPk/NQa8dyS/z99n5IygSjzFm7Kuuzbq9gaA+QDQaH1bCcI
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="6127275"
X-IronPort-AV: E=Sophos;i="6.07,142,1708416000"; 
   d="scan'208";a="6127275"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 06:08:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,142,1708416000"; 
   d="scan'208";a="51923339"
Received: from vyakovle-mobl2.ger.corp.intel.com (HELO pujfalus-desk.ger.corp.intel.com) ([10.252.54.189])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 06:08:30 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	tiwai@suse.de
Cc: linux-sound@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com,
	kai.vehmanen@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	stable@vger.kernel.org
Subject: [PATCH 17/17] ASoC: SOF: Intel: hda: Compensate LLP in case it is not reset
Date: Thu, 21 Mar 2024 15:08:14 +0200
Message-ID: <20240321130814.4412-18-peter.ujfalusi@linux.intel.com>
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

During pause/reset or stop/start the LLP counter is not reset, which will
result broken delay reporting.

Read the LLP value on STOP/PAUSE trigger and use it in LLP reading to
normalize the LLP from the register.

Cc: stable@vger.kernel.org # 6.8
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/intel/hda-dai-ops.c | 11 +++++++++++
 sound/soc/sof/intel/hda-pcm.c     |  8 ++++++++
 sound/soc/sof/intel/hda-stream.c  |  9 ++++++++-
 3 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sof/intel/hda-dai-ops.c b/sound/soc/sof/intel/hda-dai-ops.c
index c50ca9e72d37..b073720b4cf4 100644
--- a/sound/soc/sof/intel/hda-dai-ops.c
+++ b/sound/soc/sof/intel/hda-dai-ops.c
@@ -7,6 +7,7 @@
 
 #include <sound/pcm_params.h>
 #include <sound/hdaudio_ext.h>
+#include <sound/hda_register.h>
 #include <sound/hda-mlink.h>
 #include <sound/sof/ipc4/header.h>
 #include <uapi/sound/sof/header.h>
@@ -362,6 +363,16 @@ static int hda_trigger(struct snd_sof_dev *sdev, struct snd_soc_dai *cpu_dai,
 	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
 		snd_hdac_ext_stream_clear(hext_stream);
+
+		/*
+		 * Save the LLP registers in case the stream is
+		 * restarting due PAUSE_RELEASE, or START without a pcm
+		 * close/open since in this case the LLP register is not reset
+		 * to 0 and the delay calculation will return with invalid
+		 * results.
+		 */
+		hext_stream->pplcllpl = readl(hext_stream->pplc_addr + AZX_REG_PPLCLLPL);
+		hext_stream->pplcllpu = readl(hext_stream->pplc_addr + AZX_REG_PPLCLLPU);
 		break;
 	default:
 		dev_err(sdev->dev, "unknown trigger command %d\n", cmd);
diff --git a/sound/soc/sof/intel/hda-pcm.c b/sound/soc/sof/intel/hda-pcm.c
index 69fefcd1abc5..d7b446f3f973 100644
--- a/sound/soc/sof/intel/hda-pcm.c
+++ b/sound/soc/sof/intel/hda-pcm.c
@@ -282,6 +282,14 @@ int hda_dsp_pcm_open(struct snd_sof_dev *sdev,
 
 	/* binding pcm substream to hda stream */
 	substream->runtime->private_data = &dsp_stream->hstream;
+
+	/*
+	 * Reset the llp cache values (they are used for LLP compensation in
+	 * case the counter is not reset)
+	 */
+	dsp_stream->pplcllpl = 0;
+	dsp_stream->pplcllpu = 0;
+
 	return 0;
 }
 
diff --git a/sound/soc/sof/intel/hda-stream.c b/sound/soc/sof/intel/hda-stream.c
index 8504a4f27b60..0c189d3b19c1 100644
--- a/sound/soc/sof/intel/hda-stream.c
+++ b/sound/soc/sof/intel/hda-stream.c
@@ -1064,6 +1064,8 @@ snd_pcm_uframes_t hda_dsp_stream_get_position(struct hdac_stream *hstream,
 	return pos;
 }
 
+#define merge_u64(u32_u, u32_l) (((u64)(u32_u) << 32) | (u32_l))
+
 /**
  * hda_dsp_get_stream_llp - Retrieve the LLP (Linear Link Position) of the stream
  * @sdev: SOF device
@@ -1093,7 +1095,12 @@ u64 hda_dsp_get_stream_llp(struct snd_sof_dev *sdev,
 	llp_l = readl(hext_stream->pplc_addr + AZX_REG_PPLCLLPL);
 	llp_u = readl(hext_stream->pplc_addr + AZX_REG_PPLCLLPU);
 
-	return ((u64)llp_u << 32) | llp_l;
+	/* Compensate the LLP counter with the saved offset */
+	if (hext_stream->pplcllpl || hext_stream->pplcllpu)
+		return merge_u64(llp_u, llp_l) -
+		       merge_u64(hext_stream->pplcllpu, hext_stream->pplcllpl);
+
+	return merge_u64(llp_u, llp_l);
 }
 
 /**
-- 
2.44.0


