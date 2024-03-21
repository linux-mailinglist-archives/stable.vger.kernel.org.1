Return-Path: <stable+bounces-28546-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DD72885998
	for <lists+stable@lfdr.de>; Thu, 21 Mar 2024 14:08:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8C9A281C4A
	for <lists+stable@lfdr.de>; Thu, 21 Mar 2024 13:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF7D84A50;
	Thu, 21 Mar 2024 13:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Oy4u+6G3"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9558D8405C;
	Thu, 21 Mar 2024 13:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711026483; cv=none; b=mlRMg38eXPhxgyYWzNgGBRO3fFyoUFgPFCxw0Bj+rFKyAUlQnZ7H1OJQKtPZtr6yXOQxLp8kVFnYj/byV+vpGc/3c6mupxwrllFpJI3INhkJ+GADragmSzdySdFNFN3mRXuLtkQCIbPuCbNdmzsGCbHJ0Fy1EXro4LgxOKxnwaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711026483; c=relaxed/simple;
	bh=FSxXZBR8j228c7YOjbwTYZ72B+vQCZaHBK8ckfdx+DU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WrwcIBsn4E31SQ0qVlewWsGm8VZWGLbETRDyjcpKk72gJqwqR/VW9UH792JnEHdJ6ERAB40EIH5CDTfpq5162HMneILSDpmn/3cFbAPjcWCDb8GHh+Jq27TGRTVguHgG0zaknC+siZG7zOhKreIt9VGx+Pads1UqcRGJA7YXYKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Oy4u+6G3; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711026482; x=1742562482;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FSxXZBR8j228c7YOjbwTYZ72B+vQCZaHBK8ckfdx+DU=;
  b=Oy4u+6G3yD8i5R6JR/vBvvuaXk1m0EVqW3OO5zwqQC2meJEWOrXcaweX
   LWLZ+N0CdT/0soeCvoQDrNpZeX1MAfA+kraeO4fO5Gkp+cIyznQutirnJ
   7kOQqvjNq6Zt9vdsaVtlj4y94OhcrPTRT9O7f15aBc37F+etAPbrYEpRf
   SE4ONcglbMGyg996L4zpRPVL7gRncU8Wo+aF2OPorJQg7uSI8i7N49chO
   1uhOqC1sj3ibsrDMk/2EQIPOc6vbuAVUbMQFemio7zlb+gmtlHVjOqBHe
   4l0mxMRbmeg0YlFD2BUbdS8TKv/2k2sOU4OqFrmTY/bUFQQhlpZgl+PtW
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="6127179"
X-IronPort-AV: E=Sophos;i="6.07,142,1708416000"; 
   d="scan'208";a="6127179"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 06:08:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,142,1708416000"; 
   d="scan'208";a="51923250"
Received: from vyakovle-mobl2.ger.corp.intel.com (HELO pujfalus-desk.ger.corp.intel.com) ([10.252.54.189])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 06:07:59 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	tiwai@suse.de
Cc: linux-sound@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com,
	kai.vehmanen@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	stable@vger.kernel.org
Subject: [PATCH 05/17] ASoC: SOF: Intel: mtl/lnl: Use the generic get_stream_position callback
Date: Thu, 21 Mar 2024 15:08:02 +0200
Message-ID: <20240321130814.4412-6-peter.ujfalusi@linux.intel.com>
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

Drop the MTL mtl_dsp_get_stream_hda_link_position() function and related
defines since it can only work on platforms which have 19 streams because
of the use of 0x948 as base offset for the LLP registers.

The generic hda_dsp_get_stream_hda_link_position() takes the number of
streams into consideration when reading the LLP registers for the stream
and can handle different HDA configurations.

Cc: stable@vger.kernel.org # 6.8
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/intel/lnl.c |  2 --
 sound/soc/sof/intel/mtl.c | 14 --------------
 sound/soc/sof/intel/mtl.h | 10 ----------
 3 files changed, 26 deletions(-)

