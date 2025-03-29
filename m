Return-Path: <stable+bounces-126995-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B187A75542
	for <lists+stable@lfdr.de>; Sat, 29 Mar 2025 09:53:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A01611891A40
	for <lists+stable@lfdr.de>; Sat, 29 Mar 2025 08:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0FE18DF93;
	Sat, 29 Mar 2025 08:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e65lhkwZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525D035972;
	Sat, 29 Mar 2025 08:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743238377; cv=none; b=IpfUIncuTeXMT/rxHNrJWbu5cCrIVBog9w/tUi9u1D3Hguy0AjM7B2uOQrD3O6LV2MuLGEYTlY1e3+liMteM3zccKA6kTenzNQzfvPyWFqZu3D/eMJmjT2RpWZnyK172nq0+PFKmMnlzoMdPlIs0IqruF8yYb/eoXZoNCwczU6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743238377; c=relaxed/simple;
	bh=VuNKaSttNCraDAMFXX4IwdkGLy4R9KErqa/ImpP7GDI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uTTXN9vqIhjcWVmSM+dxr5GPABa+4uRvEfLfi18/zTvCBbDKhOHrqh7x/7pQ+8bqBIw/lslPx/hetlOvvtjaghqOHPw3HLUvqhabRLzc4EykP0OzbkJ1wi7RYFdMgMDL1UiGKeM3JQic3Va1a7GGQEMWa7c7uvmBj1JyhVyaS3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e65lhkwZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C41E9C4CEE2;
	Sat, 29 Mar 2025 08:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743238376;
	bh=VuNKaSttNCraDAMFXX4IwdkGLy4R9KErqa/ImpP7GDI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=e65lhkwZazJXDxHke7ITrqrGsNTa/7lBo7ScI8lwRLjDm+wC1YFiDX5bnYK75Hw4P
	 y+WJSwrfTZtXQ4EhINWX/wJTpVu4SiMprLh0xw2x7UGUa8/qljf1W/ooggQqTnJnY1
	 u49qG78g/yRn/Q7TbulS4AG5ZLvW43fTNi/VXhGZjKgPoEvjg90LKngLl0JTc3ehX9
	 tbfiSM3wGV6/uIuWm6UCuB9+6eISC/dUQeCPeLw8V1/8Vbza0bl6TtBJJ9zeFws7wb
	 Hh+nDdJF50HT8ZOT+Yh/ieLHp6Q828JUrIbzT3bD0cqvTlezt8BBoY8Ut9KGa+2mBU
	 diRGhVYLs99/A==
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5e6167d0536so1689576a12.1;
        Sat, 29 Mar 2025 01:52:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUn7YVVrN99SK8VpnAVI5Lr6/i2eebryxxB2LLpRzS30CmZPzBUHDdr4jTFNsl1FSwILYhbmHaU@vger.kernel.org, AJvYcCVDG8XIX9kuuy0M/Yjz0JOTylZ+YTIskNg/jRJN8TgkiVcloe3pLG1RWjKVKmoIi4w6APl3WS0AsOw1Tx0=@vger.kernel.org, AJvYcCXARvY8tKOsZFNPaEtTSnh6qYDXyYQwhmMQH4kpcPGqSwEJWgwrlITLSOMO8Tj2jBOuT2t5w7fzwjsuxkzxv/g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEXa+d5CvTQpVPGcJPGioFs+RamU952ofde/a954Lcc34/WteB
	x4l5LSm6/GhNeGM7/lAoN6SRRABpeAcmgmInImsSNPKmtj4SwYHyBjxLYnMxt5ofP75RVqWjhhP
	wObWKkW3CpvbadxCjdGHCe5uBnXE=
X-Google-Smtp-Source: AGHT+IFcTBlHFMe+cnzJ3GscmxD7DadfgO659/mYjAgkv2zsYhCstTT+cs4vEk+dCL2YR1W8PvXdP/Jf5yhQc854D64=
X-Received: by 2002:a17:907:6092:b0:ac4:491:1549 with SMTP id
 a640c23a62f3a-ac738a088edmr212495866b.1.1743237957112; Sat, 29 Mar 2025
 01:45:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250304073554.20869-1-wangrui@loongson.cn> <aab657d72a3ee578e5c7a09c6c044e0d5c5add9a.camel@xry111.site>
 <CAAhV-H5ayw7NxbSbCeAFaxOz+TZ8QeghmhW6-j2B1vTcjYxsJQ@mail.gmail.com> <CANiq72=AZ+CN4SScZcnRBpkS8ogCaZ=Uhe=k7fhGCVyecyRu5g@mail.gmail.com>
In-Reply-To: <CANiq72=AZ+CN4SScZcnRBpkS8ogCaZ=Uhe=k7fhGCVyecyRu5g@mail.gmail.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sat, 29 Mar 2025 16:45:49 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5Yc8d4qSN0Fwe=wShXHzJrdJ0KX87kV0_0ToQiHBEECQ@mail.gmail.com>
X-Gm-Features: AQ5f1Jo_BhIWW_S-wVrrfYgevxjvR72OSEu-wwQPjbXYleu9ZtV1saltGmiCwUg
Message-ID: <CAAhV-H5Yc8d4qSN0Fwe=wShXHzJrdJ0KX87kV0_0ToQiHBEECQ@mail.gmail.com>
Subject: Re: [PATCH] rust: Fix enabling Rust and building with GCC for LoongArch
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Xi Ruoyao <xry111@xry111.site>, WANG Rui <wangrui@loongson.cn>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
	loongson-kernel@lists.loongnix.cn, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Miguel,

On Sat, Mar 29, 2025 at 12:15=E2=80=AFAM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Tue, Mar 4, 2025 at 10:12=E2=80=AFAM Huacai Chen <chenhuacai@kernel.or=
g> wrote:
> >
> > Don't rely on  default behavior, things may change in future.
> > Acked-by: Huacai Chen <chenhuacai@loongson.cn>
>
> I was pinged about this one -- are you picking this one through your tree=
?
OK, I wll pick it to the loongarch tree, thanks.

Huacai

>
> I didn't test it, but the change seems safe to me for other
> architectures that we have at the moment, since they don't seem to set
> any of those three from a quick look, so:
>
> Acked-by: Miguel Ojeda <ojeda@kernel.org>
>
> In any case, the usual question for these "skipped flags" is whether
> they could affect the output of `bindgen`, i.e. could they modify
> layouts somehow?
>
> Also, it would be nice to mention a bit more what was the build error
> and the GCC version in the commit message.
>
> Finally, regarding the Cc: stable, I guess that means 6.12+ since it
> is the first LTS with loongarch64, right?
>
> Thanks!
>
> Cheers,
> Miguel

