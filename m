Return-Path: <stable+bounces-204861-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F61ACF4EBA
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 18:11:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F47D311F8F4
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 17:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5722877D4;
	Mon,  5 Jan 2026 17:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OAjryMcf"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4308C3064B2
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 17:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767632612; cv=none; b=quA9YMB3N5KxeqF5y3kO1LCGWpw96ec0Vnv0HTtEsqlasHpTbVDbCU8LCYW4BOxQciNe5/V1zzxlKomTsbqohgnq1zeOM0zQBKrpAZMnV2y078uD9pVCG+6LINi5RUw5mb0xiG+yyqCTI/uy0hrTfW3NQnmm+299T6GfhAgRsJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767632612; c=relaxed/simple;
	bh=N14dZVc9vTLW0oh1eKAbE1UDroXlvYied7zrMk/D+UY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QB3XLLzR2Dn/JFob8PZulHkc3+FW0KQWBcSw7YdUNzb4l6asodh+X4vN/030nblG8zVSF1KaBjrjOIs8Mzc/o0ZctFD1tSSSY/oub2QGcrJl9SJH3Nyd5nq+ruaR7dJwOMSNhWT/kDiGO5/S2jlTUAe339JOfzHZB6fwwtlB/0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OAjryMcf; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-78fdb90b670so1712347b3.2
        for <stable@vger.kernel.org>; Mon, 05 Jan 2026 09:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767632608; x=1768237408; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rVdUSzzxHV8dZysVvdcW5SugnSBaNdFEMUgp6qzC8gU=;
        b=OAjryMcfOaoPOdTTIjcBidpPNScC681+Y/D6ehtb7EGbqOfJ0lRNcHXln4KtE+gZXi
         Hq0tK43fVTIHrevWf8JFs1g8hzVjVzNO1jDO6MQydhOs8uOl+oTCbdzaYAPS09Jq9vRU
         hh1KKYGI/MF3lTLSusyFthQhbPuGHa5t077JC+EQ/j8lVwcIbGatiAykPvTD8731nHJ7
         gLrSzww+hqv166I2ilnwWYj1b1mwWnPvNLW+mIAs1dKxRYqmtkjfJMRyFA3OaZO+HTfL
         USG2TS8/DWvhKfR16UuwZY9t8B4pu/8pWvFM7SjL9LCeuHqTB8mk6A1ekFUD8JjxuifC
         PSdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767632608; x=1768237408;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rVdUSzzxHV8dZysVvdcW5SugnSBaNdFEMUgp6qzC8gU=;
        b=uYYcKl3tGIzgEp600V0Qsi5jVQeFewh0Kb5Ob45MZxzUHyU73I0uFcqK/jV1wwyYhz
         9Zzl4LMtrPq+VKf5AeI7pLcLSN1QCUbzeeRGzHRJLxcJhJPNpneaob07PxGrfL77Bbs0
         VNmLdP8KFY31ZjDIeSE22clhBQuWYyIqSVnxcCzU+IUxWHzTD5jNZl/F8yV/P1Elt+rs
         YeiW/vciMz2LwdmfZQjQvZnK9koCnXw0TD4KKvuMo9cNzC0VaPyrlyKVAJgdAkPuRC6m
         GRdjmHtrwIbCPM+wDGJOdr7FBvKITSBJynk1UF1mvs7b/xWjxJMMajPcpiTkhF3ROwuz
         LP+w==
X-Forwarded-Encrypted: i=1; AJvYcCW1Gq4EyafEfKEWUZYZEp1NRLJcNuxz2GuIC+vOirk3Y+SrowAf4I7citWJGnX4mR/xOTOyeqw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlF9jzHJoGYuFe0iHQ5kopPfKulo5K9/ZP34JK2Ujsb57CjTWl
	7uN4XvORCNqUSXytMo32b3BDXIKcRMZzykFi/PXGM6i1e33a2p6WF6Mg
