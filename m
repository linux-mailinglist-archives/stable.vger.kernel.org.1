Return-Path: <stable+bounces-197583-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D05C91F87
	for <lists+stable@lfdr.de>; Fri, 28 Nov 2025 13:20:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCFD93ADA8C
	for <lists+stable@lfdr.de>; Fri, 28 Nov 2025 12:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF2930FC20;
	Fri, 28 Nov 2025 12:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="N1jYfmb3"
X-Original-To: stable@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74E230B525;
	Fri, 28 Nov 2025 12:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764332408; cv=none; b=OMf5jH71RYv9guW073gHZKk3mIs7gSf5Jo20w5Dqn2U/wm775h6LntBagjJGbi0kcmeORjdyB5Cme6vSHxmhw9nLAwodFMj7U5CM1CJsGFeB/ruKfUBte7fGLyiivZ+e9z0461LNWYqbZTxVtCIV/f0/OIFjeaNVeucyOwQsUIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764332408; c=relaxed/simple;
	bh=CdmwPdrr3EARVtj5K3PbHB+9TZqqKUswINQfw1bWmuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HeP6z5KXnq003eA3v4dps2VsjWdXrPUZupXcFPQ9lhzFomyOjrxDH9d3YKfzK7jG7OZcJcY9rSkiw5TrrqXbCPLpYoXCuS1PZ2nfILdFq0eFAZfbDXVpAbG/Afvoc7T6Z/q1gHApcmDD9YIwc6kZZ3n8H8ng9BFmDofCz7R9LCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=N1jYfmb3; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D4EB51038C12D;
	Fri, 28 Nov 2025 13:19:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1764332396; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=Pj85ndYF6D/9EHzFbQU2VeVO43xCrB/B0gLvmyv0Qtk=;
	b=N1jYfmb3Plr8WpDrL9LOTlTzYJmUjZl+MT9ZS2mK9wWltQ2CWqu9cEYzO4lAAOtOTjrN6I
	pIk0EFn+NRgYV4LbZfsPjTyK4LFI75pfG0o1WIpQGH/foaZ362aQ5l+QQXFuzwByNwD8wl
	hdxzJ3dKoIQ5ZvBiEc4TPZJa+/E7+lT+HeBzDduN0SMGh/GB573RXNYXLG8Fj0dXhp/fvy
	p8hAG4UG0MVnqy6z3UcvgaZWFT/z7fBFAZR2s/DPFwJ9U9fKZX1299RT+gsydQgZni7TFn
	tOZREaTO8OAI2U8dzChGpo9aItZppr6y3tIr5QZUZTeeJPVQC9q5sROWqmxeWA==
Date: Fri, 28 Nov 2025 13:19:41 +0100
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
	sr@sladewatkins.com
Subject: Re: [PATCH 6.17 000/176] 6.17.10-rc2 review
Message-ID: <aSmTXZeXr0yM8psa@duo.ucw.cz>
References: <20251127150348.216197881@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TYsNH0V++3noc6jD"
Content-Disposition: inline
In-Reply-To: <20251127150348.216197881@linuxfoundation.org>
X-Last-TLS-Session-Version: TLSv1.3


--TYsNH0V++3noc6jD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 6.17.10 release.
> There are 176 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

CIP testing did not find any problems here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
6.17.y

6.6 passes our testing, too:
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
6.6.y

Tested-by: Pavel Machek (CIP) <pavel@denx.de>

Best regards,
                                                                Pavel


--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--TYsNH0V++3noc6jD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaSmTXQAKCRAw5/Bqldv6
8iFOAJwOSiw+savJH8uBnD320+UEw9SQIACfUgLEw53Jj3yS+4ECdudQZTvy6i8=
=nayA
-----END PGP SIGNATURE-----

--TYsNH0V++3noc6jD--

