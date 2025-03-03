Return-Path: <stable+bounces-120062-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 202FDA4C101
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 13:52:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E80B162374
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 12:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24EA420F09D;
	Mon,  3 Mar 2025 12:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ONH1ZfPz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C826A1F19A;
	Mon,  3 Mar 2025 12:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741006326; cv=none; b=jfCCg2D5oxcLuIQn1/xmHZzp417qtEWDeqbkMOgg+IOiGAZ9HpdfoRjSS6Uze2dfsCBOcdiNng1BFwaDToKHXqGf0vH0YT933A0NR5KIc2CywXQn1MRFaulHDooUBSFAblzC64hjPmFvr/e9nHRyiFACama/nWUAQvjjf5mKdoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741006326; c=relaxed/simple;
	bh=vN6ggPv/ECtAyJIOC13/S4vopzaeQ+5ICHdDXWNQvl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GwHYxffdUb1s2Nc3pRfcrqXJx/X6l6X+MU2uucc6hmb0QsZElkLoNkZvlXTb+NdMB7Nemyi0I48YlNHVxih6h1I97s2hNEG+WTNFPcsgtzlT/KaD9BQTgibzbTlxQrY4vguef0NGcAkcIGsRnjpa25ROsfq0YTwRkeGMlIEdSws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ONH1ZfPz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76135C4CED6;
	Mon,  3 Mar 2025 12:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741006326;
	bh=vN6ggPv/ECtAyJIOC13/S4vopzaeQ+5ICHdDXWNQvl4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ONH1ZfPzWGINdRjQAstNyxlvRq0WrepPbpTzxzMkO8ACwrgPNSl2hWt0ohqGNqKuA
	 uL50x8rLNKdRa9XY7/aeW7PGIw87q9qKRHOXRHrDtwguDhiIN3rzfxldKlRxIBzreB
	 /3estso0OyqSxlOnsMMjAgNXJ/3pGo8eTz2b/guUTQC2qdVpA/yZZlmht1L3CAbuPo
	 O/fdWmA6t6nk1wqqWdoCYjsmlMomEjJWZYqFF0q8SEJzK5oxnNj8LDsUXTsvvcZT9w
	 zTVx+rCHR9aVnZfAVC8g35lY7LBXVKfNrqNeZFnFbpPfFeEIPtzqqUuy/vjAOaxRjp
	 DjvxWYsY+d68g==
Date: Mon, 3 Mar 2025 12:52:00 +0000
From: Mark Brown <broonie@kernel.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Sameer Pujar <spujar@nvidia.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Sheetal <sheetal@nvidia.com>, Ritu Chaudhary <rituc@nvidia.com>,
	stable@vger.kernel.org, linux-sound@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] ASoC: tegra: Fix ADX S24_LE audio format
Message-ID: <215b6a0e-20db-49dc-b2d2-df8dfaf899f6@sirena.org.uk>
References: <20250302225927.245457-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="09veEn5TwlpgDBHd"
Content-Disposition: inline
In-Reply-To: <20250302225927.245457-2-thorsten.blum@linux.dev>
X-Cookie: You will be awarded some great honor.


--09veEn5TwlpgDBHd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Mar 02, 2025 at 11:59:25PM +0100, Thorsten Blum wrote:
> Commit 4204eccc7b2a ("ASoC: tegra: Add support for S24_LE audio format")
> added support for the S24_LE audio format, but duplicated S16_LE in
> OUT_DAI() for ADX instead.

Please allow a reasonable time for review.  People get busy, go on
holiday, attend conferences and so on so unless there is some reason for
urgency (like critical bug fixes) please allow at least a couple of
weeks for review.  If there have been review comments then people may be
waiting for those to be addressed.

--09veEn5TwlpgDBHd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfFpe8ACgkQJNaLcl1U
h9D+Lgf8DTpEtDAyCKsn5luzCVg7TGGIKZrLUvqF0vP7Q3NNkRzoy1cS46E6pZyC
6wnVbCsOZiQ+Yi0a3s5Dj3L0lYDD5my9AQ41ZooayRTxILP+2QZIrgRZZUadWqa4
0oT6manyA3BkNAL0y8f9riEPaiUdCGoRH0quWPpX4IdQgNygEXbAXwmfndXnay+c
DhAyrHT+n5G6RYZwToc5TIzw/NmpjNkUUTEoqVt3gARJ2gSK9Spl6Mph1Ol2DlMX
giSXUP5+795ONq5EBoO+Zxz0F9KmXcvdvPXy/K7knXaIcOAru+e4W7lidbWncJgX
pFRb6FUb91C4vXk9U8v8FoL/pZw43A==
=ZzNs
-----END PGP SIGNATURE-----

--09veEn5TwlpgDBHd--

