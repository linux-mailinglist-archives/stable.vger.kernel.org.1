Return-Path: <stable+bounces-202855-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A99CC827C
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 15:23:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 73196302B642
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 14:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81E3336EFE;
	Wed, 17 Dec 2025 14:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VM+YPxs/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7419E1D5CF2;
	Wed, 17 Dec 2025 14:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765981369; cv=none; b=tJKbi3Lpd0bfL1C8R4b+Qxki1iKfKlJUCz2k7SPXpN2miPCojaYY8PgXxIg7UTrqxp48E5PDusk02qNEQ4DWK4ic2OoYosfLm9hIeou9IwaX6+Iht4hpHHA+oZW23CSk1/CEvqLXUYEae/7rdxwKwVAJQKLqgXQ7PAj/JZnp9o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765981369; c=relaxed/simple;
	bh=KB+55qmFD4iUy4V1fCdeZyJ9JuaxVKBZl1f8SKw0+eU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CiV/Bo/k7FB6/4EKck++s8U7dfUs8/p1bpE3jBxM/B/1Fr3Qd0Y9gGUh6MXaAGCINPGYNUIwC3Uw4L7GkZ0OjgRKh0960pBRamT9hDnNpuCADj9KSgcWPa7xxCrLX8msKAFgtyN4HNdd3ATQAxhRPMPJ0rZdL8qUJRA4A0BSov4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VM+YPxs/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAC3CC116B1;
	Wed, 17 Dec 2025 14:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765981365;
	bh=KB+55qmFD4iUy4V1fCdeZyJ9JuaxVKBZl1f8SKw0+eU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VM+YPxs/uwyN5p3c4+aiScotCfMfow/4EuhDQbz+PaEBc007rKul+puKbqSHZUdqH
	 IqPeZtlZY8uy/T1Y/mDIrquFAcFHaIjVGuBJbLyO0MQ7NOvRjUX+6+8JBQw3XX6BuO
	 i8jx2pP7aB7U+UfBZTQh/xy1zRrK2Q4PIs86XevJvJ9t+hF8+y6BFAF9DgSxdFIwjl
	 xFRc0GyaAz2EwaBsxSYr31xi894t/OeY1w4J/RKBiZA61cJmaGab0t0OjBEs8X5l8e
	 XTxMvO3yCr0Mm1z6YRIyFgZWJqJTO+5tf8Hu3mZd1z2/MY+xzCwRhgkNp2QdJNAh02
	 HaEuEMOj2R2FQ==
Date: Wed, 17 Dec 2025 14:22:41 +0000
From: Mark Brown <broonie@kernel.org>
To: =?iso-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: Richard Fitzgerald <rf@opensource.cirrus.com>, lgirdwood@gmail.com,
	linux-sound@vger.kernel.org, kai.vehmanen@linux.intel.com,
	seppo.ingalsuo@linux.intel.com, stable@vger.kernel.org,
	niranjan.hy@ti.com, ckeepax@opensource.cirrus.com,
	sbinding@opensource.cirrus.com
Subject: Re: [PATCH] ASoC: soc-ops: Correct the max value for clamp in
 soc_mixer_reg_to_ctl()
Message-ID: <002df03b-18c4-450f-bb18-40f6ad246514@sirena.org.uk>
References: <af368a9e-16c0-4512-8103-2351a9163e2c@opensource.cirrus.com>
 <56411df9-3253-439a-b8eb-75c5b0175a7a@linux.intel.com>
 <bc6f3e66-ca9b-4ba3-bbe1-5ef31c373e6d@opensource.cirrus.com>
 <e98a78fc-0b30-4af1-b6f5-2bc5cacc8115@linux.intel.com>
 <9f1d5b88-e638-4b87-bee0-fc963231d20e@opensource.cirrus.com>
 <87c2d498-60fe-4339-83c8-f6d6bc256ea7@linux.intel.com>
 <8e2d0294-318c-4776-a02e-f6e6497852db@sirena.org.uk>
 <9e0c68de-c528-47f2-94e7-ddb118d3dda2@linux.intel.com>
 <ccc3f3c6-c99d-4e78-9296-f49898894c61@sirena.org.uk>
 <e513fe97-a0b2-4d96-9987-07b41a2891a7@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EjSetY0rl15ikZdM"
Content-Disposition: inline
In-Reply-To: <e513fe97-a0b2-4d96-9987-07b41a2891a7@linux.intel.com>
X-Cookie: Big book, big bore.


--EjSetY0rl15ikZdM
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 17, 2025 at 04:19:31PM +0200, P=E9ter Ujfalusi wrote:
> On 17/12/2025 16:00, Mark Brown wrote:

> > What did you actually run there?  Did you somehow have an existing
> > .config that it was picking up with everything turned off?
> git clean -xdf
> make mrproper

> ./tools/testing/kunit/kunit.py run --alltests

Interesting, that works happily for me.  You might try running in qemu
by specifying --arch I guess, but generally I'd report that to the kunit
people.

--EjSetY0rl15ikZdM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmlCvLAACgkQJNaLcl1U
h9D3cgf+M2csv/fcxg3yI1Wg8MP7R+bfq/CL4X4UBtPHTNnmxBT9PQjrfmc/BFbF
eHnkVlUQggymyJY5Cgf3FOYKIrwQbISmbDnt7+GGSghbt+7r3lcgUUnVhK+Qm3cK
1qWyW8mBzDUtE3urnAJKOSby7KhwvP5mhpiCHFX2vnshwL4d8l7f7o0/gDwr4E+/
7tiCsZzxtw+bPbJkda41HfPnS0M9nfBmnqerjrHq0dLpTU+Yf9U3+vVie1X8VVWw
6HY1LBuj7nxkuz1jD8pXMDWLTStVWtbapTY393hMgGksK1oNs7+IMqfjpBMqaXR+
vN0T+jYkPYjisnuNgnkBIAVTcQoIOQ==
=YJ2j
-----END PGP SIGNATURE-----

--EjSetY0rl15ikZdM--

