Return-Path: <stable+bounces-132008-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4868AA83375
	for <lists+stable@lfdr.de>; Wed,  9 Apr 2025 23:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5971A3B8FA3
	for <lists+stable@lfdr.de>; Wed,  9 Apr 2025 21:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429A52144BF;
	Wed,  9 Apr 2025 21:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fCw3vf4R"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5AD61E5713
	for <stable@vger.kernel.org>; Wed,  9 Apr 2025 21:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744234532; cv=none; b=sIwlT0Jyy0O/l91NK2YpPsKM9rM6A2PUt1DjsG+0EgeYcKgJUh22pu+GhMjNFMokhW44h+LF7Eipsp0aAXTt4IoL7o75v+d6WgVAoANT502yeB8AduUZV6srp/kPKsTtaR5Bdx4pKqvM2KfuFnu93l2wcg5+7NdMghhnjf/Wskc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744234532; c=relaxed/simple;
	bh=DtY0vGLHcf+CQtDC0YI1wt0uIFmrfTa1t3e4mx9zvdM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V56hUKIIGKieTvKUgI6OKI9l2bLmZYLR48TFYHI586D0VZDXtvbb6fTQaIwZcA3D7OVAvDlKBLZV7n/4zGdlrxaBjtITdjznBCUEJn92jLhpNVyJhVIKW0b3PhJtysdpUVSey9gkJz1tFY+R89sBal0ddl5kKR9niFN68PmC05w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fCw3vf4R; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5dbfc122b82so3612a12.0
        for <stable@vger.kernel.org>; Wed, 09 Apr 2025 14:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744234527; x=1744839327; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hBtSrPe7WZluOp+nomC0bfsWMrHWKW7U6czDExpfaAo=;
        b=fCw3vf4RkVMD5pOIcusYCTrUZap1afG4lCsUpH+n8vzMY/ljPsawNY1duH3HXfB7f8
         KfNvs0A7H2SLmw13begfhqmE206b+9W6CCylnvNXNhpkw26Trzloxg1S1GC0DSqXstBC
         jbL4as8zawV4hVKyg+kJUkdiVxaPtKgV7gbX/01VeWx0k4beP4JL8ThWTWOPkMw/g9r8
         pPMfv1pN+zBP8C1g1T4XdM0OCRs3yoZJLf1OMhCIvWkBkfB6sRLLwQoMStYB4NRvIEEJ
         BWgUInl1ss3N+kFgGTskG8XWOnAMizbsvv9r1/ME0j8Zwa6pKF8nGrDAVdG4CUUAw4s3
         oYNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744234527; x=1744839327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hBtSrPe7WZluOp+nomC0bfsWMrHWKW7U6czDExpfaAo=;
        b=rD3lvQ1rZQO9vzQ1IPsMZUXAXhGD040/S1h7UczS2qACp+Jqjoto/gshkgp1khLo7x
         LWyEMf23bMSLDtG9bz/AgqY5r9LyDRO/JmVGkOGB46OXMHrB6jwmBMac2xLossvr6/cp
         EGWTyp/J28qN+YKPLn18K2u92nZ1Ze8UGJYH1cMAhSFfnRsmsoIcl5sNntbULvNVhzbF
         5kngoXrXYeEvAW6J34vX3R4Y47hUaXGqLpIyqCzbsldpjXPHWutz4yK/yk2StWo20mcR
         hsb1B0XOm4KYlPX0vxjKw08Sxt228TCKc4hhgKMl62z6NnX3wFKrJI7AHTtAUNWgnKAu
         yVIA==
X-Forwarded-Encrypted: i=1; AJvYcCX74Ws02S3GDfN8xjU6HsJ/m84THaZsE7R3NJ/OoFQ9+F/rLr+/BRHaG0KkT9dnCjEU/qM+EKE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbIIsGPv1Utz895EZOfAPQE8R9HlyUpRA8ovu2/IL7GODO0phh
	T0h8KD7RB7qaJZNaI5RYgeG0LJ+VtGkmKiiWahFRLkBS3NYsE5PBL4CMLguUCaO5g9J8CUasA04
	cFpc7y9G8TCySxpp17Yxh9CI1xceP9ethqIL8
X-Gm-Gg: ASbGncsEylKN+/jVhpPNS3B8gTzHAwxTYPDrsxZOFxYrl6MVsNND6uPFNtOqlOrSj2F
	I4k+rTCsCFjvJ3NE3RQKKnlz7aq5o4GWHu5TOWG1kL5TU6P1ZtTv6i7y3V7K8BZNOhYVQCJ+oOb
	LEWBhxRCcCKqK9cvjc8x4YukebxJ4YEoLuI79FpATErqhcG4+Bh49Vvi9GD9H/Bd4=
X-Google-Smtp-Source: AGHT+IHPCp84FrskA1MxfUD14D4kgZf0Pn5Jyg9pNQCJj5QuZD0wTInhm0c57wkfzvcDWR168vHuSJT3TGtpjWG2WvY=
X-Received: by 2002:a50:99d7:0:b0:5ed:f521:e06c with SMTP id
 4fb4d7f45d1cf-5f3291cd5a2mr14691a12.7.1744234526715; Wed, 09 Apr 2025
 14:35:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250408220311.1033475-1-ojeda@kernel.org>
