Return-Path: <stable+bounces-259284-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MPusLPU5G2pnAQkAu9opvQ
	(envelope-from <stable+bounces-259284-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 21:26:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C10F613073
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 21:26:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 59777301D30F
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503852C11EE;
	Sat, 30 May 2026 19:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gE6tY2C1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227E726B764;
	Sat, 30 May 2026 19:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780169199; cv=none; b=u/1xtziztBhvRTokk5vCilMPwLplNEbcAjLLpD1+/ikbG42WpZwySwbB9V+N6ux4y93rY8mA21fgLoVCrE9e2cVMqEvx5lfClwOtujs0YbXsbl5aCxxAPV1xH+se5xvPR9qyD2+WlIbmbm502DU8Er44VQ+OkrKbxFUjSzd6AYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780169199; c=relaxed/simple;
	bh=V5JDf3FoZpGmt8nIt1lcKs/LSZF2o0MDSYTrqqrMOu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i0sRbMb4DMWBRHXbJletdsUUxnkf8MPx85KuE/4Uxeu7YKf/l7Jsum/LeBjaea71WvaydfI+KMe2WbTITi5KzJMhkQJFuhs8mscYMSNoWiMYgsFjwEsd/H1MaF7jbKC5VUPY8i2pHv89oy/jnTxGoJT3i+m3rLUZXyMCCPBBm/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gE6tY2C1; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE7821F00899;
	Sat, 30 May 2026 19:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780169197;
	bh=z5GsolBXXG87q6U09vPL4wkhz04P58jv7onQiI/rtEM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gE6tY2C169MjZGxfK1lZvyGSb6rNyisdk9hNjLiqAv/5UjrwIvu6eRjZKaI8FMafi
	 8SmYISFrENntrlZoRw6boLB8gRAwxqNVp47J48Md0Yq4HlZj6+KIfkwYn7vRfw0p7S
	 2Dp32qEn744GwPbS26zLypvHNJ0qxMC/a7I+n2OC82tGMyf340Rh51Z/syVlcLlJ0F
	 Fk2iA8WOWIyhuNhQ2JHVFQx91inAfMk+FJlFeIxjGZ901dFVnb6h5ZBW/81of9YPkN
	 z6bq8VVhQ5VpbdJtYF94j93q7ZArNcDoUMvGFO5jka8c0/vLKPukANTmjTf99wi+16
	 bfm+4HjNQ6bFQ==
Date: Sat, 30 May 2026 12:26:30 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Aleksander Jan Bajkowski <olek2@wp.pl>
Cc: linux-crypto@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>,
	Christian Lamparter <chunkeey@gmail.com>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] crypto: crypto4xx - Remove insecure and unused rng_alg
Message-ID: <20260530192630.GB6807@quark>
References: <20260529220430.34135-1-ebiggers@kernel.org>
 <5c74c261-53cf-4185-a8a0-7554bc9fe5f7@wp.pl>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c74c261-53cf-4185-a8a0-7554bc9fe5f7@wp.pl>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259284-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[wp.pl];
	FREEMAIL_CC(0.00)[vger.kernel.org,gondor.apana.org.au,gmail.com,lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 1C10F613073
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, May 30, 2026 at 05:05:19PM +0200, Aleksander Jan Bajkowski wrote:
> Hi Eric,
> 
> On 30/05/2026 00:04, Eric Biggers wrote:
> > Remove crypto4xx_rng, as it is insecure and unused:
> > 
> > - It has only a 64-bit security strength, which is highly inadequate.
> >    This can be seen by the fact that crypto4xx_hw_init() seeds it with
> >    only 64 bits of entropy, and the fact that the original commit
> >    mentions that it implements ANSI X9.17 Annex C.
> 
> In addition to a seed, the PRNG also uses ring oscillators as sources of
> entropy. The entropy should be higher than 64b. This is the Rambus EIP-73d
> IP core. The same IP core is built into eip93 (EIP-73a), eip97 (EIP-73d),
> and eip197 (EIP-73d). You can find the documentation online. The complete
> "container" is actually Rambus EIP-94, and one of its parts is EIP-73d.

Just because it may have another source of entropy doesn't mean its
security strength is higher than 64 bits.

I cannot find any documentation other than
https://datasheet.octopart.com/PPC460EX-SUB800T-AMCC-datasheet-11553412.pdf
which says "ANSI X9.17 Annex C compliant using a DES algorithm".

DES actually has a 56-bit key, so maybe I was over-generous.

And according to https://cacr.uwaterloo.ca/hac/about/chap5.pdf ANSI
X9.17 has only a 64-bit state anyway.  So even if we assume the
datasheet is incorrect and the algorithm is actually 3DES which has a
longer key, the state is likely still 64-bit.

So it isn't looking good.  And since it's an undocumented proprietary
design it shouldn't be given the benefit of the doubt either.

> This PRNG is also used internally for Generation IV with IPSEC offload. The
> IPSEC offload implementation for eip93 was recently submitted to upstream.
> I am not sure whether eip94 shares some of the logic for IPSEC offload and
> it will be possible to use some of the code.

That's not related to this patch.

- Eric

