Return-Path: <stable+bounces-102585-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 405229EF2BD
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:52:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0A9F2926E9
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 16:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37768235891;
	Thu, 12 Dec 2024 16:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nzIEHEr4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E318322145E;
	Thu, 12 Dec 2024 16:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734021760; cv=none; b=M3cI08RbeMQ2Kj/R8TFnDHGYTGu4kE9YVBA4qYTcOcyx6nncb2GBQhx4Pt1MQGSZYkgZWawBgRWurxp3I5YacZDBsMbPFTq6PnSWDJ0m/cD0J35nSY2baqMN+WLUQBa8NvELwRgVRfGDJU34tsK3WCE1mnoz2sR6u/LPZFT5Vlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734021760; c=relaxed/simple;
	bh=ism6XkSYR3ViRlZWO5GQyzO4O2U6SjF+seTT701eKuM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YW/rHZyEfelIV1yi6obov6MdyTxh35e3G7yPC4sEZ/lHyEb4Wy50FByIFOYF1ZbeICNoHV4BGP4v/1l13SptK+Ir0iJQeRZvPUQWoFFd0xbQGtXGJlOXmTa38swC5ktegrID6NJrRrdMKn1t7engtROqAVkxHfopCgf1Mv5ohng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nzIEHEr4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50D61C4CECE;
	Thu, 12 Dec 2024 16:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734021759;
	bh=ism6XkSYR3ViRlZWO5GQyzO4O2U6SjF+seTT701eKuM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nzIEHEr4C7V7iZ0ob736K2GWwLag/IJsOLiCq2IItFI88nt5VUFgBN+3QJjRCqq8R
	 JfOrLQ+kdFYuOzNaZ8YfTeo5Hd0gCUXmZGrSzp5xoxeZVMrjR+ynv3fbmvJy7g9ksg
	 3sIwW80XQkeFo5aTJIxaW0MB18YNXR593+soykDA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hans de Goede <hdegoede@redhat.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 053/565] ASoC: Intel: sst: Support LPE0F28 ACPI HID
Date: Thu, 12 Dec 2024 15:54:08 +0100
Message-ID: <20241212144313.593152581@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144311.432886635@linuxfoundation.org>
References: <20241212144311.432886635@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index e4cd6f0c686fc..6aa1be124ee8d 100644
--- a/sound/hda/intel-dsp-config.c
+++ b/sound/hda/intel-dsp-config.c
@@ -559,6 +559,10 @@ static const struct config_entry acpi_config_table[] = {
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
index 3be64430c2567..53d04c7ff6831 100644
--- a/sound/soc/intel/atom/sst/sst_acpi.c
+++ b/sound/soc/intel/atom/sst/sst_acpi.c
@@ -126,6 +126,28 @@ static const struct sst_res_info bytcr_res_info = {
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
@@ -269,10 +291,38 @@ static int sst_acpi_probe(struct platform_device *pdev)
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
@@ -281,11 +331,6 @@ static int sst_acpi_probe(struct platform_device *pdev)
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
@@ -346,6 +391,7 @@ static int sst_acpi_remove(struct platform_device *pdev)
 }
 
 static const struct acpi_device_id sst_acpi_ids[] = {
+	{ "LPE0F28", (unsigned long)&snd_soc_acpi_intel_baytrail_machines},
 	{ "80860F28", (unsigned long)&snd_soc_acpi_intel_baytrail_machines},
 	{ "808622A8", (unsigned long)&snd_soc_acpi_intel_cherrytrail_machines},
 	{ },
-- 
2.43.0




