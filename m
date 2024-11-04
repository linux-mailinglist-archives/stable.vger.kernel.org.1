Return-Path: <stable+bounces-89638-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 447849BB1E7
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 11:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBC561F2170B
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 10:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 225BB1CFECE;
	Mon,  4 Nov 2024 10:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ScfIuYG1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA7F1CF2B2;
	Mon,  4 Nov 2024 10:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730717559; cv=none; b=gbzQ6BQVIP+U1GFpPuT7OfgyXEDfQx8itB3Hyo8ExByrm9b0ZCjfBKPZ7V+JDJe2om4bRBIjjSFA0UT5ToL7m4TbZ/fIZ+iU5c3AM4FHT/hh2yGzpc+OSkH6x14x7qxGkmbBGVFJXHRFVdA4+Xs7stRl3lMh2E0hh/r1uLAzgNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730717559; c=relaxed/simple;
	bh=gor5LVMmeTXSUZU1XJ4D04dR3mzfZ4ySPxfgJOXOMyo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SKjlM68oLv3F7i/GtPsYT/B2sEmY1ZUlmkXUjXGF5bxDtiKVAjAZqZZbdb2BJHnIR2DO6tHGms042lKhPjsrsOWKP/b5Enyzl2svxRt/vr2fqxmLr7iOaRyRHt/nEJQFHGu5HDq2+Jct2g8jfJzfUSQ6RVPDaJGHLjY4Y8rB7VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ScfIuYG1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5F7CC4CECE;
	Mon,  4 Nov 2024 10:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730717559;
	bh=gor5LVMmeTXSUZU1XJ4D04dR3mzfZ4ySPxfgJOXOMyo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ScfIuYG1tD6ZHRWh+bxazRjHOf3noqO4e6VFNQxPaw9sUDubY64jo1RWBmtY8wYNj
	 iZDEVq+o7je1mG9u4PWfDvvftJCnoHRrNnhQ4+z/Mi9j6gWORePavOBQX0FXiKAYnp
	 2hwd2Lm6q62y/XSq+WcEvZW7sEFu2SlgVfLWbgZgDbv+E+0h01PJcLhi+omVbuKfN7
	 YHgLSj+jd8LAgDsHLsLetpjtlPdII9EVyb2QY7X3hGMaFU5Lz/79EMEmJSJXYn8lDN
	 ZJXraPLrCsv7IIbWyTzpqxPeCFpFpEWXe4+M8H6dbTDJpvBRtv1FsJNLR7o14V8wj9
	 24KOPY9Ip7aoA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	cezary.rojewski@intel.com,
	liam.r.girdwood@linux.intel.com,
	peter.ujfalusi@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	kai.vehmanen@linux.intel.com,
	perex@perex.cz,
	tiwai@suse.com,
	pierre-louis.bossart@linux.dev,
	u.kleine-koenig@baylibre.com,
	tomlohave@gmail.com,
	alban.boye@protonmail.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 04/14] ASoC: Intel: bytcr_rt5640: Add DMI quirk for Vexia Edu Atla 10 tablet
Date: Mon,  4 Nov 2024 05:51:56 -0500
Message-ID: <20241104105228.97053-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241104105228.97053-1-sashal@kernel.org>
References: <20241104105228.97053-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.59
Content-Transfer-Encoding: 8bit

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 0107f28f135231da22a9ad5756bb16bd5cada4d5 ]

The Vexia Edu Atla 10 tablet mostly uses the BYTCR tablet defaults,
but as happens on more models it is using IN1 instead of IN3 for
its internal mic and JD_SRC_JD2_IN4N instead of JD_SRC_JD1_IN4P
for jack-detection.

Add a DMI quirk for this to fix the internal-mic and jack-detection.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Link: https://patch.msgid.link/20241024211615.79518-2-hdegoede@redhat.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/boards/bytcr_rt5640.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index 79c50498144ec..ddf68be0af14a 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -1132,6 +1132,21 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
 					BYT_RT5640_SSP0_AIF2 |
 					BYT_RT5640_MCLK_EN),
 	},
+	{	/* Vexia Edu Atla 10 tablet */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "AMI Corporation"),
+			DMI_MATCH(DMI_BOARD_NAME, "Aptio CRB"),
+			/* Above strings are too generic, also match on BIOS date */
+			DMI_MATCH(DMI_BIOS_DATE, "08/25/2014"),
+		},
+		.driver_data = (void *)(BYT_RT5640_IN1_MAP |
+					BYT_RT5640_JD_SRC_JD2_IN4N |
+					BYT_RT5640_OVCD_TH_2000UA |
+					BYT_RT5640_OVCD_SF_0P75 |
+					BYT_RT5640_DIFF_MIC |
+					BYT_RT5640_SSP0_AIF2 |
+					BYT_RT5640_MCLK_EN),
+	},
 	{	/* Voyo Winpad A15 */
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "AMI Corporation"),
-- 
2.43.0


