Return-Path: <stable+bounces-89903-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 818949BD33D
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 18:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF950B21659
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 17:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB071DD0D5;
	Tue,  5 Nov 2024 17:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hVId1WOn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850CC7DA6F;
	Tue,  5 Nov 2024 17:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730827223; cv=none; b=Y9FFZKFI4Hm/eG9wAvHT+algzqJaoPTEp1Jw+Ebh1zQmiKlKkMSWaOwl30018c+We/JiPyev0z6Ch30igZHOMCyD97U6UfKts/2BO8lqhWlh5H9roQzvRsLDp9UQxy/yb484qUQIJHZ/j8Xh6V6XjI3n1j9n1/rPQaSwh6Jji8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730827223; c=relaxed/simple;
	bh=4EphDwlB93fryLV684UsXTDR+tsiWXh3MZULEaeECgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O+lM7HztCca4Kx2hY+42PdeKAArmUVn8IIERZ44e0N95lefLpjKcsFI05i6a6fFAxb73lTqstLXz5zm05Jjyt6dlSamkDseox23inzHKTZPJtAaFiNOsuZsUpc5RanURnv8Wu7OfTL0pXt5jvRA6qSryxF2Ej+paqfGE1itLiGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hVId1WOn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AAE2C4CED3;
	Tue,  5 Nov 2024 17:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730827223;
	bh=4EphDwlB93fryLV684UsXTDR+tsiWXh3MZULEaeECgc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hVId1WOnPB4KLt2b8bD7Y0AfWtQ9cPwhKdeiN8Bnz6aVBuCCR9dM++u1pB/+F87FU
	 DQrHMeVX5Z9jrqqcz/RB5jPUoY5OPI5dysenSfSrZjfSYYesb7Zz1Z2aRwXgz6Z2b6
	 JFXCXVPLzLZ3y3ciRPDQvDu2c0H/h06j99w/tfBQPOqRB2N7wLNfF2BGD1pB26zdYG
	 Nlo+L0v0oOIOUS6wZ/Kyr1TeiBcV9WptVRuRgmhl0tH/kLGeQVgdPUwkQFu8IWbXUj
	 v7wppB+BtgW9kyHDvpbzgemLqcyhKBow8ckXLFjG8FxWRkbKih69uIcaYJYhO3UWA3
	 5txkaDCh2PVbg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1t8NE7-000000000E4-1s3b;
	Tue, 05 Nov 2024 18:20:23 +0100
Date: Tue, 5 Nov 2024 18:20:23 +0100
From: Johan Hovold <johan@kernel.org>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Felipe Balbi <balbi@ti.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Lee Jones <lee@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	stable@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
Subject: Re: [PATCH v4 4/6] phy: core: Fix an OF node refcount leakage in
 _of_phy_get()
Message-ID: <ZypT18RpHSd_Vb-o@hovoldconsulting.com>
References: <20241102-phy_core_fix-v4-0-4f06439f61b1@quicinc.com>
 <20241102-phy_core_fix-v4-4-4f06439f61b1@quicinc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241102-phy_core_fix-v4-4-4f06439f61b1@quicinc.com>

On Sat, Nov 02, 2024 at 11:53:46AM +0800, Zijun Hu wrote:
> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> _of_phy_get() will directly return when suffers of_device_is_compatible()
> error, but it forgets to decrease refcount of OF node @args.np before error
> return, the refcount was increased by previous of_parse_phandle_with_args()
> so causes the OF node's refcount leakage.
> 
> Fix by decreasing the refcount via of_node_put() before the error return.
> 
> Fixes: b7563e2796f8 ("phy: work around 'phys' references to usb-nop-xceiv devices")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
>  drivers/phy/phy-core.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
> index 52ca590a58b9..3127c5d9c637 100644
> --- a/drivers/phy/phy-core.c
> +++ b/drivers/phy/phy-core.c
> @@ -624,13 +624,15 @@ static struct phy *_of_phy_get(struct device_node *np, int index)
>  	struct of_phandle_args args;
>  
>  	ret = of_parse_phandle_with_args(np, "phys", "#phy-cells",
> -		index, &args);
> +					 index, &args);

This is an unrelated change which do not belong in this patch (and even
more so as it is a fix that is marked for backporting).

>  	if (ret)
>  		return ERR_PTR(-ENODEV);
>  
>  	/* This phy type handled by the usb-phy subsystem for now */
> -	if (of_device_is_compatible(args.np, "usb-nop-xceiv"))
> -		return ERR_PTR(-ENODEV);
> +	if (of_device_is_compatible(args.np, "usb-nop-xceiv")) {
> +		phy = ERR_PTR(-ENODEV);
> +		goto out_put_node;
> +	}
>  
>  	mutex_lock(&phy_provider_mutex);
>  	phy_provider = of_phy_provider_lookup(args.np);
> @@ -652,6 +654,7 @@ static struct phy *_of_phy_get(struct device_node *np, int index)
>  
>  out_unlock:
>  	mutex_unlock(&phy_provider_mutex);
> +out_put_node:
>  	of_node_put(args.np);
>  
>  	return phy;A

With the above fixed:

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>

