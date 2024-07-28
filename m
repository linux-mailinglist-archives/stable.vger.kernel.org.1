Return-Path: <stable+bounces-62313-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD2593E857
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 18:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 995E7281FBD
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 16:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B85C56B81;
	Sun, 28 Jul 2024 16:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nTL/RXA4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0182A7347E;
	Sun, 28 Jul 2024 16:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722183002; cv=none; b=TIo7xhXRhWNI2ANHJc35RCCR8Sfzrh+Petgs4CFeB27rnN3CW2XKFBu5iT713i6Zu0SkdBWH0lswANKwKU2gLjthMbpumCiHeXM074TfIYP/BvwIKAnXaGjC7FYp6L04vf0jMk72/wvaF40rfr4IyVkQ299agOwhlct+k0YXb+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722183002; c=relaxed/simple;
	bh=ZKrtN/ztZKHxME0bLtjP87f6YS3aHEf/izl9OPV/7s0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CKkwUBW1oledYaWZHI07/1iiHvtKyKLBMl16G1XO1mVfsOjaoaFguAl0QsGswD1dv58rm5ndtlXhpHUXyuT1A5Dm4x52P5+LsZi4RLeQ4JgE1RexsITDStg7UY76uWxr/txMjQvO0byPcLDIzCOug6TxpUjtEdAMSSVrsKgbVUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nTL/RXA4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CFE3C4AF0F;
	Sun, 28 Jul 2024 16:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722183001;
	bh=ZKrtN/ztZKHxME0bLtjP87f6YS3aHEf/izl9OPV/7s0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nTL/RXA4ECipN769puQtklsXGq/wreRweAWYVJNFCx41n1cUrx+Ve/Wr2T8RFGP+f
	 ngW0od40rekXuYfjDe2DgkYYDDl90/xlt2Cd91UVHRgh8bJbsLEWhEYCQC1jBNZmi0
	 U2mq4yH7UG08XrSlwgm19U80Gk3gxktF6KtDDQeh7f0m3f0UrwAgwaeiyQgnnKmLJC
	 Oiqbz4TX/DYbtDUrA1QWQBtoxQB4eRGp9zLnaKIMK+1P7/ytcVZwr3S5o72vetYC+P
	 u4fQBf8ZHnB4Sh2g0eaP3peCxicW10lM/oR0lNH0XRjRl0ylS3vEEWZX/kWDz6bm9C
	 CrEnDHCO73T6g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	cezary.rojewski@intel.com,
	liam.r.girdwood@linux.intel.com,
	peter.ujfalusi@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	kai.vehmanen@linux.intel.com,
	perex@perex.cz,
	tiwai@suse.com,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 02/11] ASoC: Intel: sof_sdw: Add quirks for some new Dell laptops
Date: Sun, 28 Jul 2024 12:09:35 -0400
Message-ID: <20240728160954.2054068-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728160954.2054068-1-sashal@kernel.org>
References: <20240728160954.2054068-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.223
Content-Transfer-Encoding: 8bit

From: Charles Keepax <ckeepax@opensource.cirrus.com>

[ Upstream commit 91cdecaba791c74df6da0650e797fe1192cf2700 ]

Add quirks for some new Dell laptops using Cirrus amplifiers in a bridge
configuration.

Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://msgid.link/r/20240527193552.165567-11-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/boards/sof_sdw.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/sound/soc/intel/boards/sof_sdw.c b/sound/soc/intel/boards/sof_sdw.c
index 25bf73a7e7bfa..ad3694d36d969 100644
--- a/sound/soc/intel/boards/sof_sdw.c
+++ b/sound/soc/intel/boards/sof_sdw.c
@@ -234,6 +234,22 @@ static const struct dmi_system_id sof_sdw_quirk_table[] = {
 		},
 		.driver_data = (void *)(RT711_JD2_100K),
 	},
+	{
+		.callback = sof_sdw_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_SKU, "0CE3")
+		},
+		.driver_data = (void *)(SOF_SIDECAR_AMPS),
+	},
+	{
+		.callback = sof_sdw_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_SKU, "0CE4")
+		},
+		.driver_data = (void *)(SOF_SIDECAR_AMPS),
+	},
 	{}
 };
 
-- 
2.43.0


