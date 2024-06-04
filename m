Return-Path: <stable+bounces-47929-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B12978FB50C
	for <lists+stable@lfdr.de>; Tue,  4 Jun 2024 16:19:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6908C286782
	for <lists+stable@lfdr.de>; Tue,  4 Jun 2024 14:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D911A28D;
	Tue,  4 Jun 2024 14:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JnLToLMe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC81E12B14F
	for <stable@vger.kernel.org>; Tue,  4 Jun 2024 14:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717510753; cv=none; b=d+nmve0eG6GNHl+QssSBrDfY3xzODV7V5FaxfHSxjdDTcSoahM5OGsdhznoGvGmxy+5g5LVXUp0pUslPEpXpJ9GpvP8Fx6QHBH3bpYpWOc01cEPq+htEEc7UrxB/faWr+enwyXASXJ5UyqA44IbUugWbvg3aba8ldSrPgbQZth8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717510753; c=relaxed/simple;
	bh=svt/R/hpco/e7GTF3qHoaxdNx6Ly/J2mSsIoksmP0ss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z7PkxovPXrIAyM34aipjj1PkyO4FuUyIDbBuId8lBqFqwcf8+XI2A5Kh9x3Bx58TQGdcLWIv9CBmviaaGD1XI6ZUmzV3+z7b4rYAxzKXk96rrLPs0nZ2aag1unrmoBGw+GzTYSVYB13BbzlyY13XzZZbiY2vTVsPORgvQ94nbpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JnLToLMe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03E50C2BBFC;
	Tue,  4 Jun 2024 14:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717510753;
	bh=svt/R/hpco/e7GTF3qHoaxdNx6Ly/J2mSsIoksmP0ss=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JnLToLMefquPEgXbs1KIgmNYL0C2VCWmWBREpLeyCKrt8Ns1ElZkrBDRByVRG+N0M
	 NnOAJRsN70aWjteSWZ+kRbt8y81sTnM6ziHOMDbMRyNlow21QZvkkA/MK/npVtKjej
	 TeFDPTFgFZJ9d4xAKphV4dBmUl1sMh+jxB1u6eCety6K2QKplhagb/fIHLZqbJN/cK
	 DSF7NiO5Ifbw3yoarJHtkehDWRzjDG1GzdTLLSma//tFlX/hbXnWDEeb1nvn/GJqLg
	 AaC9lsUqb7vl2SNkm7ZmCSjA/wnAedH0PdFlEGswXYwV78f32Jx70i1MGEmbxl7ukT
	 rNDo5njgnhjsQ==
Date: Tue, 4 Jun 2024 15:19:08 +0100
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
	Maxime Ripard <mripard@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: Widespread breakage in v6.9.4-rc1
Message-ID: <05715fe6-621e-4759-82d4-7c9c79fb483f@sirena.org.uk>
References: <dc0c4e9d-e37c-442d-8b75-72f0e2927802@sirena.org.uk>
 <2024060454-clavicle-jump-c4f4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jnhEONL1D4e5BB8r"
Content-Disposition: inline
In-Reply-To: <2024060454-clavicle-jump-c4f4@gregkh>
X-Cookie: Is it clean in other dimensions?


--jnhEONL1D4e5BB8r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 04, 2024 at 04:09:57PM +0200, Greg Kroah-Hartman wrote:
> On Tue, Jun 04, 2024 at 02:48:27PM +0100, Mark Brown wrote:

> > and I'm seeing extensive breakage on many platforms with it due to the
> > backporting of c0e0f139354 ("drm: Make drivers depends on DRM_DW_HDMI")
> > which was reverted upstream in commit 8f7f115596d3dcced ("Revert "drm:
> > Make drivers depends on DRM_DW_HDMI"") for a combination of the reasons
> > outlined in that revert and the extensive breakage that it cause in
> > -next.

> Build breakage or runtime?

Runtime, the drivers get deselected by Kconfig then a bunch of graphics
and audio stuff is disabled.

--jnhEONL1D4e5BB8r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZfIlsACgkQJNaLcl1U
h9CLagf/eCHKzrRsjSuUPMCAjmP9vYA4ThnflkjyEs+BIN4QdblJXWySrVJ+OHJc
eKIx5vhrQxoJvKh19jItaxRhfNhnQPkjO8zuoJvq8NBVB97feWhQx0EePr5Evjb/
iGefOheodU4qyJ2Jqm2iM71gR818rM1MkOAPAXn5Pw6jIfoHmGEkbQVlCAWiC38C
MNpGBncX0wWE/ikdZiXCcQdPRmnLgDPQsTbs+IMBpsm1gxHGe5FzGxW/Lt86QMmC
2mJXb4vOr08NXdq7ok540GdHRpWrVtLnWQQ0MQbV4ZxBqkkK04G1Ix5hv/6cb1jB
PPsVy6VG1348KZKKMZAQFV0hr56xRA==
=5IRf
-----END PGP SIGNATURE-----

--jnhEONL1D4e5BB8r--

