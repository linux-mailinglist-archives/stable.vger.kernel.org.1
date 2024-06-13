Return-Path: <stable+bounces-51675-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2ED90710C
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 14:33:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB4D71C247F2
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 12:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC5B399;
	Thu, 13 Jun 2024 12:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iH6KaTpQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD483C24;
	Thu, 13 Jun 2024 12:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718281986; cv=none; b=ZSbVzLj5iOTVIHp0/k+UaEQQ4DB37sUuEXffJvpb57n3ZsucVuoCr6XLjaxAvRXyNeT6Ro8fot0PeZWcZ25aWYIhL4zmn+4FsDsyNeB/7uYlGifwPIbiPQM/Bk8UqD357J/j3n7wYrkTxuh3f9X1OL8C7fcQgfp9OYE/VQxXbKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718281986; c=relaxed/simple;
	bh=ssFNSVgWFBvaVA6JxITcFHw1uyL+hfT3lsmaEz9WZdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lDocIL6ETq5SFpn5fPQNOc+3pvuSjJtTjWnZEjK/Ujw8d1zifBW+B5hu0+iD2Et5gVFaMp6rTIHU3+0LWa6NFkgwZ2jGNLxGequDD95sGDwvoGb50IRPSt7z/Ch2Sdt/DCYjRGpc1CLpYRCzH/yOSJpUJOgFSZZ8I/Z5YWcOkV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iH6KaTpQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73D78C4AF1A;
	Thu, 13 Jun 2024 12:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718281985;
	bh=ssFNSVgWFBvaVA6JxITcFHw1uyL+hfT3lsmaEz9WZdQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iH6KaTpQRjSPtqriCWn7FEZ6s2IGcAPV1EzvVLzOdt5/UQ4Msd/zajKFD1KyZKhPf
	 m3i891lqf3FBmgO0UHj3N+hFMWC/nOeXkRhrHuwuDQDWdb37YbaIzSR/VTD5TN7FS0
	 nYq7E0P/SL3E8qOBMNxkzb5EwPOH/NzunngIBnYc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Cezary Rojewski <cezary.rojewski@intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 124/402] ASoC: Intel: Disable route checks for Skylake boards
Date: Thu, 13 Jun 2024 13:31:21 +0200
Message-ID: <20240613113306.977536242@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613113302.116811394@linuxfoundation.org>
References: <20240613113302.116811394@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cezary Rojewski <cezary.rojewski@intel.com>

[ Upstream commit 0cb3b7fd530b8c107443218ce6db5cb6e7b5dbe1 ]

Topology files that are propagated to the world and utilized by the
skylake-driver carry shortcomings in their SectionGraphs.

