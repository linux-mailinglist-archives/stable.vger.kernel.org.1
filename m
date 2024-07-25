Return-Path: <stable+bounces-61344-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F9AA93BBE0
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 06:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFCE51C2091E
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 04:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C091C694;
	Thu, 25 Jul 2024 04:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="w039w93K"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4339B1799D;
	Thu, 25 Jul 2024 04:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721883383; cv=none; b=uqwh41vws17E6JghhQlsWblB6YGaymtX0dnAyoggBZQmP0HptrTgDsXoC2uFYR3IXVunuyTEUrnNj5E/u5pRjUpdRy/0ZXTsIaiBv/yWhcqHBa15tI8yhXc3SXWQd0VMdff9i8tW6oK31CbtGFF6n+IBXWO3w6T53ZlEdMv61ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721883383; c=relaxed/simple;
	bh=zk/VhAHN1LPunJ+YJmUalCWwGgZ5WsvNLPHEGNo3DhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t9uI9f7n25MszQ+ru7qFB7bASbOFN6JanyZZDlw5F6DsK0Jm/yqH1Q64c3WxEexrpXuS+Vxe/+E5y1ptA1AeCfl4KjapHVrCeofhjnKKn+b+01U/JR5enHFXdbrCx40xu98xpSVzGFu/WIpidNJ2pt8pKlPdnfMxhEydHeyVZVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=w039w93K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52A14C116B1;
	Thu, 25 Jul 2024 04:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721883382;
	bh=zk/VhAHN1LPunJ+YJmUalCWwGgZ5WsvNLPHEGNo3DhM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=w039w93KtKKREIAq9lY6f4/SJCMwGs1O5VIHAOZkgdJeZjpH99r/5aCIE+4GfeiRF
	 wmglW/z+fQs2+2QUr4hd/8HTAFyDy+E+Zp1V/+WAOV9j0MTnhqUEoH5qauo/ix1w2t
	 JcydWzM4H8SiPyJWCMJIK3wyK/mFQ9EXCYLYEWXk=
Date: Thu, 25 Jul 2024 06:56:19 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: crwulff@gmail.com
Cc: linux-usb@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>,
	Roy Luo <royluo@google.com>,
	Krishna Kurapati <quic_kriskura@quicinc.com>,
	Michael Grzeschik <m.grzeschik@pengutronix.de>,
	yuan linyu <yuanlinyu@hihonor.com>,
	Paul Cercueil <paul@crapouillou.net>,
	Felipe Balbi <balbi@kernel.org>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] usb: gadget: core: Check for unset descriptor
Message-ID: <2024072512-arguably-creole-a017@gregkh>
References: <20240725010419.314430-2-crwulff@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240725010419.314430-2-crwulff@gmail.com>

On Wed, Jul 24, 2024 at 09:04:20PM -0400, crwulff@gmail.com wrote:
> From: Chris Wulff <crwulff@gmail.com>
> 
> Make sure the descriptor has been set before looking at maxpacket.
> This fixes a null pointer panic in this case.
> 
> This may happen if the gadget doesn't properly set up the endpoint
> for the current speed, or the gadget descriptors are malformed and
> the descriptor for the speed/endpoint are not found.
> 
> No current gadget driver is known to have this problem, but this
> may cause a hard-to-find bug during development of new gadgets.
> 
> Fixes: 54f83b8c8ea9 ("USB: gadget: Reject endpoints with 0 maxpacket value")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chris Wulff <crwulff@gmail.com>
> ---
> v2: Added WARN_ONCE message & clarification on causes
> v1: https://lore.kernel.org/all/20240721192048.3530097-2-crwulff@gmail.com/
> ---
>  drivers/usb/gadget/udc/core.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
> index 2dfae7a17b3f..81f9140f3681 100644
> --- a/drivers/usb/gadget/udc/core.c
> +++ b/drivers/usb/gadget/udc/core.c
> @@ -118,12 +118,10 @@ int usb_ep_enable(struct usb_ep *ep)
>  		goto out;
>  
>  	/* UDC drivers can't handle endpoints with maxpacket size 0 */
> -	if (usb_endpoint_maxp(ep->desc) == 0) {
> -		/*
> -		 * We should log an error message here, but we can't call
> -		 * dev_err() because there's no way to find the gadget
> -		 * given only ep.
> -		 */
> +	if (!ep->desc || usb_endpoint_maxp(ep->desc) == 0) {
> +		WARN_ONCE(1, "%s: ep%d (%s) has %s\n", __func__, ep->address, ep->name,
> +			  (!ep->desc) ? "NULL descriptor" : "maxpacket 0");

So you just rebooted a machine that hit this, that's not good at all.
Please log the error and recover, don't crash a system (remember,
panic-on-warn is enabled in billions of Linux systems.)

thanks,

greg k-h

