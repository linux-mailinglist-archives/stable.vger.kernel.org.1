Return-Path: <stable+bounces-190008-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D0AC0EBB1
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 16:00:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 61BE9501233
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 14:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 255152C08B2;
	Mon, 27 Oct 2025 14:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="tJ0SRt4c"
X-Original-To: stable@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD062BE7D9;
	Mon, 27 Oct 2025 14:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761576851; cv=none; b=gOyjARc62HpDGQ4vioOivmQyZEHyxomvY3UO3Ovu9w95ortYYkJ9JUXx7i/98F4BWYOrK/urAOueicwy4wcU8ChmX1CrzFaIp7mZxcHiP6btDIjru8xppda6O1xgJETlSzGuoFJ8cPJmtFpldX40yTyXP9RJWsspZ+2P70Zxizs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761576851; c=relaxed/simple;
	bh=CFtQi3W9Wpk2UNpC+QN9fl+vSK7ews1i8/9jkHGSpzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KYwIGAau25T0z/0dmV4KR7pUr7jEQNpcf+eua6EsYp3cmvUIjxvbsUN6+EFTfaRAY30zpZ95AmkywUa8AqrcUFNVXg3+GRE7MXl2iXbPkoHhdPiHY83q8+EU5fnEoBsp4T9UIq4iiKkypQx50caCC8/9p0vXG8YRJ4SPcZwCyr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=tJ0SRt4c; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=+XaUSZ8sj54yy88kQ5J30N+g5e/B7bSDezU+OegbPWg=; b=tJ0SRt4cUCdS3oGEtUqJKkwtBh
	MsWPtmpoTWBye7Mg1WN0TjHe/VIteu/SoGWC3Q3LGPapW2NBMOqQMWWk7oXuqQN8E1HoTdQUBZYPO
	lfYbuQVEc5cuz4bUjRkoSB2n0mY2GHvBpJ2ei3Q7TzDxYahSgbo9muPYQDnv0Y5KLu7PCpf7GOm7i
	eY9fNIpv8nZ1pZRuLoCVR1iIif0cxfKkQ+YAsxyPOVpL43P/H35nQQ1NGxEKUMC0VNvFZW3JRq5UD
	57ueCS/a3TlC9SmhZUwVfH5Nia8iZkQbeUWC4HqLF4wpwPESPCHk5/jLQ5ToLvpRqj9CY6Gn0zSZA
	hHJ3DRiw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:36070)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vDObd-000000001z1-2VoR;
	Mon, 27 Oct 2025 14:53:57 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vDObb-000000005fo-03LC;
	Mon, 27 Oct 2025 14:53:55 +0000
Date: Mon, 27 Oct 2025 14:53:54 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v1] net: phy: dp83867: Disable EEE support as not
 implemented
Message-ID: <aP-Hgo5mf7BQyee_@shell.armlinux.org.uk>
References: <20251023144857.529566-1-ghidoliemanuele@gmail.com>
 <ae723e7c-f876-45ef-bc41-3b39dc1dc76b@lunn.ch>
 <664ef58b-d7e6-4f08-b88f-e7c2cf08c83c@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <664ef58b-d7e6-4f08-b88f-e7c2cf08c83c@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Oct 27, 2025 at 01:57:48PM +0100, Emanuele Ghidoli wrote:
> 
> 
> On 27/10/2025 00:45, Andrew Lunn wrote:
> >> Since the introduction of phylink-managed EEE support in the stmmac driver,
> >> EEE is now enabled by default, leading to issues on systems using the
> >> DP83867 PHY.
> > 
> > Did you do a bisect to prove this?
> Yes, I have done a bisect and the commit that introduced the behavior on our
> board is 4218647d4556 ("net: stmmac: convert to phylink managed EEE support").
> 
> > 
> >> Fixes: 2a10154abcb7 ("net: phy: dp83867: Add TI dp83867 phy")
> > 
> > What has this Fixes: tag got to do with phylink?
> I think that the phylink commit is just enabling by default the EEE support,
> and my commit is not really fixing that. It is why I didn't put a Fixes: tag
> pointing to that.
> 
> I’ve tried to trace the behavior, but it’s quite complex. From my testing, I
> can summarize the situation as follows:
> 
> - ethtool, after that patch, returns:
> ethtool --show-eee end0
> EEE settings for end0:
>         EEE status: enabled - active
>         Tx LPI: 1000000 (us)
>         Supported EEE link modes:  100baseT/Full
>                                    1000baseT/Full
>         Advertised EEE link modes:  100baseT/Full
>                                     1000baseT/Full
>         Link partner advertised EEE link modes:  100baseT/Full
>                                                  1000baseT/Full
> - before that patch returns, after boot:
> EEE settings for end0:
>         EEE status: disabled
>         Tx LPI: disabled
>         Supported EEE link modes:  100baseT/Full
>                                    1000baseT/Full
>         Advertised EEE link modes:  Not reported
>         Link partner advertised EEE link modes:  100baseT/Full
>                                                  1000baseT/Full

Oh damn. I see why now:

        /* Some DT bindings do not set-up the PHY handle. Let's try to
         * manually parse it
         */
        if (!phy_fwnode || IS_ERR(phy_fwnode)) {
                int addr = priv->plat->phy_addr;
		...
                if (priv->dma_cap.eee)
                        phy_support_eee(phydev);

                ret = phylink_connect_phy(priv->phylink, phydev);
        } else {
                fwnode_handle_put(phy_fwnode);
                ret = phylink_fwnode_phy_connect(priv->phylink, fwnode, 0);
        }

The driver only considers calling phy_support_eee() when DT fails to
describe the PHY (because in the other path, it doesn't have access to
the struct phy_device to make this call.)

My commit makes it apply even to DT described PHYs, so now (as has been
shown when you enable EEE manually) it's uncovering latent problems.

So now we understand why the change has occurred - this is important.
Now the question becomes, what to do about it.

For your issue, given that we have statements from TI that indicate
none of their gigabit PHYs support EEE, we really should not be
reporting to userspace that there is any EEE support. Therefore,
"Supported EEE link modes" should be completely empty.

I think I understand why we're getting EEE modes supported. In the
DP83867 manual, it states for the DEVAD field of the C45 indirect
access registers:

"Device Address: In general, these bits [4:0] are the device address
DEVAD that directs any accesses of ADDAR register (0x000E) to the
appropriate MMD. Specifically, the DP83867 uses the vendor specific
DEVAD [4:0] = 11111 for accesses. All accesses through registers
REGCR and ADDAR can use this DEVAD. Transactions with other
DEVAD are ignored."

Specifically, that last sentence, and the use of "ignored". If this
means the PHY does not drive the MDIO data line when registers are
read, they will return 0xffff, which is actually against the IEEE
requirements for C45 registers (unimplemented C45 registers are
supposed to be zero.)

So, this needs to be tested - please modify phylib's
genphy_c45_read_eee_cap1() to print the value read from the register.

If it is 0xffff, that confirms that theory.

The correct solution here, to stop other MAC drivers running into this
is for TI PHY drivers to implement the .get_features() phylib method,
call genphy_read_abilities() or genphy_c45_pma_read_abilities() as
appropriate, and then clear phydev->supported_eee so the PHY driver
reports (correctly according to TI's statements) that EEE modes are not
supported.

So, while my commit does have an unintended change of behaviour (thanks
for helping to locate that), it would appear that it has revealed a
latent bug in likely all TI PHY gigabit drivers that needs fixing
independently of what we do about this.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

