Return-Path: <stable+bounces-132316-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B01A86C4E
	for <lists+stable@lfdr.de>; Sat, 12 Apr 2025 12:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C75E464170
	for <lists+stable@lfdr.de>; Sat, 12 Apr 2025 10:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4430F192D66;
	Sat, 12 Apr 2025 10:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="O/Lc9gQh"
X-Original-To: stable@vger.kernel.org
Received: from mail-24417.protonmail.ch (mail-24417.protonmail.ch [109.224.244.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5D81C84A4
	for <stable@vger.kernel.org>; Sat, 12 Apr 2025 10:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744452097; cv=none; b=f/gkjPTf25jkILN/wW1IAlJevRr76dgrB6Bz7EzcuwliB6ZTPx2Z3BqkcBPfdpvAzvsTe9X7CUkaarx75dbHBMHHgEUu/ZItaI25xNFHckmkn4S6zmyDf+vjCDlUeJKk/0NADG2Fq60pml7q6f22T8Oti+D1TD5Y1pdmvJhHhm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744452097; c=relaxed/simple;
	bh=gctz7JVAZNhoV8W8iIskQvtz6KYucHNDoTF2Crsr+48=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JFEDokgnosZV8FtJxAcopZUsPlaWLFg7cXrIWVgXV8qrh5oUZp82Qn0vRRW+SLIfdpCkcBEa62LzFZ5h3yBsLuumu2BFmcre6ANbivMZenlXTE8NuvA0MhLE4Hl4wYmH6/vw1wxyt3wcZ15Gxe1gvQTuZRMM8oD/oLaQ5+q7ngY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=O/Lc9gQh; arc=none smtp.client-ip=109.224.244.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1744452088; x=1744711288;
	bh=FFmx/R+eIscgMWQqmhbFAfJgkDuQbwwym1T6jG1NDe0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=O/Lc9gQhf7cF3CwTlcqgR0OGUvPQnOGUan5urHjTGk7o8Exq8W9UnSnQqg1Zu5QLe
	 /XY3oM2CWbzPTmzDfAkshQvMBYXkHgXA1gCeDfaVpJ3G104B8pmWAZc+czb1aSpqVK
	 L4OhvZS3cfLMzfCutrSKpjcDDq7IXDKpLaEl5VmCjPPQIz0V+O78Q6zvrWJ6Fq9FlE
	 knBWxjXyL8xQPkhvVGtC1mT3AJTHoe39BvTkFNpdS6NZTs11A0astFlKiIF9xyx8bQ
	 1/lQoBf3gf6/RFBR6eaYTy5ewqZ20TudU0ccgCWhv+lZAkhcUVTB9QWkWhToMmdPk1
	 GCKQAaCGXnwbw==
Date: Sat, 12 Apr 2025 10:01:22 +0000
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Christian Schrefl <chrisi.schrefl@gmail.com>, Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] rust: fix building firmware abstraction on 32bit arm
Message-ID: <D94KNIHTJOWU.1EHA7217LSC4S@proton.me>
In-Reply-To: <CANiq72kc4gzfieD-FjuWfELRDXXD2vLgPv4wqk3nt4pjdPQ=qg@mail.gmail.com>
References: <20250411-rust_arm_fix_fw_abstaction-v1-1-0a9e598451c6@gmail.com> <D93TIWHR8EZM.25205EFWBLJLM@proton.me> <CANiq72kc4gzfieD-FjuWfELRDXXD2vLgPv4wqk3nt4pjdPQ=qg@mail.gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 75669246ee197850379a62647421f2407153a805
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri Apr 11, 2025 at 4:15 PM CEST, Miguel Ojeda wrote:
> On Fri, Apr 11, 2025 at 2:46=E2=80=AFPM Benno Lossin <benno.lossin@proton=
.me> wrote:
>>
>> Ah I overlooked this, you should be using `kernel::ffi` (or
>> `crate::ffi`) instead of `core`. (for `c_char` it doesn't matter, but we
>> shouldn't be using `core::ffi`, since we have our own mappings).
>
> In 6.6, C `char` changed to unsigned, but `core::ffi::c_char` is
> signed (in x86_64 at least).
>
> We should just never use `core::ffi` (except in `rust/ffi.rs`, of
> course) -- I think we should just add the C types to the prelude
> (which we discussed in the past) so that it is easy to avoid the
> mistake (something like the patch attached as the end result, but
> tested and across a kernel cycle or two) and mention it in the Coding
> Guidelines. Thoughts?

Yeah sounds like a good idea.

> I tried to use Clippy's `disallowed-types` too:
>
>     disallowed-types =3D [
>         { path =3D "core::ffi::c_void", reason =3D "the `kernel::ffi`
> types should be used instead" },
>         { path =3D "core::ffi::c_char", reason =3D "the `kernel::ffi`
> types should be used instead" },
>         { path =3D "core::ffi::c_schar", reason =3D "the `kernel::ffi`
> types should be used instead" },
>         { path =3D "core::ffi::c_uchar", reason =3D "the `kernel::ffi`
> types should be used instead" },
>         { path =3D "core::ffi::c_short", reason =3D "the `kernel::ffi`
> types should be used instead" },
>         { path =3D "core::ffi::c_ushort", reason =3D "the `kernel::ffi`
> types should be used instead" },
>         { path =3D "core::ffi::c_int", reason =3D "the `kernel::ffi` type=
s
> should be used instead" },
>         { path =3D "core::ffi::c_uint", reason =3D "the `kernel::ffi`
> types should be used instead" },
>         { path =3D "core::ffi::c_long", reason =3D "the `kernel::ffi`
> types should be used instead" },
>         { path =3D "core::ffi::c_ulong", reason =3D "the `kernel::ffi`
> types should be used instead" },
>         { path =3D "core::ffi::c_longlong", reason =3D "the `kernel::ffi`
> types should be used instead" },
>         { path =3D "core::ffi::c_ulonglong", reason =3D "the `kernel::ffi=
`
> types should be used instead" },
>     ]
>
> But it goes across aliases.

We could make the types in `ffi` be transparent newtypes. But not sure
if that could interfere with kCFI or other stuff.

---
Cheers,
Benno


