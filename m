Return-Path: <stable+bounces-77173-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FCAB98599F
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BFCE1C20936
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 11:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C6E1A76BE;
	Wed, 25 Sep 2024 11:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c4493yRP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545661A726A;
	Wed, 25 Sep 2024 11:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264381; cv=none; b=AbXlf+9pJb+CMU/7uiYEjrdp9hbldw9M9F5JhFP5Mn7NbqYg8btVYwJqqXlh61tcMWOtw8U3uPNJzW+8peAF6BwNshpbx/XPkYY1YrLfp0QakuzfQtPapjVowJwWWPXBa4YsxuUD7TFyWlFCHavxm4f6B4vhSqvF9r8I53zJ2Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264381; c=relaxed/simple;
	bh=Pb6ZUZpF21AKLI5dPOYrEq51md+n1GRLbVMHVy5aPYo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mnpKsV7EvXM11610/NL/cRgGnPIlzcUcFt7FJWUUBPeFLHbB6DCm2Uw0X58t1oPceYgdZSZD5eWQj6EJFk9I8zt+ukSM70gDyIlPYqyCD7V0AXwMguMjBf9PYsGDFNn1dbw1ewUF3Ma67bivfQAixjY7nMa17giYHWNljcKT3Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c4493yRP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32CBDC4CEC7;
	Wed, 25 Sep 2024 11:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727264380;
	bh=Pb6ZUZpF21AKLI5dPOYrEq51md+n1GRLbVMHVy5aPYo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c4493yRPnBu6MpJuDV6WEHxQYSCHQ5rPmR6+mAdAopGYjLJEpR8ZLTSkXOxM7xtFz
	 bHwnSA05TwkyOxHFe1N1MKC7/ZgmtDpKGDuOlXg1eHg9BW2/VOJc5FmY8n2mOpFOWz
	 l2tB8BelBmXfj8cIRxVNMSPdRHqA8JOWTAtdmxmLIKYtzh210vIxfkuAbROPsfOZQJ
	 cPTqu9jIjA3CJZhY88xaj8PHS3N4zQHfGFO3515Ln4YYOIwG4GMyFD0JRsT7n1R86i
	 zC1Le42d0klVIp4Cv+/jzpC6r8j3lrU1vVLgKuGXTS/wfDyL+IgaVdl+xKw7Jw5d95
	 IUd3OPy4+s+sA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	hkallweit1@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 075/244] net: phy: Check for read errors in SIOCGMIIREG
Date: Wed, 25 Sep 2024 07:24:56 -0400
Message-ID: <20240925113641.1297102-75-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925113641.1297102-1-sashal@kernel.org>
References: <20240925113641.1297102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11
Content-Transfer-Encoding: 8bit

From: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

[ Upstream commit 569bf6d481b0b823c3c9c3b8be77908fd7caf66b ]

When reading registers from the PHY using the SIOCGMIIREG IOCTL any
errors returned from either mdiobus_read() or mdiobus_c45_read() are
ignored, and parts of the returned error is passed as the register value
back to user-space.

For example, if mdiobus_c45_read() is used with a bus that do not
implement the read_c45() callback -EOPNOTSUPP is returned. This is
however directly stored in mii_data->val_out and returned as the
registers content. As val_out is a u16 the error code is truncated and
returned as a plausible register value.

Fix this by first checking the return value for errors before returning
it as the register content.

Before this patch,

    # phytool read eth0/0:1/0
    0xffa1

After this change,

    $ phytool read eth0/0:1/0
    error: phy_read (-95)

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Tested-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20240903171536.628930-1-niklas.soderlund+renesas@ragnatech.se
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/phy.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index 785182fa5fe01..b88d857ea23b8 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -342,14 +342,19 @@ int phy_mii_ioctl(struct phy_device *phydev, struct ifreq *ifr, int cmd)
 		if (mdio_phy_id_is_c45(mii_data->phy_id)) {
 			prtad = mdio_phy_id_prtad(mii_data->phy_id);
 			devad = mdio_phy_id_devad(mii_data->phy_id);
-			mii_data->val_out = mdiobus_c45_read(
-				phydev->mdio.bus, prtad, devad,
-				mii_data->reg_num);
+			ret = mdiobus_c45_read(phydev->mdio.bus, prtad, devad,
+					       mii_data->reg_num);
+
 		} else {
-			mii_data->val_out = mdiobus_read(
-				phydev->mdio.bus, mii_data->phy_id,
-				mii_data->reg_num);
+			ret = mdiobus_read(phydev->mdio.bus, mii_data->phy_id,
+					   mii_data->reg_num);
 		}
+
+		if (ret < 0)
+			return ret;
+
+		mii_data->val_out = ret;
+
 		return 0;
 
 	case SIOCSMIIREG:
-- 
2.43.0


