Return-Path: <stable+bounces-160408-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 038D9AFBDB8
	for <lists+stable@lfdr.de>; Mon,  7 Jul 2025 23:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 959CF188A81D
	for <lists+stable@lfdr.de>; Mon,  7 Jul 2025 21:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 154FF289376;
	Mon,  7 Jul 2025 21:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aEUf5hpX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FD6288C0F;
	Mon,  7 Jul 2025 21:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751924262; cv=none; b=osKzP4M303ipgE0Mc+4o1U/fXcwiAUCqvD/u0dxaHxCq91wpQ8NyPCEBmD0q4vRjRG8szAorrTaWYuYJJZrRHGzLQ4ZoxdzY0nF2ikaq2l7Z3Pt2SNs78sAnO+aIfQ6+mYEcCOnpUxQIKlqnVaPjOLZlbuGU67XE44ZLyyU3qaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751924262; c=relaxed/simple;
	bh=FwgBjQrtkvW4NcXe5znuL7tO2Cvvn0e72ByCc7X4IEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LXcFHSsPo+CkLE+Ao7bbTWdUm+I6n9xvGJjJNJsCXJASOYNnA8/j6Hy1+o0StA2m04VoFzZKAf2wKl999MNwj6s1gMkoupCUJ5hBzH+8W4KVLlurhG+J5CtaUOcWK1cGfxMbq+O351ThF/PBP2PcPOdpPbXVV2cwCE10C5+AYQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aEUf5hpX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4D00C4CEE3;
	Mon,  7 Jul 2025 21:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751924262;
	bh=FwgBjQrtkvW4NcXe5znuL7tO2Cvvn0e72ByCc7X4IEQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aEUf5hpXQDGhXqkPcEUz2rqPtZu0Vi3w/XOuiO6FINAXPN48HKZqDkWSou6GaVb3E
	 /IyDNl75pIlZOvtKpTi4re/eUf403YY5MRU+0WhjYkZftdjGfxmRt3BtcsedeARjGp
	 sE1waHuQzm+mfSTKrLvjJihTRfaFubPgmZ+j9wv57GrZAFLCtAlwUJx/xzXJsJlnRL
	 Shtm2+nmM0UTkuGycWht7wY0Z6vNh/sIjTRSB1Fbt2xl2algw/Irw2jy16swyPdRMc
	 Iows8Q2lWei8DUQIBwMOANrp8ZEzZDaqrwyy9mqQ2Bo7npHV5TWHbS+VMWVy9mb5UQ
	 a/uthVrGAEEwg==
Date: Mon, 7 Jul 2025 21:37:40 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: stable@vger.kernel.org
Cc: stable-commits@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: Patch "crypto: powerpc/poly1305 - add depends on BROKEN for now"
 has been added to the 6.12-stable tree
Message-ID: <20250707213740.GB3178810@google.com>
References: <20250707043445.484247-1-sashal@kernel.org>
 <20250707172944.GA3116681@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707172944.GA3116681@google.com>

On Mon, Jul 07, 2025 at 05:29:47PM +0000, Eric Biggers wrote:
> On Mon, Jul 07, 2025 at 12:34:45AM -0400, Sasha Levin wrote:
> > This is a note to let you know that I've just added the patch titled
> > 
> >     crypto: powerpc/poly1305 - add depends on BROKEN for now
> > 
> > to the 6.12-stable tree which can be found at:
> >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> You forgot to Cc the relevant mailing lists.
> 
> > diff --git a/arch/powerpc/lib/crypto/Kconfig b/arch/powerpc/lib/crypto/Kconfig
> > new file mode 100644
> > index 0000000000000..3f9e1bbd9905b
> > --- /dev/null
> > +++ b/arch/powerpc/lib/crypto/Kconfig
> > @@ -0,0 +1,22 @@
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +
> > +config CRYPTO_CHACHA20_P10
> > +	tristate
> > +	depends on PPC64 && CPU_LITTLE_ENDIAN && VSX
> > +	default CRYPTO_LIB_CHACHA
> > +	select CRYPTO_LIB_CHACHA_GENERIC
> > +	select CRYPTO_ARCH_HAVE_LIB_CHACHA
> > +
> > +config CRYPTO_POLY1305_P10
> > +	tristate
> > +	depends on PPC64 && CPU_LITTLE_ENDIAN && VSX
> > +	depends on BROKEN # Needs to be fixed to work in softirq context
> > +	default CRYPTO_LIB_POLY1305
> > +	select CRYPTO_ARCH_HAVE_LIB_POLY1305
> > +	select CRYPTO_LIB_POLY1305_GENERIC
> > +
> > +config CRYPTO_SHA256_PPC_SPE
> > +	tristate
> > +	depends on SPE
> > +	default CRYPTO_LIB_SHA256
> > +	select CRYPTO_ARCH_HAVE_LIB_SHA256
> 
> Really?

I see this was already backported correctly for 6.15, so please just
cherry-pick it from there.

- Eric

