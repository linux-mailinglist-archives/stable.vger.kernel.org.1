Return-Path: <stable+bounces-126640-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6185A70B19
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 21:11:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E15E6173445
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 20:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5993A26657A;
	Tue, 25 Mar 2025 20:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="D3tTe2W9"
X-Original-To: stable@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C056266569;
	Tue, 25 Mar 2025 20:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742933250; cv=none; b=Wy8v724bqKr1GDtUOofZSbMHM/hjWU1IVMLKNowlBiCT62dE4+wvBP7O/aaQ+9uVM8s4V0jy9SJrSJDtwqEkaBT+vIgutxPAf8bWLhe2M8nhuSzCDAmNAgkE2IGNCfyUKtKco+tlYXR6z/ZRQp83I8Q0s8JRhZ6eTrw7o+B83Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742933250; c=relaxed/simple;
	bh=h12nujPrVxEu5STE3RwRLUsoUnli6vhz58xY3+tYaTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DtWJ2PWQoHMpNa2ayEoEmC0C5Xa6vjgzWNv22GrvKpt8E1+h4ALirmlHhHtdX9MFpB/8xuE3pUmR2HG0HCTLU0WApoAlt5iJtlOwTj95GysSMwQq0YA71MCbXdRfC/Me/PYGbwMlTSlJPXnOguO3QIwyPZeqqbAU9hd7gvPMb3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=D3tTe2W9; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 15898102F66E4;
	Tue, 25 Mar 2025 21:07:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1742933245; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=mMWsmyRuKUUusNiZ9qsNQ3v93lX+3Lkzf2Js+Q75+KY=;
	b=D3tTe2W9IkxIyHacw7Kf4AVI0HXxENctJLjr2LGY0kng4oEYpkk99GmDmYHpRMnPGjoVKg
	tjNyjdhr/AftVD1cRiUKs6sbhkTwkTu0psmjqSndmqsaueDM51h7jzP5y1iWckq1dCFy6J
	KPlTtHcIYz56KtkZLernrSe9xogqZmZ5rL9XM91GWpngdSXt1yTdJjL+IiWJVSIbB778zo
	mxF4brgLf5Y9va0W4p/lCCKGn2zWIUH9SzsvlNDe9cBH/cAxDS/RVtfNBdjx774moBrgqj
	V/Y1XkK1u23bISJRyVArG1ta8h/n5Rs9Ilcg3WikGaFX+krNHEV3pkzo8EYC8g==
Date: Tue, 25 Mar 2025 21:07:19 +0100
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
Subject: Re: [PATCH 6.12 000/116] 6.12.21-rc1 review
Message-ID: <Z+MM96vqPR1MWz1m@duo.ucw.cz>
References: <20250325122149.207086105@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Boa8ut/6H3QAHeGX"
Content-Disposition: inline
In-Reply-To: <20250325122149.207086105@linuxfoundation.org>
X-Last-TLS-Session-Version: TLSv1.3


--Boa8ut/6H3QAHeGX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 6.12.21 release.
> There are 116 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

CIP testing did not find any problems here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
6.12.y

6.6 looks broken, I assume that's similar error to 6.1.

6.13 is being retried, I guess it will pass.

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
6.13.y

Tested-by: Pavel Machek (CIP) <pavel@denx.de>

Best regards,
                                                                Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--Boa8ut/6H3QAHeGX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ+MM9wAKCRAw5/Bqldv6
8obLAJ9OP+UGS1+0oXkcp6cq6rRxKDNLYACgiNnbe7kEkONB31XcWhUIBKcLjG8=
=+daf
-----END PGP SIGNATURE-----

--Boa8ut/6H3QAHeGX--

