Return-Path: <stable+bounces-116235-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E629BA34747
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 16:33:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9E707A3B3F
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 15:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD4C18DF6D;
	Thu, 13 Feb 2025 15:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zu0rm2RY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D1E1865EE;
	Thu, 13 Feb 2025 15:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739460784; cv=none; b=ZmUQwT6La6N18cbEnKIHFMfolvOKQ0JEMkbgx1BCo0op1TFByod0MdvHVarnO11ZGE9FQ1OAqlj7rqyNioxmuWEV7hAKicsoueqxJ9jv6lSoXbxbUzY9joC0qrwHHyb1Alc0pXKBmKAgWbZbeDfLNQB+8znaaetWm3w01B5JSWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739460784; c=relaxed/simple;
	bh=t8QMv5hVTQ+R0IqU8p9CIOvH1ExAEP3a6Vf8v5IaDu0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nwBFaZkdW1J/PlPyP+BmZFLXz+yWNPvTB71Epa5iLXBk6vBM1m4/G36f5fvZitjFaIzBdzsZxHx0xXdUx2nN95Q3Hp7YGzmxgiPtCYqx0G3I+KGlObbBtUZIAW0+zDKBINKmXS6tKED+dkZbl59ndLde3g/isscwl7mXl/o0A5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zu0rm2RY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1DC6C4CEF8;
	Thu, 13 Feb 2025 15:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739460783;
	bh=t8QMv5hVTQ+R0IqU8p9CIOvH1ExAEP3a6Vf8v5IaDu0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Zu0rm2RYHRQAFLzKn4r1HNUMm8YFtDy2MYYtFUpabmqvXs66874sy8GDK5fdm9ZHY
	 w5QC+it44v0XhZy8u8SLZWzM+Uo8+2eibnrdhjONcomdz+gkA8LKnLBcvxYEa3awEK
	 4waS3GORPbRaeRFxe5NCxvQ6EoBVx5VNLpueKTNBqvdUV4k8fp5uUc1dCq0vmuQ03H
	 QuGWQedP5GwbmxOZI29HQuY93RVX6y37ArJWxIhnXpzsKFhWpzXmyLol1k+UYuNb0k
	 Ggp6cSPIzMlGEwTKeAOmsHe+NmdczDjA7zD9K3RavX3gAEnscHDnItccaRUyQHOAJp
	 yCkILzAzWDACg==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-54506b54268so968742e87.3;
        Thu, 13 Feb 2025 07:33:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUYWBBNQ5Ut66pjosYl8YRPKT8qAOfI9qCECcALv/0hv0kSpe+/hjmyKx19wWRJjS3r99NCLmq+@vger.kernel.org, AJvYcCV96RfVCZSCTZSmw4JAwYKdHaRIJhCHXEi7X7s3LFkQ/Ky7GHwyxb/bCwtuDOp2x+4saD9JwIMBOCcj9AI=@vger.kernel.org, AJvYcCVtdghud2YIuYvpDvbffBF2KUOvKZvtjwgnjHhMUgMvGhNs2h+UL9P4Upo2azWxPTHmbzX34HxnzS1kO9X/EiI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/0yRR0gi+aUHMUzJZuApMo0Pfn5wdxM29VfYyWZ+LETbBtvtl
	yh5HZukYXT0YxSfqNUEz4yBuT7DZGy2ABXMmuWQvQnlRiQxRKO+vbvQHcDDkuAlOjiopAUSKXkr
	G+oS3nsFgvmMnr+swMF3T2lOjyIc=
X-Google-Smtp-Source: AGHT+IFn/vzxAa1gLojO/0597IUwEJuHjE+ZMbhdN6Wkn18KpSJ16vMq38P8PaQcagI5saZOuyRj6jrZinDRQOOBjFs=
X-Received: by 2002:a05:6512:1111:b0:545:6cf:6f3e with SMTP id
 2adb3069b0e04-5451dde81aemr1356458e87.49.1739460781858; Thu, 13 Feb 2025
 07:33:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210163732.281786-1-ojeda@kernel.org>
In-Reply-To: <20250210163732.281786-1-ojeda@kernel.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 13 Feb 2025 16:32:50 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHgjwHkLsJkM3H2pjEPXDvD80V+XhH_Gsjv8N4Cf6Bvkw@mail.gmail.com>
X-Gm-Features: AWEUYZmhbBgIMQcrZGkDUPbbIKzS9-BDPJ0yLZaCMkeMRCLb0heF4J8bVRc0_r0
Message-ID: <CAMj1kXHgjwHkLsJkM3H2pjEPXDvD80V+XhH_Gsjv8N4Cf6Bvkw@mail.gmail.com>
Subject: Re: [PATCH] arm64: rust: clean Rust 1.85.0 warning using softfloat target
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, 
	moderated for non-subscribers <linux-arm-kernel@lists.infradead.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev, stable@vger.kernel.org, 
	Matthew Maurer <mmaurer@google.com>, Ralf Jung <post@ralfj.de>, 
	Jubilee Young <workingjubilee@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 10 Feb 2025 at 17:38, Miguel Ojeda <ojeda@kernel.org> wrote:
>
> Starting with Rust 1.85.0 (to be released 2025-02-20), `rustc` warns
> [1] about disabling neon in the aarch64 hardfloat target:
>
>     warning: target feature `neon` cannot be toggled with
>              `-Ctarget-feature`: unsound on hard-float targets
>              because it changes float ABI
>       |
>       = note: this was previously accepted by the compiler but
>               is being phased out; it will become a hard error
>               in a future release!
>       = note: for more information, see issue #116344
>               <https://github.com/rust-lang/rust/issues/116344>
>
> Thus, instead, use the softfloat target instead.
>

We have to carefully make the distinction here between codegen and ABI.

The arm64 C code in the kernel is built with -mgeneral-regs-only
because FP/SIMD registers are not preserved/restored like GPRs, and so
they must be used only in carefully controlled circumstances, i.e., in
assembler code called under kernel_neon_begin()/kernel_neon_end()
[modulo some exceptions related to NEON intrinsics]

This does not impact the ABI, which remains hard-float [this was the
only arm64 calling convention that existed until about a year ago].
Any function that takes or returns floats or doubles (or NEON
intrinsic types) is simply rejected by the compiler.

Changing this to softfloat for Rust modifies this calling convention,
i.e., it will result in floats and doubles being accepted as function
parameters and return values, but there is no code in the kernel that
actually supports/implements that. Also, it should be clarified
whether using a softfloat ABI permits the compiler to use FP/SIMD
registers in codegen. We might still need -Ctarget-feature="-neon"
here afaict.

Ideally, we'd have a target/target-feature combo that makes this more
explicit: no FP/SIMD codegen at all, without affecting the ABI,
therefore making float/double types in function prototypes illegal.
AIUI, this change does something different.

