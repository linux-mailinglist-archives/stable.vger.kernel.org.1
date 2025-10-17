Return-Path: <stable+bounces-187002-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 20EC4BE9FDB
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 17:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7D0C25834B5
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 15:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 851D53370FB;
	Fri, 17 Oct 2025 15:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QoeQV0YO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0901D5CE0;
	Fri, 17 Oct 2025 15:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760714842; cv=none; b=c6BS7W+vFk5E9xEkJcrTtIZFCwN9mvs0s4jDKyiFFqK5Y1cuefqZrgKbLEOEB3fzf+98PizGB2vQn/G1UVft9f6bfABnNKeMDIiBNc/KnDH9GdDaQ1IMrNGwAL/EJiEcZJ9wDXyThGjMIAjg3vDZeyFQRAIy3zg9BiAthJZqW9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760714842; c=relaxed/simple;
	bh=DjdQ6gltIe3UzyC/d/y/QRZnUSPCqsu0vIhI0B9fDYI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IzIwBB9G0bB9PkT9x6Mt/ZZRZrGU5WKEVRyR+HoCBz6d8Djf6D1SbjsjuGktH6ddUN9G09fS0VPQh/+N5+wnHNBhcWBcUnjmWTHnDM7DeQVF2EttvOt/Fv5tdhJaOWXvmtVy2q/ckkBHLIItvU6XQ4I4d1N/pbQiA2qzfivKVYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QoeQV0YO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7B65C113D0;
	Fri, 17 Oct 2025 15:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760714842;
	bh=DjdQ6gltIe3UzyC/d/y/QRZnUSPCqsu0vIhI0B9fDYI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QoeQV0YOzXVxRo0JgXJwWwh2f1fM1LzZkBUi65fbOKCvT10hneHryGtHnAEeRRDRq
	 RsgZQpXU4ONc1KIKvS0nMlL0KsFayRDAopNRXJ5GqZI3ibgmoNOv6+7cYT5Mjw7vmT
	 Nvf5BUxjaTKOmjaNevDLE1WQeAnKoVVwPMBm41Zg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	=?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.12 277/277] ASoC: SOF: ipc4-pcm: fix start offset calculation for chain DMA
Date: Fri, 17 Oct 2025 16:54:44 +0200
Message-ID: <20251017145157.273609930@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017145147.138822285@linuxfoundation.org>
References: <20251017145147.138822285@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kai Vehmanen <kai.vehmanen@linux.intel.com>

commit bace10b59624e6bd8d68bc9304357f292f1b3dcf upstream.

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
Link: https://patch.msgid.link/20251002074719.2084-3-peter.ujfalusi@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/sof/ipc4-pcm.c      |   14 ++++++++++----
 sound/soc/sof/ipc4-topology.c |    1 -
 sound/soc/sof/ipc4-topology.h |    2 ++
 3 files changed, 12 insertions(+), 5 deletions(-)

--- a/sound/soc/sof/ipc4-pcm.c
+++ b/sound/soc/sof/ipc4-pcm.c
@@ -992,7 +992,7 @@ static int sof_ipc4_get_stream_start_off
 		return -EINVAL;
 	} else if (host_copier->data.gtw_cfg.node_id == SOF_IPC4_CHAIN_DMA_NODE_ID) {
 		/*
-		 * While the firmware does not supports time_info reporting for
+		 * While the firmware does not support time_info reporting for
 		 * streams using ChainDMA, it is granted that ChainDMA can only
 		 * be used on Host+Link pairs where the link position is
 		 * accessible from the host side.
@@ -1000,10 +1000,16 @@ static int sof_ipc4_get_stream_start_off
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
 
--- a/sound/soc/sof/ipc4-topology.c
+++ b/sound/soc/sof/ipc4-topology.c
@@ -32,7 +32,6 @@ MODULE_PARM_DESC(ipc4_ignore_cpc,
 
 #define SOF_IPC4_GAIN_PARAM_ID  0
 #define SOF_IPC4_TPLG_ABI_SIZE 6
-#define SOF_IPC4_CHAIN_DMA_BUF_SIZE_MS 2
 
 static DEFINE_IDA(alh_group_ida);
 static DEFINE_IDA(pipeline_ida);
--- a/sound/soc/sof/ipc4-topology.h
+++ b/sound/soc/sof/ipc4-topology.h
@@ -250,6 +250,8 @@ struct sof_ipc4_dma_stream_ch_map {
 #define SOF_IPC4_DMA_METHOD_HDA   1
 #define SOF_IPC4_DMA_METHOD_GPDMA 2 /* defined for consistency but not used */
 
+#define SOF_IPC4_CHAIN_DMA_BUF_SIZE_MS 2
+
 /**
  * struct sof_ipc4_dma_config: DMA configuration
  * @dma_method: HDAudio or GPDMA



