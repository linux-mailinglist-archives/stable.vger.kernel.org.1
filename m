Return-Path: <stable+bounces-183019-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F55FBB2BAA
	for <lists+stable@lfdr.de>; Thu, 02 Oct 2025 09:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C491519C368A
	for <lists+stable@lfdr.de>; Thu,  2 Oct 2025 07:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709912D0C73;
	Thu,  2 Oct 2025 07:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NXG+g3+D"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F2F2BE651;
	Thu,  2 Oct 2025 07:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759391193; cv=none; b=BSETlED5qicOpq1sLHwJFSQrrFXelL3cmtjR0+VTDNSQ7f2OAXrTdTbwOjYtTMzpUCCmBolOOVqr9tGtxQNceiRkxFeFgWxQUIaU+3LdzBlAS4SCSZFT3ZMfl5stgCyDG9gS23znDYqLX1jrrN6ttD0rcORBgzCnxK/3ar8PCmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759391193; c=relaxed/simple;
	bh=LW2ylkswe6VqUt4aS/vrR8o+xnIZi/jn4YxOkzksIcw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RSRJlDfK4BexEjXvuSLQtuCG/KyVIrWVQsg2K/abqMBJmdG6+YIQuyoNxjg5uC5xlYHZkYoth9U5O3W4onRGSYu4SF84vlKLkdovKh2MwopIFFCJFVXoPkjWuLmguNfDlg9jTZGSEJwUIC0etuR+vr+m2oRpckfwd1pQC05CoXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NXG+g3+D; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759391192; x=1790927192;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LW2ylkswe6VqUt4aS/vrR8o+xnIZi/jn4YxOkzksIcw=;
  b=NXG+g3+D6patoF6yjYlHblc6QUNZo5NKoMbIl+kIlbs6+2kab/Xa+pTl
   MtCKAqRWwvszmWk7eXiu5toffYu1fNPQJtF/WIuGyT+x8CJJz2HZr7Zi/
   0a5Y21S1jKziA/2QoooLvRAzSsEfOfO6FUvQLpPNLl2vt5Czm2kbLX8CG
   r95d9kZp6ed5INh6dFly5aoJT/o140f1We14LAksLvw7GRU/2AugAdB1z
   Xqq+7JEpT0m8tbSnKa9yit0+d5D+4gVv1iX/g6vVJ/9rGA10/selLanDz
   lzK2kEPaPOWiTE+gjGMgj7OCfTz0zQZQm2JlOohIzOapuGIp2mPiD8IbU
   Q==;
X-CSE-ConnectionGUID: M0jlFTaOSiS/2yKIxfZ5/w==
X-CSE-MsgGUID: K6Ok9js+SDK4UgHeZ90TmQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="61630980"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="61630980"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2025 00:46:31 -0700
X-CSE-ConnectionGUID: CPMJzd9xTQWoJxWYHtVExA==
X-CSE-MsgGUID: bQLL2BtzQJ2nzBxxPnePRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,308,1751266800"; 
   d="scan'208";a="179760346"
Received: from slindbla-desk.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.8])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2025 00:46:28 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Cc: linux-sound@vger.kernel.org,
	kai.vehmanen@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	pierre-louis.bossart@linux.dev,
	stable@vger.kernel.org
Subject: [PATCH 2/5] ASoC: SOF: ipc4-pcm: fix start offset calculation for chain DMA
Date: Thu,  2 Oct 2025 10:47:16 +0300
Message-ID: <20251002074719.2084-3-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002074719.2084-1-peter.ujfalusi@linux.intel.com>
References: <20251002074719.2084-1-peter.ujfalusi@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kai Vehmanen <kai.vehmanen@linux.intel.com>

Assumption that chain DMA module starts the link DMA when 1ms of
data is available from host is not correct. Instead the firmware
chain DMA module fills the link DMA with initial buffer of zeroes
and the host and link DMAs are started at the same time.

This results in a small error in delay calculation. This can become a
more severe problem if host DMA has delays that exceed 1ms. This results
in negative delay to be calculated and bogus values reported to
applications. This can confuse some applications like
alsa_conformance_test.

