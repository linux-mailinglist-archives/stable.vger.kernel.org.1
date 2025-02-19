Return-Path: <stable+bounces-118238-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 779A9A3BBBF
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 11:40:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 655AC1898CBA
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 10:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 236501DE2D7;
	Wed, 19 Feb 2025 10:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="GqZH4TcC"
X-Original-To: stable@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5B11D6DD8;
	Wed, 19 Feb 2025 10:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739961594; cv=none; b=DWPltBgI1GD0AKKmOs6eZm+Cs3nZHROJCYO9e2nqHwwCWxnUAGOhDJUDZ82srNHjBAbiYCgvuyQRI9gCcx2XCfsNCfATiVEyjHEY1y9pZG+xvs8yjwe2ylVL5UqcE48DUoWWhsBz0wW2vJD2fZjJiqEEV0Q/KeeUhlfILwtioBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739961594; c=relaxed/simple;
	bh=TogrUvQlt1gaFgztsa1pyw9ZegJKiY/hNcKknZYEB5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cxvX0JkW7ZCEJI5X4GJmrs9UL7tCHuHRPy2OCKJEA+Dqy6m4ZkelkxWxbeN7JNOSyOxm3USLNbazL45zCNs2Wyb7bgGEHRDkyjc/SammhwprqJzUcnyF4o/H0Hydo51T5yyCsZS6XPbNvtoIVafn5Vt/Si5vs/hSzX08edOfPxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=GqZH4TcC; arc=none smtp.client-ip=217.72.192.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1739961562; x=1740566362; i=christian@heusel.eu;
	bh=4JOeNT3gI6trmavC+IfWbMMGMy68iPsdhleeSXnsKlM=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=GqZH4TcCe+Qujxm5980B5VyoTg7vTNXAgse8v2f+nFUsEIZsNiMkHT29O9qeFjkJ
	 oxK24J8lMgBQK2FBtsfGQrDkNQjpnJNusy9kmfXIJttJpKX/ahq89H4w2PGyZQKSE
	 1hj5KgUBDKIgSHoOA71bzIia5fobzif7I01i+gQGNUcHcnUjvohpwRqvoGB25eu+/
	 5v5bNMZs2FaMsC3EaFDQiZy4EP3YM4qikkOi0h3Ct6QaVFGUAfryQMWnJhg2TD9G5
	 lfYPqP0B3WH9E1aR7TyILEkqot4PoV3PzdEvaK6/C2wcDNZyEBDuUFM+kG8P03R2Z
	 xcuSB2ipNP+xDxBrjg==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([141.70.80.5]) by mrelayeu.kundenserver.de (mreue107
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MV5KC-1tsywW2oZq-00WBlI; Wed, 19
 Feb 2025 11:39:22 +0100
Date: Wed, 19 Feb 2025 11:39:20 +0100
From: Christian Heusel <christian@heusel.eu>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, 
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, 
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, 
	hargar@microsoft.com, broonie@kernel.org
Subject: Re: [PATCH 6.13 000/274] 6.13.4-rc1 review
Message-ID: <e73566d8-6d1c-4e05-b806-734759dfc237@heusel.eu>
References: <20250219082609.533585153@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gwd2hpvmfcpie2yu"
Content-Disposition: inline
In-Reply-To: <20250219082609.533585153@linuxfoundation.org>
X-Provags-ID: V03:K1:R3Z4jbSbRTwGXImYxYf+EkgwnYixT4CB3AhkHmm8KDUBaTmZjTv
 euJ0Px39g3pEgRjZf1tQtPdLYCSMJ2xStid7IQKEvtVLXesWNvoSFP0zF0LWYcUYARhTKL8
 g6GyPC5vv30wV3w9tClKsCtBjji5IhtHmDi+Hb3C9QA+nceIm7SrlyqQz94L3GKMUzdInVB
 uTv/59QA8d4e3O9TwVtLg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:eZiTHlGIkHg=;01u9xB/26FI3qHcuBb/CBb0aWRx
 e+HEnYIFXy4cKWVqG3hBpI/atukyO21UaLX7LXOUKTVIn7ktp2NcN6WXmnFLpzUrpHj3XW/1C
 8Lng6Rwypt9QokPVIEqanxk9pi+dWBNRbgCRrwR7z0WKMa0u9lAvgGAJECGDwh1eVNiVtl2qn
 oBio/AS1iF3RWL1ia64W1oGOLS6fbW5HUp0R3hkqTNHP3G7vJbmuAH8ovGKmSse9kWppfKlIE
 heWvvsYppfq8cpfa/4plf9Uh7+H+n63RqjfxmQgaDOZZjBd7yibEbnc5uzZztSrub9wfDQlja
 aQTcG+V0Fu7uFAbBL1Qta+i+q7lDVOf80sSwjm7n/4S5A8i1iTa0FHAIAThyBEOh8EszrN9co
 bKUOFobylivnEaqqt3lBAjnu+DTvbGjnyCO51tcXwBoWyo0G4zGzuRZfpVXJdW428QMyePy8C
 XLkmxzlwHs7QnfCShYcMkpJbxnPTO2m+iJr14zobc+xdGgV/7MV08wRN3GW/excqpVNaBvYS6
 mk2lpDlvjuc79RwF9fTyn5e7tnC42Fxo0dcqsXu1eICFer9+f4TaRlP0SN0NDCZS/fK20yQ/m
 rwDy1Exvz71cfyLEVFioYOl3F8NK5SU8llUhDviFAyy6z2t9vjkIwsjtPK6lJm+Bx4InvpeJn
 t9WAezjgX3EAfju0ijrJ3NMIyfgQX3M94WeZ9iwTx69b9qq/jAm1X9PdplP5h3hv7pXB3DvWx
 sihVwlEQDalas+OX6OrLJDmjG87KWLfYNPqtsdRnhVtDmoUAycT8HyjdGSGR1VCfY7/E8wqmR
 nm5W17R+Jg3gHSSvyZw/ScxLR+WqGkCAtkpRZ9/dIsesWCp22mLo+eSpr1/OCy8fbhedY+u6A
 IlXIEB2gSeVsVmD/1npwnRRslX4I1qpHVqlu6UHTMTo3wVTvum9RooCLRM/VvvLNohqLPQtY/
 7cZue8G4IpOHEUH1oXuBQWUICXnsB1JVO7X42B4av3H11i863Vjk5kWy3q5TgJhW313p4TiE/
 RAUOY29NlVJIEXeMmbthGw8IaMbfT1xdv1jNySVviIC27KI3j/L0Jh/XWqedoIEyiMgLy4snF
 gvdug3KgSZyByCCM0rasp/uKAWE7/U0Ry/dBUAHkcAJOewdd+XK/ahjyadgzu/aBwtXUEHu/C
 rEADrj8aMp7DBtRjHp35YiGaDOjIN1VYKyI7g09tcxmBKe5ZBYErczmcQ/roL+vdq91QLkrZU
 gX69ZnSp49dfaQgkpnNToUbE/eqUh058w1xsZm422hkIZibcqO0Svt0xDgXgq9O6kmC2wIgif
 BIM/jRWAbUoT9OqrIMhtJ0m0bKieTPmlobXJF1d2gcy6hCbdCE3EO5Rmm/AzUTt953ZQUv1Gu
 oM+uhncyk4gt2wFQ==


--gwd2hpvmfcpie2yu
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 6.13 000/274] 6.13.4-rc1 review
MIME-Version: 1.0

