Return-Path: <stable+bounces-62276-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF42F93E7E9
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 18:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13A14B20DEB
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 16:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A902C146A73;
	Sun, 28 Jul 2024 16:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jtX1vAxk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BEF14658C;
	Sun, 28 Jul 2024 16:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722182856; cv=none; b=QK+NNNLSQZFxRZCc5WQt2N7e40aZy11llaJRipsMZ0vJ/bV64cC0rCwnI8v6on5ggIfmv/7udf2ECYr0Bq9d0ZrKNVxv1lr766wmu1oZ12rjUe8wAFQ2buQpvsfmTLtBHRpqQ5KmVslhvJVgnUL+CyxgsIpef7gnAMkMNvW2+5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722182856; c=relaxed/simple;
	bh=/UQdGBD0RHRsChFpXQ+Mq0Sxhh2VKcAxmI95QsEhbWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tntjp3B2wKyZW9aOQ/MxSu5JpblduvA7o1UWyeSC6Hm5zCJijY6/VJVxm1W4LU72S/NsZSr9REkafniEkWLKm2iv9KN2druhjThMe1NHcYEGz2WRqxXAfiTRq0oL7fLx8Ge0Qw6qHxRsngqvHLn3AJ1tSUVGJVuY+En/RPH6jBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jtX1vAxk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E2E2C4AF0F;
	Sun, 28 Jul 2024 16:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722182856;
	bh=/UQdGBD0RHRsChFpXQ+Mq0Sxhh2VKcAxmI95QsEhbWc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jtX1vAxkYqsuFLu0kRUub0L2PselQumv0XCLlHgmsw28SGQxik/6YRctzV9yuruyp
	 sB1+exev2Jh2dE2bKLRXG9+AznlWE02oXZwIfLnSmi8T0NWv0rDoBopSazDEwtdqfH
	 sLzV125zkYhqeSSXeZu6E+6e7NNGmdROQfpEiwOLZK6rvl9RWxOAwK937f6NIWic+M
	 SuMeo2hylqTV5wI21770T9vtb8ZvcoCweqHQhgFm4gT9BA2aYEmIHOxmyHQe20ScVH
	 45uS0I5TBdpLLLiyyAXY3utocb+dQFbwupEA7TiimJb6eURngWZBQNX3KPMm9EUXT/
	 MUusYHCszd5/w==
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
Subject: [PATCH AUTOSEL 6.6 10/17] ASoC: Intel: sof_sdw: fix jack detection on ADL-N variant RVP
Date: Sun, 28 Jul 2024 12:06:46 -0400
Message-ID: <20240728160709.2052627-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728160709.2052627-1-sashal@kernel.org>
References: <20240728160709.2052627-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.43
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
index 5980fce817976..dc144cd7e0e3b 100644
--- a/sound/soc/intel/boards/sof_sdw.c
+++ b/sound/soc/intel/boards/sof_sdw.c
@@ -286,6 +286,15 @@ static const struct dmi_system_id sof_sdw_quirk_table[] = {
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


