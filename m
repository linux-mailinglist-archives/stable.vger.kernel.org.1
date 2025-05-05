Return-Path: <stable+bounces-140593-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 579C4AAAE2E
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DB797A949A
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE963703CE;
	Mon,  5 May 2025 22:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OOShjDGR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626D835C910;
	Mon,  5 May 2025 22:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485230; cv=none; b=qrAf7e7w05XUFOuKnNqQZs0GMk/XhVhExI9ilJ/aHIN3YmsLz8RjPaXsJ6SkfWoWPjuuKrdGMzAfgZcK3N9oBUjc0+xlCQWLaFpFR14zC2Aa9MvU1kZvTgwktRJHm5TBFFIznrIecUzT/Z5+qco2OKA7F7g5zt64m6JX+bgOCMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485230; c=relaxed/simple;
	bh=YLu4pxyHP47HRCKaOwpN72EW9TWh8HCR+iIjXybySzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q2UbCI56EB6z8Oh8SpTVQ2OQKT1iiyO3krV8midbYHXCWZmiuvCumb0lMO1gwHK9/H86Awho30KdtH53lLIgscT5w4d7mATcGZ6Ytqcje2DFHIB4wjeg3ZrMv5L1BEv3VEe8m4I9uKxPTB/ha6VOgUNrUVuxp/TJe1hwV29du/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OOShjDGR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E56C7C4CEED;
	Mon,  5 May 2025 22:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485229;
	bh=YLu4pxyHP47HRCKaOwpN72EW9TWh8HCR+iIjXybySzM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OOShjDGRnfE8o/91wmsBrKmtFQdMxMFC/GUfhOlcHi/xwbJ8Isl/ioATIMbLZhECg
	 rYBkCdIgOfOM7j77zkQjy3jKGCamEsRznXT71r1QY+qnnxmaYDECZfmSH4ybn7gKiZ
	 TR7oOz8x997I5CjE41cEuVwPmaFNdojdVU32SnfRH0SjVyoTUjb4z6ZrV9GICdHoCL
	 +BgpSDtHmKASFQmLHqL+HIt30TtD+Jt78x9VGotq4mapXNoMurxABxAuGCWvPjtGDj
	 0cM7ctnYAQKTdDW/a7gIq2LqGonBX8qEu30/RTWGjtsUTP7ZXfuKrGjmUhhUyWMfmP
	 9NN5SJ+I7jrTw==
Date: Tue, 6 May 2025 07:47:04 +0900
From: Mark Brown <broonie@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, perex@perex.cz,
	tiwai@suse.com, lgirdwood@gmail.com, lumag@kernel.org,
	christianshewitt@gmail.com, kuninori.morimoto.gx@renesas.com,
	herve.codina@bootlin.com, jonas@kwiboo.se,
	krzysztof.kozlowski@linaro.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.14 601/642] ASoC: hdmi-codec: allow to refine
 formats actually supported
Message-ID: <aBk_6Dh4twLESMv_@finisterre.sirena.org.uk>
References: <20250505221419.2672473-1-sashal@kernel.org>
 <20250505221419.2672473-601-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oSWZcH3l9DGtTCj4"
Content-Disposition: inline
In-Reply-To: <20250505221419.2672473-601-sashal@kernel.org>
X-Cookie: Well begun is half done.


--oSWZcH3l9DGtTCj4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 05, 2025 at 06:13:37PM -0400, Sasha Levin wrote:
> From: Olivier Moysan <olivier.moysan@foss.st.com>
>=20
> [ Upstream commit 038f79638e0676359e44c5db458d52994f9b5ac1 ]
>=20
> Currently the hdmi-codec driver registers all the formats that are
> allowed on the I2S bus. Add i2s_formats field to codec data, to allow
> the hdmi codec client to refine the list of the audio I2S formats
> actually supported.

This is clearly a new feature which won't do anything without further
work in the drivers.

--oSWZcH3l9DGtTCj4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmgZP+cACgkQJNaLcl1U
h9DQFwf/byg4WXd0ZV2QRRrWIw79W7S7/zdyXLkI88YkBixPtQ4S/wr6rqxXejyc
6kytbz+1MDKxXCnrKDemLVgHB31GW6osbSjFbHBxtzMUAc3ZFDDCmXbBST9BEvt9
4S9eo+DzaBbNdB7O5Md1CLep8a7LFna2WXB5YNMafk9ylE4c4cRLu9PGrOtva9Zv
+8M8/obb4zU0fYgAXNtfAKEXQLCQnWoe43WxCoUpwdFZI5YXVeOSDJTuxrLjqLnR
WcphGe6LiKrx3Pf0hhcbKRZr3FFlELeBSD8Yy5Plg8OQwk0Lqp5OfYKY/P7v+M/i
aB4ZO1iyC6erfUJG73p6TTRh/NaxMw==
=MH23
-----END PGP SIGNATURE-----

--oSWZcH3l9DGtTCj4--

