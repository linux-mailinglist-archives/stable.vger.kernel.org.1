Return-Path: <stable+bounces-52170-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8799908790
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 11:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEAD81F24BBF
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 09:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 982771922FA;
	Fri, 14 Jun 2024 09:35:17 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF22146D60;
	Fri, 14 Jun 2024 09:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718357717; cv=none; b=pdx7t01H3WFuGWL7AezhymaASmAPIp360YAV0a6KDIkmvH92zsKAcxlguvrY7xZb05P970JZ8gAYFnFl1cO6hawRW0ILPI+LFg6y+dAZ61WK1c4CpDG1uzqArDyoRyj8z2otZtcgYiZPNsWHMVbt7QDVQUhORuz0nkTFGNLML6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718357717; c=relaxed/simple;
	bh=+SRN0TRxmcBxaF6CyBtFMH7/VP/6CAVDDqHQgSCDdoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UwXB4afuENequALET0r0e2m4YBLiR20KjxHxN6pYNQ/cCN5UZzTmHcXs1JqNYdMAT7IXTByLBf0T3enLEWQUTBIPKHeztd+uFBwOekj5m1FYV7cjz5BRbc8qcWzzU4F+LE3NouzB5dlOo7EZ1ApdNnVArpG6mOxDYXj5M/v7CMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 2CEEE1C0082; Fri, 14 Jun 2024 11:35:08 +0200 (CEST)
Date: Fri, 14 Jun 2024 11:35:07 +0200
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.1 00/85] 6.1.94-rc1 review
Message-ID: <ZmwOy7M+WQQweaSD@duo.ucw.cz>
References: <20240613113214.134806994@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+Bb+eb7BKPYLfG0z"
Content-Disposition: inline
In-Reply-To: <20240613113214.134806994@linuxfoundation.org>


--+Bb+eb7BKPYLfG0z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 6.1.94 release.
> There are 85 patches in this series, all will be posted as a response
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

--+Bb+eb7BKPYLfG0z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZmwOywAKCRAw5/Bqldv6
8p+8AKCMHRgKGCDAtTKWJK79aoTPmKVQ9ACfYdtDawBVEOzsLgCWqASbflOXtqI=
=5RJg
-----END PGP SIGNATURE-----

--+Bb+eb7BKPYLfG0z--

