Return-Path: <stable+bounces-190052-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4D7C0F9D5
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 18:23:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C8DA14E622A
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 17:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53874314A99;
	Mon, 27 Oct 2025 17:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="g4kE6Pw5"
X-Original-To: stable@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A852C11FA;
	Mon, 27 Oct 2025 17:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761585811; cv=none; b=WKlNotpsvPoBvNg5OZnQaCpRWZGnfk+EsIcCq5yJ+7x3c07iFw0mPIp6sJLoexKW66iuYIlriQ6/YfepaX18T4fTIUNqMTWYbvxOC9SVLd4y5O5K1h18UZetoyLLQzLwSiESDv9PSFbvHfDcB24YSJ7AyFAjtHZNnFFbVqjxC9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761585811; c=relaxed/simple;
	bh=W7yYiAve8BRludsH4H9uCvtACWd17oeeVi8WkBjanKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uPs1QAS2p4xSEJEZFpjl3wTQvFF9azE/ZiHS4A0sHA5QwBAT6kNL7d28wYymZtI53fVA7iYDNgrdObkcXkeapC+c187pjt+oi+F1g8ku5gBxfU/JZMjghLGhx1Tjt2npR7bOiJAl50Bzi5zbVV+f3IwTfYnpcxX9QNIrjPFIT84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=g4kE6Pw5; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=S+iucMdg9qjVFiWWp9rclLxcWQ4IxlakxagbG/6yZZw=; b=g4kE6Pw5jZjpq7ZZ56ASaZexrk
	xCIf6N1qjgzbn+P+7RibERhhizgCjTlfUH7wwHs/bWRGIIpjpi213uyYuzE4u43BqDlAzXTSIL7Mb
	6AcYxzGbvrPkKg30mAzOJjFvp9QVWVB9mSK2IZ/bqhOSDjEj0f/FoDjYgxDOcxr4fTJcVW8QQ59Hv
	XDSj1nrMRWPNLjtzkLceuWGNov1n6YbkUPeKN3nwYHq8+cM/4mZLJ6GnvtAE7NmeVlIPTv+uNzzq5
	93ldSxgS9LiapWYxGflYs+lz3AaREUaltZ9cLr+ja+7bxOO9HbQkpKS9EfsbhzXqpD8r1YP6gTOoe
	KXXQuu6w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:56672)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vDQwF-0000000029B-0P41;
	Mon, 27 Oct 2025 17:23:23 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vDQwD-000000005mD-1Pdj;
	Mon, 27 Oct 2025 17:23:21 +0000
Date: Mon, 27 Oct 2025 17:23:21 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Emanuele Ghidoli <ghidoliemanuele@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v1] net: phy: dp83867: Disable EEE support as not
 implemented
Message-ID: <aP-qiSsYzFDe-xlV@shell.armlinux.org.uk>
References: <20251023144857.529566-1-ghidoliemanuele@gmail.com>
 <ae723e7c-f876-45ef-bc41-3b39dc1dc76b@lunn.ch>
 <664ef58b-d7e6-4f08-b88f-e7c2cf08c83c@gmail.com>
 <aP-Hgo5mf7BQyee_@shell.armlinux.org.uk>
 <f65c1650-22c3-4363-8b7e-00d19bf7af88@gmail.com>
 <aP-hca4pDsDlEGUt@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aP-hca4pDsDlEGUt@shell.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Oct 27, 2025 at 04:44:33PM +0000, Russell King (Oracle) wrote:
