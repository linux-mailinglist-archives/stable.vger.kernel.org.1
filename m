Return-Path: <stable+bounces-80696-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E0D98FA16
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 00:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BF79284CA4
	for <lists+stable@lfdr.de>; Thu,  3 Oct 2024 22:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E071CF283;
	Thu,  3 Oct 2024 22:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="JEiWLYgs"
X-Original-To: stable@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3CD748D;
	Thu,  3 Oct 2024 22:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727995857; cv=none; b=OSYLQocEQpEyMg7adWskZAQVdj+0DnRVIZupZM7kUySQbpqnLfBFPG+ACb0aKa6c5lPg/8U/27+dXz2BFzNx1ZjL+nx4opNMSL8zCukQapvVZ/7NmhfXWzbXmxTGp/LzTeW36qXKsCmVSCFlEuXt41PXtG9AVrtytKlImKoSLPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727995857; c=relaxed/simple;
	bh=jeMAGHJ0dsiRHeik00FYjaL9SF93iaOygrdM/utcmyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RL/zvvW6xT9+Yp6Q2vdzKc+tf0VxmBo0CSyvxKcBR6FyGSTV3+hwP+HdS6bPh/VwRIGqs8cTMdKM1xdHYDPYemWaV23603OaBtFq8Bwj5efoVHkyg2SWIMLglXS3DKbRYrCu6rJvTzKzShvb7JEoe6xnsrhsS/lrQQss0tD4lGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=JEiWLYgs; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ho4Dkbnr7gS9ICt6dH3nWArm3KWyz3GKBaC/BZym6Do=; b=JEiWLYgs8jEFGcLkf5e2M21B81
	kGqvbysci0yVOL/ezcxZPqLcY/ZS+BIuJ+oQlvQ59CDkgkJvPa41eIEMBbpfiaoi+PSMWSv825rs3
	+VGhuZulkHPTZsRg7lrbe9SNO6Rla2UtZzCY386SOqXWd5EQyA4EAw0ktVWTyjQhK9YA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1swUed-008zOF-MS; Fri, 04 Oct 2024 00:50:39 +0200
Date: Fri, 4 Oct 2024 00:50:39 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Daniel Golle <daniel@makrotopia.org>,
	stable@vger.kernel.org
Subject: Re: [net PATCH 2/2] net: phy: Skip PHY LEDs OF registration for
 Generic PHY driver
Message-ID: <2dcd127d-ab41-4bf7-aea4-91f175443e62@lunn.ch>
References: <20241003221006.4568-1-ansuelsmth@gmail.com>
 <20241003221006.4568-2-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241003221006.4568-2-ansuelsmth@gmail.com>

On Fri, Oct 04, 2024 at 12:10:05AM +0200, Christian Marangi wrote:
> It might happen that a PHY driver fails to probe or is not present in
> the system as it's a kmod. In such case the Device Tree might have LED
> entry but the Generic PHY is probed instead.
> 
> In this scenario, PHY LEDs OF registration should be skipped as
> controlling the PHY LEDs is not possible.
> 
> Tested-by: Daniel Golle <daniel@makrotopia.org>
> Cc: stable@vger.kernel.org
> Fixes: 01e5b728e9e4 ("net: phy: Add a binding for PHY LEDs")
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  drivers/net/phy/phy_device.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index 499797646580..af088bf00bae 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c
> @@ -3411,6 +3411,11 @@ static int of_phy_leds(struct phy_device *phydev)
>  	struct device_node *leds;
>  	int err;
>  
> +	/* Skip LED registration if we are Generic PHY */
> +	if (phy_driver_is_genphy(phydev) ||
> +	    phy_driver_is_genphy_10g(phydev))
> +		return 0;

Why fix it link this, when what you propose for net-next, that the drv
ops must also exist, would fix it.

I don't see any need to special case genphy.

	Andrew

