Return-Path: <stable+bounces-110754-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3544FA1CC1A
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 17:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCF621882AE4
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B402823236E;
	Sun, 26 Jan 2025 15:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UnkasEXm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCF81F91D1;
	Sun, 26 Jan 2025 15:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737904095; cv=none; b=ogvggBg0cjrJcSg0cobs6kQjhwDPHGd82lXVFRrSdnUXMR3DqUj0vbeKAEfhZV2kh2pLFjzPHDziw4GXrpWnQv5L3aGV2JrDf82MzDzc0z3Hehklaizcd35CB7URgOuG3KDcm9ODW3h5/ebhogjoTed1kJqPBjO3JUfAT6dv6aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737904095; c=relaxed/simple;
	bh=wmCvz7H9zB5HkCm+N0v6cJJZiu6DvNdNrpd9md0NDR4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L5Um65TL8SgYQvfYULMW5k+xvzyObXYz/T2+adv/XuiiU06OK+TtPHF+eZ4e2soLEoloC+rx1S1crTJQgVKjdhd4eT00sBTNarMMNyaZjKXk0cUSevGJenOUYH5TDKzcegDNAGZERoruN3qnU0tZg+NC9d+uvA+t7U1lUUd9iec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UnkasEXm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BD58C4CED3;
	Sun, 26 Jan 2025 15:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737904094;
	bh=wmCvz7H9zB5HkCm+N0v6cJJZiu6DvNdNrpd9md0NDR4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UnkasEXmPN3etfkRA5YIG7M7G1bYGPXtqEX97r1LkBGhvn+o0zJSpq80r6RIK2V7A
	 0ZwwUNjBhgXDePor1S4PCb6o1hW6fttIr3Jf7cc22A3S2M99roBV4B5JJ1hH8hpEAU
	 ng6/AS2h9GCsUfF4aaAaV/9BhtfgcLhAvBSuQU7iOooa41r5PkY0UMNSXgG1LrtuoW
	 /Q5Ye8qbYf3ho+ojkhsPQOLnO1IcisaFv2HHX3dtehm1Znzr36TglKmXfVSgixv9nk
	 IVRNPtHcm/Wsbic/es0AViFUWPiUKsRIBD26Omnt1W5ZZ+EsFMaWEzVamtUkcQTqNt
	 tB6SVTwdPWwJQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Simon Trimmer <simont@opensource.cirrus.com>,
	Liam Girdwood <liam.r.girdwood@intel.com>,
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
	ckeepax@opensource.cirrus.com,
	Vijendar.Mukunda@amd.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 03/14] ASoC: Intel: sof_sdw: Correct quirk for Lenovo Yoga Slim 7
Date: Sun, 26 Jan 2025 10:07:50 -0500
Message-Id: <20250126150803.962459-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126150803.962459-1-sashal@kernel.org>
References: <20250126150803.962459-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.11
Content-Transfer-Encoding: 8bit

From: Simon Trimmer <simont@opensource.cirrus.com>

[ Upstream commit 7662f0e5d55728a009229112ec820e963ed0e21c ]

In addition to changing the DMI match to examine the product name rather
than the SKU, this adds the quirk to inform the machine driver to not
bind in the cs42l43 microphone DAI link.

Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
Reviewed-by: Liam Girdwood <liam.r.girdwood@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Link: https://patch.msgid.link/20241206075903.195730-5-yung-chuan.liao@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/boards/sof_sdw.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/boards/sof_sdw.c b/sound/soc/intel/boards/sof_sdw.c
index 41042259f2b26..9456b63389db5 100644
--- a/sound/soc/intel/boards/sof_sdw.c
+++ b/sound/soc/intel/boards/sof_sdw.c
@@ -600,9 +600,10 @@ static const struct dmi_system_id sof_sdw_quirk_table[] = {
 		.callback = sof_sdw_quirk_cb,
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-			DMI_EXACT_MATCH(DMI_PRODUCT_SKU, "380E")
+			DMI_MATCH(DMI_PRODUCT_NAME, "83HM")
 		},
-		.driver_data = (void *)(SOC_SDW_SIDECAR_AMPS),
+		.driver_data = (void *)(SOC_SDW_SIDECAR_AMPS |
+					SOC_SDW_CODEC_MIC),
 	},
 	{
 		.callback = sof_sdw_quirk_cb,
-- 
2.39.5


