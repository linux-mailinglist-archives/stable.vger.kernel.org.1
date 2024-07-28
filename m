Return-Path: <stable+bounces-62292-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 588C193E818
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 18:22:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1311C2826F1
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 16:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A8F15AD86;
	Sun, 28 Jul 2024 16:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RbZyS0E5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B2B762DF;
	Sun, 28 Jul 2024 16:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722182917; cv=none; b=NmfzUIYHXtCcEKPAQn9/OVEUDlHHkcl9bGj6dLJKZ5zV5uFZVbtLVNJ7lXJhNGDfGQhBQbNyqMYsgKh8KUoGRbRUeKiUhrJ3+T9hRBkabv1DopgBRzd/CC3jVU/evnnTNRkeAtF5kAnjuRMUyR8W1LnduXfnNIYM6vwbDpkDs8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722182917; c=relaxed/simple;
	bh=h5T+cJRGnbY0CGPW2MiC0k+WDQ9Czbj3yIqOiGgdWtM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m/FcfxPhlbrNBpulK40IJ52t54XDJSa5nawr7vd/tQGOzqUcGuhewlOvEZQNJmabJTS88ocq8r/VgSqYVHyXCDqNEVCReQI3XJC31Q83ukq3anZwZu56/LT3Li9lOLMlmbrASNTM0m3B+1UwIvSF86tnjrNoXRJdN9YAar3ggWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RbZyS0E5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68569C4AF0E;
	Sun, 28 Jul 2024 16:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722182917;
	bh=h5T+cJRGnbY0CGPW2MiC0k+WDQ9Czbj3yIqOiGgdWtM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RbZyS0E5Yy+aKT1qxgrGbUxr6nurh4id98sFJs//MxO4qifUMmz3gJeAJIo5seOdi
	 412KMAGW1DsdvEZ5w3ClL1+k3dFx/gO44v0DpejiURub2QTvFYNxedNFRaJSYAUQAU
	 rKy4BO/kn/TdleTaGKrgUgdkUxDJTG1S3kTSCSpcXEs2puvMoLYNfJcJkQkUquSsqw
	 eic2Pv+AbcfpS5cNG0HaY6EvsMFAzz7uCI3pdOTV9by6mMfOfOVA+tZ4rqSVHYf0+L
	 1da+muoKnlagVgg6PBpD6H3iSZm4RmRXnczXPhiI/+ncHvepmjW623DWyYLJGoO+s6
	 Z1nAf0yG0J8Mw==
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
Subject: [PATCH AUTOSEL 6.1 09/15] ASoC: Intel: sof_sdw: fix jack detection on ADL-N variant RVP
Date: Sun, 28 Jul 2024 12:07:53 -0400
Message-ID: <20240728160813.2053107-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728160813.2053107-1-sashal@kernel.org>
References: <20240728160813.2053107-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.102
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
index d03de37e3578c..cf501baf6f143 100644
--- a/sound/soc/intel/boards/sof_sdw.c
+++ b/sound/soc/intel/boards/sof_sdw.c
@@ -267,6 +267,15 @@ static const struct dmi_system_id sof_sdw_quirk_table[] = {
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


