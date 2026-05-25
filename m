Return-Path: <stable+bounces-254163-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UGeRG+ZjFGoxNAcAu9opvQ
	(envelope-from <stable+bounces-254163-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 16:59:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B3F65CC035
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 16:59:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8FEC930055D7
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 14:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1AE13F39D1;
	Mon, 25 May 2026 14:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ng5ofvEq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946EE387566;
	Mon, 25 May 2026 14:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779721182; cv=none; b=ij2igXElCv+KyOkBZhOOYvEvBQ4CAt1lPZ70zCRQYqacIhENLvY5JbutwCgoQXNoq0z4uos16n+UxJopKGGp0jZcunimPpKPECpGOT6HC3RSgOKQGZWpbFe2SO9C5tD03HloA8teDOjFKqW/UB3BaCuXOYz41PDs5pN147xJUGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779721182; c=relaxed/simple;
	bh=B8wPoM4vVLoPf3Vj40P6Wp2Sn5gzPUbypAGMNGosdMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=svfEvvTv8zKAebNhFpQ88sw6QuMDx1zUh9ukhpPlWBHjpxHi7inYM7soBMP6P5/bUSkMVhGNCjb/p6TfV1KtTV6ixUtxRbv4jz8cns24HKD4FNnmoLUv/+4Pnhn3l5qmoOb/2neT6H+NsYMhgkeHw5zSvnR1XmA/8QkGm9Ottvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ng5ofvEq; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 942601F000E9;
	Mon, 25 May 2026 14:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779721181;
	bh=YgcxoFWvQzBGZlnk+prvgf7xYHShdN14BvMPoAeCOMc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ng5ofvEqGL9n3Uw8gG4a5YNQ+LxOsnt6kGvVG1D3sLFYEj2hf4bcC/bearluhEkfd
	 6e4dnTbEv6Y6IEEbXcqCmYwtpkgNQv2EayQ7yQsobjclJyr/u7tpLktj+5jA3dWqmJ
	 tYpGFkclCH83kaYdhXAKvlgawHyAaroV9MMhVmdLQU+LvIRUe3kql07Iv5OF/e3of+
	 h1xRUGKHR3egr15Uo+e6WTwXjYi1EP+Rdy36zk8u/YgfstTVaUjgjXrrZn8XWOlKL7
	 FLHYrFWjqWQ9qZkcvO9bIkxvNtyFql9FMvu0R2OYQmgLhTEjOdQ5+JtLHMSaSMX5ME
	 1IstRdtXZPcEg==
Date: Mon, 25 May 2026 09:59:39 -0500
From: Eric Biggers <ebiggers@kernel.org>
To: Qunqin Zhao <zhaoqunqin@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>, linux-crypto@vger.kernel.org,
	Herbert Xu <herbert@gondor.apana.org.au>,
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
	Yinggang Gu <guyinggang@loongson.cn>, Lee Jones <lee@kernel.org>,
	kernel test robot <lkp@intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH] crypto: loongson - Select CRYPTO_RNG
Message-ID: <20260525145939.GC2018@quark>
References: <20260522022525.12976-1-ebiggers@kernel.org>
 <CAAhV-H5cDnWKxBobwRErRyvG8671e6VXsBe6w1RkX9rfn7CVFA@mail.gmail.com>
 <20260522025722.GD5937@quark>
 <d71adfa1-8895-e741-b72f-c5e99d5fb9e6@loongson.cn>
 <20260522040310.GF5937@quark>
 <bc3acf15-808d-4141-7f1f-4a7a7f856c6c@loongson.cn>
 <20260522174835.GA1894319@google.com>
 <4501444d-9c17-8d4b-8bfd-bd1d69d77a76@loongson.cn>
 <20260525032006.GA243157@quark>
 <05c794a7-f82d-5454-8df9-0ac543f8f8f7@loongson.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <05c794a7-f82d-5454-8df9-0ac543f8f8f7@loongson.cn>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254163-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,loongson:email]
X-Rspamd-Queue-Id: 6B3F65CC035
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 25, 2026 at 04:17:25PM +0800, Qunqin Zhao wrote:
> 
> 在 2026/5/25 上午11:20, Eric Biggers 写道:
> > On Mon, May 25, 2026 at 10:45:14AM +0800, Qunqin Zhao wrote:
> > > > > To be honest, I previously assumed that the `hw_random` was designed
> > > > > strictly and exclusively for the TRNG mode.
> > > > > 
> > > > > Is it architecturally acceptable or common practice for a PRNG mode to
> > > > > utilize `hw_random` as well?
> > > > > 
> > > > > Thanks,
> > > > So the Loongson RNG is a PRNG?  Where does it get its entropy from, and
> > > > what is its security strength?
> > > Loongson's hardware supports both TRNG and PRNG simultaneously.
> > > 
> > > We can locate a reseed function within loongson-rng.c, which clearly
> > > indicates that it is a PRNG driver.
> > That reseed function gets called with entropy from the Linux RNG.  So,
> > it seems it's really just a PRNG seeded from the Linux RNG.  What value
> > does that provide over just using the Linux RNG directly?
> 
> Alternatively,the reseed function can serve  as a stirring mechanism, where
> the primary entropy comes from the internal hardware TRNG.
> 
> Or simply ignore the  entropy from the Linux RNG entirely, trigger a
> reseeding internal.
> 
> 
> The driver merely forwards the seed to the firmware; how it is utilized and
> what kind of random numbers are returned are entirely determined by the
> firmware implementation.
> 
> > 
> > > So the core issue here is whether a PRNG driver can utilize the crypto
> > > interface.
> > If you're asking about crypto_rng, it can.  But the crypto_rng interface
> > is also kind of useless.  If you're asking about hwrng, it does look
> > like it's designed for TRNGs.  Would it be possible for this driver to
> > use the TRNG mode?
> 
> I mean crypto_rng.
> 
> We might use the hwrng interface to add support for the TRNG in this driver.

If you can actually provide fresh entropy on each call, then yes you
should implement hwrng.

> > 
> > > If it cannot, does that imply the drivers listed below serve no practical
> > > purpose? (7.1-rc1)
> > > 
> > > loongson@loongson:~/upstream/linux/drivers/crypto$ grep crypto_register_rng
> > Most of the drivers in drivers/crypto/ are added by the hardware
> > manufacturer without any regard for whether they're useful or not.
> 
> If we are dropping crypto-rng drivers entirely,

We should, since they have no real point.

> I am fine with removing the Loongson driver along with the others.
> 
> However, targeting the Loongson driver alone is unacceptable.

We just happen to be digging into the details on this driver right now,
since we're having to spend time fixing it.  Thanks for confirming that
this is supported purely for parity with other drivers.

- Eric

