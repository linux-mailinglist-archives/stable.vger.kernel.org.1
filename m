Return-Path: <stable+bounces-43332-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFBAC8BF1CD
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E08F1C22E12
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B9585959;
	Tue,  7 May 2024 23:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JrLFjPaO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F44A7FBA6;
	Tue,  7 May 2024 23:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715123436; cv=none; b=EtG0Do653801mD/bjwLy3B8+/WUoQDkCO830Vw743PrFO836rBkHZ8eFND7uDfkeFP9YTbtaGtKLCXTwnpQWfL4oCGKXbJQK9PWuPCJK2voPVUd+2fhktFj2blXmCELgh6FIOc6ZrefT6EHd2Y8oy1Nd5fapjFz/lyNOL0JWqZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715123436; c=relaxed/simple;
	bh=mlO1AB1Iz8VdqHcNQzJ0eSmS0bKUqYyoUn6XIjE4TJM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=crKyXivCvcFx+Mp0qV70zLY0lJ0ciiKJq2Mmu7tSkwTRr+Da3Ke9oUbhJcXswZErFyOPpJXGQ/xnpLx537fPqN9scGECKuO2BKJXYYtyldLjnzfr2SjaBJM9qWOzG8NL5dOXLeTji+/2ls5vfjuXjx2abwYL2mhA0Hozm4vTT8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JrLFjPaO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 900ABC2BBFC;
	Tue,  7 May 2024 23:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715123436;
	bh=mlO1AB1Iz8VdqHcNQzJ0eSmS0bKUqYyoUn6XIjE4TJM=;
	h=From:To:Cc:Subject:Date:From;
	b=JrLFjPaOdJ6/C1eBKUy1ozF8req+Fdq64njZH5RtwZXxUnCzCs1Gz8uAU6gXTPSMj
	 svjPJo2txJuZ5/8LAkWA6yJD3KLyNqDuZSY1iR1eaquGu+S4K9hcy7+CK3AQHCIm56
	 emoAv0L1noh+nhDBP2IKo/gdm4VDp48G1EGgPpJqU4iJ+7I6G7g9WeX2JtKRVzxrFk
	 UhNlbwfgBGnCYx0u3gMWCsCuC+hxWsgqy7+oGkS1BdsMf2ZV8Y7/rjZ+OUKtCROwza
	 QQE+LKXM4WwDZKL4CoyfcO9gsQaSYB8QRnwl3yiLQQSfn6OMZr/6YG2fyTxsgQ0CS2
	 I/7VCZDseSqsw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	cezary.rojewski@intel.com,
	pierre-louis.bossart@linux.intel.com,
	liam.r.girdwood@linux.intel.com,
	peter.ujfalusi@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	kai.vehmanen@linux.intel.com,
	perex@perex.cz,
	tiwai@suse.com,
	kuninori.morimoto.gx@renesas.com,
	alban.boye@protonmail.com,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 01/43] ASoC: Intel: bytcr_rt5640: Apply Asus T100TA quirk to Asus T100TAM too
Date: Tue,  7 May 2024 19:09:22 -0400
Message-ID: <20240507231033.393285-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.30
Content-Transfer-Encoding: 8bit

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit e50729d742ec364895f1c389c32315984a987aa5 ]

The Asus T100TA quirk has been using an exact match on a product-name of
"T100TA" but there are also T100TAM variants with a slightly higher
clocked CPU and a metal backside which need the same quirk.

Sort the existing T100TA (stereo speakers) below the more specific
T100TAF (mono speaker) quirk and switch from exact matching to
substring matching so that the T100TA quirk will also match on
the T100TAM models.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Link: https://msgid.link/r/20240407191559.21596-1-hdegoede@redhat.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/boards/bytcr_rt5640.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index e609249cc38d5..651408c6f399d 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -636,28 +636,30 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
 					BYT_RT5640_USE_AMCR0F28),
 	},
 	{
+		/* Asus T100TAF, unlike other T100TA* models this one has a mono speaker */
 		.matches = {
 			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
-			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "T100TA"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "T100TAF"),
 		},
 		.driver_data = (void *)(BYT_RT5640_IN1_MAP |
 					BYT_RT5640_JD_SRC_JD2_IN4N |
 					BYT_RT5640_OVCD_TH_2000UA |
 					BYT_RT5640_OVCD_SF_0P75 |
+					BYT_RT5640_MONO_SPEAKER |
+					BYT_RT5640_DIFF_MIC |
+					BYT_RT5640_SSP0_AIF2 |
 					BYT_RT5640_MCLK_EN),
 	},
 	{
+		/* Asus T100TA and T100TAM, must come after T100TAF (mono spk) match */
 		.matches = {
-			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
-			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "T100TAF"),
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "T100TA"),
 		},
 		.driver_data = (void *)(BYT_RT5640_IN1_MAP |
 					BYT_RT5640_JD_SRC_JD2_IN4N |
 					BYT_RT5640_OVCD_TH_2000UA |
 					BYT_RT5640_OVCD_SF_0P75 |
-					BYT_RT5640_MONO_SPEAKER |
-					BYT_RT5640_DIFF_MIC |
-					BYT_RT5640_SSP0_AIF2 |
 					BYT_RT5640_MCLK_EN),
 	},
 	{
-- 
2.43.0


