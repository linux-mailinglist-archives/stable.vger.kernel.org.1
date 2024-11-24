Return-Path: <stable+bounces-94962-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 352969D7185
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:50:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3C2C163CFF
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 13:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9BFF1E1A18;
	Sun, 24 Nov 2024 13:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EhS9k7sh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60D91AF0D5;
	Sun, 24 Nov 2024 13:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455420; cv=none; b=hYPcqiPiqUITSyiQ/Bm9z3aLPyCUMe6Owv6TdlmijaTXrtlCNnGuGGH2xDcHMTprFPK0wRK0/ACRbltMGAoQ4exuEYR2TaRt1/TXK9WVjaYvn6F/UbLC2Omh5HBL6k9T3pSGcEMcleOrbhxsvXcWeX4b9y+AejUUDSMze5Y/qNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455420; c=relaxed/simple;
	bh=yqDjVU4Mc9UjQOvy1RKjsPrMOtf35mTuH1VH1QdP/ZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H/KoslarXA1/PNzHvMC7vuDYoiQD1vPlpTrOxEGfcMI7KEOMwYIT0iZHMFvNpp44tNC4pPvuJjVwKDevzzYxVSeq/HKTXC+jzUE9ykaseke1lNaLQRTRpCYxa3S9IAtfBPeRFw1pFpW+8xJYnGXNWoLw2ji7gj4H1lv/NAvUZ5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EhS9k7sh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72DADC4CED1;
	Sun, 24 Nov 2024 13:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455420;
	bh=yqDjVU4Mc9UjQOvy1RKjsPrMOtf35mTuH1VH1QdP/ZE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EhS9k7shwD/e4BzAeKaMnrTE0Mtti1jaruvb/YFEUBv2nx5SzJwjiZQdQvrjNy/JZ
	 tGPTooXukRNOhOy52TKF0tKdvzIBLttD05l27npGhg8/qGNOA8it93Cm+unCIX0HXr
	 rtHeYedXSSGfd/3MYmBkPst1JqzfYKB6CoPkV8wBcBzkuN8BgFehRcc1gy4nRQRvhR
	 UJtqxG+oZP5KcQqkWmmlGRUasAma06ArcOUsfxGaJuZem0venmUjiCJCNM7Lg1y76B
	 uaJCe7pqcp2RyYA9PIaH63JERYHhlJwvvjkdO3htKeLqtV0v9HNVMpqw24ygCWManQ
	 Ubt74/snjbpPg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mac Chiang <mac.chiang@intel.com>,
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
	balamurugan.c@intel.com,
	ckeepax@opensource.cirrus.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 066/107] ASoC: Intel: soc-acpi-intel-arl-match: Add rt722 and rt1320 support
Date: Sun, 24 Nov 2024 08:29:26 -0500
Message-ID: <20241124133301.3341829-66-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124133301.3341829-1-sashal@kernel.org>
References: <20241124133301.3341829-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.1
Content-Transfer-Encoding: 8bit

From: Mac Chiang <mac.chiang@intel.com>

[ Upstream commit f193fb888d1da45365daa7d0ff7a964c8305d407 ]

This patch adds support for the rt722 multi-function codec and the
rt1320 amplifier in the ARL board configuration.

Link 0: RT722 codec with three endpoints: Headset, Speaker, and DMIC.
Link 2: RT1320 amplifier.

Note:
The Speaker endpoint on the RT722 codec is not used.

Signed-off-by: Mac Chiang <mac.chiang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Link: https://patch.msgid.link/20241028072631.15536-4-yung-chuan.liao@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../intel/common/soc-acpi-intel-arl-match.c   | 63 +++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/sound/soc/intel/common/soc-acpi-intel-arl-match.c b/sound/soc/intel/common/soc-acpi-intel-arl-match.c
index 072b8486d0727..24d850df77ca8 100644
--- a/sound/soc/intel/common/soc-acpi-intel-arl-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-arl-match.c
@@ -44,6 +44,31 @@ static const struct snd_soc_acpi_endpoint spk_3_endpoint = {
 	.group_id = 1,
 };
 
+/*
+ * RT722 is a multi-function codec, three endpoints are created for
+ * its headset, amp and dmic functions.
+ */
+static const struct snd_soc_acpi_endpoint rt722_endpoints[] = {
+	{
+		.num = 0,
+		.aggregated = 0,
+		.group_position = 0,
+		.group_id = 0,
+	},
+	{
+		.num = 1,
+		.aggregated = 0,
+		.group_position = 0,
+		.group_id = 0,
+	},
+	{
+		.num = 2,
+		.aggregated = 0,
+		.group_position = 0,
+		.group_id = 0,
+	},
+};
+
 static const struct snd_soc_acpi_adr_device cs35l56_2_lr_adr[] = {
 	{
 		.adr = 0x00023001FA355601ull,
@@ -185,6 +210,24 @@ static const struct snd_soc_acpi_adr_device rt711_sdca_0_adr[] = {
 	}
 };
 
+static const struct snd_soc_acpi_adr_device rt722_0_single_adr[] = {
+	{
+		.adr = 0x000030025D072201ull,
+		.num_endpoints = ARRAY_SIZE(rt722_endpoints),
+		.endpoints = rt722_endpoints,
+		.name_prefix = "rt722"
+	}
+};
+
+static const struct snd_soc_acpi_adr_device rt1320_2_single_adr[] = {
+	{
+		.adr = 0x000230025D132001ull,
+		.num_endpoints = 1,
+		.endpoints = &single_endpoint,
+		.name_prefix = "rt1320-1"
+	}
+};
+
 static const struct snd_soc_acpi_link_adr arl_cs42l43_l0[] = {
 	{
 		.mask = BIT(0),
@@ -287,6 +330,20 @@ static const struct snd_soc_acpi_link_adr arl_sdca_rvp[] = {
 	{}
 };
 
+static const struct snd_soc_acpi_link_adr arl_rt722_l0_rt1320_l2[] = {
+	{
+		.mask = BIT(0),
+		.num_adr = ARRAY_SIZE(rt722_0_single_adr),
+		.adr_d = rt722_0_single_adr,
+	},
+	{
+		.mask = BIT(2),
+		.num_adr = ARRAY_SIZE(rt1320_2_single_adr),
+		.adr_d = rt1320_2_single_adr,
+	},
+	{}
+};
+
 static const struct snd_soc_acpi_codecs arl_essx_83x6 = {
 	.num_codecs = 3,
 	.codecs = { "ESSX8316", "ESSX8326", "ESSX8336"},
@@ -385,6 +442,12 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_arl_sdw_machines[] = {
 		.drv_name = "sof_sdw",
 		.sof_tplg_filename = "sof-arl-rt711-l0.tplg",
 	},
+	{
+		.link_mask = BIT(0) | BIT(2),
+		.links = arl_rt722_l0_rt1320_l2,
+		.drv_name = "sof_sdw",
+		.sof_tplg_filename = "sof-arl-rt722-l0_rt1320-l2.tplg",
+	},
 	{},
 };
 EXPORT_SYMBOL_GPL(snd_soc_acpi_intel_arl_sdw_machines);
-- 
2.43.0


