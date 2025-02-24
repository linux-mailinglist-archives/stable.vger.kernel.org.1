Return-Path: <stable+bounces-118819-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 585B1A41CA2
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 12:26:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 183E4188F659
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 11:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADAD0264FBC;
	Mon, 24 Feb 2025 11:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qs8U+O88"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C72E264A7F;
	Mon, 24 Feb 2025 11:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740395889; cv=none; b=qiDkri4CHFW6PlSovxPL0eqX6Xj9Vgq5UCuu9FCHLFzrauvRXrruLO0XAi57mygRHtFjr8xLMzGb6U7M8qqOLqELFU39qbX5CxUerpdmI1CqVX/cha1PLPqbarsouikBGFYdI0DS3Qc0POhP/ykKkO+QQJNyVdWYLEMuTTtLnpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740395889; c=relaxed/simple;
	bh=0lz0fiyiL0oqUiQGqCjmSs7vLdseJRl2Qcxpeys47qk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GPx8sU24g3KW0+Sn+XELua8naRdR6f/J3ykT3WwxmCiHxpF8UEi46xZeYiUE2N0/sxqzT9rJBZYvh+nja9oexoYgBi9GMCtbvRa3WQ4/WT0WOJJ6woqZAhEmnmS7H5YJJor8QQun0vwpoQ8AYPA7qghaZPKB3056NCZhQwriCWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qs8U+O88; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F28BCC4CEE6;
	Mon, 24 Feb 2025 11:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740395888;
	bh=0lz0fiyiL0oqUiQGqCjmSs7vLdseJRl2Qcxpeys47qk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qs8U+O88hg5yXc83nFEwy3Iq3nCybeXp5iL0JTfn1tdvdCQqrAEVR6CEGaivTZhiI
	 oQfmmcuw+yVEXTWhN+YQf5o4hk/0a0myrIo3pLhpHrWEtAZyvDRDJiMv/Pnav9qXcL
	 gtNcmvIi+solVBt6+nwz3/RYz79Zev1TVdVGo5uEO8VrCyqgaB/7W79kWPxNCbxulp
	 9T7VbddnPgTJ8RHwgiyifcukZL0MQq2cqHZVDl88fH4xcp8t9FAP1koeaGzDWmSPyb
	 jUJlRfKmE7go4iXJp04VIpuhHWGD35hRIizpoajDyKyjmMyShIV2ohQQZG7qkNg8K1
	 tXmgrEqV2Gb5Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Richard Fitzgerald <rf@opensource.cirrus.com>,
	Liam Girdwood <liam.r.girdwood@intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	cezary.rojewski@intel.com,
	liam.r.girdwood@linux.intel.com,
	peter.ujfalusi@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	kai.vehmanen@linux.intel.com,
	perex@perex.cz,
	tiwai@suse.com,
	pierre-louis.bossart@linux.dev,
	ckeepax@opensource.cirrus.com,
	Vijendar.Mukunda@amd.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 03/28] ASoC: Intel: sof_sdw: Add lookup of quirk using PCI subsystem ID
Date: Mon, 24 Feb 2025 06:17:34 -0500
Message-Id: <20250224111759.2213772-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250224111759.2213772-1-sashal@kernel.org>
References: <20250224111759.2213772-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.16
Content-Transfer-Encoding: 8bit

From: Richard Fitzgerald <rf@opensource.cirrus.com>

[ Upstream commit fc016ef7da64fd473d73ee6c261ba1b0b47afe2b ]

Add lookup of PCI subsystem vendor:device ID to find a quirk.

The subsystem ID (SSID) is part of the PCI specification to uniquely
identify a particular system-specific implementation of a hardware
device.

Unlike DMI information, it identifies the sound hardware itself, rather
than a specific model of PC. SSID can be more reliable and stable than
DMI strings, and is preferred by some vendors as the way to identify
the actual sound hardware.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Reviewed-by: Liam Girdwood <liam.r.girdwood@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Link: https://patch.msgid.link/20250204053943.93596-2-yung-chuan.liao@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/boards/sof_sdw.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/sound/soc/intel/boards/sof_sdw.c b/sound/soc/intel/boards/sof_sdw.c
index 84fc35d88b926..8f2416b73dc43 100644
--- a/sound/soc/intel/boards/sof_sdw.c
+++ b/sound/soc/intel/boards/sof_sdw.c
@@ -13,6 +13,7 @@
 #include <linux/soundwire/sdw.h>
 #include <linux/soundwire/sdw_type.h>
 #include <linux/soundwire/sdw_intel.h>
+#include <sound/core.h>
 #include <sound/soc-acpi.h>
 #include "sof_sdw_common.h"
 #include "../../codecs/rt711.h"
@@ -685,6 +686,22 @@ static const struct dmi_system_id sof_sdw_quirk_table[] = {
 	{}
 };
 
+static const struct snd_pci_quirk sof_sdw_ssid_quirk_table[] = {
+	{}
+};
+
+static void sof_sdw_check_ssid_quirk(const struct snd_soc_acpi_mach *mach)
+{
+	const struct snd_pci_quirk *quirk_entry;
+
+	quirk_entry = snd_pci_quirk_lookup_id(mach->mach_params.subsystem_vendor,
+					      mach->mach_params.subsystem_device,
+					      sof_sdw_ssid_quirk_table);
+
+	if (quirk_entry)
+		sof_sdw_quirk = quirk_entry->value;
+}
+
 static struct snd_soc_dai_link_component platform_component[] = {
 	{
 		/* name might be overridden during probe */
@@ -1212,6 +1229,13 @@ static int mc_probe(struct platform_device *pdev)
 
 	snd_soc_card_set_drvdata(card, ctx);
 
+	if (mach->mach_params.subsystem_id_set) {
+		snd_soc_card_set_pci_ssid(card,
+					  mach->mach_params.subsystem_vendor,
+					  mach->mach_params.subsystem_device);
+		sof_sdw_check_ssid_quirk(mach);
+	}
+
 	dmi_check_system(sof_sdw_quirk_table);
 
 	if (quirk_override != -1) {
@@ -1227,12 +1251,6 @@ static int mc_probe(struct platform_device *pdev)
 	for (i = 0; i < ctx->codec_info_list_count; i++)
 		codec_info_list[i].amp_num = 0;
 
-	if (mach->mach_params.subsystem_id_set) {
-		snd_soc_card_set_pci_ssid(card,
-					  mach->mach_params.subsystem_vendor,
-					  mach->mach_params.subsystem_device);
-	}
-
 	ret = sof_card_dai_links_create(card);
 	if (ret < 0)
 		return ret;
-- 
2.39.5


