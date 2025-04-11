Return-Path: <stable+bounces-132237-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F8EAA85E41
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 15:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B992C3B29A6
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 13:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EDBC130AC8;
	Fri, 11 Apr 2025 13:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oCHB33EI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7BE7DA6A;
	Fri, 11 Apr 2025 13:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744376798; cv=none; b=mbnkXvxywrPe2uRfqC+TB+KvtVLOP9AeRm08QabRzkKMla5GiEGh2o2R1WgYokRy3LTqEYxyoAAKTLFE2Uinxj+nY/u46/TfRRrBhfirMSGFvMxtac1f6loM26QJZcVb05EN3uKG6sPxlmYXqy+1cUYut68+LHw0M/7i17sTyy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744376798; c=relaxed/simple;
	bh=5O79GdJMUP1u1auDATSqpr2gGJykXZlL0f4n5WLQaS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XZVZ10UCx6SPk+3uZTh5b2Jn45NHBGIlvwgjEv1MZTZd2k6Xp+EwHDs20JkfXLgn/7JaJtobiudqE4yfAwd9a6CG6i/W/vpXL/EfdOuysxrwknZ1dAJgQdrS/LucHVVYJuP38I3X/o/cFXJGKeAGkYagoods1sLICGkVGWP8+Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oCHB33EI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 506F3C4CEE2;
	Fri, 11 Apr 2025 13:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744376797;
	bh=5O79GdJMUP1u1auDATSqpr2gGJykXZlL0f4n5WLQaS8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oCHB33EIcwBAAJPW7SO/vLL7mLGzXBClQFxfPq7Pgaq4qkNo00L4MAAaaVSAl5pBX
	 DJFRwHCd9ksWW1uOxVAsehLtq31xgQ1QykeaPmW3bkqaRv2Lb+R9tGQi9GUpUJKs7G
	 VvvXPitxaU4AHjFjlBLbtnqMzVAC89ik78+Jrdf0=
Date: Fri, 11 Apr 2025 15:06:34 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Henry Martin <bsdhenrymartin@gmail.com>
Cc: joel@jms.id.au, andrew@codeconstruct.com.au, linux-usb@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] usb/gadget: Add NULL check in ast_vhub_init_dev()
Message-ID: <2025041119-debit-cosmic-f41c@gregkh>
References: <20250405113020.80387-1-bsdhenrymartin@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250405113020.80387-1-bsdhenrymartin@gmail.com>

On Sat, Apr 05, 2025 at 07:30:20PM +0800, Henry Martin wrote:
> devm_kasprintf() returns NULL when memory allocation fails. Currently,
> ast_vhub_init_dev() does not check for this case, which results in a
> NULL pointer dereference.
> 
> Add NULL check after devm_kasprintf() to prevent this issue.
> 
> Cc: stable@vger.kernel.org	# v4.18
> Fixes: 7ecca2a4080c ("usb/gadget: Add driver for Aspeed SoC virtual hub")
> Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
> ---
> V1 -> V2: Add Cc: stable label and correct commit message.
> 
>  drivers/usb/gadget/udc/aspeed-vhub/dev.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/gadget/udc/aspeed-vhub/dev.c b/drivers/usb/gadget/udc/aspeed-vhub/dev.c
> index 573109ca5b79..5b7d41a990d7 100644
> --- a/drivers/usb/gadget/udc/aspeed-vhub/dev.c
> +++ b/drivers/usb/gadget/udc/aspeed-vhub/dev.c
> @@ -548,6 +548,8 @@ int ast_vhub_init_dev(struct ast_vhub *vhub, unsigned int idx)
>  	d->vhub = vhub;
>  	d->index = idx;
>  	d->name = devm_kasprintf(parent, GFP_KERNEL, "port%d", idx+1);
> +	if (!d->name)
> +		return -ENOMEM;
>  	d->regs = vhub->regs + 0x100 + 0x10 * idx;
>  
>  	ast_vhub_init_ep0(vhub, &d->ep0, d);
> -- 
> 2.34.1
> 

What kernel version did you make this against?  It does not apply to
6.15-rc1 for me :(

thanks,

greg k-h

