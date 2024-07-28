Return-Path: <stable+bounces-62257-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 764E893E7AB
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 18:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20C6C1F21A6B
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 16:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16FA91386C6;
	Sun, 28 Jul 2024 16:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oQaa6gIS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37AE137905;
	Sun, 28 Jul 2024 16:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722182775; cv=none; b=ODHQWHUaTyiuRmejGzqtC5dBrAt2b/d/mcKVeU9VPB6oLEhd5/QtFLMfedTId5Tccg+R/LTnp+jmaWTDpGNdPaaCmz+C7ZbIJy3NTDhEJAVFFVK0qXucGf8GqF2AVVlpV7GuGh10gkXahdZmKhn3PxfwAfTPHQahsNXeDqT0x/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722182775; c=relaxed/simple;
	bh=ZWwOIXhWJ16760WpJd2nj8bqfFlHut1jmYjqK1gtZ5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AzGFQLPZO2liv9tGJHA0R3Gj/wiJHNqWRuy8XbjoFpput6JGVhTkFmuLpQUqtBj1VN0cNG1WzZ1TecmxsdN+7nU9AZNaATWi7kOHlXyYjIWUhOTB7YnQ3PWkaA+tCCqL6TiAJsZ4Iz4rY5E/cUpJw2T823nph0AUfRfCqYXhmxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oQaa6gIS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6907BC32782;
	Sun, 28 Jul 2024 16:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722182775;
	bh=ZWwOIXhWJ16760WpJd2nj8bqfFlHut1jmYjqK1gtZ5k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oQaa6gISkRKHfHi55ZNSei5FMmzy9Wpp8s3JafPOw606y462WSYWbi9aU7e7ffX2z
	 RLSyx7KcoGSh9nRlRVkcnrYDDWTQRERit6BlzD4dhrv+srcPCb8T9j0jo+kG43oBib
	 yiicXUaWHSSteYwkTutobLCPew/GCx3XuWWTKk6/HqCR931YlbPcIHjOGODlP+ut1z
	 kvBmV6Fwr3pfGnjhOpQKjCiOFOMIH+3XAf4qmzy1JNsG2jiyqUHVFLXAfnbq9YGiOR
	 YrtiSG5osyEpNzeS6hUM7Yqf4pdCBMhyd/M2b1GADlI0+1CvEZOy0tKKSlGBYfyMyP
	 dcWiiODu9VKlQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
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
	ckeepax@opensource.cirrus.com,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 14/23] ASoC: Intel: sof_sdw: fix jack detection on ADL-N variant RVP
Date: Sun, 28 Jul 2024 12:04:55 -0400
Message-ID: <20240728160538.2051879-14-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728160538.2051879-1-sashal@kernel.org>
References: <20240728160538.2051879-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
Content-Transfer-Encoding: 8bit

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

[ Upstream commit 65c90df918205bc84f5448550cde76a54dae5f52 ]

Experimental tests show that JD2_100K is required, otherwise the jack
is detected always even with nothing plugged-in.

To avoid matching with other known quirks the SKU information is used.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://patch.msgid.link/20240624121119.91552-2-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/boards/sof_sdw.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/intel/boards/sof_sdw.c b/sound/soc/intel/boards/sof_sdw.c
index a878b6b3d1948..965d46968f95a 100644
--- a/sound/soc/intel/boards/sof_sdw.c
+++ b/sound/soc/intel/boards/sof_sdw.c
@@ -277,6 +277,15 @@ static const struct dmi_system_id sof_sdw_quirk_table[] = {
 					SOF_BT_OFFLOAD_SSP(2) |
 					SOF_SSP_BT_OFFLOAD_PRESENT),
 	},
+	{
+		.callback = sof_sdw_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "Intel Corporation"),
+			DMI_MATCH(DMI_PRODUCT_SKU, "0000000000070000"),
+		},
+		.driver_data = (void *)(SOF_SDW_TGL_HDMI |
+					RT711_JD2_100K),
+	},
 	{
 		.callback = sof_sdw_quirk_cb,
 		.matches = {
-- 
2.43.0


