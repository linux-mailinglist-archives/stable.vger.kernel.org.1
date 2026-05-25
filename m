Return-Path: <stable+bounces-254067-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IPauCO6/E2rWFQcAu9opvQ
	(envelope-from <stable+bounces-254067-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 05:20:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8951B5C58A6
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 05:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1E95D3008281
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 03:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C735A2BE035;
	Mon, 25 May 2026 03:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DTEABuQH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9589F1EA7CE;
	Mon, 25 May 2026 03:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779679210; cv=none; b=rGSuGF9nI+fx8Iv2hHBPUiRRm1pCOj0kOg/rmI9++4yk8vSvz6KzwtfYIhXmbT2ODBtTbv0U15btmDvWmh2ix1UMG3ANrgjirlSVCQpxKbPEe4o8oGGYDHjOtJiAaeyWARslnjwRsAb5bmk538odlC19obetEnPR3pR2hzAFmZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779679210; c=relaxed/simple;
	bh=dujhx+kNkJj4kNiU/zgoiaK+THB6K/rFBIERBnI7OyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ODil4idOV0fve3NyPpy6aTdGsDFpYxGe/mzjZnqBt3yYQCK+YkRrQ3BjiSG4N7ESy0sZBRstwgP9g3XxOMkXjvR031XOSxSOkvCnk+frLpcCfgMTRNtKpeoUo6sIZn+bJ0ZtUM+JT92+opLWrfewOt5j18pFrn1nX430YlOioe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DTEABuQH; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1627B1F000E9;
	Mon, 25 May 2026 03:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779679208;
	bh=vsyaQijSF17oIUNASElUtqLbJFypQHGCf/EnkeK63AM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DTEABuQH/yQueBer9Vkmn/T1iSsMD8UI+in6nAOPm3PHV/3X+16QGNbPTybv5HxuZ
	 dS/3SauIYktoOoG7mO8/viXSJ8/dGW0l6P4S4+Ch9QRd26kYIOVnm+B4rjMsaqOblc
	 25qBnjKyEbh879DofpF6AE20PqZ+fxupDr/Un36ByLY/U0KSlESb8BSTdiKYmHN9j6
	 H89eBG7DHano0NsDWQWuvYpmv+xM/hxHU/MxG7z6fA47psoBwUOwpKnhFfc4m2j5Nj
	 YU2qfv9S5aDR3OVxPykdILWnVOqnZfixC1Z95JgU0YuzrOnkXeRu0wR397iFNNuO22
	 asOgTUNGzlk+Q==
Date: Sun, 24 May 2026 22:20:06 -0500
From: Eric Biggers <ebiggers@kernel.org>
To: Qunqin Zhao <zhaoqunqin@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>, linux-crypto@vger.kernel.org,
	Herbert Xu <herbert@gondor.apana.org.au>,
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
	Yinggang Gu <guyinggang@loongson.cn>, Lee Jones <lee@kernel.org>,
	kernel test robot <lkp@intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH] crypto: loongson - Select CRYPTO_RNG
Message-ID: <20260525032006.GA243157@quark>
References: <20260522022525.12976-1-ebiggers@kernel.org>
 <CAAhV-H5cDnWKxBobwRErRyvG8671e6VXsBe6w1RkX9rfn7CVFA@mail.gmail.com>
 <20260522025722.GD5937@quark>
 <d71adfa1-8895-e741-b72f-c5e99d5fb9e6@loongson.cn>
 <20260522040310.GF5937@quark>
 <bc3acf15-808d-4141-7f1f-4a7a7f856c6c@loongson.cn>
 <20260522174835.GA1894319@google.com>
 <4501444d-9c17-8d4b-8bfd-bd1d69d77a76@loongson.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4501444d-9c17-8d4b-8bfd-bd1d69d77a76@loongson.cn>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254067-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 8951B5C58A6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 25, 2026 at 10:45:14AM +0800, Qunqin Zhao wrote:
> > > To be honest, I previously assumed that the `hw_random` was designed
> > > strictly and exclusively for the TRNG mode.
> > > 
> > > Is it architecturally acceptable or common practice for a PRNG mode to
> > > utilize `hw_random` as well?
> > > 
> > > Thanks,
> > So the Loongson RNG is a PRNG?  Where does it get its entropy from, and
> > what is its security strength?
> 
> Loongson's hardware supports both TRNG and PRNG simultaneously.
> 
> We can locate a reseed function within loongson-rng.c, which clearly
> indicates that it is a PRNG driver.

That reseed function gets called with entropy from the Linux RNG.  So,
it seems it's really just a PRNG seeded from the Linux RNG.  What value
does that provide over just using the Linux RNG directly?

> So the core issue here is whether a PRNG driver can utilize the crypto
> interface.

If you're asking about crypto_rng, it can.  But the crypto_rng interface
is also kind of useless.  If you're asking about hwrng, it does look
like it's designed for TRNGs.  Would it be possible for this driver to
use the TRNG mode?

> If it cannot, does that imply the drivers listed below serve no practical
> purpose? (7.1-rc1)
> 
> loongson@loongson:~/upstream/linux/drivers/crypto$ grep crypto_register_rng

Most of the drivers in drivers/crypto/ are added by the hardware
manufacturer without any regard for whether they're useful or not.

- Eric

