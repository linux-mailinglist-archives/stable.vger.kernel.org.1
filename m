Return-Path: <stable+bounces-104273-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 322989F2308
	for <lists+stable@lfdr.de>; Sun, 15 Dec 2024 10:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B5BD7A1033
	for <lists+stable@lfdr.de>; Sun, 15 Dec 2024 09:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB9D14A0B3;
	Sun, 15 Dec 2024 09:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="NpqNgQQV"
X-Original-To: stable@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A128D14A4F9;
	Sun, 15 Dec 2024 09:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734255739; cv=none; b=QAfkrkF81zVnLwE4oTPnvBQX6M8QqOv0eYw8lIiXO+bA9TKHcuZplkDcJPuMAbMSGcGeZe0BhVO0tnnT2+/EIABlqb1RcqaQW76BGugxCeImPGmyAkvmn10dkf3MfZIk81wijGBsS6w3TjPjuqZ5ILrnXq35xd6VWml88atKcEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734255739; c=relaxed/simple;
	bh=xMVOhtbQytr6wEIhe7eAl+vJ5qEW9VuVwiOHBxSryjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ENef/a2ZZa3aocaohUBwvmMuwGTYrAFfGkUlJtZtXUC2u0dlubUCImojTsYcLkW0lehQ1EkP0vFVDRAbeWrB+XQxz2/thGjHiQhnPXWkta67HhyaoGN2gf/mMWprI4q9ib7g5HMDqLH3VjnUUkyGF1W2FnmF8nf7zONiYG6goxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=NpqNgQQV; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 720DE1049AF53;
	Sun, 15 Dec 2024 10:42:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1734255732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RsKpE+SoXaRl2pX/ah17zsvmzlMzy0vowGk2sPgroH4=;
	b=NpqNgQQV9XPaueL7GniXS73T1GcRv5pKgDOFMcozcWZoI07xpvinPJj62UHVHLrHqgWy62
	HCBi8AH7nsrFAXg6Lvg4j7vsk2MJzC7LhbsQAuJE+7trumb/BU/An50O+Gy0Uj6mSXcss1
	1Y8QDDd8RilLn3nNs6XqYMAwyCcdKNOeBoyfspfmGTGdFA2jLugMirIOz2nGLfwDMDCi0C
	U9x02q4g/W4qj21m8UIJXLSbKE3XMVIJN7lcL6N9GYFIY4FCQ2An1yuMGL6nojbxIC2iHv
	D28Uq279lSYtxcF+UqY18C9gTn4LxqrUsjcFZVJhgQwx7kkU/Gpt92pKaZNEgA==
Date: Sun, 15 Dec 2024 10:42:07 +0100
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
Subject: Re: [PATCH 6.1 000/772] 6.1.120-rc2 review
Message-ID: <Z16kb0iKa/NTPUBO@duo.ucw.cz>
References: <20241213150009.122200534@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zz5q+IAwDhZ5Uyvh"
Content-Disposition: inline
In-Reply-To: <20241213150009.122200534@linuxfoundation.org>
X-Last-TLS-Session-Version: TLSv1.3


--zz5q+IAwDhZ5Uyvh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 6.1.120 release.
> There are 772 patches in this series, all will be posted as a response
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

--zz5q+IAwDhZ5Uyvh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ16kbwAKCRAw5/Bqldv6
8tMPAJ9TrajCnv3OTzQhfe82IktI9LVl/ACgizqO7dNpgCufuni9ko8hZ5kgDWQ=
=W7e/
-----END PGP SIGNATURE-----

--zz5q+IAwDhZ5Uyvh--

