Return-Path: <stable+bounces-160389-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C15AFB9E8
	for <lists+stable@lfdr.de>; Mon,  7 Jul 2025 19:29:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A98AB1898D95
	for <lists+stable@lfdr.de>; Mon,  7 Jul 2025 17:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA2A2957C1;
	Mon,  7 Jul 2025 17:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qjupirAr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC788225A4F;
	Mon,  7 Jul 2025 17:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751909387; cv=none; b=fDpGALGInzxfPSInYsE0Tkrrwk5bjAThs1Bn8wxDJBlbeF73iM9BQ58GOQg3OJIEP1zlYaSqShR7ahY/fUdr6D4t0jY1tjSN45xV9WCHGdNgFs0JL0hbkXYxIkxUlA6PWxdWlwuxEn3veMZxGWZtfeIezb4m+YpNwyalas9Dins=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751909387; c=relaxed/simple;
	bh=FCDs/HMbZ2C4wZrpxx8SA6xLTwwkneYiBf2oUoIPIH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RESlgZrLnue+5WGzee6jvOg/D+IcaICRNIrj9pHlLvR4a7M7FMTxFq4bjvgWj45vZvj3HNcEgAS5qP3abjcAg0zQfar4ITagD03Hn764FZ2gwcRgqCylDdpf3BHNmXoDZrJLGz/AQFiNiq0+SO89fvEN2zMPUaVuNKYmfEpPePQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qjupirAr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91B38C4CEE3;
	Mon,  7 Jul 2025 17:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751909387;
	bh=FCDs/HMbZ2C4wZrpxx8SA6xLTwwkneYiBf2oUoIPIH0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qjupirArFMF+8B8j4j4snd/X3ZveqjsYKGvwzq2TI3U9+HEeHKhi+8n1I637dAKqn
	 c5N3qaA1u7nb/AcDEQKW3lqBtrAIPlOpNup7yVuwwrXMfAgR0OuN37SWigUPPABHCg
	 6NHwmGggm/YoFhqZN0xUeP2Fj8ChnseByFO1d6RJnntCV9p3p0soagGzyMtHwc1Pjs
	 d3Xz+SXV3qgaTCEXTtYbASkaoSBgbaV1vZWSsKZAoZsTTkq3sa5koNY7D64AZIHFVp
	 eMR4821BHPJYwuyXHO8dXQOXTcSnQGaZbBQqdfNWzdH5mFuv1MPf+xrX4l+ew5WD3t
	 nCZS/WciPCWuQ==
Date: Mon, 7 Jul 2025 17:29:44 +0000
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
Message-ID: <20250707172944.GA3116681@google.com>
References: <20250707043445.484247-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707043445.484247-1-sashal@kernel.org>

On Mon, Jul 07, 2025 at 12:34:45AM -0400, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     crypto: powerpc/poly1305 - add depends on BROKEN for now
> 
> to the 6.12-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

You forgot to Cc the relevant mailing lists.

> diff --git a/arch/powerpc/lib/crypto/Kconfig b/arch/powerpc/lib/crypto/Kconfig
> new file mode 100644
> index 0000000000000..3f9e1bbd9905b
> --- /dev/null
> +++ b/arch/powerpc/lib/crypto/Kconfig
> @@ -0,0 +1,22 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +config CRYPTO_CHACHA20_P10
> +	tristate
> +	depends on PPC64 && CPU_LITTLE_ENDIAN && VSX
> +	default CRYPTO_LIB_CHACHA
> +	select CRYPTO_LIB_CHACHA_GENERIC
> +	select CRYPTO_ARCH_HAVE_LIB_CHACHA
> +
> +config CRYPTO_POLY1305_P10
> +	tristate
> +	depends on PPC64 && CPU_LITTLE_ENDIAN && VSX
> +	depends on BROKEN # Needs to be fixed to work in softirq context
> +	default CRYPTO_LIB_POLY1305
> +	select CRYPTO_ARCH_HAVE_LIB_POLY1305
> +	select CRYPTO_LIB_POLY1305_GENERIC
> +
> +config CRYPTO_SHA256_PPC_SPE
> +	tristate
> +	depends on SPE
> +	default CRYPTO_LIB_SHA256
> +	select CRYPTO_ARCH_HAVE_LIB_SHA256

Really?

- Eric

