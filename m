Return-Path: <stable+bounces-124274-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 144E6A5F3B8
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 13:04:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C0903B103F
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 12:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5192676D3;
	Thu, 13 Mar 2025 12:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kLK4P3A8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9758E266EFC;
	Thu, 13 Mar 2025 12:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741867265; cv=none; b=Od7VhvBJiY1hf+95tyecNcs8mXsULsWurCuquljegDYWCkAM6Iz1TYewcrARqcNqFJZKzZW3HFX3X1hUyrpYvaQXVYe4Hh79AQXAy3rmtjpx93ij0fszfdYeVAITSDBoLeHnkC6JFXKgiBUDioIuh8vSC3FQNesM1hmoddfJTQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741867265; c=relaxed/simple;
	bh=r1h8UbJXzdgHhi3mQdi/KaeP1cFKYfP9HVXS6yh2t9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CtKr5x4aofW2VT4jBTpB2qkrsJqJw57amXmL00iCRn8/qFENxvwBaav4JRc2BN7f8h3HT8uHEiVRvHX4eT0KA9/BjW17HJf4VdsehKDV/EFzHMHTvhE7+/xFAm+E8knmEH4POX340SBxjR/xS2XUGxf+1iXs9oy/gFJmPfcKZC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kLK4P3A8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BECE7C4CEDD;
	Thu, 13 Mar 2025 12:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741867265;
	bh=r1h8UbJXzdgHhi3mQdi/KaeP1cFKYfP9HVXS6yh2t9o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kLK4P3A8XYkw9vagWrFreaZDyEV4mJOmaBziFJWOEe0GIFZUvmDEuoG76jAdKQKzM
	 +1M8BPEj0LIrkGBc0ZbjMgB6nzK4SaTDtB0dNgA84b8GFaJ5MFMcmNdr1tY2u+Nafp
	 ydFVQ1BP34svmnJO78Ekemg5YDig5yQ77GbKGjT+93VqpjHW16zdAMOMyySMiMu/9w
	 7QEcvy0a146s4fOLAVUWBgqCnadDQwa6BTcUpJzhaYDZJuNeN5CBlaMa3Tyn33VEXz
	 P3FGto0n6FMiQS6dwnhUToGUe2cN41DFVqYWsBZb/Op0mR228OugX4Qcdcv661PF8c
	 Yvfdxr5w9oCRQ==
Date: Thu, 13 Mar 2025 12:01:00 +0000
From: Mark Brown <broonie@kernel.org>
To: Christian Eggers <ceggers@arri.de>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	Douglas Anderson <dianders@chromium.org>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 2/2] regulator: check that dummy regulator has been
 probed before using it
Message-ID: <9557f23e-5f12-402f-9379-6d5010f30159@sirena.org.uk>
References: <20250313103051.32430-1-ceggers@arri.de>
 <20250313103051.32430-3-ceggers@arri.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/jetKCok6ESu8NLO"
Content-Disposition: inline
In-Reply-To: <20250313103051.32430-3-ceggers@arri.de>
X-Cookie: A beer delayed is a beer denied.


--/jetKCok6ESu8NLO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 13, 2025 at 11:27:39AM +0100, Christian Eggers wrote:
> Due to asynchronous driver probing there is a chance that the dummy
> regulator hasn't already been probed when first accessing it.

Please do not submit new versions of already applied patches, please
submit incremental updates to the existing code.  Modifying existing
commits creates problems for other users building on top of those
commits so it's best practice to only change pubished git commits if
absolutely essential.

--/jetKCok6ESu8NLO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfSyPwACgkQJNaLcl1U
h9CdHQf9H77M7xIXqMmT3HxBg3P9VDmT7x0b/udLFoEx8fBvax/hoR20RcdQQ71P
u+9Nem2zsdiJaQKs+augxLvMV6hmdiPQZqYQ+nUlwkPqgoCViAen1XBimw8vvTsB
rn8DZn1sThjrYSNxNbfHuHMIFH7gtxv/UWfnKm1e+yvCUvBvWSZ1mScen4EtY8g5
rV7irpqfaqvMyG14rv8DC2mJV2NIVuSRP6x6Y+x/EFpVGkneRkX9UFEFPcj55bua
uuWXRSPYL7ElhT7o4vyfEqd5cRP/2m2Aoe/3e7+0e2EbQI8A5gJSAZ8v2oVri+3o
oOyAmUH+IgYOQZvmN2QdyHmGonrnrQ==
=qVSg
-----END PGP SIGNATURE-----

--/jetKCok6ESu8NLO--