On 25/02/19 09:24AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.13.4 release.
> There are 274 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Fri, 21 Feb 2025 08:25:11 +0000.
> Anything received after that time might be too late.
>=20

Tested on a ThinkPad E14 Gen 3 with a AMD Ryzen 5 5500U CPU and on the
Steam Deck (LCD variant)

--gwd2hpvmfcpie2yu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb3ea3iR6a4oPcswTwEfU8yi1JYUFAme1tNgACgkQwEfU8yi1
JYU29Q/8DboiQjHpTqR3Xs5SQmsoSMXdn2sMGfnphyksbYSmzm3hMKg1n+fDR2z+
7umDKTVtPVxZVBFUjT57KpM9swnjT/JXA7NLcYW0rJXJ9Dc/Crv0U34VQhACg3Wx
iobUxDun9j3E5ecgFreYiCQ8uAzkuMjzlMZ7lodqosQw3etaFb06hVjKDfxPWx5q
xFPsrBV9sEFpIp0Oc93nC7xA6J/z5Ysjg/Xf/g4XjE1rIDflEO9hfFL39iCkSpTX
xxIGbrNqLcpKbPTNyExMqzeDThqEflXIYDQRb1J5mb1C3I7DK1mFbf0263UbaWK0
X0mfPW0m++msg1RWw+sIVgeZyH6nVjMytBAzbKFn/A+88f4upVs2qMRKFrbjyDDj
P9x8w7JodhF0RYSSbCa11XP85ICnyesuCMqWwK+h2psw4/1oFNXasaQwwcQULT1Q
ZGgLoGiDmtIDISULd1U36tkJwKr8v4ItAYfSZOI/bDBG3WRA4YS1Sb89h3X850u2
Cb5Z5DuDkwF/TD0Mu748Bg1s37W6MjxcOKo4rPbkzwqx4wg6+RaXTc3+e2guofEF
yAYCKUiO8W3FbibTEPbIhjJwWzSET4nZkwvuskKmtPqRc55tcLmCbahcqNLvy1uo
pH8G5WH1qtqWeO0VHwcNeE8EN8u/4vUYYrnXTMWDmC5usrENAsk=
=TDb8
-----END PGP SIGNATURE-----

--gwd2hpvmfcpie2yu--

