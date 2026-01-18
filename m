Return-Path: <stable+bounces-210244-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F9BD399FD
	for <lists+stable@lfdr.de>; Sun, 18 Jan 2026 22:28:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2BACB300A34D
	for <lists+stable@lfdr.de>; Sun, 18 Jan 2026 21:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC291276050;
	Sun, 18 Jan 2026 21:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l7IBoFct"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE60327A461
	for <stable@vger.kernel.org>; Sun, 18 Jan 2026 21:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768771692; cv=none; b=NSTlxgdmGrCdKT91stKLOyQOIBAreE9F4hDLKcsjyrr3HruJWNqSkhl1g+Vyn4u4Ml2LLF+SgPJ2PTZ+M+K91riACeNFCiQzGVqcO131ajBsegjQXo1j1KILTKjoe1tRQEnwpKJPBHSFJWQ4F+AwIwlw7hCjgjv6jZNrK6P8xS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768771692; c=relaxed/simple;
	bh=vMjNC2Tecqsx8qX3k0bRveOjlS/EXBttTZEBqFc2UQM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GmP+d6DCSyPwtk8/8cP3fqJ6g1xBDn1+W0rlP5r7gdGRUXkSzTL5Zy/qOhyDtHprgEphcjech1DId1UHL8UXdl1hIjed4w4qGrdxvkzFTSsnzZLHps116oS+bDWO6OQ6PotPGgyCE0csHKrFrpPGL2mXa0ZPchAcJIuvaU4Py1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l7IBoFct; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-42fb03c3cf2so2464140f8f.1
        for <stable@vger.kernel.org>; Sun, 18 Jan 2026 13:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768771689; x=1769376489; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oDaH472bfnhCIqyZjen1yWQU/ijPpbhjthhXvYN1hIc=;
        b=l7IBoFct5PFbMFortsr/kHXsgdv3btxnTCNp/CiM7j8lrV55RQEcNuEhwcOtc8TMoV
         vBPmYK3Eu1ndYOqpPJ0IlX6orYyWz3LaA/iRG4wKE+3bDvqY0GffxyFArC3xhBh0oD8I
         T6ErERViLhy229ny3s2y7+KDXmnEG67CCwIFVhvOnywI1Yj9ufRq0hufTJCvP6YZ1NtC
         xG69Th2AZiCp+O+0+C5bbJjuF4wZxDDUK1N8H7VZuRQU6gfxAvH7fXPqkjOO9NzcG5No
         RmzdhdLg1DhIXX8W15B6ZPByo6E6iFeJSTJHj+x615EiEGgKKEgbU7Oe1Xf7YZ+CtSKr
         IU9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768771689; x=1769376489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oDaH472bfnhCIqyZjen1yWQU/ijPpbhjthhXvYN1hIc=;
        b=S7/6FrTqhECxY80M/NlMBZFkXj5llfnmeHfKHfjeog+62cTQTRBKtAmUr/ZhP0zgUT
         eSy2PmsbuzDPZPOmvFLe1sE0iDC7rJog3GY1Ytg/en4LCWdGa0QZOveKKMtMuhOPo5nS
         WOT1LBwmuZ+YDV0/qTPgyzfMmRkSI+L58v6FD2wJsEt33UZNeE0n5I0oq6KpmWMaSgJO
         t+Lab2I4L4EEYXuGTzqtb39hjlGqvT6yuBJ++jKCVlJzNNtsAY5Pyf+X1o0bupi5zqRT
         N91BMOBgi3RIzBUZu6mHtMLnZSNc7EWcud9PMnjY5ItsJ9yu6ZfqqsLDdIb0qAgjCRof
         ACfw==
X-Forwarded-Encrypted: i=1; AJvYcCW8fq4MpYZKgCb21lXNxGYBaAYup66Y16udAUA75DHFevVv3GAmYQ7SwPzu/ckiLW16og45zM0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrLGyplonJmLAJPMNGGeYk9u1EWrIJo8B5JewJhkTukv+q1jV9
	b+aIZ7x0iKIIeaj8IIRvlKkYt9V+5qn/ld7PPwoJkB49MtD4KbVPHbpQFSbrBTXMVHU9j/Zb/PM
	vSG2cVhjv6G1V7jPPLmAiUUh35qh8EzdH2hrogPtS
