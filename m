Return-Path: <stable+bounces-77807-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5687987777
	for <lists+stable@lfdr.de>; Thu, 26 Sep 2024 18:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55F05B28252
	for <lists+stable@lfdr.de>; Thu, 26 Sep 2024 16:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E3C156968;
	Thu, 26 Sep 2024 16:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F54g5pPT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D04934CC4;
	Thu, 26 Sep 2024 16:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727367678; cv=none; b=qInFyfsefh84l5weW8XRFVuv6xPuskEkrIb+5tzabTGSnBuhTpkq1UCUtdwicLoou734P+171zgksvX3otpesycxWddMeCkMqAfNsm8SNrXGCCc8d3zxg2Yqfx0bSMOfda1GL7o/yZv9loxDBqpNPfWzja2gdkFRcVl48dw0o7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727367678; c=relaxed/simple;
	bh=WRsqfac2hKLCDH03X7aLQwER6nnZNkaG9i+aBGCIQlg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aEPXSgD6fqK6QWonMDPy241B6Vf5hCwFChVmpYF8mQvcNr0PT5t0f9DnyEzoDEM8aonSPG2lTWWas9Y0zHbL1x92h50GW1Yvyc5Dq9Pc5PPweVCfy8+aNuPeisx01mNqlpvlclkwb6VyfejkkG+zEYl3uVK5A6fi51GepAYhV8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F54g5pPT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01BABC4CEC5;
	Thu, 26 Sep 2024 16:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727367678;
	bh=WRsqfac2hKLCDH03X7aLQwER6nnZNkaG9i+aBGCIQlg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F54g5pPT18+0JmNaLhrAEpuF4IysWci5TcL5035/ctiBgNPeTz87P1CtUJaIgxSuI
	 FX3lmhfOn5oli5sZOJiMR67i9sXO3tyOu4wZs2m5p0Dby3zyyaGamPl0XcVW6J5CkV
	 Nm9o95KfD4hPfojrPEXNES7YBNXfM6KRCwTJmgnO5nwDxvRhjastIHO+kMPvkLTyYL
	 pIO1F/R4efjIrAFWCaQmbWtNFtxN/LfkiyU0ZrBtwcBQspPeDv1EKNCGJsq1Cj9/IY
	 AmKk7GZHmgF16nX2XiDuftx+k+aB7/Y8yBt7EDmv3jt5hSOAxLVEAIa8yyxeaUMPx5
	 ZWWSQ1giam7KA==
Date: Thu, 26 Sep 2024 17:21:11 +0100
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
Message-ID: <20240926-battering-revolt-6c6a7827413e@spud>
References: <20240917000848.720765-1-jmontleo@redhat.com>
 <20240917000848.720765-2-jmontleo@redhat.com>
 <334EBB3A-6ABF-4FBF-89D2-DF3A6DCCCEA2@kernel.org>
 <20240917142950.48d800ac@eugeo>
 <31885EDD-EF6D-4EF1-94CA-276BA7A340B7@kernel.org>
 <CANiq72=KdF2zrcHJEH+YGv9Mn6szsHrZpEWb_y2QkFzButm3Ag@mail.gmail.com>
 <20240926-plated-guts-e84b822c40cc@spud>
 <CANiq72=ShT8O0GcN8G-YRE1CB8Z9Ztr-ZNcQ6cphHYvDGanTKg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jQkvOklAUWnSslpM"
Content-Disposition: inline
In-Reply-To: <CANiq72=ShT8O0GcN8G-YRE1CB8Z9Ztr-ZNcQ6cphHYvDGanTKg@mail.gmail.com>


--jQkvOklAUWnSslpM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2024 at 06:11:17PM +0200, Miguel Ojeda wrote:
> On Thu, Sep 26, 2024 at 5:56=E2=80=AFPM Conor Dooley <conor@kernel.org> w=
rote:
> >
> > Mixed builds are allowed on the c side, since we can figure out what the
>=20
> I am not sure what you mean by allowed on the C side. For out-of-tree
> modules you mean?

No. Things like clang + ld & gas.
I don't care about out of tree modules ;)

> > versions of each tool are. If there's a way to detect the version of
> > libclang in use by the rust side, then I would be okay with mixed gcc +
> > rustc builds.
>=20
> If you mean the libclang used by bindgen, yes, we have such a check
> (warning) in scripts/rust_is_available.sh. We can also have it as a
> Kconfig symbol if needed.

Okay. Short term then is deny gcc + rust, longer term is allow it with
the same caveats as the aforementioned mixed stuff.

> Regarding rustc's LLVM version, I wanted to have a similar check in
> scripts/rust_is_available.sh (also a warning), but it would have been
> quite noisy, and if LTO is not enabled it should generally be OK. So
> we are adding instead a Kconfig symbol for that, which will be used
> for a couple things. Gary has a WIP patch for this one.

Cool, I'll check that out.

> > Yes, I would rather this was not applied at all. My plan was to send a
> > patch making HAVE_RUST depend on CC_IS_CLANG, but just ain't got around
> > to it yet, partly cos I was kinda hoping to mention this to you guys at
> > LPC last week, but I never got the chance to talk to any rust people (or
> > go to any rust talks either!).
>=20
> To be clear, that `depends on` would need to be only for RISC-V, i.e.
> other architectures are "OK" with those. It is really, really
> experimental, as we have always warned, but some people is using it
> successfully, apparently.

Yes, just for riscv. The logic in our Kconfig menu is currently something
like
select HAVE_RUST if RUSTC_SUPPORTS_RISCV
so that would just become
select HAVE_RUST if RUSTC_SUPPORTS_RISCV && CC_IS_CLANG

>=20
> > Sure, I can add a comment there.
>=20
> Thanks!
>=20
> > In sorta related news, is there a plan for config "options" that will
> > allow us to detect gcc-rs or the gcc rust backend?
>=20
> gccrs is way too early to even think about that. rustc_codegen_gcc,
> yeah, if needed, we can add a symbol for that when we start supporting
> the backend.

Cool, sounds good.

--jQkvOklAUWnSslpM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZvWJ9wAKCRB4tDGHoIJi
0kYkAQD/k60KM2HCPrXZ+0g/PWrqYoQ0W+csV7fk/qkJR/xxoQEAgfjfobdRiFEJ
qEEFFmJcu3ccLX2+R1YqyCfedleEfAc=
=94Il
-----END PGP SIGNATURE-----

--jQkvOklAUWnSslpM--

