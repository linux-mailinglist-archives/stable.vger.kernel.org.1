Return-Path: <stable+bounces-94915-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D82089D70B2
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:37:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64738161044
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 13:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0727A1B4F02;
	Sun, 24 Nov 2024 13:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AyBVT1TQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CB61B3953;
	Sun, 24 Nov 2024 13:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455225; cv=none; b=CLe4EhXFBtftbqjWbxEwAk/7pOLQspnGZ4soso4NZAMaMw9Q95tFPXWfAJeTYkPupAUapZmKmmE7aAQG3aX4CXbdduMqvaZxNtWsxMSZ/kbNX6dwvGcvGiPhYgsnOEGd4dQiV7yLcv34Um/eIF9TbO/VMkuOh7S7jDlsLr+i5kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455225; c=relaxed/simple;
	bh=gwKTWdmOhGpSurPbqJlS6FMGkVNclBJwZ67crx0Kyd8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jrQwd00keweQ5h8muyru9Se4wy0gaFuZ/l0Ztvo/6bngd9Oc5EdN7F+FF7JK3mkWocQo6M99PCTPwaBD1nhbfMJXKv8NxkddBSr0XwyWYrCC9PuAcWI1dQrDmrP1Gn/wrX226PmJQ2yVKcN4MjQ4AGHpbDrLtTh9fuVr3aYyYxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AyBVT1TQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 794A6C4CECC;
	Sun, 24 Nov 2024 13:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455225;
	bh=gwKTWdmOhGpSurPbqJlS6FMGkVNclBJwZ67crx0Kyd8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AyBVT1TQfW60LMHmkS/Vd694jtqfJjLuU72ai1n09nWaY1AvbMbJ7FxZqnAXRxP7X
	 Na0Rejs9wT/Rj+EH8E3AyyiBUzo0gHCbGTza2Jytvd6s6DDBnPPsCegtCsjjFt5qjR
	 CYDabSYs8nfuu4iHCG5cjN905p2Bv2giEPPP5OaDa6LJzny7hUV4UTseW1iqLXq66C
	 QIjT989gxko1iXxewMG9SADBVHLZeIvjYEZ95tCzXHcEaZVti8rGWPrEcU9hHieoso
	 NjeK8MIEL0TltLoNBQD5A7VX85FGv8HRicIAmjUOGbccAfx/XrxXixe4y/qtgYpwpC
	 HzslRdBMZMgCA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Balamurugan C <balamurugan.c@intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	=?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	cezary.rojewski@intel.com,
	liam.r.girdwood@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	kai.vehmanen@linux.intel.com,
	perex@perex.cz,
	tiwai@suse.com,
	pierre-louis.bossart@linux.dev,
	brent.lu@intel.com,
	ckeepax@opensource.cirrus.com,
	mstrozek@opensource.cirrus.com,
	chao.song@linux.intel.com,
	rf@opensource.cirrus.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 019/107] ASoC: Intel: sof_rt5682: Add HDMI-In capture with rt5682 support for MTL.
Date: Sun, 24 Nov 2024 08:28:39 -0500
Message-ID: <20241124133301.3341829-19-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124133301.3341829-1-sashal@kernel.org>
References: <20241124133301.3341829-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.1
Content-Transfer-Encoding: 8bit

From: Balamurugan C <balamurugan.c@intel.com>

[ Upstream commit 0f5d2228a99a4733b2a6652e16255be9caf2616a ]

Added match table entry on mtl machines to support HDMI-In capture
with rt5682 I2S audio codec. also added the respective quirk
configuration in rt5682 machine driver.

Signed-off-by: Balamurugan C <balamurugan.c@intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Link: https://patch.msgid.link/20241004030135.67968-2-yung-chuan.liao@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/boards/sof_rt5682.c               | 7 +++++++
 sound/soc/intel/common/soc-acpi-intel-mtl-match.c | 7 +++++++
 2 files changed, 14 insertions(+)

diff --git a/sound/soc/intel/boards/sof_rt5682.c b/sound/soc/intel/boards/sof_rt5682.c
index bc581fea0e3a1..866589fece7a3 100644
--- a/sound/soc/intel/boards/sof_rt5682.c
+++ b/sound/soc/intel/boards/sof_rt5682.c
@@ -870,6 +870,13 @@ static const struct platform_device_id board_ids[] = {
 					SOF_SSP_PORT_BT_OFFLOAD(2) |
 					SOF_BT_OFFLOAD_PRESENT),
 	},
+	{
+		.name = "mtl_rt5682_c1_h02",
+		.driver_data = (kernel_ulong_t)(SOF_RT5682_MCLK_EN |
+					SOF_SSP_PORT_CODEC(1) |
+					/* SSP 0 and SSP 2 are used for HDMI IN */
+					SOF_SSP_MASK_HDMI_CAPTURE(0x5)),
+	},
 	{
 		.name = "arl_rt5682_c1_h02",
 		.driver_data = (kernel_ulong_t)(SOF_RT5682_MCLK_EN |
diff --git a/sound/soc/intel/common/soc-acpi-intel-mtl-match.c b/sound/soc/intel/common/soc-acpi-intel-mtl-match.c
index d4435a34a3a3f..fd02c864e25ef 100644
--- a/sound/soc/intel/common/soc-acpi-intel-mtl-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-mtl-match.c
@@ -42,6 +42,13 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_mtl_machines[] = {
 					SND_SOC_ACPI_TPLG_INTEL_SSP_MSB |
 					SND_SOC_ACPI_TPLG_INTEL_DMIC_NUMBER,
 	},
+	{
+		.comp_ids = &mtl_rt5682_rt5682s_hp,
+		.drv_name = "mtl_rt5682_c1_h02",
+		.machine_quirk = snd_soc_acpi_codec_list,
+		.quirk_data = &mtl_lt6911_hdmi,
+		.sof_tplg_filename = "sof-mtl-rt5682-ssp1-hdmi-ssp02.tplg",
+	},
 	/* place boards for each headphone codec: sof driver will complete the
 	 * tplg name and machine driver will detect the amp type
 	 */
-- 
2.43.0