In-Reply-To: <20250408220311.1033475-1-ojeda@kernel.org>
From: Matthew Maurer <mmaurer@google.com>
Date: Wed, 9 Apr 2025 14:35:15 -0700
X-Gm-Features: ATxdqUFhVkSOwO53hFox7UAmqaM-iyfDXe_LO4ZiaZoTyX7HLUuRtwe61t2vc0E
Message-ID: <CAGSQo00QxBbUb8AxwqtRKXy96na_HUVmAG9nWmX=cVvozqwWaA@mail.gmail.com>
Subject: Re: [PATCH] rust: kasan/kbuild: fix missing flags on first build
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	Alexander Potapenko <glider@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	kasan-dev@googlegroups.com, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev, 
	Sami Tolvanen <samitolvanen@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 8, 2025 at 3:03=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wrot=
e:
>
> If KASAN is enabled, and one runs in a clean repository e.g.:
>
>     make LLVM=3D1 prepare
>     make LLVM=3D1 prepare
>
> Then the Rust code gets rebuilt, which should not happen.
>
> The reason is some of the LLVM KASAN `rustc` flags are added in the
> second run:
>
>     -Cllvm-args=3D-asan-instrumentation-with-call-threshold=3D10000
>     -Cllvm-args=3D-asan-stack=3D0
>     -Cllvm-args=3D-asan-globals=3D1
>     -Cllvm-args=3D-asan-kernel-mem-intrinsic-prefix=3D1
>
> Further runs do not rebuild Rust because the flags do not change anymore.
>
> Rebuilding like that in the second run is bad, even if this just happens
> with KASAN enabled, but missing flags in the first one is even worse.
>
> The root issue is that we pass, for some architectures and for the moment=
,
> a generated `target.json` file. That file is not ready by the time `rustc=
`
> gets called for the flag test, and thus the flag test fails just because
> the file is not available, e.g.:
>
>     $ ... --target=3D./scripts/target.json ... -Cllvm-args=3D...
>     error: target file "./scripts/target.json" does not exist
>
> There are a few approaches we could take here to solve this. For instance=
,
> we could ensure that every time that the config is rebuilt, we regenerate
> the file and recompute the flags. Or we could use the LLVM version to
> check for these flags, instead of testing the flag (which may have other
> advantages, such as allowing us to detect renames on the LLVM side).
>
> However, it may be easier than that: `rustc` is aware of the `-Cllvm-args=
`
> regardless of the `--target` (e.g. I checked that the list printed
> is the same, plus that I can check for these flags even if I pass
> a completely unrelated target), and thus we can just eliminate the
> dependency completely.
>
> Thus filter out the target.
>
> This does mean that `rustc-option` cannot be used to test a flag that
> requires the right target, but we don't have other users yet, it is a
> minimal change and we want to get rid of custom targets in the future.
>
> We could only filter in the case `target.json` is used, to make it work
> in more cases, but then it would be harder to notice that it may not
> work in a couple architectures.
>
> Cc: Matthew Maurer <mmaurer@google.com>
> Cc: Sami Tolvanen <samitolvanen@google.com>
> Cc: stable@vger.kernel.org
> Fixes: e3117404b411 ("kbuild: rust: Enable KASAN support")
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
> By the way, I noticed that we are not getting `asan-instrument-allocas` e=
nabled
> in neither C nor Rust -- upstream LLVM renamed it in commit 8176ee9b5dda =
("[asan]
> Rename asan-instrument-allocas -> asan-instrument-dynamic-allocas")). But=
 it
> happened a very long time ago (9 years ago), and the addition in the kern=
el
> is fairly old too, in 342061ee4ef3 ("kasan: support alloca() poisoning").
> I assume it should either be renamed or removed? Happy to send a patch if=
 so.
>
>  scripts/Makefile.compiler | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/Makefile.compiler b/scripts/Makefile.compiler
> index 8956587b8547..7ed7f92a7daa 100644
> --- a/scripts/Makefile.compiler
> +++ b/scripts/Makefile.compiler
> @@ -80,7 +80,7 @@ ld-option =3D $(call try-run, $(LD) $(KBUILD_LDFLAGS) $=
(1) -v,$(1),$(2),$(3))
>  # TODO: remove RUSTC_BOOTSTRAP=3D1 when we raise the minimum GNU Make ve=
rsion to 4.4
>  __rustc-option =3D $(call try-run,\
>         echo '#![allow(missing_docs)]#![feature(no_core)]#![no_core]' | R=
USTC_BOOTSTRAP=3D1\
> -       $(1) --sysroot=3D/dev/null $(filter-out --sysroot=3D/dev/null,$(2=
)) $(3)\
> +       $(1) --sysroot=3D/dev/null $(filter-out --sysroot=3D/dev/null --t=
arget=3D%,$(2)) $(3)\
>         --crate-type=3Drlib --out-dir=3D$(TMPOUT) --emit=3Dobj=3D- - >/de=
v/null,$(3),$(4))

The problem with this change is that some `rustc` flags will only be
valid on some platforms. For example, if we check if a
`-Zsanitizer=3Dshadow-call-stack` is available, it will fail for non
aarch64 targets. I don't think we're currently directly detecting any
of these, because all of the stuff we're using is known present by
virtue of minimum compiler version, which means we can possibly get
away with this change for now. That said, this isn't a long term
solution unless we are getting rid of target.json files altogether, as
one of the main adaptations we've been putting in those is to enable
additional target features.

>
>  # rustc-option
>
> base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
> --
> 2.49.0

