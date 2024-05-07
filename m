Return-Path: <stable+bounces-43284-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F23B08BF159
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8D4D286C9A
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F3C130487;
	Tue,  7 May 2024 23:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mxa1CFTN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B3C12FF94;
	Tue,  7 May 2024 23:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715123291; cv=none; b=UtMagSrRLVE0VDM3o2j9fgGjgYp+ZRehLED0uEOWyk6BYW0DLYiT558BN8boDGh2R5793URL1/qsihi0oriqzDdkSBBWyYWD9h6jErWbOKZWGTDr3PrbpvDHjFbEK8TVflSsVJCrMH8V8Z7gdr6WG9mYWQwhjbTC7vZbWmidH30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715123291; c=relaxed/simple;
	bh=fMZL4RoHbvrnjWzJxqjWKAOYDH7W6GHNI90xcTP36aA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GZNvQeTM312duk9xNDoNi/NEqz7gcILY9bBRtP0tgBWgJYPqgpjnf/6kkTE8mrYw1xxXcEB3O09oe8Pyjz8sq2mx0CzRSKGii2JwpQ3D2mxH+3JUI+EmcyNTTvB9If2gk8qd2VqUaiEZTVKY69xWmK40i3/VILFo0zMh/7GNpgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mxa1CFTN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24B12C3277B;
	Tue,  7 May 2024 23:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715123290;
	bh=fMZL4RoHbvrnjWzJxqjWKAOYDH7W6GHNI90xcTP36aA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mxa1CFTNAY/gAISK7GnOWg6WtCqlQK/HteshZPemZEJNDYfJH70sX7/cOiKayxa5z
	 IAmwvvt5MhrXqv9EtoMFlfitXelXOXRrO8H4XzBUFX+YkhWBfnRO84I5bVu/O+d0Lb
	 rzbJHxQwIYeNOtV60fUUOrSpmDFhpsl14oQU2pIggzP/oEiJKzXoSyH2JvsuFo8sAK
	 bU9iwe/YhqOcpthx+ZM9cCp86hThlEtwrwZPckUColFHX3LgYHvTPA8AAIPxoitidw
	 j21gTGLsG6veeFVv0TD8QZ1vCeW+gU8F4e+OZMxdUb7UFBqWyoPhnyLccuQynX82zH
	 kugl6RCyMEa+A==
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
Subject: [PATCH AUTOSEL 6.8 05/52] ASoC: SOF: ipc4-pcm: Use consistent name for sof_ipc4_timestamp_info pointer
Date: Tue,  7 May 2024 19:06:31 -0400
Message-ID: <20240507230800.392128-5-sashal@kernel.org>
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

[ Upstream commit 36e980050b0733829e4e0f97b97f7907ba9f00bb ]

The pointer to sof_ipc4_timestamp_info named most of the time as
'time_info' only to be named as 'stream_info' or 'info' in two function.

