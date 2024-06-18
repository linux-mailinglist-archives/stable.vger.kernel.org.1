Return-Path: <stable+bounces-52664-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B9E90CA2B
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 13:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 534221F21763
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 11:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038111A00C9;
	Tue, 18 Jun 2024 11:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h4bIjzSV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3E615A844;
	Tue, 18 Jun 2024 11:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718709310; cv=none; b=P9fhfvjMlUadZmAt8Z/ZuAqTB2NOxm1hcFB5v/ICXQWl6wIajvxnGGU09+ewSg5mQYDpZV/CLloaL4jhchUDlMBwwtBK36t5fKwY3asvpIcsYmMCMHzJ81Zsth/qLiUL9FhhPrLDQUnZMIVa6XHTj6M4mUDdj6Ajrq/wo+Fwnfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718709310; c=relaxed/simple;
	bh=FhuwRLQO68CQIh1e4REGDMaFZVAy4zws0a+cKVmWB6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uLJ+MLUHQYx//sX7rIyeOVhU0qgwAjmwAUu+5/GJxrrhTiHAGvKvB2JOni1DYk9F3UlZDRPMB5c9M/On3wrdA9xZv6Je+H81P2pDNHGE3+9WDkVlmkmSdDXbEyHQ3swbnk09eaDwQ5Z8L9zGgC2NyVPhMTksgdPD6A5wnzSL3CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h4bIjzSV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27420C32786;
	Tue, 18 Jun 2024 11:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718709310;
	bh=FhuwRLQO68CQIh1e4REGDMaFZVAy4zws0a+cKVmWB6E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h4bIjzSVPAu4fkvyJyB7moPqIUratKHa2oT88TgrlOFzik2cza/FWitwjT4vRm0kB
	 CPUUKIDPQtGeT3fKthaJpQJAjPxRIC3qKjXUYAOm+vtUfYRQhXP1ya+N4mJh2cdcux
	 o9ABxKD7i7hGruhZRyP2HFaQRn3EyPfn0Mog5Gm5XSX1HpSbmf1BuWqNnMnOsZ8tbG
	 Vrf4oTcy1fbLlCfpTDl0uKeHjkePbLtIgRtjY6iFJzdTMIa5enrbAlZeVHshc8YQqb
	 tvrClkZdjbX6k3bhnULszCBliCxN00ni5+Xzxngnb2oql6zxKgX6OkKmYs9VP6M3by
	 xUZlSn8n2eupQ==
Date: Tue, 18 Jun 2024 12:15:05 +0100
From: Simon Horman <horms@kernel.org>
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] net: usb: ax88179_178a: improve link status logs
Message-ID: <20240618111505.GA650324@kernel.org>
References: <20240617103405.654567-1-jtornosm@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617103405.654567-1-jtornosm@redhat.com>

On Mon, Jun 17, 2024 at 12:33:59PM +0200, Jose Ignacio Tornos Martinez wrote:
> Avoid spurious link status logs that may ultimately be wrong; for example,
> if the link is set to down with the cable plugged, then the cable is
> unplugged and afer this the link is set to up, the last new log that is
> appearing is incorrectly telling that the link is up.
> 
> In order to aovid errors, show link status logs after link_reset
> processing, and in order to avoid spurious as much as possible, only show
> the link loss when some link status change is detected.
> 
> cc: stable@vger.kernel.org
> Fixes: e2ca90c276e1 ("ax88179_178a: ASIX AX88179_178A USB 3.0/2.0 to gigabit ethernet adapter driver")
> Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
> ---
>  drivers/net/usb/ax88179_178a.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
> index c2fb736f78b2..60357796be99 100644
> --- a/drivers/net/usb/ax88179_178a.c
> +++ b/drivers/net/usb/ax88179_178a.c
> @@ -326,7 +326,8 @@ static void ax88179_status(struct usbnet *dev, struct urb *urb)
>  
>  	if (netif_carrier_ok(dev->net) != link) {
>  		usbnet_link_change(dev, link, 1);
> -		netdev_info(dev->net, "ax88179 - Link status is: %d\n", link);
> +		if (!link)
> +			netdev_info(dev->net, "ax88179 - Link status is: %d\n", link);

Sorry Jose,

one more nit I noticed after sending my previous email.

The line above looks like it could be wrapped to <= 80 columns wide,
which is still preferred for Networking code.

Flagged by checkpatch.pl --max-line-length=80

>  	}
>  }
>  

...

