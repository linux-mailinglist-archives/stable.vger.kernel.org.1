Return-Path: <stable+bounces-83592-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB8F99B47A
	for <lists+stable@lfdr.de>; Sat, 12 Oct 2024 13:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16EBC1F261BE
	for <lists+stable@lfdr.de>; Sat, 12 Oct 2024 11:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA801207A1E;
	Sat, 12 Oct 2024 11:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jy8h+1dS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45151865EB;
	Sat, 12 Oct 2024 11:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728732620; cv=none; b=nWnMNJXYQTrg9CjpAwx+dHuQmmLNA3WVlXIncnOnpeStB5GIw5O4ltTPIUAkHyBS26muvQshWCtMAarjCJEy2lmQHWKa11uAh9EPfKfE0EgwLiy6NCkfrZOHFNibIwd3ynm5LHRx6179Afr11GyeAsmFLpyht2By2JMq+Coo6U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728732620; c=relaxed/simple;
	bh=ewWdFYs6EezhQAgp5OSuv91igPdOBaRQyHwPqn+SdnA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UXnsZSuH3kAaqaqq+wxIR6RBrDjODPxIseAf7j1bfjzTaoHSwdnogzmnWdu/MeDLXzc8vub7q/lIxmji0yIznEpuRBZRn6wbET+WVW5Sc40gB8TZ2n4Kd4esYxp6gSF+YK2yv+PzcCceen0QI6ThQexL9CnDN3nl+1Z/bEmOhvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jy8h+1dS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EBCAC4CECF;
	Sat, 12 Oct 2024 11:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728732620;
	bh=ewWdFYs6EezhQAgp5OSuv91igPdOBaRQyHwPqn+SdnA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jy8h+1dSBnvp8iiv/9m0M4ZzjpUu9e8WzC6M/eXocEPrZqK1dQn9jqxh3R7ixbhVI
	 ZpB2qJFbWH6BpowzdrB++Q7BXoLRfKi/Ryi/ROTKrX+QnvENzK2irjRPyklZ78O3+B
	 EHizWExbWRojm9Y3eOHgQG3cNUhGWqfmXyQ5BQLaWcZGoAWXllqEekLAPXdNafY1nG
	 ZdRe0pY12RNbpwc2wK8DSQq75jw6fA538PnID+R09Kg37g/JGfH1gUvkjyuK9znrAN
	 JA1Zwa5Ag9wGkNQTsNwvhtdSr4lJyHSUkihTrtzD54VALTx/mDFVGnz1eRODCE6XKZ
	 k/6cJrdClY8Fw==
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
Date: Sat, 12 Oct 2024 07:30:01 -0400
Message-ID: <20241012113009.1764620-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241012113009.1764620-1-sashal@kernel.org>
References: <20241012113009.1764620-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.322
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


