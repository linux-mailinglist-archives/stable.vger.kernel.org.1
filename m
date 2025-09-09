Return-Path: <stable+bounces-179083-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E6C1B4FDFF
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 15:49:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4D753A2918
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 13:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7982635AAD1;
	Tue,  9 Sep 2025 13:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XcKQPw8r"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1CB35A29C
	for <stable@vger.kernel.org>; Tue,  9 Sep 2025 13:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757425289; cv=none; b=iTAPjTWw6KjtSu/4PPGmSEjMcZuImc4Aiy/VItc8hcCXYQDmOM60vnMSzck0azx5L887Nr0lmFm3n1yoi4/9/m67TWxS2vU8IVVJ5KKfyooK2zOxbZamFCZcaR+1xca42I37Ld3g31jvOaAzFxUxWZzzsWKoR16Uj4AtRkbRKG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757425289; c=relaxed/simple;
	bh=hxrA1u0i3QdX2WF0YP/9Yngh01/0dr4Fi2cGW2VCD8E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EdZjIuNB5r2cwPlVGpPtBRMUHA9Xgvni6GNrMRoOjOhgqKLD9blkkSL93/FY4MtuNkzSTWDVzuVfafwGtD34Vpj4UIKpnXXxPRQv9eXxQUcZPv/cjDP6IbKQg9LkFS6iKt7w1zJiE6BEGyFJQ57cBF94DJvnJ6Qi6WuoUgR8A0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XcKQPw8r; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3e751508f3aso481639f8f.0
        for <stable@vger.kernel.org>; Tue, 09 Sep 2025 06:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757425285; x=1758030085; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vGCVFLl/bZU4VqXRso3PPgDeP8aVgDKQ3+zbC69nRRQ=;
        b=XcKQPw8r/C6D5PvmnmJ556JFF0M9xQeWw2enHjc+itOEQlB7IZz4k2Ytdir556DluM
         lc6BO/eQtitx1pV5po/LvND1m+2ZaHPjzF5O0BbLTikha7p0AfqD5XbsiPTRA4n8VE5Z
         VyUw2lXwtNOrzeFGNw7f5SopgM3eP9Yqw21+YQYsnCG6VgqpzcxA9A+3kJLEkFcQvQIR
         WsY8RJV2+8iSAifgTxjav6z0E37jlLvzd+cnYrldJfmw6VqhWAziKJ0SLxHwkGrYLT4v
         W/aaGpIwEYbYkGMJYWzjnvTmoihy1l0cKXFO5XT72g7m7z6AXCeK5fhD+zvhxij2NuM4
         2B6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757425285; x=1758030085;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vGCVFLl/bZU4VqXRso3PPgDeP8aVgDKQ3+zbC69nRRQ=;
        b=wYr81c/hW4PPPOFzx7pvuNRzdww5QB4US7tvG/Kmop/k7DqyYF9JZltWXS/63D2jGE
         X23w6aFhvA7TRcp+flUB3Z4PAafdPeZjC8H+9OwrjEshczMMVffUFK7QJkltq5KAncmY
         8nygCckJu52TYQ5kKLrxOkB1XQQj/+/5LnEUw721fTXDjlAWsXjWhY9385UnNWd9hzC8
         YM09OVP6BPKF3fMrIJoJQ/StUwoMLzeYRNl0wYNC9dTbpdOgQiELoPxbUBT5txmGl+v4
         Yn+9Noq+GjPYuJsdC+uzxRUIT6IcNXkfuP6PQ12+JpjDJNRa2jN6bPhhgLQ0Ng6kL2wb
         16WQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOeFABx3AFqwmrYAdmVTOqvbyZ4PNLhaH4XXyLonVQVw8BVLa9z5lTUFmwdOb7Al9DZQBFc0g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLYjoDxzPXDYoOMSp1YRRmv2ZHZPCY97OitC0MUkccT9H5ZBQ4
	bzbgLkVTfu1gd7kJyxRH5UznEOYi0SchW/E4gjIx/m+Ws9moG2BxDmKfhZbjYnTq66twu6o/7ix
	2xoEEHtW8RM9C8xalYA==
X-Google-Smtp-Source: AGHT+IE/mmAbQTOt8MvZZNGslJ2H2GmSSbN9MpzaubBetSPclclKq6OgKdnhJfvpCbHxNnnHv8DltcQ3KGr2Jow=
X-Received: from wrwa18.prod.google.com ([2002:a5d:53d2:0:b0:3d7:c499:56f])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2f87:b0:3d7:df92:5e31 with SMTP id ffacd0b85a97d-3e641e3b09amr11045695f8f.16.1757425285136;
 Tue, 09 Sep 2025 06:41:25 -0700 (PDT)
