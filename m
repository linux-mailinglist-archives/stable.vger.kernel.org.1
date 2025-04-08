Return-Path: <stable+bounces-130445-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A02AA8049A
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 14:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 658C4189E8FE
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 12:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E608126A0D9;
	Tue,  8 Apr 2025 12:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kgsAtpX7"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BFF2690EB
	for <stable@vger.kernel.org>; Tue,  8 Apr 2025 12:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744113731; cv=none; b=KrXKE0qDryxJ4rIrYRFvVuC2zUsrivITeodnenbkrqfs1/R5L+frK6cFR7H6EBQOMa2kVoqP0AGkU5350lEHxXUOf+t2UP+bEO2LhS/rxxilJy0RCiLkb5jR2ikeI09TzeE0xfUBRAJsco7gVqGzgBAk5I//1mbH4m9TxDLzrgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744113731; c=relaxed/simple;
	bh=UFixeHLNjdQjTR+kkvlptM4ncETLW9p2OBuXaKgwWbA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SlmdKGjDgqq2sxDsWAhBpTVYTkNWtlidjUrLPATOezxjrPW7GJyGWMu+vwNmrQjVUo1da/1f8hhH2nGBA5PZEXSE7O7iP6L4LF2/taS3wuJ1CC0Lr5fSwJKbD2D014fcgppozG+sFqlG1E/TIh1Dj7uEnIp85B7wCkzBimKERjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kgsAtpX7; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3913b539aabso3200224f8f.2
        for <stable@vger.kernel.org>; Tue, 08 Apr 2025 05:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744113727; x=1744718527; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TaB33ZWJPGuieEub6nK71J8fMj0CB/UDsbyRfDQHdI4=;
        b=kgsAtpX7aQm4hdQxeJvX0s02V7x2rDAVqdEYTihLP05xusT3gCL4z9HhJXtkrLs3Cn
         JE8Aqx9C65EoT0BSO1fHiVC4iCl5LaF/B0CeW9CyEfwJ+MwDLs6dxZHMv8x1yTWhAbg+
         Hzl8z4ymgZG5HfX5QR0mChgUa7TANGtms2w4GhMA/YJvTjZIEjOTn/z+Y3U7XIXl7bdd
         GT2zM5UFk03aEyWp2qWJhs91fulb2GzLsqEOXEn6v1Zy0cid0d8XOzJRf4Qdqip0wtNJ
         G4xnQho1oJ6TLoUDN3vXRorsmd4QWlGdEP4knIwnQuKvQPHFLSFVe/zw3DtXfFNRxK/w
         iH/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744113727; x=1744718527;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TaB33ZWJPGuieEub6nK71J8fMj0CB/UDsbyRfDQHdI4=;
        b=RYEneQ+WaadrUsDfalE+Ar4v7BCaGxOBUOdYE4rre3Vqi+CSgijTmyisZ+c2PBu/ND
         YNWeRSpofnDDoifp5BIslX/3nPl/1G0jcr46+Cg5nzS7DmDlqiOjZ5ncLco4dmJiSyXr
         nHQZJXT1gnfaZJlQBfxWvnE4cWc0CHCfPuhag85QV35y49KH38bijmE+KGEgDKeD+Bo2
         SHam08temuzErwBBWp5+5X1Mps9MPGUi+vXReRtlbSZmmfPxksB4Lmzl780ctQaZZKs1
         I3FjKhledKVU+fggWQiOPcRxJlCZrBWFTAY0S06IGmCnhF2HzjIETk+/XXVQDHMThJtp
         ZxIA==
X-Gm-Message-State: AOJu0Yy3EgQdglszXItVW6cj23f7tb/OHqUE+bC308Fh7bVApFSoH20F
	HV7IKNXX1of7K1eNxYuC8/4hoK7FrnLEIdNNNR/RdR1Nh7g6GS25YorJCIaP3gDrqmQZKqOZCCk
	I+luTP6eziHNmYqyiPF87LMuKny5qmYiWvdDm
