Return-Path: <stable+bounces-164454-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91692B0F4B6
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 15:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3F2D580558
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 13:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F2F2EB5D3;
	Wed, 23 Jul 2025 13:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HG2w8Y+K"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB9227EFFA
	for <stable@vger.kernel.org>; Wed, 23 Jul 2025 13:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753279171; cv=none; b=bVEuqb9Vzx5bYtjuT/Ny/vHpaUrQlSXUz6BnNiaDBaYfSpOSmM/uEA8Nvz/M8p++A2SnQIgzRFXOIyx6Itz7BABxQhFzRBWO32hpVkKX/YViZvkKMz3ebyGoFEl2Cj5uJtYsZNbMAEQQxkW1rjcpYDuPtriR2jgbjbmbnHdc82E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753279171; c=relaxed/simple;
	bh=hxxKER3/SUOnGnSfaLOQTV6Iee5dCXV3EbjFji4nP1M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aMUcbFNkFv4/z/Hc6tH1gE+3VHB8vd4MckxYtlsAlImc3R8A909bekzcv9yaZTOdy4LEHbBvqEalKtxC9k7EwT67o6LR8TCqL9sVCpZPa3srnvUMNr653StR9DNG2mGJ8JGqRQqe99xTNW77n4HtlBV9ghIh9jXxsNcOLgvEDsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HG2w8Y+K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 230E5C4CEEF;
	Wed, 23 Jul 2025 13:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753279170;
	bh=hxxKER3/SUOnGnSfaLOQTV6Iee5dCXV3EbjFji4nP1M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HG2w8Y+Kbyi8NMPDo8QeBU1XcgYyIVunHloCJm3vUhihGYj/cDs4ycYoH2Vdi9msD
	 LgajnkxiBBGQwWJZVrnBzQkL5A776FebNYqexbSlt9RgHwBvG4I21g80dBt/1obnEI
	 Bw0v1Uip6D1W7WwTxv6buSXPkpT6EHNZwPPhWZ+O6Z+lk1W/hZ3zTc+TmhMmYf/lK+
	 IRU/ir/Gum040MB5Nw5bG/knRP5vLNnejmBTySIS5DmSlWhmmnv5GE9aoMk4bpLDxX
	 kT8CiVFWAu65VhJ9E6kT5lKaAfRV+9khkAMTkM2wVb967UTn4BI8ztUch1uRFnqm4T
	 geAj2IE4spYhA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mohan Kumar D <mkumard@nvidia.com>,
	Sheetal <sheetal@nvidia.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] ALSA: hda/tegra: Add Tegra264 support
Date: Wed, 23 Jul 2025 09:59:24 -0400
Message-Id: <20250723135925.1089403-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025071243-other-defy-2a7d@gregkh>
References: <2025071243-other-defy-2a7d@gregkh>
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
index 643e0496b0936..7272197a860e7 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -4551,6 +4551,7 @@ HDA_CODEC_ENTRY(0x10de002e, "Tegra186 HDMI/DP1", patch_tegra_hdmi),
 HDA_CODEC_ENTRY(0x10de002f, "Tegra194 HDMI/DP2", patch_tegra_hdmi),
 HDA_CODEC_ENTRY(0x10de0030, "Tegra194 HDMI/DP3", patch_tegra_hdmi),
 HDA_CODEC_ENTRY(0x10de0031, "Tegra234 HDMI/DP", patch_tegra234_hdmi),
+HDA_CODEC_ENTRY(0x10de0034, "Tegra264 HDMI/DP",	patch_tegra234_hdmi),
 HDA_CODEC_ENTRY(0x10de0040, "GPU 40 HDMI/DP",	patch_nvhdmi),
 HDA_CODEC_ENTRY(0x10de0041, "GPU 41 HDMI/DP",	patch_nvhdmi),
 HDA_CODEC_ENTRY(0x10de0042, "GPU 42 HDMI/DP",	patch_nvhdmi),
-- 
2.39.5


