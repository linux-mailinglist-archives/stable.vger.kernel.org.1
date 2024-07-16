Return-Path: <stable+bounces-60303-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 910EE933020
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 20:35:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 239C4B2263A
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 18:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B66C71A2FB7;
	Tue, 16 Jul 2024 18:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="On5IlMjv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698EA1A0AF8;
	Tue, 16 Jul 2024 18:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721154814; cv=none; b=Vr4OW80kkigQIRGotgZ7QHEsjMxdydgFLxZqDJh8fZvsBx1lOpVtE/0bP+N/C0AHG3tEVKFFd5TNYS9Matsds/5WS83VmfEOlkIoLEdmKay0LwqHiVBdBduLGOA5uHfjtnNB4HhVyxuOA4kSy6OiO6Brcy7wTsEp4ScHXJXvwF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721154814; c=relaxed/simple;
	bh=YG6oQwo0hhMp9liGJwhLCAZgieohceHYXGJea/xVCz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UwXLUshz8GtpVTIKwV4NjTGESAorRhXd42pEA3HMK9Pt6PabcG9Tw+ImUFPpWx9hRYO6giXZTWJU5i7A6+59BaUN8bY5UCATMw5S63gt9Q3R1j9NQwlW8gbrjXFqJ3XlHHsGOYPX/GFnUvLUi8GJrG8/W7++KlXLnxWrcb7LRRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=On5IlMjv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B22CC4AF0D;
	Tue, 16 Jul 2024 18:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721154814;
	bh=YG6oQwo0hhMp9liGJwhLCAZgieohceHYXGJea/xVCz4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=On5IlMjvzdvuWHVLUAQN91ySzCdqMoaOSq84y9Vw9ivJvWq7Mxx5pLnlUAKDANLsM
	 6toGhsD9w4ul+ZyWc/xGG5Zd5Eb1BeBksDR9HH7P2Ol83g9wrXKznlL8TyUA2ysTHK
	 rNb2uFi8W1zYAcD6uEUNEZnTS4iWPZztG4y7uQf3cx4nHvNiscFo9sUJs7n4uHwJye
	 NfeZvo/+zANOmyTRSpx5W1GVlN2n2b6XYonmZEf1wcihHbD25reOHCH8TIhM6d6pvb
	 vGTxbr3xHU3SwI2n0kHWC1wDhiFrQcPURMQEcfT1ij5rEleIO1hnoiK7sH+UILJL//
	 3Ey3Nu9zUnKfw==
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
Subject: [PATCH AUTOSEL 6.6 3/8] ASoC: SOF: Intel: hda-pcm: Limit the maximum number of periods by MAX_BDL_ENTRIES
Date: Tue, 16 Jul 2024 14:33:00 -0400
Message-ID: <20240716183324.2814275-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240716183324.2814275-1-sashal@kernel.org>
References: <20240716183324.2814275-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.40
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
index f23c72cdff489..7d17d586ed9db 100644
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