> On Mon, Oct 27, 2025 at 04:34:54PM +0100, Emanuele Ghidoli wrote:
> > > So, this needs to be tested - please modify phylib's
> > > genphy_c45_read_eee_cap1() to print the value read from the register.
> > > 
> > > If it is 0xffff, that confirms that theory.
> > It’s not 0xffff; I verified that the value read is:
> > TI DP83867 stmmac-0:02: Reading EEE capabilities from MDIO_PCS_EEE_ABLE: 0x0006
> 
> Thanks for testing. So the published manual for this PHY is wrong.
> https://www.ti.com/lit/ds/symlink/dp83867ir.pdf page 64.
> 
> The comment I quoted from that page implies that the PCS and AN
> MMD registers shouldn't be implemented.
> 
> Given what we now know, I'd suggest TI PHYs are a mess. Stuff they
> say in the documentation that is ignored plainly isn't, and their
> PHYs report stuff as capable but their PHYs aren't capable.
> 
> I was suggesting to clear phydev->supported_eee, but that won't
> work if the MDIO_AN_EEE_ADV register is implemented even as far
> as exchanging EEE capabilities with the link partner. We use the
> supported_eee bitmap to know whether a register is implemented.
> Clearing ->supported_eee will mean we won't write to the advertisement
> register. That's risky. Given the brokenness so far, I wouldn't like
> to assume that the MDIO_AN_EEE_ADV register contains zero by default.
> 
> Calling phy_disable_eee() from .get_features() won't work, because
> after we call that method, of_set_phy_eee_broken() will then be
> called, which will clear phydev->eee_disabled_modes. I think that is
> a mistake. Is there any reason why we would want to clear the
> disabled modes? Isn't it already zero? (note that if OF_MDIO is
> disabled, or there's no DT node, we don't zero this.)
> 
> Your placement is the only possible location as the code currently
> stands, but I would like to suggest that of_set_phy_eee_broken()
> should _not_ be calling linkmode_zero(modes), and we should be able
> to set phydev->eee_disabled_modes in the .get_features() method.
> 
> Andrew, would you agree?

What I'm thinking of is an overall change such as (against net-next):

diff --git a/drivers/net/phy/dp83867.c b/drivers/net/phy/dp83867.c
index deeefb962566..f923f3a57b11 100644
--- a/drivers/net/phy/dp83867.c
+++ b/drivers/net/phy/dp83867.c
@@ -708,6 +708,21 @@ static int dp83867_probe(struct phy_device *phydev)
 	return dp83867_of_init(phydev);
 }
 
+static int dp83867_get_features(struct phy_device *phydev)
+{
+	int err = genphy_read_abilities(phydev);
+
+	/* TI Gigabit PHYs do not support EEE, even though they report support
+	 * in their "ignored" Clause 45 indirect registers, appear to implement
+	 * the advertisement registers and exchange the relevant AN page. Set
+	 * all EEE link modes as disabled, so we still write to the C45 EEE
+	 * advertisement register to ensure it is set to zero.
+	 */
+	linkmode_fill(phydev->eee_disabled_modes);
+
+	return err;
+}
+
 static int dp83867_config_init(struct phy_device *phydev)
 {
 	struct dp83867_private *dp83867 = phydev->priv;
@@ -1118,6 +1133,7 @@ static struct phy_driver dp83867_driver[] = {
 		/* PHY_GBIT_FEATURES */
 
 		.probe          = dp83867_probe,
+		.get_features	= dp83867_get_features,
 		.config_init	= dp83867_config_init,
 		.soft_reset	= dp83867_phy_reset,
 
diff --git a/drivers/net/phy/phy-core.c b/drivers/net/phy/phy-core.c
index 605ca20ae192..43ccbd3a09f8 100644
--- a/drivers/net/phy/phy-core.c
+++ b/drivers/net/phy/phy-core.c
@@ -207,8 +207,6 @@ void of_set_phy_eee_broken(struct phy_device *phydev)
 	if (!IS_ENABLED(CONFIG_OF_MDIO) || !node)
 		return;
 
-	linkmode_zero(modes);
-
 	if (of_property_read_bool(node, "eee-broken-100tx"))
 		linkmode_set_bit(ETHTOOL_LINK_MODE_100baseT_Full_BIT, modes);
 	if (of_property_read_bool(node, "eee-broken-1000t"))

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

