Return-Path: <stable+bounces-1578-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC5F17F805E
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:49:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DDBD1F20FAB
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E272C87B;
	Fri, 24 Nov 2023 18:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kvwq2dsg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48BB33CFD;
	Fri, 24 Nov 2023 18:49:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F2D0C433C9;
	Fri, 24 Nov 2023 18:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700851750;
	bh=aDOSRANcOHgrMdzUDO2V+v9ZDHQurv0G9d1oaXuKxAg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kvwq2dsgB5MOPG4h6AulPB4WXmPUnC4XBuZl2nx3Vw5Fp9EJhTeFKx1G+3Mbm4Fh+
	 Ix3+jrliRO7pZnswbs/eKMJeNIhEKm1ZeMqxArpAJAhmP6zniJJpknDoc9ZtXBWT5O
	 f7ysHM2uEO6ASIy0C/nHJMpBopQttKzqtrHHd/yA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 056/372] ASoC: SOF: Pass PCI SSID to machine driver
Date: Fri, 24 Nov 2023 17:47:23 +0000
Message-ID: <20231124172012.343925350@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172010.413667921@linuxfoundation.org>
References: <20231124172010.413667921@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Richard Fitzgerald <rf@opensource.cirrus.com>

[ Upstream commit ba2de401d32625fe538d3f2c00ca73740dd2d516 ]

Pass the PCI SSID of the audio interface through to the machine driver.
This allows the machine driver to use the SSID to uniquely identify the
specific hardware configuration and apply any platform-specific
configuration.

struct snd_sof_pdata is passed around inside the SOF code, but it then
passes configuration information to the machine driver through
struct snd_soc_acpi_mach and struct snd_soc_acpi_mach_params. So SSID
information has been added to both snd_sof_pdata and
snd_soc_acpi_mach_params.

PCI does not define 0x0000 as an invalid value so we can't use zero to
indicate that the struct member was not written. Instead a flag is
included to indicate that a value has been written to the
subsystem_vendor and subsystem_device members.

sof_pci_probe() creates the struct snd_sof_pdata. It is passed a struct
pci_dev so it can fill in the SSID value.

sof_machine_check() finds the appropriate struct snd_soc_acpi_mach. It
copies the SSID information across to the struct snd_soc_acpi_mach_params.
This done before calling any custom set_mach_params() so that it could be
used by the set_mach_params() callback to apply variant params.

The machine driver receives the struct snd_soc_acpi_mach as its
platform_data.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20230912163207.3498161-3-rf@opensource.cirrus.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/sound/soc-acpi.h    | 7 +++++++
 include/sound/sof.h         | 8 ++++++++
 sound/soc/sof/sof-audio.c   | 7 +++++++
 sound/soc/sof/sof-pci-dev.c | 8 ++++++++
 4 files changed, 30 insertions(+)

diff --git a/include/sound/soc-acpi.h b/include/sound/soc-acpi.h
index 528279056b3ab..1a5f90b0a5463 100644
--- a/include/sound/soc-acpi.h
+++ b/include/sound/soc-acpi.h
@@ -67,6 +67,10 @@ static inline struct snd_soc_acpi_mach *snd_soc_acpi_codec_list(void *arg)
  * @i2s_link_mask: I2S/TDM links enabled on the board
  * @num_dai_drivers: number of elements in @dai_drivers
  * @dai_drivers: pointer to dai_drivers, used e.g. in nocodec mode
+ * @subsystem_vendor: optional PCI SSID vendor value
+ * @subsystem_device: optional PCI SSID device value
+ * @subsystem_id_set: true if a value has been written to
+ *		      subsystem_vendor and subsystem_device.
  */
 struct snd_soc_acpi_mach_params {
 	u32 acpi_ipc_irq_index;
@@ -79,6 +83,9 @@ struct snd_soc_acpi_mach_params {
 	u32 i2s_link_mask;
 	u32 num_dai_drivers;
 	struct snd_soc_dai_driver *dai_drivers;
+	unsigned short subsystem_vendor;
+	unsigned short subsystem_device;
+	bool subsystem_id_set;
 };
 
 /**
diff --git a/include/sound/sof.h b/include/sound/sof.h
index 341fef19e6124..1caeb7bf109b4 100644
--- a/include/sound/sof.h
+++ b/include/sound/sof.h
@@ -63,6 +63,14 @@ struct snd_sof_pdata {
 	const char *name;
 	const char *platform;
 
+	/*
+	 * PCI SSID. As PCI does not define 0 as invalid, the subsystem_id_set
+	 * flag indicates that a value has been written to these members.
+	 */
+	unsigned short subsystem_vendor;
+	unsigned short subsystem_device;
+	bool subsystem_id_set;
+
 	struct device *dev;
 
 	/* indicate how many first bytes shouldn't be loaded into DSP memory. */
diff --git a/sound/soc/sof/sof-audio.c b/sound/soc/sof/sof-audio.c
index cf2c0db57d899..061ab7289a6c3 100644
--- a/sound/soc/sof/sof-audio.c
+++ b/sound/soc/sof/sof-audio.c
@@ -832,6 +832,13 @@ int sof_machine_check(struct snd_sof_dev *sdev)
 		mach = snd_sof_machine_select(sdev);
 		if (mach) {
 			sof_pdata->machine = mach;
+
+			if (sof_pdata->subsystem_id_set) {
+				mach->mach_params.subsystem_vendor = sof_pdata->subsystem_vendor;
+				mach->mach_params.subsystem_device = sof_pdata->subsystem_device;
+				mach->mach_params.subsystem_id_set = true;
+			}
+
 			snd_sof_set_mach_params(mach, sdev);
 			return 0;
 		}
diff --git a/sound/soc/sof/sof-pci-dev.c b/sound/soc/sof/sof-pci-dev.c
index 05fb4e20e8a40..99cc272e321d0 100644
--- a/sound/soc/sof/sof-pci-dev.c
+++ b/sound/soc/sof/sof-pci-dev.c
@@ -217,6 +217,14 @@ int sof_pci_probe(struct pci_dev *pci, const struct pci_device_id *pci_id)
 		return ret;
 
 	sof_pdata->name = pci_name(pci);
+
+	/* PCI defines a vendor ID of 0xFFFF as invalid. */
+	if (pci->subsystem_vendor != 0xFFFF) {
+		sof_pdata->subsystem_vendor = pci->subsystem_vendor;
+		sof_pdata->subsystem_device = pci->subsystem_device;
+		sof_pdata->subsystem_id_set = true;
+	}
+
 	sof_pdata->desc = desc;
 	sof_pdata->dev = dev;
 
-- 
2.42.0