X-Gm-Gg: AY/fxX6ViIGyPouvA9uYwpwqrFUk2QNuICG4Slet6LyFm3Qs5H40gUywHj9TAaEDNWy
	fKug8WbSW3sd21ThYHfX2EdGLMYXwCMCNFHDSdc6Qzi8fmEhF05JjrgBULRSWpK2rvafnCm1/Yj
	uV5V1H+h47PGiBPqHQZfHGlQ+f5M5ct9NMTHijHpHma816KjglaXUG6YmPity2xp/2dtQPDI5qK
	K8BwZR84JH8rMwGnzEi+admA2BihtbdVvaTma680KnfaK6mN5N7uTMCF5VRIiVZisIMLaXzcEel
	jQHCQicmFC3A7xWBMP9Mn/lC8EQVr9XwtyqQ
X-Received: by 2002:a05:6000:2913:b0:42f:ba09:aa7c with SMTP id
 ffacd0b85a97d-4356a060c90mr11483919f8f.54.1768771689026; Sun, 18 Jan 2026
 13:28:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115183832.46595-1-ojeda@kernel.org> <CANiq72mRB1Hhu=m26GsFHDTdiRTditNZGT4bRYWhWo_oBWsYXA@mail.gmail.com>
In-Reply-To: <CANiq72mRB1Hhu=m26GsFHDTdiRTditNZGT4bRYWhWo_oBWsYXA@mail.gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Sun, 18 Jan 2026 22:27:56 +0100
X-Gm-Features: AZwV_Qh4FAOBZN8AyV-kWC5X51-KWGqGLoI6xIRuEElZkOxwPw9uZwBLY87FHhU
Message-ID: <CAH5fLgg+TOAWQAJ+KMyZBe4E70i=qy9TbFiB1ydH7YzOG7TWGQ@mail.gmail.com>
Subject: Re: [PATCH] rust: kbuild: give `--config-path` to `rustfmt` in `.rsi` target
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 18, 2026 at 8:43=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Thu, Jan 15, 2026 at 7:38=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> w=
rote:
> >
> > `rustfmt` is configured via the `.rustfmt.toml` file in the source tree=
,
> > and we apply `rustfmt` to the macro expanded sources generated by the
> > `.rsi` target.
> >
> > However, under an `O=3D` pointing to an external folder (i.e. not just
> > a subdir), `rustfmt` will not find the file when checking the parent
> > folders. Since the edition is configured in this file, this can lead to
> > errors when it encounters newer syntax, e.g.
> >
> >     error: expected one of `!`, `.`, `::`, `;`, `?`, `where`, `{`, or a=
n operator, found `"rust_minimal"`
> >       --> samples/rust/rust_minimal.rsi:29:49
> >        |
> >     28 | impl ::kernel::ModuleMetadata for RustMinimal {
> >        |                                               - while parsing =
this item list starting here
> >     29 |     const NAME: &'static ::kernel::str::CStr =3D c"rust_minima=
l";
> >        |                                                 ^^^^^^^^^^^^^^=
 expected one of 8 possible tokens
> >     30 | }
> >        | - the item list ends here
> >        |
> >        =3D note: you may be trying to write a c-string literal
> >        =3D note: c-string literals require Rust 2021 or later
> >        =3D help: pass `--edition 2024` to `rustc`
> >        =3D note: for more on editions, read https://doc.rust-lang.org/e=
dition-guide
> >
> > A workaround is to use `RUSTFMT=3Dn`, which is documented in the `Makef=
ile`
> > help for cases where macro expanded source may happen to break `rustfmt=
`
> > for other reasons, but this is not one of those cases.
> >
> > One solution would be to pass `--edition`, but we want `rustfmt` to
> > use the entire configuration, even if currently we essentially use the
> > default configuration.
> >
> > Thus explicitly give the path to the config file to `rustfmt` instead.
> >
> > Reported-by: Alice Ryhl <aliceryhl@google.com>
> > Fixes: 2f7ab1267dc9 ("Kbuild: add Rust support")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
>
> Applied to `rust-fixes` -- thanks everyone!

Thanks Miguel for looking into this.

Alice

