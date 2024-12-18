Return-Path: <stable+bounces-105119-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AAB89F5EDE
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 07:53:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BEB218955B5
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 06:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79D00156F55;
	Wed, 18 Dec 2024 06:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FsmOExNF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A326154457;
	Wed, 18 Dec 2024 06:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734504778; cv=none; b=cs5Xt+1J3M7moI15/IioKdY1qZV4hYxQ6QwCVqhBXN5tqQyXZCgnsjHLqFqStl6nPtyzJVuPX7zsIKs50dXwhHuBtEJrUm+qD1liXBTy1nwHlNg5eK+SQYOM7wUBaZvaP66KV/g0IjqZ/c2ybSd8KiEPfKP+H3Jdm3MJQsyCbm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734504778; c=relaxed/simple;
	bh=xFYjZQz9CdV8btbhFZ7g4gXuiGZ44yHRNOXodtxkLh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c6ro7bWo16wl+wtVEyiyTnAJZ9AymNrpwWhsXdc3RKnmbtQsRu84k9FFH/k1QkgCJNOvs95eqVDZ2+TMrGCUyk5zSBgWUudGOXlHvXpRwZL/0cgV8bAYnGOmxSlwLLK/T0Opf1I0cIw/uGeU/3mPYJMm7567bfd37w+bQp/4qCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FsmOExNF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 240D0C4CED0;
	Wed, 18 Dec 2024 06:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734504777;
	bh=xFYjZQz9CdV8btbhFZ7g4gXuiGZ44yHRNOXodtxkLh0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FsmOExNFEAoERRCe2lAm3LhA/W1nJTF5UNzm8DLb/LhfXP5fbr2QEP1+QCQcnKevV
	 +N+H61PNnDxsV1ew5mr0PuhAWCWstp35wGSwdSXduJ/5eVENYtVcw136BEyUtwUiHs
	 8iJrTx3piFixjFbVTrcXeBUhBEAkZLScaAce7VDU=
Date: Wed, 18 Dec 2024 06:31:08 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Selvarasu Ganesan <selvarasu.g@samsung.com>
Cc: quic_jjohnson@quicinc.com, kees@kernel.org, abdul.rahim@myyahoo.com,
	m.grzeschik@pengutronix.de, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, jh0801.jung@samsung.com,
	dh10.jung@samsung.com, naushad@samsung.com, akash.m5@samsung.com,
	rc93.raju@samsung.com, taehyun.cho@samsung.com,
	hongpooh.kim@samsung.com, eomji.oh@samsung.com,
	shijie.cai@samsung.com, alim.akhtar@samsung.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: f_midi: Fixing wMaxPacketSize exceeded
 issue during MIDI bind retries
Message-ID: <2024121845-cactus-geology-8df3@gregkh>
References: <CGME20241208152338epcas5p4fde427bb4467414417083221067ac7ab@epcas5p4.samsung.com>
 <20241208152322.1653-1-selvarasu.g@samsung.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241208152322.1653-1-selvarasu.g@samsung.com>

On Sun, Dec 08, 2024 at 08:53:20PM +0530, Selvarasu Ganesan wrote:
> The current implementation sets the wMaxPacketSize of bulk in/out
> endpoints to 1024 bytes at the end of the f_midi_bind function. However,
> in cases where there is a failure in the first midi bind attempt,
> consider rebinding.

What considers rebinding?  Your change does not modify that.

> This scenario may encounter an f_midi_bind issue due
> to the previous bind setting the bulk endpoint's wMaxPacketSize to 1024
> bytes, which exceeds the ep->maxpacket_limit where configured TX/RX
> FIFO's maxpacket size of 512 bytes for IN/OUT endpoints in support HS
> speed only.
> This commit addresses this issue by resetting the wMaxPacketSize before
> endpoint claim.

resets it to what?  Where did the magic numbers come from?  How do we
know this is now full speed and not high speed?

> 
> Fixes: 46decc82ffd5 ("usb: gadget: unconditionally allocate hs/ss descriptor in bind operation")
> Cc: stable@vger.kernel.org
> Signed-off-by: Selvarasu Ganesan <selvarasu.g@samsung.com>
> ---
>  drivers/usb/gadget/function/f_midi.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/usb/gadget/function/f_midi.c b/drivers/usb/gadget/function/f_midi.c
> index 837fcdfa3840..5caa0e4eb07e 100644
> --- a/drivers/usb/gadget/function/f_midi.c
> +++ b/drivers/usb/gadget/function/f_midi.c
> @@ -907,6 +907,15 @@ static int f_midi_bind(struct usb_configuration *c, struct usb_function *f)
>  
>  	status = -ENODEV;
>  
> +	/*
> +	 * Reset wMaxPacketSize with maximum packet size of FS bulk transfer before
> +	 * endpoint claim. This ensures that the wMaxPacketSize does not exceed the
> +	 * limit during bind retries where configured TX/RX FIFO's maxpacket size
> +	 * of 512 bytes for IN/OUT endpoints in support HS speed only.
> +	 */
> +	bulk_in_desc.wMaxPacketSize = cpu_to_le16(64);
> +	bulk_out_desc.wMaxPacketSize = cpu_to_le16(64);

Where did "64" come from?  How do we know this is full speed?  Later
on in this function the endpoint sizes are set, why set them here to
these small values when you do not know the speed?

Or, if it had failed before, reset the values on the failure, not here
before you start anything up, right?

thanks,

greg k-h

