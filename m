Return-Path: <stable+bounces-106163-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06DE39FCD92
	for <lists+stable@lfdr.de>; Thu, 26 Dec 2024 21:21:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D61B7A0F88
	for <lists+stable@lfdr.de>; Thu, 26 Dec 2024 20:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6666D1474B8;
	Thu, 26 Dec 2024 20:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="LN/cNB80"
X-Original-To: stable@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6EE061FDF;
	Thu, 26 Dec 2024 20:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735244505; cv=none; b=gdYsBN1aqMAYM6s//A7p1L1fSo0Gf7+wlby/qaYLSVYyLobTQraH3pOt/3YrYQTBDpBpGfbNWkPiuVkGCWAUxmKzriEEKJlVmcWkSov9CZXBkjh5755oN83gZK3C/stKcpxpqn1/tld2hRwSV+LNrxayd6xIcdf055xht0BQuWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735244505; c=relaxed/simple;
	bh=Nr4BNDAiONN0lQOy7SQhlDh9VQb5Traq50M/a9PMXFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eqeXYO20I+yNXETDNpk+ZrEiCOLDImUlhHEHz9B5KoEtEWzdpcnoqEXzEWXwpuLooorDLW4iTKmF3jplKrbBbfYPw11KhPxgghySN7hbLrvpN1/Ihm36uitJoYZFE+k51NfolY0IFDhpMeUfySmOBi8pwfD8p0QCoFM0MY6NyK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=LN/cNB80; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5E56810408FAF;
	Thu, 26 Dec 2024 21:21:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1735244501;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JK+ei++vKPa0VfwieqMiK89n+GtjDWuvAomMunUIVYE=;
	b=LN/cNB80CUgSRcokvRWQFyUZz9ZT5pTSm2WhhKiely9kigHuUmWMfdXpf+LLM8Qeyz4cF/
	fkjFqcCo5P37aQ9E8Zet7WZLm5EvPq3irnTNH+tq4SjABg18rTLz9BN/pkaUu+bOQaW7Rl
	HC1x+KF63/FHMAbr6UVorSqmX7u5A2q1uYSv4KBA0+zi8VPc3hhyUiiZaf3ICjdxUPS9IT
	7KT1gclLxXIOEzfk7ha+F8BJFKOdbuFQN1MSj9LQGfQrIYLe17PxWs0Fwi+hKD4XVGNuIQ
	6T3dNrgqPaKgbJXwjZn5udN4RH3ktn7ixHamahuR2d0Zn+yVjcyxVZy7FN8EUQ==
Date: Thu, 26 Dec 2024 21:21:37 +0100
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
Subject: Re: [PATCH 6.12 000/160] 6.12.7-rc1 review
Message-ID: <Z2260fyPFGj0IoaH@duo.ucw.cz>
References: <20241223155408.598780301@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Arci39VYFY3NcwzD"
Content-Disposition: inline
In-Reply-To: <20241223155408.598780301@linuxfoundation.org>
X-Last-TLS-Session-Version: TLSv1.3


--Arci39VYFY3NcwzD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 6.12.7 release.
> There are 160 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

CIP testing did not find any problems here (obsvx2, bbb are test problems,
not kernel problems):

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
6.12.y

6.6 passes our testing, too:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
6.6.y

Tested-by: Pavel Machek (CIP) <pavel@denx.de>

Best regards,
                                                                Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--Arci39VYFY3NcwzD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ2260QAKCRAw5/Bqldv6
8qRWAJ0WSRtKLUPiY1tJglB3PGfNgxeP9ACeJlNud+7UNoyVi3nkRs5KpgHqkFI=
=9lCu
-----END PGP SIGNATURE-----

--Arci39VYFY3NcwzD--

