Return-Path: <stable+bounces-43459-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5273F8C0070
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 16:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0818B284172
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 14:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B838662F;
	Wed,  8 May 2024 14:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="OF//Msdw"
X-Original-To: stable@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588508288C;
	Wed,  8 May 2024 14:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715179740; cv=none; b=EndOaA0of0CgnqKpYlhJJgDTjgHYgmwfR+zWuzSj6VUFnkyH4DXh/4g8JeXlepn4ua+0OQK06SwMZdwAbiD5WHtUZ9YG3YjQiqHnzAWgiN3idGUA9VCMSvDGLDBTvVoassTldXcYZcjEnoj1wdt9uDuYa6bw4iQwedYFj9wKqfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715179740; c=relaxed/simple;
	bh=H42Qpj0LHlPj6U0riQeWmuHCvFK8YLrtgrADOSDhXY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QBVxuQl0atTLE7cLBkDPGOOobyZ03Qfl02gb+HlWbu0rj33Y7uvzPXBh4fJLkefX/1b53Id15/nF2Viu0WzJj3g7wDl+O3v440LU40ZCJB+XiUiJfZ+MEBYn2p5LAtCZpkdimc+w995/4v7sX0SbhKG231kp2LgLSHNT04buqL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=OF//Msdw; arc=none smtp.client-ip=212.227.126.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1715179736; x=1715784536; i=christian@heusel.eu;
	bh=H42Qpj0LHlPj6U0riQeWmuHCvFK8YLrtgrADOSDhXY8=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=OF//MsdwkURxs/LS8RJ1gb1bMgWjN9UM2KZOXMDAwrxEwMiApVANsr8fEZmIse1X
	 q1QFml+eSv3jPX37ciUuRPaM5O4gf8SedOjB+xyst+K6+VeSkROTmOpm/4fyUwmkN
	 xRUeNrBilWxmKAnuLjEri17sKxH1aQr7AOj6KwwDLdjK2Ei05W7h2J0XEeBIU8jXE
	 m6+VxugUZhauEzRmFD6BumDfKlQVdxTJiZGQE6zYaFP5YIVdQ3/g8+o89RoYJDvfd
	 oeJzC1OH4o47cjTNJ9YPdZn74TRgJzaExHpltpgOTJxmEPwcQF2EPtqhOWjb03ztA
	 94T2X6ccq8libT4UBQ==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([141.70.80.5]) by mrelayeu.kundenserver.de (mreue010
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1N0WsG-1ssA1q0wrM-00wYuD; Wed, 08
 May 2024 16:23:58 +0200
Date: Wed, 8 May 2024 16:23:57 +0200
From: Christian Heusel <christian@heusel.eu>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: regressions@lists.linux.dev, Alex Deucher <alexander.deucher@amd.com>, 
	stable@vger.kernel.org, Mario Limonciello <mario.limonciello@amd.com>, 
	heftig@archlinux.org
Subject: Re: [bisected]: Games crash with 6.9rc-5+/6.8.9+/6.6.30+
Message-ID: <sglmco4glinkpskjfdvvb2jvlywz5jggdlxspfsjza5qyr57jm@vfk2l4zq7yrl>
References: <gifkxwcrswqevdig33inrsieahso2lcxbhcawu6d2qprnujoij@eqg53vwjamts>
 <8e7ed389-c894-418f-a8ec-1ccfb13e2126@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="uvaoibqorowknm64"
Content-Disposition: inline
In-Reply-To: <8e7ed389-c894-418f-a8ec-1ccfb13e2126@amd.com>
X-Provags-ID: V03:K1:pO8KHU2wTOUtVOtKpVJ+DNGlhnz2Z3sa4TH6i2Yg7TkgB+bPlGA
 TL0PAO9+M1i3UiovROLCkNs5Zo/UAn5pFzWuzVSJjHwRRd22Y2ymE5QA5ALEzAqVfwh/Spe
 QbujSRGNv1v4WjmUBXqd95ZjnW5uTcqSnSOcvM14OSLBcgEAjXk79VtLMlpOGUbdV/+2/y3
 7C8ErJMs5qP+a3/bCI4jg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+XEHyLzEpn4=;p5UzbLPKnimyhfWoAHiLEoWJOoY
 f2YLGaUv6yeVNFbqS/YeHi8uoIBpiRKrKhuHo0m1IiHZs4PjAjvWrm6o1Euo+6OOxa85mR1yW
 cAJTdTdNVw+Bed04UaXu1aCvHej/NVo6xNxjvRmT48pZ7VWB065mVKwsSDu/uVFN6lCo3cuAT
 SRCyJTyLkDHXiQDcVBxHopkScB4f1E8q3h+hxxAXxrEdayBARiiiEq+mwHV+Iu+PocGVIKpk2
 LapLXHImo3AMRg7NwsMuTXdz68B6eVCynf0g3ge5a0W/SZ8gTMT83LPfS8Ax68dCW7ybDlZHA
 jF9AXNiOMQaT/d3+YnH6KyGkSpXefOZravbm04FPPbXow6ADVSYc0imUMCokVUdZrGcmnIICo
 rr2TQSjaIYwTQPHaVb+eCPafP7eIqDjZo2v++lXAL6Yt+gIL4EyPlaUhWPm02yc8pikzJfDoq
 R2rNXzvJU2q3Jr+0bOtFTuHBJc2jbhsbLZICpwVbzSSbG/RYIoBR+KshTlxrSVO2yCAQZBTYr
 9bCRuEuhq0EyvTIxErsVUZs100ASETr0sD09lWv6QhB+zWyYLpJbF3brFV4Y03y9zNS9FP9K2
 YyYjaLYkkyspsdKVn5RTPCRWmLwdalcK14vEZjquYZfu6SGA2A1DP9uoPrs9sUoTbBP2WpPv0
 D1JhbD/MS3BM4wZr4sqISTeGDuvvITHVrPGugluAL7heHKh5r5awK0Ya4FnHPzkP4ELsL+z7/
 e+uVo4H3XrfEH+C0Q+A22JbkvCi5rCv5nCX/0S2htQw0eeOegmFSZQ=


--uvaoibqorowknm64
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 24/05/08 01:01PM, Christian K=F6nig wrote:
> Hi Christian,

Hey Christian,

> most likely Michel just pointed out the right solution.
>=20
> There is an off by one in the bug fix, which might cause the issue.
> We are still testing, but so far it looks good.

I have applied both patches and one of the reporting users says the
problem is fixed for them:
https://gitlab.archlinux.org/archlinux/packaging/packages/linux/-/issues/47=
#note_183991

> Regards,
> Christian.

Cheers,
Christian

--uvaoibqorowknm64
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb3ea3iR6a4oPcswTwEfU8yi1JYUFAmY7iv0ACgkQwEfU8yi1
JYXHPRAA1XxfBB+8He4hmYg5QnC6lT2LhPNmTNvxK190LPKxi5cWeSejioWn39fN
uIQ+IkfeKRsVLzWIlve3i0TLkf+P3Xw314G/Byz+i5NxZ33noSTIjDbbE3p2j5U6
HaCvEl/X1eyuOlPnbzEF3Nio9YW5bI1MRr/OU8l9gF5n+OvE7y/6opIombh+J/N/
gVM9dntG63m1V2yJUyLJKoUhS+5375QTvNM0OKpyzSYPasX4gZv/SfLzSgGJrWFj
2cD3b86Ay3G64vgo9u0fuMxhmCn0jl4QVpE9odcWYNzqmZ1XiPAI3824/aVb6bA2
5EhODfTRpbF9M+IruK7o5eVnSaXkT+LsEn2cAP6+SSyFKnbZf1qj3taxFZ06Rx7u
R8yHclhE4iyZnaG0eKgv8vGQ3K3RgA6Rvd/tJ/+oWTggfQTQa2jo8WoGRAbqrtJi
7D9cwgk3qOrX6h2O6K05OAxefZnRonk8L1dgw/jAnnEO13HWam4hybYFb+VqhnTk
AbbrmdTgYyEz0Otv88U/fbhyRdCqSE9vJk4mfCeWQzx3faxW4JUs7oEiVbL60tDd
FlTqH6tpOF2CB9yJQQUWsEzYAOHWarDG1Kk4RXpAOeTK5/SjxqMugJDsy2dtlAMB
Oaqph32lFRzi8tlIV3AC0g+XxP8EG8kjAcTGBaAFYYVETS4J71M=
=BNBv
-----END PGP SIGNATURE-----

--uvaoibqorowknm64--

