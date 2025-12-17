Return-Path: <stable+bounces-202849-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C948CC815E
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 15:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 98C9D3027706
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 14:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC325348447;
	Wed, 17 Dec 2025 14:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EB02FpEU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53F62D7DED;
	Wed, 17 Dec 2025 14:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765980032; cv=none; b=sy7cgG1n3nMQlWUMTbQEbGxA1fZPKaYup6SqB4RCUqDDK8tukYNChdQfJIstVmlVrLR+ObhxoZS8VtCRowTS6abxzws02r/q2dRmocIB737N7WRVhFPav8M58t0MYJwlYEN1ZVcIOrm51gswyvCxw2LVf6pDlFkUl+hi44GByW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765980032; c=relaxed/simple;
	bh=BNlRNBs8aebCFdZZlC8ntXzCYJoy9zC3SQOE5BopmB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=awYCdtDUDmy+fbTzUAs1RhU9qG38A0cdVi/mPi+fVsWWaV9g4rLqSbi5qX5V/sh00jc5DG6p4DobYlOgcuNtQ1UTUfd4qiwQHSTAZ1WZNyPrCJWmy6UqnWBRRM3vR7Dx19JehZb/L2RwR+iwQefkPluFLiBVFXAxdUqUWL2FaW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EB02FpEU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4225FC4CEF5;
	Wed, 17 Dec 2025 14:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765980032;
	bh=BNlRNBs8aebCFdZZlC8ntXzCYJoy9zC3SQOE5BopmB8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EB02FpEU/ZEesMx8hfYCrP7bm636yFykFoIcVw3tKdWK6VdOJZ7JfhDx54CvIJvnB
	 qRLI9tw30Niva5/xqczs9HiBnGsnbbMOLyGMi0MI3WcXbEF6zzJ2QO33dBb8WagSVd
	 5tVZqobOCzuL9XUUaUOMaKylHMyjT93B67sbiVoeBaTbYEC68gYtg4oVYBEJ4gbFou
	 7VQEl2GmaXMlPGU1V+KAoLed/edPd8TtlZg3PLABKe1Ot4So2HYeYnPhBWIqi/uUl1
	 EGhE4aTRFewpWMiKbKCNyZ5C7udhMI8Nvobg/0lpSFroBLO9Qq0rtFP0bAslkEByLl
	 FF0bFpi26SusA==
Date: Wed, 17 Dec 2025 14:00:27 +0000
From: Mark Brown <broonie@kernel.org>
To: =?iso-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: Richard Fitzgerald <rf@opensource.cirrus.com>, lgirdwood@gmail.com,
	linux-sound@vger.kernel.org, kai.vehmanen@linux.intel.com,
	seppo.ingalsuo@linux.intel.com, stable@vger.kernel.org,
	niranjan.hy@ti.com, ckeepax@opensource.cirrus.com,
	sbinding@opensource.cirrus.com
Subject: Re: [PATCH] ASoC: soc-ops: Correct the max value for clamp in
 soc_mixer_reg_to_ctl()
Message-ID: <ccc3f3c6-c99d-4e78-9296-f49898894c61@sirena.org.uk>
References: <6e97293c-71c1-40a8-8eba-4e2feda1e6ea@sirena.org.uk>
 <27404fce-b371-4003-b44b-a468572cf76d@linux.intel.com>
 <af368a9e-16c0-4512-8103-2351a9163e2c@opensource.cirrus.com>
 <56411df9-3253-439a-b8eb-75c5b0175a7a@linux.intel.com>
 <bc6f3e66-ca9b-4ba3-bbe1-5ef31c373e6d@opensource.cirrus.com>
 <e98a78fc-0b30-4af1-b6f5-2bc5cacc8115@linux.intel.com>
 <9f1d5b88-e638-4b87-bee0-fc963231d20e@opensource.cirrus.com>
 <87c2d498-60fe-4339-83c8-f6d6bc256ea7@linux.intel.com>
 <8e2d0294-318c-4776-a02e-f6e6497852db@sirena.org.uk>
 <9e0c68de-c528-47f2-94e7-ddb118d3dda2@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZsWdSFwoA1L3tu5g"
Content-Disposition: inline
In-Reply-To: <9e0c68de-c528-47f2-94e7-ddb118d3dda2@linux.intel.com>
X-Cookie: Big book, big bore.


--ZsWdSFwoA1L3tu5g
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 17, 2025 at 03:59:02PM +0200, P=E9ter Ujfalusi wrote:
> On 17/12/2025 15:56, Mark Brown wrote:

> > What do you mean by "kunit test setup" - that's just a self contained
> > Python script that drives everything, it has minimal Python
> > requirements.

> I'm holding it wrong I'm sure:

> [15:35:21] Configuring KUnit Kernel ...
> [15:35:21] Building KUnit Kernel ...
> Populating config with:
> $ make ARCH=3Dum O=3D.kunit olddefconfig

What did you actually run there?  Did you somehow have an existing
=2Econfig that it was picking up with everything turned off?

--ZsWdSFwoA1L3tu5g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmlCt3oACgkQJNaLcl1U
h9Bg9gf/SbtjZLDt832NAwVRgO3bBWtS1nR2YVImHfpeXJOkqVjIBetN6XFNGjUV
gxZFIlvMpKgN4TOg2x9mM5s7DZqRhFENUabX9IHEku5Xts3OPVHqZeTNym0daLSk
EgdQtAQaff1M+jtc60RfKLQKOkYgBeOGocv0ejiwDtcfs55ZSg6tIWRmlTZJcLtY
CfJzkupysrsSlAZ14c7zRBRSvLp47hWEvd0F7FSGExnbH9wri/snhY6ibHAtgi1C
goYgYfzvTADKLZGYYKhH3oIZq/ejuc4ily/K74yTUgtyFLLs3nScBLxUC/DOcTYB
0UpCT7uenKcvfX+zYQUDjZdawr4pOQ==
=vyX9
-----END PGP SIGNATURE-----

--ZsWdSFwoA1L3tu5g--

