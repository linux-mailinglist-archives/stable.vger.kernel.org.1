Return-Path: <stable+bounces-43406-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C18EE8BF280
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D51B28229E
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17FCE210195;
	Tue,  7 May 2024 23:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YjEzO3wk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57CE210189;
	Tue,  7 May 2024 23:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715123623; cv=none; b=KOB/N9yfqKK2HChyFMLEEh5w/vdp31xRRFLTVvrOLLo4ZcBaCpUjtDOz8/C+Me4frfUHvAfgpsCexpMhr6Xbi2VNcuPZd5sKs7YYSefxUNRureQgahNPvvYvmCpHe0cfML7QZdF7ounOga/ij7duT6eSwKtdxtGoB+h3bqxp7LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715123623; c=relaxed/simple;
	bh=rn7UcmnI++JbqNyYfnzjkMyqhtS2zkMHokclIOfOATY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GH9gwD4f+FByOLRuohY95dV7idd88m4iuof8FAl5aWfMrznK14uVpbAQzroN6fkKBZiGigDoW3FPaZ3gTsWdjaqSCEOxq1fXOqOJtaZ22WjknomiQhHa40BSEpYgvCokS6Fsdez5fQz6AnsD2hcmTeEpEfN2cc+k3av5SbBSxlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YjEzO3wk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3694DC4AF63;
	Tue,  7 May 2024 23:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715123623;
	bh=rn7UcmnI++JbqNyYfnzjkMyqhtS2zkMHokclIOfOATY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YjEzO3wk/TJrU2QY5DH2o/KkhGU6LVI1oZZSWW8sdNuaO0UCMBbdzBciLKYQxfdsF
	 4tSvBKU9AVEPzPsf/rQGIg/dpux9mc93CVR8aj/RFYQgcnCX8PzjZIaC76rabuY8v3
	 p6Oz5+Tgm+nXuenRzf3BpAUdCOFxg6zlBPQNN/ubJrqo70AUEO1UnTxqavPlGD8L/X
	 1+neErgY0Bclauzm0bJuHmuzdlLlR/VXBzshDn+5VsJsd5zpWCVWePEY4A/9gS786M
	 reqxhej5G69QlgRS8yp0MYwufGiBkH3QKLg1exqSNshIaYd4PRZmD+uNQ2HYTzo7WR
	 V4fN9qk2tmq7g==
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
Subject: [PATCH AUTOSEL 5.15 06/15] ASoC: rt715-sdca: volume step modification
Date: Tue,  7 May 2024 19:13:15 -0400
Message-ID: <20240507231333.394765-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507231333.394765-1-sashal@kernel.org>
References: <20240507231333.394765-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.158
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
index bfa536bd71960..7c8d6a012f610 100644
--- a/sound/soc/codecs/rt715-sdca.c
+++ b/sound/soc/codecs/rt715-sdca.c
@@ -315,7 +315,7 @@ static int rt715_sdca_set_amp_gain_8ch_get(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
-static const DECLARE_TLV_DB_SCALE(in_vol_tlv, -17625, 375, 0);
+static const DECLARE_TLV_DB_SCALE(in_vol_tlv, -1725, 75, 0);
 static const DECLARE_TLV_DB_SCALE(mic_vol_tlv, 0, 1000, 0);
 
 static int rt715_sdca_get_volsw(struct snd_kcontrol *kcontrol,
@@ -476,7 +476,7 @@ static const struct snd_kcontrol_new rt715_sdca_snd_controls[] = {
 			RT715_SDCA_FU_VOL_CTRL, CH_01),
 		SDW_SDCA_CTL(FUN_MIC_ARRAY, RT715_SDCA_FU_ADC7_27_VOL,
 			RT715_SDCA_FU_VOL_CTRL, CH_02),
-			0x2f, 0x7f, 0,
+			0x2f, 0x3f, 0,
 		rt715_sdca_set_amp_gain_get, rt715_sdca_set_amp_gain_put,
 		in_vol_tlv),
 	RT715_SDCA_EXT_TLV("FU02 Capture Volume",
@@ -484,13 +484,13 @@ static const struct snd_kcontrol_new rt715_sdca_snd_controls[] = {
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


