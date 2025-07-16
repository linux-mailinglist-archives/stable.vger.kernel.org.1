Return-Path: <stable+bounces-163140-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50035B07683
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 15:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 258821887EE4
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 13:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4DA2F5C27;
	Wed, 16 Jul 2025 12:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZPzLDInw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1782F5C26
	for <stable@vger.kernel.org>; Wed, 16 Jul 2025 12:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752670691; cv=none; b=nbSnTzoG+RKWNIGIVKgcJrc1q18Esdfw8IXOyoxj/p/iLBczsOc8F8jnAoCgEzG63SliytFGrb1lBXRaIY0GKCvq74Lpk+cQXMJ0xErSi1uBnVXUr6MI4dy1DxWgW5qWh49Tzn9s0rLrdCWoih9mrGiD8FPe3hCTIsDBdsF7SeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752670691; c=relaxed/simple;
	bh=hejksmTwhRTjEr0a3BQhqXKh2R4coyfoquE+QLfbtKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kb/VqvJjHczW1wQUOVkDx8bAxLnOSVb+89tFARuhhOQzQ0FL9veSz45wVgJaHLK72/ZN4nRaLzH8K66OAWpDoGBaazLqT48N7TZYJDCUOU7uJf0mAqSSmhaa2kcvPFFBqTePAoS4m025frmSOG91y45iGlG4q57MpKsxJE8omUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZPzLDInw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F413FC4CEF0;
	Wed, 16 Jul 2025 12:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752670690;
	bh=hejksmTwhRTjEr0a3BQhqXKh2R4coyfoquE+QLfbtKk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZPzLDInwtCv8u9C5Lox13QXQl2tnpstTfNkWUqLYcEXQWKO91yAwECdNVjdrryP8a
	 EzbzTz5iDSjTQCBy1RK8xrWUCIdqhYn+/xqvl+rkv0LOuAyTbdPicxooSM1TVFoGU8
	 kvvqIzfT9cfcr2DNZ9sv34SaL3y0HkMADz06ZQ1/RHK5f9zg3u2XBBY7DqQELqjl/e
	 slHLp+EHofTSh+6rM3BJrOnCpY2leUAR2Tu4PaIu9qP3jjJ9mdpVp3lJqiFVbkIhpM
	 InQfGEFKLyLrZp0PLYlEFEARiU+c+KZ1EgnkslMDXxOILE9/j7/yY59xk/21ZYng98
	 fMf4xfbDq1mqA==
Date: Wed, 16 Jul 2025 13:58:07 +0100
From: Mark Brown <broonie@kernel.org>
To: kernelci-results@groups.io, bot@kernelci.org
Cc: stable@vger.kernel.org
Subject: Re: [TEST REGRESSION] stable-rc/linux-6.12.y:
 kselftest.seccomp.seccomp_seccomp_benchmark_per-filter_last_2_diff_per-filter_filters_4
 on bcm2837-rpi-3-b-plus
Message-ID: <bb9ea244-8d9f-4243-97cd-9506546a162f@sirena.org.uk>
References: <175266998670.2811448.3696380835897675982@poutine>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aPI93MmFY89hc08W"
Content-Disposition: inline
In-Reply-To: <175266998670.2811448.3696380835897675982@poutine>
X-Cookie: osteopornosis:


--aPI93MmFY89hc08W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 16, 2025 at 12:46:28PM -0000, KernelCI bot wrote:

> kselftest.seccomp.seccomp_seccomp_benchmark_per-filter_last_2_diff_per-filter_filters_4 running on bcm2837-rpi-3-b-plus

FWIW the seccomp benchmarks are very unstable on a fairly wide range of
hardware.  We probably need some filtering on the tests that get
reported.

--aPI93MmFY89hc08W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmh3od4ACgkQJNaLcl1U
h9Cebwf/UaLWdJ2jA/Xg2qaquqTL1TSJrGNx4b+GcFR97aMiYQWqdkR6WPc7B+Xv
JGZnoISes4LJ469mVZTvk6NU61Yvf2VBCwevuyjmehu9eLdNkrMR80zAqZAJESRE
+bh7fRrzLb7IPkwFs2ztDnPpzDT/mAKBjLyDYN5z+FTCYhnt+Qffi8m/fQcFgbaa
6XFk0f2phMFBBkaF4mlwQccajStZ+KshsgidbAmEuV2dP3LqKUjVSqBXGJSeZSJW
dzPzuSEPtFRKxRqBdtcXUD7xl0u2jX7azmHlSqzPrjVRM7sTW30NU+iECzniDE+1
oRImhHaP84Dbrij1dphgMtrjkRqVcA==
=T3GM
-----END PGP SIGNATURE-----

--aPI93MmFY89hc08W--

