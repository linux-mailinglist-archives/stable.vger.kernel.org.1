Return-Path: <stable+bounces-163156-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46495B078A4
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 16:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 468A63A72DC
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 14:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C592F4A16;
	Wed, 16 Jul 2025 14:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tDQbXnGp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD15262FF0
	for <stable@vger.kernel.org>; Wed, 16 Jul 2025 14:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752677482; cv=none; b=mvDOltMY80fz84hskBDZlrYdKPcFC+zXgcswGX4YDACnwUMsfvwQCE4kkQnxnMvjg6M6Gitt0ehCpyMrZ6QDHEDHtGOfaENKQ/o7N1lfXhu+n9V4/T3QbTYtAv1GG+NokKBhRroQbVtVgWX38yb8NyBJSP17lMY3T+PEmMzeN0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752677482; c=relaxed/simple;
	bh=vIvrzECYouQ+JUyzbYQXOhzLY6xh/fvhKnrKbrCub8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sdFipyJiT2Z2kjkOuOvleRIBvX12RajrOhjNcgGHjIs29hMIwGF07NOOlgKtFOCb0s2NgB3++CfkzvhpIt7ums4dKaCNGu1skP/+0/GOUI0d2wNH9ZX5OILOstGI3jd0H+o6IAVSnALCmy0eMNSSkQBEhCJ28vZRK8mitUWZS/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tDQbXnGp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9886C4CEE7;
	Wed, 16 Jul 2025 14:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752677481;
	bh=vIvrzECYouQ+JUyzbYQXOhzLY6xh/fvhKnrKbrCub8g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tDQbXnGpaec7w4FsZrxnaBkc6A632ect3dtqtq+ucAKI1t/yDFGDmZgGXPJyN8B1m
	 S1/ViwMxJnZkHmM3MZOvWOBFPkPGc25k5Su2s5St0TYP0Q+jlQGCHi84Fv9b/TeOn3
	 ZmmIPM1ga+cSh1PWU1pum0EiiStVzGtFs93i5rgScGFsD019B1l3RKMQHB6UtqOHAd
	 2F70bujpn9beQX3ARYj0s8cbqDNTeFVdan5rZUsb45HTV6HVvZh37pDVyq12amTdE/
	 lm0JYmZYCCYl2pZUE9vF6rPFWJm6hT9iS8FuMVVRrOx32Y3kN7c5zMahFalAEcjm0+
	 k1wwQWag1trFg==
Date: Wed, 16 Jul 2025 15:51:14 +0100
From: Mark Brown <broonie@kernel.org>
To: Gustavo Padovan <gus@collabora.com>
Cc: kernelci-results@groups.io, bot@kernelci.org, stable@vger.kernel.org
Subject: Re: [TEST REGRESSION] stable-rc/linux-6.12.y:
 kselftest.seccomp.seccomp_seccomp_benchmark_per-filter_last_2_diff_per-filter_filters_4
 on bcm2837-rpi-3-b-plus
Message-ID: <c1b238da-a93a-41ca-abd5-99520bac4832@sirena.org.uk>
References: <175266998670.2811448.3696380835897675982@poutine>
 <bb9ea244-8d9f-4243-97cd-9506546a162f@sirena.org.uk>
 <9899229dc635f4912615525b80642b82a14e1741.camel@collabora.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vXXcg8TEI7nEUIjQ"
Content-Disposition: inline
In-Reply-To: <9899229dc635f4912615525b80642b82a14e1741.camel@collabora.com>
X-Cookie: osteopornosis:


--vXXcg8TEI7nEUIjQ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 11:36:02AM -0300, Gustavo Padovan wrote:
> On Wed, 2025-07-16 at 13:58 +0100, Mark Brown wrote:
> > On Wed, Jul 16, 2025 at 12:46:28PM -0000, KernelCI bot wrote:

> > > kselftest.seccomp.seccomp_seccomp_benchmark_per-
> > > filter_last_2_diff_per-filter_filters_4 running on bcm2837-rpi-3-b-
> > > plus

> > FWIW the seccomp benchmarks are very unstable on a fairly wide range
> > of
> > hardware.=A0 We probably need some filtering on the tests that get
> > reported.

> Indeed. However, for the previous 17 executions it passed 12 with 5
> infra issues unrelated to the test. That's is why we sent this report.

Yeah, it does work a lot of the time but it fails often enough for me to
have excluded it from triggering bisects in my own CI.  It is more
unstable on some other platforms that this one though.

> But to your point, we really need clear understanding of patterns to
> flag something as regression vs it being an unstable test.

Yup.

--vXXcg8TEI7nEUIjQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmh3vGEACgkQJNaLcl1U
h9DOGgf9ERfKkbnQdJgBjGr2SNPnMALjgY22hfs5ceb5PN8pJ/am0zj5UjazK1EB
J4mZn6bp9eRzXSzpC03nQJDSwuwAYkPvA2fUtaDwHLlYDMYFAgWSScP9eydqO727
Qg458nNYuyb0uthVR0+K4Om3RrMqW7C9mQAs1dUHHoBdB8y5h7sLGmnkCi+r8ksS
p0kTOQWj7InzFPXwFxNYJjp7aqaREgQ3so1NIfyYGXoDwDTv733hYasU8QHFidLQ
nQK0DSJbWZU4SUqvt+jclh7lHmFXHGDSfxw4JvVri5MkGbwmB0snA2JZDmLDTkOL
EDzpijZkiS8r6NtPymTCx63IXv8rGg==
=ojwA
-----END PGP SIGNATURE-----

--vXXcg8TEI7nEUIjQ--

