Return-Path: <stable+bounces-118879-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2692A41D34
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 12:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B9E01891D71
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 11:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676902192E5;
	Mon, 24 Feb 2025 11:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BOmXoDWt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C848281378;
	Mon, 24 Feb 2025 11:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740396044; cv=none; b=Ptu9tAiQcWIIaU+4U5YzG8cdjB82Xoea6GC8D2PkvZIt4+7hD2Bc2kfmL3E15Wk2Nos2OWNF1wJnN2Zcz5xpiPAXyj8QtR+4ZyEMB6XQuw25wO+9NIobbrz7pR3tAYPoK2U7IHNCQSm5bVpbd1umfgnzar3gNBloDxLgDklE2sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740396044; c=relaxed/simple;
	bh=Nta6SfkxSvH7zeTF4vPYsbeZW+YfKlQw6mpUKwHK9l4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nYn6V4bAM2RmnflE20APbrzMIcCwNgBjNoyhatcH5VaZLiKqTcT1gvCfT1YyfNPIzepuP0xEtq1FRgeljgwZndXct0m63dyvy/M4xSh6b4aL2xw00m3XzA2Pr+jvLvfjk1cQ4gyAS1px8UDOWxvYK68GHtJcKf59nYCfhoACzb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BOmXoDWt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20E60C4CEE8;
	Mon, 24 Feb 2025 11:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740396044;
	bh=Nta6SfkxSvH7zeTF4vPYsbeZW+YfKlQw6mpUKwHK9l4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BOmXoDWtsNV2yzJynwDWvUct/vINYolEFYnW58tHuwHzZIW5Ba82ZyoxOUYW8WAgE
	 5J2ymK70c4oVdOTsQ7wNQ2V9FgcRU+HVXYQR/+y7D62/d4ijzPk/C00PBu/W/JN4oZ
	 xeSNwoOqdjzw/TM+l8BnkH8zjQhfGM02YByNkmOWDz6F+4jFz1y8uQAaWChBb0HlC3
	 LGyz+dtlWmvCcCKxq6bcQVFlZSWzBeI7IYNvOZg2kMIPXwvfv9fWgI1m79E1O/C5yC
	 +302xVFl1tPH2PhtnH7XxY2QXudP0cB5eNCmygW+Ud8KSwI6DGruGRtlpNvP6OfVXA
	 GRM85dNPIA2Dw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Terry Cheong <htcheong@chromium.org>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Johny Lin <lpg76627@gmail.com>,
	=?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	ranjani.sridharan@linux.intel.com,
	daniel.baluta@nxp.com,
	perex@perex.cz,
	tiwai@suse.com,
	pierre-louis.bossart@linux.dev,
	cezary.rojewski@intel.com,
	peterz@infradead.org,
	sound-open-firmware@alsa-project.org,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 3/7] ASoC: SOF: Intel: hda: add softdep pre to snd-hda-codec-hdmi module
Date: Mon, 24 Feb 2025 06:20:26 -0500
Message-Id: <20250224112033.2214818-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250224112033.2214818-1-sashal@kernel.org>
References: <20250224112033.2214818-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.178
Content-Transfer-Encoding: 8bit

From: Terry Cheong <htcheong@chromium.org>

[ Upstream commit 33b7dc7843dbdc9b90c91d11ba30b107f9138ffd ]

In enviornment without KMOD requesting module may fail to load
snd-hda-codec-hdmi, resulting in HDMI audio not usable.
Add softdep to loading HDMI codec module first to ensure we can load it
correctly.

Signed-off-by: Terry Cheong <htcheong@chromium.org>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Johny Lin <lpg76627@gmail.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Link: https://patch.msgid.link/20250206094723.18013-1-peter.ujfalusi@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/intel/hda-codec.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/sof/intel/hda-codec.c b/sound/soc/sof/intel/hda-codec.c
index 6744318de612e..0449e7a2669ff 100644
--- a/sound/soc/sof/intel/hda-codec.c
+++ b/sound/soc/sof/intel/hda-codec.c
@@ -258,6 +258,7 @@ int hda_codec_i915_exit(struct snd_sof_dev *sdev)
 }
 EXPORT_SYMBOL_NS(hda_codec_i915_exit, SND_SOC_SOF_HDA_AUDIO_CODEC_I915);
 
+MODULE_SOFTDEP("pre: snd-hda-codec-hdmi");
 #endif
 
 MODULE_LICENSE("Dual BSD/GPL");
-- 
2.39.5


