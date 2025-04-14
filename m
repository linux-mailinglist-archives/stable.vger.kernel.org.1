Return-Path: <stable+bounces-132637-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 194BEA8860C
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 16:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FEA0167FD6
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 14:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A23127979A;
	Mon, 14 Apr 2025 14:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="SCAxwFSL"
X-Original-To: stable@vger.kernel.org
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4AC279789;
	Mon, 14 Apr 2025 14:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744642376; cv=none; b=O5P3luhOAPmIU9F6YgjqCTekAyeb9dZyc9QTsdYzTsVkhpb5l7zWBetromzyTyOlJTgVYu92uEr+6OlwoYvTQvPEkItT48VJhsgwGBUc9INdZIkyrzU8Wh3NXZagWmebzZMz7z6A5H5oaryPu1PS5z5Rm39iIhvZn/2t2wijTOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744642376; c=relaxed/simple;
	bh=q275gpJ5gkFxsqAByotGoyQ2YIzbhtPnLFBEwofgH7w=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ra4/qlSSEqKuyvhDrMQArdL+AmCBFIeRRh4m0HGMTOhcns1AKz/PvR7Z/XomhL6+cBaYR/do9iMdzBToxVXY8METAzALEiIqQNxzetrgVz8h9wMwrLgA25fAXKwu6sFKJyWy69bbfXRA/p8ZhIKB/8jr8vTWXvD24WvRu1KBGRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=SCAxwFSL; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1744642370; x=1744901570;
	bh=dD5e/1Fu7mhWrgn3QSi/3YdnMeUu7C/RwKN6vJhntek=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=SCAxwFSLxDPZSu7uhNHnIZxdUSR2tLa3lzxcULMslZQcyzF4ZPPACYURlLvOP24cA
	 Y0tCItwnUQvahI5wU7hcCz0RXidtdtnHCpSqTdUBrUjma/sYd3Ladogpy4isL18Z+f
	 ogWSlc0u88J1YDt8CqElcTnwEQX4tcwGE5tsp3CX+5BDi8Vf20eISTDYNhWXA7F2hg
	 cLaOyAbhSwH+Sr43ajpaT4YyBoWQs7E+5Sj0EwEuqzGjOeURg/wx2b39iBmWVp1r8s
	 rc2hIOeRsry0i/rrAzdpCfmxAIr+mXZNJ5Q5Ikxs5rXkMHTmgHnei8Zqsp47/9EFoZ
	 Clprdy/koFxFA==
Date: Mon, 14 Apr 2025 14:52:42 +0000
To: Alice Ryhl <aliceryhl@google.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Christian Schrefl <chrisi.schrefl@gmail.com>, Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] rust: fix building firmware abstraction on 32bit arm
Message-ID: <D96G3LM70821.3O228HXNXZ3OA@proton.me>
In-Reply-To: <Z_0WRohxxMYqKxM5@google.com>
References: <20250411-rust_arm_fix_fw_abstaction-v1-1-0a9e598451c6@gmail.com> <D93TIWHR8EZM.25205EFWBLJLM@proton.me> <CANiq72kc4gzfieD-FjuWfELRDXXD2vLgPv4wqk3nt4pjdPQ=qg@mail.gmail.com> <D94KNIHTJOWU.1EHA7217LSC4S@proton.me> <Z_0WRohxxMYqKxM5@google.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 3caaa48efb154cbf541da6ca91722a1468259d9c
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon Apr 14, 2025 at 4:05 PM CEST, Alice Ryhl wrote:
> On Sat, Apr 12, 2025 at 10:01:22AM +0000, Benno Lossin wrote:
>> On Fri Apr 11, 2025 at 4:15 PM CEST, Miguel Ojeda wrote:
>> > On Fri, Apr 11, 2025 at 2:46=E2=80=AFPM Benno Lossin <benno.lossin@pro=
ton.me> wrote:
>> >>
>> >> Ah I overlooked this, you should be using `kernel::ffi` (or
>> >> `crate::ffi`) instead of `core`. (for `c_char` it doesn't matter, but=
 we
>> >> shouldn't be using `core::ffi`, since we have our own mappings).
>> >
>> > In 6.6, C `char` changed to unsigned, but `core::ffi::c_char` is
>> > signed (in x86_64 at least).
>> >
>> > We should just never use `core::ffi` (except in `rust/ffi.rs`, of
>> > course) -- I think we should just add the C types to the prelude
>> > (which we discussed in the past) so that it is easy to avoid the
>> > mistake (something like the patch attached as the end result, but
>> > tested and across a kernel cycle or two) and mention it in the Coding
>> > Guidelines. Thoughts?
>>=20
>> Yeah sounds like a good idea.
>>=20
>> > I tried to use Clippy's `disallowed-types` too:
>> >
>> >     disallowed-types =3D [
>> >         { path =3D "core::ffi::c_void", reason =3D "the `kernel::ffi`
>> > types should be used instead" },
>> >         { path =3D "core::ffi::c_char", reason =3D "the `kernel::ffi`
>> > types should be used instead" },
>> >         { path =3D "core::ffi::c_schar", reason =3D "the `kernel::ffi`
>> > types should be used instead" },
>> >         { path =3D "core::ffi::c_uchar", reason =3D "the `kernel::ffi`
>> > types should be used instead" },
>> >         { path =3D "core::ffi::c_short", reason =3D "the `kernel::ffi`
>> > types should be used instead" },
>> >         { path =3D "core::ffi::c_ushort", reason =3D "the `kernel::ffi=
`
>> > types should be used instead" },
>> >         { path =3D "core::ffi::c_int", reason =3D "the `kernel::ffi` t=
ypes
>> > should be used instead" },
>> >         { path =3D "core::ffi::c_uint", reason =3D "the `kernel::ffi`
>> > types should be used instead" },
>> >         { path =3D "core::ffi::c_long", reason =3D "the `kernel::ffi`
>> > types should be used instead" },
>> >         { path =3D "core::ffi::c_ulong", reason =3D "the `kernel::ffi`
>> > types should be used instead" },
>> >         { path =3D "core::ffi::c_longlong", reason =3D "the `kernel::f=
fi`
>> > types should be used instead" },
>> >         { path =3D "core::ffi::c_ulonglong", reason =3D "the `kernel::=
ffi`
>> > types should be used instead" },
>> >     ]
>> >
>> > But it goes across aliases.
>>=20
>> We could make the types in `ffi` be transparent newtypes. But not sure
>> if that could interfere with kCFI or other stuff.
>
> Transparent newtypes for all integers would be super inconvenient.

Yeah I noticed that too when trying... We often assign integer literals
to the ffi types.

---
Cheers,
Benno


