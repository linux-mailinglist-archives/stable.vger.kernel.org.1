Return-Path: <stable+bounces-83598-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F9A099B690
	for <lists+stable@lfdr.de>; Sat, 12 Oct 2024 20:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82D081F21D49
	for <lists+stable@lfdr.de>; Sat, 12 Oct 2024 18:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D0712C54D;
	Sat, 12 Oct 2024 18:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="R49lbYXW"
X-Original-To: stable@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7396C81AC6;
	Sat, 12 Oct 2024 18:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728756895; cv=none; b=Bqhx84HDvnUazgErltYzYKObs7tPCngt+lL8XMh1N4XVhZFJPIwryaLHnTALxQCgmlzJ5NvrWBh8vLHaHTucoNDjijz5HXxl9idAQUFayWvXZvctWDvbj9tte63wnrWOouOiifBVkxIIyHFTNL6i/1vkXeCXNgUOLhIuYGDoHFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728756895; c=relaxed/simple;
	bh=F43Ef2FxRFG2dCTICzYZwwxEWCgji1udsNDsdvVtJew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cKnHbPw5aJCyNQIEUZ9DLnCh5eU05D6R1dZmZb88CGyVPDIAYO0dy2O+vsaB0Vjon6jTECVNWYPb2tJestmoC1DRwRPPiHaTZQb9kUz529fe7WuJuTKcrS23CF53Es6IBG/XlV9G7RPAff9od3Qorswn0rzuBRyUS9NmvJdjihw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=R49lbYXW; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=RtgkYBkKn4YW6WOs02680DjsXE7fPjhLxXICoPrpxqw=; b=R49lbYXWwnbo9n/i4DeXA3tKMQ
	K6I0iJX7idZZv6xm1cu+oFSn86FjQDZLXRH6mJ9+9Li3PytyveNr0P81f6kIyHovjL0lXB00tIt6c
	tizGXNc4KOU9EtetST6KAp6CVwfLrSpDxXAt3K0l7fHz9TyIyM3n9N5VLYgFa6HJOOIM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1szgdX-009oQI-Rh; Sat, 12 Oct 2024 20:14:43 +0200
Date: Sat, 12 Oct 2024 20:14:43 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	stable@vger.kernel.org, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Subject: Re: [PATCH net v1 1] net: macb: Avoid 20s boot delay by skipping
 MDIO bus registration for fixed-link PHY
Message-ID: <379d10d5-468c-4d88-984e-df9ddc52f28e@lunn.ch>
References: <20241010105101.3128090-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010105101.3128090-1-o.rempel@pengutronix.de>

> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index f06babec04a0b..e4ee55bc53ba7 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -930,9 +930,6 @@ static int macb_mdiobus_register(struct macb *bp)
>  		return ret;
>  	}
> 
> -	if (of_phy_is_fixed_link(np))
> -		return mdiobus_register(bp->mii_bus);
> -
>  	/* Only create the PHY from the device tree if at least one PHY is
>  	 * described. Otherwise scan the entire MDIO bus. We do this to support
>  	 * old device tree that did not follow the best practices and did not
> @@ -953,8 +950,19 @@ static int macb_mdiobus_register(struct macb *bp)
> 
>  static int macb_mii_init(struct macb *bp)
>  {
> +	struct device_node *child, *np = bp->pdev->dev.of_node;
>  	int err = -ENXIO;
> 
> +	/* With fixed-link, we don't need to register the MDIO bus,
> +	 * except if we have a child named "mdio" in the device tree.
> +	 * In that case, some PHYs may be attached to the MACB's MDIO bus.

nitpick. It could be a switch on the MDIO bus, so "some devices may
be"

> +	 */
> +	child = of_get_child_by_name(np, "mdio");
> +	if (child)
> +		of_node_put(child);

The code now gets this node twice. You could add an optimisation patch
which passed child to macb_mdiobus_register().

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

