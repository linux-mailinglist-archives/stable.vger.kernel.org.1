Return-Path: <stable+bounces-43283-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B91F18BF157
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E49D1F207BF
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA2012F5BC;
	Tue,  7 May 2024 23:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WNAfPvtA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F5B85649;
	Tue,  7 May 2024 23:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715123289; cv=none; b=KXi9lduLZWOSTl5XDDIsoIWlwqzXtZIavgu5/2mbEOHv/e5JfR3x9oWlCEtmVSpcaeDFNl4FqYAzWttJUj/M5S7ct+UGHgvZhIL+Jsyq8tZuAW89BC/xkwRLHYiTwoLOAu8M+H/9fA44dCEWc4FUwFGnnRkTZJ4OuGket2pZuvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715123289; c=relaxed/simple;
	bh=ZhK1g55UfD4HZULMY7fdHUpuK13tLpuQdiaLIrYBSrM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uCWGOmkOye/8Q+JgPU01+IC4Bnc2xFFGWNrClUOiEOvMOTMTTFCR67Sn0TN6Qdh2edA1YilpeHVbuBI+Fx+MQdfSfaPUxqknZfbT64mj/MfNeQnqH0tINetFIqhAvpCDiHb2k2giPa4FhEg5qPzGlnzK8MhxnufWpaZUaXHZq54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WNAfPvtA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29134C4AF17;
	Tue,  7 May 2024 23:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715123288;
	bh=ZhK1g55UfD4HZULMY7fdHUpuK13tLpuQdiaLIrYBSrM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WNAfPvtAmY7FTzwAFbNfSykaZuJPVsVyxGctl0/RJ9LzYYPXQJg/4BwHcbUaIwqOT
	 lTg5RP3cZfd6JvaX6ET7uxFxe1i0qMpHd0NlNeVmHrTn3h6cue8SyQPlxBEFKrnk7O
	 OgyT6jYAS+5pOauAGeSV6nmaFriatzf4WGTkeVOp1fhtMLSCDKRNsFmovJK5ur3K3j
	 Lb4Ou7G86F/4nD88D3subpR47WUjXsEoMrdL2yotdC7P8t3mQs1ndxUp479dM3HYI7
	 BiSx5IKJrE0RWsgQkzu3MCNbPC92jRqLuhyvKrH02nBULzuAFIAytVqnOiFkf4Bqr4
	 iMnOQKMtOgM3A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	yung-chuan.liao@linux.intel.com,
	daniel.baluta@nxp.com,
	perex@perex.cz,
	tiwai@suse.com,
	sound-open-firmware@alsa-project.org,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 04/52] ASoC: SOF: ipc4-pcm: Use consistent name for snd_sof_pcm_stream pointer
Date: Tue,  7 May 2024 19:06:30 -0400
Message-ID: <20240507230800.392128-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507230800.392128-1-sashal@kernel.org>
References: <20240507230800.392128-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.9
Content-Transfer-Encoding: 8bit

From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>

[ Upstream commit 965e49cdf8c19f21b8308adeded3a8139cff5c84 ]

Throughout the file the pointer for snd_sof_pcm_stream is named either
'stream' or (wrongly) 'spcm' which confuses the reader.

Use 'sps' for the pointer name as it is the most common name used in SOF
codebase.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Link: https://msgid.link/r/20240409110036.9411-2-peter.ujfalusi@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/ipc4-pcm.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/sound/soc/sof/ipc4-pcm.c b/sound/soc/sof/ipc4-pcm.c
index a99fced908251..31133c5dcbf50 100644
--- a/sound/soc/sof/ipc4-pcm.c
+++ b/sound/soc/sof/ipc4-pcm.c
@@ -747,7 +747,7 @@ static int sof_ipc4_pcm_setup(struct snd_sof_dev *sdev, struct snd_sof_pcm *spcm
 	return 0;
 }
 
