Return-Path: <stable+bounces-127182-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7FE3A7698A
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 17:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31B7F16562A
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 15:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3AE421D594;
	Mon, 31 Mar 2025 14:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="osOl1+ql"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9FD21D3EB;
	Mon, 31 Mar 2025 14:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743432888; cv=none; b=ikIF8iuZjfhMxPzZtoFcQ7VtR5ncNMhrS5pw4WjzdE6kg2EWZrAm/65Oivbi5cv25PRBqFMLXqY1F1bGAa9ZzT7dnCqG0nuuXVvKvmkKxgH7dsnpBw4dybuiqaFUW8yYBPivtHPqaBjDx4XIlZl6dFzm+hu3Fe8vOXw6LCEJ2dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743432888; c=relaxed/simple;
	bh=IlaMP7UxFkb+Nz46yLWcun00yuw5cDMRLZcwlKxGBLg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A88/9Y0BHiGsqZsU4UIYNFB9s0fbF6py1aZJDSWTDtPHOCTsTjRMGTN+6sMvqvS/5oLZS3UrwWiLiaXY9+D97PwubEcJYJDo0CvCJq8v0W1FOC9JJmtlCZnN0NZtg+oWuCO2y5PUkG3txyKLdegzCQpNySfnivEYHkxwIyaN+RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=osOl1+ql; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2A74C4CEE3;
	Mon, 31 Mar 2025 14:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743432888;
	bh=IlaMP7UxFkb+Nz46yLWcun00yuw5cDMRLZcwlKxGBLg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=osOl1+qlV4wP3lzUa4anADQnYXsoqw5AAukHgDYmhQaVpTmXPCc4M5ftzm49CLlRs
	 cKxeCOAZVybsAFpzz7smIh0XBkR5YsSTo7yiW8Da33Fxrd56B1+/LVJHIHmhhub1OP
	 UHobIiNpiuSkEBfOonJ9qhKbK0xzLdaDWda3dEqnY1i0HAbQEK2ci6yst070h3E8VI
	 6Rtq+6KveDMheHkVtoabCpb1+hVQrTjsfAG4k1VpHWrhwXHqa+4+nJ2LnLVXBEm0/Y
	 GB2yYm8ZqSSIl9+6M+8Q13XvEQQBRHnXNgDPVQiybwrBvrfqi1EmgQfxZ+ixWqI+0v
	 EbaYtUakF7lrQ==
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
	pierre-louis.bossart@linux.dev,
	ranjani.sridharan@linux.intel.com,
	peterz@infradead.org,
	u.kleine-koenig@baylibre.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.13 14/24] ASoC: amd: amd_sdw: Add quirks for Dell SKU's
Date: Mon, 31 Mar 2025 10:53:54 -0400
Message-Id: <20250331145404.1705141-14-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250331145404.1705141-1-sashal@kernel.org>
References: <20250331145404.1705141-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.9
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


