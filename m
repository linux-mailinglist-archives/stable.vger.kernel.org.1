Return-Path: <stable+bounces-230650-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cF3uB/l1xmlFKgUAu9opvQ
	(envelope-from <stable+bounces-230650-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 13:20:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E2D73441DA
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 13:20:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2EEB43001CD4
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 12:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B25039B4A3;
	Fri, 27 Mar 2026 12:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="EcLJ95J9"
X-Original-To: stable@vger.kernel.org
Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7D4396D0F
	for <stable@vger.kernel.org>; Fri, 27 Mar 2026 12:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774613982; cv=none; b=smelaIuL9IPZOt2SlWnfJTkLGI0GVOztYINzOtGYJUf8NQtaJzWg2AyqXEgIh4GGQ44YWIZ+ksFZcAJTIUlcPqG/3Y5AyZlSTUbvtnYptG8gbTIXMJ5oU9fLHW8CEJSnaPrwC2mDwuYEbGCw0NgU4N0oerbaSzKky4YnbcnjFQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774613982; c=relaxed/simple;
	bh=nXO58KgcOSFD5NXL3UaqWfOGuPdY+H+Uby+ffFErYcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tpMbotZ58WY4V3PS5BlTIOAo7k5rALT0HP5HZBwL82I0yySPBjY17Yw7gIzRnACgMWHzQIF8oZXbB6DwJ4NJTrpUZXGSSyj09+5xM+0qjpE7A2iszRhiNx6TXqPcMzBm8OrC+iFEgMhG0NhJsHv7QgDSOQ8GSXgDX/waRWO/vZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=EcLJ95J9; arc=none smtp.client-ip=212.77.101.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 36376 invoked from network); 27 Mar 2026 13:19:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1774613973; bh=+9KIb0T+WT9OzqTMOwo1n0HvVm6k3ENENUEgwuOw2DU=;
          h=From:To:Cc:Subject;
          b=EcLJ95J9NQpAYhH4N7sr508RLabGwlNpO0mS2QVjBSsDT1qglBae+nJsnE4aG1HYl
           SsOnbOA7KIAQLUyxDcXcawj9FTl7L5sFt5so3h/CFw59+X1+RBk0bKmW0iDSttUI3P
           vNi1ZqZbRg9Nqx7pv2G5nCwMc9b66HU58sb6n5G0dIlmNihT0ApoyrkrdYy4z1Jeb5
           sUNFgzQO7GK4F1uWDIVuiwP3olfLdx1kNm8FHkHSm0096Si6YwGvBv0+x39EGXV3iQ
           WbIRE8/3cncLico2pZcrLjDOCRje9btq9162yHa0OSwU1um0El0SCBTFG8Tk+DjIv/
           l4Wh6feTpX89Q==
Received: from 77-236-5-223.static.play.pl (HELO localhost) (stf_xl@wp.pl@[77.236.5.223])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with TLS_AES_256_GCM_SHA384 encrypted SMTP
          for <johan@kernel.org>; 27 Mar 2026 13:19:33 +0100
Date: Fri, 27 Mar 2026 13:19:33 +0100
From: Stanislaw Gruszka <stf_xl@wp.pl>
To: Johan Hovold <johan@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Vishal Thanki <vishalthanki@gmail.com>
Subject: Re: [PATCH v2] wifi: rt2x00usb: fix devres lifetime
Message-ID: <20260327121933.GC16800@wp.pl>
References: <20260327113219.1313748-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327113219.1313748-1-johan@kernel.org>
X-WP-MailID: bd41d97f0885404bb4e168523c1c8c2c
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [gSMR]                               
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[wp.pl,none];
	R_DKIM_ALLOW(-0.20)[wp.pl:s=20241105];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230650-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[wp.pl];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stf_xl@wp.pl,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[wp.pl:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1E2D73441DA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 27, 2026 at 12:32:19PM +0100, Johan Hovold wrote:
> USB drivers bind to USB interfaces and any device managed resources
> should have their lifetime tied to the interface rather than parent USB
> device. This avoids issues like memory leaks when drivers are unbound
> without their devices being physically disconnected (e.g. on probe
> deferral or configuration changes).
> 
> Fix the USB anchor lifetime so that it is released on driver unbind.
> 
> Fixes: 8b4c0009313f ("rt2x00usb: Use usb anchor to manage URB")
> Cc: stable@vger.kernel.org	# 4.7
> Cc: Vishal Thanki <vishalthanki@gmail.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>
Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>

> ---
>  drivers/net/wireless/ralink/rt2x00/rt2x00usb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00usb.c b/drivers/net/wireless/ralink/rt2x00/rt2x00usb.c
> index 83d00b6baf64..174d89b0b1d7 100644
> --- a/drivers/net/wireless/ralink/rt2x00/rt2x00usb.c
> +++ b/drivers/net/wireless/ralink/rt2x00/rt2x00usb.c
> @@ -826,7 +826,7 @@ int rt2x00usb_probe(struct usb_interface *usb_intf,
>  	if (retval)
>  		goto exit_free_device;
>  
> -	rt2x00dev->anchor = devm_kmalloc(&usb_dev->dev,
> +	rt2x00dev->anchor = devm_kmalloc(&usb_intf->dev,
>  					sizeof(struct usb_anchor),
>  					GFP_KERNEL);
>  	if (!rt2x00dev->anchor) {
> -- 
> 2.52.0
> 

