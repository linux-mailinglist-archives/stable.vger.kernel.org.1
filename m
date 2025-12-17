Return-Path: <stable+bounces-202832-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB73DCC9067
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 18:20:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 46959300795A
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 17:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7C834F494;
	Wed, 17 Dec 2025 13:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NdM9AKfO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36CD34F47B;
	Wed, 17 Dec 2025 13:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765977514; cv=none; b=BuiTAyGRdbNJVL640ceHaa7sN91KwxgaXA5aJjs+PjKjVTmOpN5Zo9dvNiY6SxPLESb1MfKDWCpwsTxlMegVzs0rEqervRejlCgR61XekXsZt3M5SyqMl3bOOcmbs5FNNr+z5WUqRAHpO3uD38AKkm4m9ETgChNJDmKllA+bDb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765977514; c=relaxed/simple;
	bh=h0jSaIZcisSRslk5sI4/j8Ns/tsAihyi0TdoR/+bjag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L0OnC8CqkgXoTw4WyFC/KZqsnCnK/hFQE7+rmI1dOWqIE42Rz9abacdrjpx5OqexCrNg+ELOoo4f0JMPqK+BMuA+ZPpRLC4nMjQMLBBU8xpuhK/jC9lAqb9hPsVyOpJykIEHgF2E4Bl+RSOvm6MEA921frbwB78xnJzse9XbZ84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NdM9AKfO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69FE7C4CEF5;
	Wed, 17 Dec 2025 13:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765977511;
	bh=h0jSaIZcisSRslk5sI4/j8Ns/tsAihyi0TdoR/+bjag=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NdM9AKfOdWiOl5CrCAcocUZ81wffvXxvgBdli1lKZvzhR5JSOXrY38BDx3/cYQPiW
	 wWcohv5gpJ0vhQG02Dg7iBb6qUgpK5+hobM3n4f/qaSlD5dra2DM5njaDtY8R9bv1a
	 zT/vxgHzm1TDcCJ9Rq0KVOMp88pRAJr1gVqNCJ2y7h4BMnPd43nQn7bU1JJcbD2gv/
	 6xxVFyj9ro231lLp4sirDQZ674FqC+kLpqNHf5RpkwQbBlgc/ulu+omZAvAu1twdCK
	 Lv5BuNHL265UFnEbXfcGSwMSt3I0UU/9Vfu15YZLQXXY5IGWCMOHqwpuyrAgYxgoZm
	 U3Bdq2/uWR8ug==
Date: Wed, 17 Dec 2025 13:18:26 +0000
From: Mark Brown <broonie@kernel.org>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: =?iso-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@linux.intel.com>,
	lgirdwood@gmail.com, linux-sound@vger.kernel.org,
	kai.vehmanen@linux.intel.com, seppo.ingalsuo@linux.intel.com,
	stable@vger.kernel.org, niranjan.hy@ti.com,
	ckeepax@opensource.cirrus.com, sbinding@opensource.cirrus.com
Subject: Re: [PATCH] ASoC: soc-ops: Correct the max value for clamp in
 soc_mixer_reg_to_ctl()
Message-ID: <c2dd8f88-e1e8-45b7-b270-133584702714@sirena.org.uk>
References: <20251217120623.16620-1-peter.ujfalusi@linux.intel.com>
 <6e97293c-71c1-40a8-8eba-4e2feda1e6ea@sirena.org.uk>
 <27404fce-b371-4003-b44b-a468572cf76d@linux.intel.com>
 <af368a9e-16c0-4512-8103-2351a9163e2c@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ugY07UIq1b6MJvCT"
Content-Disposition: inline
In-Reply-To: <af368a9e-16c0-4512-8103-2351a9163e2c@opensource.cirrus.com>
X-Cookie: Big book, big bore.


--ugY07UIq1b6MJvCT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 17, 2025 at 12:36:39PM +0000, Richard Fitzgerald wrote:

> The ASoC kunit tests have specific tests for SX controls.
> The original patch failed those tests, but it was merged anyway.

The issue there is that these tests use weird names in the form

   single volsw_sx: 0,0 -> range: 15->4(0), sign: 0, inv: 0 -> 0xf,0x0

which was causing the tests to just not get matched when checking
results.

--ugY07UIq1b6MJvCT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmlCraEACgkQJNaLcl1U
h9BCugf8Cfa9bcj/iiBWxAoHLVeoGoV9JQYe/8Ttwv5IvV9W2Nd+j+8Oo5TtQC/3
r0fcnr0+iNjlOYYOdE5iFduhHVOJ0NsY8Lobn3RIpeBwOaK3d8C+g6ZjZEcDe7dL
SHTwt9DUcaEvJnrw+oquuWF8ApZEd0j1LYlFTfFY/eEuCqGtadI1m5qV9UrhJm+C
1mKe5gND4J4TnMPe/T9DbWc4YVOhJ3y7hko70JnzCkeUeDSYcLHBf1h7eItH5UE3
EQPcyt7G85p5hK7ECk7BcKnbSD9dY0tpoalrpiVt5cVKnnCUiZmcbK1M6GGgd4c7
UJ5nho0a0rG+rQBg9g499NurC6hyFg==
=0XrB
-----END PGP SIGNATURE-----

--ugY07UIq1b6MJvCT--

