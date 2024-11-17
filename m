Return-Path: <stable+bounces-93680-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F55C9D0402
	for <lists+stable@lfdr.de>; Sun, 17 Nov 2024 14:28:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C637E1F22CC9
	for <lists+stable@lfdr.de>; Sun, 17 Nov 2024 13:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD39C1885AD;
	Sun, 17 Nov 2024 13:28:39 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90B7A937;
	Sun, 17 Nov 2024 13:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731850119; cv=none; b=WwfRz9OesrgOorlhKKR1/CKZKf+OdPYx5qJz5K/DdB8RL4WbKVajggi+R0I5dU1iZ4WCmWq78CXQEHmly85dDXZd61B0075m+P6B/VlAtN/n3xO6SzoVTzh8OuxDglQ0NnQxYjcGu1QBEhkxl00sZiLUKw+1BWVdY1ZUHtGLmjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731850119; c=relaxed/simple;
	bh=bx3r4QIQAahFoDG2DBeu+XZjR7UMy/rwEfagxq56LVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pu+jio7AV+CqURg/K9Y90nx6vDOf1TN6lTucBn7+0eyrQ4GaYJNROmHjw2R7jvgqn2BJnvJedSPQnOIAbqKIbUofarcj810kjKJsIiu/pztO3Nbh5jHXE4WDMQPAp3CsAdWR+/Yvcn5WCcinb5JkWw99qLeov7gmmxyUgHLE56c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 1D0211C006B; Sun, 17 Nov 2024 14:28:35 +0100 (CET)
Date: Sun, 17 Nov 2024 14:28:34 +0100
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
Subject: Re: [PATCH 5.10 00/82] 5.10.230-rc1 review
Message-ID: <ZznvgmzumS+ZS3tm@duo.ucw.cz>
References: <20241115063725.561151311@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ycXsIuw838M306Fg"
Content-Disposition: inline
In-Reply-To: <20241115063725.561151311@linuxfoundation.org>


--ycXsIuw838M306Fg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 5.10.230 release.
> There are 82 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

CIP testing did not find any problems here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
5.10.y

Tested-by: Pavel Machek (CIP) <pavel@denx.de>

Best regards,
                                                                Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--ycXsIuw838M306Fg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZznvggAKCRAw5/Bqldv6
8qSBAJ9CFbPWc4s1QV9FZHlvnYK4ghoN3QCfd6VKpwUc8YM9J2P5yaQyWr5IGyc=
=eiwy
-----END PGP SIGNATURE-----

--ycXsIuw838M306Fg--