diff --git a/sound/soc/sof/intel/lnl.c b/sound/soc/sof/intel/lnl.c
index 7ae017a00184..d1c73d407e68 100644
--- a/sound/soc/sof/intel/lnl.c
+++ b/sound/soc/sof/intel/lnl.c
@@ -134,8 +134,6 @@ int sof_lnl_ops_init(struct snd_sof_dev *sdev)
 		sof_lnl_ops.runtime_resume = lnl_hda_dsp_runtime_resume;
 	}
 
-	sof_lnl_ops.get_stream_position = mtl_dsp_get_stream_hda_link_position;
-
 	/* dsp core get/put */
 	sof_lnl_ops.core_get = mtl_dsp_core_get;
 	sof_lnl_ops.core_put = mtl_dsp_core_put;
diff --git a/sound/soc/sof/intel/mtl.c b/sound/soc/sof/intel/mtl.c
index df05dc77b8d5..060c34988e90 100644
--- a/sound/soc/sof/intel/mtl.c
+++ b/sound/soc/sof/intel/mtl.c
@@ -626,18 +626,6 @@ static int mtl_dsp_disable_interrupts(struct snd_sof_dev *sdev)
 	return mtl_enable_interrupts(sdev, false);
 }
 
-u64 mtl_dsp_get_stream_hda_link_position(struct snd_sof_dev *sdev,
-					 struct snd_soc_component *component,
-					 struct snd_pcm_substream *substream)
-{
-	struct hdac_stream *hstream = substream->runtime->private_data;
-	u32 llp_l, llp_u;
-
-	llp_l = snd_sof_dsp_read(sdev, HDA_DSP_HDA_BAR, MTL_PPLCLLPL(hstream->index));
-	llp_u = snd_sof_dsp_read(sdev, HDA_DSP_HDA_BAR, MTL_PPLCLLPU(hstream->index));
-	return ((u64)llp_u << 32) | llp_l;
-}
-
 int mtl_dsp_core_get(struct snd_sof_dev *sdev, int core)
 {
 	const struct sof_ipc_pm_ops *pm_ops = sdev->ipc->ops->pm;
@@ -707,8 +695,6 @@ int sof_mtl_ops_init(struct snd_sof_dev *sdev)
 	sof_mtl_ops.core_get = mtl_dsp_core_get;
 	sof_mtl_ops.core_put = mtl_dsp_core_put;
 
-	sof_mtl_ops.get_stream_position = mtl_dsp_get_stream_hda_link_position;
-
 	sdev->private = kzalloc(sizeof(struct sof_ipc4_fw_data), GFP_KERNEL);
 	if (!sdev->private)
 		return -ENOMEM;
diff --git a/sound/soc/sof/intel/mtl.h b/sound/soc/sof/intel/mtl.h
index cc5a1f46fd09..ea8c1b83f712 100644
--- a/sound/soc/sof/intel/mtl.h
+++ b/sound/soc/sof/intel/mtl.h
@@ -6,12 +6,6 @@
  * Copyright(c) 2020-2022 Intel Corporation. All rights reserved.
  */
 
-/* HDA Registers */
-#define MTL_PPLCLLPL_BASE		0x948
-#define MTL_PPLCLLPU_STRIDE		0x10
-#define MTL_PPLCLLPL(x)			(MTL_PPLCLLPL_BASE + (x) * MTL_PPLCLLPU_STRIDE)
-#define MTL_PPLCLLPU(x)			(MTL_PPLCLLPL_BASE + 0x4 + (x) * MTL_PPLCLLPU_STRIDE)
-
 /* DSP Registers */
 #define MTL_HFDSSCS			0x1000
 #define MTL_HFDSSCS_SPA_MASK		BIT(16)
@@ -103,9 +97,5 @@ int mtl_dsp_ipc_get_window_offset(struct snd_sof_dev *sdev, u32 id);
 
 void mtl_ipc_dump(struct snd_sof_dev *sdev);
 
-u64 mtl_dsp_get_stream_hda_link_position(struct snd_sof_dev *sdev,
-					 struct snd_soc_component *component,
-					 struct snd_pcm_substream *substream);
-
 int mtl_dsp_core_get(struct snd_sof_dev *sdev, int core);
 int mtl_dsp_core_put(struct snd_sof_dev *sdev, int core);
-- 
2.44.0