X-Gm-Gg: ASbGncsFcqcAWp5YWAj1LHtQ9rwdYbzK5SfIRH3+NzmXVzDL9X4tu5xS5hPDp2EfPqV
	t0dt35YsYvXehNKMxmJgyW+sW8Z9aHMlMZ59/RKiFeaB/xcKXcJ2bZ1wpvzdjIOZiINbWLUotGS
	7tnY7LJCQWjcm4O+0zGI7dkQac7gUI0KUkZe1BF5/H3axSF3OE94EIi6RxNbzvUebGGN8=
X-Google-Smtp-Source: AGHT+IHXn3WJ6YCdSECNM+7ovqF4F6BBSSghd/853rpu4Q9m55dL3x51uqHj8qHREP2y60W+P/vi1GG5MRr/eiKRt0k=
X-Received: by 2002:a5d:6d8e:0:b0:39c:1257:c7a1 with SMTP id
 ffacd0b85a97d-39cba93d0bbmr11770462f8f.57.1744113726698; Tue, 08 Apr 2025
 05:02:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250408104828.499967190@linuxfoundation.org> <20250408104830.890872754@linuxfoundation.org>
 <CAH5fLgj6SEKy1-CopXTnaFWK6WFddP+ahccf1_MdabpeCuB87A@mail.gmail.com>
In-Reply-To: <CAH5fLgj6SEKy1-CopXTnaFWK6WFddP+ahccf1_MdabpeCuB87A@mail.gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 8 Apr 2025 14:01:54 +0200
X-Gm-Features: ATxdqUFkRj9aDnv5yAULCjRgrblo_P7OU2VhSsBvhEFQYpsjIS9BRcEt53vb5D4
Message-ID: <CAH5fLggOycGwNKXS-=3oO6tSN+mA2YOnJpXBGOOK5pEO6A=qfg@mail.gmail.com>
Subject: Re: [PATCH 6.6 089/268] rust: fix signature of rust_fmt_argument
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	Tamir Duberstein <tamird@gmail.com>, Petr Mladek <pmladek@suse.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 8, 2025 at 1:57=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> wr=
ote:
>
> On Tue, Apr 8, 2025 at 1:54=E2=80=AFPM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > 6.6-stable review patch.  If anyone has any objections, please let me k=
now.
> >
> > ------------------
> >
> > From: Alice Ryhl <aliceryhl@google.com>
> >
> > [ Upstream commit 901b3290bd4dc35e613d13abd03c129e754dd3dd ]
> >
> > Without this change, the rest of this series will emit the following
> > error message:
> >
> > error[E0308]: `if` and `else` have incompatible types
> >   --> <linux>/rust/kernel/print.rs:22:22
> >    |
> > 21 | #[export]
> >    | --------- expected because of this
> > 22 | unsafe extern "C" fn rust_fmt_argument(
> >    |                      ^^^^^^^^^^^^^^^^^ expected `u8`, found `i8`
> >    |
> >    =3D note: expected fn item `unsafe extern "C" fn(*mut u8, *mut u8, *=
mut c_void) -> *mut u8 {bindings::rust_fmt_argument}`
> >               found fn item `unsafe extern "C" fn(*mut i8, *mut i8, *co=
nst c_void) -> *mut i8 {print::rust_fmt_argument}`
> >
> > The error may be different depending on the architecture.
> >
> > To fix this, change the void pointer argument to use a const pointer,
> > and change the imports to use crate::ffi instead of core::ffi for
> > integer types.
> >
> > Fixes: 787983da7718 ("vsprintf: add new `%pA` format specifier")
> > Reviewed-by: Tamir Duberstein <tamird@gmail.com>
> > Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> > Acked-by: Petr Mladek <pmladek@suse.com>
> > Link: https://lore.kernel.org/r/20250303-export-macro-v3-1-41fbad85a27f=
@google.com
> > Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> > Signed-off-by: Sasha Levin <sashal@kernel.org>
>
> > -use core::{
> > +use crate::{
> >      ffi::{c_char, c_void},
>
> I don't think crate::ffi exists on 6.6, so I would think that this
> does not compile.

We probably need to change rust_fmt_argument to use `*mut u8` instead
of *mut c_char` to fix this. Let me know if you want a patch for this.

Alice

