Return-Path: <stable+bounces-88991-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC319B2D72
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 11:53:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D42B3281AEC
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 10:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18F81D63C2;
	Mon, 28 Oct 2024 10:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TJjqsZ87"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E3E1DAC9A;
	Mon, 28 Oct 2024 10:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730112680; cv=none; b=Rjdh8xSIp/Gqqa/eeE//yXSQijepvdWLy6HBtDJUKfMEba/pK54xEpbT39vDS1+L/p5mIQsoxA3Kr3bDfExKgutHkjf36WlyWYQAq20f/+fMM/0JT8aUKiVU3xNNLC3xFXq/XU//+WqwiW4YJF++uuaKrlQGQE5ImPjqenK2/Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730112680; c=relaxed/simple;
	bh=jrYaQfzl4oeGEUwkbYxrHCuxMLpkITPsbBebxD6qeRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vlm8d1zLvNCDsm4xG6kZfVee7MVG671uwqVfVNfX13pNb1OUKapSviZ7m4HjXmU82pYIJX9kuSymJqAaAKjPTUez/Ac4WU6KI1O4meDgLJugFHVLl7qbNmJVDio/P3XfrYgTByX3mn8IyFUmwhsZFmFvYZBbV6gE2syvQQeqqKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TJjqsZ87; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81A7CC4CEC3;
	Mon, 28 Oct 2024 10:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730112680;
	bh=jrYaQfzl4oeGEUwkbYxrHCuxMLpkITPsbBebxD6qeRk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TJjqsZ87ouedag3Zq0ViiPUlGv2S66b082GgXP7R/55/hLgDzZ9fafBAJ4E8Lp5nF
	 X2wKsm68TPnMa6/kssGxoo7VfDhBweiBq6hHRCRBkjD8GUOhetXOkouzGpliIU82zo
	 tD1AGc5ER7N4/eQHlYEMdf72CTN/NqGRQ0Ip5mDStqe0DzGt8a1Bw+s/Rc/bEddi+y
	 zyOQFd+s9FivoZouOB5FGg6I1jfRmfjDdOqzgvZFn9PRNgfVal8OMTVzA5sSfn6uNf
	 olyrZa0vq8lOg6x2Gm+4jDu41XN9ypvltXpukG7Mjao5Q7t6QzkUzhv9IknVWn68yQ
	 T6meGkjqtoX5A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	=?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	daniel.baluta@nxp.com,
	perex@perex.cz,
	tiwai@suse.com,
	pierre-louis.bossart@linux.dev,
	cezary.rojewski@intel.com,
	sound-open-firmware@alsa-project.org,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 09/32] ASoC: SOF: Intel: hda: Always clean up link DMA during stop
Date: Mon, 28 Oct 2024 06:49:51 -0400
Message-ID: <20241028105050.3559169-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241028105050.3559169-1-sashal@kernel.org>
References: <20241028105050.3559169-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.5
Content-Transfer-Encoding: 8bit

From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>

[ Upstream commit ab5593793e9088abcddce30ba8e376e31b7285fd ]

This is required to reset the DMA read/write pointers when the stream is
prepared and restarted after a call to snd_pcm_drain()/snd_pcm_drop().
Also, now that the stream is reset during stop, do not save LLP registers
in the case of STOP/suspend to avoid erroneous delay reporting.

Link: https://github.com/thesofproject/sof/issues/9502
Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
All: stable@vger.kernel.org # 6.10.x 6.11.x
Link: https://patch.msgid.link/20241016032910.14601-5-yung-chuan.liao@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/intel/hda-dai-ops.c | 23 ++++++++++-------------
 sound/soc/sof/intel/hda-dai.c     |  1 +
 2 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/sound/soc/sof/intel/hda-dai-ops.c b/sound/soc/sof/intel/hda-dai-ops.c
index 484c761478853..92681ca7f24de 100644
--- a/sound/soc/sof/intel/hda-dai-ops.c
+++ b/sound/soc/sof/intel/hda-dai-ops.c
@@ -346,20 +346,21 @@ static int hda_trigger(struct snd_sof_dev *sdev, struct snd_soc_dai *cpu_dai,
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 		snd_hdac_ext_stream_start(hext_stream);
 		break;
-	case SNDRV_PCM_TRIGGER_SUSPEND:
-	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
-		snd_hdac_ext_stream_clear(hext_stream);
-
 		/*
-		 * Save the LLP registers in case the stream is
-		 * restarting due PAUSE_RELEASE, or START without a pcm
-		 * close/open since in this case the LLP register is not reset
-		 * to 0 and the delay calculation will return with invalid
-		 * results.
+		 * Save the LLP registers since in case of PAUSE the LLP
+		 * register are not reset to 0, the delay calculation will use
+		 * the saved offsets for compensating the delay calculation.
 		 */
 		hext_stream->pplcllpl = readl(hext_stream->pplc_addr + AZX_REG_PPLCLLPL);
 		hext_stream->pplcllpu = readl(hext_stream->pplc_addr + AZX_REG_PPLCLLPU);
+		snd_hdac_ext_stream_clear(hext_stream);
+		break;
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_STOP:
+		hext_stream->pplcllpl = 0;
+		hext_stream->pplcllpu = 0;
+		snd_hdac_ext_stream_clear(hext_stream);
 		break;
 	default:
 		dev_err(sdev->dev, "unknown trigger command %d\n", cmd);
@@ -512,7 +513,6 @@ static const struct hda_dai_widget_dma_ops sdw_ipc4_chain_dma_ops = {
 static int hda_ipc3_post_trigger(struct snd_sof_dev *sdev, struct snd_soc_dai *cpu_dai,
 				 struct snd_pcm_substream *substream, int cmd)
 {
-	struct hdac_ext_stream *hext_stream = hda_get_hext_stream(sdev, cpu_dai, substream);
 	struct snd_soc_dapm_widget *w = snd_soc_dai_get_widget(cpu_dai, substream->stream);
 
 	switch (cmd) {
@@ -527,9 +527,6 @@ static int hda_ipc3_post_trigger(struct snd_sof_dev *sdev, struct snd_soc_dai *c
 		if (ret < 0)
 			return ret;
 
-		if (cmd == SNDRV_PCM_TRIGGER_STOP)
-			return hda_link_dma_cleanup(substream, hext_stream, cpu_dai);
-
 		break;
 	}
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
diff --git a/sound/soc/sof/intel/hda-dai.c b/sound/soc/sof/intel/hda-dai.c
index 8cccf38967e72..ac505c7ad3429 100644
--- a/sound/soc/sof/intel/hda-dai.c
+++ b/sound/soc/sof/intel/hda-dai.c
@@ -302,6 +302,7 @@ static int __maybe_unused hda_dai_trigger(struct snd_pcm_substream *substream, i
 	}
 
 	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_SUSPEND:
 		ret = hda_link_dma_cleanup(substream, hext_stream, dai);
 		if (ret < 0) {
-- 
2.43.0


