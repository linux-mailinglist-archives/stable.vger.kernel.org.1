Return-Path: <stable+bounces-116374-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0104A35854
	for <lists+stable@lfdr.de>; Fri, 14 Feb 2025 09:01:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99D763AB49A
	for <lists+stable@lfdr.de>; Fri, 14 Feb 2025 08:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C5D21D596;
	Fri, 14 Feb 2025 08:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KjpeEtUt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88967221550;
	Fri, 14 Feb 2025 08:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739520062; cv=none; b=EpDONLsynKNQhfaKQjEq5DKpTIWYLxyw6rhdD40KzL0YEjaKNoPj1Fjp3anR9g2cmIdyRwPP6/SUn/ky7OlNFvoVnAke6hFFVK9Na0W24psy3OnjMctrAmIlwAFqHZOfnQV5dXkEEmu0u8z2bmpmG37W+1PDWspHQNZZE9cBC60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739520062; c=relaxed/simple;
	bh=GKKFPhOHTbLnldzFhimOJsuL88ApoB+sH3SCD1/GUSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fMMoJOQEhqI9lP0RGFL26KQtV6F2NO1lDqp2Zb5f6y39Kc3o2guY1xhcPRQZsWGfRVQLlZ8XC2MoYe1B01ZVr4I00Xx9D4qXIYRJTEpHZ5qL6Zl8yuh0GfiQFZcUcXH8FH1qZrcq4kJbk/lWUIkcmLV+kjLQ2aDIRDiv97Yo/qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KjpeEtUt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55DB7C4CED1;
	Fri, 14 Feb 2025 08:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739520062;
	bh=GKKFPhOHTbLnldzFhimOJsuL88ApoB+sH3SCD1/GUSE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KjpeEtUtGfjUi3Rci7goJY6v7wxiLxsXoQpbTieMjlrIs0Qdlo93cSY6xtBQp61Nt
	 Cuut4nOr6+kp36rpzd2vuHc7PsKwZmG6z0jtey79G7mZaz1ErxVqL2W1dyfBuehFP2
	 vG645LM5c3oR3VSRgQYKhrnZlrXUOxTWvKZoY83E=
Date: Fri, 14 Feb 2025 09:00:58 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Prashanth K <prashanth.k@oss.qualcomm.com>
Cc: Ferry Toth <ftoth@exalondelft.nl>,
	Ricardo B Marliere <ricardo@marliere.net>,
	Kees Cook <kees@kernel.org>, linux-usb@vger.kernel.org,
	Elson Roy Serrao <quic_eserrao@quicinc.com>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: u_ether: Set is_suspend flag if remote
 wakeup fails
Message-ID: <2025021436-seizing-prankish-ebf2@gregkh>
References: <20250212100840.3812153-1-prashanth.k@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212100840.3812153-1-prashanth.k@oss.qualcomm.com>

On Wed, Feb 12, 2025 at 03:38:40PM +0530, Prashanth K wrote:
> Currently while UDC suspends, u_ether attempts to remote wakeup
> the host if there are any pending transfers. However, if remote
> wakeup fails, the UDC remains suspended but the is_suspend flag
> is not set. And since is_suspend flag isn't set, the subsequent
> eth_start_xmit() would queue USB requests to suspended UDC.
> 
> To fix this, bail out from gether_suspend() only if remote wakeup
> operation is successful.
> 
> Cc: stable@vger.kernel.org
> Fixes: 0a1af6dfa077 ("usb: gadget: f_ecm: Add suspend/resume and remote wakeup support")
> Signed-off-by: Prashanth K <prashanth.k@oss.qualcomm.com>
> ---
>  drivers/usb/gadget/function/u_ether.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/gadget/function/u_ether.c b/drivers/usb/gadget/function/u_ether.c
> index 09e2838917e2..f58590bf5e02 100644
> --- a/drivers/usb/gadget/function/u_ether.c
> +++ b/drivers/usb/gadget/function/u_ether.c
> @@ -1052,8 +1052,8 @@ void gether_suspend(struct gether *link)
>  		 * There is a transfer in progress. So we trigger a remote
>  		 * wakeup to inform the host.
>  		 */
> -		ether_wakeup_host(dev->port_usb);
> -		return;
> +		if (!ether_wakeup_host(dev->port_usb))
> +			return;

What about the other place in the driver where this function is called
but the return value is ignored?

thanks,

greg k-h

