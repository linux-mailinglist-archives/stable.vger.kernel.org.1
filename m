Return-Path: <stable+bounces-141883-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE9EBAACFB8
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 23:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B44C17EC2D
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 21:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A329321ABB0;
	Tue,  6 May 2025 21:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l7JyZXpx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52078221F33;
	Tue,  6 May 2025 21:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746567364; cv=none; b=LqmYaYYkHlLe8E5PFBTb+xednBy1S3AUtI5v82O2QK7e26nKpY55BeoBaYBryfDVwYgSuAzgntcZnCesgMv927ujkhK5mG5IgnFujorH9n5/zyQPu5sK/nhoXLiLmaDpUbTGarLVRucAOeLqR08vkoyrfri2UsYzQH7xXKrXAkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746567364; c=relaxed/simple;
	bh=5fus4QswKuH4bWzhbFrvPNEYz32EATy0xQY7ugIxme8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iuO4nqBJnjqtYqMY+Jf1a8dF1wgpF1OUu3NecPW2GX15szWXkIf7yl//noEKgBMZDOUCnDokArcuqkTZVf/ZCt8vr62msvfe+X81AMTOCk9RtvyWdPr4fplUsk8dxR1zSqZ1heyTYca+ycKv9KEFiU5nol2U0f2n8GWjpvshrH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l7JyZXpx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 232F7C4CEE4;
	Tue,  6 May 2025 21:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746567363;
	bh=5fus4QswKuH4bWzhbFrvPNEYz32EATy0xQY7ugIxme8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l7JyZXpxy1JIkJkqxTNIVIQB85vosyBp1t6GrU655KsM2Vrl3v8LHE1O4WrwHZ56E
	 JPyNFhqI+4WhhUeQwSuKZ7Yu4qa32WnJdy/H8Wz5R9o6BHZrxIDoxcCqQXhaVt4wb8
	 glG3bMXrK24XLztUNwec1GHI9s/QZoC+AOW5MagVfizwwRJuXZ+S68zMQTDTbymkvL
	 Mw89gsXtHbq1ryOy435d5e3EoZfAWfeiAtT9Gu2h3e3zvjSwG807aTmz1730eUkfsC
	 7t7+s67c+hXVhlUUQRxpPVs2Xzp+KvR/ArjY98MC+E50/u2+lZi+Kug7a9mwvo6xEC
	 9XKZy1H8hC7Ww==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Stefan Binding <sbinding@opensource.cirrus.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	yung-chuan.liao@linux.intel.com,
	pierre-louis.bossart@linux.dev,
	Vijendar.Mukunda@amd.com,
	peter.ujfalusi@linux.intel.com,
	peterz@infradead.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 19/20] ASoC: intel/sdw_utils: Add volume limit to cs42l43 speakers
Date: Tue,  6 May 2025 17:35:22 -0400
Message-Id: <20250506213523.2982756-19-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250506213523.2982756-1-sashal@kernel.org>
References: <20250506213523.2982756-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Stefan Binding <sbinding@opensource.cirrus.com>

[ Upstream commit 02b44a2b2bdcee03cbb92484d31e9ca1b91b2a38 ]

The volume control for cs42l43 speakers has a maximum gain of +31.5 dB.
However, for many use cases, this can cause distorted audio, depending
various factors, such as other signal-processing elements in the chain,
for example if the audio passes through a gain control before reaching
the codec or the signal path has been tuned for a particular maximum
gain in the codec.

In the case of systems which use the soc_sdw_cs42l43 driver, audio will
likely be distorted in all cases above 0 dB, therefore add a volume
limit of 128, which is 0 dB maximum volume inside this driver.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Link: https://patch.msgid.link/20250430103134.24579-2-sbinding@opensource.cirrus.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sdw_utils/soc_sdw_cs42l43.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/soc/sdw_utils/soc_sdw_cs42l43.c b/sound/soc/sdw_utils/soc_sdw_cs42l43.c
index 668c9d28a1c12..b415d45d520d0 100644
--- a/sound/soc/sdw_utils/soc_sdw_cs42l43.c
+++ b/sound/soc/sdw_utils/soc_sdw_cs42l43.c
@@ -20,6 +20,8 @@
 #include <sound/soc-dapm.h>
 #include <sound/soc_sdw_utils.h>
 
+#define CS42L43_SPK_VOLUME_0DB	128 /* 0dB Max */
+
 static const struct snd_soc_dapm_route cs42l43_hs_map[] = {
 	{ "Headphone", NULL, "cs42l43 AMP3_OUT" },
 	{ "Headphone", NULL, "cs42l43 AMP4_OUT" },
@@ -117,6 +119,14 @@ int asoc_sdw_cs42l43_spk_rtd_init(struct snd_soc_pcm_runtime *rtd, struct snd_so
 			return -ENOMEM;
 	}
 
+	ret = snd_soc_limit_volume(card, "cs42l43 Speaker Digital Volume",
+				   CS42L43_SPK_VOLUME_0DB);
+	if (ret)
+		dev_err(card->dev, "cs42l43 speaker volume limit failed: %d\n", ret);
+	else
+		dev_info(card->dev, "Setting CS42L43 Speaker volume limit to %d\n",
+			 CS42L43_SPK_VOLUME_0DB);
+
 	ret = snd_soc_dapm_add_routes(&card->dapm, cs42l43_spk_map,
 				      ARRAY_SIZE(cs42l43_spk_map));
 	if (ret)
-- 
2.39.5


