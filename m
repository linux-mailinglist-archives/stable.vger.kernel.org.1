Return-Path: <stable+bounces-70028-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6766D95CF67
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 16:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2446F28122C
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 14:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D64D1A38CD;
	Fri, 23 Aug 2024 14:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uHQ8Zg5K"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D5F1A38C3;
	Fri, 23 Aug 2024 14:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724421919; cv=none; b=rha8XEWIS4v3VraIoH2su4NZAFsrFMFb0oYqJZs8cYe0cZrnLeWpsSRoNX4q+hLQ+x7piRgh46Sh+JfAFE0MEYfpUnccYkedtvHyGS2jU8Yts/VbKztZxbQwoP4fDrZ/HpV+q3ThqAx+rkoNE17b/NfJcU6ij+jQmUCrpwO+QB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724421919; c=relaxed/simple;
	bh=VH0aY4estQCwicRYBWlxraTzj5ZQ7u7+dU1JRYM3hdE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Putu9txmCwpFHJ9xR8QfeZEk+e0SjW2AnF4VEs5+B942/SBGVNZwIEDCfT242onX42JREO1EzPYa6TVDKqZMS2mIWEdUKnRCbSpibcSiBk6kCqUC56nx6f9enJrsm13sahufEQKr4juJu7rQlq34GMIPxAJPYZ4XJaUshElrtV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uHQ8Zg5K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAAC2C32786;
	Fri, 23 Aug 2024 14:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724421919;
	bh=VH0aY4estQCwicRYBWlxraTzj5ZQ7u7+dU1JRYM3hdE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uHQ8Zg5KB/yrWNHcyDjFm9eKVy/8GCxNMOd+M9gkWMPDwlLlWXIyLaiP3kMb8lpCa
	 /OIDgA1YtdzYYFIPrirNjKBDnkurgUksebMMhfVcIh8QnEGCsjIyz70lAVFvCo5pjF
	 eY1/B7t4/oKqaNVPT0gjmQ1ypm00J/Uk/+ORCdVA4nXkky4Gst1LhjiCVZ+LIPqBt6
	 NLG6MoAB+mKPVbTth3FIlkEKNveoKNRYrVGDDnzMjZWhwUDomM5v8aiunQf+YDW50M
	 Au+uNsIu+TkKzn2Wc6XHpDBE9Tmz6Oejit647DktQo7kPKM7HJhjz6C3G6eXSYc+Ay
	 rGe0Ay8NJDxnA==
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
Subject: [PATCH AUTOSEL 5.15 4/9] net: phy: vitesse: repair vsc73xx autonegotiation
Date: Fri, 23 Aug 2024 10:04:51 -0400
Message-ID: <20240823140507.1975524-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240823140507.1975524-1-sashal@kernel.org>
References: <20240823140507.1975524-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.165
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


