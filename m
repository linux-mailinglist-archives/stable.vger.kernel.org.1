Return-Path: <stable+bounces-188372-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3BC2BF793D
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 18:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 052721882FD8
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 16:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F236E3451DA;
	Tue, 21 Oct 2025 16:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WMmhLyCq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF6F3451AD;
	Tue, 21 Oct 2025 16:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761062775; cv=none; b=iiT1WKkRZvw05WqF4EcPNyCxOsyLe03FFrU9RGi41pkY4txixSJEljtgmxAlHyQoMIEez4wG/JUq/5OQIDEoCq6muxdAm5MsQWgDyz41xO9YpQx6+AaEK0muC88i2ez5sRIKRb6th3Woc9ApjaK551UQJStHBnULEls4KwvD7q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761062775; c=relaxed/simple;
	bh=qYlGn7W1xsBMVOnKfhoZVoNO+LBcUe/Za6r0RNX+fZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QqI7XWx2iDK+zrtO1cc6Ep52/IjAGgZaNeO6kxODK2sXlU4haugTqgPZZVlzYYY63S/GU27qpI7dD6sOP6BMRk6ki7slm7mbhWFW71br0iFYwJat0imkAceTiQv6WV3jLB0ugAA0ul6DHZtgn+d/RuCCiT8rDl/svH2ogkZHUUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WMmhLyCq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5032C4CEF1;
	Tue, 21 Oct 2025 16:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761062774;
	bh=qYlGn7W1xsBMVOnKfhoZVoNO+LBcUe/Za6r0RNX+fZw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WMmhLyCq5nHPFAmMrY5p/3bBqV+VZaKAVyPQ0jSd9rHnLBzEuNpp5Bh98chqZ8j8Y
	 xnuzfU8fhn9Asyt9lcDfhmpDoKEX3TkJaYOUthxmqfjAMRIG0/hMkOYA93QR1Fqftl
	 k6KKdB/Go0bf/GntlEbBXjP4Uk0EDSjy5y2VZZic=
Date: Tue, 21 Oct 2025 18:06:11 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	andrey.konovalov@linux.dev
Subject: Re: [PATCH] usb: raw-gadget: do not limit transfer length
Message-ID: <2025102151-footpath-entomb-76da@gregkh>
References: <a6024e8eab679043e9b8a5defdb41c4bda62f02b.1757016152.git.andreyknvl@gmail.com>
 <CA+fCnZdG+X48_W_bSKYpziKohjp1QVgDzUzfYK_KOk42j58_ZA@mail.gmail.com>
 <CA+fCnZdHJtHgZuD9tiDGD8svXTEdP=GK8HSo71y_UfKgZcaUxg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+fCnZdHJtHgZuD9tiDGD8svXTEdP=GK8HSo71y_UfKgZcaUxg@mail.gmail.com>

On Tue, Oct 21, 2025 at 04:19:13PM +0200, Andrey Konovalov wrote:
> On Tue, Oct 21, 2025 at 4:18 PM Andrey Konovalov <andreyknvl@gmail.com> wrote:
> >
> > On Thu, Sep 4, 2025 at 10:08 PM <andrey.konovalov@linux.dev> wrote:
> > >
> > > From: Andrey Konovalov <andreyknvl@gmail.com>
> > >
> > > Drop the check on the maximum transfer length in Raw Gadget for both
> > > control and non-control transfers.
> > >
> > > Limiting the transfer length causes a problem with emulating USB devices
> > > whose full configuration descriptor exceeds PAGE_SIZE in length.
> > >
> > > Overall, there does not appear to be any reason to enforce any kind of
> > > transfer length limit on the Raw Gadget side for either control or
> > > non-control transfers, so let's just drop the related check.
> > >
> > > Cc: stable@vger.kernel.org
> > > Fixes: f2c2e717642c ("usb: gadget: add raw-gadget interface")
> > > Signed-off-by: Andrey Konovalov <andreyknvl@gmail.com>
> > > ---
> > >  drivers/usb/gadget/legacy/raw_gadget.c | 2 --
> > >  1 file changed, 2 deletions(-)
> > >
> > > diff --git a/drivers/usb/gadget/legacy/raw_gadget.c b/drivers/usb/gadget/legacy/raw_gadget.c
> > > index 20165e1582d9..b71680c58de6 100644
> > > --- a/drivers/usb/gadget/legacy/raw_gadget.c
> > > +++ b/drivers/usb/gadget/legacy/raw_gadget.c
> > > @@ -667,8 +667,6 @@ static void *raw_alloc_io_data(struct usb_raw_ep_io *io, void __user *ptr,
> > >                 return ERR_PTR(-EINVAL);
> > >         if (!usb_raw_io_flags_valid(io->flags))
> > >                 return ERR_PTR(-EINVAL);
> > > -       if (io->length > PAGE_SIZE)
> > > -               return ERR_PTR(-EINVAL);
> > >         if (get_from_user)
> > >                 data = memdup_user(ptr + sizeof(*io), io->length);
> > >         else {
> > > --
> > > 2.43.0
> > >
> >
> > Hi Greg,
> >
> > Could you pick up this patch?
> >
> > Thank you!
> 
> (Greg to To:)

Can you send it to the proper list again?  I didn't see it on the
linux-usb list as it was never sent there :(

thanks,

greg k-h