Since commit daa480bde6b3 ("ASoC: soc-core: tidyup for
snd_soc_dapm_add_routes()") route checks are no longer permissive. Probe
failures for Intel boards have been partially addressed by commit
a22ae72b86a4 ("ASoC: soc-core: disable route checks for legacy devices")
and its follow up but only skl_nau88l25_ssm4567.c is patched. Fix the
problem for the rest of the boards.

Link: https://lore.kernel.org/all/20200309192744.18380-1-pierre-louis.bossart@linux.intel.com/
Fixes: daa480bde6b3 ("ASoC: soc-core: tidyup for snd_soc_dapm_add_routes()")
Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
Link: https://msgid.link/r/20240308090502.2136760-2-cezary.rojewski@intel.com
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/boards/bxt_da7219_max98357a.c       | 1 +
 sound/soc/intel/boards/bxt_rt298.c                  | 1 +
 sound/soc/intel/boards/glk_rt5682_max98357a.c       | 2 ++
 sound/soc/intel/boards/kbl_da7219_max98357a.c       | 1 +
 sound/soc/intel/boards/kbl_da7219_max98927.c        | 4 ++++
 sound/soc/intel/boards/kbl_rt5660.c                 | 1 +
 sound/soc/intel/boards/kbl_rt5663_max98927.c        | 2 ++
 sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c | 1 +
 sound/soc/intel/boards/skl_hda_dsp_generic.c        | 2 ++
 sound/soc/intel/boards/skl_nau88l25_max98357a.c     | 1 +
 sound/soc/intel/boards/skl_rt286.c                  | 1 +
 11 files changed, 17 insertions(+)

diff --git a/sound/soc/intel/boards/bxt_da7219_max98357a.c b/sound/soc/intel/boards/bxt_da7219_max98357a.c
index e49c64f54a12c..5bc2f8c82ffcd 100644
--- a/sound/soc/intel/boards/bxt_da7219_max98357a.c
+++ b/sound/soc/intel/boards/bxt_da7219_max98357a.c
@@ -750,6 +750,7 @@ static struct snd_soc_card broxton_audio_card = {
 	.dapm_routes = audio_map,
 	.num_dapm_routes = ARRAY_SIZE(audio_map),
 	.fully_routed = true,
+	.disable_route_checks = true,
 	.late_probe = bxt_card_late_probe,
 };
 
diff --git a/sound/soc/intel/boards/bxt_rt298.c b/sound/soc/intel/boards/bxt_rt298.c
index 0d1df37ecea0b..cd11a40252329 100644
--- a/sound/soc/intel/boards/bxt_rt298.c
+++ b/sound/soc/intel/boards/bxt_rt298.c
@@ -575,6 +575,7 @@ static struct snd_soc_card broxton_rt298 = {
 	.dapm_routes = broxton_rt298_map,
 	.num_dapm_routes = ARRAY_SIZE(broxton_rt298_map),
 	.fully_routed = true,
+	.disable_route_checks = true,
 	.late_probe = bxt_card_late_probe,
 
 };
diff --git a/sound/soc/intel/boards/glk_rt5682_max98357a.c b/sound/soc/intel/boards/glk_rt5682_max98357a.c
index 99b3d7642cb77..5f1eb75048324 100644
--- a/sound/soc/intel/boards/glk_rt5682_max98357a.c
+++ b/sound/soc/intel/boards/glk_rt5682_max98357a.c
@@ -603,6 +603,8 @@ static int geminilake_audio_probe(struct platform_device *pdev)
 	card = &glk_audio_card_rt5682_m98357a;
 	card->dev = &pdev->dev;
 	snd_soc_card_set_drvdata(card, ctx);
+	if (!snd_soc_acpi_sof_parent(&pdev->dev))
+		card->disable_route_checks = true;
 
 	/* override platform name, if required */
 	mach = pdev->dev.platform_data;
diff --git a/sound/soc/intel/boards/kbl_da7219_max98357a.c b/sound/soc/intel/boards/kbl_da7219_max98357a.c
index 14b625e947f5f..77f6898b397d4 100644
--- a/sound/soc/intel/boards/kbl_da7219_max98357a.c
+++ b/sound/soc/intel/boards/kbl_da7219_max98357a.c
@@ -621,6 +621,7 @@ static struct snd_soc_card kabylake_audio_card_da7219_m98357a = {
 	.dapm_routes = kabylake_map,
 	.num_dapm_routes = ARRAY_SIZE(kabylake_map),
 	.fully_routed = true,
+	.disable_route_checks = true,
 	.late_probe = kabylake_card_late_probe,
 };
 
diff --git a/sound/soc/intel/boards/kbl_da7219_max98927.c b/sound/soc/intel/boards/kbl_da7219_max98927.c
index 2b43459adc33a..2c57c9204d322 100644
--- a/sound/soc/intel/boards/kbl_da7219_max98927.c
+++ b/sound/soc/intel/boards/kbl_da7219_max98927.c
@@ -1018,6 +1018,7 @@ static struct snd_soc_card kbl_audio_card_da7219_m98927 = {
 	.codec_conf = max98927_codec_conf,
 	.num_configs = ARRAY_SIZE(max98927_codec_conf),
 	.fully_routed = true,
+	.disable_route_checks = true,
 	.late_probe = kabylake_card_late_probe,
 };
 
@@ -1036,6 +1037,7 @@ static struct snd_soc_card kbl_audio_card_max98927 = {
 	.codec_conf = max98927_codec_conf,
 	.num_configs = ARRAY_SIZE(max98927_codec_conf),
 	.fully_routed = true,
+	.disable_route_checks = true,
 	.late_probe = kabylake_card_late_probe,
 };
 
@@ -1053,6 +1055,7 @@ static struct snd_soc_card kbl_audio_card_da7219_m98373 = {
 	.codec_conf = max98373_codec_conf,
 	.num_configs = ARRAY_SIZE(max98373_codec_conf),
 	.fully_routed = true,
+	.disable_route_checks = true,
 	.late_probe = kabylake_card_late_probe,
 };
 
@@ -1070,6 +1073,7 @@ static struct snd_soc_card kbl_audio_card_max98373 = {
 	.codec_conf = max98373_codec_conf,
 	.num_configs = ARRAY_SIZE(max98373_codec_conf),
 	.fully_routed = true,
+	.disable_route_checks = true,
 	.late_probe = kabylake_card_late_probe,
 };
 
diff --git a/sound/soc/intel/boards/kbl_rt5660.c b/sound/soc/intel/boards/kbl_rt5660.c
index 289ca39b8206e..776a1beaaf17d 100644
--- a/sound/soc/intel/boards/kbl_rt5660.c
+++ b/sound/soc/intel/boards/kbl_rt5660.c
@@ -519,6 +519,7 @@ static struct snd_soc_card kabylake_audio_card_rt5660 = {
 	.dapm_routes = kabylake_rt5660_map,
 	.num_dapm_routes = ARRAY_SIZE(kabylake_rt5660_map),
 	.fully_routed = true,
+	.disable_route_checks = true,
 	.late_probe = kabylake_card_late_probe,
 };
 
diff --git a/sound/soc/intel/boards/kbl_rt5663_max98927.c b/sound/soc/intel/boards/kbl_rt5663_max98927.c
index a3e040a249f6f..fa7d9cff98550 100644
--- a/sound/soc/intel/boards/kbl_rt5663_max98927.c
+++ b/sound/soc/intel/boards/kbl_rt5663_max98927.c
@@ -954,6 +954,7 @@ static struct snd_soc_card kabylake_audio_card_rt5663_m98927 = {
 	.codec_conf = max98927_codec_conf,
 	.num_configs = ARRAY_SIZE(max98927_codec_conf),
 	.fully_routed = true,
+	.disable_route_checks = true,
 	.late_probe = kabylake_card_late_probe,
 };
 
@@ -970,6 +971,7 @@ static struct snd_soc_card kabylake_audio_card_rt5663 = {
 	.dapm_routes = kabylake_5663_map,
 	.num_dapm_routes = ARRAY_SIZE(kabylake_5663_map),
 	.fully_routed = true,
+	.disable_route_checks = true,
 	.late_probe = kabylake_card_late_probe,
 };
 
diff --git a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
index dd38fdaf2ff58..673eaa8917067 100644
--- a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
+++ b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
@@ -779,6 +779,7 @@ static struct snd_soc_card kabylake_audio_card = {
 	.codec_conf = max98927_codec_conf,
 	.num_configs = ARRAY_SIZE(max98927_codec_conf),
 	.fully_routed = true,
+	.disable_route_checks = true,
 	.late_probe = kabylake_card_late_probe,
 };
 
diff --git a/sound/soc/intel/boards/skl_hda_dsp_generic.c b/sound/soc/intel/boards/skl_hda_dsp_generic.c
index f4b4eeca3e03c..6aad5232acbe4 100644
--- a/sound/soc/intel/boards/skl_hda_dsp_generic.c
+++ b/sound/soc/intel/boards/skl_hda_dsp_generic.c
@@ -229,6 +229,8 @@ static int skl_hda_audio_probe(struct platform_device *pdev)
 	ctx->common_hdmi_codec_drv = mach->mach_params.common_hdmi_codec_drv;
 
 	hda_soc_card.dev = &pdev->dev;
+	if (!snd_soc_acpi_sof_parent(&pdev->dev))
+		hda_soc_card.disable_route_checks = true;
 
 	if (mach->mach_params.dmic_num > 0) {
 		snprintf(hda_soc_components, sizeof(hda_soc_components),
diff --git a/sound/soc/intel/boards/skl_nau88l25_max98357a.c b/sound/soc/intel/boards/skl_nau88l25_max98357a.c
index e3a1f04a8b535..3b62e15da95fa 100644
--- a/sound/soc/intel/boards/skl_nau88l25_max98357a.c
+++ b/sound/soc/intel/boards/skl_nau88l25_max98357a.c
@@ -643,6 +643,7 @@ static struct snd_soc_card skylake_audio_card = {
 	.dapm_routes = skylake_map,
 	.num_dapm_routes = ARRAY_SIZE(skylake_map),
 	.fully_routed = true,
+	.disable_route_checks = true,
 	.late_probe = skylake_card_late_probe,
 };
 
diff --git a/sound/soc/intel/boards/skl_rt286.c b/sound/soc/intel/boards/skl_rt286.c
index 75dab5405380f..9c2ba695c1a16 100644
--- a/sound/soc/intel/boards/skl_rt286.c
+++ b/sound/soc/intel/boards/skl_rt286.c
@@ -524,6 +524,7 @@ static struct snd_soc_card skylake_rt286 = {
 	.dapm_routes = skylake_rt286_map,
 	.num_dapm_routes = ARRAY_SIZE(skylake_rt286_map),
 	.fully_routed = true,
+	.disable_route_checks = true,
 	.late_probe = skylake_card_late_probe,
 };
 
-- 
2.43.0




