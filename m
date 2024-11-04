Return-Path: <stable+bounces-89639-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C2669BB1E9
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 11:58:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B05AF1C21AB0
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 10:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D83B1D096F;
	Mon,  4 Nov 2024 10:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fZbM6tDK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310441B86CC;
	Mon,  4 Nov 2024 10:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730717564; cv=none; b=fNmolqnBkmMqKmr8z/Yqmjplkktl9cVOwwgw2a6QnAT92/G7YXzNzDn0nkbNynTn7z2iZX3rSqgebK03bOAp1UAtprIrCulz/sT+DfZMmvlehx/W9w1TZze/RSWMUVdSXZlHnFi5L8DZ5UWWgGTmYlF53X2rRak8C79dy2nFahE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730717564; c=relaxed/simple;
	bh=lPeDna9M3oHM6ZuSmc/fmvPvdn/xIwXzu0m4Hpr7x0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aswou+izjYFClzIJJD9mZkUGGjfv6JTorPZJBISUY7sVeRGdHyr6gD/Fwufnmzx05zvAH9CrhWIrgiyr4/LCaCDrRqOcqhwvryc1sKCKhbcFS8LgDHNZ3dn0w1oz8tlmAFef0ZYKkqOwsE/HNYSBx49gYQv4I2Pa4zAWzoMoe0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fZbM6tDK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34876C4CED1;
	Mon,  4 Nov 2024 10:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730717564;
	bh=lPeDna9M3oHM6ZuSmc/fmvPvdn/xIwXzu0m4Hpr7x0o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fZbM6tDKtU2lK6OusHavMhEb33dIIZPyAqx9oiPvSE5/i67ZJN/JkOMn1eKN7H03F
	 XFToiBesdtwIVdutDkQC/sV6zj1Ff3Vc/A/tp/A7mlVugV2XUP10ZqaZFgov8qeEno
	 /2/VpyFyK6ITl5a1qdslBMhfbftBWtRPtDuLPydZCn74RoZ9OMLHi5u0VQSPorGFSW
	 YczPoWepddlqQXcUNWfoVzcCMjb757e8BRKom/wjcUsjAKwXivk0rJ+YVjYRBBnHXM
	 H+A1FPm1/bUHdiuHY0qwxoaGOXWWWRh7cUUWKsYyepqfwAYcebnvdRJZCetR66SBFF
	 wNfE+P2P2OlJg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	cezary.rojewski@intel.com,
	liam.r.girdwood@linux.intel.com,
	peter.ujfalusi@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	kai.vehmanen@linux.intel.com,
	pierre-louis.bossart@linux.dev,
	amadeuszx.slawinski@linux.intel.com,
	u.kleine-koenig@baylibre.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 05/14] ASoC: Intel: sst: Support LPE0F28 ACPI HID
Date: Mon,  4 Nov 2024 05:51:57 -0500
Message-ID: <20241104105228.97053-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241104105228.97053-1-sashal@kernel.org>
References: <20241104105228.97053-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.59
Content-Transfer-Encoding: 8bit

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 6668610b4d8ce9a3ee3ed61a9471f62fb5f05bf9 ]

Some old Bay Trail tablets which shipped with Android as factory OS
have the SST/LPE audio engine described by an ACPI device with a
HID (Hardware-ID) of LPE0F28 instead of 80860F28.

Add support for this. Note this uses a new sst_res_info for just
the LPE0F28 case because it has a different layout for the IO-mem ACPI
resources then the 80860F28.

An example of a tablet which needs this is the Vexia EDU ATLA 10 tablet,
which has been distributed to schools in the Spanish Andalucía region.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Link: https://patch.msgid.link/20241025090221.52198-1-hdegoede@redhat.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/hda/intel-dsp-config.c        |  4 ++
 sound/soc/intel/atom/sst/sst_acpi.c | 64 +++++++++++++++++++++++++----
 2 files changed, 59 insertions(+), 9 deletions(-)

