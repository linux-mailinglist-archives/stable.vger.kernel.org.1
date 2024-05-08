Return-Path: <stable+bounces-43286-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF23D8BF15D
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AA3C286C2B
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A899130AE4;
	Tue,  7 May 2024 23:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ua2Ykv0U"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31825130AD3;
	Tue,  7 May 2024 23:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715123295; cv=none; b=lIJXVYzcEj8idkLRSYmN83KwMD3n+0A45YlUujXfSGE4rwqrkMtrg36R7rSyKsn5cmAEmBmSSZnNc7LAq1A4tI/EN2CCfDDgMpoCzG7WEPLFxXHMgadYmwC1W2SLzyiQprobPqhUliiuLcvlvu+juLRFe6UeEYdrnJpYjrpI9Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715123295; c=relaxed/simple;
	bh=wXz2BuXc74bmjDqhTEU40pxq26+fO6/UemXfc3UHyEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mUCP747FQXphwooBaLHyEXQKKiZUPUd1OvHca66wjYXJhdZ4S/dmudpEQH3B1zfPDNKm2nJDRDRnNM2P0j4x9gWvgoCdhBT0/GOb8AkYmwwjHYgb062qjy0LHN7K2iIn+FTkWbFzvPnNNSIkBRV6jP+fW3KV3ccYwOcrWBDUGfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ua2Ykv0U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 328E7C4AF17;
	Tue,  7 May 2024 23:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715123294;
	bh=wXz2BuXc74bmjDqhTEU40pxq26+fO6/UemXfc3UHyEM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ua2Ykv0U0ip/Ztes+WuPuqDw0QhbeiDFbjlhKMM2dWQCorc4sWYDx8Y3IsR9djBnV
	 KGgwcC82Y3gIk4e/0NYRIvaQpouEBwwbCUtZPOspynWV4ijdqGr3PJKC6vS5FuV0d5
	 T1jeb9njt8PcfTI9SZMOiTI67nkdsR7GfgusBv7yfu9hE5sW5Ql4HNFpR7aPSsxh/a
	 i/FCl8Bbe5eEoONa8GGqi1lJmcbVKRfURfx8WQVDwh1xA3iHyToO2x7L8jy3aR6p5U
	 KyWIBW9w5rR7T1fATUFanrTN9O4ZkGI7qoXM8CK5OVXqTGHXostXJ33N13EIRH2Qyc
	 kVoTnv1vfEqkA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Uday M Bhat <uday.m.bhat@intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	peter.ujfalusi@linux.intel.com,
	daniel.baluta@nxp.com,
	perex@perex.cz,
	tiwai@suse.com,
	sound-open-firmware@alsa-project.org,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 07/52] ASoC: SOF: pcm: Restrict DSP D0i3 during S0ix to IPC3
Date: Tue,  7 May 2024 19:06:33 -0400
Message-ID: <20240507230800.392128-7-sashal@kernel.org>
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

From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>

[ Upstream commit 90a2353080eedec855d63f6aadfda14104ee9b06 ]

Introduce a new field in struct sof_ipc_pcm_ops that can be used to
restrict DSP D0i3 during S0ix suspend to IPC3. With IPC4, all streams
must be stopped before S0ix suspend.

Reviewed-by: Uday M Bhat <uday.m.bhat@intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://msgid.link/r/20240408194147.28919-3-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/ipc3-pcm.c  |  1 +
 sound/soc/sof/pcm.c       | 13 ++++++-------
 sound/soc/sof/sof-audio.h |  2 ++
 3 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/sound/soc/sof/ipc3-pcm.c b/sound/soc/sof/ipc3-pcm.c
index 330f04bcd75d2..a7cf52fd76455 100644
--- a/sound/soc/sof/ipc3-pcm.c
+++ b/sound/soc/sof/ipc3-pcm.c
@@ -409,4 +409,5 @@ const struct sof_ipc_pcm_ops ipc3_pcm_ops = {
 	.trigger = sof_ipc3_pcm_trigger,
 	.dai_link_fixup = sof_ipc3_pcm_dai_link_fixup,
 	.reset_hw_params_during_stop = true,
+	.d0i3_supported_in_s0ix = true,
 };
diff --git a/sound/soc/sof/pcm.c b/sound/soc/sof/pcm.c
index f03cee94bce62..8804e00e7251b 100644
--- a/sound/soc/sof/pcm.c
+++ b/sound/soc/sof/pcm.c
@@ -325,14 +325,13 @@ static int sof_pcm_trigger(struct snd_soc_component *component,
 			ipc_first = true;
 		break;
 	case SNDRV_PCM_TRIGGER_SUSPEND:
-		if (sdev->system_suspend_target == SOF_SUSPEND_S0IX &&
+		/*
+		 * If DSP D0I3 is allowed during S0iX, set the suspend_ignored flag for
+		 * D0I3-compatible streams to keep the firmware pipeline running
+		 */
+		if (pcm_ops && pcm_ops->d0i3_supported_in_s0ix &&
+		    sdev->system_suspend_target == SOF_SUSPEND_S0IX &&
 		    spcm->stream[substream->stream].d0i3_compatible) {
-			/*
-			 * trap the event, not sending trigger stop to
-			 * prevent the FW pipelines from being stopped,
-			 * and mark the flag to ignore the upcoming DAPM
-			 * PM events.
-			 */
 			spcm->stream[substream->stream].suspend_ignored = true;
 			return 0;
 		}
diff --git a/sound/soc/sof/sof-audio.h b/sound/soc/sof/sof-audio.h
index 85b26e3fefa8f..05e2a899d746c 100644
--- a/sound/soc/sof/sof-audio.h
+++ b/sound/soc/sof/sof-audio.h
@@ -116,6 +116,7 @@ struct snd_sof_dai_config_data {
  *				  triggers. The FW keeps the host DMA running in this case and
  *				  therefore the host must do the same and should stop the DMA during
  *				  hw_free.
+ * @d0i3_supported_in_s0ix: Allow DSP D0I3 during S0iX
  */
 struct sof_ipc_pcm_ops {
 	int (*hw_params)(struct snd_soc_component *component, struct snd_pcm_substream *substream,
@@ -135,6 +136,7 @@ struct sof_ipc_pcm_ops {
 	bool reset_hw_params_during_stop;
 	bool ipc_first_on_start;
 	bool platform_stop_during_hw_free;
+	bool d0i3_supported_in_s0ix;
 };
 
 /**
-- 
2.43.0