X-Gm-Gg: AY/fxX6T/F2PCTmwTsJ5gy4B2Fimk5whTcDUF9n3pJZscw1Zaom0ek78FSjG+hWNQcu
	pctF/bodoq5nL1YmLXG6PCtQ7u2W9wCI3zHT9Ht2Y/6Q6omZAplgQ/kDbrvInT5xOgLXKZqwqsg
	frzi3NieW3AJab37PV+o2zWvW/tjH7fIliCzTDHSgekf/ZyVh9hm0HOjK9g8Tl0rsHToxYaJHgA
	x6AB3NMERrRG5aWpGmaueTIp3IRLVwioxzZRtz4e2piVAzzW+KUx/gjhgPQBzSlFvjr5sslPZUO
	V2RJD5/okkQkx44mfi3NKxGVJ0lQRURGlsivvv1cUBoFnaIOJ6esUJQrPXC8qSE5/P2JpFT6jbC
	mMjbstugT1cAtBVYvjRafqhAiR+7tXJYBLHOoPgF+g2pd22I2/gDuFxxD+5w/naxSvOK7CNAUiv
	0BQH/spaE=
X-Google-Smtp-Source: AGHT+IFwZusyd0qviV3+UDmgZyv+kp9rf3jSujTbP0tJ/F8xB6jJMvw66Eng5dzCVjwg6hrobpRNAw==
X-Received: by 2002:a05:690c:3746:b0:787:f793:b573 with SMTP id 00721157ae682-790a8a87dc8mr2403767b3.29.1767632608366;
        Mon, 05 Jan 2026 09:03:28 -0800 (PST)
Received: from localhost ([2601:346:0:79bd:830c:9f83:df41:3e7d])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790a88ed5e6sm765547b3.55.2026.01.05.09.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 09:03:28 -0800 (PST)
Date: Mon, 5 Jan 2026 12:03:27 -0500
From: Yury Norov <yury.norov@gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Burak Emir <bqe@google.com>, Andreas Hindborg <a.hindborg@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] rust: bitops: fix missing _find_* functions on 32-bit
 ARM
Message-ID: <aVvu3zF2rYKR3XC0@yury>
References: <20260105-bitops-find-helper-v2-1-ae70b4fc9ecc@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260105-bitops-find-helper-v2-1-ae70b4fc9ecc@google.com>

On Mon, Jan 05, 2026 at 10:44:06AM +0000, Alice Ryhl wrote:
> atus: O
> Content-Length: 4697
> Lines: 121
> 
> On 32-bit ARM, you may encounter linker errors such as this one:
> 
> 	ld.lld: error: undefined symbol: _find_next_zero_bit
> 	>>> referenced by rust_binder_main.43196037ba7bcee1-cgu.0
> 	>>>               drivers/android/binder/rust_binder_main.o:(<rust_binder_main::process::Process>::insert_or_update_handle) in archive vmlinux.a
> 	>>> referenced by rust_binder_main.43196037ba7bcee1-cgu.0
> 	>>>               drivers/android/binder/rust_binder_main.o:(<rust_binder_main::process::Process>::insert_or_update_handle) in archive vmlinux.a
> 
> This error occurs because even though the functions are declared by
> include/linux/find.h, the definition is #ifdef'd out on 32-bit ARM. This
> is because arch/arm/include/asm/bitops.h contains:
> 
> 	#define find_first_zero_bit(p,sz)	_find_first_zero_bit_le(p,sz)
> 	#define find_next_zero_bit(p,sz,off)	_find_next_zero_bit_le(p,sz,off)
> 	#define find_first_bit(p,sz)		_find_first_bit_le(p,sz)
> 	#define find_next_bit(p,sz,off)		_find_next_bit_le(p,sz,off)
> 
> And the underscore-prefixed function is conditional on #ifndef of the
> non-underscore-prefixed name, but the declaration in find.h is *not*
> conditional on that #ifndef.
> 
> To fix the linker error, we ensure that the symbols in question exist
> when compiling Rust code. We do this by definining them in rust/helpers/
> whenever the normal definition is #ifndef'd out.
> 
> Note that these helpers are somewhat unusual in that they do not have
> the rust_helper_ prefix that most helpers have. Adding the rust_helper_
> prefix does not compile, as 'bindings::_find_next_zero_bit()' will
> result in a call to a symbol called _find_next_zero_bit as defined by
> include/linux/find.h rather than a symbol with the rust_helper_ prefix.
> This is because when a symbol is present in both include/ and
> rust/helpers/, the one from include/ wins under the assumption that the
> current configuration is one where that helper is unnecessary. This
> heuristic fails for _find_next_zero_bit() because the header file always
> declares it even if the symbol does not exist.
> 
> The functions still use the __rust_helper annotation. This lets the
> wrapper function be inlined into Rust code even if full kernel LTO is
> not used once the patch series for that feature lands.
> 
> Cc: stable@vger.kernel.org
> Fixes: 6cf93a9ed39e ("rust: add bindings for bitops.h")
> Reported-by: Andreas Hindborg <a.hindborg@kernel.org>
> Closes: https://rust-for-linux.zulipchat.com/#narrow/channel/x/topic/x/near/561677301
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Which means, you're running active testing, which in turn means that
Rust is in a good shape indeed. Thanks to you and Andreas for the work.

