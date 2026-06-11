Return-Path: <stable+bounces-262636-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id K0I3Cxx2KmrlpgMAu9opvQ
	(envelope-from <stable+bounces-262636-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 10:47:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB8266FFD5
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 10:47:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gondor.apana.org.au header.s=h01 header.b=ewanb71h;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262636-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-262636-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=apana.org.au;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AC7D8302E0D0
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 08:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0D13BAD9A;
	Thu, 11 Jun 2026 08:47:18 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D8F3BAD94;
	Thu, 11 Jun 2026 08:47:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781167637; cv=none; b=LZFvL3TBr/kTKVSiHdfU+vakUq/L3Bj7jKK/Xlu5DlhWzMGGQbPPfJ1yaidKJ37RVtXCjD3X0tcBwygs4Ywod14DGEWOaKZP0tYZnmdvBoJqnrV1mQ6LqWtOLgPFPzEKQy03fqQoeYai1UchqDylChpEDmOCfz4Cjf5Jcz3Blms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781167637; c=relaxed/simple;
	bh=p3VFzluSG4KUtmK2o4PmhRNpzIz4XrdG4befu3O85zM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ohBUZV8XCtAwBq6XJtuJ7NlZzz+iPMeVccriOzMoofytfhsOttnwQZOrqCSj5e9LOB3+2BKwMy6BhbGgvh99VqaLU2t4roCroRLEeazmhbL1PFKPYkkynkTKmBeoJV4OCGHs0iQWWPBBX1ISoZS0XKHQ858fTquvbNqMAfyh5Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=ewanb71h; arc=none smtp.client-ip=180.181.231.80
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=sKVfby74oDjxfTtZORtOiAzRAVYhFnZVQ82kmcDTCDI=; 
	b=ewanb71h8n4GjOKPrbT8Hfaju1SItPx3fUZ+cOX6wMpTbQUd0M+yOc2MoRc0VBxWaAlLtvm/5J+
	cc4utsZeVhST+K5QRVFeu49BsCEXcdd71p/KN7ZlfMLwqk+jtl8W6kz9m6sH2C9ppLmIx7UK7eP1A
	h6Qfn0UpLniYL6JwdObQXR9vgYY7JCb2EnMlKYyIVtaa4YMoTgGVxeB1Ys/1ZvqoAEeFvHpfotQLe
	zjMpJAECDaN7thuCC7iMxG6NL6Ih3H3kQCjox8qU7HtmuPJ/JndNq6GNEcZlxg6K5/FCYxHhVyYjF
	WctMgSxbAEL6o+Br79udaVAxg/lmYp9Wjmhg==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.98.2 #2 (Debian))
	id 1wXb4B-00000004XR0-41FU;
	Thu, 11 Jun 2026 16:47:13 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 11 Jun 2026 16:47:11 +0800
Date: Thu, 11 Jun 2026 16:47:11 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Cc: linux-crypto@vger.kernel.org, qat-linux@intel.com,
	stable@vger.kernel.org, Ahsan Atta <ahsan.atta@intel.com>,
	Laurent M Coquerel <laurent.m.coquerel@intel.com>
Subject: Re: [PATCH] crypto: qat - validate RSA CRT component lengths
Message-ID: <aip2D_O8EprwIL4u@gondor.apana.org.au>
References: <20260528155854.40858-1-giovanni.cabiddu@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528155854.40858-1-giovanni.cabiddu@intel.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262636-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:giovanni.cabiddu@intel.com,m:linux-crypto@vger.kernel.org,m:qat-linux@intel.com,m:stable@vger.kernel.org,m:ahsan.atta@intel.com,m:laurent.m.coquerel@intel.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[herbert@gondor.apana.org.au,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,intel.com:email,gondor.apana.org.au:dkim,gondor.apana.org.au:mid,gondor.apana.org.au:from_mime,apana.org.au:url,apana.org.au:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9DB8266FFD5

On Thu, May 28, 2026 at 04:57:44PM +0100, Giovanni Cabiddu wrote:
> The generic RSA key parser (rsa_helper.c) bounds each CRT component (p,
> q, dp, dq, qinv) by the modulus size n_sz, but qat_rsa_setkey_crt()
> allocates half-size DMA buffers (key_sz / 2) and right-aligns each
> component with:
> 
>     memcpy(dst + half_key_sz - len, src, len)
> 
> When a CRT component is larger than half_key_sz the subtraction
> underflows and memcpy writes past the DMA buffer, causing memory
> corruption.
> 
> Add a len > half_key_sz check next to the existing !len check for each
> of the five CRT components so the driver falls back to the non-CRT path
> instead of writing out of bounds.
> 
> Fixes: 879f77e9071f ("crypto: qat - Add RSA CRT mode")
> Cc: stable@vger.kernel.org
> Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
> Reviewed-by: Ahsan Atta <ahsan.atta@intel.com>
> Reviewed-by: Laurent M Coquerel <laurent.m.coquerel@intel.com>
> Tested-by: Laurent M Coquerel <laurent.m.coquerel@intel.com>
> ---
>  drivers/crypto/intel/qat/qat_common/qat_asym_algs.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

