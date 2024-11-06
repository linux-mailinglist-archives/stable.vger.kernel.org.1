Return-Path: <stable+bounces-90119-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A234E9BE6CA
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 13:07:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C0D8B23B5E
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 12:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A57A1DF24B;
	Wed,  6 Nov 2024 12:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="K4jE3QSr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BC01DEFF4;
	Wed,  6 Nov 2024 12:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730894828; cv=none; b=WzZVx3xzdrTObv7f3whAt0VEsb/QnNMmuTcPHxTRDaX32Pkh+oH9w5H1imvmEx4Ztb7ffPwSdSG9uCoIADGheh7bKW5PpbE8c2HLTX0oiIF8X/gUIT02jL98l7Cc+Z0igeJmLO+ZbhgJlSmat0Jo8r+QjqGOREFMBlD2a/qEUx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730894828; c=relaxed/simple;
	bh=hCgFfeFPmHs1uZCKpKxJNtQGfpu3Ad6fMYfjgg3cO8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J4BLFI8RzH3hWcUpRBjwS2oxCcxQuzRQAh0MznnEI5SqZpBC8kXOVVGgMmJmSUptiJRO++f1BEIJRfVqA/rLo+EMsa38Z7UMEsD6+EGS0t5WNBDIz9yyrnKGiKw8h3gGFXO1bBA7qpN4hXPLWLc+T+Iq+txFPUNrrK9gQuS5lyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=K4jE3QSr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59D92C4CECD;
	Wed,  6 Nov 2024 12:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730894827;
	bh=hCgFfeFPmHs1uZCKpKxJNtQGfpu3Ad6fMYfjgg3cO8c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K4jE3QSrQP2n50FFnKFtD8RNn2RaPoYvkcK6YN+2JQdnC36Bc9rJKQQX2qyVheGZ7
	 GYdhgRUuSxi2kgXgUmC+M3+YcaftII8hKQk9VMxNI6FH0v2PZ0mKUot7YHr5RtqNkI
	 MUOdgCeX6rQx7d08GPjx/Cq8kOr40r47BsVnCXtQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Linus Walleij <linus.walleij@linaro.org>,
	Pawel Dembicki <paweldembicki@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 006/350] net: phy: vitesse: repair vsc73xx autonegotiation
Date: Wed,  6 Nov 2024 12:58:54 +0100
Message-ID: <20241106120321.026326988@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106120320.865793091@linuxfoundation.org>
References: <20241106120320.865793091@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index fbf9ad429593..697b07fdf3ec 100644
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