Before I merge it, can you also test m68k build? Arm and m68k are the
only arches implementing custom API there.

Thanks,
Yury

> ---
> Changes in v2:
> - Remove rust_helper_ prefix from helpers.
> - Improve commit message.
> - The set of functions for which a helper is added is changed so that it
>   matches arch/arm/include/asm/bitops.h
> - Link to v1: https://lore.kernel.org/r/20251203-bitops-find-helper-v1-1-5193deb57766@google.com
> ---
>  rust/helpers/bitops.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 
> diff --git a/rust/helpers/bitops.c b/rust/helpers/bitops.c
> index 5d0861d29d3f0d705a014ae4601685828405f33b..e79ef9e6d98f969e2a0a2a6f62d9fcec3ef0fd72 100644
> --- a/rust/helpers/bitops.c
> +++ b/rust/helpers/bitops.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  
>  #include <linux/bitops.h>
> +#include <linux/find.h>
>  
>  void rust_helper___set_bit(unsigned long nr, unsigned long *addr)
>  {
> @@ -21,3 +22,44 @@ void rust_helper_clear_bit(unsigned long nr, volatile unsigned long *addr)
>  {
>  	clear_bit(nr, addr);
>  }
> +
> +/*
> + * The rust_helper_ prefix is intentionally omitted below so that the
> + * declarations in include/linux/find.h are compatible with these helpers.
> + *
> + * Note that the below #ifdefs mean that the helper is only created if C does
> + * not provide a definition.
> + */
> +#ifdef find_first_zero_bit
> +__rust_helper
> +unsigned long _find_first_zero_bit(const unsigned long *p, unsigned long size)
> +{
> +	return find_first_zero_bit(p, size);
> +}
> +#endif /* find_first_zero_bit */
> +
> +#ifdef find_next_zero_bit
> +__rust_helper
> +unsigned long _find_next_zero_bit(const unsigned long *addr,
> +				  unsigned long size, unsigned long offset)
> +{
> +	return find_next_zero_bit(addr, size, offset);
> +}
> +#endif /* find_next_zero_bit */
> +
> +#ifdef find_first_bit
> +__rust_helper
> +unsigned long _find_first_bit(const unsigned long *addr, unsigned long size)
> +{
> +	return find_first_bit(addr, size);
> +}
> +#endif /* find_first_bit */
> +
> +#ifdef find_next_bit
> +__rust_helper
> +unsigned long _find_next_bit(const unsigned long *addr, unsigned long size,
> +			     unsigned long offset)
> +{
> +	return find_next_bit(addr, size, offset);
> +}
> +#endif /* find_next_bit */
> 
> ---
> base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
> change-id: 20251203-bitops-find-helper-25ed1bbae700
> 
> Best regard

