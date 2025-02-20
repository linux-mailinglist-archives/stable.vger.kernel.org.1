Return-Path: <stable+bounces-118508-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4957A3E561
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 20:57:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1FE24231DF
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 19:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37640213E80;
	Thu, 20 Feb 2025 19:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="EwvtQ6Wi"
X-Original-To: stable@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5716C1E883E;
	Thu, 20 Feb 2025 19:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740081437; cv=none; b=sTClOwytRiaCfoV7pfeXh83nInwodTF4e8vAOlsmRdGbN/yy//FMMeQHxJQ2cy5dHNhBLsoTQ5DKixyba+2rtda1B5n3FlhcxhnLSg/EjEYbpParEDmynLlEsHf6IFBx596A74xLVg8uu2Qlst1oipMaN5aCIk4G1SZ0fbJHcsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740081437; c=relaxed/simple;
	bh=rhNRYvn+DdX8gdlvRnyY/2T8DeMLcSBO0EYXVjLwed8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k7KL++uMQe8C6qbxVPoUrOPrMjXidWNN+JY/iNWI92puuXnuN3OrmRodEjnpuM2n8RkyF4HWeTJLRBwmyeb/mnkRcg0GmkfeUcnSzVLFuYTQOgcyzbIRity2cNBRzXxD3bZy9hR+dwZ7Hj31swMsZOGcUZEJkK5BcbMJ1SlC7Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=EwvtQ6Wi; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 309BA10382D3C;
	Thu, 20 Feb 2025 20:57:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1740081431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6BeHgAJNCPXVhMCWWIUaLu/pLImJZmpygLdpID0UTCY=;
	b=EwvtQ6Wi1GVrQRQyhDGiy/BqpN4ZGJQfEnz2bj4al6tXc6+a+d4WWX18jmtm01vnypH1ge
	QfSFkS+Zbdb8dEdmBYN7wNVOcxHyOlcEMtU6XK20YjTFfUCa5SAPGfyk0o/YmK7M3Aswvd
	QgOdBbLmd4HFy1GtKCDT0Wa3R4vcaDf7BRV7g/yOyweVWlDVWO5J41mzvjdMmDxOBCaZWm
	Z5K3cdxXvZ5WZIVM7u9Y2N+lSY7VMdnP7c7sC7AR020Wnsny04SZLzwH+QCZWR5DfTKq+V
	b6NtNFoz0rTme8VKqtIgEpgTpGlWulDGnhMHTZFg7WRe0+8Ur0TBN0y4Tu/unw==
Date: Thu, 20 Feb 2025 20:57:01 +0100
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
Subject: Re: [PATCH 6.1 000/569] 6.1.129-rc2 review
Message-ID: <Z7eJDTrf/5758e60@duo.ucw.cz>
References: <20250220104545.805660879@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EMOJE/HPlVE/RmOR"
Content-Disposition: inline
In-Reply-To: <20250220104545.805660879@linuxfoundation.org>
X-Last-TLS-Session-Version: TLSv1.3


--EMOJE/HPlVE/RmOR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 6.1.129 release.
> There are 569 patches in this series, all will be posted as a response
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

--EMOJE/HPlVE/RmOR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ7eJDQAKCRAw5/Bqldv6
8jCKAJ9Ig0/7Lgd3ln5Bb+RcnOfnp8BVnACfdfO7sNMFGuRpj+ym528xqUeFQsU=
=KvCN
-----END PGP SIGNATURE-----

--EMOJE/HPlVE/RmOR--

