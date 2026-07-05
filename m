Return-Path: <stable+bounces-271990-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wm5RE9ugSWrX4wAAu9opvQ
	(envelope-from <stable+bounces-271990-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 05 Jul 2026 02:10:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E66708AEE
	for <lists+stable@lfdr.de>; Sun, 05 Jul 2026 02:10:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=JrcY2ZWN;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271990-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-271990-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0F3E63009164
	for <lists+stable@lfdr.de>; Sun,  5 Jul 2026 00:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2578213FEE;
	Sun,  5 Jul 2026 00:09:58 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA0EA59;
	Sun,  5 Jul 2026 00:09:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783210197; cv=none; b=rUEZg+BhmTDoJ9hyBtU13AcYAvpfUR3SRPPwNU/zltBl+YCANFu0WlD7+7Y0Um2JhZW3rxU7wF8JzByA9hQwgTDzDgvlY3n0KBHi+Urq+TSsZiv7wQG21tpL05a02FDta/OqnmAcb6mSq0Wa4XV9qm/LUdzyKcyeHF2JsUGXV0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783210197; c=relaxed/simple;
	bh=P8z/eVTREoSDrG789SsiktPt95kAcoPIn5gKBLPriOg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E/PPBIwNaBMmywTMcqnrJbEml1mGqCEZIHukgs0HN9r66h9QRvd16S18yldXEPoJpFRfmAx/+8lY9Zt3M4I8pAmSa03eo6YGqPPUY1OQHBdni7prtGw+M07Mj4tGIuubrkXBaJqAZZa3x1ZMzk8YKCUjyjeqPlTOyREAv3XdcZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JrcY2ZWN; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 093701F000E9;
	Sun,  5 Jul 2026 00:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783210196;
	bh=LX6xjD/GCMPQ0Y2u4ed0iKp7X4rlArJKkKIPu+zieKg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=JrcY2ZWNVg97hiA2goSG/RpNk7UNrZGijKJWoFc51WDa5n6uOpR0WtmQyQh7HY6+s
	 w8oK/RmRdnrs0pTnIqlyYWwEG0lxq/wkaHDehMBCTYBaCC7N30WWH+CsKq6bMAKOBW
	 LCadaFYaQ2izZPIwlmrezV3ba0PS2H43pLGK5HGhcWJJi0NFf2jQMsxhWglUhee7LE
	 +odg30qr/1HXC2z0pvYrsPhT6clqwk/9+Wt/bxurJH+AuSYpLD27Z8MEtzbWzr+3Ls
	 g7BZkU9H8Weucgw5+t4C/cz0uwg3GPlM/AUuJnVS92fvSJi20iZ1O6YOVOmwY1iOQL
	 vaPrF+dgoo1tw==
Date: Sun, 5 Jul 2026 01:09:51 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Biren Pandya <birenpandya@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Linus Walleij
 <linusw@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: accel: kxsd9: fix use-after-free on remove
Message-ID: <20260705010951.7a2b298e@jic23-huawei>
In-Reply-To: <20260703-kxsd9-v3-proper-v1-1-e9f08af25d7e@gmail.com>
References: <20260703-kxsd9-v3-proper-v1-0-e9f08af25d7e@gmail.com>
	<20260703-kxsd9-v3-proper-v1-1-e9f08af25d7e@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[jic23@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:birenpandya@gmail.com,m:dlechner@baylibre.com,m:nuno.sa@analog.com,m:andy@kernel.org,m:linusw@kernel.org,m:linux-iio@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271990-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jic23@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[jic23-huawei:mid,vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C8E66708AEE

On Fri, 03 Jul 2026 22:53:22 +0530
Biren Pandya <birenpandya@gmail.com> wrote:

> The kxsd9 driver currently calls iio_triggered_buffer_cleanup() before
> iio_device_unregister() in the remove() function. This order creates a
> race condition where userspace can still access sysfs or ioctl interfaces
> while the triggered buffers are being torn down, potentially leading to
> a use-after-free.
> 
> Fix this by swapping the cleanup order. Unregister the IIO device first
> to guarantee that all userspace interfaces are destroyed and no new
> accesses can occur before cleaning up the triggered buffers.
> 
> This vulnerability was flagged by the Sashiko automated review system.
> 
> Link: https://sashiko.dev/#/patchset/20260621193036.78549-2-birenpandya@gmail.com
> Fixes: 9a9a369d6178 ("iio: accel: kxsd9: Deploy system and runtime PM")
That tag touches the pm runtime stuff just below, but nothing to do with the
bug reported here.

Should be:
Fixes: 0427a106a98a ("iio: accel: kxsd9: Add triggered buffer handling")

> Cc: stable@vger.kernel.org
> Signed-off-by: Biren Pandya <birenpandya@gmail.com>
> ---
>  drivers/iio/accel/kxsd9.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/kxsd9.c b/drivers/iio/accel/kxsd9.c
> index 7ac885d94d7f4..27adcdd312014 100644
> --- a/drivers/iio/accel/kxsd9.c
> +++ b/drivers/iio/accel/kxsd9.c
> @@ -478,8 +478,8 @@ void kxsd9_common_remove(struct device *dev)
>  	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>  	struct kxsd9_state *st = iio_priv(indio_dev);
>  
> -	iio_triggered_buffer_cleanup(indio_dev);
>  	iio_device_unregister(indio_dev);
> +	iio_triggered_buffer_cleanup(indio_dev);
>  	pm_runtime_get_sync(dev);
>  	pm_runtime_put_noidle(dev);
>  	pm_runtime_disable(dev);
> 


