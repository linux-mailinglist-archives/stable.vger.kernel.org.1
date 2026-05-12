Return-Path: <stable+bounces-245833-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kMAuHJ9NA2r63gEAu9opvQ
	(envelope-from <stable+bounces-245833-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 17:56:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1CA524293
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 17:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 880DC3051C45
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 15:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 837B1362138;
	Tue, 12 May 2026 15:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tE0cq5vw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5703A872C;
	Tue, 12 May 2026 15:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778600915; cv=none; b=c+ANVxz1SCPeLeG8gkRZW9r/rwL4PaiopQIo+VdXSWrFsHernxL+aN2/NbVmzFK2S3zS1iG69aSACFuNJtNXRJw1VqvXiRHQGb8ijaB1LekvccSlBpqu9gvlBtJ/BfZ0vsSC/HdGDO+rS546GiT5NdP1ILgepanepIMh884PdeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778600915; c=relaxed/simple;
	bh=LGzpwnbg/V4HRPwFqkB/GGyJfWOphgIoXSDhen6BwjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=heDmUsTTnsBF8l1vNcllRCQ/1fMeeZFHlrHu9qOhKgg1Uyud0GUta3jpNA9KvKI/xJuQ9lXGNmxn1zo3We1wv2mliV5e+7vjCeRRkN+U3VjudNXy8kb67acRFxb/6dTmvtv0yNJwh8Dko/al/JfCyfS7+vnHlGTuq/zQsjLg4/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tE0cq5vw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D0ACC2BCF6;
	Tue, 12 May 2026 15:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778600914;
	bh=LGzpwnbg/V4HRPwFqkB/GGyJfWOphgIoXSDhen6BwjU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tE0cq5vwYUzXs5Kac/YbMH1kQ1hrscqUif8l/vO9Rl+yK4S0kYHG/Thnj48osQD5k
	 pN88OVATAel0pHSpgJ4s/b5pm58HJ8QeqjGPWfgFFFes2Gqu32giKjZtkaT7MAgnDY
	 FzAND1NwwWQ3XRCW0+egmTkdHKACukohzBxG34So=
Date: Tue, 12 May 2026 17:48:39 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jeremy Erazo <mendozayt13@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] usb: gadget: composite: fix integer underflow in
 WebUSB GET_URL handling
Message-ID: <2026051227-concerned-geiger-b8a6@gregkh>
References: <2026051237-delicacy-gallon-268c@gregkh>
 <20260512153825.327038-1-mendozayt13@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512153825.327038-1-mendozayt13@gmail.com>
X-Rspamd-Queue-Id: 8D1CA524293
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245833-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 03:38:25PM +0000, Jeremy Erazo wrote:
> The WebUSB GET_URL handler in composite_setup() narrows
> landing_page_length to fit the host-supplied wLength using
> 
> 	landing_page_length = w_length
> 		- WEBUSB_URL_DESCRIPTOR_HEADER_LENGTH + landing_page_offset;
> 
> If wLength is smaller than WEBUSB_URL_DESCRIPTOR_HEADER_LENGTH the
> unsigned subtraction wraps, and the subsequent
> 
> 	memcpy(url_descriptor->URL,
> 	       cdev->landing_page + landing_page_offset,
> 	       landing_page_length - landing_page_offset);
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
>  drivers/usb/gadget/composite.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
> index a902184bd..dc3664374 100644
> --- a/drivers/usb/gadget/composite.c
> +++ b/drivers/usb/gadget/composite.c
> @@ -2172,7 +2172,10 @@ composite_setup(struct usb_gadget *gadget, const struct usb_ctrlrequest *ctrl)
>  				sizeof(url_descriptor->URL)
>  				- WEBUSB_URL_DESCRIPTOR_HEADER_LENGTH + landing_page_offset);
>  
> -			if (w_length < WEBUSB_URL_DESCRIPTOR_HEADER_LENGTH + landing_page_length)
> +			if (w_length < WEBUSB_URL_DESCRIPTOR_HEADER_LENGTH)
> +				landing_page_length = landing_page_offset;
> +			else if (w_length <
> +				 WEBUSB_URL_DESCRIPTOR_HEADER_LENGTH + landing_page_length)
>  				landing_page_length = w_length
>  				- WEBUSB_URL_DESCRIPTOR_HEADER_LENGTH + landing_page_offset;
>  
> -- 
> 2.53.0
> 
> 

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

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

