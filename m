Return-Path: <stable+bounces-183336-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ACAE6BB8427
	for <lists+stable@lfdr.de>; Sat, 04 Oct 2025 00:07:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5C3953489BD
	for <lists+stable@lfdr.de>; Fri,  3 Oct 2025 22:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF88726A1C4;
	Fri,  3 Oct 2025 22:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZHM+6P3h"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9349B220F2D;
	Fri,  3 Oct 2025 22:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759529229; cv=none; b=PCz9Ndm5TsRvzUrW60d2Rs1Xx8lfJerqOirHcu2c3ad+8zM8nw/wQxY9pTdiWDAyvzXcQ9Vkg3WgpWTrqv+0TF5ay7aCEOGgorUwWa2Wh7O+MBzYtVVWoRlX7ZWr+8kAinHwgB3QNbbDW9+FUVlDTVCnfJAzgn3+7cvW188AlSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759529229; c=relaxed/simple;
	bh=w+IacxaWuWyWgcXzziS0Xsget5PpIhVBKXaCaaHjjko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oqnUoZ5Ts16LSYsBCPmG7+JPOXa8wZtH6t+DAutAYdk26Q2ls8d+FtfWiSjDo27TNOOf2IVu1/dwQeh5HnVXqtkepTNicoaB7K1EZ4aOmr5xvAPfj0lCrZo0yGMeagejD1k8PJKrcEDAHpPeWE6RuQUts8lTa4CLQNCP50CIv8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZHM+6P3h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0AECC4CEF5;
	Fri,  3 Oct 2025 22:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759529229;
	bh=w+IacxaWuWyWgcXzziS0Xsget5PpIhVBKXaCaaHjjko=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZHM+6P3hzDiHwELDQAhkeiz8mw2nMCQVlm1fS3GWsMAyam4EX3sS/XLGzQSGt5kGg
	 w1XN2nWU4htbdSCEoumczNKjRymN9PDNBufoqy+enaU30jeRTesC5X2Eomt+NeVOJx
	 4UwUN7uKpACDm9TU1QWc+XQBKhJFRn/H8nUKEL4x1J4aamBX8mx+CYRRDDDsD/vUjZ
	 Cfe4D+QBUg79DADnHVIa1gE2LJQjkSXN+AXP0KTT2BXXDWba2Sw6iWb5il01akjLpw
	 mhdSgQ0J/Yji5Wv9eKSo/O3i3jNOPsxcWb2KLUpaw0Q82X28Gp3hxDDz+wL/n+CuOG
	 8IGiKIBo+hDfg==
Date: Fri, 3 Oct 2025 23:07:02 +0100
From: Conor Dooley <conor@kernel.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: linux-kernel@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>,
	stable@vger.kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Alexandre Ghiti <alex@ghiti.fr>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, Kees Cook <kees@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Matthew Maurer <mmaurer@google.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	linux-riscv@lists.infradead.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v1] rust: cfi: only 64-bit arm and x86 support CFI_CLANG
Message-ID: <20251003-viewing-residency-d4f849c6fbe6@spud>
References: <20250908-distill-lint-1ae78bcf777c@spud>
 <CANiq72mw36RzCtNVax650fJ=+cYjuGNF722_Mn2Oy1FAvxWc8Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3LGMo/RvwtuM22VG"
Content-Disposition: inline
In-Reply-To: <CANiq72mw36RzCtNVax650fJ=+cYjuGNF722_Mn2Oy1FAvxWc8Q@mail.gmail.com>


--3LGMo/RvwtuM22VG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 08, 2025 at 04:36:09PM +0200, Miguel Ojeda wrote:
> On Mon, Sep 8, 2025 at 3:13=E2=80=AFPM Conor Dooley <conor@kernel.org> wr=
ote:
> >
> > From: Conor Dooley <conor.dooley@microchip.com>
> >
> > The kernel uses the standard rustc targets for non-x86 targets, and out
> > of those only 64-bit arm's target has kcfi support enabled. For x86, the
> > custom 64-bit target enables kcfi.
> >
> > The HAVE_CFI_ICALL_NORMALIZE_INTEGERS_RUSTC config option that allows
> > CFI_CLANG to be used in combination with RUST does not check whether the
> > rustc target supports kcfi. This breaks the build on riscv (and
> > presumably 32-bit arm) when CFI_CLANG and RUST are enabled at the same
> > time.
> >
> > Ordinarily, a rustc-option check would be used to detect target support
> > but unfortunately rustc-option filters out the target for reasons given
> > in commit 46e24a545cdb4 ("rust: kasan/kbuild: fix missing flags on first
> > build"). As a result, if the host supports kcfi but the target does not,
> > e.g. when building for riscv on x86_64, the build would remain broken.
> >
> > Instead, make HAVE_CFI_ICALL_NORMALIZE_INTEGERS_RUSTC depend on the only
> > two architectures where the target used supports it to fix the build.
> >
> > CC: stable@vger.kernel.org
> > Fixes: ca627e636551e ("rust: cfi: add support for CFI_CLANG with Rust")
> > Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
>=20
> If you are taking this through RISC-V:
>=20
> Acked-by: Miguel Ojeda <ojeda@kernel.org>

Hopefully someone can take it! I was hoping it'd be 6.18 material, can
someone grab it for fixes please?

--3LGMo/RvwtuM22VG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaOBJBgAKCRB4tDGHoIJi
0hn2AQDcRLVCHp2IPXIs5re6hj5zLylHHpS/BPI8BgjOwOBFwwEA/TM7CNhkYPZK
8W+W/SJgbmEWAv5y6PlKgzmM5lGFrAI=
=4bNn
-----END PGP SIGNATURE-----

--3LGMo/RvwtuM22VG--

