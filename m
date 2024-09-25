Return-Path: <stable+bounces-77405-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0AB985D07
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 14:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5D1BB2856B
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 12:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57641D5CD2;
	Wed, 25 Sep 2024 12:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n5i/waos"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20A01D5CCB;
	Wed, 25 Sep 2024 12:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727265652; cv=none; b=tu+CR3zUDvC+0GBrx5aeghndTb3isLNhRmQ+KG4+Ri+Uh0vXAFrCYyuzK11gfAARE7JGSNozkqJqYvnPjt+Yu31W4UHPPMur6QjdSj69JuverllCJsW69l7mQ90zlD1FPtb3tXBAe1vMTIHI+sP6TWYpBksbOCwNVSA+JeswqNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727265652; c=relaxed/simple;
	bh=C8mB3wjrG+2zjcbFXnCEKkxtBLMLigQxms7/qABLo38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m1lz1jMmJqU0ijbZJ2WBh267KflpKJo/IQQ/YfZ2tHoI8dmX7nuzLedaTCYxoQ2+jIjWB59qUp6iL4vZvGkCd3I7bx7IK/qKyeYrI1ceoE8Epwny7+lA6IK1+YzgFn25TiHONJnylaG2XXrjueAxDdEU/sAVRszu3t7LhPx9kbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n5i/waos; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA162C4CEC3;
	Wed, 25 Sep 2024 12:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727265652;
	bh=C8mB3wjrG+2zjcbFXnCEKkxtBLMLigQxms7/qABLo38=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n5i/waos1vIpAu7BPH9gQBObwEi3ts5b/f1k5Rr2POSC8zbqALJY4iw4CkL8X9dfX
	 RPFL3BtyRoov7pbUQIgP6Nt5Esslu2OKl7XRhkmudQbQ9KUsPO4l8AhJeiOcTlNqGj
	 c7xRblB13vVJ5OF2rMp7ccbmXwwm9M3EbalCxnevH7HY0JmbcsLwB5l9xD07eq+Z9b
	 6PszbzHGDexDnhWz/mV5GQwKsmOA1C36FI2PXNupIGTaxsHvT7kr3G4b6MYVSEG2fh
	 qnikl3CJpWNBLSaAfCiO0+zCAy0v1Y4j2nCxc7C5pAnN49zPPFcXlYHNWPHMl3tizs
	 0MLfz0wPUDWnw==
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
Subject: [PATCH AUTOSEL 6.10 060/197] net: phy: Check for read errors in SIOCGMIIREG
Date: Wed, 25 Sep 2024 07:51:19 -0400
Message-ID: <20240925115823.1303019-60-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925115823.1303019-1-sashal@kernel.org>
References: <20240925115823.1303019-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.11
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
index c4236564c1cd0..8495b111a524a 100644
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


