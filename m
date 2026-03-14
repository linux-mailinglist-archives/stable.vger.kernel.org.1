Return-Path: <stable+bounces-225407-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iI6aF83wtGm/uQAAu9opvQ
	(envelope-from <stable+bounces-225407-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 14 Mar 2026 06:23:25 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C10D328BCD9
	for <lists+stable@lfdr.de>; Sat, 14 Mar 2026 06:23:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 109AE30DE01B
	for <lists+stable@lfdr.de>; Sat, 14 Mar 2026 05:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D05C34F25E;
	Sat, 14 Mar 2026 05:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="Z/3trxoz"
X-Original-To: stable@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD18433BBBD;
	Sat, 14 Mar 2026 05:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773465484; cv=none; b=dJnbe9p4pa2wMzEFzjYqojZCA7hM17J4XDmohac+J/a0F347HamF6W4GSkpsWbGHH2gjq7xLmuJomuG+oE50ZuZpEf143rKMrfuHZ2TaG/luaR0uKCqf1LHHXfogmpYn2LgoNcvf/qM2TInj6ZMYZhzG+J2WWccgws6sHtf35K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773465484; c=relaxed/simple;
	bh=l2f0TyCGMZRVFZjFMQEWO2I0dyb2w8I6MmUdj806EQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ckLFVU2vidd/Q38b/DMIMRbVGZyhibuluGKHZLsuzMuElSkonzWjj8ZoFiln4JtuXUToQQm2z3vWb3ugy1GHGumkI1EeP42T1/tHVm5LFGgL3D4THIwCWGsaop8mIzKcledLXiA/VtThQBe4FemwPZEKY6zn3/A7W2bu8vKOKsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=Z/3trxoz; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=lUXcLKoc7COE0wu6kd451RLHftXbNwdcrBZLRXaHvGs=; 
	b=Z/3trxozemy/z5PUEmrC+qNC9yLQSXe4Sj0YO0EgKgOhRdfnn85GdntZzcsxBmG+1VLI9IjEj2a
	MYNdXARcq3CgoC+cPwY5TB+Pf0O0ul5YiOcRu1nuYDef5pYeAijUy4dG3Yuzlvjeusj85i+sRmWVk
	vYtvbtt7KTqb2JDyjiXc+oz7HH5AbmBCLqPZAgGvyiAI3dUTQ4i/tj6+JjxQJmrJk5tKZnSScWQ4g
	VB9tLEivSKz/xdzNsGJvRQHm1JXMAytef+JrESV0LsefeznGJK8AMK0wQas0PJfjzuRhVImTFw3kw
	HDBrN8B9hvl0uN3QyOjDzYYAvChbG6OGotBA==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1w1HNb-00ELCa-1U;
	Sat, 14 Mar 2026 13:17:40 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 14 Mar 2026 14:17:39 +0900
Date: Sat, 14 Mar 2026 14:17:39 +0900
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: "David S. Miller" <davem@davemloft.net>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Eric =?iso-8859-1?Q?B=E9nard?= <eric@eukrea.com>,
	Nicolas Royer <nicolas@eukrea.com>, stable@vger.kernel.org,
	linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: atmel-tdes - fix DMA sync direction
Message-ID: <abTvc58wltmQNOe_@gondor.apana.org.au>
References: <20260307153109.321147-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260307153109.321147-2-thorsten.blum@linux.dev>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	TAGGED_FROM(0.00)[bounces-225407-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: C10D328BCD9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Mar 07, 2026 at 04:31:10PM +0100, Thorsten Blum wrote:
> Before DMA output is consumed by the CPU, ->dma_addr_out must be synced
> with dma_sync_single_for_cpu() instead of dma_sync_single_for_device().
> Using the wrong direction can return stale cache data on non-coherent
> platforms.
> 
> Fixes: 13802005d8f2 ("crypto: atmel - add Atmel DES/TDES driver")
> Fixes: 1f858040c2f7 ("crypto: atmel-tdes - add support for latest release of the IP (0x700)")
> Cc: stable@vger.kernel.org
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  drivers/crypto/atmel-tdes.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

