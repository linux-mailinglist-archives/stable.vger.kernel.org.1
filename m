Return-Path: <stable+bounces-81517-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E7F0993E9A
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 08:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D517283A23
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 06:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0EA914BF89;
	Tue,  8 Oct 2024 06:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jia+vuWd"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C762314A618;
	Tue,  8 Oct 2024 06:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728367612; cv=none; b=g5QXDFvL8njEGpQLUP7OjWkmAOJOsKPvLtjR8ymjGxTtrhT8qmrJA/Q1NPgu0rdBBnRnSs8AgV+YCQRV/pFIGpuB7BwT6KdYN3yUmjJ5rl+8ePYWjAHdqeZtoLsHMd46ucFoV/E2hw4qYQLkmStm2clczuCxEE0tLevQOINk+7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728367612; c=relaxed/simple;
	bh=G419xqsgtCr3YapZUHYGtrbBTJwkX6BjsZ3jyky95HY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RB6W8uPhwOR7t8PZ0VCt1Nm0NGX/Ba3GQc1mKunCrIGLG2h7oDmS0wVoxPw65NsalCEEZgK1hM9cZisTo0VmIeevRK0Pyb2fBMK8G29NxEVLg0dWMTLfUaIIbx69m5SL4K5V88Qu+vZ2ISezBKNX1PtCY13XGf9ANLsVN5ZgrrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jia+vuWd; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728367611; x=1759903611;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=G419xqsgtCr3YapZUHYGtrbBTJwkX6BjsZ3jyky95HY=;
  b=jia+vuWdX1GejB5JHyorda8vzkbfA1ki4PSLeYLmaZebKIpl4+TFu0x9
   nU5CO6ttBXa2Tzl8keGzHI6s906IwZrQ5dGkIef+p7ZfAkgUXV8XSbGvg
   C/+FuQu0MopipNJWwprlb/CLvrMVHD7F4IgsAva7RayXmc+y3QvvlToCv
   1xDlEf0U9odJDT1EbRF6To8CeUmiBCZQkqD0qgPl1shgFhanM5xJXTiSz
   4bNdDIkB17XE0/PSWScv0fQWWyMto8/iTKxv1hejMkVDQzDRIZVY6iQTr
   RxttejbxC0V/n3+TuBFPBnwT1P1Xw/GxwXwjcUemuzdA4MS9p9Dxn37mx
   Q==;
X-CSE-ConnectionGUID: gf0tKQj8SPSei6QJbLL7RQ==
X-CSE-MsgGUID: RNmWxHCoQP6Tc7gPAX5xSQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11218"; a="38673202"
X-IronPort-AV: E=Sophos;i="6.11,186,1725346800"; 
   d="scan'208";a="38673202"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 23:06:50 -0700
X-CSE-ConnectionGUID: UqCYFoCXT4u2kt/D1EubvA==
X-CSE-MsgGUID: jYMcuHdxTeiAZ8hjym65bw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,186,1725346800"; 
   d="scan'208";a="80134042"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.245.49])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 23:06:47 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Cc: linux-sound@vger.kernel.org,
	kai.vehmanen@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	stable@vger.kernel.org,
	pierre-louis.bossart@linux.dev
Subject: [PATCH for 6.12] ASoC: SOF: Intel: hda-loader: do not wait for HDaudio IOC
Date: Tue,  8 Oct 2024 09:07:10 +0300
Message-ID: <20241008060710.15409-1-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kai Vehmanen <kai.vehmanen@linux.intel.com>

Commit 9ee3f0d8c999 ("ASOC: SOF: Intel: hda-loader: only wait for
HDaudio IOC for IPC4 devices") removed DMA wait for IPC3 case.
Proceed and remove the wait for IPC4 devices as well.

There is no dependency to IPC version in the load logic and
checking the firmware status is a sufficient check in case of
errors.

The removed code also had a bug in that -ETIMEDOUT is returned
without stopping the DMA transfer.

Cc: stable@vger.kernel.org
Link: https://github.com/thesofproject/linux/issues/5135
Fixes: 9ee3f0d8c999 ("ASOC: SOF: Intel: hda-loader: only wait for HDaudio IOC for IPC4 devices")
Suggested-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 sound/soc/sof/intel/hda-loader.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/sound/soc/sof/intel/hda-loader.c b/sound/soc/sof/intel/hda-loader.c
index 75f6240cf3e1..9d8ebb7c6a10 100644
--- a/sound/soc/sof/intel/hda-loader.c
+++ b/sound/soc/sof/intel/hda-loader.c
@@ -294,14 +294,9 @@ int hda_cl_copy_fw(struct snd_sof_dev *sdev, struct hdac_ext_stream *hext_stream
 {
 	struct sof_intel_hda_dev *hda = sdev->pdata->hw_pdata;
 	const struct sof_intel_dsp_desc *chip = hda->desc;
-	struct sof_intel_hda_stream *hda_stream;
-	unsigned long time_left;
 	unsigned int reg;
 	int ret, status;
 
-	hda_stream = container_of(hext_stream, struct sof_intel_hda_stream,
-				  hext_stream);
-
 	dev_dbg(sdev->dev, "Code loader DMA starting\n");
 
 	ret = hda_cl_trigger(sdev->dev, hext_stream, SNDRV_PCM_TRIGGER_START);
@@ -310,18 +305,6 @@ int hda_cl_copy_fw(struct snd_sof_dev *sdev, struct hdac_ext_stream *hext_stream
 		return ret;
 	}
 
-	if (sdev->pdata->ipc_type == SOF_IPC_TYPE_4) {
-		/* Wait for completion of transfer */
-		time_left = wait_for_completion_timeout(&hda_stream->ioc,
-							msecs_to_jiffies(HDA_CL_DMA_IOC_TIMEOUT_MS));
-
-		if (!time_left) {
-			dev_err(sdev->dev, "Code loader DMA did not complete\n");
-			return -ETIMEDOUT;
-		}
-		dev_dbg(sdev->dev, "Code loader DMA done\n");
-	}
-
 	dev_dbg(sdev->dev, "waiting for FW_ENTERED status\n");
 
 	status = snd_sof_dsp_read_poll_timeout(sdev, HDA_DSP_BAR,
-- 
2.46.2


