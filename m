Return-Path: <stable+bounces-262637-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id njNwFI12KmotpwMAu9opvQ
	(envelope-from <stable+bounces-262637-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 10:49:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ABAD867001B
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 10:49:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gondor.apana.org.au header.s=h01 header.b=mfixcgMH;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262637-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-262637-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=apana.org.au;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BFFE531BA40A
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 08:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ADE6368276;
	Thu, 11 Jun 2026 08:48:07 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D02A2EB0F;
	Thu, 11 Jun 2026 08:48:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781167686; cv=none; b=jvxj33UdalklVO2L3CQjeT/XXbWFe2sP5Tt3YIUGm3xvz+Kkl4bDPwPPA+6WKflMhnYHcrCRnZjTt9jsQco/jttBt02oKvn4KDmVp/D97IIV1TFYnNQ8HpB8o9yqlopGGS21tMFFuF4tD2jRO2J/EAI+37w3pFlaO4W9VDUmxOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781167686; c=relaxed/simple;
	bh=45ncqpgJrcQKx+gXWAJgxgeTJJDD60YjbMYFoi2dHL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s1Qix63PSY8dwPv9MNDteytu0yTBlfXtNprNgNQ73lnqIUnzjLXFufRaD0mSTlPDVKFeBC9TidM1KWmNlsZPCSLG3LFUQc6M9kbZH8XFFiVyYOJ7F/7Th2vM/8GX+rnseiJjpk2V2SyO00PL2IorvK6tC2l+W+dMxFaem5lX6z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=mfixcgMH; arc=none smtp.client-ip=180.181.231.80
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=c3j48vW+9D5m6shOf5DXD0lLDgCnzW/Ek78ImnixKSc=; 
	b=mfixcgMHgRBcAHB30u1ynUg9Tappp5HybmPW5Kf0dH0t2yixJzKi56B+GYfSg6n1hJY+tJyXZKm
	WvDL3jwdXRnwT0vodSotZjF2rfihR2H7Km+6JbOoLdBr9QiEjhjcBsw3YCbdd3ii8tra7Id2E79U/
	4HUqFxFL8A7XOJERYfB9B4U6NfdRnxo/cf5Cgx35BdNzkdLuJGwmpOMcOhno/IOC3g51e6N5Pzli2
	d7YaAcBvMPSRxBCbMu+nSE3/GOD/0FqH9i39mRmhA51s4cwvYoaF/yhbDHTmZ36FLVmIAW5mEPHUi
	p6EwG0toEAp7yyWfjlc2FsSb2aquVKwBZZ2A==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.98.2 #2 (Debian))
	id 1wXb4y-00000004XRV-35Ww;
	Thu, 11 Jun 2026 16:48:01 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 11 Jun 2026 16:48:00 +0800
Date: Thu, 11 Jun 2026 16:48:00 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org, Christian Lamparter <chunkeey@gmail.com>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] crypto: crypto4xx - Remove insecure and unused rng_alg
Message-ID: <aip2QHfRK9nEZMMJ@gondor.apana.org.au>
References: <20260529220430.34135-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529220430.34135-1-ebiggers@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262637-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[herbert@gondor.apana.org.au,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ebiggers@kernel.org,m:linux-crypto@vger.kernel.org,m:chunkeey@gmail.com,m:linuxppc-dev@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,gondor.apana.org.au:dkim,gondor.apana.org.au:mid,gondor.apana.org.au:from_mime,vger.kernel.org:from_smtp,apana.org.au:url,apana.org.au:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ABAD867001B

On Fri, May 29, 2026 at 03:04:30PM -0700, Eric Biggers wrote:
> Remove crypto4xx_rng, as it is insecure and unused:
> 
> - It has only a 64-bit security strength, which is highly inadequate.
>   This can be seen by the fact that crypto4xx_hw_init() seeds it with
>   only 64 bits of entropy, and the fact that the original commit
>   mentions that it implements ANSI X9.17 Annex C.
> 
>   Another issue was that this driver didn't implement the crypto_rng API
>   correctly, as crypto4xx_prng_generate() didn't return 0 on success.
> 
> - No user of this code is known.  It's usable only theoretically via the
>   "rng" algorithm type of AF_ALG.  But userspace actually just uses the
>   actual Linux RNG (/dev/random etc) instead.  And rng_algs don't
>   contribute entropy to the actual Linux RNG either.  (This may have
>   been confused with hwrng, which does contribute entropy.)
> 
> Fixes: d072bfa48853 ("crypto: crypto4xx - add prng crypto support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> ---
>  drivers/crypto/Kconfig                  |  1 -
>  drivers/crypto/amcc/crypto4xx_core.c    | 88 -------------------------
>  drivers/crypto/amcc/crypto4xx_core.h    |  4 --
>  drivers/crypto/amcc/crypto4xx_reg_def.h | 11 ----
>  4 files changed, 104 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

