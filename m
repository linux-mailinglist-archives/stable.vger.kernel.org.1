Return-Path: <stable+bounces-58832-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C8F92C085
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 18:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91E5E1F23BF9
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 16:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5351CFD52;
	Tue,  9 Jul 2024 16:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z/3Ko7JX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8EA1CFD4A;
	Tue,  9 Jul 2024 16:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720542211; cv=none; b=ZQYwCd4PJlIPSMYwmFIcsLqTKHYpDl0u+nzpz8B/4KitNzdxij2MJAM3hyT3AQgY8zlP/3+rRSOBC7bmgtvKFx4w7XoeZoaeVqA49AZiEnPJG7PMjrZYitbzSFHacD3Abq0FXwJFOnHpKkUINzFHtNNoKVokTnSUusCIeKz2lWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720542211; c=relaxed/simple;
	bh=fiiDAM/QxgHfwMHerXyYhOSUr1/+hLhF8DPS43KJCIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o3fbpU6aNWeLh74JwotoAW2Hd2Fc8CMOVjKvdlGtmF0GO9tE92g4Dc8yxtQE1N3wx+zi1UuWKVfOzG5mh7ZH5pUgGzB92NN9yEgMOeghdHKqIqZNBs+H98ZiGo/rES1WEsS/D+eBp3Mbomkv2+tSV1++Fgvl9crEhRrjdvsz6nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z/3Ko7JX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7172C32786;
	Tue,  9 Jul 2024 16:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720542210;
	bh=fiiDAM/QxgHfwMHerXyYhOSUr1/+hLhF8DPS43KJCIo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z/3Ko7JXlB5U9SNv8DrFGoQt50k4tJcmoSCARGNiSzwsbcJ5GmgtUtCEccHJuKKUI
	 +h34IULbbQuXJGMuEmX9v9lZaIQxTQ93D+QMY4uwlU+0j+pzYMtkV2Gl/KS0L9b59u
	 f3Gwr5IyeXgEOueXgjpNxhYmdcXmgxpr6YrigwF51CvJCd+TJnG1oc1KcRHaFnQuvZ
	 cQxS3qe/N4azAVY68XfEAl806WX8Bt86DLzrOegesxmI7ae3+zz6qC1q7ODSlKNEzO
	 +f97jj0UQlCRz5TByJz7Ku7FlETU8PfzZNWDqqXmOfhCf+PZXT3bOfPw7J+Cb58Vzi
	 RVZD8rqyyjwcw==
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
Subject: [PATCH AUTOSEL 6.6 30/33] ALSA: dmaengine_pcm: terminate dmaengine before synchronize
Date: Tue,  9 Jul 2024 12:21:56 -0400
Message-ID: <20240709162224.31148-30-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240709162224.31148-1-sashal@kernel.org>
References: <20240709162224.31148-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.38
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
index d142609570347..e299e8634751f 100644
--- a/sound/core/pcm_dmaengine.c
+++ b/sound/core/pcm_dmaengine.c
@@ -368,6 +368,12 @@ EXPORT_SYMBOL_GPL(snd_dmaengine_pcm_sync_stop);
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
@@ -388,6 +394,12 @@ EXPORT_SYMBOL_GPL(snd_dmaengine_pcm_close);
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


