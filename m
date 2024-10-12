Return-Path: <stable+bounces-83558-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE6E99B3F0
	for <lists+stable@lfdr.de>; Sat, 12 Oct 2024 13:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0B0F1F2843B
	for <lists+stable@lfdr.de>; Sat, 12 Oct 2024 11:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFEF21D2238;
	Sat, 12 Oct 2024 11:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R+RNKAbe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5671D0E18;
	Sat, 12 Oct 2024 11:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728732517; cv=none; b=I5W+K5vTgC7LON1q6JoiFn3ueHrCrNx6KjCs2WoDt6a4l23sYoz+v01Ezhw9YV76KaDndoX5rQSXIlt+buwUO1Lq8wnGKfqiU4I0R22chriGOcnjdgTIZMtqT0AqgWGEHBiZFLp7TYyklVPIcSpQfZOiVztijjYZwM4UaEvEpKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728732517; c=relaxed/simple;
	bh=VH0aY4estQCwicRYBWlxraTzj5ZQ7u7+dU1JRYM3hdE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nhO/tyAmMMJSiquQBcYv0nGOZPNN55cby0nopyF86Hvs/5+gSdwTttho39tVY6XCm/CXAQxZb5qOmawOyMI0dmOp6z5YeLKePqj6pSU8qSlZT1GtWBUCP6g2sSoSnhtswh4+GMCZPbOJcnpMIcbuIIMX0ioXj+kfMK/vdDrqOOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R+RNKAbe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F1A3C4CEC7;
	Sat, 12 Oct 2024 11:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728732517;
	bh=VH0aY4estQCwicRYBWlxraTzj5ZQ7u7+dU1JRYM3hdE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R+RNKAbeGtIaU4pwBYfqY3gPk5Rh5Vgy2tWAfRGyWu8MBCriMg2ffhVZJvh7K4FCB
	 9IYB3MR01FhEeAu8rGRSSY6QnQ1Kf4RcYA168tBBU37R6sKruGKjM+MYpWJQ4/e998
	 Z45eXEOc9S7eiOC2LZo19A9WtkC0xVVqkvuP02OVXlKC6eFCm/Mg4k+b7UAIwh9pHL
	 dWigAR6SRmwyOT6PLT8D6pQG9Jj1F2SmgVkTeqk/1I/bYFQrlPTu5m+fWuR2SmPeo2
	 85T44/LDX1mldTXmEnH039PKrHSbJ68sTwdBVfjLObtOjFoumbBCtHSRvz7tUSQujD
	 qKlqebBq6Wyqw==
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
Subject: [PATCH AUTOSEL 6.1 08/13] net: phy: vitesse: repair vsc73xx autonegotiation
Date: Sat, 12 Oct 2024 07:27:57 -0400
Message-ID: <20241012112818.1763719-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241012112818.1763719-1-sashal@kernel.org>
References: <20241012112818.1763719-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.112
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
index 897b979ec03c8..3b5fcaf0dd36d 100644
--- a/drivers/net/phy/vitesse.c
+++ b/drivers/net/phy/vitesse.c
@@ -237,16 +237,6 @@ static int vsc739x_config_init(struct phy_device *phydev)
 	return 0;
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
  * on "rgmii-txid", "rgmii-rxid" or "rgmii" interfaces.
@@ -444,7 +434,6 @@ static struct phy_driver vsc82xx_driver[] = {
 	.phy_id_mask    = 0x000ffff0,
 	/* PHY_GBIT_FEATURES */
 	.config_init    = vsc738x_config_init,
-	.config_aneg    = vsc73xx_config_aneg,
 	.read_page      = vsc73xx_read_page,
 	.write_page     = vsc73xx_write_page,
 }, {
@@ -453,7 +442,6 @@ static struct phy_driver vsc82xx_driver[] = {
 	.phy_id_mask    = 0x000ffff0,
 	/* PHY_GBIT_FEATURES */
 	.config_init    = vsc738x_config_init,
-	.config_aneg    = vsc73xx_config_aneg,
 	.read_page      = vsc73xx_read_page,
 	.write_page     = vsc73xx_write_page,
 }, {
@@ -462,7 +450,6 @@ static struct phy_driver vsc82xx_driver[] = {
 	.phy_id_mask    = 0x000ffff0,
 	/* PHY_GBIT_FEATURES */
 	.config_init    = vsc739x_config_init,
-	.config_aneg    = vsc73xx_config_aneg,
 	.read_page      = vsc73xx_read_page,
 	.write_page     = vsc73xx_write_page,
 }, {
@@ -471,7 +458,6 @@ static struct phy_driver vsc82xx_driver[] = {
 	.phy_id_mask    = 0x000ffff0,
 	/* PHY_GBIT_FEATURES */
 	.config_init    = vsc739x_config_init,
-	.config_aneg    = vsc73xx_config_aneg,
 	.read_page      = vsc73xx_read_page,
 	.write_page     = vsc73xx_write_page,
 }, {
-- 
2.43.0


