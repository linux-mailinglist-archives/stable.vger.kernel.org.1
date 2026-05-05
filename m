Return-Path: <stable+bounces-244029-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cFaTBbi4+WmNBAMAu9opvQ
	(envelope-from <stable+bounces-244029-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 11:30:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B0BD24C9B5E
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 11:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A60333008D43
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 09:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05213126C4;
	Tue,  5 May 2026 09:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="naIMprh7"
X-Original-To: stable@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22992F6910;
	Tue,  5 May 2026 09:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777973426; cv=none; b=KVeiL0HWCBA1Xs9oAcDX3QSu2vOJjnnV/CsQfuNbOdB9ukcXQP8Wt5Iv2ZNOXgHxTUbY9k5aDf/LbFJQzgYpAwVFZUD6bAqdAl77TOGnyH7dL6Zm2aWIvq6qBgJhq36Z79b1jnYNeATKGiCSjZvbzKrOS8KGiuWLqUencNzySbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777973426; c=relaxed/simple;
	bh=LdjSLyepUOKVFjsGIp3W8ZnMtwsGA4HY10BzrVAz7yI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aYLv4boJWgdDDfJAbqeJIYT6GoGNuVjDqupby1CsiyxuJp/QDYSc8XHSkttssOFWnoJyVfiYYmx1B9TzfPar7H0G1oPmrYjOmnWHPw35ZSF00RY5o+4k/7ikxVzzgEKPaWgosb/e7EoCCppu1tObDArQsayyu1NMFecGoOir98E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=naIMprh7; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=QNLOEXFxq4uiqG2FBjx7y5UulD3vGj5gX9vl2RjNT68=; 
	b=naIMprh7/p53cXXpze96WKbbfz5st0pY2gSh3UBEuXWwRMTvsODxYYgE4mttHmOIXJYeC7e5oMk
	+Qn/dklp9eY9xsclyGS4j15Q3w8sL7BZxSbIWpLlB0/oYXutLdR3tVuE0mj0LBdBBCg4U3l6t09GW
	IDI57buDhZ0bwS8rhoSDIp16VNmD/UNAg/75DG854TJNEzch4PNzzR1Di4aRDhSxNjEBIqNW4guWX
	NepUxGYJG2p6KaadCrgzDqWQ7E+MqTVJPkoyDt+QEsI+B1cwpMbU/gbu9A6EWJQ97vGzkWqFV9ekg
	wpNjkeck6ZbNAjUf8kj9S4f+jvgOgmMTnnmA==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1wKC6U-00BNzu-0K;
	Tue, 05 May 2026 17:30:11 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 05 May 2026 17:30:10 +0800
Date: Tue, 5 May 2026 17:30:10 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: "David S. Miller" <davem@davemloft.net>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Linus Walleij <linusw@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	stable@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] crypto: atmel-sha204a - drop hwrng quality reduction
 for ATSHA204A
Message-ID: <afm4osSDHTltfoIJ@gondor.apana.org.au>
References: <20260428101430.514838-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428101430.514838-3-thorsten.blum@linux.dev>
X-Rspamd-Queue-Id: B0BD24C9B5E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244029-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[apana.org.au:url,apana.org.au:email,microchip.com:url,gondor.apana.org.au:dkim,gondor.apana.org.au:mid,linux.dev:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

On Tue, Apr 28, 2026 at 12:14:32PM +0200, Thorsten Blum wrote:
> Commit 8006aff15516 ("crypto: atmel-sha204a - Set hwrng quality to
> lowest possible") reduced the hwrng quality to 1 based on a review by
> Bill Cox [1]. However, despite its title, the review only tested the
> ATSHA204, not the ATSHA204A.
> 
> In the same thread, Atmel engineer Landon Cox wrote "this behavior has
> been eliminated entirely"[2] in the ATSHA204A and "this problem does not
> affect the ATECC108 or the ATECC108A (or the ATSHA204A)"[3].
> 
> According to the official ATSHA204A datasheet [4], the device contains a
> high-quality hardware RNG that combines its output with an internal seed
> value stored in EEPROM or SRAM to generate random numbers. The device
> also implements all security functions using SHA-256, and the driver
> uses the chip's Random command in seed-update mode.
> 
> Keep 'quality = 1' for ATSHA204, but drop the explicit hwrng quality
> reduction for ATSHA204A and fall back to the hwrng core default.
> 
> [1] https://www.metzdowd.com/pipermail/cryptography/2014-December/023858.html
> [2] https://www.metzdowd.com/pipermail/cryptography/2014-December/023852.html
> [3] https://www.metzdowd.com/pipermail/cryptography/2014-December/023886.html
> [4] https://ww1.microchip.com/downloads/en/DeviceDoc/ATSHA204A-Data-Sheet-40002025A.pdf
> 
> Fixes: 8006aff15516 ("crypto: atmel-sha204a - Set hwrng quality to lowest possible")
> Cc: stable@vger.kernel.org
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
> Changes in v2:
> - Drop the enum and dereference match data if needed as suggested by Ard
> - Keep the review comment
> - v1: https://lore.kernel.org/lkml/20260427124030.315590-3-thorsten.blum@linux.dev/
> ---
>  drivers/crypto/atmel-sha204a.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

