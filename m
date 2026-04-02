Return-Path: <stable+bounces-232926-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SB7VBVYhzmnElAYAu9opvQ
	(envelope-from <stable+bounces-232926-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 09:57:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC94385825
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 09:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 946A43019F18
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 07:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D60B363C65;
	Thu,  2 Apr 2026 07:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="g8aXiaFB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7F631F9B8;
	Thu,  2 Apr 2026 07:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775115931; cv=none; b=oY+MEW2Z0Yh2ucQvk4TlyzKTtJBEgV8TgXHPSIboJCrE7c1A0UnteZj6gbtlEuAlY5KOhvxw/fzZfV8vEC2102rEAm3WZ4D/VSHROCtXnZqNA2b1iiFBYuy+qHpZNwoUQrcVfpOdjDstG5FH+nkHyNRelpZW7CMQvME63gzTbaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775115931; c=relaxed/simple;
	bh=L9PtbiHVcjP1nfTjjXupJxIUPL/K74latiizMZHOzk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oCU20HgMn3sf2/b78fj76YJGt7uB1PAQDOhRWH3QA0l9sYyd0CzYzPnNJW2q2zSL5oD7ifo5CUqdK6Euuz6eg33MrMtO5PKp9o+AxCaKxdtdRqbuCInv7hxYHJy0ByLX23ckgWRUVxQak9Dd65J0fivgw6IeA7qwhfei5MM25JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=g8aXiaFB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73E52C19423;
	Thu,  2 Apr 2026 07:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775115930;
	bh=L9PtbiHVcjP1nfTjjXupJxIUPL/K74latiizMZHOzk0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g8aXiaFBflMZSSIMOvUkPQT6eLGTUxFv6rtaRDIjUK7GRYqPS/ycnXwKOb0dYGT0F
	 1Sw3HmGKgrXt/oMK07s/DvI81FBv0h5Pg2xNkPe5VJPi0lQmxDJPsfre4W+vuJQBWa
	 XOWeeSMeMpzulWFRMbiyt6uo3YNDD4UvBcB8UYpw=
Date: Thu, 2 Apr 2026 09:45:28 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Nathan Rebello <nathan.c.rebello@gmail.com>, linux-usb@vger.kernel.org,
	addcontent08@gmail.com, kyungtae.kim@dartmouth.edu,
	stable@vger.kernel.org
Subject: Re: [PATCH] usbip: vhci: reject RET_SUBMIT with inflated
 number_of_packets
Message-ID: <2026040220-defeat-jokester-22dc@gregkh>
References: <20260327064449.735-1-nathan.c.rebello@gmail.com>
 <34da1928-f6e7-43fb-a436-6bc02e262698@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34da1928-f6e7-43fb-a436-6bc02e262698@linuxfoundation.org>
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-232926-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,dartmouth.edu];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.990];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email]
X-Rspamd-Queue-Id: 6DC94385825
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 31, 2026 at 05:17:44PM -0600, Shuah Khan wrote:
> On 3/27/26 00:44, Nathan Rebello wrote:
> > When a USB/IP client receives a RET_SUBMIT response,
> > usbip_pack_ret_submit() unconditionally overwrites
> > urb->number_of_packets from the network PDU. This value is
> > subsequently used as the loop bound in usbip_recv_iso() and
> > usbip_pad_iso() to iterate over urb->iso_frame_desc[], a flexible
> > array whose size was fixed at URB allocation time based on the
> > *original* number_of_packets from the CMD_SUBMIT.
> > 
> > A malicious USB/IP server can set number_of_packets in the response
> > to a value larger than what was originally submitted, causing a heap
> > out-of-bounds write when usbip_recv_iso() writes to
> > urb->iso_frame_desc[i] beyond the allocated region.
> > 
> > KASAN confirmed this with kernel 7.0.0-rc5:
> > 
> >    BUG: KASAN: slab-out-of-bounds in usbip_recv_iso+0x46a/0x640
> >    Write of size 4 at addr ffff888106351d40 by task vhci_rx/69
> > 
> >    The buggy address is located 0 bytes to the right of
> >     allocated 320-byte region [ffff888106351c00, ffff888106351d40)
> > 
> > The server side (stub_rx.c) and gadget side (vudc_rx.c) already
> > validate number_of_packets in the CMD_SUBMIT path since commits
> > c6688ef9f297 ("usbip: fix stub_rx: harden CMD_SUBMIT path to handle
> > malicious input") and b78d830f0049 ("usbip: fix vudc_rx: harden
> > CMD_SUBMIT path to handle malicious input"). The server side validates
> > against USBIP_MAX_ISO_PACKETS because no URB exists yet at that point.
> > On the client side we have the original URB, so we can use the tighter
> > bound: the response must not exceed the original number_of_packets.
> > 
> > This mirrors the existing validation of actual_length against
> > transfer_buffer_length in usbip_recv_xbuff(), which checks the
> > response value against the original allocation size.
> > 
> > Kelvin Mbogo's series ("usb: usbip: fix integer overflow in
> > usbip_recv_iso()", v2) hardens the receive-side functions themselves;
> > this patch complements that work by catching the bad value at its
> > source -- in usbip_pack_ret_submit() before the overwrite -- and
> > using the tighter per-URB allocation bound rather than the global
> > USBIP_MAX_ISO_PACKETS limit.
> > 
> > Fix this by checking rpdu->number_of_packets against
> > urb->number_of_packets in usbip_pack_ret_submit() before the
> > overwrite. On violation, clamp to zero so that usbip_recv_iso() and
> > usbip_pad_iso() safely return early.
> > 
> > Fixes: 0775a9cbc798 ("staging: usbip: vhci extension: modifications to the client side")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Nathan Rebello <nathan.c.rebello@gmail.com>
> > ---
> >   drivers/usb/usbip/usbip_common.c | 13 ++++++++++++-
> >   1 file changed, 12 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/usb/usbip/usbip_common.c b/drivers/usb/usbip/usbip_common.c
> > --- a/drivers/usb/usbip/usbip_common.c
> > +++ b/drivers/usb/usbip/usbip_common.c
> > @@ -470,7 +470,18 @@ static void usbip_pack_ret_submit(struct usbip_header *pdu, struct urb *urb,
> >   		urb->status		= rpdu->status;
> >   		urb->actual_length	= rpdu->actual_length;
> >   		urb->start_frame	= rpdu->start_frame;
> > -		urb->number_of_packets = rpdu->number_of_packets;
> > +		/*
> > +		 * The number_of_packets field determines the length of
> > +		 * iso_frame_desc[], which is a flexible array allocated
> > +		 * at URB creation time. A response must never claim more
> > +		 * packets than originally submitted; doing so would cause
> > +		 * an out-of-bounds write in usbip_recv_iso() and
> > +		 * usbip_pad_iso(). Clamp to zero on violation so both
> > +		 * functions safely return early.
> > +		 */
> > +		if (rpdu->number_of_packets < 0 ||
> > +		    rpdu->number_of_packets > urb->number_of_packets)
> > +			rpdu->number_of_packets = 0;
> > +		urb->number_of_packets = rpdu->number_of_packets;
> >   		urb->error_count	= rpdu->error_count;
> >   	}
> >   }
> 
> Look good to me.
> 
> Acked-by: Shuah Khan <skhan@linuxfoundation.org>

This patch is somehow corrupted and can not be applied at all.  Nathan,
how did you generate it?

You can tell something is wrong as it shows you removing, and then
adding, the same line, which is a huge hint something went wrong.

Can you regenerate this against my latest usb-testing branch and resend?

thanks,

greg k-h

