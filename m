Return-Path: <stable+bounces-46483-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A25038D06BB
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 17:53:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 447491F2353A
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 15:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F2D15E5B0;
	Mon, 27 May 2024 15:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XQhTrfRs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C26717E8E2;
	Mon, 27 May 2024 15:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716825128; cv=none; b=e++SzzwoBF6+DphlWelzk865AGu5VF22445b3rQilySgHkU7Grpk+5vsVKbrYzjXE+9MgvWDWqGkbSFbfvIiLJDJIs+2+O+oLSZfaHmtKhQpThp7GuDfj8aqdDHf0Pel77X2TacF6lxR4rvNSggxBprz99wLozaGhmPy9lGhDKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716825128; c=relaxed/simple;
	bh=2cLx1RTnLIZnsam3m/uMcFJB/9IKs3dw7YoYr5Yf46k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JTP1FLEKGkQprj0riHOUi+r4lD/OZTPFNeo0U8Jn/YumPbwMFaikdPDkW7N1EPq+lizhryBXMQ8I0UCoYee9kOy/MgpnqQjYeOlR7gDFUsXGfe1gZQ++Vqd1ap0puJsVam6dpsyo9QXLUSd71o++kEAoCWRQmN0UXU5FXnd+PJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XQhTrfRs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6584FC4AF08;
	Mon, 27 May 2024 15:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716825128;
	bh=2cLx1RTnLIZnsam3m/uMcFJB/9IKs3dw7YoYr5Yf46k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XQhTrfRslkJjPbNnEn1XmIuo9RlCJqoRqp71BSlUALfNy33GryknV+/cojNKVUGU2
	 yQX5pm9zsiC0Z7GbgeziIsx7MEH3ODSdOXgu4Wb2m03lz3E/WveDrz1iD83JaL03j+
	 otiPOm8zSgYemkVYkhTow3RTBsrh9W29uTQEwqhGtERH2xZqt8tSNqdC2Ye1TaqcPC
	 fbYj44OsRFCHF4YJuG+XvydVwC/GC1KYd9HMarKwbiku50xToC7fuKAi5GlEz7Z4RA
	 XYq4Uaib5q5LoQvaV5RLSa0g219fj6IzK5YLMgeh/5JcQUzsz4CUrHuFaFwgW8lv87
	 3v2InRlsKFoyg==
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
Subject: [PATCH AUTOSEL 6.9 08/23] ASoC: Intel: sof_sdw: add JD2 quirk for HP Omen 14
Date: Mon, 27 May 2024 11:50:09 -0400
Message-ID: <20240527155123.3863983-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240527155123.3863983-1-sashal@kernel.org>
References: <20240527155123.3863983-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.2
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
index 08f330ed5c2ea..f4f08e9031506 100644
--- a/sound/soc/intel/boards/sof_sdw.c
+++ b/sound/soc/intel/boards/sof_sdw.c
@@ -495,6 +495,15 @@ static const struct dmi_system_id sof_sdw_quirk_table[] = {
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


