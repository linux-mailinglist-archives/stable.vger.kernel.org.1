Return-Path: <stable+bounces-58866-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA74592C0E9
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 18:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB9B91C22485
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 16:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED97718C167;
	Tue,  9 Jul 2024 16:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nnm0ALZN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60551A2FD6;
	Tue,  9 Jul 2024 16:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720542328; cv=none; b=tSEDipsEjsdT93gJuThPYrRVon0BenygaOeQNDHS7W8ObJQRiM8FHC5TroTl4Gg99ar5q7az77pKFWo7LoimGuxfUK19dz7kbbsVkYdcLGjyrkLnG+zJpWOCF1iwn5U1QcIRhjjT210ewm7kDtnjBBQniBFfARRK80MK0ww32AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720542328; c=relaxed/simple;
	bh=a9WcE/tbIP7gjG1RSqi1GYE8Sbvz4tjxdQ8++NDdFak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W3rBIP2Euq6zO9CdDOsjjZB/ayrEQNXe+5LUji1Hz9FMHX7SIsxn2hc6cnIWOZNcowUAU9wUvs497B0f83kLTqASxClv52l2g4ml3ctxbvaArL6bHotrkC/ljmYD3NUsi5DulJcp3zOBDRXRTgzfXm/9I0xPAK93uP94V8fvooM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nnm0ALZN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A9C2C3277B;
	Tue,  9 Jul 2024 16:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720542328;
	bh=a9WcE/tbIP7gjG1RSqi1GYE8Sbvz4tjxdQ8++NDdFak=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nnm0ALZNJppfbTnhpc+sR91OR1RMpxihBRMZd5W/rJARZkj/Jo2/muSNL1jRUL11v
	 Ue4TvUz8ODagy4oeyOPAdbiB1iMR7s0grFaWYXpVHON0luG6RlPttr4fquDsz0HUL/
	 5rdB7/FzSlHRlZP6eHIQ7thKAR0PDsoPATKKAAyfUjtu/gld5UFmKgz7sjPlpB/yYd
	 zRmCV9ImckPX9Kh5j0KJFQEfCZfBqYnvIly3NoplTu9U7iaFMe6Lqs+b2h5Q+AegPe
	 FNkZd2EUySw4ZycAenmmCSjRG3PA+f17YUMGnGygaTxfItPENDDhyWrvK4tqmSReFG
	 fowdTDabTNPQw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jai Luthra <j-luthra@ti.com>,
	Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lars@metafoo.de,
	perex@perex.cz,
	tiwai@suse.com,
	lgirdwood@gmail.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 04/17] ALSA: dmaengine: Synchronize dma channel after drop()
Date: Tue,  9 Jul 2024 12:24:48 -0400
Message-ID: <20240709162517.32584-4-sashal@kernel.org>
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

From: Jai Luthra <j-luthra@ti.com>

[ Upstream commit e8343410ddf08fc36a9b9cc7c51a4e53a262d4c6 ]

Sometimes the stream may be stopped due to XRUN events, in which case
the userspace can call snd_pcm_drop() and snd_pcm_prepare() to stop and
start the stream again.

In these cases, we must wait for the DMA channel to synchronize before
marking the stream as prepared for playback, as the DMA channel gets
stopped by drop() without any synchronization. Make sure the ALSA core
synchronizes the DMA channel by adding a sync_stop() hook.

Reviewed-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>
Signed-off-by: Jai Luthra <j-luthra@ti.com>
Link: https://lore.kernel.org/r/20240611-asoc_next-v3-1-fcfd84b12164@ti.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/sound/dmaengine_pcm.h         |  1 +
 sound/core/pcm_dmaengine.c            | 10 ++++++++++
 sound/soc/soc-generic-dmaengine-pcm.c |  8 ++++++++
 3 files changed, 19 insertions(+)

diff --git a/include/sound/dmaengine_pcm.h b/include/sound/dmaengine_pcm.h
index 96666efddb396..6d9c94a570733 100644
--- a/include/sound/dmaengine_pcm.h
+++ b/include/sound/dmaengine_pcm.h
@@ -34,6 +34,7 @@ snd_pcm_uframes_t snd_dmaengine_pcm_pointer_no_residue(struct snd_pcm_substream
 int snd_dmaengine_pcm_open(struct snd_pcm_substream *substream,
 	struct dma_chan *chan);
 int snd_dmaengine_pcm_close(struct snd_pcm_substream *substream);
+int snd_dmaengine_pcm_sync_stop(struct snd_pcm_substream *substream);
 
 int snd_dmaengine_pcm_open_request_chan(struct snd_pcm_substream *substream,
 	dma_filter_fn filter_fn, void *filter_data);
diff --git a/sound/core/pcm_dmaengine.c b/sound/core/pcm_dmaengine.c
index 0fe93b423c4ed..3e479dca122a0 100644
--- a/sound/core/pcm_dmaengine.c
+++ b/sound/core/pcm_dmaengine.c
@@ -344,6 +344,16 @@ int snd_dmaengine_pcm_open_request_chan(struct snd_pcm_substream *substream,
 }
 EXPORT_SYMBOL_GPL(snd_dmaengine_pcm_open_request_chan);
 
+int snd_dmaengine_pcm_sync_stop(struct snd_pcm_substream *substream)
+{
+	struct dmaengine_pcm_runtime_data *prtd = substream_to_prtd(substream);
+
+	dmaengine_synchronize(prtd->dma_chan);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_dmaengine_pcm_sync_stop);
+
 /**
  * snd_dmaengine_pcm_close - Close a dmaengine based PCM substream
  * @substream: PCM substream
diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
index 4aa48c74f21a0..fa1f91c34834f 100644
--- a/sound/soc/soc-generic-dmaengine-pcm.c
+++ b/sound/soc/soc-generic-dmaengine-pcm.c
@@ -323,6 +323,12 @@ static int dmaengine_copy_user(struct snd_soc_component *component,
 	return 0;
 }
 
+static int dmaengine_pcm_sync_stop(struct snd_soc_component *component,
+				   struct snd_pcm_substream *substream)
+{
+	return snd_dmaengine_pcm_sync_stop(substream);
+}
+
 static const struct snd_soc_component_driver dmaengine_pcm_component = {
 	.name		= SND_DMAENGINE_PCM_DRV_NAME,
 	.probe_order	= SND_SOC_COMP_ORDER_LATE,
@@ -332,6 +338,7 @@ static const struct snd_soc_component_driver dmaengine_pcm_component = {
 	.trigger	= dmaengine_pcm_trigger,
 	.pointer	= dmaengine_pcm_pointer,
 	.pcm_construct	= dmaengine_pcm_new,
+	.sync_stop	= dmaengine_pcm_sync_stop,
 };
 
 static const struct snd_soc_component_driver dmaengine_pcm_component_process = {
@@ -344,6 +351,7 @@ static const struct snd_soc_component_driver dmaengine_pcm_component_process = {
 	.pointer	= dmaengine_pcm_pointer,
 	.copy_user	= dmaengine_copy_user,
 	.pcm_construct	= dmaengine_pcm_new,
+	.sync_stop	= dmaengine_pcm_sync_stop,
 };
 
 static const char * const dmaengine_pcm_dma_channel_names[] = {
-- 
2.43.0