-static void sof_ipc4_build_time_info(struct snd_sof_dev *sdev, struct snd_sof_pcm_stream *spcm)
+static void sof_ipc4_build_time_info(struct snd_sof_dev *sdev, struct snd_sof_pcm_stream *sps)
 {
 	struct sof_ipc4_copier *host_copier = NULL;
 	struct sof_ipc4_copier *dai_copier = NULL;
@@ -758,7 +758,7 @@ static void sof_ipc4_build_time_info(struct snd_sof_dev *sdev, struct snd_sof_pc
 	int i;
 
 	/* find host & dai to locate info in memory window */
-	for_each_dapm_widgets(spcm->list, i, widget) {
+	for_each_dapm_widgets(sps->list, i, widget) {
 		struct snd_sof_widget *swidget = widget->dobj.private;
 
 		if (!swidget)
@@ -778,7 +778,7 @@ static void sof_ipc4_build_time_info(struct snd_sof_dev *sdev, struct snd_sof_pc
 		return;
 	}
 
-	info = spcm->private;
+	info = sps->private;
 	info->host_copier = host_copier;
 	info->dai_copier = dai_copier;
 	info->llp_offset = offsetof(struct sof_ipc4_fw_registers, llp_gpdma_reading_slots) +
@@ -847,7 +847,7 @@ static int sof_ipc4_pcm_hw_params(struct snd_soc_component *component,
 
 static int sof_ipc4_get_stream_start_offset(struct snd_sof_dev *sdev,
 					    struct snd_pcm_substream *substream,
-					    struct snd_sof_pcm_stream *stream,
+					    struct snd_sof_pcm_stream *sps,
 					    struct sof_ipc4_timestamp_info *time_info)
 {
 	struct sof_ipc4_copier *host_copier = time_info->host_copier;
@@ -901,7 +901,7 @@ static int sof_ipc4_pcm_pointer(struct snd_soc_component *component,
 	struct sof_ipc4_timestamp_info *time_info;
 	struct sof_ipc4_llp_reading_slot llp;
 	snd_pcm_uframes_t head_cnt, tail_cnt;
-	struct snd_sof_pcm_stream *stream;
+	struct snd_sof_pcm_stream *sps;
 	u64 dai_cnt, host_cnt, host_ptr;
 	struct snd_sof_pcm *spcm;
 	int ret;
@@ -910,8 +910,8 @@ static int sof_ipc4_pcm_pointer(struct snd_soc_component *component,
 	if (!spcm)
 		return -EOPNOTSUPP;
 
-	stream = &spcm->stream[substream->stream];
-	time_info = stream->private;
+	sps = &spcm->stream[substream->stream];
+	time_info = sps->private;
 	if (!time_info)
 		return -EOPNOTSUPP;
 
@@ -921,7 +921,7 @@ static int sof_ipc4_pcm_pointer(struct snd_soc_component *component,
 	 * the statistics is complete. And it will not change after the first initiailization.
 	 */
 	if (time_info->stream_start_offset == SOF_IPC4_INVALID_STREAM_POSITION) {
-		ret = sof_ipc4_get_stream_start_offset(sdev, substream, stream, time_info);
+		ret = sof_ipc4_get_stream_start_offset(sdev, substream, sps, time_info);
 		if (ret < 0)
 			return -EOPNOTSUPP;
 	}
@@ -1013,15 +1013,15 @@ static snd_pcm_sframes_t sof_ipc4_pcm_delay(struct snd_soc_component *component,
 {
 	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
 	struct sof_ipc4_timestamp_info *time_info;
-	struct snd_sof_pcm_stream *stream;
+	struct snd_sof_pcm_stream *sps;
 	struct snd_sof_pcm *spcm;
 
 	spcm = snd_sof_find_spcm_dai(component, rtd);
 	if (!spcm)
 		return 0;
 
-	stream = &spcm->stream[substream->stream];
-	time_info = stream->private;
+	sps = &spcm->stream[substream->stream];
+	time_info = sps->private;
 	/*
 	 * Report the stored delay value calculated in the pointer callback.
 	 * In the unlikely event that the calculation was skipped/aborted, the
-- 
2.43.0


