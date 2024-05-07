Return-Path: <stable+bounces-43335-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9338B8BF1D3
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C543D1C221ED
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC999148826;
	Tue,  7 May 2024 23:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ODmsWxcW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A381487F7;
	Tue,  7 May 2024 23:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715123441; cv=none; b=M2b+fyAT6TCey5ttkR3+T+k0y++tH5SUuC6h1DpVGXbp4+n9XfrNNtt06nnQBsvOAuE2lYNjwQnezCLDUYfKwn8/snBpBiRh98OhKTUD9Exw5vSr80YcKOBLb/t8bBc1UhTwMBEvPq4OKs7S8EWwYFwhR/5McamS50BsV2sAu0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715123441; c=relaxed/simple;
	bh=x+ILaP9ypmyXCEp+Idha2KABu9yijatlZKhXKqcVmgc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mgUYMKXdyPnTQ5TUwgMeG7FXAoaEEQDPBZZwaFD6wOsyIAwzgKvY8U0ssEADsQcb4VjP8z5TVM+7f6+BYD3fUqSkzs9z5JNFA7ZM/UFCp0EhSnYHSuS5xa+38cAP3VBTk9a0jtZc70oOYXNmh2XF1dl6vCKYlxTQLhQQ+QpJP9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ODmsWxcW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB81AC2BBFC;
	Tue,  7 May 2024 23:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715123441;
	bh=x+ILaP9ypmyXCEp+Idha2KABu9yijatlZKhXKqcVmgc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ODmsWxcWYnauCJ1o8HnRSqdBZKNqTrlSEVTBi2NZeZX0MYBN7GZ8f/unUOiQurilZ
	 RbClThTC1G86iP+0NrxhMERi9Srnij3rDQ895Q/N5zsTh+kZGWaUAfZARnkfZ0+ozi
	 LYbexmD9OvulG+v8Pp/s4GSnsTmJKjQ1ot0UvocVkpYBPlXafEagOKSaPL0wbP3pTj
	 4wTTMRnMybj97BkJiR8pWVXM6M8yuQnkPQDASOhdVTZOq511BFAN4UHMVFELPrXZnq
	 VaLVHNLVR4NdtPcY9yaTxZtX8VwXUCYwoZql1QJ3s9XoLd7F+I4cvqr5SGd7Rb01Lu
	 /padO5TLnx9XA==
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
Subject: [PATCH AUTOSEL 6.6 04/43] ASoC: SOF: pcm: Restrict DSP D0i3 during S0ix to IPC3
Date: Tue,  7 May 2024 19:09:25 -0400
Message-ID: <20240507231033.393285-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507231033.393285-1-sashal@kernel.org>
References: <20240507231033.393285-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.30
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
index cb58ee8c158a5..720bd9bd2667a 100644
--- a/sound/soc/sof/ipc3-pcm.c
+++ b/sound/soc/sof/ipc3-pcm.c
@@ -398,4 +398,5 @@ const struct sof_ipc_pcm_ops ipc3_pcm_ops = {
 	.trigger = sof_ipc3_pcm_trigger,
 	.dai_link_fixup = sof_ipc3_pcm_dai_link_fixup,
 	.reset_hw_params_during_stop = true,
+	.d0i3_supported_in_s0ix = true,
 };
diff --git a/sound/soc/sof/pcm.c b/sound/soc/sof/pcm.c
index d778717cab10b..8e602e42afee2 100644
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
index a6d6bcd00ceec..3606595a7500c 100644
--- a/sound/soc/sof/sof-audio.h
+++ b/sound/soc/sof/sof-audio.h
@@ -113,6 +113,7 @@ struct snd_sof_dai_config_data {
  *				  triggers. The FW keeps the host DMA running in this case and
  *				  therefore the host must do the same and should stop the DMA during
  *				  hw_free.
+ * @d0i3_supported_in_s0ix: Allow DSP D0I3 during S0iX
  */
 struct sof_ipc_pcm_ops {
 	int (*hw_params)(struct snd_soc_component *component, struct snd_pcm_substream *substream,
@@ -129,6 +130,7 @@ struct sof_ipc_pcm_ops {
 	bool reset_hw_params_during_stop;
 	bool ipc_first_on_start;
 	bool platform_stop_during_hw_free;
+	bool d0i3_supported_in_s0ix;
 };
 
 /**
-- 
2.43.0