Date: Tue, 9 Sep 2025 13:41:24 +0000
In-Reply-To: <202509082009.4A8DC97BD2@keescook>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250908-distill-lint-1ae78bcf777c@spud> <202509082009.4A8DC97BD2@keescook>
Message-ID: <aMAuhKfrYRlkTHSy@google.com>
Subject: Re: [PATCH v1] rust: cfi: only 64-bit arm and x86 support CFI_CLANG
From: Alice Ryhl <aliceryhl@google.com>
To: Kees Cook <kees@kernel.org>
Cc: Conor Dooley <conor@kernel.org>, linux-kernel@vger.kernel.org, 
	Conor Dooley <conor.dooley@microchip.com>, stable@vger.kernel.org, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Alexandre Ghiti <alex@ghiti.fr>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Matthew Maurer <mmaurer@google.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, 
	linux-riscv@lists.infradead.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 08, 2025 at 08:11:48PM -0700, Kees Cook wrote:
> On Mon, Sep 08, 2025 at 02:12:35PM +0100, Conor Dooley wrote:
> > From: Conor Dooley <conor.dooley@microchip.com>
> >=20
> > The kernel uses the standard rustc targets for non-x86 targets, and out
> > of those only 64-bit arm's target has kcfi support enabled. For x86, th=
e
> > custom 64-bit target enables kcfi.
> >=20
> > The HAVE_CFI_ICALL_NORMALIZE_INTEGERS_RUSTC config option that allows
> > CFI_CLANG to be used in combination with RUST does not check whether th=
e
> > rustc target supports kcfi. This breaks the build on riscv (and
> > presumably 32-bit arm) when CFI_CLANG and RUST are enabled at the same
> > time.
> >=20
> > Ordinarily, a rustc-option check would be used to detect target support
> > but unfortunately rustc-option filters out the target for reasons given
> > in commit 46e24a545cdb4 ("rust: kasan/kbuild: fix missing flags on firs=
t
> > build"). As a result, if the host supports kcfi but the target does not=
,
> > e.g. when building for riscv on x86_64, the build would remain broken.
> >=20
> > Instead, make HAVE_CFI_ICALL_NORMALIZE_INTEGERS_RUSTC depend on the onl=
y
> > two architectures where the target used supports it to fix the build.
>=20
> I'm generally fine with this, but normally we do arch-specific stuff
> only in arch/$arch/Kconfig, and expose some kind of
> ARCH_HAS_CFI_ICALL_NORMALIZE_INTEGERS that would get tested here. Should
> we do that here too?

I'm thinking in this case it makes sense to keep this patch simple as
it's a fix. Once rustc supports cfi on riscv (which should really just
be changing the target to list it as supported), we can reorganize it to
match what you're describing at that point.

> > CC: stable@vger.kernel.org
> > Fixes: ca627e636551e ("rust: cfi: add support for CFI_CLANG with Rust")
> > Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> > ---
> > CC: Paul Walmsley <paul.walmsley@sifive.com>
> > CC: Palmer Dabbelt <palmer@dabbelt.com>
> > CC: Alexandre Ghiti <alex@ghiti.fr>
> > CC: Miguel Ojeda <ojeda@kernel.org>
> > CC: Alex Gaynor <alex.gaynor@gmail.com>
> > CC: Boqun Feng <boqun.feng@gmail.com>
> > CC: Gary Guo <gary@garyguo.net>
> > CC: "Bj=C3=B6rn Roy Baron" <bjorn3_gh@protonmail.com>
> > CC: Benno Lossin <lossin@kernel.org>
> > CC: Andreas Hindborg <a.hindborg@kernel.org>
> > CC: Alice Ryhl <aliceryhl@google.com>
> > CC: Trevor Gross <tmgross@umich.edu>
> > CC: Danilo Krummrich <dakr@kernel.org>
> > CC: Kees Cook <kees@kernel.org>
> > CC: Sami Tolvanen <samitolvanen@google.com>
> > CC: Matthew Maurer <mmaurer@google.com>
> > CC: "Peter Zijlstra (Intel)" <peterz@infradead.org>
> > CC: linux-kernel@vger.kernel.org
> > CC: linux-riscv@lists.infradead.org
> > CC: rust-for-linux@vger.kernel.org
> > ---
> >  arch/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/arch/Kconfig b/arch/Kconfig
> > index d1b4ffd6e0856..880cddff5eda7 100644
> > --- a/arch/Kconfig
> > +++ b/arch/Kconfig
> > @@ -917,6 +917,7 @@ config HAVE_CFI_ICALL_NORMALIZE_INTEGERS_RUSTC
> >  	def_bool y
> >  	depends on HAVE_CFI_ICALL_NORMALIZE_INTEGERS_CLANG
> >  	depends on RUSTC_VERSION >=3D 107900
> > +	depends on ARM64 || X86_64
> >  	# With GCOV/KASAN we need this fix: https://github.com/rust-lang/rust=
/pull/129373
> >  	depends on (RUSTC_LLVM_VERSION >=3D 190103 && RUSTC_VERSION >=3D 1082=
00) || \
> >  		(!GCOV_KERNEL && !KASAN_GENERIC && !KASAN_SW_TAGS)
> > --=20
> > 2.47.2
> >=20
>=20
> --=20
> Kees Cook

