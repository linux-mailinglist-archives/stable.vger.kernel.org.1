Return-Path: <stable+bounces-127155-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD6FA76951
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 17:07:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 300F6188D178
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 15:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6932B214A76;
	Mon, 31 Mar 2025 14:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iwjJQS/A"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B069214234;
	Mon, 31 Mar 2025 14:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743432812; cv=none; b=jD6z5Qye7s88oTLI4AVqwSPLdepJVcf1+LxjGrxtDGwaCF2CJAcKMEtkKvep8w41WpzB1D3/LuAtX7vbmrzyq5bSRitiGPpmMDLd7BAz3LTjnmtEjgIWTh+fo1yBIYwAq+4eQaefR9sZDI32OL+V3TqGI5usD2k1uZBMPQrE8Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743432812; c=relaxed/simple;
	bh=IlaMP7UxFkb+Nz46yLWcun00yuw5cDMRLZcwlKxGBLg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DfxqHEBQaUBy6BZMdb7wmhuWLWx8cdiDxWWOeEtcClmUTqFzPTnumQiDJ7p5D6tUlXflqLpWOGFPN17c2IujWKhsWQKsPpVLLGx7lvuCnzaftdGyHNrOEefVqmXsPJhmski9LeXaI4uJE5/Y8F33BBwTh0DJlSrZeoDD87vhyYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iwjJQS/A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 783E7C4CEE3;
	Mon, 31 Mar 2025 14:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743432812;
	bh=IlaMP7UxFkb+Nz46yLWcun00yuw5cDMRLZcwlKxGBLg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iwjJQS/AgB6KbTSQu0Qt75jKsI/djbbGuRohJ5wh8ffUQDi7W02Jb28WaTBplInpW
	 QKEUGcgNAaUk9JuA4BAw/E8+MZLpbv3xXSOQmqBOZxz1r2q/c5NVRffB8IMlooIrUP
	 lGqEa7aTSxOpyWk7Wztctbo10humLQ/NGSR4WT13mkXbfUCWMKbMGmV5qVxAR4qKXj
	 5+ImBlQWNynGbn0rl+ynPPyjawIrWphP1qDueLMDdsHq70vjQZCMEgqoS0NJLKM2gc
	 w14geL0RPSAYxGcCUu+LZl+F1uHpd2VC3TnKmMwC2SYkiU9zgkCb39jjrT3H2DGk9V
	 bD8D2QO8M095A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	yung-chuan.liao@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	pierre-louis.bossart@linux.dev,
	peterz@infradead.org,
	u.kleine-koenig@baylibre.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 14/27] ASoC: amd: amd_sdw: Add quirks for Dell SKU's
Date: Mon, 31 Mar 2025 10:52:32 -0400
Message-Id: <20250331145245.1704714-14-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250331145245.1704714-1-sashal@kernel.org>
References: <20250331145245.1704714-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14
Content-Transfer-Encoding: 8bit

From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>

[ Upstream commit 4bb5b6f13fd83b32c8a93fbd399e7558415d1ce0 ]

This patch adds a quirk to include the codec amplifier function for Dell
SKU's listed in quirk table.

Note: In these SKU's, the RT722 codec amplifier is excluded, and an
external amplifier is used instead.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Link: https://patch.msgid.link/20250207062819.1527184-26-Vijendar.Mukunda@amd.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/amd/acp/acp-sdw-legacy-mach.c | 34 +++++++++++++++++++++++++
 sound/soc/amd/acp/soc_amd_sdw_common.h  |  1 +
 2 files changed, 35 insertions(+)

diff --git a/sound/soc/amd/acp/acp-sdw-legacy-mach.c b/sound/soc/amd/acp/acp-sdw-legacy-mach.c
index 9280cd30d19cf..a0defa5d15f73 100644
--- a/sound/soc/amd/acp/acp-sdw-legacy-mach.c
+++ b/sound/soc/amd/acp/acp-sdw-legacy-mach.c
@@ -28,6 +28,8 @@ static void log_quirks(struct device *dev)
 			SOC_JACK_JDSRC(soc_sdw_quirk));
 	if (soc_sdw_quirk & ASOC_SDW_ACP_DMIC)
 		dev_dbg(dev, "quirk SOC_SDW_ACP_DMIC enabled\n");
+	if (soc_sdw_quirk & ASOC_SDW_CODEC_SPKR)
+		dev_dbg(dev, "quirk ASOC_SDW_CODEC_SPKR enabled\n");
 }
 
 static int soc_sdw_quirk_cb(const struct dmi_system_id *id)
@@ -45,6 +47,38 @@ static const struct dmi_system_id soc_sdw_quirk_table[] = {
 		},
 		.driver_data = (void *)RT711_JD2,
 	},
+	{
+		.callback = soc_sdw_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_SKU, "0D80"),
+		},
+		.driver_data = (void *)(ASOC_SDW_CODEC_SPKR),
+	},
+	{
+		.callback = soc_sdw_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_SKU, "0D81"),
+		},
+		.driver_data = (void *)(ASOC_SDW_CODEC_SPKR),
+	},
+	{
+		.callback = soc_sdw_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_SKU, "0D82"),
+		},
+		.driver_data = (void *)(ASOC_SDW_CODEC_SPKR),
+	},
+	{
+		.callback = soc_sdw_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_SKU, "0D83"),
+		},
+		.driver_data = (void *)(ASOC_SDW_CODEC_SPKR),
+	},
 	{}
 };
 
diff --git a/sound/soc/amd/acp/soc_amd_sdw_common.h b/sound/soc/amd/acp/soc_amd_sdw_common.h
index b7bae107c13e4..ed5aec9c01458 100644
--- a/sound/soc/amd/acp/soc_amd_sdw_common.h
+++ b/sound/soc/amd/acp/soc_amd_sdw_common.h
@@ -22,6 +22,7 @@
 #define SOC_JACK_JDSRC(quirk)		((quirk) & GENMASK(3, 0))
 #define ASOC_SDW_FOUR_SPK		BIT(4)
 #define ASOC_SDW_ACP_DMIC		BIT(5)
+#define ASOC_SDW_CODEC_SPKR		BIT(15)
 
 #define AMD_SDW0	0
 #define AMD_SDW1	1
-- 
2.39.5


