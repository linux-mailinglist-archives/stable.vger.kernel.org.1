Return-Path: <stable+bounces-202814-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD91ECC7AE5
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 13:46:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DDC13303369F
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 12:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF8A635770B;
	Wed, 17 Dec 2025 12:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NIoNq34H"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3D634B180;
	Wed, 17 Dec 2025 12:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765975456; cv=none; b=RpjwY6p1g+b5BPccIsVbHrCp0paDPMgkWgDLtNQdX8LuxTlXDhxdnLaei1o+XFPHX1WKlj1LMulsAR3AhtTJwjxFR6z/fdBeoiHyNNSYywZAbmEtsbLZR7EPN02b0gpMEAG/YrU/in9k34VuMlC0xIr8QeVhVO5XPkAhQgLlets=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765975456; c=relaxed/simple;
	bh=pAo9tcho1YtnBhDvIc6z84oUQGHcjVv4dRkyBd4ts/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uCNuAYrHsg0Y2A6qfUtIIaFGc9Rx5m1qJ3WQAbvyv0yutHYegZHUXpmKqcZSwTP3+sJhipoAk0fsXP3d8Kd7yS4KRA23MKJvnKYLIP0nRTLvtzud58Engo5Y13WsFSE3r6Ud7GQZ9vu19ob4nSGmHVc5FaC6Yzi+LxFC6BnA34k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NIoNq34H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0232AC4CEF5;
	Wed, 17 Dec 2025 12:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765975455;
	bh=pAo9tcho1YtnBhDvIc6z84oUQGHcjVv4dRkyBd4ts/I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NIoNq34HPL85Y5hrOVqB0JULe2bvwIOKtdV8wBHKnC7BKswqD8P0Y1mKXZaMOyC9q
	 tTJSatRbZa9Zdm1znDBWrC1zaM9/B3YsT1QrRUT40CjAW1gaYxMvSK9Q6MNqRGURtj
	 1kV85eeFRCJRbO7jFGPUG+52AjVowN7mgfxA75K7NuUtMwaDuq0ckBpd5HUYYhD/3Z
	 RcXitqyxCwMQMp4bhwL3edwELYGZjfUMAVrApsI7UYLJpxvg5hhNCiDIUNFGxyq7bq
	 AxUdBm28jdOvvBCFYzxQzK/Th/vm7F9kp3YEQCuv6W0HoK/6PJUX2bh2INjIzr4qBK
	 SxPJWqxNF09uA==
Date: Wed, 17 Dec 2025 12:44:10 +0000
From: Mark Brown <broonie@kernel.org>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: =?iso-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@linux.intel.com>,
	lgirdwood@gmail.com, linux-sound@vger.kernel.org,
	kai.vehmanen@linux.intel.com, seppo.ingalsuo@linux.intel.com,
	stable@vger.kernel.org, niranjan.hy@ti.com,
	ckeepax@opensource.cirrus.com, sbinding@opensource.cirrus.com
Subject: Re: [PATCH] ASoC: soc-ops: Correct the max value for clamp in
 soc_mixer_reg_to_ctl()
Message-ID: <669a2eb4-1147-41ba-adff-f28d5f38eed2@sirena.org.uk>
References: <20251217120623.16620-1-peter.ujfalusi@linux.intel.com>
 <6e97293c-71c1-40a8-8eba-4e2feda1e6ea@sirena.org.uk>
 <27404fce-b371-4003-b44b-a468572cf76d@linux.intel.com>
 <af368a9e-16c0-4512-8103-2351a9163e2c@opensource.cirrus.com>
 <56411df9-3253-439a-b8eb-75c5b0175a7a@linux.intel.com>
 <bc6f3e66-ca9b-4ba3-bbe1-5ef31c373e6d@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OeATLZxdI9z+4goM"
Content-Disposition: inline
In-Reply-To: <bc6f3e66-ca9b-4ba3-bbe1-5ef31c373e6d@opensource.cirrus.com>
X-Cookie: Big book, big bore.


--OeATLZxdI9z+4goM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 17, 2025 at 12:40:39PM +0000, Richard Fitzgerald wrote:

> make mrproper
> ./tools/testing/kunit/kunit.py run
> --kunitconfig=tools/testing/kunit/configs/all_tests.config

There's the --alltests option for this.

--OeATLZxdI9z+4goM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmlCpZkACgkQJNaLcl1U
h9AtQgf+PRDljmtUhJ5AxEE1q5FWYjkrbV/3r+KWrXgsCoYwtsPcfy6+Os7yKDsk
nfBolwzBDBcYOVGjL1Rz6TJYRwYwrs//2QiovS8uJeuA5NnNsmkJI1dCJqWJfa8K
enIRwEft2up/kZF6HOiMAxWDMqOt0PefYEHg2Oc/K9iBgdQFqFIL433yBDXf16Ot
1Qtu7UGjd4xl6uy8c+Lhsl+XJM5W/sukuWP2bwP6L0C4UuIyjzKEBVo0cJMLe2a6
ndyCGNzL4ncv1jBWtkQfhuOfR96x9Kjj0f6ddiWmICdCVQElzDa5ZBQHT7Yvtpo+
uzzvHZuipSw32Movr80tP0sjc8MwZg==
=jei+
-----END PGP SIGNATURE-----

--OeATLZxdI9z+4goM--

