Return-Path: <stable+bounces-153823-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF321ADD69B
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 18:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7D982C805C
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 16:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4992EE295;
	Tue, 17 Jun 2025 16:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1p86WIlh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C963A235071;
	Tue, 17 Jun 2025 16:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750177211; cv=none; b=i0eMG2dTj7EIv6QaE44gd+48o6V84rUB8eTABPjyNoEb3Nf6ZcflnxKDzWYG0D46v3vBaQ2D0apNRU6aDbzBJX0hPGyVcEAFMsyNeP/UlTPayYTDeM4upHaQruOyanzoknGDsk7XUPtfVgbcnJGOtmHZqHhTtqYulcKGYoJ9+uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750177211; c=relaxed/simple;
	bh=lfGMZeKBs2iTkjbuRV2D7VoLVPEPhr3P876C4ZEuKaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T7yS5vGDSn/yQUn2qcVOFsmQ7Y3+gd4cynboCHPL4jYMLCoLTh7bWpf2VboftuOEFXWOZqzgKkGJNmzGxBES0dpmGP7BfnSvvEmbqEu40Su7jD/uy5JvBa/1YkaGdnp4gn89Hc62tMKE7bBUA478HYcugm48nJ9Igg+dBjYLYDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1p86WIlh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E732CC4CEE3;
	Tue, 17 Jun 2025 16:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750177211;
	bh=lfGMZeKBs2iTkjbuRV2D7VoLVPEPhr3P876C4ZEuKaQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1p86WIlhgrPNT2PvtuyCR1rMseEdOjAiBhusQtSoCv3om9YeNulVjZOyaoYZO0pMH
	 osWf4l6vXBDpKEMoCG+dBfgmfipv2ILI74T8/4su0ISRcOtrCCtnGaqYMtbsAiN2t1
	 9Kz50pGn6ze3HS8CxJNptJuIK5WT66he2MfH1vsI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 308/512] phy: rockchip: samsung-hdptx: Do no set rk_hdptx_phy->rate in case of errors
Date: Tue, 17 Jun 2025 17:24:34 +0200
Message-ID: <20250617152432.086049406@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617152419.512865572@linuxfoundation.org>
References: <20250617152419.512865572@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

[ Upstream commit 1f4d382769e3b38dfc498c806811dae856e40f31 ]

Ensure rk_hdptx_ropll_tmds_cmn_config() updates hdptx->rate only after
all the other operations have been successful.

Fixes: c4b09c562086 ("phy: phy-rockchip-samsung-hdptx: Add clock provider support")
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Link: https://lore.kernel.org/r/20250318-phy-sam-hdptx-bpc-v6-4-8cb1678e7663@collabora.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
index 70526c67ca0f1..5547f8df8e717 100644
--- a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
+++ b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
@@ -781,9 +781,7 @@ static int rk_hdptx_ropll_tmds_cmn_config(struct rk_hdptx_phy *hdptx,
 {
 	const struct ropll_config *cfg = NULL;
 	struct ropll_config rc = {0};
-	int i;
-
-	hdptx->rate = rate * 100;
+	int ret, i;
 
 	for (i = 0; i < ARRAY_SIZE(ropll_tmds_cfg); i++)
 		if (rate == ropll_tmds_cfg[i].bit_rate) {
@@ -842,7 +840,11 @@ static int rk_hdptx_ropll_tmds_cmn_config(struct rk_hdptx_phy *hdptx,
 	regmap_update_bits(hdptx->regmap, CMN_REG(0086), PLL_PCG_CLK_EN,
 			   PLL_PCG_CLK_EN);
 
-	return rk_hdptx_post_enable_pll(hdptx);
+	ret = rk_hdptx_post_enable_pll(hdptx);
+	if (!ret)
+		hdptx->rate = rate * 100;
+
+	return ret;
 }
 
 static int rk_hdptx_ropll_tmds_mode_config(struct rk_hdptx_phy *hdptx,
-- 
2.39.5




