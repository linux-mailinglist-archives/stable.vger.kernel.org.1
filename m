Return-Path: <stable+bounces-176437-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21DEBB373D0
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 22:29:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DA3D1893073
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 20:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3763B2DCC01;
	Tue, 26 Aug 2025 20:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="GcHQRGWn"
X-Original-To: stable@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1C419FA8D;
	Tue, 26 Aug 2025 20:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756240177; cv=none; b=p2ZY3ps392LXSW4Wm5pFfSpq8wjqM15gZzvQLeiMkdIFRltpY0t89TINxP0kOuGJnOErEBm+VefWA8DC5jB601PkbGOOO+Kqmk78m41e5AnFjyn07OJlrhjkOKrFv6/zpfnor4Y3jguykph0A6vNWX3+R+DpK/jQjA78A5Kv9WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756240177; c=relaxed/simple;
	bh=IuWqYdocJbqzcN8QHCz0euYVZoPszlClNC1l7YKAmC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sKK+0Nuhrs7x9Oa4qR0FOFVO0pk4xbnayeA5LoPVeYx52olY/2zStZIzP1/3jmxB7ZQ9bOuKgSNo4xfHjnxcwd0Q/EhxYWQQv5NucZyC9OxQNmKLs8tQzeyqDmYEk8fY/OqPXYD6RtpElOGqUwlOv9ue174vF9jFAhMbhAiMuJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=GcHQRGWn; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 82ECB1026E14E;
	Tue, 26 Aug 2025 22:29:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1756240164; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=ueU7h2Ggrqx6Kn8QwnWa6YKbvUXUBr9dG1Dh/XCPykA=;
	b=GcHQRGWnnKdpRgD9XI6vqHb6okKJ44LyBK+HoQHRsFDmERhbPg0BtlMQKjR15nW4nW95A9
	nTs6JxUgzXjBCnlFstVhhTA6pA/r9AIQC69FvXGa4rCGc4+ZfMmdDcWcoLScYsqKcsOEGE
	ErLeCnrw2sS8wcD6L9JCESuEa8GOYkGdQRIyLH+o9BQOmTHnpoluEvuA4stkG8rEVA2Tzh
	hRoMpXgYm1jJZHZSXtFhA0HcijkSoQ1vc9I9I02lRtOSMS9niEXvyE+zwSDeOAgbtTJcCE
	ZvpcRNjv+0GHoRU0uWfeoDQrBlLG2YdwgGdU6VYojEpdSFVGsv9vxl9ZukL7Kw==
Date: Tue, 26 Aug 2025 22:29:18 +0200
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
	achill@achill.org
Subject: Re: [PATCH 5.10 000/523] 5.10.241-rc1 review
Message-ID: <aK4ZHmebgVFn21mR@duo.ucw.cz>
References: <20250826110924.562212281@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tvkH+yIFCJ7TPG13"
Content-Disposition: inline
In-Reply-To: <20250826110924.562212281@linuxfoundation.org>
X-Last-TLS-Session-Version: TLSv1.3


--tvkH+yIFCJ7TPG13
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 5.10.241 release.
> There are 523 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

CIP testing did not find any problems here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
5.10.y

Tested-by: Pavel Machek (CIP) <pavel@denx.de>

Best regards,
                                                                Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--tvkH+yIFCJ7TPG13
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaK4ZHgAKCRAw5/Bqldv6
8uQqAKDAir4XOwQfNx6BDTMuGS5cTECcgwCbBEFvR8HvAA1OdnF6/mH1v+OuhS8=
=mIT+
-----END PGP SIGNATURE-----

--tvkH+yIFCJ7TPG13--

