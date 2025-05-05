Return-Path: <stable+bounces-141145-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB45AAB636
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 07:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBED9461A6C
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B2C329D3A;
	Tue,  6 May 2025 00:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gw69iT7o"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30BA2BEC3A;
	Mon,  5 May 2025 22:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485298; cv=none; b=dltP7LbYQZ/wOl/RdG0bHCtA/CuhxRB8cQGOnGFh9GO6QgKcjjMr8LWOHRbI4V8xBqwteVWLmBblCTlcQwJDkemr5kx607PzM3luXxL/xpZV1tQ+v7/vuymEfxrPH8AvEUo4AxoHYjnDrAzuHoHxlNYtDkLtk2YmLFfDhu7nefs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485298; c=relaxed/simple;
	bh=LrT/BzsEdzbAPHh6GUB5YHHxutK4sZM6h/Bma2CUFEc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KIcqAq9APOuwufcPYIL2Myqw6u1C/Gxr1Nxw6NItxDKwWJPhGWxiETEawB8jnvx5wPiX6D2feT4u9Xire33kGGzN/4iCnS730ss3GIKNV9ABdeUkJfSeWOVknPEwtrg6WpAKmyz6hkrpdsZjy/azbPQCyDB2J/L9LZ7j3Xoj31o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gw69iT7o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B005C4CEE4;
	Mon,  5 May 2025 22:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485298;
	bh=LrT/BzsEdzbAPHh6GUB5YHHxutK4sZM6h/Bma2CUFEc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gw69iT7o4mFM+wTDlWYCVt4l3YHe22+vENLsrhGFdMUUk7n2xC9yNxaN6ziKZ79Sj
	 2lb2s+yrrj9hzuOB8fANslgyr1I8duwCdWK21lzFg8fUTLmErSVrDMIAWhFowYoFrW
	 5GQJY8/uNgS96/bu0op9fqgvcjVsVSRmd/3qwhLcH3+80ZBYfn95roXS73nxe3eMfw
	 z8w0p6OvUIJLwgy8e17lECEsptk8ZqbmjiZK5C72/HLlL9asHATjqUHUGY1VlBuVQQ
	 Bkknqw40QzaaJnbDTWAc68i6jzXoEl83D9pia4aAZpA6erG4yO4IV1FLOTaQ/hK2PZ
	 UaKl4PuXtS9sQ==
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
Subject: [PATCH AUTOSEL 6.12 256/486] ASoC: mediatek: mt8188: Add reference for dmic clocks
Date: Mon,  5 May 2025 18:35:32 -0400
Message-Id: <20250505223922.2682012-256-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
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


