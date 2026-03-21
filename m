Return-Path: <stable+bounces-227741-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wEubOptbvmmYNQMAu9opvQ
	(envelope-from <stable+bounces-227741-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 09:49:31 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 52EF92E43AE
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 09:49:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A9453021E86
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 08:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5036313E3D;
	Sat, 21 Mar 2026 08:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="n21HfaNi"
X-Original-To: stable@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD572DCF4C;
	Sat, 21 Mar 2026 08:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774082961; cv=none; b=oVtlTdaScjykL7587aL8nLfQHk01a2B/+tV+Spy93AHhFnciiK6sABSDduK9Q1zy9LBSJn1qU6wVXnBxgPRghKbZTUwdCVYab3YvQZWfTwmc+SGDqK0LTb6PQTyfPlEVekVq3MPTNceCaofETmVosrTVtmMRlHMdltRtT6aN0xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774082961; c=relaxed/simple;
	bh=2FKUVsPYy1urRBPQFaO5JaAPS/4cXj6tkJsgZiChXgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gqtaMFKRS0E+RvFy/tZbu1foBRFhccjBhAYrI/+3MxGbtvFDtpZAOlJX0uRW9+WO9R3t5+1L3tiIzqcYYtR7+hRbLOF2bHwCzWzLRUs6xj/H65ssg1Y7gVeELUhptjCxdsulsIbUjvMxlmz+dgBgWprPntpUOgyXHcM17v5ge2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=n21HfaNi; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=J+H11LAznX/cYognNg/use6inBDXVLaU4zUxBBkfRsk=; 
	b=n21HfaNiD/Il9DoR1xKdn2MEHcCWWqQIQueJPl2/miKej9euHnNZmQ6JzsBW0JOQHJem7H49xH9
	VX7zz8H027nCdcXGEBzgjbEoDHu0WWktPE9GWP4F5anVvd5BkwQ8ghcqRCXev/gaIcpEjLX+SfSz8
	bHpyAmYvj+QD9Bu+j8YYPVXMH5ALirspbZ272mZ6fUfotLKgU1ZDxze3z/NIZ9Hs/hrMqUayWIuGM
	c4FIO3dUmvxfbw2TROu2ZcJ4S2KrMwVMUNuZMOiwg92CBdcOW2g+G5Qxfg5DtB/jvU5bCXDNVQujv
	E/xjFGBut4hidpx6I4CzzDzCvwvMMg19QKaA==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1w3s11-00GJAS-28;
	Sat, 21 Mar 2026 16:49:04 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 21 Mar 2026 17:49:03 +0900
Date: Sat, 21 Mar 2026 17:49:03 +0900
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Haren Myneni <haren@us.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Dan Streetman <ddstreet@ieee.org>, stable@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] crypto: nx - fix bounce buffer leaks in
 nx842_crypto_{alloc,free}_ctx
Message-ID: <ab5bf7kayDrxyUNF@gondor.apana.org.au>
References: <20260311155645.397083-4-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311155645.397083-4-thorsten.blum@linux.dev>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[us.ibm.com,linux.ibm.com,ellerman.id.au,gmail.com,kernel.org,davemloft.net,ieee.org,vger.kernel.org,lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-227741-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email,gondor.apana.org.au:dkim,gondor.apana.org.au:mid,apana.org.au:email,apana.org.au:url]
X-Rspamd-Queue-Id: 52EF92E43AE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 11, 2026 at 04:56:47PM +0100, Thorsten Blum wrote:
> The bounce buffers are allocated with __get_free_pages() using
> BOUNCE_BUFFER_ORDER (order 2 = 4 pages), but both the allocation error
> path and nx842_crypto_free_ctx() release the buffers with free_page().
> Use free_pages() with the matching order instead.
> 
> Fixes: ed70b479c2c0 ("crypto: nx - add hardware 842 crypto comp alg")
> Cc: stable@vger.kernel.org
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  drivers/crypto/nx/nx-842.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

