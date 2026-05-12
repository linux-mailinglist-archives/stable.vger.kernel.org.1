Return-Path: <stable+bounces-245808-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UN3KKhtCA2pV2QEAu9opvQ
	(envelope-from <stable+bounces-245808-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 17:07:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B38E852348C
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 17:07:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 78BB431E21A0
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 14:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE6693C1F47;
	Tue, 12 May 2026 14:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UYrcBT9s"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890373B5F5D;
	Tue, 12 May 2026 14:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778596689; cv=none; b=WLWAmjj7EJ9YIeaeYaipdkFuAUcM9YTZDXyAKco5O7Foak+7b78J8Cn+ZnfSg0qW/levV+zD5gEpqzEDCd8AswvRydrQrJtWoKb4X7IIP2N7IWGXQCAvfQazVGs+qlzH8YAR+1tTeeclVnfu6E/wCcVJYO/33LUXQRXMlxiAELA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778596689; c=relaxed/simple;
	bh=jbLD75OPWL6SVoyShglRzZ8g9b0hfzwobh3zc9lFvnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZUIGp18qlKP0DmpYT1hqC10SYbuK2yPm6DaWpZ0N1mmT035NsO1n2E4HkOz6mHRQeYDh2a/OvWKaH+XWVdBPyiJKKLSJyTY4ccRUG3gQ9ZXhOusyo2nsTXqLIbCl9fk8gzcdFIxrzyFacZpMFaBzZesq4OPz+80RAxo68R1Ducs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UYrcBT9s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EB48C2BCB0;
	Tue, 12 May 2026 14:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778596689;
	bh=jbLD75OPWL6SVoyShglRzZ8g9b0hfzwobh3zc9lFvnE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UYrcBT9sp4yjXzDVwf/vTaxcqAsp3us210SJWzfIb+QqdOZk/kvUVnKrATPK8DA0z
	 PNiFNzJ7X02hnSki/8k4hI04nvVAbb34hXRdgNCxcAmDdD59VxT2YUh+TnRxitcBBh
	 ymiC3PJE6dFjsmU1SAgtVBe7rs27CnuI0JOzeVlc=
Date: Tue, 12 May 2026 16:32:51 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Sebastian EM <mendozayt13@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: composite: fix integer underflow in WebUSB
 GET_URL handling
Message-ID: <2026051237-delicacy-gallon-268c@gregkh>
References: <20260512014343.3770664-1-mendozayt13@gmail.com>
 <2026051221-glory-macaroni-dce6@gregkh>
 <CAD89HyBhwxDsat_JCFFfA-tUYVatxByDj=ikpc9Rxj=kAqn=Sw@mail.gmail.com>
 <2026051245-kangaroo-matriarch-8eed@gregkh>
 <CAD89HyCWaa8esENsCip3foXe7c8x34HRx=37+c4MwnTpCbN1oQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD89HyCWaa8esENsCip3foXe7c8x34HRx=37+c4MwnTpCbN1oQ@mail.gmail.com>
X-Rspamd-Queue-Id: B38E852348C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245808-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 09:12:14AM -0500, Sebastian EM wrote:
> The WebUSB GET_URL handler in composite_setup() narrows
> landing_page_length to fit the host-supplied wLength using
> 
> landing_page_length = w_length
> - WEBUSB_URL_DESCRIPTOR_HEADER_LENGTH + landing_page_offset;
> 
> If wLength is smaller than WEBUSB_URL_DESCRIPTOR_HEADER_LENGTH the
> unsigned subtraction wraps, and the subsequent
> 
> memcpy(url_descriptor->URL,
>       cdev->landing_page + landing_page_offset,
>       landing_page_length - landing_page_offset);
> 
> ends up copying close to UINT_MAX bytes from cdev->landing_page into
> cdev->req->buf.  KASAN reports a slab-out-of-bounds in composite_setup
> on the kmalloc-2k gadget_info allocation, and FORTIFY_SOURCE traps the
> memcpy as a 4294967293-byte field-spanning write into
> url_descriptor->URL (size 252).
> 
> A USB host can reach this from a single SETUP packet against any
> gadget that has webusb/use=1 and a landingPage configured.
> 
> Handle the small-wLength case before the math: when the host requested
> fewer bytes than the URL descriptor header, only the header is
> meaningful and no URL bytes need to be copied.  Setting
> landing_page_length to landing_page_offset makes the existing memcpy a
> no-op and leaves the descriptor returned to the host unchanged for all
> larger wLength values.
> 
> Fixes: 93c473948c58 ("usb: gadget: add WebUSB landing page support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jeremy Erazo <mendozayt13@gmail.com>
> ---
> v2:
> - Drop the self Reported-by tag.
> - Add Fixes tag.
> - Cc stable.
> 
>  drivers/usb/gadget/composite.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
> index a902184bd..dc3664374 100644
> --- a/drivers/usb/gadget/composite.c
> +++ b/drivers/usb/gadget/composite.c
> @@ -2172,7 +2172,10 @@ composite_setup(struct usb_gadget *gadget, const
> struct usb_ctrlrequest *ctrl)
>   sizeof(url_descriptor->URL)
>   - WEBUSB_URL_DESCRIPTOR_HEADER_LENGTH + landing_page_offset);
> 
> - if (w_length < WEBUSB_URL_DESCRIPTOR_HEADER_LENGTH + landing_page_length)
> + if (w_length < WEBUSB_URL_DESCRIPTOR_HEADER_LENGTH)
> + landing_page_length = landing_page_offset;
> + else if (w_length <
> + WEBUSB_URL_DESCRIPTOR_HEADER_LENGTH + landing_page_length)
>   landing_page_length = w_length
>   - WEBUSB_URL_DESCRIPTOR_HEADER_LENGTH + landing_page_offset;
> 
> -- 
> 2.53.0
> 
> El mar, 12 may 2026 a las 8:29, Greg Kroah-Hartman (<
> gregkh@linuxfoundation.org>) escribió:
> 
> > On Tue, May 12, 2026 at 06:18:54AM -0500, Sebastian EM wrote:
> > > Hi Greg,
> > >
> > > Thanks for the review.
> > >
> > > You are right; the self Reported-by tag does not belong there, so I
> > dropped
> > > it in v2.
> > >
> > > The introducing commit is:
> > >
> > > 93c473948c58 ("usb: gadget: add WebUSB landing page support")
> > >
> > > I also added:
> > >
> > > Cc: stable@vger.kernel.org
> > >
> > > since the issue was introduced with the WebUSB GET_URL handling path and
> > > the fix is a small bounds/underflow fix suitable for stable kernels.
> > >
> > > v2 is attached as a plain patch:
> > >
> > >
> > 0001-v2-usb-gadget-composite-fix-integer-underflow-in-WebUSB-GET_URL-handling.patch
> >
> > We can't take patches as attachments, just send this as a normal v2
> > patch.
> >
> > thanks,
> >
> > greg k-h
> >

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- Your patch is malformed (tabs converted to spaces, linewrapped, etc.)
  and can not be applied.  Please read the file,
  Documentation/process/email-clients.rst in order to fix this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

