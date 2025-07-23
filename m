Return-Path: <stable+bounces-164456-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C99B0F4BF
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 16:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3BA01C83564
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 14:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59872F0C69;
	Wed, 23 Jul 2025 14:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uwtAUrPV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4CF12F0C7A
	for <stable@vger.kernel.org>; Wed, 23 Jul 2025 14:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753279222; cv=none; b=NcDdoWs6FdJIeH6CulDuwRpBynyKze/gejOJWzaE0m9mQAsJKinAb+gveSGUO6ayvQdToyWH4L/r3bi0rDfJpIMShpir8B9tT/m4/y5y/6abag7gU+j56AGHs5zCn/Cwg4/K8TmYRq6LbyI6z8Gu2Z/ojz4FF95naIDjGoV6k1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753279222; c=relaxed/simple;
	bh=neXOAgTueLNPJjX7N9b+5VBjJR/JQfs8AZXB3m9iPnY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KbRvvaDBGQgHWHBrPoiOH1c+4V+hYx+3Ba9r/1tdY/TstfQ8/2ubKuRyiRhP9YOpKbB1wHaNYBYkIX6ZpoA0Nk05Xixge7k3sEO+Zxd50sFdOyXv9QrbTtFOVVUKXQXiPjvic8MFdUmlUEn0xOQxnwg31QL0/c6yMuAC3PXyDvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uwtAUrPV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCFA5C4CEE7;
	Wed, 23 Jul 2025 14:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753279222;
	bh=neXOAgTueLNPJjX7N9b+5VBjJR/JQfs8AZXB3m9iPnY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uwtAUrPVu3eRfRlwX59qhrMxZzDPuNQ8mXb68GoglprRtNTBrI0Vm0y9qK2JmcF6l
	 CJQDUsO4GY++tLRj3tzHGjLLzRCleX5WLo337bGSI6RxMo0qjYzPTQ298tI3wa9y2D
	 7RWlgvJfu5OxmGI7ypxSxBSRx4+mRrYzO4qwcGlsoTXPydKvvOenPlLyPwpxzfok/i
	 f+FLpLpE2b62RQpi5ZewIVKoqXLIsb6QgEAhJrjRsMNbU4mTQzbzwU+Yw425uLJmUd
	 ktS8QAqraJuXQ390mAKSEOJkm85smtDOhgNz66TbmolQlqxLJNI9Q7c9ff2WLh5Jpe
	 U4Q84vnNpjqUg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mohan Kumar D <mkumard@nvidia.com>,
	Sheetal <sheetal@nvidia.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] ALSA: hda/tegra: Add Tegra264 support
Date: Wed, 23 Jul 2025 10:00:15 -0400
Message-Id: <20250723140016.1089536-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025071243-multiple-shimmer-e8b6@gregkh>
References: <2025071243-multiple-shimmer-e8b6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mohan Kumar D <mkumard@nvidia.com>

[ Upstream commit 1c4193917eb3279788968639f24d72ffeebdec6b ]

Update HDA driver to support Tegra264 differences from legacy HDA,
which includes: clocks/resets, always power on, and hardware-managed
FPCI/IPFS initialization. The driver retrieves this chip-specific
information from soc_data.

Signed-off-by: Mohan Kumar D <mkumard@nvidia.com>
Signed-off-by: Sheetal <sheetal@nvidia.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Link: https://patch.msgid.link/20250512064258.1028331-4-sheetal@nvidia.com
Stable-dep-of: e0a911ac8685 ("ALSA: hda: Add missing NVIDIA HDA codec IDs")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/hda_tegra.c  | 51 +++++++++++++++++++++++++++++++++-----
 sound/pci/hda/patch_hdmi.c |  1 +
 2 files changed, 46 insertions(+), 6 deletions(-)