diff --git a/sound/hda/intel-dsp-config.c b/sound/hda/intel-dsp-config.c
index e7c2ef6c6b4cb..16a3e478e50b9 100644
--- a/sound/hda/intel-dsp-config.c
+++ b/sound/hda/intel-dsp-config.c
@@ -721,6 +721,10 @@ static const struct config_entry acpi_config_table[] = {
 #if IS_ENABLED(CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_ACPI) || \
     IS_ENABLED(CONFIG_SND_SOC_SOF_BAYTRAIL)
 /* BayTrail */
+	{
+		.flags = FLAG_SST_OR_SOF_BYT,
+		.acpi_hid = "LPE0F28",
+	},
 	{
 		.flags = FLAG_SST_OR_SOF_BYT,
 		.acpi_hid = "80860F28",
diff --git a/sound/soc/intel/atom/sst/sst_acpi.c b/sound/soc/intel/atom/sst/sst_acpi.c
index 29d44c989e5fc..1f9bb1b84949d 100644
--- a/sound/soc/intel/atom/sst/sst_acpi.c
+++ b/sound/soc/intel/atom/sst/sst_acpi.c
@@ -125,6 +125,28 @@ static const struct sst_res_info bytcr_res_info = {
 	.acpi_ipc_irq_index = 0
 };
 
+/* For "LPE0F28" ACPI device found on some Android factory OS models */
+static const struct sst_res_info lpe8086_res_info = {
+	.shim_offset = 0x140000,
+	.shim_size = 0x000100,
+	.shim_phy_addr = SST_BYT_SHIM_PHY_ADDR,
+	.ssp0_offset = 0xa0000,
+	.ssp0_size = 0x1000,
+	.dma0_offset = 0x98000,
+	.dma0_size = 0x4000,
+	.dma1_offset = 0x9c000,
+	.dma1_size = 0x4000,
+	.iram_offset = 0x0c0000,
+	.iram_size = 0x14000,
+	.dram_offset = 0x100000,
+	.dram_size = 0x28000,
+	.mbox_offset = 0x144000,
+	.mbox_size = 0x1000,
+	.acpi_lpe_res_index = 1,
+	.acpi_ddr_index = 0,
+	.acpi_ipc_irq_index = 0
+};
+
 static struct sst_platform_info byt_rvp_platform_data = {
 	.probe_data = &byt_fwparse_info,
 	.ipc_info = &byt_ipc_info,
@@ -268,10 +290,38 @@ static int sst_acpi_probe(struct platform_device *pdev)
 		mach->pdata = &chv_platform_data;
 	pdata = mach->pdata;
 
-	ret = kstrtouint(id->id, 16, &dev_id);
-	if (ret < 0) {
-		dev_err(dev, "Unique device id conversion error: %d\n", ret);
-		return ret;
+	if (!strcmp(id->id, "LPE0F28")) {
+		struct resource *rsrc;
+
+		/* Use regular BYT SST PCI VID:PID */
+		dev_id = 0x80860F28;
+		byt_rvp_platform_data.res_info = &lpe8086_res_info;
+
+		/*
+		 * The "LPE0F28" ACPI device has separate IO-mem resources for:
+		 * DDR, SHIM, MBOX, IRAM, DRAM, CFG
+		 * None of which covers the entire LPE base address range.
+		 * lpe8086_res_info.acpi_lpe_res_index points to the SHIM.
+		 * Patch this to cover the entire base address range as expected
+		 * by sst_platform_get_resources().
+		 */
+		rsrc = platform_get_resource(pdev, IORESOURCE_MEM,
+					     pdata->res_info->acpi_lpe_res_index);
+		if (!rsrc) {
+			dev_err(ctx->dev, "Invalid SHIM base\n");
+			return -EIO;
+		}
+		rsrc->start -= pdata->res_info->shim_offset;
+		rsrc->end = rsrc->start + 0x200000 - 1;
+	} else {
+		ret = kstrtouint(id->id, 16, &dev_id);
+		if (ret < 0) {
+			dev_err(dev, "Unique device id conversion error: %d\n", ret);
+			return ret;
+		}
+
+		if (soc_intel_is_byt_cr(pdev))
+			byt_rvp_platform_data.res_info = &bytcr_res_info;
 	}
 
 	dev_dbg(dev, "ACPI device id: %x\n", dev_id);
@@ -280,11 +330,6 @@ static int sst_acpi_probe(struct platform_device *pdev)
 	if (ret < 0)
 		return ret;
 
-	if (soc_intel_is_byt_cr(pdev)) {
-		/* override resource info */
-		byt_rvp_platform_data.res_info = &bytcr_res_info;
-	}
-
 	/* update machine parameters */
 	mach->mach_params.acpi_ipc_irq_index =
 		pdata->res_info->acpi_ipc_irq_index;
@@ -344,6 +389,7 @@ static void sst_acpi_remove(struct platform_device *pdev)
 }
 
 static const struct acpi_device_id sst_acpi_ids[] = {
+	{ "LPE0F28", (unsigned long)&snd_soc_acpi_intel_baytrail_machines},
 	{ "80860F28", (unsigned long)&snd_soc_acpi_intel_baytrail_machines},
 	{ "808622A8", (unsigned long)&snd_soc_acpi_intel_cherrytrail_machines},
 	{ },
-- 
2.43.0


