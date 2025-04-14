Return-Path: <stable+bounces-132631-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D751A8856C
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 16:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4017856297C
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 14:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197432D0A49;
	Mon, 14 Apr 2025 14:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CP0V714z"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244972D0A4B
	for <stable@vger.kernel.org>; Mon, 14 Apr 2025 14:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744639563; cv=none; b=RYOhSKDSdfbE6B9JsddboCdty0bE3iVkBcWN2LPQrt7U7qAeqU6th8GuZpdhXODGz7O1x/5IuHCyqsmQzHStE24mVExCnHtA4OOqZZKwWls+zT99+W62Nw/J6AOfcDZ56ENvmL/Dz+zdCwaVC8TKYgZ8aK6/YEYaO2CBPwS3uLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744639563; c=relaxed/simple;
	bh=1Tpyq5xBZ9bBoXA1okFnsjXuvR0LvRO7JEf1SqZG1A0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Qjl7YDCSJl8GOKvS6I1SIP5W4YI+tBtJvlU0XpSmusgqCuLxGt7FuleDj4/QI/99zofvgSMtTQUPkIxJ165gemzoqIuEQb1/4uSEUeJ3Gon7HpBj+td5nj8Oko7OzDuMxlR/joU/jtAMJWQo0JTWhctZ9WB6gaaaZuNcc9kOueg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CP0V714z; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3913aea90b4so1884054f8f.2
        for <stable@vger.kernel.org>; Mon, 14 Apr 2025 07:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744639560; x=1745244360; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pquPnA1PEeiSIlwvjcbZGrtyLxq30mwUO7DzjIyEInU=;
        b=CP0V714zVRvI6BPoFKJv/511uVdtY2KKjP4J5SRbnEKmAbGQGsEaCJhVwlg3DsMa+m
         6se662E0q3EkwI8bI3zQx8ljO+zgXKMb4BT/3nynxDTC6qxDCjxc7XWfeZo80ny/WGDt
         +FJxDxAa53aQxF+hf1IBrCB7bBnzEQbT2Su06hXDjNIrLnBI5FG+mkHFxUM9PDnfPe12
         EwwJbxnAxXuzxINt8s1diavKHShPAVa6ASO9XtWGZvbpoLIp41KqbqqCz5nTOLxTeoWH
         ToKtDrzLDczrBn1ZyzD6Y/y3ntjH7TJdGcM00nNBKYTy/54lScYYlCgkY8fyVDpWWmJi
         9SkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744639560; x=1745244360;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pquPnA1PEeiSIlwvjcbZGrtyLxq30mwUO7DzjIyEInU=;
        b=KrdKkhgBsgiPOSORyhts7VBFexKv0yGEnlmaiWdYSfdY/57q7xz53q61zOEu/cn097
         vPKFv18jmnhfEPo1IrpF0Id+0MzWi5QFFuEwpP0WKm9fEe91OWFyJCc9u1rEbn0eivVl
         cl06Uhq7a9LNxTieL8peVGwTNqdU6JMuruaUuQCaSYdBxHzancqu6A7AILxKr5IUU7Qu
         SX2N7c071Eh6O8/GMPQdZNPZYOACg3M4O84UqumzzrTxdnrdhebPdUfxGUQLhT4jnt6/
         zH0Ef/oIescVbdOWIIJEDVqNG2gj9UFH/IWNpDRhZ3lEOWtriM0XrZGNt+SFTVKlioVl
         AHgg==
X-Forwarded-Encrypted: i=1; AJvYcCWpl7NkM8ugLwRSRP1Zj6Ro8twRR5TYCn6DVcd8fGYkBSYXoR4RlKmLx5EiClnnx/5IurPTWKA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkURA51IDvGlr839+Ljry4Hi0S7NDN5ZzeFQ+475T/3TR2oiLS
	lkSRgwNfsfdQzGFmm/X4ScQgs294zheceI4oxuM+NKQV1tjnZgWsxl8n74g7QFxSEv2IDN7R1np
	tJWgOfOp93pijxQ==
