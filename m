Return-Path: <stable+bounces-70037-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB2395CF80
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 16:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 419721C20CB0
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 14:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BDDC1AAE1C;
	Fri, 23 Aug 2024 14:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FelA4lMC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1CE1AAE11;
	Fri, 23 Aug 2024 14:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724421952; cv=none; b=USeAQ4kRy5mCXw/bijD91y1I1o/5x8gU3pc0bXN2zBuutgDxNwYu34DC61WTH4DCjCinV/3skCQrsz9oL147m9TA4gItWWZ04nv9efZLDREjmBalDWnOmU7Tvhdk2EF1SFVKPlsOzg981ZAU4CWBkWepqEa5RS/v246SRs5dbaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724421952; c=relaxed/simple;
	bh=PNoNd7ySCCKZSMeht91COu5h8hrIkKAZ4nWz2IT5jlo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bD13qv6rdWxoPeI0Trb8zS7IL4N4i11UJnL4U7PHhT5EnPASU+mK0Kvss7jH6AoDb7ojDLvKU89K/tweYi3T/LbZaxF/JTp9tBpP7AN5bZE9r3uACTqu4s/Bg8xt0IrROCOPfbvgjOHi7kJEa3ttynQe0wRsLl/asWa0ldais4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FelA4lMC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69A14C4AF0E;
	Fri, 23 Aug 2024 14:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724421952;
	bh=PNoNd7ySCCKZSMeht91COu5h8hrIkKAZ4nWz2IT5jlo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FelA4lMCtHOzhjsNHuNWiIVwgq2y1Rpuzg3GFJoGjqXcvySfhfSIOHyo979JNOQoS
	 gYs8QZEFfCWkvMunvaoBSGSvwMhMXMXo41KaUisAdqsN98tiL2lFOz53vrcv7lBnyQ
	 Kff181KfJC4vn6NuSqJ+Vyr6mbIVudFdVNU9SbJIQzEhFPHgCI4GztvNeiFLGmozZN
	 c+fLemNjqWiZkkmMCR1ZAAlhjEes+sgmFaJTPW1rweERPwuKIj/jL32P8+W/dlVTpR
	 TNdW4emaiSSeeHxwXC7awujQ6X5c3il6ELHYOAPk0aAlM3txqn8xMwORqnK5FB+PKH
	 gKeg4GrgiBpVg==
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
Subject: [PATCH AUTOSEL 5.10 4/9] net: phy: vitesse: repair vsc73xx autonegotiation
Date: Fri, 23 Aug 2024 10:05:24 -0400
Message-ID: <20240823140541.1975737-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240823140541.1975737-1-sashal@kernel.org>
References: <20240823140541.1975737-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.224
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
index bb680352708a6..3f594c8784e20 100644
--- a/drivers/net/phy/vitesse.c
+++ b/drivers/net/phy/vitesse.c
@@ -232,16 +232,6 @@ static int vsc739x_config_init(struct phy_device *phydev)
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
  * on "rgmii-txid", "rgmii-rxid" or "rgmii" interfaces. */
@@ -424,7 +414,6 @@ static struct phy_driver vsc82xx_driver[] = {
 	.phy_id_mask    = 0x000ffff0,
 	/* PHY_GBIT_FEATURES */
 	.config_init    = vsc738x_config_init,
-	.config_aneg    = vsc73xx_config_aneg,
 	.read_page      = vsc73xx_read_page,
 	.write_page     = vsc73xx_write_page,
 }, {
@@ -433,7 +422,6 @@ static struct phy_driver vsc82xx_driver[] = {
 	.phy_id_mask    = 0x000ffff0,
 	/* PHY_GBIT_FEATURES */
 	.config_init    = vsc738x_config_init,
-	.config_aneg    = vsc73xx_config_aneg,
 	.read_page      = vsc73xx_read_page,
 	.write_page     = vsc73xx_write_page,
 }, {
@@ -442,7 +430,6 @@ static struct phy_driver vsc82xx_driver[] = {
 	.phy_id_mask    = 0x000ffff0,
 	/* PHY_GBIT_FEATURES */
 	.config_init    = vsc739x_config_init,
-	.config_aneg    = vsc73xx_config_aneg,
 	.read_page      = vsc73xx_read_page,
 	.write_page     = vsc73xx_write_page,
 }, {
@@ -451,7 +438,6 @@ static struct phy_driver vsc82xx_driver[] = {
 	.phy_id_mask    = 0x000ffff0,
 	/* PHY_GBIT_FEATURES */
 	.config_init    = vsc739x_config_init,
-	.config_aneg    = vsc73xx_config_aneg,
 	.read_page      = vsc73xx_read_page,
 	.write_page     = vsc73xx_write_page,
 }, {
-- 
2.43.0


