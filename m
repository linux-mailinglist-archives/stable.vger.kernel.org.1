Return-Path: <stable+bounces-60295-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A7D933008
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 20:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF02B1F22194
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 18:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DBB71A0B16;
	Tue, 16 Jul 2024 18:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jB55YUc7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0871C1A01CD;
	Tue, 16 Jul 2024 18:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721154757; cv=none; b=Kc6eSGvORUsSl7CwQV+K4c0a85gqtDKUptl7P+B8jgBi66Cj9dsfwFbsUvf5CTQBlHmMjlGKyMOgpdVa2ZX8lmC64AsHVMykifNTJi3QeuFGI2it4YtEH7t0S+MtwuqyP6Ogq0UxyLrmhDwwQNyzOwpScdyEy1vhnFCdnuwbQlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721154757; c=relaxed/simple;
	bh=in01/cuBSfzW2fFwhuaZvYsjc3ek9xQkRKEYGumJyV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=om+n9yB4YckCNkZ0WFg98V3uyeSVUnKfuTGvqittkk6Qm6K+3HRfX1jHguEPgECqpiJqJ7X0BEGreXKHM7p2Yckz3o3CyPhc/fAmAZwLgHR4qgc4rONinkXXO4Q82QTBCUSMlT6IGl7mwjKNMyrhGsZlJmOWMhtiZAHSko7+dzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jB55YUc7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B93EC4AF0B;
	Tue, 16 Jul 2024 18:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721154756;
	bh=in01/cuBSfzW2fFwhuaZvYsjc3ek9xQkRKEYGumJyV4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jB55YUc7HOj2intzokVNITYiVr637+xHmWrWvvNA58j2TkOynOoM8k94LeyEQmMKq
	 +c5LdgGJVDMsid0XbennAWLj7AcbdNpUi5QLpaW7jQFOPWViSnsAsC0pItkDw9G6cV
	 sJYTimufui+/0Mm88pLZsLolJwpOFV+ctkzk2PRFpwfZtN2Y8GY1sE8cBMUNetB7h0
	 SPlh/jThx0fNZjelxSbauOPcPTDGf2YWL15da4cMFk2Ns0SSr+nZ5j62LMBAhjoqOW
	 fyXL0rScDDSPksjh8M1fdf6wDjiH5Hod4DrqyOBCIf1x8E1r5FXkjnfL1QK7CrUwEm
	 hrDn+9RXnzztg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	yung-chuan.liao@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	daniel.baluta@nxp.com,
	perex@perex.cz,
	tiwai@suse.com,
	kai.vehmanen@linux.intel.com,
	kuninori.morimoto.gx@renesas.com,
	sound-open-firmware@alsa-project.org,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.9 06/11] ASoC: SOF: Intel: hda-pcm: Limit the maximum number of periods by MAX_BDL_ENTRIES
Date: Tue, 16 Jul 2024 14:31:50 -0400
Message-ID: <20240716183222.2813968-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240716183222.2813968-1-sashal@kernel.org>
References: <20240716183222.2813968-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.9
Content-Transfer-Encoding: 8bit

From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>

[ Upstream commit 82bb8db96610b558920b8c57cd250ec90567d79b ]

The HDaudio specification Section 3.6.2 limits the number of BDL entries to 256.

Make sure we don't allow more periods than this normative value.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://patch.msgid.link/20240704090106.371497-1-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/intel/hda-pcm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/soc/sof/intel/hda-pcm.c b/sound/soc/sof/intel/hda-pcm.c
index d7b446f3f973e..8b5fbbc777bd4 100644
--- a/sound/soc/sof/intel/hda-pcm.c
+++ b/sound/soc/sof/intel/hda-pcm.c
@@ -254,6 +254,12 @@ int hda_dsp_pcm_open(struct snd_sof_dev *sdev,
 	snd_pcm_hw_constraint_integer(substream->runtime,
 				      SNDRV_PCM_HW_PARAM_PERIODS);
 
+	/* Limit the maximum number of periods to not exceed the BDL entries count */
+	if (runtime->hw.periods_max > HDA_DSP_MAX_BDL_ENTRIES)
+		snd_pcm_hw_constraint_minmax(runtime, SNDRV_PCM_HW_PARAM_PERIODS,
+					     runtime->hw.periods_min,
+					     HDA_DSP_MAX_BDL_ENTRIES);
+
 	/* Only S16 and S32 supported by HDA hardware when used without DSP */
 	if (sdev->dspless_mode_selected)
 		snd_pcm_hw_constraint_mask64(substream->runtime, SNDRV_PCM_HW_PARAM_FORMAT,
-- 
2.43.0