X-Google-Smtp-Source: AGHT+IGQbHeuxbBbZFXwHsYpF9g2N88M1bkKFXroszwDXJntxCkbevVk0P6QDHTRfo+/ugItOAMd6LUWJaI08es=
X-Received: from wmbev15.prod.google.com ([2002:a05:600c:800f:b0:43d:7e5:30f0])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2483:b0:39a:d32c:fb5e with SMTP id ffacd0b85a97d-39ea51f577emr9570064f8f.21.1744639560478;
 Mon, 14 Apr 2025 07:06:00 -0700 (PDT)
Date: Mon, 14 Apr 2025 14:05:58 +0000
In-Reply-To: <D94KNIHTJOWU.1EHA7217LSC4S@proton.me>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250411-rust_arm_fix_fw_abstaction-v1-1-0a9e598451c6@gmail.com>
 <D93TIWHR8EZM.25205EFWBLJLM@proton.me> <CANiq72kc4gzfieD-FjuWfELRDXXD2vLgPv4wqk3nt4pjdPQ=qg@mail.gmail.com>
 <D94KNIHTJOWU.1EHA7217LSC4S@proton.me>
Message-ID: <Z_0WRohxxMYqKxM5@google.com>
Subject: Re: [PATCH] rust: fix building firmware abstraction on 32bit arm
From: Alice Ryhl <aliceryhl@google.com>
To: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, 
	Christian Schrefl <chrisi.schrefl@gmail.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	Russ Weight <russ.weight@linux.dev>, Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 12, 2025 at 10:01:22AM +0000, Benno Lossin wrote:
> On Fri Apr 11, 2025 at 4:15 PM CEST, Miguel Ojeda wrote:
> > On Fri, Apr 11, 2025 at 2:46=E2=80=AFPM Benno Lossin <benno.lossin@prot=
on.me> wrote:
> >>
> >> Ah I overlooked this, you should be using `kernel::ffi` (or
> >> `crate::ffi`) instead of `core`. (for `c_char` it doesn't matter, but =
we
> >> shouldn't be using `core::ffi`, since we have our own mappings).
> >
> > In 6.6, C `char` changed to unsigned, but `core::ffi::c_char` is
> > signed (in x86_64 at least).
> >
> > We should just never use `core::ffi` (except in `rust/ffi.rs`, of
> > course) -- I think we should just add the C types to the prelude
> > (which we discussed in the past) so that it is easy to avoid the
> > mistake (something like the patch attached as the end result, but
> > tested and across a kernel cycle or two) and mention it in the Coding
> > Guidelines. Thoughts?
>=20
> Yeah sounds like a good idea.
>=20
> > I tried to use Clippy's `disallowed-types` too:
> >
> >     disallowed-types =3D [
> >         { path =3D "core::ffi::c_void", reason =3D "the `kernel::ffi`
> > types should be used instead" },
> >         { path =3D "core::ffi::c_char", reason =3D "the `kernel::ffi`
> > types should be used instead" },
> >         { path =3D "core::ffi::c_schar", reason =3D "the `kernel::ffi`
> > types should be used instead" },
> >         { path =3D "core::ffi::c_uchar", reason =3D "the `kernel::ffi`
> > types should be used instead" },
> >         { path =3D "core::ffi::c_short", reason =3D "the `kernel::ffi`
> > types should be used instead" },
> >         { path =3D "core::ffi::c_ushort", reason =3D "the `kernel::ffi`
> > types should be used instead" },
> >         { path =3D "core::ffi::c_int", reason =3D "the `kernel::ffi` ty=
pes
> > should be used instead" },
> >         { path =3D "core::ffi::c_uint", reason =3D "the `kernel::ffi`
> > types should be used instead" },
> >         { path =3D "core::ffi::c_long", reason =3D "the `kernel::ffi`
> > types should be used instead" },
> >         { path =3D "core::ffi::c_ulong", reason =3D "the `kernel::ffi`
> > types should be used instead" },
> >         { path =3D "core::ffi::c_longlong", reason =3D "the `kernel::ff=
i`
> > types should be used instead" },
> >         { path =3D "core::ffi::c_ulonglong", reason =3D "the `kernel::f=
fi`
> > types should be used instead" },
> >     ]
> >
> > But it goes across aliases.
>=20
> We could make the types in `ffi` be transparent newtypes. But not sure
> if that could interfere with kCFI or other stuff.

Transparent newtypes for all integers would be super inconvenient.

Alice

