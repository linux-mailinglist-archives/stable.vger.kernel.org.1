Return-Path: <stable+bounces-120217-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A7FA4D795
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 10:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2537E3AA111
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 09:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FEB01FBCBF;
	Tue,  4 Mar 2025 09:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HtNE5ZwP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0783E189528;
	Tue,  4 Mar 2025 09:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741079558; cv=none; b=jjsyjUgyZqRAKCXCIED8jfoeuHKI6d/ZxA7mDzCdlWV1Zm14kmUvqqf8uPCMV2NHoKcNuls/L0hOlMLXYJM6U/zePr5g+NWTerieJ8GgWgs5p0joEJmF93U5/P/nludJIRInCpFm6cXKcyet0JEslEdYRQO+KL8Eyves+radp0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741079558; c=relaxed/simple;
	bh=1Qpfy3Zvq8F9m3xCtMjd6gWMsu7LuwIbW6obX7fT2i8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ryhhJOd3/eThWyNh1QEeDfKxBUxM2ala3+QCD3pLOYVLCySjAjuOsZAO5ww8lFBPDhCskUyDKbXio7oikdJfr5HeImJ3BP/2rLtCcMiitNGXFwflNd3sTZFP0N1zyaz6cNeohyFGZinlyqnSPtohXlsu4wgDgo6mvWi5UiFUvJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HtNE5ZwP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D4E7C4CEEA;
	Tue,  4 Mar 2025 09:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741079557;
	bh=1Qpfy3Zvq8F9m3xCtMjd6gWMsu7LuwIbW6obX7fT2i8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HtNE5ZwPFHTlDnWJhDpEwLdyYgR+ecgarCKB1ymj8pejvJFzx8mTHIy0WAQMfTsur
	 tNO3tlupfO+hvQxJ2qbyWuk749dNRlrh+ha/vjUaYqVhmeu/J17ttutBZMonWoyqLw
	 j64eWOKFpV+kby30+oF31LwYIvNpVCKoMTAECeFSikryIV359FprpaQIAMsF7ZQmgT
	 BzilRk2ry4ybp9TEb4Mwrkp+wJ2ZVWmfIwd+PukFsMeTcl+kxWp0/sw3pkr7tEHjgd
	 f8M/05KnA/MCgtweLP8UqxwmJy4Mo2yr9C/3LOlVmVIf65AaljDFumwmnZAW6eWw48
	 CjtrXa2kczSoA==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-abf538f7be0so459607666b.3;
        Tue, 04 Mar 2025 01:12:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVYi8WRgUlgPk9TV+KXhpnRYXY2rWa+Y80icvQQ2wAyzCGgDvWAdNuogU2MVzXLR9OqAC3xqUrU/ZrUP14=@vger.kernel.org, AJvYcCWeF2f2lrrvtgZp1obqMDx7gO9sB1qglP6CwvHLLz4msIkB2NfcAs8P6uHXMgLa6E2xdKv6H+0n@vger.kernel.org, AJvYcCXVyYTJapw9LEH2jyPjIvMO3QPZiImzzxwLwZIqvpTlstrekUJaHBPojdY00DLQVJuVcIxOeKjHhV29WalD1Vw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtjrDvyOBbalRLcRg4gOvUc1aLMWSQFH1QhOKmsCfjk21GCo3X
	xtU9X+IYzSc6xj9aOgNSHvOXddEiiRRjk3qCUlYDwwoMMWHeT1strZX7YMBdcana5lBWFvRpUA6
	LAKUGcjVByX7jK3R+UqMckquLUCo=
X-Google-Smtp-Source: AGHT+IH2SgX4aUGNkkw2aLENO08CdBohYV/2qS8B86jrVMJUU7M4mrsCUBPz7DNzEajQfmfUU1WqKQWdeCX9cPf6nuk=
X-Received: by 2002:a17:907:d1b:b0:abf:7a26:c484 with SMTP id
 a640c23a62f3a-abf7a26c6cemr587565566b.46.1741079556157; Tue, 04 Mar 2025
 01:12:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250304073554.20869-1-wangrui@loongson.cn> <aab657d72a3ee578e5c7a09c6c044e0d5c5add9a.camel@xry111.site>
In-Reply-To: <aab657d72a3ee578e5c7a09c6c044e0d5c5add9a.camel@xry111.site>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 4 Mar 2025 17:12:24 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5ayw7NxbSbCeAFaxOz+TZ8QeghmhW6-j2B1vTcjYxsJQ@mail.gmail.com>
X-Gm-Features: AQ5f1Jrmu3QkofUkgSVv14_9s0-0IlCDV35VINfTj4fgFw6W6IhF1VQfXIJgbuI
Message-ID: <CAAhV-H5ayw7NxbSbCeAFaxOz+TZ8QeghmhW6-j2B1vTcjYxsJQ@mail.gmail.com>
Subject: Re: [PATCH] rust: Fix enabling Rust and building with GCC for LoongArch
To: Xi Ruoyao <xry111@xry111.site>
Cc: WANG Rui <wangrui@loongson.cn>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
	loongson-kernel@lists.loongnix.cn, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 3:49=E2=80=AFPM Xi Ruoyao <xry111@xry111.site> wrote=
:
>
> On Tue, 2025-03-04 at 15:35 +0800, WANG Rui wrote:
> > This patch fixes a build issue on LoongArch when Rust is enabled and
> > compiled with GCC by explicitly setting the bindgen target and skipping
> > C flags that Clang doesn't support.
> >
> > Cc: stable@vger.kernel.org
> > Signed-off-by: WANG Rui <wangrui@loongson.cn>
> > ---
> >  rust/Makefile | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/rust/Makefile b/rust/Makefile
> > index ea3849eb78f6..2c57c624fe7d 100644
> > --- a/rust/Makefile
> > +++ b/rust/Makefile
> > @@ -232,7 +232,8 @@ bindgen_skip_c_flags :=3D -mno-fp-ret-in-387 -mpref=
erred-stack-boundary=3D% \
> >       -mfunction-return=3Dthunk-extern -mrecord-mcount -mabi=3Dlp64 \
> >       -mindirect-branch-cs-prefix -mstack-protector-guard% -mtraceback=
=3Dno \
> >       -mno-pointers-to-nested-functions -mno-string \
> > -     -mno-strict-align -mstrict-align \
> > +     -mno-strict-align -mstrict-align -mdirect-extern-access \
> > +     -mexplicit-relocs -mno-check-zero-division \
>
> Hmm I'm wondering if we can just drop -mno-check-zero-division from
> cflags-y: for all GCC releases it's the default at either -O2 or -Os,
> and AFAIK we don't support other optimization levels.
Don't rely on  default behavior, things may change in future.
Acked-by: Huacai Chen <chenhuacai@loongson.cn>

>
> --
> Xi Ruoyao <xry111@xry111.site>
> School of Aerospace Science and Technology, Xidian University

