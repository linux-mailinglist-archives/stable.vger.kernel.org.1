Return-Path: <stable+bounces-70053-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB1995CFB4
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 16:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 851E0282B51
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 14:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581911B14F1;
	Fri, 23 Aug 2024 14:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tH0RdDh9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7D81B14E7;
	Fri, 23 Aug 2024 14:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724422009; cv=none; b=HhLzOf/PyzMyzhEEl5u4t/T+o4vlDb38YQKTV1Kf1Is6xBO3ugpBUBRV4WSsNW1zt71QAOnOGjj7GPge1VrF4yAxt0rCdBH5Pky4laAH1zwmJYoxa3+0LfOVdIZAtz6qMzpTlKWlARArbjcEbRkf4Y3uOnN3DIU50YV+2IDWNSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724422009; c=relaxed/simple;
	bh=ewWdFYs6EezhQAgp5OSuv91igPdOBaRQyHwPqn+SdnA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dm/9CPyDA/f9/gZfmJPzowqihUHvIJeqL4VtrLLj0D+8pNfuFzmrw1TUp/aHw2+lZm1bgn4OOTeuyC4pv9eaAk+UA45/eM78QhoLZ2IOaRfiZjBJKLit7UCBX64Ac4LnPsxjsiQCPcsRQGixcQRwscl2kGc3BC/0myHrD2WxN20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tH0RdDh9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35F1CC4AF09;
	Fri, 23 Aug 2024 14:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724422008;
	bh=ewWdFYs6EezhQAgp5OSuv91igPdOBaRQyHwPqn+SdnA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tH0RdDh9cqUw7ory/1ckNg4XAGp8YngMyx/NdCBRtW/R6ofbA2RMUjKQfK5OnIvY3
	 4k6Yhu0KcLlUjumX0ZXvtvMSrd02BhQFXXIqrcIj0e0VkPqVA3xggfxIBarXzL69Rg
	 5+dxb/FHJt/fjiqXpQk9VTTJYvaTgNhNuZ452EQHRT1XytyrIc2S/2oCV6Sio1Cilc
	 ZKx3clrXjeZ/ZExxhZWM4PUNq5zOof9zOFg/4VZcQB3RnOcxQD4yLhau98vadoKctr
	 1J9QM9TsFs0Jq5/8IW6/MnAfg+/of+mNdwCQaoCkEAMe0FU3SismkEySlvhl+M9iHZ
	 kYBXtgQrE93XA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Pawel Dembicki <paweldembicki@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 4/6] net: phy: vitesse: repair vsc73xx autonegotiation
Date: Fri, 23 Aug 2024 10:06:25 -0400
Message-ID: <20240823140636.1976114-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240823140636.1976114-1-sashal@kernel.org>
References: <20240823140636.1976114-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.320
Content-Transfer-Encoding: 8bit

From: Pawel Dembicki <paweldembicki@gmail.com>

[ Upstream commit de7a670f8defe4ed2115552ad23dea0f432f7be4 ]

When the vsc73xx mdio bus work properly, the generic autonegotiation
configuration works well.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/vitesse.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/net/phy/vitesse.c b/drivers/net/phy/vitesse.c
index fbf9ad429593c..697b07fdf3ec7 100644
--- a/drivers/net/phy/vitesse.c
+++ b/drivers/net/phy/vitesse.c
@@ -241,16 +241,6 @@ static int vsc739x_config_init(struct phy_device *phydev)
 	return genphy_config_init(phydev);
 }
 
-static int vsc73xx_config_aneg(struct phy_device *phydev)
-{
-	/* The VSC73xx switches does not like to be instructed to
-	 * do autonegotiation in any way, it prefers that you just go
-	 * with the power-on/reset defaults. Writing some registers will
-	 * just make autonegotiation permanently fail.
-	 */
-	return 0;
-}
-
 /* This adds a skew for both TX and RX clocks, so the skew should only be
  * applied to "rgmii-id" interfaces. It may not work as expected
  * on "rgmii-txid", "rgmii-rxid" or "rgmii" interfaces. */
@@ -459,7 +449,6 @@ static struct phy_driver vsc82xx_driver[] = {
 	.phy_id_mask    = 0x000ffff0,
 	.features       = PHY_GBIT_FEATURES,
 	.config_init    = vsc738x_config_init,
-	.config_aneg    = vsc73xx_config_aneg,
 	.read_page      = vsc73xx_read_page,
 	.write_page     = vsc73xx_write_page,
 }, {
@@ -468,7 +457,6 @@ static struct phy_driver vsc82xx_driver[] = {
 	.phy_id_mask    = 0x000ffff0,
 	.features       = PHY_GBIT_FEATURES,
 	.config_init    = vsc738x_config_init,
-	.config_aneg    = vsc73xx_config_aneg,
 	.read_page      = vsc73xx_read_page,
 	.write_page     = vsc73xx_write_page,
 }, {
@@ -477,7 +465,6 @@ static struct phy_driver vsc82xx_driver[] = {
 	.phy_id_mask    = 0x000ffff0,
 	.features       = PHY_GBIT_FEATURES,
 	.config_init    = vsc739x_config_init,
-	.config_aneg    = vsc73xx_config_aneg,
 	.read_page      = vsc73xx_read_page,
 	.write_page     = vsc73xx_write_page,
 }, {
@@ -486,7 +473,6 @@ static struct phy_driver vsc82xx_driver[] = {
 	.phy_id_mask    = 0x000ffff0,
 	.features       = PHY_GBIT_FEATURES,
 	.config_init    = vsc739x_config_init,
-	.config_aneg    = vsc73xx_config_aneg,
 	.read_page      = vsc73xx_read_page,
 	.write_page     = vsc73xx_write_page,
 }, {
-- 
2.43.0


