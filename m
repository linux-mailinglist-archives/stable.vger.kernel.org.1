Return-Path: <stable+bounces-58877-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E8492C107
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 18:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 310021F22B84
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 16:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E6C19249D;
	Tue,  9 Jul 2024 16:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DS/U8h38"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E942192495;
	Tue,  9 Jul 2024 16:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720542351; cv=none; b=Oj1Zc9DBnXN0Zwj+BsIJ9M+ee2FS8cYgw/gt44Mwk7MTmgzSyOEbGj9XxQwHxjfYVnvCR9iub7cSraGV+mVeqJpBIjX7/pxsR93IQdD7Zb3Jx/QwMm7aEFyMlA7Bm0aBwjm38S1d2Za4Dq6VUYfclQ9txp26oe7dphCEFwvXIJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720542351; c=relaxed/simple;
	bh=43uQ+ReS2KRJiDZmBqZCfBhkvVVgCmazL3D70yVZ1v0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ktd74lwSYLlGZI8zJIdffSd1d8rQ6NZphXKnb7Oa40s2+b3+Svtrr5bF29z17uFXMJt3JSayec7QoiMH/GUrmILBGL7yDg3YjBhpHa0G0O+GCh4HtWYRWZ4au/c7RG/biX0rkrZc9FnEkn3UJAWb93rhAD8UmihJWSOxOGq4GpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DS/U8h38; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E372C32782;
	Tue,  9 Jul 2024 16:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720542351;
	bh=43uQ+ReS2KRJiDZmBqZCfBhkvVVgCmazL3D70yVZ1v0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DS/U8h38vQmiGt6KuUXbjdewht3CGNRzRWqJC+KNAoNVTTqJ5vhmjor0BQYsKkzhi
	 eYXZsVn9gpuSqr53gjQAeFhV6UsO1K9t1xLudv/lH3mgQafKfFg0MmhFTIrNNIDpn3
	 DCxCGF3UI7M5NN9D/wyf8pqdo/kWu2dqHCh5/cI8RG/nR9lX9LGbsg2cSKergfwsmX
	 wTpZYOrAcawX3B1TXmRY1g5nL6VEfWGJydpEie4BWJ7m7UNzcj4pn17mJRTubDrdQZ
	 SnP2FmxLUjV7un6vog1mLS1N6MwgLPliiWd/kst66Y3WhQN8jPoLzrAIKouF7d3GFX
	 TW+1R0hCe1HrA==
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
Subject: [PATCH AUTOSEL 5.15 15/17] ALSA: dmaengine_pcm: terminate dmaengine before synchronize
Date: Tue,  9 Jul 2024 12:24:59 -0400
Message-ID: <20240709162517.32584-15-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240709162517.32584-1-sashal@kernel.org>
References: <20240709162517.32584-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.162
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
index 3e479dca122a0..9f953ff8b0645 100644
--- a/sound/core/pcm_dmaengine.c
+++ b/sound/core/pcm_dmaengine.c
@@ -361,6 +361,12 @@ EXPORT_SYMBOL_GPL(snd_dmaengine_pcm_sync_stop);
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
@@ -379,6 +385,12 @@ EXPORT_SYMBOL_GPL(snd_dmaengine_pcm_close);
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


