Return-Path: <stable+bounces-118788-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3121BA41C5A
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 12:19:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 479A03BA55F
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 11:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C7325A658;
	Mon, 24 Feb 2025 11:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mu3fh5lJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C76324BC05;
	Mon, 24 Feb 2025 11:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740395811; cv=none; b=AiyRRXebMFotywHzgNl4ffhqFlYVZxuhfenJQxj7q6B5PKB0GAdvdHglJOrIwmGL1XdEJFdlSRtmGcwHwQZ5NNjVOYRcroIT186QrxUDw57S96b54Jj3l1Ku+fc9kqhynnh4w/l/il9PC6bp981RYml889tt681AFxacwwcCZfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740395811; c=relaxed/simple;
	bh=ORWuvybuN31lbTRPvYVJ6fBUcYskFjGCVci229SNWGw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T2tI5PgrqCLlVxe+MyFTND1LQVpfFU2ADJnvJkk4aNuCJ3V2SifMrSdF2CkLtsWPaJG3GRU+1WCitp2TqsmjtpZ4wadx+FN8QyY6AryDlbNi7OtkkuppZ/EizCujw7OBQi56+Ej7GQR9tGtG6P8vXzVpcCSpNIrUiSVDvLKX6T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mu3fh5lJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5472C4AF0B;
	Mon, 24 Feb 2025 11:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740395810;
	bh=ORWuvybuN31lbTRPvYVJ6fBUcYskFjGCVci229SNWGw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mu3fh5lJvsIBSPVwsjOu85mz8g4jr/XrT7Of9n94B2j8014goyiTRFhHjtY5AsbDW
	 v9hL90CrhJNR4NgYrA1eIBV8JgOnL3eEz05xveEjvPPI17MN3Y2ecN3LvQNPSO6VRm
	 NqRObEOE5NbZ29T6IdhTxzGmC+x302suLKiaNcu4aJPn2l7hC9y7X4yoZ6JEtdWy8v
	 TVgqQQzg1nETM4FHdbF0fG/hq1hSn/CSmnvFtTKWZ7y2cUMDYCeSUKa14R1Yl444c1
	 z7NFxYDNJu5XTlne+q4fYE1yfRTLCHttPTrzXs03SinxreZKxcdxqDiP/DTmWtE+BD
	 y+0Go5KbsIdfg==
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
Subject: [PATCH AUTOSEL 6.13 04/32] ASoC: Intel: sof_sdw: Add lookup of quirk using PCI subsystem ID
Date: Mon, 24 Feb 2025 06:16:10 -0500
Message-Id: <20250224111638.2212832-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250224111638.2212832-1-sashal@kernel.org>
References: <20250224111638.2212832-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.4
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
index 65e55c46fb064..62e71f56269d8 100644
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
@@ -749,6 +750,22 @@ static const struct dmi_system_id sof_sdw_quirk_table[] = {
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
@@ -1276,6 +1293,13 @@ static int mc_probe(struct platform_device *pdev)
 
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
@@ -1291,12 +1315,6 @@ static int mc_probe(struct platform_device *pdev)
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


