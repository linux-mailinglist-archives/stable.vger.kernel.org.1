Return-Path: <stable+bounces-138949-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19116AA1C0B
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 22:22:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1B7E4E26E1
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 20:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA0C264629;
	Tue, 29 Apr 2025 20:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="M8q/mjVp"
X-Original-To: stable@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5319525E47B;
	Tue, 29 Apr 2025 20:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745957931; cv=none; b=M8mC1aw507mlNkDiKkUCTvDEL+5aYWq4OQCBaiwbxVcM+SYSpkHikpD90tFP5huj1tAaT55kQMBzhZFqn0oXmjxwDH0BevKM8wJgU0DRzEfm5QsCs5GqHIaDbjkzn9P6gEgiESSzy283XoPaFZwVaRu4Et/kdUdySDmjpdDQxWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745957931; c=relaxed/simple;
	bh=sDMxoCpucl7FxGwnSXWDMmTs32K9ueRzoHGHU98VOYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hv9E1wRT/W28X/yLnvwUlt7Iiuyw7lAq/QjhdHLGE9AKxZxSap04T90qMWNwpkITzvhIwv7QFwVk7BuOYM66rpYM7RjJRDN5Qzl5HSnndYFflkCm62WGgmko5dnegC/SsmXdY+M/QvkeYXQfQf5fIMYTzrqlZ5q7BtSOjyOPayk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=M8q/mjVp; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 625A210273DB0;
	Tue, 29 Apr 2025 22:18:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1745957926; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=03RJ6CVBBgFmy/eiFwV71/JOGoxqIX2jDinYEZTMhQQ=;
	b=M8q/mjVpAHYHYEZK5YFKnqmW2WyeCR3hPZaXaWCvE8fWTg1BScBirgNma9cDe3zWIwvBuy
	lXNBM5pm25Bl+A5GQiqbKS3/vnZIHSSvoPGq2SvIeb12ujTmZHTETNSqCoPeGzFN1EvmZL
	DZwMBGoirIcVd129wCZXOG9BSLhr9oBXI2oMGxjdmfjGGTNDr2mHFFJdXpg955AT98q/rg
	tkBRrpBmmiJQkaehmhrZm0O9hOmK5ss4kIXtFngveHnh3W7yRgi1z4dahMv1AmsVrXktiC
	tfl1wKnEc3ZrDqce093H0Y/10ZOxKy3Z8rMaogMX1+1IuF4wBYf2aM03ADVVsw==
Date: Tue, 29 Apr 2025 22:18:41 +0200
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
Subject: Re: [PATCH 6.14 000/311] 6.14.5-rc1 review
Message-ID: <aBE0IVi4gqCLpdu7@duo.ucw.cz>
References: <20250429161121.011111832@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2IQwKLXhs60ALlL1"
Content-Disposition: inline
In-Reply-To: <20250429161121.011111832@linuxfoundation.org>
X-Last-TLS-Session-Version: TLSv1.3


--2IQwKLXhs60ALlL1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 6.14.5 release.
> There are 311 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

CIP testing did not find any problems here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
6.14.y

6.12 and 6.6 pass our testing, too:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
6.12.y
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
6.6.y

I'm still retrying 5.4 and 5.15.

Tested-by: Pavel Machek (CIP) <pavel@denx.de>

Best regards,
                                                                Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--2IQwKLXhs60ALlL1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaBE0IQAKCRAw5/Bqldv6
8ou6AKC9vt9++Fuyt36MUw6sabcV7fSCpgCghmJkgIJBeDshvTrNjSMf+ze4B2I=
=jCHC
-----END PGP SIGNATURE-----

--2IQwKLXhs60ALlL1--

