Return-Path: <stable+bounces-43285-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0998BF15B
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:23:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E39DC281F47
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B25130A50;
	Tue,  7 May 2024 23:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zq2Vro5w"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED4F13049B;
	Tue,  7 May 2024 23:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715123292; cv=none; b=TRtlcPuAOKFhg5MzKTSC+/cbUO4w+DFDmJYGbM+1RPjxNfbpLOMUcr2ZLyf8byLlhjYAkuZAK2mT8zJDOfOqvPb4nwJ7CO1EZIerzRGFJ7zKiXqWYMNp4JH3HdRXqv9C3GP+2GLULcXioLifKseOMuBrsbLBv1lpDWKUcEz3KTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715123292; c=relaxed/simple;
	bh=mtqQA7fM03lbyP9x4PeuiVSY0upO+p2prgw7qKIBwBY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R+Y0gUxNHuULuyPyWqyq6+wCIBdqwfrC2+1JH3XPZec0CMNDLff+1Y31ylXAdSHIKmApz27a/HwcFw+jiwUeWxEakUCTMxPWyYqshW6vm406Mn3XxKtZ/JDfGkX7KX9OxeGPZPmhv+dK78gqfTet8Dx3IFBzJYfYB5EMiPDZTyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zq2Vro5w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A4E2C4AF63;
	Tue,  7 May 2024 23:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715123292;
	bh=mtqQA7fM03lbyP9x4PeuiVSY0upO+p2prgw7qKIBwBY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zq2Vro5wm5G8xmqtAC7bJzU8Dq3lcmXSTNSixPZAZ8fJAixEaDNc8uaX+XAkmsUyD
	 B9vtdKaf7Ig6yCjnP2NjdRguwHOAHLsfjpEK/1/LUYS39rHWR332aKRlqyjrDkIoTM
	 DV0oue8yjp6wGM0nif5amaLxawpstxAbqIll/K3LyJZ5W7lFnJK3Ux5fMsSfNAkM8V
	 ppHhyNFdvsbkZHROSMx6aqiHO4o2sM+4f3rJEKLdlXSy7r3DnqLy/Zzdfy0DZoItBE
	 5rmIHbzTODhipDhzUKJegBd8M5dTZTbybM4pVdsnzQ+3kJKvVyDf+dIH66qAdytVuG
	 YywcJI4DCkXCw==
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
Subject: [PATCH AUTOSEL 6.8 06/52] ASoC: SOF: ipc4-pcm: Introduce generic sof_ipc4_pcm_stream_priv
Date: Tue,  7 May 2024 19:06:32 -0400
Message-ID: <20240507230800.392128-6-sashal@kernel.org>
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

[ Upstream commit 551af3280c16166244425bbb1d73028f3a907e1f ]

Using the sof_ipc4_timestamp_info struct directly as sps->private data
is too restrictive, add a new generic sof_ipc4_pcm_stream_priv struct
containing the time_info to allow new information to be stored in a
generic way.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Link: https://msgid.link/r/20240409110036.9411-4-peter.ujfalusi@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/ipc4-pcm.c | 43 ++++++++++++++++++++++++++++++++--------
 1 file changed, 35 insertions(+), 8 deletions(-)

diff --git a/sound/soc/sof/ipc4-pcm.c b/sound/soc/sof/ipc4-pcm.c
index 3f8b9443496ce..d07c1b06207a5 100644
--- a/sound/soc/sof/ipc4-pcm.c
+++ b/sound/soc/sof/ipc4-pcm.c
@@ -37,6 +37,22 @@ struct sof_ipc4_timestamp_info {
 	snd_pcm_sframes_t delay;
 };
 
