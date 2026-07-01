Return-Path: <stable+bounces-270131-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id veccMn/rRGqX3AoAu9opvQ
	(envelope-from <stable+bounces-270131-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Jul 2026 12:27:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 27F956EC21A
	for <lists+stable@lfdr.de>; Wed, 01 Jul 2026 12:27:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=xQYCJa2D;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270131-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-270131-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C4DF13056881
	for <lists+stable@lfdr.de>; Wed,  1 Jul 2026 10:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D30C40E8E7;
	Wed,  1 Jul 2026 10:25:47 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083CB3C1F4F;
	Wed,  1 Jul 2026 10:25:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782901546; cv=none; b=UAIzyZKYh7Tb3u0qpo2mCxQU1Wj/D6C4A2h/Tl2B48kBWHU28LR+804DjWTkgTdscm9d3tgI6OWaERUJIMvyGQ7hr6c/gpAkxE6gOWbnC0Xd73eB3RNREv3EhCKxMLt3aoxJFKVDFpmkvN8EjGBZvyJ04dCIHMY8z2JsJ1qFX/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782901546; c=relaxed/simple;
	bh=Zwc9OT/HbVqiv11orN2n3ee5JLDvtSqQAS3sCwyTy9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H1d0VzUncKzOdYci5HIsR1qiXH03FLihnyGz9cmL47voEzZpJ8K9OrGJbb+8KEzg6Kd+dzPT5uDIUu3Hq0h/kdcK71pWsMHRXwivP+IOmPg0P2PrQoTFUFR5sfpAqjg+B49SIPmCTehzFJO34R7W+2je2Thc4O2QSeckTyAg9vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xQYCJa2D; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E19651F000E9;
	Wed,  1 Jul 2026 10:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782901543;
	bh=C7zV9GY5gNgVzaxV40iTUoOhY2WdnX6qR6DXnDytM3M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=xQYCJa2DhvX/A6yxHv39gzCJRtVZnl0a04+q597TLj/SC1dpHcW7ryGrUdMXaiGo2
	 YXZj6qkgHJtzTDYJPZYRRyF/nYGz3G//EmtWYW6f9YVJIXR9lju6Klg4JlqjAUFait
	 L7vm+/Qmhvey2YRW/sqxTJfT+QFHy28nPYOn7LtA=
Date: Wed, 1 Jul 2026 12:25:40 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Sascha Grunert <sgrunert@redhat.com>
Cc: linux-usb@vger.kernel.org, valentina.manea.m@gmail.com,
	shuah@kernel.org, i@zenithal.me, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/2] usbip: block SET_INTERFACE for isoc alt settings
Message-ID: <2026070107-estrogen-semantic-31a4@gregkh>
References: <20260701101826.894848-1-sgrunert@redhat.com>
 <20260701101826.894848-3-sgrunert@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701101826.894848-3-sgrunert@redhat.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270131-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sgrunert@redhat.com,m:linux-usb@vger.kernel.org,m:valentina.manea.m@gmail.com,m:shuah@kernel.org,m:i@zenithal.me,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:valentinamaneam@gmail.com,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,zenithal.me];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 27F956EC21A

On Wed, Jul 01, 2026 at 12:18:26PM +0200, Sascha Grunert wrote:
> USB/IP cannot forward isochronous transfers. When the client activates
> an alt setting with isoc endpoints, the transfers fail with -EPROTO and
> the resulting usb_clear_halt cascade disconnects the device.
> 
> Intercept SET_INTERFACE in tweak_set_interface_cmd() and fake success
> when the target alt setting contains isoc endpoints, keeping the device
> at alt 0.
> 
> Tested with a Turtle Beach Velocity One Flight yoke (10f5:7001)
> forwarded to a VM via USB/IP, which previously disconnect-looped every
> few seconds and now stays connected.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Sascha Grunert <sgrunert@redhat.com>

What commit id does this fix?

> ---
>  drivers/usb/usbip/stub_rx.c | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/drivers/usb/usbip/stub_rx.c b/drivers/usb/usbip/stub_rx.c
> index d0e3d3f..f323b48 100644
> --- a/drivers/usb/usbip/stub_rx.c
> +++ b/drivers/usb/usbip/stub_rx.c
> @@ -100,6 +100,28 @@ static int tweak_clear_halt_cmd(struct urb *urb)
>  	return ret;
>  }
>  
> +static bool altsetting_has_isoc(struct usb_device *udev, __u16 interface,
> +				__u16 alternate)
> +{
> +	struct usb_interface *intf;
> +	struct usb_host_interface *alt;
> +	int i;
> +
> +	intf = usb_ifnum_to_if(udev, interface);
> +	if (!intf)
> +		return false;
> +
> +	alt = usb_altnum_to_altsetting(intf, alternate);
> +	if (!alt)
> +		return false;
> +
> +	for (i = 0; i < alt->desc.bNumEndpoints; i++) {
> +		if (usb_endpoint_xfer_isoc(&alt->endpoint[i].desc))
> +			return true;
> +	}
> +	return false;
> +}
> +
>  static int tweak_set_interface_cmd(struct urb *urb)
>  {
>  	struct usb_ctrlrequest *req;
> @@ -111,6 +133,20 @@ static int tweak_set_interface_cmd(struct urb *urb)
>  	alternate = le16_to_cpu(req->wValue);
>  	interface = le16_to_cpu(req->wIndex);
>  
> +	/*
> +	 * USB/IP cannot forward isochronous transfers.  If the requested
> +	 * alt setting activates isochronous endpoints, pretend the switch
> +	 * succeeded without touching the device.  This prevents the
> +	 * cascade of failed isoc URBs that leads to a device disconnect.
> +	 */
> +	if (alternate != 0 && altsetting_has_isoc(urb->dev, interface,
> +						  alternate)) {
> +		dev_info(&urb->dev->dev,
> +			 "usb_set_interface blocked: inf %u alt %u (isoc)\n",
> +			 interface, alternate);

Why is this not an error?  And if a user sees this, what can they do
about it?

> +		return 0;

Why isn't this an error?

thanks,

greg k-h

