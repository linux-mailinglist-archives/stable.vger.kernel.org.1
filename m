Return-Path: <stable+bounces-191735-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A4EC20640
	for <lists+stable@lfdr.de>; Thu, 30 Oct 2025 14:54:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C2ABC4EB2AC
	for <lists+stable@lfdr.de>; Thu, 30 Oct 2025 13:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E39241CA2;
	Thu, 30 Oct 2025 13:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MIR6j42j"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDE41EF39E;
	Thu, 30 Oct 2025 13:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761832369; cv=none; b=frtS1zMG4c3uT/iTeFtVFOgzt0ZVsMEElx8vdqbdu/k5JaDBmm8fV6QQP+oGbOfoXDwQ8NYE91jeUbdbRGXE6xB5fl+rF5yP/Bnl05Fd8KI2UJmDgeIqubUbmsWhDj6aSoOlfqzKbs5i2d4Xh6xYwQ5RrfSWaxJaAPBMp+hroqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761832369; c=relaxed/simple;
	bh=eZjyLvOFzMZRQj65+8qH5o8o4HIvM8oDUkHkj4nGFLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MebICFmhtl85p1tI20C/DgHj0MHK4KeTWL5MJ5toNdaT9Y+9NdXB85lFSGJOTklcpumrbmd513jqa1vISQ7CcaJuE10/1avQDvMjClPzmAXD+rkwNMhVYV5o6A/baJED5IyR73WPENe1pgAa+1SWpHMc7czetxWNZuOvkVgQvXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MIR6j42j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEE95C4CEF8;
	Thu, 30 Oct 2025 13:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761832368;
	bh=eZjyLvOFzMZRQj65+8qH5o8o4HIvM8oDUkHkj4nGFLo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MIR6j42jULIRRKr1pBBLheADEM/ved2LDyNs82hTw9WEr2VDXtvVVUdiXzdWVnuZn
	 3RW34veyevcDc7pSh/Ja7X8z+J8VGQ3/l1aApVoSCHZZZhJbXDvgCufsjTR3dWD89g
	 J0H3inRTuBS6MroR/tNZsAQQwuQ2z/M85HdSkTMzYeLuhXMIPveFn7DQg9auBAgo7I
	 JzgqqQjhLUCpGLHSqhjKaEGMW3ush3rMrYGIa0vn/yfpDMHvTu+kzcWLu+c3T3S6hH
	 G7IA1PTHISS7zVl4Do07L+kZJLNKKn97XyAeGMtXXaS+MLeaLXqwL/6BOyfvXZv49j
	 ffHQ74/XK655A==
Date: Thu, 30 Oct 2025 13:52:41 +0000
From: Mark Brown <broonie@kernel.org>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	David Rhodes <david.rhodes@cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Nikita Shubin <nikita.shubin@maquefel.me>,
	Axel Lin <axel.lin@ingics.com>,
	Brian Austin <brian.austin@cirrus.com>, linux-sound@vger.kernel.org,
	patches@opensource.cirrus.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/4] ASoC: cs4271: Fix cs4271 I2C and SPI drivers
 automatic module loading
Message-ID: <794c1c49-83f8-4bff-b602-5f20f589aaa1@sirena.org.uk>
References: <20251029093921.624088-1-herve.codina@bootlin.com>
 <20251029093921.624088-2-herve.codina@bootlin.com>
 <06766cfb10fd6b7f4f606429f13432fe8b933d83.camel@gmail.com>
 <20251030144319.671368a2@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KuymU7zciVsA1ocq"
Content-Disposition: inline
In-Reply-To: <20251030144319.671368a2@bootlin.com>
X-Cookie: Is there life before breakfast?


--KuymU7zciVsA1ocq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 30, 2025 at 02:43:19PM +0100, Herve Codina wrote:

> I hesitate to fully remove cs4271_dt_ids in the SPI part.

...

> Maybe this could be handle globally out of this series instead of introducing
> a specific pattern in this series.

Yes, it feels sensible to be consistant and if there's practical issues
fix everyone rather than have one driver that works randomly differently.

--KuymU7zciVsA1ocq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmkDbakACgkQJNaLcl1U
h9Bs1Qf/W5JnT2/KHyguMuqqdBHz6kDJg3xv4gpOSoK17mPlbwQBgUa4kupa8/zd
w3XnVQzm2oEvRJrBlLLGNrxT0Dpz08xhIEE01pEVE/FHfPcAruASOoJNFM1gyJPX
9ItqNU5kv/EM8Cyf7ftdanmBE9CEnPaHE0HYDh+3DlYr7iiULP3IEE94S1owH10S
0j1KvlxKxz5yJuckqHvkwIuW19/Bveqp7pa4I3bA+4FbnCMNuBDMtuqfCXDimphR
ax/CjFIwyXa50p49oyxKOfROKbf8lwfU/OBhPbkJ8Pme2DLToPfSVmZTsN/kC8te
f+sDdDFul/6GS5+sP7LqQTcdLhNbqw==
=15HB
-----END PGP SIGNATURE-----

--KuymU7zciVsA1ocq--

