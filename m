Return-Path: <stable+bounces-62307-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC2D93E847
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 18:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0662EB20F6E
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 16:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1DEF188CD7;
	Sun, 28 Jul 2024 16:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jt07ItmH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C03E188CD5;
	Sun, 28 Jul 2024 16:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722182971; cv=none; b=sGy3/3MCRETY3rj1LikTIZx9osftZCPWY6SpCydS7d9HLSkJc3hykjdgaJEtBNdXTlQsqK1coGnTWKQSlGOQxafPzDZupDqDCdlXlAio8TEvrhMDiH5aSLwL0C9TfyoftgvtEBXaWbUjnjm0/PlYaFflwLpdjO+hvZWTsNx/QH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722182971; c=relaxed/simple;
	bh=5a30SfJIZmq7iTMLZ4NkwPdCwdreEiJp3iMfcFRfd7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g//gWmwWn+l/hUBZb4EAifpz4wXrm2SoX7z15i6m+dnZ5XxvSXZ6D+a/Qk9lfZXONi3uebAOIBCDlTRLz3pvCM1DZdjHkVp27z4PI1gR5r1WOSUcTYc0TEmf98Bei/Vfvx2IMmTGU4xuVmwuW9FY4ciVYbGKL9fGPkQqTov/QtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jt07ItmH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D162C4AF0B;
	Sun, 28 Jul 2024 16:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722182971;
	bh=5a30SfJIZmq7iTMLZ4NkwPdCwdreEiJp3iMfcFRfd7E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jt07ItmHJeCxiBf7gD2Uyvny+IUjHLcZrVDgHNAsN19RRkDzRRWJzw9aCQnP0UEQW
	 z1092sdvYvxYE9p7PK9FXv0yBidosWVuJ1oWtW1sD+QCLM8lL2IX8T9n96wamwARIz
	 GrNp47wEzJK64SdPbKl26dDyxJpPzeM0m0SXeUqzqnQJJkkocTf+3x+OeTsDe6yA8R
	 sWrC0BAqGrCmtiIZnYcnoIe6PEmdjjL15LM9tcxJkTTw5tmlevwZQtd8dGJhesCQ8F
	 Sp79+JXod+dZ3/J6sUeXvEzNhX821KRj54ttOp/MvWPCy5g4gMXDYVN9uFf8Zf5cAL
	 Js/k0HPjEeRzA==
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
Subject: [PATCH AUTOSEL 5.15 09/13] ASoC: Intel: sof_sdw: fix jack detection on ADL-N variant RVP
Date: Sun, 28 Jul 2024 12:08:51 -0400
Message-ID: <20240728160907.2053634-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728160907.2053634-1-sashal@kernel.org>
References: <20240728160907.2053634-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.164
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
index 089b6c7994f9a..cfa0c3eaffea7 100644
--- a/sound/soc/intel/boards/sof_sdw.c
+++ b/sound/soc/intel/boards/sof_sdw.c
@@ -258,6 +258,15 @@ static const struct dmi_system_id sof_sdw_quirk_table[] = {
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


