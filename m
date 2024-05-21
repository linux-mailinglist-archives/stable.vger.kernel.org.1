Return-Path: <stable+bounces-45515-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF218CAFA4
	for <lists+stable@lfdr.de>; Tue, 21 May 2024 15:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CCC81C21591
	for <lists+stable@lfdr.de>; Tue, 21 May 2024 13:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 979FE768EE;
	Tue, 21 May 2024 13:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RdnWDP7a"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8C055783;
	Tue, 21 May 2024 13:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716299265; cv=none; b=PDoljsqvqX+n3LrNxUmiiTaVaW0TjtoPorr8zQICNkHeWjmGp5Una96MX6l4u/g6EhTljrHRr9WxYcKDMoZulNzSx1/TEpgdXyL7ChtfakafPD862DCQX98ynEjCTyR3xDLRkCfe1qIKLKoGedmwnW5SlGI19N9BLaeNEgV74CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716299265; c=relaxed/simple;
	bh=Rs0778QKzKCdk0BVA98zOTHQl+mRFeefvwXEHJ/1we8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IByw8ck5vaj1XHI2O2ap/sJNIdV21FiO9lHDyTBb4x8Q+KWkSMT8wTSb2LhzealfEULxF8v0VqnPVYvkqzjxbbYixCmvw8Amvwxz0ezX1JkZEgwAU0u/WXNEsBeG4chMc6fK6iwi2Ri4/cwodsu2HYLeQQs+uKpTPJ+3iMR77B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RdnWDP7a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEC6CC2BD11;
	Tue, 21 May 2024 13:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716299264;
	bh=Rs0778QKzKCdk0BVA98zOTHQl+mRFeefvwXEHJ/1we8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RdnWDP7adAioYkB3/+Il09h51NgpF8SMAVZyOlo4p1vHsDU8W/MmkscYN3ZaqPUvh
	 LJJyfhttBT1gQbWzZA65iJeGWv8wz+cfco9WKnizzAj4wSwPNVeM6kXOtfvJ4VxIC/
	 dKTVtxVgFa0pORmupAShSMqwC9XPkDPG0YVZBHckGuCWfwRbis10RHmhNEm6ZftgNK
	 GZp1T6A/upBmVnSxgjJoNZU+xemHpmENftx9Etor5hVqexWIToaxjbOpVh+eYiI2Mm
	 fFfbLAACqP4MQk/LeEay0vniuHCpwirjQeLw/3fxCUglIuP+4KEpcYTmG6SEWS1+Es
	 O1BAaRNoj3u9A==
Date: Tue, 21 May 2024 14:47:39 +0100
From: Simon Horman <horms@kernel.org>
To: Romain Gantois <romain.gantois@bootlin.com>
Cc: MD Danish Anwar <danishanwar@ti.com>, Roger Quadros <rogerq@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>, Diogo Ivo <diogo.ivo@siemens.com>,
	Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH net] net: ti: icssg_prueth: Fix NULL pointer dereference
 in prueth_probe()
Message-ID: <20240521134739.GE764145@kernel.org>
References: <20240521-icssg-prueth-fix-v1-1-b4b17b1433e9@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240521-icssg-prueth-fix-v1-1-b4b17b1433e9@bootlin.com>

+ Andrew Lunn, Diogo Ivo, Vignesh Raghavendra
  Not trimming reply to provide context for these people

On Tue, May 21, 2024 at 02:44:11PM +0200, Romain Gantois wrote:
> In the prueth_probe() function, if one of the calls to emac_phy_connect()
> fails due to of_phy_connect() returning NULL, then the subsequent call to
> phy_attached_info() will dereference a NULL pointer.
> 
> Check the return code of emac_phy_connect and fail cleanly if there is an
> error.
> 
> Fixes: 128d5874c082 ("net: ti: icssg-prueth: Add ICSSG ethernet driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>

For Networking patches, please consider seeding the CC
list using ./scripts/get_maintainer.pl this.patch.
I've added the people who seemed to be missing.

The patch itself looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

> ---
> Hello everyone,
> 
> There is a possible NULL pointer dereference in the prueth_probe() function of
> the icssg_prueth driver. I discovered this while testing a platform with one
> PRUETH MAC enabled out of the two available.
> 
> These are the requirements to reproduce the bug:
> 
> prueth_probe() is called
> either eth0_node or eth1_node is not NULL
> in emac_phy_connect: of_phy_connect() returns NULL
> 
> Then, the following leads to the NULL pointer dereference:
> 
> prueth->emac[PRUETH_MAC0]->ndev->phydev is set to NULL
> prueth->emac[PRUETH_MAC0]->ndev->phydev is passed to phy_attached_info()
> -> phy_attached_print() dereferences phydev which is NULL
> 
> This series provides a fix by checking the return code of emac_phy_connect().
> 
> Best Regards,
> 
> Romain
> ---
>  drivers/net/ethernet/ti/icssg/icssg_prueth.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> index 7c9e9518f555a..1ea3fbd5e954e 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> @@ -1039,7 +1039,12 @@ static int prueth_probe(struct platform_device *pdev)
>  
>  		prueth->registered_netdevs[PRUETH_MAC0] = prueth->emac[PRUETH_MAC0]->ndev;
>  
> -		emac_phy_connect(prueth->emac[PRUETH_MAC0]);
> +		ret = emac_phy_connect(prueth->emac[PRUETH_MAC0]);
> +		if (ret) {
> +			dev_err(dev,
> +				"can't connect to MII0 PHY, error -%d", ret);
> +			goto netdev_unregister;
> +		}
>  		phy_attached_info(prueth->emac[PRUETH_MAC0]->ndev->phydev);
>  	}
>  
> @@ -1051,7 +1056,12 @@ static int prueth_probe(struct platform_device *pdev)
>  		}
>  
>  		prueth->registered_netdevs[PRUETH_MAC1] = prueth->emac[PRUETH_MAC1]->ndev;
> -		emac_phy_connect(prueth->emac[PRUETH_MAC1]);
> +		ret = emac_phy_connect(prueth->emac[PRUETH_MAC1]);
> +		if (ret) {
> +			dev_err(dev,
> +				"can't connect to MII1 PHY, error %d", ret);
> +			goto netdev_unregister;
> +		}
>  		phy_attached_info(prueth->emac[PRUETH_MAC1]->ndev->phydev);
>  	}
>  
> 
> ---
> base-commit: e4a87abf588536d1cdfb128595e6e680af5cf3ed
> change-id: 20240521-icssg-prueth-fix-03b03064c5ce
> 
> Best regards,
> -- 
> Romain Gantois <romain.gantois@bootlin.com>
> 
> 

