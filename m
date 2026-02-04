Return-Path: <stable+bounces-213350-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iIEKHnHXgml5cQMAu9opvQ
	(envelope-from <stable+bounces-213350-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 06:21:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2532BE1E9D
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 06:21:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BF4EE3015849
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 05:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6305356A1F;
	Wed,  4 Feb 2026 05:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="I28tFzjC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7343431BCAE;
	Wed,  4 Feb 2026 05:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770182501; cv=none; b=HaWXQZrvse5Al0ecLdyyOK+raiFgDSbL+Hsnq61/UuWlcxiI45+m3z2H0JpK7L/rLlWa0T+Q2jxI1U9lvvfz4lmNFjohvbee95OJqdgmyBXBjc+KPrBp/eRKYML0hho83T/X/Hg3JZ5OzyFtCGO94XJG/isM4u1PoQPqlB3ww1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770182501; c=relaxed/simple;
	bh=6T+Q+snv83Lq/o2B97GAk1EUnXxhea2+cmBgwylekjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=twOdYb+qeqStYs1lp1DP+5Uh9Fg5a3JpO4frHK5JyLayLrVN9YyCmqEHM+3HqnwFJxo1TaoPKVKTfwkzhRCN9jUaUPqJw8jNj+xzGwqGFe+d74zjCafFpLC7vHnJX8AfNaAlpeSQcRUsAe1N1+h/Z01rWBFTcDvJFLc64Mz+J50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=I28tFzjC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F6F4C4CEF7;
	Wed,  4 Feb 2026 05:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770182501;
	bh=6T+Q+snv83Lq/o2B97GAk1EUnXxhea2+cmBgwylekjM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I28tFzjClOF5i7r1K38160PRvLL0HVeelkisbujYu7leyunDTVWjJOGbKKc8SzTnp
	 Bw6dO+7dJ+X0MEHj1IgZxLDxyoflUgenpXRlsSd71FUCeVg6SxKxIc1WNnQb7Wqxoa
	 upE0BGJmiBIBQVf4Ntp1i+3VJdKvZNAZhiD7xYB4=
Date: Wed, 4 Feb 2026 06:21:37 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Tomasz =?utf-8?Q?Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
Cc: jikos@kernel.org, bentiss@kernel.org, sashal@kernel.org,
	oleg@makarenk.ooo, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] HID: pidff: Fix condition effect bit clearing
Message-ID: <2026020430-evergreen-unsubtle-7c48@gregkh>
References: <20260203174241.2863219-1-tomasz.pakula.oficjalny@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260203174241.2863219-1-tomasz.pakula.oficjalny@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-213350-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	SEM_URIBL_FRESH15_UNKNOWN_FAIL(0.00)[linuxfoundation.org:query timed out];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 2532BE1E9D
X-Rspamd-Action: no action

On Tue, Feb 03, 2026 at 06:42:41PM +0100, Tomasz Pakuła wrote:
> As reported by MPDarkGuy on discord, NULL pointer dereferences were
> happening because not all the conditional effects bits were cleared.
> 
> Properly clear all conditional effect bits from ffbit
> 
> Signed-off-by: Tomasz Pakuła <tomasz.pakula.oficjalny@gmail.com>
> ---
> 
> Urgent for 6.19 rc period and backports for 6.18
> 
>  drivers/hid/usbhid/hid-pidff.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hid/usbhid/hid-pidff.c b/drivers/hid/usbhid/hid-pidff.c
> index a4e700b40ba9..56d6af39ba81 100644
> --- a/drivers/hid/usbhid/hid-pidff.c
> +++ b/drivers/hid/usbhid/hid-pidff.c
> @@ -1452,10 +1452,13 @@ static int pidff_init_fields(struct pidff_device *pidff, struct input_dev *dev)
>  		hid_warn(pidff->hid, "unknown ramp effect layout\n");
>  
>  	if (PIDFF_FIND_FIELDS(set_condition, PID_SET_CONDITION, 1)) {
> -		if (test_and_clear_bit(FF_SPRING, dev->ffbit)   ||
> -		    test_and_clear_bit(FF_DAMPER, dev->ffbit)   ||
> -		    test_and_clear_bit(FF_FRICTION, dev->ffbit) ||
> -		    test_and_clear_bit(FF_INERTIA, dev->ffbit))
> +		bool test = false;
> +
> +		test |= test_and_clear_bit(FF_SPRING, dev->ffbit);
> +		test |= test_and_clear_bit(FF_DAMPER, dev->ffbit);
> +		test |= test_and_clear_bit(FF_FRICTION, dev->ffbit);
> +		test |= test_and_clear_bit(FF_INERTIA, dev->ffbit);
> +		if (test)
>  			hid_warn(pidff->hid, "unknown condition effect layout\n");
>  	}
>  
> -- 
> 2.52.0
> 
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

