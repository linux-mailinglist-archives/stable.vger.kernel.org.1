Return-Path: <stable+bounces-176865-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB309B3E6BC
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 16:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C42B916D9CA
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 14:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F37EC2EF643;
	Mon,  1 Sep 2025 14:11:29 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DBF2566DD
	for <stable@vger.kernel.org>; Mon,  1 Sep 2025 14:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756735889; cv=none; b=PTVwXMcOQ3UpoopP1LBtg1G8NwncubnkN28S+eNgwjQ41zDfm2MD0vf+yfhY4EeuGfnE3KwAxYlAJEuT15S9VA+CYpoZZ7TlVyWO7QSbKsEfAYmRXmKp1jkAG/Qt5ABeEGWRAVOKncMdHp38rwVE/hoZssXD4UBQn/wDhLXlZGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756735889; c=relaxed/simple;
	bh=JxjbOSKiea0RyHNQhTiW/tpNHvI/zKSczFt824xsAgg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kUbfvZGDb5MftHwOc7U0dCb/AWKeBWdxgzXePivU7/Cn8df4D0vNydqFZtD7B23ZaKqqdujohWOr+gsMbDHWkJPYhLQgRomKDk1QBJbCxuXHslIDi4UTwN1Imhv8Ffxt4Y60XMeRh9n+WVFWMDy3dEwtoT3rtowcs/ePqQ72ddw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from pomiot (c144-154.icpnet.pl [85.221.144.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: mgorny)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 4BB50340F29;
	Mon, 01 Sep 2025 14:11:26 +0000 (UTC)
From: =?UTF-8?q?Micha=C5=82=20G=C3=B3rny?= <mgorny@gentoo.org>
To: stable@vger.kernel.org
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Paul Olaru <paul.olaru@oss.nxp.com>,
	Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
	Rander Wang <rander.wang@intel.com>,
	Mark Brown <broonie@kernel.org>,
	=?UTF-8?q?Micha=C5=82=20G=C3=B3rny?= <mgorny@gentoo.org>
Subject: [PATCH v2 linux-5.10.y 1/5] ASoC: Intel: bxt_da7219_max98357a: shrink platform_id below 20 characters
Date: Mon,  1 Sep 2025 16:10:54 +0200
Message-ID: <20250901141117.96236-1-mgorny@gentoo.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025090101-exert-deceased-3071@gregkh>
References: <2025090101-exert-deceased-3071@gregkh>
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

Sparse throwns the following warnings:

sound/soc/intel/boards/bxt_da7219_max98357a.c:843:19: error: too long
initializer-string for array of char(no space for nul char)

sound/soc/intel/boards/bxt_da7219_max98357a.c:844:19: error: too long
initializer-string for array of char(no space for nul char)

sound/soc/intel/boards/bxt_da7219_max98357a.c:845:19: error: too long
initializer-string for array of char(no space for nul char)

Fix by using the 'mx' acronyn for Maxim

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Paul Olaru <paul.olaru@oss.nxp.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
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

