Return-Path: <stable+bounces-93679-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0EB39D0400
	for <lists+stable@lfdr.de>; Sun, 17 Nov 2024 14:27:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8038D1F22CAE
	for <lists+stable@lfdr.de>; Sun, 17 Nov 2024 13:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 367831885AD;
	Sun, 17 Nov 2024 13:27:32 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FC61714DF;
	Sun, 17 Nov 2024 13:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731850052; cv=none; b=gxpbOwNy/pdwpHVYw0TtJgFwDCRtoHTTDnppMzxD1XnN0QUbKzVVN1JMZSZ/bdJqqGbSzWIKXf+z3kHdbQP1kvXUt8SIvLIA4my3Jh3q/+2LJ+SxS7F8YrZ3fcCQPBVjlkisT6GAdCedI9Wxh+zPVVKZR0Ten5k7Jfp1xZwV5iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731850052; c=relaxed/simple;
	bh=8RErPTwkylJwyL6M/PWGE9OaDR0n0llnGyOYCwla8so=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M2SGKesk5Uv5RYAqpw+zbZb2bWehk2U1bmrL1b5AOwaGasKkA55iirCcvWJejQ4cheqkHjomr132TQ9EZ3EEGviMdLbqmllgOVslxWaNnwYgUc5uSM8gsiBlLo/tkoQYH9BOU62EBzvZW7B34jvW/DwMhyI4m4IWiQYdDnSfmwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 638951C006B; Sun, 17 Nov 2024 14:27:28 +0100 (CET)
Date: Sun, 17 Nov 2024 14:27:27 +0100
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
Subject: Re: [PATCH 6.1 00/39] 6.1.118-rc1 review
Message-ID: <ZznvP/tS609FOH68@duo.ucw.cz>
References: <20241115063722.599985562@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZMgyRFyMNvwf1kEy"
Content-Disposition: inline
In-Reply-To: <20241115063722.599985562@linuxfoundation.org>


--ZMgyRFyMNvwf1kEy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 6.1.118 release.
> There are 39 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

CIP testing did not find any problems here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
6.1.y

Tested-by: Pavel Machek (CIP) <pavel@denx.de>

Best regards,
                                                                Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--ZMgyRFyMNvwf1kEy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZznvPwAKCRAw5/Bqldv6
8iXAAKC9NIaZeEnmWJzVpBE10WAmU36m4QCeNdzIlbbfzM6JwiVwYN+Zat+ul+4=
=BhqB
-----END PGP SIGNATURE-----

--ZMgyRFyMNvwf1kEy--

