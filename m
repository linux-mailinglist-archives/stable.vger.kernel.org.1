Return-Path: <stable+bounces-203365-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A95CDBDA7
	for <lists+stable@lfdr.de>; Wed, 24 Dec 2025 10:46:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2287A3016DCE
	for <lists+stable@lfdr.de>; Wed, 24 Dec 2025 09:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA97232F741;
	Wed, 24 Dec 2025 09:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="D3O+iANn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFF62C0F70;
	Wed, 24 Dec 2025 09:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766569517; cv=none; b=e6jxol/y5AfGnv5t4n/qlicFymg0WHXyVv/YkkzF694tuhLzJHNojG/yWyL3xGBjNV5Qtx0BCk7AKUFwzQr5bHRLMmxZiZAXBG3bSvJUvXWU4jrdJVbt6Sxjh7H7GifUretEmOHSE2gUeQm6AOVM+vGTIXsMrmsOzT3U/gpEyV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766569517; c=relaxed/simple;
	bh=1oJtW6DavlHoxxHq+HE9xjdy/JHvlvatqXmRp0VyJP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hbgcI5Hpk+drScRQFTLPk2hZuA7sDI2EB8eS8HZRY6rMth6McdOp6jEGJJt3jZuGq8ajX+pMRTo4qmWOJ8RlKh0xiNPaWLE73R2pooRtKLsq3EIOMdOxdsnt2Qih3kHuVG6zX5zDf2+WNyNomWdwT4d+6VT3Kgeek2G7tGtONHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=D3O+iANn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72157C16AAE;
	Wed, 24 Dec 2025 09:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1766569516;
	bh=1oJtW6DavlHoxxHq+HE9xjdy/JHvlvatqXmRp0VyJP4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D3O+iANnYo3qk5I3qb9n2M5f+MIi7l4bjYU7MMzsBUmEqXXP9E6fbyvTlcZ/mVudg
	 1t0/WPt+c/R6aDSyjViIBdX8KD+/Pcbu53VO43JmQPk6zy7EBBy+tiBrW/joevoHbn
	 ZW7Yg953FYOaZqZFgaJDI5Fr1WxzT+Xc8KygLelc=
Date: Wed, 24 Dec 2025 10:45:13 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
Cc: pawell@cadence.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] usb: cdns2: fix a null pointer dereference in
 cdns2_gadget_ep_queue()
Message-ID: <2025122448-snowbound-married-f070@gregkh>
References: <20251224093845.1578894-1-lihaoxiang@isrc.iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251224093845.1578894-1-lihaoxiang@isrc.iscas.ac.cn>

On Wed, Dec 24, 2025 at 05:38:45PM +0800, Haoxiang Li wrote:
> If cdns2_gadget_ep_alloc_request() fails, a null pointer dereference
> occurs. Add a check to prevent it.
> 
> Fixes: 3eb1f1efe204 ("usb: cdns2: Add main part of Cadence USBHS driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
> ---
>  drivers/usb/gadget/udc/cdns2/cdns2-gadget.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/gadget/udc/cdns2/cdns2-gadget.c b/drivers/usb/gadget/udc/cdns2/cdns2-gadget.c
> index 9b53daf76583..c5b9dae743d8 100644
> --- a/drivers/usb/gadget/udc/cdns2/cdns2-gadget.c
> +++ b/drivers/usb/gadget/udc/cdns2/cdns2-gadget.c
> @@ -1725,6 +1725,8 @@ static int cdns2_gadget_ep_queue(struct usb_ep *ep, struct usb_request *request,
>  		struct cdns2_request *preq;
>  
>  		zlp_request = cdns2_gadget_ep_alloc_request(ep, GFP_ATOMIC);
> +		if (!zlp_request)
> +			return -ENOMEM;

As stated before, you need to document the tool that you use to find
these types of things.

And how was this tested?

thanks,

greg k-h

