Return-Path: <stable+bounces-176824-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 031F3B3DF14
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 11:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 569683A86BA
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 09:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD0D330DD1B;
	Mon,  1 Sep 2025 09:55:14 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A42F30DD0B
	for <stable@vger.kernel.org>; Mon,  1 Sep 2025 09:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756720514; cv=none; b=JtwcwgiaVKPfIyRZy9VjAJ/7PJaZpcOHv514aW8FJUtL9b833Hy1FV5+QoR6hVM0OjzbMGRwrH3i5e/taK7IgqtN8VEABjhYk3+uVygNFewrzPTGF7SgtOOGCzeJp+4KZmKycumzVxg9DrePW6w50ZdL+vpskAzCY5r1aJsRP3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756720514; c=relaxed/simple;
	bh=Kgv8cj3n6y6QL7JxSO5nTiqorjZO9pLykdnt0sykH6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nh7d8CD69iLrnKGJ4ZAkApXJPud86mc2uyq+iDso6TpNQYyLSgiYmULMga2akkfpiT9Eh3zZ2qQDM3eNsAkH57nmy0zB7JGSTmllhcA90q+9dX2tYfSU8KcTE/Caul1Vv2lnae0KL3UaSBVZ71vBCqK3ajceb/Q/LGQ4vmCU24M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from pomiot (c144-154.icpnet.pl [85.221.144.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: mgorny)
	by smtp.gentoo.org (Postfix) with ESMTPSA id DB757335DB5;
	Mon, 01 Sep 2025 09:55:11 +0000 (UTC)
From: =?UTF-8?q?Micha=C5=82=20G=C3=B3rny?= <mgorny@gentoo.org>
To: stable@vger.kernel.org
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH linux-5.10.y 4/5] ASoC: Intel: sof_da7219_max98373: shrink platform_id below 20 characters
Date: Mon,  1 Sep 2025 11:54:39 +0200
Message-ID: <20250901095440.39935-4-mgorny@gentoo.org>
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

commit 1cc04d195dc245457a45df60e6558b460b8e4c71 upstream.

The excessive platform id lengths are causing out-of-buffer reads
in depmod, e.g.:

depmod: FATAL: Module index: bad character '�'=0x80 - only 7-bit ASCII is supported:
platform:jsl_rt5682_max98360ax�

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20210621194057.21711-7-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/sof_da7219_max98373.c      | 8 ++++----
 sound/soc/intel/common/soc-acpi-intel-jsl-match.c | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/intel/boards/sof_da7219_max98373.c b/sound/soc/intel/boards/sof_da7219_max98373.c
index 8d1ad892e86b..387bc8c962d9 100644
--- a/sound/soc/intel/boards/sof_da7219_max98373.c
+++ b/sound/soc/intel/boards/sof_da7219_max98373.c
@@ -431,11 +431,11 @@ static int audio_probe(struct platform_device *pdev)
 
 static const struct platform_device_id board_ids[] = {
 	{
-		.name = "sof_da7219_max98373",
+		.name = "sof_da7219_mx98373",
 		.driver_data = (kernel_ulong_t)&card_da7219_m98373,
 	},
 	{
-		.name = "sof_da7219_max98360a",
+		.name = "sof_da7219_mx98360a",
 		.driver_data = (kernel_ulong_t)&card_da7219_m98360a,
 	},
 	{ }
@@ -456,5 +456,5 @@ module_platform_driver(audio)
 MODULE_DESCRIPTION("ASoC Intel(R) SOF Machine driver");
 MODULE_AUTHOR("Yong Zhi <yong.zhi@intel.com>");
 MODULE_LICENSE("GPL v2");
-MODULE_ALIAS("platform:sof_da7219_max98360a");
-MODULE_ALIAS("platform:sof_da7219_max98373");
+MODULE_ALIAS("platform:sof_da7219_mx98360a");
+MODULE_ALIAS("platform:sof_da7219_mx98373");
diff --git a/sound/soc/intel/common/soc-acpi-intel-jsl-match.c b/sound/soc/intel/common/soc-acpi-intel-jsl-match.c
index a539b65ba254..6695168e01f6 100644
--- a/sound/soc/intel/common/soc-acpi-intel-jsl-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-jsl-match.c
@@ -32,7 +32,7 @@ static struct snd_soc_acpi_codecs mx98360a_spk = {
 struct snd_soc_acpi_mach snd_soc_acpi_intel_jsl_machines[] = {
 	{
 		.id = "DLGS7219",
-		.drv_name = "sof_da7219_max98373",
+		.drv_name = "sof_da7219_mx98373",
 		.sof_fw_filename = "sof-jsl.ri",
 		.sof_tplg_filename = "sof-jsl-da7219.tplg",
 		.machine_quirk = snd_soc_acpi_codec_list,
@@ -40,7 +40,7 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_jsl_machines[] = {
 	},
 	{
 		.id = "DLGS7219",
-		.drv_name = "sof_da7219_max98360a",
+		.drv_name = "sof_da7219_mx98360a",
 		.sof_fw_filename = "sof-jsl.ri",
 		.sof_tplg_filename = "sof-jsl-da7219-mx98360a.tplg",
 	},

