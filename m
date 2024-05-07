Return-Path: <stable+bounces-43345-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 077278BF1E8
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0B201F21034
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0EF14A0B8;
	Tue,  7 May 2024 23:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sg1Y9OPX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765E314A0A7;
	Tue,  7 May 2024 23:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715123459; cv=none; b=MSK4qF82SRMAGpYgKSvI+NfK3mSFRTtrrKy3rTrJ43HV/fS4z7IbEzy6QdGt5lpMAyiyd1EkLDakAuO0WxvpbGzSIq+ziAP2cR4BWP2W38JCoMVmMa9wy0Fs/OE9h17tv7mNo3CdHfpo/wXf9WVETCJsH5yj27lPFa0IB5KA71c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715123459; c=relaxed/simple;
	bh=WLG9byGvgiCN8PrBzGxPQQ0QWNfge3aSyrmJQsr1glw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DsLEGVPsizvu3xeNykV6frCQ3C5Q4Yv7Wl0Egvo+74nqO3tg/HKvlzGbNIAL8VhgfJm2f/LAQgo8rA+pnV0Vb0EYswQz9ZEd6cOqPBw07LtW2wioWViPfJzK4Dw+7+o9qYHpwSO2eaQvRNRUVKIsGb83QujyOzI08+SfPSCeN48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sg1Y9OPX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00A51C4AF63;
	Tue,  7 May 2024 23:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715123459;
	bh=WLG9byGvgiCN8PrBzGxPQQ0QWNfge3aSyrmJQsr1glw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sg1Y9OPXroaSJY4RqxO9nGDmmiovfrlelQfVYwl4n0tNFuFEE+sYWzpLI6DO0uGxq
	 2sgY5JACsVSIUQniiba76g1yEnI/A2/sAXgLbEBqOAmHyoRCGLoWkYcTDhiSdJQiJn
	 sHJAwvjYDOnrkw7v+IG7W8dex13cyBQuRIB2nC5tNFqwnTbH6K+zA3n1J0v/xJ8kmT
	 btorCYbo19TvKKE0noQAxSbf+RlYkL9TNOHoXnpJ7/p2TidMCsw5j/zIgXLETewdBV
	 RuWnfVX9duQ2tNByQJzD1u+zjDEIhohlrlVevwxFU4pLW/aM6+R+ps/G1oEb1azgEZ
	 JVkv/+BgUnVXQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jack Yu <jack.yu@realtek.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	oder_chiou@realtek.com,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 14/43] ASoC: rt715-sdca: volume step modification
Date: Tue,  7 May 2024 19:09:35 -0400
Message-ID: <20240507231033.393285-14-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507231033.393285-1-sashal@kernel.org>
References: <20240507231033.393285-1-sashal@kernel.org>
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

From: Jack Yu <jack.yu@realtek.com>

[ Upstream commit bda16500dd0b05e2e047093b36cbe0873c95aeae ]

Volume step (dB/step) modification to fix format error
which shown in amixer control.

Signed-off-by: Jack Yu <jack.yu@realtek.com>
Link: https://lore.kernel.org/r/b1f546ad16dc4c7abb7daa7396e8345c@realtek.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/rt715-sdca.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/rt715-sdca.c b/sound/soc/codecs/rt715-sdca.c
index 9fa96fd83d4aa..84f1dc453e971 100644
--- a/sound/soc/codecs/rt715-sdca.c
+++ b/sound/soc/codecs/rt715-sdca.c
@@ -316,7 +316,7 @@ static int rt715_sdca_set_amp_gain_8ch_get(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
-static const DECLARE_TLV_DB_SCALE(in_vol_tlv, -17625, 375, 0);
+static const DECLARE_TLV_DB_SCALE(in_vol_tlv, -1725, 75, 0);
 static const DECLARE_TLV_DB_SCALE(mic_vol_tlv, 0, 1000, 0);
 
 static int rt715_sdca_get_volsw(struct snd_kcontrol *kcontrol,
@@ -477,7 +477,7 @@ static const struct snd_kcontrol_new rt715_sdca_snd_controls[] = {
 			RT715_SDCA_FU_VOL_CTRL, CH_01),
 		SDW_SDCA_CTL(FUN_MIC_ARRAY, RT715_SDCA_FU_ADC7_27_VOL,
 			RT715_SDCA_FU_VOL_CTRL, CH_02),
-			0x2f, 0x7f, 0,
+			0x2f, 0x3f, 0,
 		rt715_sdca_set_amp_gain_get, rt715_sdca_set_amp_gain_put,
 		in_vol_tlv),
 	RT715_SDCA_EXT_TLV("FU02 Capture Volume",
@@ -485,13 +485,13 @@ static const struct snd_kcontrol_new rt715_sdca_snd_controls[] = {
 			RT715_SDCA_FU_VOL_CTRL, CH_01),
 		rt715_sdca_set_amp_gain_4ch_get,
 		rt715_sdca_set_amp_gain_4ch_put,
-		in_vol_tlv, 4, 0x7f),
+		in_vol_tlv, 4, 0x3f),
 	RT715_SDCA_EXT_TLV("FU06 Capture Volume",
 		SDW_SDCA_CTL(FUN_MIC_ARRAY, RT715_SDCA_FU_ADC10_11_VOL,
 			RT715_SDCA_FU_VOL_CTRL, CH_01),
 		rt715_sdca_set_amp_gain_4ch_get,
 		rt715_sdca_set_amp_gain_4ch_put,
-		in_vol_tlv, 4, 0x7f),
+		in_vol_tlv, 4, 0x3f),
 	/* MIC Boost Control */
 	RT715_SDCA_BOOST_EXT_TLV("FU0E Boost",
 		SDW_SDCA_CTL(FUN_MIC_ARRAY, RT715_SDCA_FU_DMIC_GAIN_EN,
-- 
2.43.0


