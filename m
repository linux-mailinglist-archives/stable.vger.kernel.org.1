Return-Path: <stable+bounces-176823-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B90EB3DF13
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 11:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 436FF3A7F51
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 09:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7485018E25;
	Mon,  1 Sep 2025 09:55:13 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E42B30C364
	for <stable@vger.kernel.org>; Mon,  1 Sep 2025 09:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756720513; cv=none; b=tKXCZfV28IZt3V6LlDEcejasxTnuG/s/08R5fQRlEKMPP0voCd/PU04x4YaZazmQOGqis6cWUb0enXbdW4kGurmT6xT5r2WU1xSe5qO8HI7siyn3z1lpa4cYOA/dVbkLbJk5fH+winIymO9vzmvCZpEiBztztiqsVvCEd/lpKmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756720513; c=relaxed/simple;
	bh=D/WwThsbkyE1jgepngGwD+3xw99B/fTF6wYnABN6uH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R4yT06O0FIonl+WWnh1222Dlk531kUVAhdjLEoVQFsYQR9ZYYdHjHJIRZHO2CaFlt3zlyk/tt5wnwFe5f3o4SIMb2b1YQ+8C50WWqdYfCfrRN0SXuEfaAkIYCHqnyN3NWHVu5CGkV0Jiin3+7TNEb/xnz7DLz9yJMzjDQn3iOmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from pomiot (c144-154.icpnet.pl [85.221.144.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: mgorny)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 6DB9133BF41;
	Mon, 01 Sep 2025 09:55:10 +0000 (UTC)
From: =?UTF-8?q?Micha=C5=82=20G=C3=B3rny?= <mgorny@gentoo.org>
To: stable@vger.kernel.org
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	=?UTF-8?q?Micha=C5=82=20G=C3=B3rny?= <mgorny@gentoo.org>
Subject: [PATCH linux-5.10.y 3/5] ASoC: Intel: glk_rt5682_max98357a: shrink platform_id below 20 characters
Date: Mon,  1 Sep 2025 11:54:38 +0200
Message-ID: <20250901095440.39935-3-mgorny@gentoo.org>
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

commit bc47256afef38175a0ad6bcfd4dbab9d2c65b377 upstream.

The excessive platform id lengths are causing out-of-buffer reads
in depmod, e.g.:

depmod: FATAL: Module index: bad character '�'=0x80 - only 7-bit ASCII is supported:
platform:jsl_rt5682_max98360ax�

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20210621194057.21711-5-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Michał Górny <mgorny@gentoo.org>
---
 sound/soc/intel/boards/glk_rt5682_max98357a.c     | 4 ++--
 sound/soc/intel/common/soc-acpi-intel-glk-match.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/boards/glk_rt5682_max98357a.c b/sound/soc/intel/boards/glk_rt5682_max98357a.c
index c1b789ac6d50..005bd96175cf 100644
--- a/sound/soc/intel/boards/glk_rt5682_max98357a.c
+++ b/sound/soc/intel/boards/glk_rt5682_max98357a.c
@@ -621,7 +621,7 @@ static int geminilake_audio_probe(struct platform_device *pdev)
 
 static const struct platform_device_id glk_board_ids[] = {
 	{
-		.name = "glk_rt5682_max98357a",
+		.name = "glk_rt5682_mx98357a",
 		.driver_data =
 			(kernel_ulong_t)&glk_audio_card_rt5682_m98357a,
 	},
@@ -643,4 +643,4 @@ MODULE_DESCRIPTION("Geminilake Audio Machine driver-RT5682 & MAX98357A in I2S mo
 MODULE_AUTHOR("Naveen Manohar <naveen.m@intel.com>");
 MODULE_AUTHOR("Harsha Priya <harshapriya.n@intel.com>");
 MODULE_LICENSE("GPL v2");
-MODULE_ALIAS("platform:glk_rt5682_max98357a");
+MODULE_ALIAS("platform:glk_rt5682_mx98357a");
diff --git a/sound/soc/intel/common/soc-acpi-intel-glk-match.c b/sound/soc/intel/common/soc-acpi-intel-glk-match.c
index ac8f77d0afa9..e05db22d860c 100644
--- a/sound/soc/intel/common/soc-acpi-intel-glk-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-glk-match.c
@@ -33,7 +33,7 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_glk_machines[] = {
 	},
 	{
 		.id = "10EC5682",
-		.drv_name = "glk_rt5682_max98357a",
+		.drv_name = "glk_rt5682_mx98357a",
 		.fw_filename = "intel/dsp_fw_glk.bin",
 		.machine_quirk = snd_soc_acpi_codec_list,
 		.quirk_data = &glk_codecs,

