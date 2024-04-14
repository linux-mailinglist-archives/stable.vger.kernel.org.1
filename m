Return-Path: <stable+bounces-37275-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A98D89C42A
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 15:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB48A28346C
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 13:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41D385654;
	Mon,  8 Apr 2024 13:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kQ+zk9es"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A992DF73;
	Mon,  8 Apr 2024 13:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712583760; cv=none; b=OAMKNClOf3oUeSouWncbbT21f+0IS3bMnnjzMIsTxsD7dMmdHuIwkMUi+s5fDqfqN44+Nua2p87XQvyRfsatRKGqvia4RWrEwBCTtvV6Nat8BtYx9LyayxkhjVTKOgRmA9mXMSzg0TMe6G30ZAaInU5nhdaky4w+vT8UebClmC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712583760; c=relaxed/simple;
	bh=CiveTact0jrufrt2JptfgamRwsUtfH5rNMkCG9bSIj8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pw8nF2OHcvVIDxaYw59onNvdsSPXNHdvpmKW0qKU/ucrDEfQvuxJ/olhNIOqjSWmIKrYcfzaOm/eQUhWkgL2/jZPJVouPIdnhIn40Hnf3Eqtld5V1xLWPCAqzbLfBR0FB+9q6TI4BRRBegkDkGzHuuD8MdMwD6i6skEhpphMeaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kQ+zk9es; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBC01C433F1;
	Mon,  8 Apr 2024 13:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712583760;
	bh=CiveTact0jrufrt2JptfgamRwsUtfH5rNMkCG9bSIj8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kQ+zk9eseGIllcq9yqgEu1jp9xQFTciVSOng884YTOF/0bJ2WN7ATUBUJOdApWxD4
	 8E9ejtgXzsOX0uB8CDPlTsm8JSnouo6s0OtPcHesRHFSpq5HNjXiYAdOrCOZNRn+tZ
	 WlTMA3A6xYjlsOAi886gHX17JJp57oaYGogaMJY8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Rander Wang <rander.wang@intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.8 216/273] ASoC: SOF: Intel: mtl/lnl: Use the generic get_stream_position callback
Date: Mon,  8 Apr 2024 14:58:11 +0200
Message-ID: <20240408125316.099809042@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408125309.280181634@linuxfoundation.org>
References: <20240408125309.280181634@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>

commit 4374f698d7d9f849b66f3fa8f7a64f0bc1a53d7f upstream.

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
Link: https://msgid.link/r/20240321130814.4412-6-peter.ujfalusi@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/sof/intel/lnl.c |    2 --
 sound/soc/sof/intel/mtl.c |   14 --------------
 sound/soc/sof/intel/mtl.h |   10 ----------
 3 files changed, 26 deletions(-)

--- a/sound/soc/sof/intel/lnl.c
+++ b/sound/soc/sof/intel/lnl.c
@@ -118,8 +118,6 @@ int sof_lnl_ops_init(struct snd_sof_dev
 	sof_lnl_ops.resume			= lnl_hda_dsp_resume;
 	sof_lnl_ops.runtime_resume		= lnl_hda_dsp_runtime_resume;
 
-	sof_lnl_ops.get_stream_position = mtl_dsp_get_stream_hda_link_position;
-
 	/* dsp core get/put */
 	sof_lnl_ops.core_get = mtl_dsp_core_get;
 	sof_lnl_ops.core_put = mtl_dsp_core_put;
--- a/sound/soc/sof/intel/mtl.c
+++ b/sound/soc/sof/intel/mtl.c
@@ -626,18 +626,6 @@ static int mtl_dsp_disable_interrupts(st
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
@@ -707,8 +695,6 @@ int sof_mtl_ops_init(struct snd_sof_dev
 	sof_mtl_ops.core_get = mtl_dsp_core_get;
 	sof_mtl_ops.core_put = mtl_dsp_core_put;
 
-	sof_mtl_ops.get_stream_position = mtl_dsp_get_stream_hda_link_position;
-
 	sdev->private = kzalloc(sizeof(struct sof_ipc4_fw_data), GFP_KERNEL);
 	if (!sdev->private)
 		return -ENOMEM;
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
@@ -103,9 +97,5 @@ int mtl_dsp_ipc_get_window_offset(struct
 
 void mtl_ipc_dump(struct snd_sof_dev *sdev);
 
-u64 mtl_dsp_get_stream_hda_link_position(struct snd_sof_dev *sdev,
-					 struct snd_soc_component *component,
-					 struct snd_pcm_substream *substream);
-
 int mtl_dsp_core_get(struct snd_sof_dev *sdev, int core);
 int mtl_dsp_core_put(struct snd_sof_dev *sdev, int core);



