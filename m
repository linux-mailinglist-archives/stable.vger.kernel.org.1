Return-Path: <stable+bounces-189268-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E07C08DF8
	for <lists+stable@lfdr.de>; Sat, 25 Oct 2025 10:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B4CA1C27C4C
	for <lists+stable@lfdr.de>; Sat, 25 Oct 2025 08:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C58F28D82A;
	Sat, 25 Oct 2025 08:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="O//m52DE"
X-Original-To: stable@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB1A23AE9B;
	Sat, 25 Oct 2025 08:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761381881; cv=none; b=lvJBzGUjvmj2YZtuNjddd2vw6C0Pd+4PcUTFw86TUl3WD8aE/lvGC2ILFZoz3k3sfIJE7LurLIlCBAilD5UVig8sliX8P4sZp8Sj1gSB9X0jJ2a9l3/3g0Be5S4SlXJyViq++QWzaivHllO7PJ5NQm7ysabbXqctmYx6UfqFWZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761381881; c=relaxed/simple;
	bh=hg8W4EJP+POIDRg8RMaQL/+Ab8rHz5hHJNZwuQ/qqeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XMb4F1JyJEmr/hNF3DekXxU2pUJImRi0swF56dzudNX7RYyI20y3yzxY4HzeEFo/R8tyGX4HsuMmKpqHALTzIb7rvvTgH6vEukABBaE4prsEs5zX6bBK2KrIoan2z0R1WOE6knZf7fIuwYnRAvsXAwbJbzZF+hLZ2N1b0THSKQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=O//m52DE; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=sv53rsHLrJUFbnFVUbU9tXd6yZ3Hn0xkNMD9PLF8YI8=; b=O//m52DEWsSMKWfceMJzTo7StD
	7Z0No+Acy4QNRAvjD2uGwvC9eXafo97kYmVn9sQKPL5acBfwBHyvrYR0yID379bk6MkxKXnufnClZ
	vxQRpGAV25Z+lxnJ7X/3QrGGqJEMV620m5y06lZQzcVepXBiMtNYPyNLR9VqpdOyXUdoSl4fXsbUK
	+6cKs9MNbgRi6whlJq+r8ziB8ytKCDUpERVzDcdVsZeNhsIJk2iPZEsuzfKcKRatfwd5Uw7Q7hw3w
	x/h4hrIRsq6Lo5EmiLI93/FNqEmHo3OcSZQRelfJtYv7yPkCH6mnFqx4WRnzUI1vpJijap+cz+y3z
	2uOcKpQw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44358)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vCZt3-000000008Q7-29RK;
	Sat, 25 Oct 2025 09:44:33 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vCZt1-000000003Xn-28FH;
	Sat, 25 Oct 2025 09:44:31 +0100
Date: Sat, 25 Oct 2025 09:44:31 +0100
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
Message-ID: <aPyN7z8Vk4EiS20b@shell.armlinux.org.uk>
References: <20251023144857.529566-1-ghidoliemanuele@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023144857.529566-1-ghidoliemanuele@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Oct 23, 2025 at 04:48:53PM +0200, Emanuele Ghidoli wrote:
> While the DP83867 PHYs report EEE capability through their feature
> registers, the actual hardware does not support EEE (see Links).
> When the connected MAC enables EEE, it causes link instability and
> communication failures.
> 
> The issue is reproducible with a iMX8MP and relevant stmmac ethernet port.
> Since the introduction of phylink-managed EEE support in the stmmac driver,
> EEE is now enabled by default, leading to issues on systems using the
> DP83867 PHY.

Wasn't it enabled before? See commit 4218647d4556 ("net: stmmac:
convert to phylink managed EEE support").

stmmac's mac_link_up() was:

-       if (phy && priv->dma_cap.eee) {
-               phy_eee_rx_clock_stop(phy, !(priv->plat->flags &
-                                            STMMAC_FLAG_RX_CLK_RUNS_IN_LPI));
-               priv->tx_lpi_timer = phy->eee_cfg.tx_lpi_timer;
-               stmmac_eee_init(priv, phy->enable_tx_lpi);
                stmmac_set_eee_pls(priv, priv->hw, true);
-       }

So, if EEE is enabled in the core synthesis, then EEE will be
configured depending on what phylib says.

In stmmac_init_phy(), there was this:

-               if (priv->dma_cap.eee)
-                       phy_support_eee(phydev);
-
                ret = phylink_connect_phy(priv->phylink, phydev);

So phylib was told to enable EEE support on the PHY if the dwmac
core supports EEE.

So, from what I can see, converting to phylink managed EEE didn't
change this. So what really did change?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