diff --git a/sound/pci/hda/hda_tegra.c b/sound/pci/hda/hda_tegra.c
index d967e70a70585..12a144a269ee8 100644
--- a/sound/pci/hda/hda_tegra.c
+++ b/sound/pci/hda/hda_tegra.c
@@ -72,6 +72,10 @@
 struct hda_tegra_soc {
 	bool has_hda2codec_2x_reset;
 	bool has_hda2hdmi;
+	bool has_hda2codec_2x;
+	bool input_stream;
+	bool always_on;
+	bool requires_init;
 };
 
 struct hda_tegra {
@@ -187,7 +191,9 @@ static int __maybe_unused hda_tegra_runtime_resume(struct device *dev)
 	if (rc != 0)
 		return rc;
 	if (chip->running) {
-		hda_tegra_init(hda);
+		if (hda->soc->requires_init)
+			hda_tegra_init(hda);
+
 		azx_init_chip(chip, 1);
 		/* disable controller wake up event*/
 		azx_writew(chip, WAKEEN, azx_readw(chip, WAKEEN) &
@@ -252,7 +258,8 @@ static int hda_tegra_init_chip(struct azx *chip, struct platform_device *pdev)
 	bus->remap_addr = hda->regs + HDA_BAR0;
 	bus->addr = res->start + HDA_BAR0;
 
-	hda_tegra_init(hda);
+	if (hda->soc->requires_init)
+		hda_tegra_init(hda);
 
 	return 0;
 }
@@ -325,7 +332,7 @@ static int hda_tegra_first_init(struct azx *chip, struct platform_device *pdev)
 	 * starts with offset 0 which is wrong as HW register for output stream
 	 * offset starts with 4.
 	 */
-	if (of_device_is_compatible(np, "nvidia,tegra234-hda"))
+	if (!hda->soc->input_stream)
 		chip->capture_streams = 4;
 
 	chip->playback_streams = (gcap >> 12) & 0x0f;
@@ -421,7 +428,6 @@ static int hda_tegra_create(struct snd_card *card,
 	chip->driver_caps = driver_caps;
 	chip->driver_type = driver_caps & 0xff;
 	chip->dev_index = 0;
-	chip->jackpoll_interval = msecs_to_jiffies(5000);
 	INIT_LIST_HEAD(&chip->pcm_list);
 
 	chip->codec_probe_mask = -1;
@@ -438,7 +444,16 @@ static int hda_tegra_create(struct snd_card *card,
 	chip->bus.core.sync_write = 0;
 	chip->bus.core.needs_damn_long_delay = 1;
 	chip->bus.core.aligned_mmio = 1;
-	chip->bus.jackpoll_in_suspend = 1;
+
+	/*
+	 * HDA power domain and clocks are always on for Tegra264 and
+	 * the jack detection logic would work always, so no need of
+	 * jack polling mechanism running.
+	 */
+	if (!hda->soc->always_on) {
+		chip->jackpoll_interval = msecs_to_jiffies(5000);
+		chip->bus.jackpoll_in_suspend = 1;
+	}
 
 	err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops);
 	if (err < 0) {
@@ -452,22 +467,44 @@ static int hda_tegra_create(struct snd_card *card,
 static const struct hda_tegra_soc tegra30_data = {
 	.has_hda2codec_2x_reset = true,
 	.has_hda2hdmi = true,
+	.has_hda2codec_2x = true,
+	.input_stream = true,
+	.always_on = false,
+	.requires_init = true,
 };
 
 static const struct hda_tegra_soc tegra194_data = {
 	.has_hda2codec_2x_reset = false,
 	.has_hda2hdmi = true,
+	.has_hda2codec_2x = true,
+	.input_stream = true,
+	.always_on = false,
+	.requires_init = true,
 };
 
 static const struct hda_tegra_soc tegra234_data = {
 	.has_hda2codec_2x_reset = true,
 	.has_hda2hdmi = false,
+	.has_hda2codec_2x = true,
+	.input_stream = false,
+	.always_on = false,
+	.requires_init = true,
+};
+
+static const struct hda_tegra_soc tegra264_data = {
+	.has_hda2codec_2x_reset = true,
+	.has_hda2hdmi = false,
+	.has_hda2codec_2x = false,
+	.input_stream = false,
+	.always_on = true,
+	.requires_init = false,
 };
 
 static const struct of_device_id hda_tegra_match[] = {
 	{ .compatible = "nvidia,tegra30-hda", .data = &tegra30_data },
 	{ .compatible = "nvidia,tegra194-hda", .data = &tegra194_data },
 	{ .compatible = "nvidia,tegra234-hda", .data = &tegra234_data },
+	{ .compatible = "nvidia,tegra264-hda", .data = &tegra264_data },
 	{},
 };
 MODULE_DEVICE_TABLE(of, hda_tegra_match);
@@ -522,7 +559,9 @@ static int hda_tegra_probe(struct platform_device *pdev)
 	hda->clocks[hda->nclocks++].id = "hda";
 	if (hda->soc->has_hda2hdmi)
 		hda->clocks[hda->nclocks++].id = "hda2hdmi";
-	hda->clocks[hda->nclocks++].id = "hda2codec_2x";
+
+	if (hda->soc->has_hda2codec_2x)
+		hda->clocks[hda->nclocks++].id = "hda2codec_2x";
 
 	err = devm_clk_bulk_get(&pdev->dev, hda->nclocks, hda->clocks);
 	if (err < 0)
diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index f030700cd60d7..8ad3eb43874de 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -4559,6 +4559,7 @@ HDA_CODEC_ENTRY(0x10de002e, "Tegra186 HDMI/DP1", patch_tegra_hdmi),
 HDA_CODEC_ENTRY(0x10de002f, "Tegra194 HDMI/DP2", patch_tegra_hdmi),
 HDA_CODEC_ENTRY(0x10de0030, "Tegra194 HDMI/DP3", patch_tegra_hdmi),
 HDA_CODEC_ENTRY(0x10de0031, "Tegra234 HDMI/DP", patch_tegra234_hdmi),
+HDA_CODEC_ENTRY(0x10de0034, "Tegra264 HDMI/DP",	patch_tegra234_hdmi),
 HDA_CODEC_ENTRY(0x10de0040, "GPU 40 HDMI/DP",	patch_nvhdmi),
 HDA_CODEC_ENTRY(0x10de0041, "GPU 41 HDMI/DP",	patch_nvhdmi),
 HDA_CODEC_ENTRY(0x10de0042, "GPU 42 HDMI/DP",	patch_nvhdmi),
-- 
2.39.5