Fix the issue by correctly calculating the firmware chain DMA
preamble size and initializing the start offset to this value.

Cc: stable@vger.kernel.org
Fixes: a1d203d390e0 ("ASoC: SOF: ipc4-pcm: Enable delay reporting for ChainDMA streams")
Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 sound/soc/sof/ipc4-pcm.c      | 14 ++++++++++----
 sound/soc/sof/ipc4-topology.c |  1 -
 sound/soc/sof/ipc4-topology.h |  2 ++
 3 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/sound/soc/sof/ipc4-pcm.c b/sound/soc/sof/ipc4-pcm.c
index 075388d5cb3c..9542c428daa4 100644
--- a/sound/soc/sof/ipc4-pcm.c
+++ b/sound/soc/sof/ipc4-pcm.c
@@ -1108,7 +1108,7 @@ static int sof_ipc4_get_stream_start_offset(struct snd_sof_dev *sdev,
 		return -EINVAL;
 	} else if (host_copier->data.gtw_cfg.node_id == SOF_IPC4_CHAIN_DMA_NODE_ID) {
 		/*
-		 * While the firmware does not supports time_info reporting for
+		 * While the firmware does not support time_info reporting for
 		 * streams using ChainDMA, it is granted that ChainDMA can only
 		 * be used on Host+Link pairs where the link position is
 		 * accessible from the host side.
@@ -1116,10 +1116,16 @@ static int sof_ipc4_get_stream_start_offset(struct snd_sof_dev *sdev,
 		 * Enable delay calculation in case of ChainDMA via host
 		 * accessible registers.
 		 *
-		 * The ChainDMA uses 2x 1ms ping-pong buffer, dai side starts
-		 * when 1ms data is available
+		 * The ChainDMA prefills the link DMA with a preamble
+		 * of zero samples. Set the stream start offset based
+		 * on size of the preamble (driver provided fifo size
+		 * multiplied by 2.5). We add 1ms of margin as the FW
+		 * will align the buffer size to DMA hardware
+		 * alignment that is not known to host.
 		 */
-		time_info->stream_start_offset = substream->runtime->rate / MSEC_PER_SEC;
+		int pre_ms = SOF_IPC4_CHAIN_DMA_BUF_SIZE_MS * 5 / 2 + 1;
+
+		time_info->stream_start_offset = pre_ms * substream->runtime->rate / MSEC_PER_SEC;
 		goto out;
 	}
 
diff --git a/sound/soc/sof/ipc4-topology.c b/sound/soc/sof/ipc4-topology.c
index b6a732d0adb4..36568160f163 100644
--- a/sound/soc/sof/ipc4-topology.c
+++ b/sound/soc/sof/ipc4-topology.c
@@ -33,7 +33,6 @@ MODULE_PARM_DESC(ipc4_ignore_cpc,
 
 #define SOF_IPC4_GAIN_PARAM_ID  0
 #define SOF_IPC4_TPLG_ABI_SIZE 6
-#define SOF_IPC4_CHAIN_DMA_BUF_SIZE_MS 2
 
 static DEFINE_IDA(alh_group_ida);
 static DEFINE_IDA(pipeline_ida);
diff --git a/sound/soc/sof/ipc4-topology.h b/sound/soc/sof/ipc4-topology.h
index dfa1a6c2ffa8..6b29692dff16 100644
--- a/sound/soc/sof/ipc4-topology.h
+++ b/sound/soc/sof/ipc4-topology.h
@@ -263,6 +263,8 @@ struct sof_ipc4_dma_stream_ch_map {
 #define SOF_IPC4_DMA_METHOD_HDA   1
 #define SOF_IPC4_DMA_METHOD_GPDMA 2 /* defined for consistency but not used */
 
+#define SOF_IPC4_CHAIN_DMA_BUF_SIZE_MS 2
+
 /**
  * struct sof_ipc4_dma_config: DMA configuration
  * @dma_method: HDAudio or GPDMA
-- 
2.51.0


