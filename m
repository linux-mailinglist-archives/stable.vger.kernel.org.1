Return-Path: <stable+bounces-89661-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0889BB23C
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 12:05:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8811E1F2109A
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 11:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2441C1AA9;
	Mon,  4 Nov 2024 10:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dlOHg/sP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391661C1746;
	Mon,  4 Nov 2024 10:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730717662; cv=none; b=n87lEwkosG6jN7mr0WkhQVvQ+Md6IlmKR9jjHgToR1OJ0Yvm8JNa9m99a5yFtQyIaOtw+SJm9pmiX7ghiyRHVcvZphXCObah7N023/mazITtkDPQdWge6WzUS95jUdOqaia/OnI1mn6ediiip7aHnSAF+nrZfaqHw6t3twg5chQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730717662; c=relaxed/simple;
	bh=a+bbiG3SFKj1AMAqvdZrshg2uoJeyHWsEIDh1NhuEWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o0JOkEkVggBtVi86MT0KjVMt5R77FP/KWPlqz2BXp6lQM7eqOXo+VFTM9GsjIf77dlJ1tbltMHQrjEOyHSjUNX1H8TCPg62hHrZZfXJZfwtcsjxMxgwz1QzyAAiwXdBe9stbpX679zDr65PCV50dFgD1B690diDPZ2FXU/tP2VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dlOHg/sP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6B27C4CECE;
	Mon,  4 Nov 2024 10:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730717661;
	bh=a+bbiG3SFKj1AMAqvdZrshg2uoJeyHWsEIDh1NhuEWg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dlOHg/sPSwtjXaeTsL2VGuw51kVihuNdTioj2au62xZhPAKFhZdCka5Enf+uX75Lz
	 XMSY1CaAVgonaKFEKfDOk2vJdvPsOcvjijiiNbPTxPbkwV1nYuv7es6ZrSR7VWQvIi
	 6mFe8KLiqlqmTh8lndH42Jkh8bD66JVZzHzjDIwyYqTUISWx7zWs/dMj8BuCRQyPZ/
	 iypvmHIvgGM2gDi7XOzcKq/i+e4emY7DOb9a30u03G7HuotDdVMPXiw1Bb4JGqMv84
	 J9iMTVrVH8wOKiAxi2bktWd9weoBKsa2d/KLTL97M+gESC1YE8815/i6SdnzNjTfe7
	 6fSEJs7ZvmMow==
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
	tomlohave@gmail.com,
	alban.boye@protonmail.com,
	u.kleine-koenig@baylibre.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 02/10] ASoC: Intel: bytcr_rt5640: Add DMI quirk for Vexia Edu Atla 10 tablet
Date: Mon,  4 Nov 2024 05:53:51 -0500
Message-ID: <20241104105414.97666-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241104105414.97666-1-sashal@kernel.org>
References: <20241104105414.97666-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.170
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
index 899a8435a1eb8..8706fef8ccce8 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -1102,6 +1102,21 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
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


