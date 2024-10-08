Return-Path: <stable+bounces-81746-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9816994924
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 14:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 534741F21B79
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 12:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1612E1DE3A2;
	Tue,  8 Oct 2024 12:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="igei3m+S"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E601D26F2;
	Tue,  8 Oct 2024 12:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728389994; cv=none; b=M83meJ6GkhBIEMACVFiFQ87FDscfWLbuq3nxT/k9Xayx6EK07uHzuxNI8NjMifJ6tCbzPDV7EWZnq/LDD/u+32LH6UNt9eOSmfYH3HrwaqFbEhRYOmTIyQinTt5DYF2BafgGsYaJRekk+ofGVInpo+WVJU1b/vqV2yt3PWqZLc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728389994; c=relaxed/simple;
	bh=rAAFVVoI0mUr4qS62z7cZZZgVqbh6vTWg3igY38gPqs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C8RJQo5fVQx/8busVg43dt0fPL4RzqU7bIW7tx9AGsobrqoJRcot1d11P15pt67c3257hfTn1ynX0Q4xJtbx7cqLMM5snJH5bBtuJpBmWPRG8T/NLMpsIcRbcgD9K/e2PbSw4NO5C53R1NkyqJMaoz5GuwJbtEOqJVN1kdiuzjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=igei3m+S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2BCAC4CEC7;
	Tue,  8 Oct 2024 12:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728389994;
	bh=rAAFVVoI0mUr4qS62z7cZZZgVqbh6vTWg3igY38gPqs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=igei3m+SaXAr0Wp+tRyR1M83qwXrWJ5x5fgMn4D2fubgxNqoPY8GgsYpbhjRsUkah
	 7OwoyodqS3yvh89xsiF29tGMlmZj8maglPtadKMxJq8mSQ8dS9KyNLOy6bt1fyXudR
	 P+5cGgAa1Nr4AJjI15x4QcixrZBFNlfCubE3nDU4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 127/482] net: phy: Check for read errors in SIOCGMIIREG
Date: Tue,  8 Oct 2024 14:03:10 +0200
Message-ID: <20241008115653.302928313@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241008115648.280954295@linuxfoundation.org>
References: <20241008115648.280954295@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

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




