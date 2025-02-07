Return-Path: <stable+bounces-114308-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75907A2CDEB
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 21:14:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEA01188C709
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 20:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672201A5B8A;
	Fri,  7 Feb 2025 20:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="YkFT9sq/"
X-Original-To: stable@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8002B19F130;
	Fri,  7 Feb 2025 20:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738959161; cv=none; b=u7JXWdRK+inXtC1VvLBEb18uHuxUMrjsxX8Ncg8ricubj6b6gh8h3TqNc6iK4eUsSHCZ3FGxdGgC7VVxNJbzJfiAcCtp5tlWu7tcJRZco+YE9rq2frxOWqG3lH7R9LJwPyDGDBTnEgtSVMDMKWwKSkVG5+IvNO0maMsrdWQY86E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738959161; c=relaxed/simple;
	bh=X7TkagegnQ0wCI9fzNkjWI+Q+lrc1KT7IkLrKsFt3ZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CBCeHYF9fHcqBDBdbOuU+4svg3k53k87rAPlB0VRWOaxSbFtlCTGICh8fS1nfVKUfCxSqTaxB64ECw4OJQDyBTH1aYt6PUcyuuamA2ozuxSP5E4mnMLuoh1gL9TOrdhIA7SC2NJFWoPI4TkMbOXS1YTLwGHQcCPR9pcK7fwbiyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=YkFT9sq/; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0A48910219925;
	Fri,  7 Feb 2025 21:12:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1738959150;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vz9q3mDYuAmWTxszoiH8p0Pj1nOmORpamSJolshMLl0=;
	b=YkFT9sq/y1eLd2LJ63qEuOW3l3hsTLpE/9QNq8FPQNZTw3riahDrFXQBbh3kTAsD1fT2HP
	5vJjNGzFITCsK0ZX9b6PIThT5q064S663V5Cydw2XMxQwBYQEwMhzZIJlrI6SblEwo4bJc
	XdxDra1Ml0L/LaKIxAgKQfjqCsIM7optKOXlLqOnBr24cUXCThO/aye6YqOPC+ookTej4k
	SpgaLG4+2e85S/8rEtqM3lsvi0ZP1madfJaNOH+UBWkaRTojCLbBDcQGSo79SmoBQtuYqB
	WJX732+iSb1NXko/RxXFRksTonAR+uI7qfCcHcUDYouBruHF38Chj9M6FXFk7w==
Date: Fri, 7 Feb 2025 21:12:21 +0100
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
Subject: Re: [PATCH 6.13 000/619] 6.13.2-rc2 review
Message-ID: <Z6ZpJe4AgSBXkEF0@duo.ucw.cz>
References: <20250206160718.019272260@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NIKWNCiO4hAxR12x"
Content-Disposition: inline
In-Reply-To: <20250206160718.019272260@linuxfoundation.org>
X-Last-TLS-Session-Version: TLSv1.3


--NIKWNCiO4hAxR12x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 6.13.2 release.
> There are 619 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

CIP testing did not find any problems here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
6.13.y

6.12 passes our testing, too:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
6.12.y

Tested-by: Pavel Machek (CIP) <pavel@denx.de>

Best regards,
                                                                Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--NIKWNCiO4hAxR12x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ6ZpJQAKCRAw5/Bqldv6
8p7xAJ450kK2AWfy8zs0Vfc79SxglZzaPACfU30sOyYjF3woLQV7Buy1UzjyypQ=
=A6j2
-----END PGP SIGNATURE-----

--NIKWNCiO4hAxR12x--

