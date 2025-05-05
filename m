Return-Path: <stable+bounces-140738-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE1AAAAAF01
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CA251BC2A69
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CCB739B0B4;
	Mon,  5 May 2025 23:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BPYpU1iH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C73A2DDD0A;
	Mon,  5 May 2025 23:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486111; cv=none; b=B195Vr8KTMkh48FEKzoi723JfpFev5jRaKzjEGmXYCjfj1/RXijjz0IZ7P0ogOqZsYuH2YEqDhdrSKleSjeeax8DWn1+MQ03BeGXD0sj64bSRRFV2VqLLeSXEPX7PmHi/pcfzWj1bonoRaGkYiXSXEdROXQZW22ZJNLoDoffly4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486111; c=relaxed/simple;
	bh=LrT/BzsEdzbAPHh6GUB5YHHxutK4sZM6h/Bma2CUFEc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yes12czeFRodiAJl9AZVbMdXORx2nKuSemAh1X3Spxx0qKid8PZf3Mac7Cze6K0x2WSojiPjP7my/4hIvfj6tGHoJdJHbUVJj/AduNVfglUPyWGowayACrv0j0QEpGFLGDNomtL+QY58qimHzdYQ7wTpUC0BJK50uKF6HbOy+Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BPYpU1iH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13BF9C4CEE4;
	Mon,  5 May 2025 23:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486110;
	bh=LrT/BzsEdzbAPHh6GUB5YHHxutK4sZM6h/Bma2CUFEc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BPYpU1iHXWbaMXEY6DZVYxDVl2m8+f2FYUa40Ik9MenuVH+9hTSabzMIj3SYPvS0B
	 cOjvFE9MVV5madyHSYSJKA3NcgD1I8emSdivpGZCWj1K0/4ZRlSzu7Ygzf2R/g3Jme
	 oZgr78ZfNiWN01mKh6YJkyhyzyw0vf9Grax9vTlT8IKc4W7+0eZUV2FQuW4XQBvtGe
	 4tmaRVqnygAizCFAK/rRyc5nvQfC0Cm58XOUZCmpDMoT7vqTxZuM25dpmLAHJ+Ccw8
	 jYqqsV/yy8hsmg63jrlROjHD3UvicXeWu3dckM/TCnT9Bdb1gOctb0JqkrowEo950E
	 z/gmGjr7fEGzg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	matthias.bgg@gmail.com,
	linux-sound@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 158/294] ASoC: mediatek: mt8188: Add reference for dmic clocks
Date: Mon,  5 May 2025 18:54:18 -0400
Message-Id: <20250505225634.2688578-158-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
Content-Transfer-Encoding: 8bit

From: Nícolas F. R. A. Prado <nfraprado@collabora.com>

[ Upstream commit bf1800073f4d55f08191b034c86b95881e99b6fd ]

Add the names for the dmic clocks, aud_afe_dmic* and aud_dmic_hires*, so
they can be acquired and enabled by the platform driver.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Link: https://patch.msgid.link/20250225-genio700-dmic-v2-2-3076f5b50ef7@collabora.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/mediatek/mt8188/mt8188-afe-clk.c | 8 ++++++++
 sound/soc/mediatek/mt8188/mt8188-afe-clk.h | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/sound/soc/mediatek/mt8188/mt8188-afe-clk.c b/sound/soc/mediatek/mt8188/mt8188-afe-clk.c
index e69c1bb2cb239..7f411b8577823 100644
--- a/sound/soc/mediatek/mt8188/mt8188-afe-clk.c
+++ b/sound/soc/mediatek/mt8188/mt8188-afe-clk.c
@@ -58,7 +58,15 @@ static const char *aud_clks[MT8188_CLK_NUM] = {
 	[MT8188_CLK_AUD_ADC] = "aud_adc",
 	[MT8188_CLK_AUD_DAC_HIRES] = "aud_dac_hires",
 	[MT8188_CLK_AUD_A1SYS_HP] = "aud_a1sys_hp",
+	[MT8188_CLK_AUD_AFE_DMIC1] = "aud_afe_dmic1",
+	[MT8188_CLK_AUD_AFE_DMIC2] = "aud_afe_dmic2",
+	[MT8188_CLK_AUD_AFE_DMIC3] = "aud_afe_dmic3",
+	[MT8188_CLK_AUD_AFE_DMIC4] = "aud_afe_dmic4",
 	[MT8188_CLK_AUD_ADC_HIRES] = "aud_adc_hires",
+	[MT8188_CLK_AUD_DMIC_HIRES1] = "aud_dmic_hires1",
+	[MT8188_CLK_AUD_DMIC_HIRES2] = "aud_dmic_hires2",
+	[MT8188_CLK_AUD_DMIC_HIRES3] = "aud_dmic_hires3",
+	[MT8188_CLK_AUD_DMIC_HIRES4] = "aud_dmic_hires4",
 	[MT8188_CLK_AUD_I2SIN] = "aud_i2sin",
 	[MT8188_CLK_AUD_TDM_IN] = "aud_tdm_in",
 	[MT8188_CLK_AUD_I2S_OUT] = "aud_i2s_out",
diff --git a/sound/soc/mediatek/mt8188/mt8188-afe-clk.h b/sound/soc/mediatek/mt8188/mt8188-afe-clk.h
index ec53c171c170a..c6c78d684f3ee 100644
--- a/sound/soc/mediatek/mt8188/mt8188-afe-clk.h
+++ b/sound/soc/mediatek/mt8188/mt8188-afe-clk.h
@@ -54,7 +54,15 @@ enum {
 	MT8188_CLK_AUD_ADC,
 	MT8188_CLK_AUD_DAC_HIRES,
 	MT8188_CLK_AUD_A1SYS_HP,
+	MT8188_CLK_AUD_AFE_DMIC1,
+	MT8188_CLK_AUD_AFE_DMIC2,
+	MT8188_CLK_AUD_AFE_DMIC3,
+	MT8188_CLK_AUD_AFE_DMIC4,
 	MT8188_CLK_AUD_ADC_HIRES,
+	MT8188_CLK_AUD_DMIC_HIRES1,
+	MT8188_CLK_AUD_DMIC_HIRES2,
+	MT8188_CLK_AUD_DMIC_HIRES3,
+	MT8188_CLK_AUD_DMIC_HIRES4,
 	MT8188_CLK_AUD_I2SIN,
 	MT8188_CLK_AUD_TDM_IN,
 	MT8188_CLK_AUD_I2S_OUT,
-- 
2.39.5


