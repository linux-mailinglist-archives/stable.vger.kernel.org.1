Return-Path: <stable+bounces-58903-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6795592C161
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 18:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D08928367D
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 16:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC561ABCC1;
	Tue,  9 Jul 2024 16:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="THq/p2Ug"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272901B30B6;
	Tue,  9 Jul 2024 16:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720542436; cv=none; b=Yo5wzoxP41D7ZqE74aiRb/oHroQl9AomnhPMMoit1CmcbfH7TgGien+2LPpD0c+tqDDUUfzpK5JLW/pXgWloWXEsD3ZMn6iKAtl/WyryU2+pokRDGYHFYeVeyuGSix2jfQNSF/nt9h7B6qgF7TuB+UqWYz8bvm36YDzxN1D5plc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720542436; c=relaxed/simple;
	bh=732bN4KdmSVKcisJi/1JjB7K1hRzj/CZchUVruxaRhU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hXuiHuh+TAlIb9Q7CUEy/wGpB3tg+J7/NC+h8e6SuumeXb8elmzLUr/GFq24qlQAZ8kVCGaXiLEGQlMRjtLrPpB1CTU7VN216/x0qdkXn3Y5t+39A28xUd2QtHs6YiF92BcfVD1nb6UNohWcz/DSQ3Kybgs/MZaDKMSpfbQhrbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=THq/p2Ug; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC2EEC4AF07;
	Tue,  9 Jul 2024 16:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720542435;
	bh=732bN4KdmSVKcisJi/1JjB7K1hRzj/CZchUVruxaRhU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=THq/p2UgYxnyVSBeHJbS/ZyvEGNXkeBZzkcXPMV0SpbpaIU/xR9rBYmIY32C4NxDL
	 MJuuxZWdOg+IvWGMDmxtiwpBqbGjqHW3LyMgVcnR9DNQHSgTwduxQ+4cLvd+wVNVSM
	 rRoJ5SKLM9V4HSNv9ItP2yx5r0sXF6jV1eNHmu4Fua2zQyOsNp+Tdi5tRxe4MNRvcz
	 0a58ssumZB3T2OG9wikW7D6yFnsW1Jr8cxOwJB3ixGqHhIaQZ6FvGZiulkh7wIMDyv
	 h80juerETpkc9JM3lYgZY3iTsnfU7pbC3fnoRPtkQ37tIZmnZLhi7BmwQIErHOQg+n
	 x+SepapQlvvKQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	lars@metafoo.de,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 10/11] ALSA: dmaengine_pcm: terminate dmaengine before synchronize
Date: Tue,  9 Jul 2024 12:26:43 -0400
Message-ID: <20240709162654.33343-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240709162654.33343-1-sashal@kernel.org>
References: <20240709162654.33343-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.279
Content-Transfer-Encoding: 8bit

From: Shengjiu Wang <shengjiu.wang@nxp.com>

[ Upstream commit 6a7db25aad8ce6512b366d2ce1d0e60bac00a09d ]

When dmaengine supports pause function, in suspend state,
dmaengine_pause() is called instead of dmaengine_terminate_async(),

In end of playback stream, the runtime->state will go to
SNDRV_PCM_STATE_DRAINING, if system suspend & resume happen
at this time, application will not resume playback stream, the
stream will be closed directly, the dmaengine_terminate_async()
will not be called before the dmaengine_synchronize(), which
violates the call sequence for dmaengine_synchronize().

This behavior also happens for capture streams, but there is no
SNDRV_PCM_STATE_DRAINING state for capture. So use
dmaengine_tx_status() to check the DMA status if the status is
DMA_PAUSED, then call dmaengine_terminate_async() to terminate
dmaengine before dmaengine_synchronize().

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Link: https://patch.msgid.link/1718851218-27803-1-git-send-email-shengjiu.wang@nxp.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/core/pcm_dmaengine.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sound/core/pcm_dmaengine.c b/sound/core/pcm_dmaengine.c
index 5d9a24ca6f3ec..6c0d0a43baa11 100644
--- a/sound/core/pcm_dmaengine.c
+++ b/sound/core/pcm_dmaengine.c
@@ -345,6 +345,12 @@ EXPORT_SYMBOL_GPL(snd_dmaengine_pcm_open_request_chan);
 int snd_dmaengine_pcm_close(struct snd_pcm_substream *substream)
 {
 	struct dmaengine_pcm_runtime_data *prtd = substream_to_prtd(substream);
+	struct dma_tx_state state;
+	enum dma_status status;
+
+	status = dmaengine_tx_status(prtd->dma_chan, prtd->cookie, &state);
+	if (status == DMA_PAUSED)
+		dmaengine_terminate_async(prtd->dma_chan);
 
 	dmaengine_synchronize(prtd->dma_chan);
 	kfree(prtd);
@@ -362,6 +368,12 @@ EXPORT_SYMBOL_GPL(snd_dmaengine_pcm_close);
 int snd_dmaengine_pcm_close_release_chan(struct snd_pcm_substream *substream)
 {
 	struct dmaengine_pcm_runtime_data *prtd = substream_to_prtd(substream);
+	struct dma_tx_state state;
+	enum dma_status status;
+
+	status = dmaengine_tx_status(prtd->dma_chan, prtd->cookie, &state);
+	if (status == DMA_PAUSED)
+		dmaengine_terminate_async(prtd->dma_chan);
 
 	dmaengine_synchronize(prtd->dma_chan);
 	dma_release_channel(prtd->dma_chan);
-- 
2.43.0