+/**
+ * struct sof_ipc4_pcm_stream_priv - IPC4 specific private data
+ * @time_info: pointer to time info struct if it is supported, otherwise NULL
+ */
+struct sof_ipc4_pcm_stream_priv {
+	struct sof_ipc4_timestamp_info *time_info;
+};
+
+static inline struct sof_ipc4_timestamp_info *
+sof_ipc4_sps_to_time_info(struct snd_sof_pcm_stream *sps)
+{
+	struct sof_ipc4_pcm_stream_priv *stream_priv = sps->private;
+
+	return stream_priv->time_info;
+}
+
 static int sof_ipc4_set_multi_pipeline_state(struct snd_sof_dev *sdev, u32 state,
 					     struct ipc4_pipeline_set_state_data *trigger_list)
 {
@@ -435,7 +451,7 @@ static int sof_ipc4_trigger_pipelines(struct snd_soc_component *component,
 		 * Invalidate the stream_start_offset to make sure that it is
 		 * going to be updated if the stream resumes
 		 */
-		time_info = spcm->stream[substream->stream].private;
+		time_info = sof_ipc4_sps_to_time_info(&spcm->stream[substream->stream]);
 		if (time_info)
 			time_info->stream_start_offset = SOF_IPC4_INVALID_STREAM_POSITION;
 
@@ -689,12 +705,16 @@ static int sof_ipc4_pcm_dai_link_fixup(struct snd_soc_pcm_runtime *rtd,
 static void sof_ipc4_pcm_free(struct snd_sof_dev *sdev, struct snd_sof_pcm *spcm)
 {
 	struct snd_sof_pcm_stream_pipeline_list *pipeline_list;
+	struct sof_ipc4_pcm_stream_priv *stream_priv;
 	int stream;
 
 	for_each_pcm_streams(stream) {
 		pipeline_list = &spcm->stream[stream].pipeline_list;
 		kfree(pipeline_list->pipelines);
 		pipeline_list->pipelines = NULL;
+
+		stream_priv = spcm->stream[stream].private;
+		kfree(stream_priv->time_info);
 		kfree(spcm->stream[stream].private);
 		spcm->stream[stream].private = NULL;
 	}
@@ -704,6 +724,7 @@ static int sof_ipc4_pcm_setup(struct snd_sof_dev *sdev, struct snd_sof_pcm *spcm
 {
 	struct snd_sof_pcm_stream_pipeline_list *pipeline_list;
 	struct sof_ipc4_fw_data *ipc4_data = sdev->private;
+	struct sof_ipc4_pcm_stream_priv *stream_priv;
 	struct sof_ipc4_timestamp_info *time_info;
 	bool support_info = true;
 	u32 abi_version;
@@ -732,6 +753,14 @@ static int sof_ipc4_pcm_setup(struct snd_sof_dev *sdev, struct snd_sof_pcm *spcm
 			return -ENOMEM;
 		}
 
+		stream_priv = kzalloc(sizeof(*stream_priv), GFP_KERNEL);
+		if (!stream_priv) {
+			sof_ipc4_pcm_free(sdev, spcm);
+			return -ENOMEM;
+		}
+
+		spcm->stream[stream].private = stream_priv;
+
 		if (!support_info)
 			continue;
 
@@ -741,7 +770,7 @@ static int sof_ipc4_pcm_setup(struct snd_sof_dev *sdev, struct snd_sof_pcm *spcm
 			return -ENOMEM;
 		}
 
-		spcm->stream[stream].private = time_info;
+		stream_priv->time_info = time_info;
 	}
 
 	return 0;
@@ -778,7 +807,7 @@ static void sof_ipc4_build_time_info(struct snd_sof_dev *sdev, struct snd_sof_pc
 		return;
 	}
 
-	time_info = sps->private;
+	time_info = sof_ipc4_sps_to_time_info(sps);
 	time_info->host_copier = host_copier;
 	time_info->dai_copier = dai_copier;
 	time_info->llp_offset = offsetof(struct sof_ipc4_fw_registers,
@@ -832,7 +861,7 @@ static int sof_ipc4_pcm_hw_params(struct snd_soc_component *component,
 	if (!spcm)
 		return -EINVAL;
 
-	time_info = spcm->stream[substream->stream].private;
+	time_info = sof_ipc4_sps_to_time_info(&spcm->stream[substream->stream]);
 	/* delay calculation is not supported by current fw_reg ABI */
 	if (!time_info)
 		return 0;
@@ -911,7 +940,7 @@ static int sof_ipc4_pcm_pointer(struct snd_soc_component *component,
 		return -EOPNOTSUPP;
 
 	sps = &spcm->stream[substream->stream];
-	time_info = sps->private;
+	time_info = sof_ipc4_sps_to_time_info(sps);
 	if (!time_info)
 		return -EOPNOTSUPP;
 
@@ -1013,15 +1042,13 @@ static snd_pcm_sframes_t sof_ipc4_pcm_delay(struct snd_soc_component *component,
 {
 	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
 	struct sof_ipc4_timestamp_info *time_info;
-	struct snd_sof_pcm_stream *sps;
 	struct snd_sof_pcm *spcm;
 
 	spcm = snd_sof_find_spcm_dai(component, rtd);
 	if (!spcm)
 		return 0;
 
-	sps = &spcm->stream[substream->stream];
-	time_info = sps->private;
+	time_info = sof_ipc4_sps_to_time_info(&spcm->stream[substream->stream]);
 	/*
 	 * Report the stored delay value calculated in the pointer callback.
 	 * In the unlikely event that the calculation was skipped/aborted, the
-- 
2.43.0


