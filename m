Return-Path: <stable+bounces-45208-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3731E8C6B95
	for <lists+stable@lfdr.de>; Wed, 15 May 2024 19:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC6B2B2566B
	for <lists+stable@lfdr.de>; Wed, 15 May 2024 17:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3F247A4C;
	Wed, 15 May 2024 17:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="flxcqdh/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9242130E21;
	Wed, 15 May 2024 17:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715794561; cv=none; b=B2JWrA2yNBXYwF+Xh903ZAmvsfCs5wSubdXDM/r54+lwZxbBSvxDlIYdQEHhPvK30Pq6uv5fLgt48U6B5QZTaM/aI3+A45iyHzZoNpsgPdiRN0Pd2TxHDWV/+PcKveX16iRUMB/Hv7IyP7Nqn6qbKgoOs/SScQufRRFdJadX5vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715794561; c=relaxed/simple;
	bh=yXnKEY7Z7Ax7J2SD93pETUZSrJHw69qdl3ldfSTgVmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MPJnY7rnCNGGTudN3no0yN76WwHuMfAcbs3MDjPsuOryiuCnOBl+w9o9sU9F98R1Dl7AQrY9mzpOTShhSNMdjDs3bRsfFu2NcXZNUOXDNrPwrGsoh/r4KWPK6gimguMFzZ7rQl73jWQEiUSZVPWqnSkhK55P6P6CWzzKqyymflE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=flxcqdh/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F96EC32789;
	Wed, 15 May 2024 17:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715794561;
	bh=yXnKEY7Z7Ax7J2SD93pETUZSrJHw69qdl3ldfSTgVmE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=flxcqdh/t+vRwhPiATj3JGLuoLPmxoJccAkNm7yJzQ04v2gAHnVuWFFFzeWyxxtt6
	 fpyCIOxuvAKoiymF9zSuSBMAIA/aaEuBN/VJydlCvNbF1UgC3Tf/i+Y1vnCS7LXwpE
	 +LaFouIdH4ERaSURpgfoOnL+nSnk+otdKo6BZTvKi1Vm1IlRc419S83xH4BeZgdZaj
	 5eCoRwP2/E//KneKlB+Dz/cgCcX9UiFPJYArD2mhXHNxsmsE+KvDMhmCZ3Pv9SqW3r
	 nP9G7FiSuKXaHRobZswgj/wOjxaUqZ/ORfK1o0RhqmHjhBh/QtQb2BuD4e49m+IE2o
	 CMzjw0iwgIlKA==
Date: Wed, 15 May 2024 18:35:55 +0100
From: Mark Brown <broonie@kernel.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: linux-kernel@vger.kernel.org, Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"open list:BROADCOM GENET ETHERNET DRIVER" <netdev@vger.kernel.org>,
	stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH stable 6.1 0/4] GENET stable patches for 6.1
Message-ID: <9a9dc83e-b218-4f64-86ee-d93ed3592480@sirena.org.uk>
References: <d52e7e4a-2b60-4fdf-9006-12528a91dabf@broadcom.com>
 <20240515170227.1679927-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HK4sQHjHaWYDxkhZ"
Content-Disposition: inline
In-Reply-To: <20240515170227.1679927-1-florian.fainelli@broadcom.com>
X-Cookie: When in doubt, lead trump.


--HK4sQHjHaWYDxkhZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 15, 2024 at 10:02:23AM -0700, Florian Fainelli wrote:
> This brings in a preliminary patch ("net: bcmgenet: Clear RGMII_LINK
> upon link down") to make sure that ("net: bcmgenet: synchronize
> EXT_RGMII_OOB_CTRL access") applies to the correct context.

That seems to resolve the issue on 6.1 stable for me.

--HK4sQHjHaWYDxkhZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZE8nsACgkQJNaLcl1U
h9AT3wf/ZDrfEEjfakKbXaSYkehns/2opFXbU2zrFK2DrSQ/SqsTcxueMQGy3+HA
6vsWtMM8C5ppdGWH1YxtUYUnr/W6oPa62n68SY0T3zlJflr6atr3sgPc7dZItuQh
HosaIaZ2EDdqiegzVO05A761bp1bDgZnIzJBO65UhbNTUMlDxUg8nVAHMIGTsnaL
hK1n7oI09YcG5bds3IXr9nXu1pEyy2zv++ntM/1uRIHyfcQ64UHcmjudnwqcLQCs
0dM2z5TiBdGg3c2o1rhcWdPLFEOAp4pUBVWujUmUlSDbRBi1UEq8DXTb8yEPb6mx
7ukFOl/7oML4juegQjp6aN3Uh2Lrfg==
=ELmF
-----END PGP SIGNATURE-----

--HK4sQHjHaWYDxkhZ--

