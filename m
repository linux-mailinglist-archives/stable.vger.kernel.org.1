Return-Path: <stable+bounces-46537-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC91B8D077A
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 18:05:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F8E9295F4F
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 16:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0181015DBD8;
	Mon, 27 May 2024 15:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NJ9AR18Z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9BE155CB0;
	Mon, 27 May 2024 15:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716825449; cv=none; b=qlodP+uYZaZgHkZZqyzhsUZ1Az6v0dlbZZQAUTrEFBvWrwpnklyFDlb6DVgAcKKzpvSwzlUhbLrg4F8UYebIyXQIcycPU5IZ4fuQADDWTAri3PcGG5BkGnUxvupDxXraFI0jXUEPKriJ/ozlUY/PA7TN9jA38JXNphQbbnA7agE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716825449; c=relaxed/simple;
	bh=XMDDtD9CY5O1r9b/PQHfX3zF0XI8LAMXOvvPTvkTzoI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tjAiVxFHpSjbjR4OhibiRPSji2pqA67f/Mmoju2N4I7Gs/npC6DE0Tq5cuZJbvxae0ph2P2zrwQXI6WOeql1ojHBdpBs4ZZV76xgv9k7CrzNhwYvtqGF4CZehvdyj96Rf6u8qd5Y+LTh13fDaHzRsMM/3YOaRxxAZhLSn3eG/hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NJ9AR18Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D84A4C2BBFC;
	Mon, 27 May 2024 15:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716825449;
	bh=XMDDtD9CY5O1r9b/PQHfX3zF0XI8LAMXOvvPTvkTzoI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NJ9AR18Z9Nxv9j+KP3BCTPAV3y1yOuAQ7ENb6e7K2Ye0wyAdbNCoSMZsJ3YJif3JB
	 SGU5TP8w7YUY2XxTTIYd1bJVqz2ikS+XXyMGssKw/8OuUlf5GTCkOtYvOZxjfceEv6
	 w+O1sTzdp7Z5ApizjD7y6Af57mFL3DNNKmiGFxEDlnujbfTcHEDX61lLV8ypYpXJef
	 tsBChYgA1d+xSFM0Vv0WN2roZ8zB2tV47/ZqAwfHIekdrWyNZs8V+JWtx0RjCPCqPt
	 ORY0qq3pMcQGSOiS2wC7MShUwQ/w8ywMFuQei65mPR8xqesuSJ1ZeYjk/fzk/NYXTY
	 8rXMOpTz6XRQQ==
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
Subject: [PATCH AUTOSEL 6.1 03/11] ASoC: Intel: sof_sdw: add JD2 quirk for HP Omen 14
Date: Mon, 27 May 2024 11:56:40 -0400
Message-ID: <20240527155710.3865826-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240527155710.3865826-1-sashal@kernel.org>
References: <20240527155710.3865826-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.92
Content-Transfer-Encoding: 8bit

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

[ Upstream commit 4fee07fbf47d2a5f1065d985459e5ce7bf7969f0 ]

The default JD1 does not seem to work, use JD2 instead.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20240411220347.131267-4-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/boards/sof_sdw.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/intel/boards/sof_sdw.c b/sound/soc/intel/boards/sof_sdw.c
index d1e6e4208c376..d03de37e3578c 100644
--- a/sound/soc/intel/boards/sof_sdw.c
+++ b/sound/soc/intel/boards/sof_sdw.c
@@ -413,6 +413,15 @@ static const struct dmi_system_id sof_sdw_quirk_table[] = {
 					SOF_BT_OFFLOAD_SSP(1) |
 					SOF_SSP_BT_OFFLOAD_PRESENT),
 	},
+	{
+		.callback = sof_sdw_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "HP"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "OMEN Transcend Gaming Laptop"),
+		},
+		.driver_data = (void *)(RT711_JD2),
+	},
+
 	/* LunarLake devices */
 	{
 		.callback = sof_sdw_quirk_cb,
-- 
2.43.0


