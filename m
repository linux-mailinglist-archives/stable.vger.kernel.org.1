Return-Path: <stable+bounces-164645-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FDF4B10FEE
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 18:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 309CA189363A
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 16:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DABC52EA476;
	Thu, 24 Jul 2025 16:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="IC+in0sx"
X-Original-To: stable@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0851885AB;
	Thu, 24 Jul 2025 16:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753375937; cv=none; b=IzvOIMFjMekUKh98UKHr7V58j7Px1WeYaNTJT7rUlj2Lmx8VgFotMvaadEGHxESmD5Ot6Fzy7e+Svykdw9YapqubqWBChkVhPLzbHf6FYI0cn4tacRfWIpKODuOUCFdYeMhZcMvaBH6s5oCzOHPb/kEmRrSrg0COdejsDPoS5Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753375937; c=relaxed/simple;
	bh=tFNUcls/ACieVxAMjd/u79UbJBIfsHpFAKeS4sD7ozU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C0NLVHR8cxbHqbvnRLWpsUHJkIcMuqVpn4Jo6vwxgLnjpIDi6miEfxi8XmTsASaRrYax/pvJtkDX7JwDGeaiCdrSuJlJkzlnKE/ypapupkG5//R082WZXmmVyq6grz7tiqM8KHt+qNH9oLypZ/mPE+/zqELa2Lkx9h5RNcpwksM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=IC+in0sx; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=cpoYxDZTbBdRV4hzabqDonIa6m7T4w9CFRBSDIFBvPA=; b=IC+in0sxB6ZOprZlgRuuB8AjEl
	x4EWIC8wdpUI687JJh1g/B2bF2ef1zgE0LS0H1AG+prdPjZqag5LKojUcRWU18t0+ZSpSlGV+QDbH
	7VCjb712oY/sax646Em2AanynPrTQt93Xe7dwV9MJjD9vaHciELIJuHVtpE7CPnLWQ8bYyr8a/g5F
	ziVx8AkdXTSruBbVxGpGvXutW0bN8g/94K9DCxzWiqSwWm1IloKshfxL/gTo8qtBcsnJJExESPWyE
	n5exkFKQ63R0ouoUuNSSTj2xLJVQsGpfVeKxowaKBAHH3ZyWK2U6N5WNaWwtqSQL7WPLKdZ3WXccN
	ZDZrlsuw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:47076)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uezAo-0003Xc-2s;
	Thu, 24 Jul 2025 17:52:03 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uezAk-0000t2-2x;
	Thu, 24 Jul 2025 17:51:58 +0100
Date: Thu, 24 Jul 2025 17:51:58 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Detlev Casanova <detlev.casanova@collabora.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel@collabora.com, stable@vger.kernel.org
Subject: Re: [PATCH net v2] net: phy: realtek: Reset after clock enable
Message-ID: <aIJkrh9_4o6flHPE@shell.armlinux.org.uk>
References: <20250724-phy-realtek-clock-fix-v2-1-ae53e341afb7@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250724-phy-realtek-clock-fix-v2-1-ae53e341afb7@kernel.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Jul 24, 2025 at 04:39:42PM +0200, Sebastian Reichel wrote:
> On Radxa ROCK 4D boards we are seeing some issues with PHY detection and
> stability (e.g. link loss or not capable of transceiving packages) after
> new board revisions switched from a dedicated crystal to providing the
> 25 MHz PHY input clock from the SoC instead.
> 
> This board is using a RTL8211F PHY, which is connected to an always-on
> regulator. Unfortunately the datasheet does not explicitly mention the
> power-up sequence regarding the clock, but it seems to assume that the
> clock is always-on (i.e. dedicated crystal).
> 
> By doing an explicit reset after enabling the clock, the issue on the
> boards could no longer be observed.
> 
> Note, that the RK3576 SoC used by the ROCK 4D board does not yet
> support system level PM, so the resume path has not been tested.
> 
> Cc: stable@vger.kernel.org
> Fixes: 7300c9b574cc ("net: phy: realtek: Add optional external PHY clock")
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
> Changes in v2:
> - Switch to PHY_RST_AFTER_CLK_EN + phy_reset_after_clk_enable(); the
>   API is so far only used by the freescale/NXP MAC driver and does
>   not seem to be written for usage from within the PHY driver, but
>   I also don't see a good reason not to use it.
> - Also reset after re-enabling the clock in rtl821x_resume()
> - Link to v1: https://lore.kernel.org/r/20250704-phy-realtek-clock-fix-v1-1-63b33d204537@kernel.org
> ---
>  drivers/net/phy/realtek/realtek_main.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
> index c3dcb62574303374666b46a454cd4e10de455d24..cf128af0ec0c778262d70d6dc4524d06cbfccf1f 100644
> --- a/drivers/net/phy/realtek/realtek_main.c
> +++ b/drivers/net/phy/realtek/realtek_main.c
> @@ -230,6 +230,7 @@ static int rtl821x_probe(struct phy_device *phydev)
>  	if (IS_ERR(priv->clk))
>  		return dev_err_probe(dev, PTR_ERR(priv->clk),
>  				     "failed to get phy clock\n");
> +	phy_reset_after_clk_enable(phydev);

Should this depend on priv->clk existing?

>  
>  	ret = phy_read_paged(phydev, RTL8211F_PHYCR_PAGE, RTL8211F_PHYCR1);
>  	if (ret < 0)
> @@ -627,8 +628,10 @@ static int rtl821x_resume(struct phy_device *phydev)
>  	struct rtl821x_priv *priv = phydev->priv;
>  	int ret;
>  
> -	if (!phydev->wol_enabled)
> +	if (!phydev->wol_enabled) {
>  		clk_prepare_enable(priv->clk);
> +		phy_reset_after_clk_enable(phydev);

Should this depend on priv->clk existing?

I'm thinking about platforms such as Jetson Xavier NX, which I
believe uses a crystal, and doesn't appear to suffer from any
problems.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

