Return-Path: <stable+bounces-42010-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 665428B70EA
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 12:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97FA41C221FE
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 10:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EAC012CDB6;
	Tue, 30 Apr 2024 10:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="11FRVeA+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C86A12CDB5;
	Tue, 30 Apr 2024 10:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714474267; cv=none; b=MVuE6Hh8FgUaacclZ4CONE+a0rJaGMpPniSYDSfpMZsARYiiwmTJT+syy4XriDFx3rj8LlzHG09MwQMZxGk5NYPg4SQv3KTKMOUpBbpVF2xhwH2ViKbOnqalOmBVSsi1fXuKMOZYntqbIK9gRp+TEwiQOx8mRsosowl1Djxam0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714474267; c=relaxed/simple;
	bh=QaI2xzrK76gR8SrLT6tuFs09kukT1Ct0/s9THMClk4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OOcGBWSyyT3ELNRumwsS2ldnGCDkH6tlIgYpUU4NVH23HsG2tmkxjHuvCEyMbOK5Bn6Fy1yLovsaMI8vuvPh2iXOXCGsUIoMQyKug9JtNmgObluwWkpJPdizJJpQzEAuFwgwGUHljo/RIyAN7+V5wVaZyOspxWjgd/t8lXBClxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=11FRVeA+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98F91C2BBFC;
	Tue, 30 Apr 2024 10:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714474267;
	bh=QaI2xzrK76gR8SrLT6tuFs09kukT1Ct0/s9THMClk4c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=11FRVeA+LZL+HXm19V5ln10uwZ2wUMsQRONpUl0wGktbnPu2M6aaVKe1UIRZV6lO3
	 V7mGUDwlBuPWKKCgvyhI9Ag6vUXe3L4Sq1hU1IsL4gtOeCpg8rogUv0qL7uaBhiPSw
	 XhvfD+E9I3/D/fc26zULbbqVV047CShMCufiIfiM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	MD Danish Anwar <danishanwar@ti.com>,
	Ravi Gunasekaran <r-gunasekaran@ti.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 107/228] net: phy: dp83869: Fix MII mode failure
Date: Tue, 30 Apr 2024 12:38:05 +0200
Message-ID: <20240430103106.883630635@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430103103.806426847@linuxfoundation.org>
References: <20240430103103.806426847@linuxfoundation.org>
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

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: MD Danish Anwar <danishanwar@ti.com>

[ Upstream commit 6c9cd59dbcb09a2122b5ce0dfc07c74e6fc00dc0 ]

The DP83869 driver sets the MII bit (needed for PHY to work in MII mode)
only if the op-mode is either DP83869_100M_MEDIA_CONVERT or
DP83869_RGMII_100_BASE.

Some drivers i.e. ICSSG support MII mode with op-mode as
DP83869_RGMII_COPPER_ETHERNET for which the MII bit is not set in dp83869
driver. As a result MII mode on ICSSG doesn't work and below log is seen.

TI DP83869 300b2400.mdio:0f: selected op-mode is not valid with MII mode
icssg-prueth icssg1-eth: couldn't connect to phy ethernet-phy@0
icssg-prueth icssg1-eth: can't phy connect port MII0

Fix this by setting MII bit for DP83869_RGMII_COPPER_ETHERNET op-mode as
well.

Fixes: 94e86ef1b801 ("net: phy: dp83869: support mii mode when rgmii strap cfg is used")
Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
Reviewed-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/dp83869.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/dp83869.c b/drivers/net/phy/dp83869.c
index fa8c6fdcf3018..d7aaefb5226b6 100644
--- a/drivers/net/phy/dp83869.c
+++ b/drivers/net/phy/dp83869.c
@@ -695,7 +695,8 @@ static int dp83869_configure_mode(struct phy_device *phydev,
 	phy_ctrl_val = dp83869->mode;
 	if (phydev->interface == PHY_INTERFACE_MODE_MII) {
 		if (dp83869->mode == DP83869_100M_MEDIA_CONVERT ||
-		    dp83869->mode == DP83869_RGMII_100_BASE) {
+		    dp83869->mode == DP83869_RGMII_100_BASE ||
+		    dp83869->mode == DP83869_RGMII_COPPER_ETHERNET) {
 			phy_ctrl_val |= DP83869_OP_MODE_MII;
 		} else {
 			phydev_err(phydev, "selected op-mode is not valid with MII mode\n");
-- 
2.43.0




