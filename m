Return-Path: <stable+bounces-65456-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F76494839B
	for <lists+stable@lfdr.de>; Mon,  5 Aug 2024 22:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3B8E283720
	for <lists+stable@lfdr.de>; Mon,  5 Aug 2024 20:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285F414A4E1;
	Mon,  5 Aug 2024 20:37:28 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDB313E881;
	Mon,  5 Aug 2024 20:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722890248; cv=none; b=XV/7QpsqzUE1kFtx2vqpBoEivvcs01ARQHcepKuIXcVujU8knt2y7kcDQpVwXpokM4vbRBPvj4b+6npahU4wo1M4DRzT6l330jSkfqx6uyefdapsSN6ypPkT6dE0c1hy/k7brZqQgvthNm0FLqj+7L3NKCy/f3YgF6RxtDzScF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722890248; c=relaxed/simple;
	bh=7+2SK2/0Mg7cQrO0vWtLDLCj9eIWq13brVxXgihEtLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nKEkRPi4bS1fmpLRA1rCGIQLWRy+pwQdEqPHfYDV+xU/L6Rr4I4aMuQEZ+qe7SbtvZT+01y3/c9GiRA8rI45k8fHHrfXhTVP2eJUITaw1NmIw/yX13X+CGXbHR377qmMwqQl4P08Uk913HdsewD7n4f+7I0hFzH+5Ix6O3oX1sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 2606B1C009C; Mon,  5 Aug 2024 22:37:18 +0200 (CEST)
Date: Mon, 5 Aug 2024 22:37:15 +0200
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 0x7f454c46@gmail.com
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.1 000/440] 6.1.103-rc3 review
Message-ID: <ZrE3+/rL2KxFRzFS@duo.ucw.cz>
References: <20240731100057.990016666@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="M0UNOviHzdSpNo2D"
Content-Disposition: inline
In-Reply-To: <20240731100057.990016666@linuxfoundation.org>


--M0UNOviHzdSpNo2D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 6.1.103 release.
> There are 440 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

> Dmitry Safonov <0x7f454c46@gmail.com>
>     jump_label: Prevent key->enabled int overflow

In practice, this will work, but theoretically signed overflow is
undefined and this depends on undefined behaviour.

+       int v;
=2E..
+               if (v <=3D 0 || (v + 1) < 0)
+                       return false;

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--M0UNOviHzdSpNo2D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZrE3+wAKCRAw5/Bqldv6
8p13AJ9L0B6215x91g6GiwokiZtsI0l0YwCdG6P9hxcnx8+53JNnbdcN7IKt1aE=
=5qua
-----END PGP SIGNATURE-----

--M0UNOviHzdSpNo2D--

