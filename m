Return-Path: <stable+bounces-104214-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E7A9F20F6
	for <lists+stable@lfdr.de>; Sat, 14 Dec 2024 22:35:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE0C61667CC
	for <lists+stable@lfdr.de>; Sat, 14 Dec 2024 21:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18C21AF0A7;
	Sat, 14 Dec 2024 21:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="IOhWmr3U"
X-Original-To: stable@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5881990A2;
	Sat, 14 Dec 2024 21:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734212114; cv=none; b=kFK7a2x5G8wCE6KU52Pnbp9IL7ZQkoxcaHcgaOpfRoarjFHcGcMfSgqS4TrhCLXGnSmnS3KcTA07hsQN4Ac1wTNH108aUZiAxgvpAvTVuEjcemTxLj2AB39UoGTRPL0VwaioWWWMv1G22wNLNrNaY0jLeQTVyZqPGhtkzZH0w3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734212114; c=relaxed/simple;
	bh=HEALE/JOZh38rsxZp7qulteeuOusG5idMUEp/x8CEfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h38c8OK3whmgqYemVWpAWhCtq4QvW02WiWKRvZN8I1PJhRrgSS5wWb83yeJt1SUVvU3H0UoePQB/2iP8fP7xMPfEgTc8lzIPeYm0N4qs1x2iiRG2G+mfs9gRRP2buSsibcWb/5f0v0NnjMwufOh+jHp1tj23LNMlYPI1iH5oTvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=IOhWmr3U; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1D97A10485891;
	Sat, 14 Dec 2024 22:35:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1734212103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q7W3Ubmkk/SyQaAYhAdRw2h9Q2Q+2U1u64YapfLzPiw=;
	b=IOhWmr3Uu82uWRHu5dRZ48w1ITdjj6fGJTcb1QgIXT6WgL7QY99tuEA+TM8QBr3F1905Sk
	PTDCdBl/VzADN1IjKYwjc24yy884z9CiprOGdSpqXrDw9wJIvsKROg8gqhuvCtChjkPI/w
	s/QuB31FPEyoGzst6pZRLn9dNW3Kmo9rO4LzJLYYRTwH2FEM6CqRcibVovl2tQy4OTOm6C
	PJk1p9/6Rxh1Y155EAJnjY7wKoT3YffGsOgIamwUSayffnFTbf2H0n2zCAuGU+8NN9zLOr
	Rv+CU1jbjr6gioqzgVa3gBqzh3oWgE0CM6qiLWwqbUVjPj+p4jCtvB0iK7JLzw==
Date: Sat, 14 Dec 2024 22:34:55 +0100
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
Subject: Re: [PATCH 6.12 000/467] 6.12.5-rc2 review
Message-ID: <Z135///gGtiotX6h@duo.ucw.cz>
References: <20241213145925.077514874@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="81OwMFnNgHG+mgJF"
Content-Disposition: inline
In-Reply-To: <20241213145925.077514874@linuxfoundation.org>
X-Last-TLS-Session-Version: TLSv1.3


--81OwMFnNgHG+mgJF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 6.12.5 release.
> There are 467 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

CIP testing did not find any problems here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
6.12.y

6.6, 5.15, 5.4 pass our testing, too:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
6.6.y
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
5.15.y
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
5.4.y

Tested-by: Pavel Machek (CIP) <pavel@denx.de>

Best regards,
                                                                Pavel


--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--81OwMFnNgHG+mgJF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ135/wAKCRAw5/Bqldv6
8kKhAKCpaBQKshB17qKP76A4ErCj4ybmYACfYslpNyhVAcFvQVqdG9nYVWkyW0o=
=4q3e
-----END PGP SIGNATURE-----

--81OwMFnNgHG+mgJF--

