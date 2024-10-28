Return-Path: <stable+bounces-88993-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A08F9B2D79
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 11:53:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C4551C217A1
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 10:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 039421DB95F;
	Mon, 28 Oct 2024 10:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A4ciPDxB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC961DB36B;
	Mon, 28 Oct 2024 10:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730112686; cv=none; b=eXr9Y4M9iWB2ydkqn+bn4ya/0g+RQUEYnkga0tSkZYbL+/iF5tB3kvkNS3xDCCc6BuKmozdmkdyAEA4lH1waIJajjFBKAb1WchDia/cmQHv/UNOFx5rkX2Mqdy0TQn/XcmK+HQN6hL2/LTelY8SlSJbuR1WgvTOy/1J0ZLD8/QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730112686; c=relaxed/simple;
	bh=pSlOsMsFj6PAMkfTsFsv/eFP6g/jikcrQfEj7vDcFdE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U82aBs4twmsNd1yXeolvXIgFjFEuXLcpxWBREEhFAGQR/PmQoc2/A8vCvh/wC6T8ije9vuDkcw9n4w7Nl31+wNeiGSgcR56s71qCW4+KeKrwpsmkjwu6j9Ov63B0T9FNp5m6md5MPQwjcLKrtpwNkGeLMb3vWPhuRL2tN87R1D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A4ciPDxB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9477CC4CEE3;
	Mon, 28 Oct 2024 10:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730112686;
	bh=pSlOsMsFj6PAMkfTsFsv/eFP6g/jikcrQfEj7vDcFdE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A4ciPDxBXOL++hUTOWYiauK3zMdlfVah0BWBJUhjXjmaTRtTbNz8SW//y/19hgI73
	 ZNqW3HoS5UFJkxRmpc+O9tJKsT7aGz0pgIW4Y5jmW/13Xj/q6wT2mkImIPvBlitkui
	 wtyVGtGzIrFrRSI4bzTVEPHdVNqc+Xzqmrx0XjECBC+Ie37RJOLYF9AcV1nz+fTF50
	 AF4+I/qv/1khGywU2PfmQ59EKs/KW7rkDVCfMQ2pOpXm41j9vcx9GC86lq8uJSZnME
	 mvglHXE92foqc+gICf0l5FmZr3v6YvrXvy86tJM3TYqJeL9/e0e3qW6q/gPvGz0M2b
	 oPjKSwtb6lseQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Derek Fang <derek.fang@realtek.com>,
	=?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	cezary.rojewski@intel.com,
	liam.r.girdwood@linux.intel.com,
	kai.vehmanen@linux.intel.com,
	perex@perex.cz,
	tiwai@suse.com,
	pierre-louis.bossart@linux.dev,
	chao.song@linux.intel.com,
	mac.chiang@intel.com,
	ckeepax@opensource.cirrus.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 11/32] ASoC: Intel: soc-acpi: lnl: Add match entry for TM2 laptops
Date: Mon, 28 Oct 2024 06:49:53 -0400
Message-ID: <20241028105050.3559169-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241028105050.3559169-1-sashal@kernel.org>
References: <20241028105050.3559169-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.5
Content-Transfer-Encoding: 8bit

From: Derek Fang <derek.fang@realtek.com>

[ Upstream commit 6924565a04e5f424c95e6d894584e3059f257373 ]

Add a new match table entry on Lunarlake for the TM2 laptops
with rt713 and rt1318.

Signed-off-by: Derek Fang <derek.fang@realtek.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Link: https://patch.msgid.link/20241016030703.13669-1-yung-chuan.liao@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../intel/common/soc-acpi-intel-lnl-match.c   | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/sound/soc/intel/common/soc-acpi-intel-lnl-match.c b/sound/soc/intel/common/soc-acpi-intel-lnl-match.c
index edfb668d0580d..8452b66149119 100644
--- a/sound/soc/intel/common/soc-acpi-intel-lnl-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-lnl-match.c
@@ -166,6 +166,15 @@ static const struct snd_soc_acpi_adr_device rt1316_3_group1_adr[] = {
 	}
 };
 
+static const struct snd_soc_acpi_adr_device rt1318_1_adr[] = {
+	{
+		.adr = 0x000133025D131801ull,
+		.num_endpoints = 1,
+		.endpoints = &single_endpoint,
+		.name_prefix = "rt1318-1"
+	}
+};
+
 static const struct snd_soc_acpi_adr_device rt1318_1_group1_adr[] = {
 	{
 		.adr = 0x000130025D131801ull,
@@ -184,6 +193,15 @@ static const struct snd_soc_acpi_adr_device rt1318_2_group1_adr[] = {
 	}
 };
 
+static const struct snd_soc_acpi_adr_device rt713_0_adr[] = {
+	{
+		.adr = 0x000031025D071301ull,
+		.num_endpoints = 1,
+		.endpoints = &single_endpoint,
+		.name_prefix = "rt713"
+	}
+};
+
 static const struct snd_soc_acpi_adr_device rt714_0_adr[] = {
 	{
 		.adr = 0x000030025D071401ull,
@@ -286,6 +304,20 @@ static const struct snd_soc_acpi_link_adr lnl_sdw_rt1318_l12_rt714_l0[] = {
 	{}
 };
 
+static const struct snd_soc_acpi_link_adr lnl_sdw_rt713_l0_rt1318_l1[] = {
+	{
+		.mask = BIT(0),
+		.num_adr = ARRAY_SIZE(rt713_0_adr),
+		.adr_d = rt713_0_adr,
+	},
+	{
+		.mask = BIT(1),
+		.num_adr = ARRAY_SIZE(rt1318_1_adr),
+		.adr_d = rt1318_1_adr,
+	},
+	{}
+};
+
 /* this table is used when there is no I2S codec present */
 struct snd_soc_acpi_mach snd_soc_acpi_intel_lnl_sdw_machines[] = {
 	/* mockup tests need to be first */
@@ -343,6 +375,12 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_lnl_sdw_machines[] = {
 		.drv_name = "sof_sdw",
 		.sof_tplg_filename = "sof-lnl-rt1318-l12-rt714-l0.tplg"
 	},
+	{
+		.link_mask = BIT(0) | BIT(1),
+		.links = lnl_sdw_rt713_l0_rt1318_l1,
+		.drv_name = "sof_sdw",
+		.sof_tplg_filename = "sof-lnl-rt713-l0-rt1318-l1.tplg"
+	},
 	{},
 };
 EXPORT_SYMBOL_GPL(snd_soc_acpi_intel_lnl_sdw_machines);
-- 
2.43.0


