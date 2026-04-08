Return-Path: <stable+bounces-235280-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WM+SNq7B1mn+HwgAu9opvQ
	(envelope-from <stable+bounces-235280-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 22:59:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC423C3EA2
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 22:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C921302C6D2
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 20:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493D333F36B;
	Wed,  8 Apr 2026 20:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yaina.de header.i=@yaina.de header.b="wVIkMRK2"
X-Original-To: stable@vger.kernel.org
Received: from mail.yaina.de (yaina.de [95.216.117.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC0B3314C5;
	Wed,  8 Apr 2026 20:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.216.117.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775681958; cv=none; b=F9gIeOj88+FiYKwiI0iWJzEu7RRpbA3PSlEKpTZE8IvglITzG/2NyEHSQa5jQzy28IIhBdeT1RC+oMbMccPv7VGgrmiMWp5/eBNPtI9YiMl9AHR7cZS73xwJVB0KB9Zoub6YcwhNthIOjTDt09zddNIZP9I4fwmR3Fld901awJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775681958; c=relaxed/simple;
	bh=oGn7Kg1BTlvOaR2h07xr9FmAxNwd6XMBe9l3iunfQfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rbdWE8/NJ0r/1gS56GPH9bx/KF+2VTTCsV1b87dUMNDNQK2vyyGEJ2hAK9Xct7CGoD+7fxNA+Dn7mMNCisU+vV3E2cWYsN6II9RrheM0FoCRGu2Ow49YJ/uF2EZQqYHIMt1sao7q9JqZf2XGX5k8EfKsrFN8wW2G8nh7Bozy678=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yaina.de; spf=pass smtp.mailfrom=yaina.de; dkim=pass (1024-bit key) header.d=yaina.de header.i=@yaina.de header.b=wVIkMRK2; arc=none smtp.client-ip=95.216.117.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yaina.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yaina.de
Received: from lycaon.yaina.de (ip1f118239.dynamic.kabel-deutschland.de [31.17.130.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "lykos.yaina.de", Issuer "CAcert Class 3 Root" (not verified))
	by mail.yaina.de (Postfix) with ESMTPSA id 3EF1C7CDEEC7;
	Wed, 08 Apr 2026 22:51:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yaina.de; s=mail;
	t=1775681466;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lVzdl6wAk2jhIhIak1BJv8WP6VL8FEB4gR39X/vx0Ws=;
	b=wVIkMRK2VRy1EHYUzXyx/orrB2v37wCr62ea61LBtDR+gFni68Hnj763SBZhmfzoFCZx8M
	xGxyS6NCijuxoYOLtARCMrlIwO0GTb6jPjit9dnLYYWzaF/g/heG6YlartTJptRTuPwupN
	+S069Ec9JZmYRrJ7fr0mEikCX0xcoaE=
Received: by lycaon.yaina.de (Postfix, from userid 500)
	id 81CC4300E40; Wed, 08 Apr 2026 22:51:05 +0200 (CEST)
Date: Wed, 8 Apr 2026 22:51:05 +0200
From: Joerg Reuter <jreuter@yaina.de>
To: Mashiro Chen <mashiro.chen@mailbox.org>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	linux-hams@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net 2/2] net: hamradio: scc: validate bufsize in
 SIOCSCCSMEM ioctl
Message-ID: <ada_uT5lwgXA3nK9@yaina.de>
References: <20260408172358.281186-1-mashiro.chen@mailbox.org>
 <20260408172358.281186-3-mashiro.chen@mailbox.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260408172358.281186-3-mashiro.chen@mailbox.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[yaina.de:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[yaina.de:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235280-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[yaina.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jreuter@yaina.de,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,yaina.de:dkim,yaina.de:mid,yaina.de:url]
X-Rspamd-Queue-Id: 3FC423C3EA2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

Am Thu, Apr 09, 2026 at 01:23:58AM +0800 schrieb Mashiro Chen:

> If a privileged user (CAP_SYS_RAWIO) sets bufsize to 0, the receive
> interrupt handler later calls dev_alloc_skb(0) and immediately writes
> a KISS type byte via skb_put_u8() into a zero-capacity socket buffer,
> corrupting the adjacent skb_shared_info region.

Oops, that's unfortunate.

> The scc.c comment already states the buffer must not exceed 4096 bytes,
> but this limit is never enforced.

That was a limit 30 years ago when we couldn't have skbs larger than one
page.

I'm not sure if anyone is actually using AX.25 jumbograms with a Zilog SCC
controller, that doesn't make much sense to me. But maybe someone out there
is indeed running IP over huge AX.25 UI frames, thus I'm not a fan of
enforcing an upper limit either. It's hamradio, you're supposed to tinker.

I'm okay with a mininum size of 16, of course.

73,
    Joerg

-- 
Joerg Reuter                                    http://yaina.de/jreuter
And I make my way to where the warm scent of soil fills the evening air. 
Everything is waiting quietly out there....                 (Anne Clark)

