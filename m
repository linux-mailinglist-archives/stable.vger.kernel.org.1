Return-Path: <stable+bounces-118718-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB705A41825
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 10:07:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 436A87A37A1
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 09:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E17B24291B;
	Mon, 24 Feb 2025 09:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mjq+6RtS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6F823F406;
	Mon, 24 Feb 2025 09:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740388031; cv=none; b=Sa5zwBR9PlklCobiGZSu+QeM1FxDQP8S/5/mZmpiN0bVUrsNJ5wHF10QYMxe0rQ7jL/xtr2KgMtUdiH+Eai7sV+i4DpOwC1Ts7mbQ0ohxk8WsWcTrOD4Qmqyne/igntuzDhrUeNMCy+C00HQL1dUNVPfIMFWv/caV7LDgdJriqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740388031; c=relaxed/simple;
	bh=7MWSohjY4oAiu8wRCsRjWVDMDYw1g9ZjbAapFACyM40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uLkyFbAMW5mlfbDP4RRSoCjMMgj+bBVICLiq2l5AA/YtUtBRI+dnE1CZbqu4tWFrzXIpwUTt4agZ7kx+CdCkN3uc01gj8LPJoWd/qHryOFMuRq0JjY3BhaBsQAC4Fo+kTIXelFabr3VHSu5D/+nwPcci4w2NSQUczX8kwFO2Ck4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mjq+6RtS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 419E8C4CEDD;
	Mon, 24 Feb 2025 09:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740388030;
	bh=7MWSohjY4oAiu8wRCsRjWVDMDYw1g9ZjbAapFACyM40=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mjq+6RtSQ69x6CRDQCpYNeWS9ihkTL33DWRpc2QGjZeG3CBsW/6I9ZKaE7ICKNMge
	 gaM2rkSvr+R9179x9uPivCJCAH73oiiRCHqYkxyDKE+n8fr3Hs+Xse3Qn1oeWTcCfh
	 jgkIzldl58Lmq/cNKxNNcZ5r2Xl3HtBiUMiEFJ5Q=
Date: Mon, 24 Feb 2025 10:06:01 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Prashanth K <prashanth.k@oss.qualcomm.com>
Cc: Kees Bakker <kees@ijzerbout.nl>,
	William McVicker <willmcvicker@google.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: Check bmAttributes only if configuration is
 valid
Message-ID: <2025022434-unveiling-handbook-6fc3@gregkh>
References: <20250224085604.417327-1-prashanth.k@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224085604.417327-1-prashanth.k@oss.qualcomm.com>

On Mon, Feb 24, 2025 at 02:26:04PM +0530, Prashanth K wrote:
> If the USB configuration is not valid, then avoid checking for
> bmAttributes to prevent null pointer deference.
> 
> Cc: stable@vger.kernel.org
> Fixes: 40e89ff5750f ("usb: gadget: Set self-powered based on MaxPower and bmAttributes")
> Signed-off-by: Prashanth K <prashanth.k@oss.qualcomm.com>
> ---
>  drivers/usb/gadget/composite.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
> index 4bcf73bae761..869ad99afb48 100644
> --- a/drivers/usb/gadget/composite.c
> +++ b/drivers/usb/gadget/composite.c
> @@ -1051,7 +1051,7 @@ static int set_config(struct usb_composite_dev *cdev,
>  		usb_gadget_set_remote_wakeup(gadget, 0);
>  done:
>  	if (power > USB_SELF_POWER_VBUS_MAX_DRAW ||
> -	    !(c->bmAttributes & USB_CONFIG_ATT_SELFPOWER))
> +	    (c && !(c->bmAttributes & USB_CONFIG_ATT_SELFPOWER)))
>  		usb_gadget_clear_selfpowered(gadget);
>  	else
>  		usb_gadget_set_selfpowered(gadget);
> -- 
> 2.25.1
> 
> 

Have you checked linux-next yet for this fix that was posted last week?
Does that not resolve the issue for you?

thanks,

greg k-h

