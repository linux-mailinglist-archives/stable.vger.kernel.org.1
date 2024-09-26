Return-Path: <stable+bounces-77803-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 635B398770E
	for <lists+stable@lfdr.de>; Thu, 26 Sep 2024 17:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0BC4B29E93
	for <lists+stable@lfdr.de>; Thu, 26 Sep 2024 15:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE091586F6;
	Thu, 26 Sep 2024 15:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FU+oDtiT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62972158205;
	Thu, 26 Sep 2024 15:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727366188; cv=none; b=XY+nyjzqMmTJyGnMGgKM1wMW8gQvmsTNw7DZrAbju3U4JxtsryEYckBWlp07AqDDEmIJygzYW+94IZIlp/Hqcgy5t0H79UDFGGWjr2vj5LH2K2SYhff4zDrMeaGJuYBJNcQOBWrnx53nWW+Z3endU/FwH6B9YHWXDjZCwq12KV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727366188; c=relaxed/simple;
	bh=1/qI2GP3Axi5UcQBFFO7yyGh9Go/5y6RvSagLxELw7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oaiLocp00jXY2PDpk3WMG8LehDo45Um30mROG1gKgT7VAUlrTuMB4wTBYPzpss82VI78RN/Mf839CtnxxeWWsRVKLVhm6HtK/8rxSC+9g5Qu/r1KbJZl/dXhMCCj1L9j5TtchVDNVulKc5NZ62ecKmLfllupLSLZT/wS5ROMo7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FU+oDtiT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDF65C4CEC5;
	Thu, 26 Sep 2024 15:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727366187;
	bh=1/qI2GP3Axi5UcQBFFO7yyGh9Go/5y6RvSagLxELw7I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FU+oDtiT5Xcl/Iai3/8xWtZT7hPf9kRCjbT1q1NyX6z8NCljCQXow4AXGtuYmSlC+
	 AzmA96KBDfIGUsL2DhJkznlHWk+kLOYjzE5ZKagM4kbBZZDUcMDZN+aCjAVWjifoUi
	 ud94FqvxI/WXzT/7jaPN9whX0uaCYcpWIaMXRNAJN/0gZyJRYvk/8EFRkwCAto3jM6
	 /ldlX4vGj3/GcKzejRPsQJus+lCjaJxUTeTr3qvb0dB+n2nR/b91T6MfK9rtbtZ2Ap
	 qt26/lxcP30MKT8O/AwM851eNGKMEQiQxUva5E9qei+t/7w/cJ8WdUjWlO+c3ajx+r
	 Hxzq5XfQUHFew==
Date: Thu, 26 Sep 2024 16:56:21 +0100
From: Conor Dooley <conor@kernel.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Gary Guo <gary@garyguo.net>, Jason Montleon <jmontleo@redhat.com>,
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
	bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, aliceryhl@google.com,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	nathan@kernel.org, ndesaulniers@google.com, morbo@google.com,
	justinstitt@google.com, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	llvm@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH] RISC-V: Fix building rust when using GCC toolchain
Message-ID: <20240926-plated-guts-e84b822c40cc@spud>
References: <20240917000848.720765-1-jmontleo@redhat.com>
 <20240917000848.720765-2-jmontleo@redhat.com>
 <334EBB3A-6ABF-4FBF-89D2-DF3A6DCCCEA2@kernel.org>
 <20240917142950.48d800ac@eugeo>
 <31885EDD-EF6D-4EF1-94CA-276BA7A340B7@kernel.org>
 <CANiq72=KdF2zrcHJEH+YGv9Mn6szsHrZpEWb_y2QkFzButm3Ag@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nmXfaJxXZ5jvnxoJ"
Content-Disposition: inline
In-Reply-To: <CANiq72=KdF2zrcHJEH+YGv9Mn6szsHrZpEWb_y2QkFzButm3Ag@mail.gmail.com>


--nmXfaJxXZ5jvnxoJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2024 at 05:40:19PM +0200, Miguel Ojeda wrote:
> On Tue, Sep 17, 2024 at 5:26=E2=80=AFPM Conor Dooley <conor@kernel.org> w=
rote:
> >
> > Yes, but unfortunately I already knew how it worked. It's not flags I a=
m worried about, it is extensions.
> > Even using a libclang that doesn't match clang could be a problem, but =
we can at least declare that unsupported.
> > Not digging it out on an airport bus, but we discussed the lack of GCC =
support on the original patch adding riscv, and decided against it.
>=20
> Do you mean you would prefer to avoid supporting the mixed GCC-Clang
> builds?

Mixed builds are allowed on the c side, since we can figure out what the
versions of each tool are. If there's a way to detect the version of
libclang in use by the rust side, then I would be okay with mixed gcc +
rustc builds.

> If so, do you mean you would prefer to not pick the patch,
> i.e. avoid supporting this at all?

Yes, I would rather this was not applied at all. My plan was to send a
patch making HAVE_RUST depend on CC_IS_CLANG, but just ain't got around
to it yet, partly cos I was kinda hoping to mention this to you guys at
LPC last week, but I never got the chance to talk to any rust people (or
go to any rust talks either!).

> (If so, then perhaps it would be a
> good idea to add a comment there and perhaps a note to
> https://docs.kernel.org/rust/arch-support.html).

Sure, I can add a comment there.=20

> Otherwise, please let me know if I am misunderstanding -- thanks!

In sorta related news, is there a plan for config "options" that will
allow us to detect gcc-rs or the gcc rust backend?

Cheers,
Conor.

--nmXfaJxXZ5jvnxoJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZvWEJQAKCRB4tDGHoIJi
0oYrAPwMntj0z02QObS+IYmEmboJI6SyEUkngNBmw9pJE4dx/AD/aIavZrcUYEKA
wsXoLTaDPQ2Dv+rm0e1ziNyB8Bg2nA4=
=wItZ
-----END PGP SIGNATURE-----

--nmXfaJxXZ5jvnxoJ--

