Return-Path: <stable+bounces-166457-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CAF4B19F2A
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 12:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0EC53B35FA
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 10:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 840BB24676B;
	Mon,  4 Aug 2025 10:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WYRfldFn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CA723D2B1;
	Mon,  4 Aug 2025 10:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754301656; cv=none; b=gf2IrscvV6GCPxbv5bbRNCHV0cSkmrD9tEyDSRuWSMe1iHOR2z8lEBDii7GfpKff8jZ43V8wjQ4stNnqF0HX5zU28/nwzTpE5Kf4mvO2KlUh+7NstGaIPwW+uL1x7WZutc19IaZPDRxbs/n2Zz20VcLQVY++12aoqWpOZiDC+10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754301656; c=relaxed/simple;
	bh=C7mKQMp+GxD6RFGH57BJqOHlqmXj4BMLvSGcVzGnIiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gAgR7G0Gidhdf1vw5KxyULCIlHblJCli7Vi7aRuzpCb5J32Hy2+taHSH4A2KABiAiGMyQAc4GD4Nd54lysYT7AhyAkwi8EfZ8KNJb+iPv91pMKkEXIXtp3t+L2+MVFmsYoyVlQXNcQf67zt+3bfECHL6dG+Ov+WFCdxXgOfA8L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WYRfldFn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB3A4C4CEE7;
	Mon,  4 Aug 2025 10:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754301655;
	bh=C7mKQMp+GxD6RFGH57BJqOHlqmXj4BMLvSGcVzGnIiU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WYRfldFnCpEyxVWR6stxBNTdXR0Lp44/oxDX3k8AgGXC9whh0RIg/D0A4uIPzuiYZ
	 gRQhwVZwyMXSKezqqTj2VpjXlJQZ7u/hxM7C0nwzg6LShAI1N1ppCHd7BmSHAC1qEy
	 25unaysiin3XB2q+7t8y8dkiPthcCwdtequVbQu7pyKG8lFT9UuanidcOX7IjAeHQp
	 c4DZ4DyDyvQo28BuOaCTjVyc019U+3zJ/7xMy01+I2foriMhkwk4EtliQWFqRG8Kri
	 z68mVg72xHp8FZzQhHuqOPuUfwuSAI6sQf4XgxShRHl4tYpzL4FowjXU2usGjKOgEN
	 JNZ9wJ3M9iMaA==
Date: Mon, 4 Aug 2025 11:00:50 +0100
From: Simon Horman <horms@kernel.org>
To: Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc: Oliver Neukum <oneukum@suse.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linux Netdev Mailing List <netdev@vger.kernel.org>,
	Linux USB Mailing List <linux-usb@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Armando Budianto <sprite@gnuweeb.org>, gwml@vger.gnuweeb.org,
	stable@vger.kernel.org, John Ernberg <john.ernberg@actia.se>
Subject: Re: [PATCH net v2] net: usbnet: Fix the wrong netif_carrier_on()
 call placement
Message-ID: <20250804100050.GQ8494@horms.kernel.org>
References: <20250801190310.58443-1-ammarfaizi2@gnuweeb.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250801190310.58443-1-ammarfaizi2@gnuweeb.org>

+ John Ernberg

On Sat, Aug 02, 2025 at 02:03:10AM +0700, Ammar Faizi wrote:
> The commit in the Fixes tag breaks my laptop (found by git bisect).
> My home RJ45 LAN cable cannot connect after that commit.
> 
> The call to netif_carrier_on() should be done when netif_carrier_ok()
> is false. Not when it's true. Because calling netif_carrier_on() when
> __LINK_STATE_NOCARRIER is not set actually does nothing.
> 
> Cc: Armando Budianto <sprite@gnuweeb.org>
> Cc: stable@vger.kernel.org
> Closes: https://lore.kernel.org/netdev/0752dee6-43d6-4e1f-81d2-4248142cccd2@gnuweeb.org
> Fixes: 0d9cfc9b8cb1 ("net: usbnet: Avoid potential RCU stall on LINK_CHANGE event")
> Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
> ---
> 
> v2:
>   - Rebase on top of the latest netdev/net tree. The previous patch was
>     based on 0d9cfc9b8cb1. Line numbers have changed since then.
> 
>  drivers/net/usb/usbnet.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
> index a38ffbf4b3f0..a1827684b92c 100644
> --- a/drivers/net/usb/usbnet.c
> +++ b/drivers/net/usb/usbnet.c
> @@ -1114,31 +1114,31 @@ static const struct ethtool_ops usbnet_ethtool_ops = {
>  };
>  
>  /*-------------------------------------------------------------------------*/
>  
>  static void __handle_link_change(struct usbnet *dev)
>  {
>  	if (!test_bit(EVENT_DEV_OPEN, &dev->flags))
>  		return;
>  
>  	if (!netif_carrier_ok(dev->net)) {
> +		if (test_and_clear_bit(EVENT_LINK_CARRIER_ON, &dev->flags))
> +			netif_carrier_on(dev->net);
> +
>  		/* kill URBs for reading packets to save bus bandwidth */
>  		unlink_urbs(dev, &dev->rxq);
>  
>  		/*
>  		 * tx_timeout will unlink URBs for sending packets and
>  		 * tx queue is stopped by netcore after link becomes off
>  		 */
>  	} else {
> -		if (test_and_clear_bit(EVENT_LINK_CARRIER_ON, &dev->flags))
> -			netif_carrier_on(dev->net);
> -
>  		/* submitting URBs for reading packets */
>  		queue_work(system_bh_wq, &dev->bh_work);
>  	}
>  
>  	/* hard_mtu or rx_urb_size may change during link change */
>  	usbnet_update_max_qlen(dev);
>  
>  	clear_bit(EVENT_LINK_CHANGE, &dev->flags);
>  }
>  
> -- 
> Ammar Faizi
> 
> 

