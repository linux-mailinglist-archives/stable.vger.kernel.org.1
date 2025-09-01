Return-Path: <stable+bounces-176822-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7623BB3DF12
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 11:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBD071888364
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 09:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FCF530C608;
	Mon,  1 Sep 2025 09:55:12 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1C118E25
	for <stable@vger.kernel.org>; Mon,  1 Sep 2025 09:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756720511; cv=none; b=YwYGiIZxLxmNN3fXVlmAmtL2yXlUfTOtWpyijr0yu5fKNlAc8A8LaOU80kC/hzYCVG6+MNzjpdOMGT4P8AW9yakjRkyPv9fHJLOG+UUX0WxRzkToZ07H5jWz4ZQZbbzTlgTQygvadtrtOmljgX6y7893ERvSlxCp29pUzA8vgdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756720511; c=relaxed/simple;
	bh=IHX/5cJeUHpTZOSNg6+ZkCQmjvy/tQ+Dc5IB8znzBRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q1rX3EXcKi+dR4cGNFZ6weH6RJSvAwaD00/X7HWbincBwrJpfKtzyVjeCPEbRRFEhQuUM3dcJOCl9ZLGMqTkm6bYSE7n+pqMo5IgnGPvPLbb6fzXX0RinOrxS3EqaVOfIj0xqvHyRNSqum7GXAewPfcTw00XuySawZL/9LnxWE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from pomiot (c144-154.icpnet.pl [85.221.144.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: mgorny)
	by smtp.gentoo.org (Postfix) with ESMTPSA id F38F033BF39;
	Mon, 01 Sep 2025 09:55:08 +0000 (UTC)
From: =?UTF-8?q?Micha=C5=82=20G=C3=B3rny?= <mgorny@gentoo.org>
To: stable@vger.kernel.org
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	=?UTF-8?q?Micha=C5=82=20G=C3=B3rny?= <mgorny@gentoo.org>
Subject: [PATCH linux-5.10.y 2/5] ASoC: Intel: sof_rt5682: shrink platform_id names below 20 characters
Date: Mon,  1 Sep 2025 11:54:37 +0200
Message-ID: <20250901095440.39935-2-mgorny@gentoo.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250901095440.39935-1-mgorny@gentoo.org>
References: <2025082909-plutonium-freestyle-5283@gregkh>
 <20250901095440.39935-1-mgorny@gentoo.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

commit 590cfb082837cc6c0c595adf1711330197c86a58 upstream.

The excessive platform id lengths are causing out-of-buffer reads
in depmod, e.g.:

depmod: FATAL: Module index: bad character '�'=0x80 - only 7-bit ASCII is supported:
platform:jsl_rt5682_max98360ax�

I needed to account for some of the drivers being missing in 5.10
while rebasing (i.e. mismatched context).

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20210621194057.21711-4-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Michał Górny <mgorny@gentoo.org>
---
 sound/soc/intel/boards/sof_rt5682.c               | 12 ++++++------
 sound/soc/intel/common/soc-acpi-intel-jsl-match.c |  2 +-
 sound/soc/intel/common/soc-acpi-intel-tgl-match.c |  4 ++--
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/sound/soc/intel/boards/sof_rt5682.c b/sound/soc/intel/boards/sof_rt5682.c
index 5883d1fa3b7e..414dc594014d 100644
--- a/sound/soc/intel/boards/sof_rt5682.c
+++ b/sound/soc/intel/boards/sof_rt5682.c
@@ -844,7 +844,7 @@ static const struct platform_device_id board_ids[] = {
 		.name = "sof_rt5682",
 	},
 	{
-		.name = "tgl_max98357a_rt5682",
+		.name = "tgl_mx98357a_rt5682",
 		.driver_data = (kernel_ulong_t)(SOF_RT5682_MCLK_EN |
 					SOF_RT5682_SSP_CODEC(0) |
 					SOF_SPEAKER_AMP_PRESENT |
@@ -861,7 +861,7 @@ static const struct platform_device_id board_ids[] = {
 					SOF_RT5682_SSP_AMP(1)),
 	},
 	{
-		.name = "tgl_max98373_rt5682",
+		.name = "tgl_mx98373_rt5682",
 		.driver_data = (kernel_ulong_t)(SOF_RT5682_MCLK_EN |
 					SOF_RT5682_SSP_CODEC(0) |
 					SOF_SPEAKER_AMP_PRESENT |
@@ -870,7 +870,7 @@ static const struct platform_device_id board_ids[] = {
 					SOF_RT5682_NUM_HDMIDEV(4)),
 	},
 	{
-		.name = "jsl_rt5682_max98360a",
+		.name = "jsl_rt5682_mx98360a",
 		.driver_data = (kernel_ulong_t)(SOF_RT5682_MCLK_EN |
 					SOF_RT5682_MCLK_24MHZ |
 					SOF_RT5682_SSP_CODEC(0) |
@@ -898,7 +898,7 @@ MODULE_AUTHOR("Bard Liao <bard.liao@intel.com>");
 MODULE_AUTHOR("Sathya Prakash M R <sathya.prakash.m.r@intel.com>");
 MODULE_LICENSE("GPL v2");
 MODULE_ALIAS("platform:sof_rt5682");
-MODULE_ALIAS("platform:tgl_max98357a_rt5682");
+MODULE_ALIAS("platform:tgl_mx98357a_rt5682");
 MODULE_ALIAS("platform:jsl_rt5682_rt1015");
-MODULE_ALIAS("platform:tgl_max98373_rt5682");
-MODULE_ALIAS("platform:jsl_rt5682_max98360a");
+MODULE_ALIAS("platform:tgl_mx98373_rt5682");
+MODULE_ALIAS("platform:jsl_rt5682_mx98360a");
diff --git a/sound/soc/intel/common/soc-acpi-intel-jsl-match.c b/sound/soc/intel/common/soc-acpi-intel-jsl-match.c
index 34f5fcad5701..a539b65ba254 100644
--- a/sound/soc/intel/common/soc-acpi-intel-jsl-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-jsl-match.c
@@ -54,7 +54,7 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_jsl_machines[] = {
 	},
 	{
 		.id = "10EC5682",
-		.drv_name = "jsl_rt5682_max98360a",
+		.drv_name = "jsl_rt5682_mx98360a",
 		.sof_fw_filename = "sof-jsl.ri",
 		.machine_quirk = snd_soc_acpi_codec_list,
 		.quirk_data = &mx98360a_spk,
diff --git a/sound/soc/intel/common/soc-acpi-intel-tgl-match.c b/sound/soc/intel/common/soc-acpi-intel-tgl-match.c
index 15d862cdcd2f..f7c491eba1e7 100644
--- a/sound/soc/intel/common/soc-acpi-intel-tgl-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-tgl-match.c
@@ -321,7 +321,7 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_tgl_machines[] = {
 	},
 	{
 		.id = "10EC5682",
-		.drv_name = "tgl_max98357a_rt5682",
+		.drv_name = "tgl_mx98357a_rt5682",
 		.machine_quirk = snd_soc_acpi_codec_list,
 		.quirk_data = &tgl_codecs,
 		.sof_fw_filename = "sof-tgl.ri",
@@ -329,7 +329,7 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_tgl_machines[] = {
 	},
 	{
 		.id = "10EC5682",
-		.drv_name = "tgl_max98373_rt5682",
+		.drv_name = "tgl_mx98373_rt5682",
 		.machine_quirk = snd_soc_acpi_codec_list,
 		.quirk_data = &tgl_max98373_amp,
 		.sof_fw_filename = "sof-tgl.ri",

