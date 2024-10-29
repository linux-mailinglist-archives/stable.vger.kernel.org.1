Return-Path: <stable+bounces-89206-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC7EC9B4B2B
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 14:47:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A881283D21
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 13:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C442C206056;
	Tue, 29 Oct 2024 13:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bJkp2CJY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FAB91E480;
	Tue, 29 Oct 2024 13:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730209632; cv=none; b=djmfAiGINlgi6b7+q4eTNFIdgCczymRUajI/k+bB1ZA2rJpClSmM8POm6LpOQ3+6q3pjkvQRWT9MsGgRubwjGQnfFJ3PN7P2h+VOUbTNB+GU4qA6vaJG/Y/DQqIdrmLiZpao0/SygmE9qgt88dwMIkUThDOWQsfyhUMRJX4hJDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730209632; c=relaxed/simple;
	bh=KEQem3GuAcK/dyUVeI9paTDkYNzz2c637THBwlYhUd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QyGSuk/Pyfd6bg4O7AObDbTbcXHhzU6fAz0GyU/GXn3rbHLkOaKQPLyOq9xrxeYYczmCtfKJUsm1rlpM1SHwAFHj2meztnXMUvTtTW4yiIBJz0Vk0CxyEXl+PJKsMEIsHK16BqWme86jzSo30Aa3WUYQBGJFvw5QfhrAz3CL9B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bJkp2CJY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11E1EC4CECD;
	Tue, 29 Oct 2024 13:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730209632;
	bh=KEQem3GuAcK/dyUVeI9paTDkYNzz2c637THBwlYhUd8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bJkp2CJYS4BqKoZSVbPb8U9xdsDI5BZ0ocj+JkurZSYlkp9bbpzg0xL02GrK/3QuP
	 1jatkq9w62FKp/NAECrxdp1olj8GcYLaQqincZ86b/wDa3/kbqqFTsCJo90e4Mmab3
	 SYsQf7apzYVGzIW8TtkXjYI8gIsHbGZcf7pKW/OkHSLwyLjlyibQ0yPoB8ZcM9ubdc
	 GU5KkUKxKqXR7VOpkuHCD/7xrDKLwwwqusMrTKqXVgC9SLiDQXpMSVtcKRphycLAr7
	 T6HijRH5UfsLYVq0UKuWKFSntaxmxZ+uxnn251AW222Dutzrh+QQSGX4BMCkZtL3Bz
	 pkdGEmjRamRIg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1t5mZH-0000000034N-2ieg;
	Tue, 29 Oct 2024 14:47:31 +0100
Date: Tue, 29 Oct 2024 14:47:31 +0100
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
Subject: Re: [PATCH v2 4/6] phy: core: Fix an OF node refcount leakage in
 _of_phy_get()
Message-ID: <ZyDnc7HpMTnwEs-2@hovoldconsulting.com>
References: <20241024-phy_core_fix-v2-0-fc0c63dbfcf3@quicinc.com>
 <20241024-phy_core_fix-v2-4-fc0c63dbfcf3@quicinc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024-phy_core_fix-v2-4-fc0c63dbfcf3@quicinc.com>

On Thu, Oct 24, 2024 at 10:39:29PM +0800, Zijun Hu wrote:
> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> It will leak refcount of OF node @args.np for _of_phy_get() not to
> decrease refcount increased by previous of_parse_phandle_with_args()
> when returns due to of_device_is_compatible() error.
> 
> Fix by adding of_node_put() before the error return.
> 
> Fixes: b7563e2796f8 ("phy: work around 'phys' references to usb-nop-xceiv devices")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
>  drivers/phy/phy-core.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
> index 52ca590a58b9..967878b78797 100644
> --- a/drivers/phy/phy-core.c
> +++ b/drivers/phy/phy-core.c
> @@ -629,8 +629,11 @@ static struct phy *_of_phy_get(struct device_node *np, int index)
>  		return ERR_PTR(-ENODEV);
>  
>  	/* This phy type handled by the usb-phy subsystem for now */
> -	if (of_device_is_compatible(args.np, "usb-nop-xceiv"))
> +	if (of_device_is_compatible(args.np, "usb-nop-xceiv")) {
> +		/* Put refcount above of_parse_phandle_with_args() got */

No need for a comment as this is already handled in the later paths.

> +		of_node_put(args.np);

For that reason you should probably initialise ret and add a new label
out_put_node that you jump to here instead.

>  		return ERR_PTR(-ENODEV);
> +	}
>  
>  	mutex_lock(&phy_provider_mutex);
>  	phy_provider = of_phy_provider_lookup(args.np);

Johan

