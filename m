Return-Path: <stable+bounces-179794-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF33B7F4D5
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 15:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09F0C5843B4
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 08:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E593305965;
	Wed, 17 Sep 2025 08:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="OAE11JPL"
X-Original-To: stable@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA8B305951;
	Wed, 17 Sep 2025 08:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758096231; cv=none; b=tTaXDyAkMkQhY3/bgGtizQIZz+fflD8IlKDJ00/lGRnCmdvQdFD9hTKGOf9XyzMll/3kveHv3F/HhpDfxkeWmUP8NTYs3eLk9NrCztDfIIIbaC0okN4Ae34oAe74TwkxmGdfWIYcoeOmqChTtgTLq6/E75PxDOIupEp2Nyuk3Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758096231; c=relaxed/simple;
	bh=tbUL94MeCSSF6v3N6bymIhC/nccgeSjQ8Ybg/zu20B8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r0maPHenPy3v6R51DRInsdEzoWOLgtp0VicsS+5NDAXW5iopKn6NS9VJf8R1p0nMT3HuER+2uSNLytArelB4c3fCjmPbqyNZvm5g13fQnwDtwYRHgdNOAPuP9LDHuOkqaXgOfII6+mALbc2NAVIwCHp/AZnd08x50iiu7Us0OOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=OAE11JPL; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0547B1038C113;
	Wed, 17 Sep 2025 10:03:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1758096220; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=6O/cG7X0J8S8E44BGSbpUb2egFNSU+5ywZqLm1L0xGw=;
	b=OAE11JPL5mQrsKVYWy3+Nqn9ErIRl+aLIyUuczVr8bWoTPQBkGQlqTIckPXgqT6mWMpKr3
	LtwpI1m1UVGilT4VqGGNATYDsymbIpaq7MTCarM9PW+DGxn620BqGWVWvclREEfe0zAEgO
	JF1jvPmrKumgpFdc2gSTZyyCkhTyk7QclB10JnojuiD/TSXbipSPWDVzSqARnhwdNWVPba
	tKHKGuV5N1WEGqaRJplwRhfypike+F63z/VuAxdLFTs/ptfxXpUpcm83cIEW9uxcrWwb2u
	7kUcWH7PCXVYxQx1g3n7e91iEma2/+R/H7uO+DEEaW7p5HsuOvRw4H6ue6J40g==
Date: Wed, 17 Sep 2025 10:03:30 +0200
From: Pavel Machek <pavel@denx.de>
To: Vijayendra Suman <vijayendra.suman@oracle.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
	patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org
Subject: Re: [PATCH 5.15 00/64] 5.15.192-rc1 review
Message-ID: <aMprUig11RJudhWO@duo.ucw.cz>
References: <20250907195603.394640159@linuxfoundation.org>
 <66ec2897-ac66-4f6e-b884-1609391239d1@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wQkK7mwbUUTBElZC"
Content-Disposition: inline
In-Reply-To: <66ec2897-ac66-4f6e-b884-1609391239d1@oracle.com>
X-Last-TLS-Session-Version: TLSv1.3


--wQkK7mwbUUTBElZC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2025-09-09 19:40:49, Vijayendra Suman wrote:
>=20
>=20
> On 08/09/25 1:27 am, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.15.192 release.
> > There are 64 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >=20
> > Responses should be made by Tue, 09 Sep 2025 19:55:53 +0000.
> > Anything received after that time might be too late.
> >=20
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/
> > patch-5.15.192-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.g=
it linux-5.15.y
> > and the diffstat can be found below.
>=20
> No issues were seen on x86_64 and aarch64 platforms with our testing.
>=20
> Tested-by: Vijayendra Suman <vijayendra.suman@oracle.com>> >

A little bit too many ">"s there. I guess there's missing \n or two
there :-).

Best regards,
								Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--wQkK7mwbUUTBElZC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaMprUgAKCRAw5/Bqldv6
8maNAJ4ydZ9lk45SbXD2KsyokDnqUrLUVgCgiMyXtpjxDC2qXlD2LmitTDlDym0=
=97Le
-----END PGP SIGNATURE-----

--wQkK7mwbUUTBElZC--

