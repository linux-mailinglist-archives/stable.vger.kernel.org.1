Return-Path: <stable+bounces-242439-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oL2/BVu09Gk4DwIAu9opvQ
	(envelope-from <stable+bounces-242439-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 16:10:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 689E54AD1D3
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 16:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 24F0F3009156
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 14:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9521B3B0AF7;
	Fri,  1 May 2026 14:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="pDKpvP1y"
X-Original-To: stable@vger.kernel.org
Received: from extorris.mess.org (extorris.mess.org [92.243.27.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035E738DD3
	for <stable@vger.kernel.org>; Fri,  1 May 2026 14:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.243.27.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777644568; cv=none; b=iGYwpoyyOyd+hp7+gP1yJx1XDA4IYk0b7U0upStQH9hH7FzP+U0FCYPk1HczyhBDfhfHrZTj8Pi24VVnGSqhwGpSk1XsEiMO+dLx0/hURpn2BPDk5vkmX6iyVFJZhbcUUZTvfC1RTeiSO0XF3aYWoTgNh2DwiH+WbISiKQSCNmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777644568; c=relaxed/simple;
	bh=jUFvUZgj3KEisJ973OH1ALeYdWFVYeipaBP7Kswn4/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L9n7/o7nlrYlVkaVIGjJWh1Bj8a/rui59GAd69XTxno6OlvveveSvd36jly1cyemfJdifM5MbiIYMEtt/T2bQpYgiDDiHoeFEZwSWp1Vlf2HFjzIFa+y2c1K0g0QNj5gJz5RrDRVKLOK3DDMCcUxYest4lpEDNK3X22uh8mMU7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org; spf=pass smtp.mailfrom=mess.org; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=pDKpvP1y; arc=none smtp.client-ip=92.243.27.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1777644564; bh=jUFvUZgj3KEisJ973OH1ALeYdWFVYeipaBP7Kswn4/4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pDKpvP1yH33DRNUgY0AbZg5Vc/rl71z3/Vy1BMOY0HKB8ZutUrwlVzvUpu1C3en9C
	 yZa4M4HzXU5YhtEirBSySoOWhLk2SIZxHhVPYc+rt+uhEwHBurGmKfUC8kaBQ2rwUt
	 kOEsSTU5QKyMEbKqli9Dtzm8rafG7L7RRGp3gdQGLAh2Ip69bclRh3r+xpNjbXJdH/
	 Ft2a+DRCmmEfd6YDZFBbh65xQZpMkpufgT9kbrnHwe8RDbMHP0mCL+JbYGLtUWiJOP
	 HWraOt3J1ZUFSBvdTjVnC1xeoW3/zS8yILtioqafT9JJQA1TLtT1UIMtWCYrZVud3P
	 oQUVv2OAsxQWw==
Received: by extorris.mess.org (Postfix, from userid 1001)
	id D06D040176; Fri, 01 May 2026 15:09:24 +0100 (BST)
Date: Fri, 1 May 2026 15:09:24 +0100
From: sean@mess.org
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Oliver Neukum <oneukum@suse.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>
Subject: Re: [PATCH 7.0.y 2/2] media: rc: ttusbir: respect DMA coherency rules
Message-ID: <afS0FNrqakZ0bnnj@extorris.mess.org>
References: <2026050121-heap-divided-c620@gregkh>
 <20260501131904.3244754-1-sashal@kernel.org>
 <20260501131904.3244754-2-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260501131904.3244754-2-sashal@kernel.org>
X-Rspamd-Queue-Id: 689E54AD1D3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mess.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[mess.org:s=2020];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-242439-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sean@mess.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[mess.org:+];
	TAGGED_RCPT(0.00)[stable,cisco];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Hello,

This commit is broken - please do not merge.

On Fri, May 01, 2026 at 09:19:03AM -0400, Sasha Levin wrote:
> From: Oliver Neukum <oneukum@suse.com>
> 
> [ Upstream commit 50acaad3d202c064779db8dc3d010007347f59c7 ]
> 
> Buffers must not share a cache line with other data structures.
> Allocate separately.
> 
> Fixes: 0938069fa0897 ("[media] rc: Add support for the TechnoTrend USB IR Receiver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Oliver Neukum <oneukum@suse.com>
> Signed-off-by: Sean Young <sean@mess.org>
> Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/media/rc/ttusbir.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/media/rc/ttusbir.c b/drivers/media/rc/ttusbir.c
> index a2a64a860264b..3848ad3a6b85f 100644
> --- a/drivers/media/rc/ttusbir.c
> +++ b/drivers/media/rc/ttusbir.c
> @@ -32,7 +32,7 @@ struct ttusbir {
>  
>  	struct led_classdev led;
>  	struct urb *bulk_urb;
> -	uint8_t bulk_buffer[5];
> +	u8 *bulk_buffer;
>  	int bulk_out_endp, iso_in_endp;
>  	bool led_on, is_led_on;
>  	atomic_t led_complete;
> @@ -186,13 +186,16 @@ static int ttusbir_probe(struct usb_interface *intf,
>  	struct rc_dev *rc;
>  	int i, j, ret;
>  	int altsetting = -1;
> +	u8 *buffer;
>  
>  	tt = kzalloc_obj(*tt);
> +	buffer = kzalloc(5, GFP_KERNEL);
>  	rc = rc_allocate_device(RC_DRIVER_IR_RAW);
> -	if (!tt || !rc) {
> +	if (!tt || !rc || buffer) {

Here buffer will be non-zero and the probe function will fail.

A fix is on the way to master but it's not there yet.

THanks,
Sean
>  		ret = -ENOMEM;
>  		goto out;
>  	}
> +	tt->bulk_buffer = buffer;
>  
>  	/* find the correct alt setting */
>  	for (i = 0; i < intf->num_altsetting && altsetting == -1; i++) {
> @@ -281,8 +284,8 @@ static int ttusbir_probe(struct usb_interface *intf,
>  	tt->bulk_buffer[3] = 0x01;
>  
>  	usb_fill_bulk_urb(tt->bulk_urb, tt->udev, usb_sndbulkpipe(tt->udev,
> -		tt->bulk_out_endp), tt->bulk_buffer, sizeof(tt->bulk_buffer),
> -						ttusbir_bulk_complete, tt);
> +			  tt->bulk_out_endp), tt->bulk_buffer, 5,
> +			  ttusbir_bulk_complete, tt);
>  
>  	tt->led.name = "ttusbir:green:power";
>  	tt->led.default_trigger = "rc-feedback";
> @@ -350,6 +353,7 @@ static int ttusbir_probe(struct usb_interface *intf,
>  		kfree(tt);
>  	}
>  	rc_free_device(rc);
> +	kfree(buffer);
>  
>  	return ret;
>  }
> @@ -373,6 +377,7 @@ static void ttusbir_disconnect(struct usb_interface *intf)
>  	usb_kill_urb(tt->bulk_urb);
>  	usb_free_urb(tt->bulk_urb);
>  	rc_free_device(tt->rc);
> +	kfree(tt->bulk_buffer);
>  	usb_set_intfdata(intf, NULL);
>  	kfree(tt);
>  }
> -- 
> 2.53.0

