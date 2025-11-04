Return-Path: <stable+bounces-192340-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A06DC2FD97
	for <lists+stable@lfdr.de>; Tue, 04 Nov 2025 09:26:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0C4A734D761
	for <lists+stable@lfdr.de>; Tue,  4 Nov 2025 08:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27674315D56;
	Tue,  4 Nov 2025 08:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VLaWHizn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7EE2315D52
	for <stable@vger.kernel.org>; Tue,  4 Nov 2025 08:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762244537; cv=none; b=V9Ne/Q6mzbEXqdbf0S0W1jhBspr7cIuHNRjvUshI5QfX3oFaCVbdSkzNmEx4bv+YiWoGkaEKoZh6OW9MnUmKpf3l/y/FYYvhijF9ZOIFrr4jwpKQBZEGHEbL6noVtA25AT0jKjzkgd2Q0Otqrd4Rq4cD0yhec2f1aQWDRlaYQjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762244537; c=relaxed/simple;
	bh=f0ExexZSvSjh6pxIi8QuIB/M9WbshjMNb7Xh3MO5KaE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dFkfZhqK1yIZfNY+N1ghTfS8bCwXAPgrCH1u1+fV/LUhD4jNiJJYeU71I4t5LaSeRnNwrXEgbbXjjq64S2nScdIFLurnm3uGRo6ZDUVZmI0GDgMZxZ84ZiKf7sUYyN4j5urefa0hDsP+Hh9ZwDRj8jErySpklmldkhWrlRvgwow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VLaWHizn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84D71C4CEF7
	for <stable@vger.kernel.org>; Tue,  4 Nov 2025 08:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762244537;
	bh=f0ExexZSvSjh6pxIi8QuIB/M9WbshjMNb7Xh3MO5KaE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VLaWHizn94jal3QBfxMd/BJoRoSh9RpAuA13xpAWd3Yyv8gcZPalSX2SOTZdWFJ92
	 EssLR0SB98U9DGgcVOjPNWggSOs6dh1F1k069nnQm/rpQadytABN+aN1mVitTmd99k
	 d9O0lUwrDURTzQw8pD4Xi40srqs1reQkrYy6tjMP0OPowAPg1kujrKiL9y69XBuDtV
	 1GGZCDCvLSRmckzRiXEEM7BRvkdFHpkbggnJnx8J0cKJyJcDbSXRzmLmoRsEqKELJW
	 c1YaHqlPP3H7W4uTwj5OwmKVxnNIsyl5TQdKCrRx+gVcFthwaYH4OV7/L+foS0uKZI
	 3D3uUn0r0ytOA==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-3652d7800a8so39682001fa.0
        for <stable@vger.kernel.org>; Tue, 04 Nov 2025 00:22:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX20kNiDm3s5prH/dNXY9keoSDUEvlP2j2WUJLIk4zefxzafwZNWY1xQJcZ0ROD2PCErJYoINY=@vger.kernel.org
X-Gm-Message-State: AOJu0YymcDAIGX/gGE7xebqrLVsEceYmmKZim3571sxgWLezVukm9ZrL
	OvBjNi3Gg+7HcFnq0ZMhyGYIEpiHiFxrdHJYDdfXHtCIUp50HTRrk1yGcX7Q3Le6z1Cb7Yen75q
	UDxkH3nebS4++Ue+t4dkr0O3V3b5rI7A=
X-Google-Smtp-Source: AGHT+IGg0J5ZRtiOoWdnps03k5E7YutbmyfCk230k7Pme1eseXmkIDg55LnE6Nfi0UlvvPP2AWGfgfJVJAdLVgfvcGk=
X-Received: by 2002:a2e:80d7:0:b0:36d:6ae3:8158 with SMTP id
 38308e7fff4ca-37a18dca6fcmr39923761fa.25.1762244535963; Tue, 04 Nov 2025
 00:22:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104054906.716914-1-ebiggers@kernel.org>
In-Reply-To: <20251104054906.716914-1-ebiggers@kernel.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 4 Nov 2025 09:22:04 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEu2G+XBKqK6KPGCaNWr9hLZ4xJHwG2+_BZ6DYdO8JKpw@mail.gmail.com>
X-Gm-Features: AWmQ_bnbmOEiAvvcVM5m53o8_1hNWBUrXac4nkeIBPil7jYX7BfUJq098pZKe0I
Message-ID: <CAMj1kXEu2G+XBKqK6KPGCaNWr9hLZ4xJHwG2+_BZ6DYdO8JKpw@mail.gmail.com>
Subject: Re: [PATCH] lib/crypto: arm/curve25519: Disable on CPU_BIG_ENDIAN
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Jason A . Donenfeld" <Jason@zx2c4.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 4 Nov 2025 at 06:51, Eric Biggers <ebiggers@kernel.org> wrote:
>
> On big endian arm kernels, the arm optimized Curve25519 code produces
> incorrect outputs and fails the Curve25519 test.  This has been true
> ever since this code was added.
>
> It seems that hardly anyone (or even no one?) actually uses big endian
> arm kernels.  But as long as they're ostensibly supported, we should
> disable this code on them so that it's not accidentally used.
>
> Note: for future-proofing, use !CPU_BIG_ENDIAN instead of
> CPU_LITTLE_ENDIAN.  Both of these are arch-specific options that could
> get removed in the future if big endian support gets dropped.
>
> Fixes: d8f1308a025f ("crypto: arm/curve25519 - wire up NEON implementation")
> Cc: stable@vger.kernel.org
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> ---
>
> This patch is targeting libcrypto-fixes
>
>  lib/crypto/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Acked-by: Ard Biesheuvel <ardb@kernel.org>

> diff --git a/lib/crypto/Kconfig b/lib/crypto/Kconfig
> index 8886055e938f..16859c6226dd 100644
> --- a/lib/crypto/Kconfig
> +++ b/lib/crypto/Kconfig
> @@ -62,11 +62,11 @@ config CRYPTO_LIB_CURVE25519
>           of the functions from <crypto/curve25519.h>.
>
>  config CRYPTO_LIB_CURVE25519_ARCH
>         bool
>         depends on CRYPTO_LIB_CURVE25519 && !UML && !KMSAN
> -       default y if ARM && KERNEL_MODE_NEON
> +       default y if ARM && KERNEL_MODE_NEON && !CPU_BIG_ENDIAN
>         default y if PPC64 && CPU_LITTLE_ENDIAN
>         default y if X86_64
>
>  config CRYPTO_LIB_CURVE25519_GENERIC
>         bool
>
> base-commit: 1af424b15401d2be789c4dc2279889514e7c5c94
> --
> 2.51.2
>

