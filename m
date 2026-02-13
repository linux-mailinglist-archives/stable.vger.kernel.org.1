Return-Path: <stable+bounces-216078-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GOO8OAklj2lNKAEAu9opvQ
	(envelope-from <stable+bounces-216078-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 14:20:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B4C01364CD
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 14:20:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6D40A3009F13
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 13:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA62B35E556;
	Fri, 13 Feb 2026 13:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Z1cEhEad"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CAA319601;
	Fri, 13 Feb 2026 13:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770988802; cv=none; b=RVQEOoCsq0v1iYYBYBpVsjStzrUxaAc239zT0UqHFZWGhDiIbNKdq2+mnEl2+N0b8IpuCRgw38+w/DY0TUo+HJleJb2DXfVFoDwOX/Hj/lv/BxhDTE4A5wmyBJ30GtI0xkvLpuJDNt9H5VGrSJcPvsF7ob2/gORTCm7KO1/gXgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770988802; c=relaxed/simple;
	bh=M3NPNMesbmaWIrMjsJGA1oz5Jp/DFXLQsry7psg4Xww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IC56WYOqaLQbqHyrCJU563YA3lDqNi5wHe7ArK/QuZAcd37W+5tp0zAexczN7Ia7/FNrsCpk+1Zuz7UFPieeQDEunK3NRG6LZJc9M2ZX1UBf4r+hWpWFENrZo0y5pa5CIPpQvm0mP0GuDbW/KptZqGOaOJv3DVSGs0/LDpOb/+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Z1cEhEad; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7090DC116C6;
	Fri, 13 Feb 2026 13:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770988802;
	bh=M3NPNMesbmaWIrMjsJGA1oz5Jp/DFXLQsry7psg4Xww=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z1cEhEadAcPndf+8KgQGX8IN7jCbbmBz5qrrlbDL4pzGAOyBwjYKfd4dhi0W2fIJU
	 1ZJP/VliCV6uguvhzydujEulh0yDmfuIbHiDdqokLtciZKoHmzPlDIx7VQ0e4ejwMb
	 AcCz5Re2/9ddSCelcyn6sGSGpFU9hh6byTtVeClA=
Date: Fri, 13 Feb 2026 14:19:58 +0100
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: "Igor Klochko (Nokia)" <igor.klochko@nokia.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Philippe Belet (Nokia)" <philippe.belet@nokia.com>
Subject: Re: [RESEND PATCH] uio: fix uio_unregister_device
Message-ID: <2026021333-primarily-nest-a851@gregkh>
References: <AM9PR07MB7204666518940F3C74372D7A8D61A@AM9PR07MB7204.eurprd07.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM9PR07MB7204666518940F3C74372D7A8D61A@AM9PR07MB7204.eurprd07.prod.outlook.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	FROM_DN_EQ_ADDR(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-216078-lists,stable=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nokia.com:email,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 4B4C01364CD
X-Rspamd-Action: no action

On Fri, Feb 13, 2026 at 01:01:45PM +0000, Igor Klochko (Nokia) wrote:
> When uio devices are created end removed in parallel, then we sometimes
> encounter kernel traces along the following lines:
> 
>   sysfs: cannot create duplicate filename '/class/uio/uio899'
> 
> which stem from:
> 
>   sysfs_create_link+0x24/0x50
>   device_add+0x2f0/0x780
>   __uio_register_device+0x18c/0x550
> 
> The sysfs directory creation is performed synchronously as part of the
> device_add call. The high level sequence for uio registration is:
> 
>   1. uio_get_minor (idr call, in critical section)
>   2. device_add (leads to sysfs directory)
>   3. manage attributes (popuplates part of the sysfs directory)
> 
> For unregistration we have by default the following flow:
> 
>   1. clean-up attributes
>   2. uio_free_minor (idr call, in critical section)
>   3. device_unregister (cleans up sysfs directory)
> 
> This creates a racing problem when we are in parallel creating and removing uio
> devices. The uio-minor that is freed when calling uio_free_minor can be claimed
> by a subsequent uio_get_minor call. The problem is that the device_addi flow
> can end up triggered, leading to a sysfs directory creation; while the
> device_unregister flow has not yet cleaned up the sysfs directory.
> 
> This patch cleans up this problem by mirroring the registration and
> unregistration flow correctly.
> After this patch, the unregistration flow becomes:
> 
>   1. clean-up attributes
>   2. device_unregister
>   3. uio_free_minor
> 
> Fixes: 0c9ae0b86050 ("uio: Fix use-after-free in uio_open")
> Cc: stable@vger.kernel.org
> Signed-off-by: Philippe Belet <philippe.belet@nokia.com>
> Reviewed-by: Igor Klochko <igor.klochko@nokia.com>
> 
> diff --git a/drivers/uio/uio.c b/drivers/uio/uio.c
> index fa0d4e6aee16..5dd137a85576 100644
> --- a/drivers/uio/uio.c
> +++ b/drivers/uio/uio.c
> @@ -1125,8 +1125,8 @@ void uio_unregister_device(struct uio_info *info)
>         wake_up_interruptible(&idev->wait);
>         kill_fasync(&idev->async_queue, SIGIO, POLL_HUP);
> 
> -       uio_free_minor(minor);
>         device_unregister(&idev->dev);
> +       uio_free_minor(minor);
> 
>         return;
>  }
> 

This is not a [RESEND] but rather a v2.

Please document what changed from the previous version below the ---
line.

Try again as a v3?

thanks,

greg k-h

