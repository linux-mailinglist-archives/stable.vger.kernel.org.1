Return-Path: <stable+bounces-242827-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OC+5FrgL+GlWpQIAu9opvQ
	(envelope-from <stable+bounces-242827-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 05:00:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA2C4B8213
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 05:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1F9C930015B8
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 03:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5762F1EA7CE;
	Mon,  4 May 2026 02:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="piQLVzrm"
X-Original-To: stable@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBB3EEBA
	for <stable@vger.kernel.org>; Mon,  4 May 2026 02:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777863598; cv=none; b=dTTFEsxun0dk3LIEmLqeY/3dnCL8rdpCQIZyWfPPq9/8y1xR/dTeSbec3fnz1TFUbx3G9PMAgQ3VRQ6nYr0RBK64ObO1QX/e8SJKjcgrdbTNyq4OyEYQBiuygMRYSCUT1sFUvpdmwQB6ljf4JRven0Axk9fE1m0HRvkDjvdUuyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777863598; c=relaxed/simple;
	bh=XXmU6cYeQVQ60gTnlBLmDNzYMqTQ1wsp5KaUyUFqt8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PWcMY5XMwsbTQ0A9Ym9zCNQftA0+IPHbADt+eRssEjd6DMApBuJTyxvjYF4HTB+4Ny9bVBf4FBr3XxgohXc8fASJpKDtbdKlHAan9d1QMbZ3mh8IIf2RlbB6n13EYnSNyvn+wNiPRlgx7eyXOCdv8mu56/P+XbWRir0mkzad5tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=piQLVzrm; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=1XlWZunvISR0RO9C3tc/uRoA4sEEjXa/zUsmBdXVeU4=; 
	b=piQLVzrm/XlRIHWTUAvq75lXGqBfCkRuMsqIidKmHYQyucrecS00zhl1ZSKHUbLgX9eRzzdb4+A
	HKMUIvuPn8MUokfqOm5oIe3kGXNqihbioAXPJjn90/aqSWXwlR+O4yC4WXSImeRRye7KsbNiBjjrj
	f9AXFwXFzCT0biQTKnjExKfo4BdQH6NftLEVlJqKCNXftXDZwiyNINnc4ul+9aDSuuz0VDD1VbALh
	kQJBJNWmk6r8JLdMql7i5bh/W7f8EPOe/LRv8mXRyZLE+FSEmbsMYdWxH6G/AQ649WPAjKWvdR9N0
	Xzu9OKG6XOiU+N309JQFdpq4TNMBVQmlw5Tg==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1wJjWs-00Ay98-0K;
	Mon, 04 May 2026 10:59:31 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Mon, 04 May 2026 10:59:30 +0800
Date: Mon, 4 May 2026 10:59:30 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: 0nsec <0nsec@proton.me>, security@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] crypto: af_alg - convert inflight to atomic_t to fix
 data race
Message-ID: <afgLkidtExDEuQDJ@gondor.apana.org.au>
References: <rM7uJ0oBopViOraMoC0Ya0_hMtNwV4CLor-vdwN4vIH7BOKqCuuC0OWUOQoOS-0XOcJmSIT5vhR4UmZlIJxD7mllIkq1UVqEop3T0e4bjis=@proton.me>
 <2026050304-greeting-prankster-910b@gregkh>
 <QACE4BCfRIeL8Dm_ETPxjem791yvR3Lj6Iw3ArtLWxEU5FwAmjTCS6DZA_hdQfyhi2MYJTIu-p36nDpUwQbhWwxc1X2LgZSCMikbNFdOGCE=@proton.me>
 <2026050328-civic-monoxide-0a54@gregkh>
 <20260503095345.375711-1-0nsec@proton.me>
 <2026050335-spiny-lullaby-2559@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026050335-spiny-lullaby-2559@gregkh>
X-Rspamd-Queue-Id: EBA2C4B8213
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-242827-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[proton.me:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,gondor.apana.org.au:dkim,gondor.apana.org.au:mid]

On Sun, May 03, 2026 at 12:42:05PM +0200, Greg KH wrote:
> On Sun, May 03, 2026 at 09:54:27AM +0000, 0nsec wrote:
> > The inflight field in struct af_alg_ctx guards the invariant that only
> > one AIO crypto request may be in flight at a time.  It is declared as a
> > plain unsigned int but accessed from two unsynchronized contexts:
> > process context under lock_sock() and the async crypto completion
> > callback which runs without any socket lock.
> > 
> > Data race under the C11 memory model.  On weakly-ordered architectures
> > the store in the completion path could be observed out of order relative
> > to the preceding areq free, widening the window for state confusion
> > between a completing first request and a newly allocated second one.
> > 
> > Convert inflight to atomic_t.  Use atomic_xchg() for the check-and-set
> > in af_alg_alloc_areq() so check and set are one atomic operation,
> > eliminating the TOCTOU that separate atomic_read + atomic_set would
> > leave.  The ENOMEM rollback path must also clear inflight since
> > atomic_xchg() sets it before the allocation attempt; without this a
> > failed allocation permanently blocks further AIO on that socket.
> > 
> > Follows the precedent of af955bf15d2c ("crypto: af_alg - Fix race
> > around ctx->rcvused by making it atomic_t").  The inflight field
> > introduced in 67b164a871af repeated the same locking gap.
> > 
> > CVE-2025-71113 fixed uninitialized garbage in inflight via memset.
> > That is a distinct bug.  This race exists independently.
> > 
> > Fixes: 67b164a871af ("crypto: af_alg - Disallow multiple in-flight AIO requests")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: 0nsec <0nsec@proton.me>
> 
> We need a real name for the author and signed off by line.

This is not a bug at all.

It's a plain int that's being written to with either zero or one
as the value.

Sure we may not notice the async write of zero soon enough, but
that would only be because user-space is doing something naughty
and trying to perform two async operations at the same time.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

