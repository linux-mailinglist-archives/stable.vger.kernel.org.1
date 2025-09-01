Return-Path: <stable+bounces-176821-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C2CB3DF11
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 11:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E440F3A6E18
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 09:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47EE2FB993;
	Mon,  1 Sep 2025 09:55:10 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FEA32F5326
	for <stable@vger.kernel.org>; Mon,  1 Sep 2025 09:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756720510; cv=none; b=VkayNN4VhIzZOtoWaOE/Q5qteX3kOlnz33gIkfwl0JBSaG8+5z1cZ6VniKEqwllezN5voW8Y4R3yHsT6K/uilFOTjhpAK0CpbE2mUFW62DduQLwG/TCKEzp6BtkM8+CZMuxXMjFiy75CpVs739GwcNbKxCfLRSwaUVqppZEnSG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756720510; c=relaxed/simple;
	bh=kM9wxqvQbfa3iKfG7ukMTmDEjRUCNSyEKnsUCRbHl+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tSZu1ZSqxSDfZCY6ExIxKpiuu29lFw1co0m4Cy9LkIGpdaSAVE8CVkP3tPCgK5ZbwN9FjFQ+hGdUYv48c1cFYVkzO6vjVDmUnHyXycG8cSd0lRVS8SHh/xcR/TiZemZCBC3mRa7B4mxMDjwbFKZyCsHW17sKRspBSllG7Otaisk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from pomiot (c144-154.icpnet.pl [85.221.144.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: mgorny)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 84983335DB5;
	Mon, 01 Sep 2025 09:55:07 +0000 (UTC)
From: =?UTF-8?q?Micha=C5=82=20G=C3=B3rny?= <mgorny@gentoo.org>
To: stable@vger.kernel.org
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	=?UTF-8?q?Micha=C5=82=20G=C3=B3rny?= <mgorny@gentoo.org>
Subject: [PATCH linux-5.10.y 1/5] ASoC: Intel: bxt_da7219_max98357a: shrink platform_id below 20 characters
Date: Mon,  1 Sep 2025 11:54:36 +0200
Message-ID: <20250901095440.39935-1-mgorny@gentoo.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025082909-plutonium-freestyle-5283@gregkh>
References: <2025082909-plutonium-freestyle-5283@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

commit 24e46fb811e991f56d5694b10ae7ceb8d2b8c846 upstream.

The excessive platform id lengths are causing out-of-buffer reads
in depmod, e.g.:

depmod: FATAL: Module index: bad character '�'=0x80 - only 7-bit ASCII is supported:
platform:jsl_rt5682_max98360ax�

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20210511213707.32958-5-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Michał Górny <mgorny@gentoo.org>
---
 sound/soc/intel/boards/bxt_da7219_max98357a.c     | 12 ++++++------
 sound/soc/intel/common/soc-acpi-intel-bxt-match.c |  2 +-
 sound/soc/intel/common/soc-acpi-intel-cml-match.c |  2 +-
 sound/soc/intel/common/soc-acpi-intel-glk-match.c |  2 +-
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/sound/soc/intel/boards/bxt_da7219_max98357a.c b/sound/soc/intel/boards/bxt_da7219_max98357a.c
index 1a24c44db6dd..85738fd20b22 100644
--- a/sound/soc/intel/boards/bxt_da7219_max98357a.c
+++ b/sound/soc/intel/boards/bxt_da7219_max98357a.c
@@ -840,9 +840,9 @@ static int broxton_audio_probe(struct platform_device *pdev)
 }
 
 static const struct platform_device_id bxt_board_ids[] = {
-	{ .name = "bxt_da7219_max98357a" },
-	{ .name = "glk_da7219_max98357a" },
-	{ .name = "cml_da7219_max98357a" },
+	{ .name = "bxt_da7219_mx98357a" },
+	{ .name = "glk_da7219_mx98357a" },
+	{ .name = "cml_da7219_mx98357a" },
 	{ }
 };
 
@@ -866,6 +866,6 @@ MODULE_AUTHOR("Naveen Manohar <naveen.m@intel.com>");
 MODULE_AUTHOR("Mac Chiang <mac.chiang@intel.com>");
 MODULE_AUTHOR("Brent Lu <brent.lu@intel.com>");
 MODULE_LICENSE("GPL v2");
-MODULE_ALIAS("platform:bxt_da7219_max98357a");
-MODULE_ALIAS("platform:glk_da7219_max98357a");
-MODULE_ALIAS("platform:cml_da7219_max98357a");
+MODULE_ALIAS("platform:bxt_da7219_mx98357a");
+MODULE_ALIAS("platform:glk_da7219_mx98357a");
+MODULE_ALIAS("platform:cml_da7219_mx98357a");
diff --git a/sound/soc/intel/common/soc-acpi-intel-bxt-match.c b/sound/soc/intel/common/soc-acpi-intel-bxt-match.c
index 32f77e29c2ff..d467663f6757 100644
--- a/sound/soc/intel/common/soc-acpi-intel-bxt-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-bxt-match.c
@@ -56,7 +56,7 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_bxt_machines[] = {
 	},
 	{
 		.id = "DLGS7219",
-		.drv_name = "bxt_da7219_max98357a",
+		.drv_name = "bxt_da7219_mx98357a",
 		.fw_filename = "intel/dsp_fw_bxtn.bin",
 		.machine_quirk = snd_soc_acpi_codec_list,
 		.quirk_data = &bxt_codecs,
diff --git a/sound/soc/intel/common/soc-acpi-intel-cml-match.c b/sound/soc/intel/common/soc-acpi-intel-cml-match.c
index 9b85811ffd51..43bba5670ab1 100644
--- a/sound/soc/intel/common/soc-acpi-intel-cml-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-cml-match.c
@@ -54,7 +54,7 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_cml_machines[] = {
 	},
 	{
 		.id = "DLGS7219",
-		.drv_name = "cml_da7219_max98357a",
+		.drv_name = "cml_da7219_mx98357a",
 		.machine_quirk = snd_soc_acpi_codec_list,
 		.quirk_data = &max98357a_spk_codecs,
 		.sof_fw_filename = "sof-cml.ri",
diff --git a/sound/soc/intel/common/soc-acpi-intel-glk-match.c b/sound/soc/intel/common/soc-acpi-intel-glk-match.c
index 26cb3b16cdd3..ac8f77d0afa9 100644
--- a/sound/soc/intel/common/soc-acpi-intel-glk-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-glk-match.c
@@ -24,7 +24,7 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_glk_machines[] = {
 	},
 	{
 		.id = "DLGS7219",
-		.drv_name = "glk_da7219_max98357a",
+		.drv_name = "glk_da7219_mx98357a",
 		.fw_filename = "intel/dsp_fw_glk.bin",
 		.machine_quirk = snd_soc_acpi_codec_list,
 		.quirk_data = &glk_codecs,

