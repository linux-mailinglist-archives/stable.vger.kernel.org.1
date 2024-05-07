Return-Path: <stable+bounces-43280-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C96B8BF14B
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D015CB2271B
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6559C84E0E;
	Tue,  7 May 2024 23:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ABQRFiy8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E6B7E590;
	Tue,  7 May 2024 23:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715123284; cv=none; b=mmB8dcfGB8detEl6CBcRlPfU/6+tpTlVmZxfzTT4y6z3pczf3GTU19K17rab+riJQVAaXbZ9QwzJQIEuQGxwesSx6oovxwCd7klaChGTVjVi6xgi/GsrPmnxyjpwqh26QGmRgX8FHTwRDKimLNBoksU6mcyYUUWKmvdm3U0GOos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715123284; c=relaxed/simple;
	bh=i+Cebfv7lo2+fMdPiE3yCY9/11GRUsk941J/hpctKbY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=om0zA6bztj5EPpD3Glj3WNeqypcWnWLMjcQ7h1d+uh6qOB+mWnlHFv5h9HcBjbXvFUwsbcSaIYzS/wWRJlNUeUiedfSWmXjyXNiJ/fRYW2AK5ZSUpHiR+DFRIg4ar9+UDbBP/nPBc47rpw+Oz71NeXhEDinJ/hD6io256BUfM6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ABQRFiy8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8AD7C2BBFC;
	Tue,  7 May 2024 23:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715123283;
	bh=i+Cebfv7lo2+fMdPiE3yCY9/11GRUsk941J/hpctKbY=;
	h=From:To:Cc:Subject:Date:From;
	b=ABQRFiy85RdH86YjCUsG20eqUym1K761qFiB1rvbm4umW40hthZSUFcS7W7yAiANF
	 OaKiVSO9xAB7bD7kGksCFpobLbO2sHL8eCBIddMQRI7Q4RxrRQ/UcmR7wQstiNEg4F
	 mq7cdIMFrlNiXMuhvPB6dIb6UATMBKXxdaeZPI2Kzc0FiXNDWDgYk2tXfm20bDYi1L
	 rPqUNwcQJprRwLnrbUR2c06l4oOSYYSrkX+TspjQFJnzoWaRusjS3abF/IYIIMrPQ/
	 De7hNI1JzDaxJICgppT1UPHTFP6hZA6b3Rpxptk96KDISS0cb0nZO+u1u7sLlydGrv
	 1krWWazjUfw7w==
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
	alban.boye@protonmail.com,
	kuninori.morimoto.gx@renesas.com,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 01/52] ASoC: Intel: bytcr_rt5640: Apply Asus T100TA quirk to Asus T100TAM too
Date: Tue,  7 May 2024 19:06:27 -0400
Message-ID: <20240507230800.392128-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.9
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
index 05f38d1f7d824..b41a1147f1c34 100644
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