Use the consistent name of 'time_info' throughout the file.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Link: https://msgid.link/r/20240409110036.9411-3-peter.ujfalusi@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/ipc4-pcm.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/sound/soc/sof/ipc4-pcm.c b/sound/soc/sof/ipc4-pcm.c
index 31133c5dcbf50..3f8b9443496ce 100644
--- a/sound/soc/sof/ipc4-pcm.c
+++ b/sound/soc/sof/ipc4-pcm.c
@@ -704,7 +704,7 @@ static int sof_ipc4_pcm_setup(struct snd_sof_dev *sdev, struct snd_sof_pcm *spcm
 {
 	struct snd_sof_pcm_stream_pipeline_list *pipeline_list;
 	struct sof_ipc4_fw_data *ipc4_data = sdev->private;
-	struct sof_ipc4_timestamp_info *stream_info;
+	struct sof_ipc4_timestamp_info *time_info;
 	bool support_info = true;
 	u32 abi_version;
 	u32 abi_offset;
@@ -735,13 +735,13 @@ static int sof_ipc4_pcm_setup(struct snd_sof_dev *sdev, struct snd_sof_pcm *spcm
 		if (!support_info)
 			continue;
 
-		stream_info = kzalloc(sizeof(*stream_info), GFP_KERNEL);
-		if (!stream_info) {
+		time_info = kzalloc(sizeof(*time_info), GFP_KERNEL);
+		if (!time_info) {
 			sof_ipc4_pcm_free(sdev, spcm);
 			return -ENOMEM;
 		}
 
-		spcm->stream[stream].private = stream_info;
+		spcm->stream[stream].private = time_info;
 	}
 
 	return 0;
@@ -752,7 +752,7 @@ static void sof_ipc4_build_time_info(struct snd_sof_dev *sdev, struct snd_sof_pc
 	struct sof_ipc4_copier *host_copier = NULL;
 	struct sof_ipc4_copier *dai_copier = NULL;
 	struct sof_ipc4_llp_reading_slot llp_slot;
-	struct sof_ipc4_timestamp_info *info;
+	struct sof_ipc4_timestamp_info *time_info;
 	struct snd_soc_dapm_widget *widget;
 	struct snd_sof_dai *dai;
 	int i;
@@ -778,44 +778,44 @@ static void sof_ipc4_build_time_info(struct snd_sof_dev *sdev, struct snd_sof_pc
 		return;
 	}
 
-	info = sps->private;
-	info->host_copier = host_copier;
-	info->dai_copier = dai_copier;
-	info->llp_offset = offsetof(struct sof_ipc4_fw_registers, llp_gpdma_reading_slots) +
-				    sdev->fw_info_box.offset;
+	time_info = sps->private;
+	time_info->host_copier = host_copier;
+	time_info->dai_copier = dai_copier;
+	time_info->llp_offset = offsetof(struct sof_ipc4_fw_registers,
+					 llp_gpdma_reading_slots) + sdev->fw_info_box.offset;
 
 	/* find llp slot used by current dai */
 	for (i = 0; i < SOF_IPC4_MAX_LLP_GPDMA_READING_SLOTS; i++) {
-		sof_mailbox_read(sdev, info->llp_offset, &llp_slot, sizeof(llp_slot));
+		sof_mailbox_read(sdev, time_info->llp_offset, &llp_slot, sizeof(llp_slot));
 		if (llp_slot.node_id == dai_copier->data.gtw_cfg.node_id)
 			break;
 
-		info->llp_offset += sizeof(llp_slot);
+		time_info->llp_offset += sizeof(llp_slot);
 	}
 
 	if (i < SOF_IPC4_MAX_LLP_GPDMA_READING_SLOTS)
 		return;
 
 	/* if no llp gpdma slot is used, check aggregated sdw slot */
-	info->llp_offset = offsetof(struct sof_ipc4_fw_registers, llp_sndw_reading_slots) +
-					sdev->fw_info_box.offset;
+	time_info->llp_offset = offsetof(struct sof_ipc4_fw_registers,
+					 llp_sndw_reading_slots) + sdev->fw_info_box.offset;
 	for (i = 0; i < SOF_IPC4_MAX_LLP_SNDW_READING_SLOTS; i++) {
-		sof_mailbox_read(sdev, info->llp_offset, &llp_slot, sizeof(llp_slot));
+		sof_mailbox_read(sdev, time_info->llp_offset, &llp_slot, sizeof(llp_slot));
 		if (llp_slot.node_id == dai_copier->data.gtw_cfg.node_id)
 			break;
 
-		info->llp_offset += sizeof(llp_slot);
+		time_info->llp_offset += sizeof(llp_slot);
 	}
 
 	if (i < SOF_IPC4_MAX_LLP_SNDW_READING_SLOTS)
 		return;
 
 	/* check EVAD slot */
-	info->llp_offset = offsetof(struct sof_ipc4_fw_registers, llp_evad_reading_slot) +
-					sdev->fw_info_box.offset;
-	sof_mailbox_read(sdev, info->llp_offset, &llp_slot, sizeof(llp_slot));
+	time_info->llp_offset = offsetof(struct sof_ipc4_fw_registers,
+					 llp_evad_reading_slot) + sdev->fw_info_box.offset;
+	sof_mailbox_read(sdev, time_info->llp_offset, &llp_slot, sizeof(llp_slot));
 	if (llp_slot.node_id != dai_copier->data.gtw_cfg.node_id)
-		info->llp_offset = 0;
+		time_info->llp_offset = 0;
 }
 
 static int sof_ipc4_pcm_hw_params(struct snd_soc_component *component,
-- 
2.43.0


