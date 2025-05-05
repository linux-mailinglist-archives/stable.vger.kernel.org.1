Return-Path: <stable+bounces-140572-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A048AAAE3E
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F6381A880FA
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87CAE2D3F8F;
	Mon,  5 May 2025 22:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s3QBcI6/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBEA35A765;
	Mon,  5 May 2025 22:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485170; cv=none; b=lml1zYoyr2+MfbEJMer/MEZ6g+7qBj2pHLqt+sm4EkEbsskRWLAgq7pChkh0YFgYYXiTDmGF9XMgiKMzX53OymFe3AOXY0Vfqh8tT/sOvW2rt6HLM+6/85h5N2dAknIM6ESVQzrCyyagN4g4Cq07+LSJZOW7skacrnvV9Sn28CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485170; c=relaxed/simple;
	bh=AS2TsFu8Kc7csbiJYii5SkgQrzo5hXNx2c6AtZWQVfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u1HRuAQHQ3BbWFVu9eZi2ocs8hwsU+EpMTAvk44RdyeEy+FAaWdd4J/ETsPUvAmgrF2LG5c4DebNHm2Ulkm3w9InW49CmPUEucu2s1TVrkPkF6veczZtLJuNc0TJNPKPJp0DYunljWOALfjsDbFBBF90WibyjyN/j3lz4Q19sp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s3QBcI6/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3EE4C4CEE4;
	Mon,  5 May 2025 22:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485169;
	bh=AS2TsFu8Kc7csbiJYii5SkgQrzo5hXNx2c6AtZWQVfg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s3QBcI6/oA0tA/PINZMYq4M38D3tbRwKAXJDV6Hr+ga8m/gVZZ95oar+vdrAk5Yhd
	 SGd6VqgCRRpKTqJCkcn5HzEFAfu+R+eGBjc6WSDDlqQ6kg/MBANCXMVscaVBxH4iyF
	 MCyVB6QIn1ExoO6/X+Ctpw/GnBfzOiewFztOcJl2T2lXkc75NLPHMSW5kSUNMBDglS
	 0b9Qln+5S9vuIv0nBjPeMFc6zwX3tNo+FCOoCvt5VUz7hh8ljH270qq2IJeI0adTjc
	 Lc3IO/Hsc0RuHl788v3v3ExF8rxDnbk/O50eDOfYe15liNSmz6xPgITNzLoAtip5kS
	 URYXhj3D+7o2w==
Date: Tue, 6 May 2025 07:46:04 +0900
From: Mark Brown <broonie@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, lgirdwood@gmail.com,
	perex@perex.cz, tiwai@suse.com, javier.carrasco.cruz@gmail.com,
	linux-sound@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.14 591/642] ASoC: cpcap: Implement
 .set_bias_level
Message-ID: <aBk_rHbbzvR_vD64@finisterre.sirena.org.uk>
References: <20250505221419.2672473-1-sashal@kernel.org>
 <20250505221419.2672473-591-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BmqjSXNMkh0e0Yd9"
Content-Disposition: inline
In-Reply-To: <20250505221419.2672473-591-sashal@kernel.org>
X-Cookie: Well begun is half done.


--BmqjSXNMkh0e0Yd9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 05, 2025 at 06:13:27PM -0400, Sasha Levin wrote:
> From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
>=20
> [ Upstream commit 5b4288792ff246cf2bda0c81cebcc02d1f631ca3 ]
>=20
> With VAUDIO regulator being always on, we have to put it in low-power mode
> when codec is not in use to decrease power usage.
>=20
> Do so by implementing driver .set_bias_level callback.

This is clearly a performance improvement not a bug fix.

--BmqjSXNMkh0e0Yd9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmgZP6sACgkQJNaLcl1U
h9AzuQf/TsuJY2vN7IY0edGyLFwWnvp3oaCEwl470g0akuayphANG/PQhswy/1aF
mNXr7LOguHFmhEVZeH20D7ByqnzGffdB511QUKgJXIX4B6zyhpzn51hqJc8BYTXL
tcOBAnJfTmjdyHW4WdbEd7zln7BcX2gmDbPs9jYzERHtbqvuTpPeIrXN/qrwlBrd
z7S88euH09affGKk1ypNJ9+NCbi0vhljp6cOI4BB2AN+UnC8pi3EG4j5rPk9HN4a
o134B+T8brNoSzEExEj1B8eB2yrxD/aQ70/rwu0XCMfGwuw8bIFF2uNR40JhhUSv
sW/Qtbq6cvzmIyrlCJmIM73woreV5Q==
=GcKz
-----END PGP SIGNATURE-----

--BmqjSXNMkh0e0Yd9--

