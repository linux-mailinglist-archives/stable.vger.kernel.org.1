Return-Path: <stable+bounces-73659-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 890EC96E2E2
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 21:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32C311F21B36
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 19:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E010518C342;
	Thu,  5 Sep 2024 19:12:35 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29EA3158DC8;
	Thu,  5 Sep 2024 19:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725563555; cv=none; b=d/AtHH+E5kwkqCnwi1C5RJoyfPVnUCWTMf34YCTyhckmgBqO8X1rf/Xr30Bc2MZlhWBGZdZCMKAevCjcq+qzTmJM8awLwudPo3LoahkxsoVQBFLBdVvhh1NBRD+eXXYlZqcJMIg93xpfBo0kDVE2aXKYJgvLDqDkvL1vxgHOB2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725563555; c=relaxed/simple;
	bh=RY+285Jvos3Lce3KrWnNw6KwCdu7/GEnZ9+YO6AgHtI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kuvCwUqGlthky4d+PDE1fAlwRyT/QTVWaNRQ5U6kVCqHtqHGGll8hB8j2FIfAEDDP4lx0Ik7Kyt8b8hiWGn0prjiz3M9pkMjXGzL9DsfYenCyy99RrIhBVmnMa0YMIbIvmwwJ99cbHwjpY3gLCO4BGXlYQcwpGamYBCysa4vWa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 24AA41C009B; Thu,  5 Sep 2024 21:12:32 +0200 (CEST)
Date: Thu, 5 Sep 2024 21:12:31 +0200
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.10 000/183] 6.10.9-rc2 review
Message-ID: <ZtoCnyqAzR4U53nC@duo.ucw.cz>
References: <20240905163542.314666063@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wfZdgS/jjDdO1Cjo"
Content-Disposition: inline
In-Reply-To: <20240905163542.314666063@linuxfoundation.org>


--wfZdgS/jjDdO1Cjo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 6.10.9 release.
> There are 183 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

CIP testing did not find any problems here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
6.10.y

6.6 passes our testing, too:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
6.6.y

Tested-by: Pavel Machek (CIP) <pavel@denx.de>

Best regards,
                                                                Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--wfZdgS/jjDdO1Cjo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZtoCnwAKCRAw5/Bqldv6
8gd7AJ4snB18i7j0boxsfoFJjnC6etZliQCZAUruRiQBj62GsWYUlIZiDlk8W0M=
=lhjw
-----END PGP SIGNATURE-----

--wfZdgS/jjDdO1Cjo--

