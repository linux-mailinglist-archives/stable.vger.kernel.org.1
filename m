Return-Path: <stable+bounces-104362-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A497F9F33FB
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 16:05:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53B3818821E7
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 15:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E7BF81ACA;
	Mon, 16 Dec 2024 15:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LZMKhukK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C85199B9;
	Mon, 16 Dec 2024 15:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734361549; cv=none; b=bAnHrwFnG1rLJ044wf9KarjfNVV+fgVULEqC5etBHE5WYpiGImbdJMn5fVo2vb65yI93cw2qz7EA4G1U0BjqK4khx6KVEu5vwcbIJmRxT9HmStS0sPh6XN4zf2D/b9Xa3YAB3N1lNck4raGDQKO87t9k6byl5oHYNSpN2N0shLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734361549; c=relaxed/simple;
	bh=tIdFuiLb3rusJpAdSMP7WjnLxa5HWfHnlLwtg03T/JM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VhsaqxxMACv3LUWaqOSs6TrQTVKdLJuIwO+YLn29htf2uDAlk0w3E7tBWeBgzUqvKhR8Irz55srdfjmERoaxxovqHafWt02WynUCKklE7Rk4zSAEleL2WLnYdGvHHpaZ0ac4OE++E/tMJmuwk5YHTxesz+92LYUNuNH0TspQpCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LZMKhukK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07BDBC4CEDD;
	Mon, 16 Dec 2024 15:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734361548;
	bh=tIdFuiLb3rusJpAdSMP7WjnLxa5HWfHnlLwtg03T/JM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LZMKhukKWnoBFUlSjwHUQUkCf+Sxv5EBpSNvEqrsh9wzufQiR3BXbv+98ABYURrHE
	 uarkrXb0TDr4MRrX1zCV5a3MW8XAkpCX6Ef03LbJ3Cijx+8pI31/TawQ2DtNNdF4vu
	 JtpIiVQRWcAIWl5K1RoaMRWLy43Iv1AosC03BD8WI3wes2/8hlENJCLY5NYONkF3ZK
	 /WuXf7zno0laeVB0SpZBm4p5mGZg0/3kCMDFpwWJnM9w8HRKDAj70Kkreumu5VsHco
	 z6m9Ae9yWH/qNvhsY+9/LY6fxbsh9pzithCNd1wYkiW/cCrwFiiJT2f72jORBBSAJS
	 uc7byt1/Od7hA==
Date: Mon, 16 Dec 2024 15:05:44 +0000
From: Mark Brown <broonie@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Peter Collingbourne <pcc@google.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] arm64/sme: Move storage of reg_smidr to
 __cpuinfo_store_cpu()
Message-ID: <c0501e6c-7657-4885-abfa-1c0753c0e063@sirena.org.uk>
References: <20241214-arm64-fix-boot-cpu-smidr-v1-1-0745c40772dd@kernel.org>
 <87a5cysfci.wl-maz@kernel.org>
 <Z2AfOZ82QG_ukWry@J2N7QTR9R3>
 <865xnjsnqo.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rYVWTQ29yACSStov"
Content-Disposition: inline
In-Reply-To: <865xnjsnqo.wl-maz@kernel.org>
X-Cookie: Be different: conform.


--rYVWTQ29yACSStov
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 16, 2024 at 02:31:43PM +0000, Marc Zyngier wrote:
> Mark Rutland <mark.rutland@arm.com> wrote:

> > I understand that we have to do something as a bodge for broken FW which
> > traps SME, but I'd much rather we did that within __cpuinfo_store_cpu().

> Honestly, I'd rather revert that patch, together with b3000e2133d8
> ("arm64: Add the arm64.nosme command line option"). I'm getting tired
> of the FW nonsense, and we are only allowing vendors to ship untested
> crap.

I'd certainly be happy to remove the override for SME, the circumstances
that lead to the need to override SVE are much less likely to occur with
SME.  We can add it again later if there's a need for it.

> Furthermore, given the state of SME in the kernel, I don't think this
> is makes any difference. So maybe this is the right time to reset
> everything to a sane state.

I'm not aware of any issues that don't have fixes on the list (the fixes
have all been on the list for about a month, apart from this one).

--rYVWTQ29yACSStov
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmdgQccACgkQJNaLcl1U
h9CjQQf+KATDHPC+FxibIGuzocFvYNi2gMtyaa0fWsGVNddEp+BzHwP015ssdDKl
JteEjEknFyE7l9Y0F6bePJqYx/L/MIag8IweEZ5XWLAIOH6aMAameWJaewCa9kLW
PqVq30dEYb/pcV0GcuntAsVUekhHKf73mZui0RXugGWnwA6Bbz0GSE5OYig2vhsX
E8vc/V/SUm1eUmfAno7lV0cesuM31qtKlppJgxtoTELP/WbRwCGCIzVz/xZ+LtWP
5N2NxHPjOeZefcRfu6emhVpeWiAjB9lLsDiB+4q2mLXe1tngZKjVrdE8ZEHuFpBe
9n2oYo4dQRPsmqDsgByqvKgusClUGw==
=xWKA
-----END PGP SIGNATURE-----

--rYVWTQ29yACSStov--

