Return-Path: <stable+bounces-94675-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 340189D6815
	for <lists+stable@lfdr.de>; Sat, 23 Nov 2024 08:39:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF8AA282F64
	for <lists+stable@lfdr.de>; Sat, 23 Nov 2024 07:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85D515CD78;
	Sat, 23 Nov 2024 07:39:13 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from manchmal.in-ulm.de (manchmal.in-ulm.de [217.10.9.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4024D29405
	for <stable@vger.kernel.org>; Sat, 23 Nov 2024 07:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.9.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732347553; cv=none; b=ZKa6MxxEYy44/LTF65YM1sNkSe80UIfC5nUbLpbRQdUKTJk2+XztrzkLm0SAU4AAT/gC70B/T5Hlb5tJfNXEsJQEV5OoE+ZCW3tO+dl1sh3HS61+MlBrRsO3Xr1RlILkquVWqW1jyAqSc3Hv8m2d8SGbZVAtMOjwut5Gwjh6WUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732347553; c=relaxed/simple;
	bh=dEjdMJImIgCAVD3pxTfPQLqmpTV1lamIMRJmNDkAA2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=smU0kEMx6ybwyO5VKbbHMhsPnsc/UU3tu7KUih4VxLET36F5OzHwGQrHoQOFKld/zEpFWiQiuPbalXd/xGiwrKQgOstl4Vc7oB1qas0q/j81nWM7ZHYuSsDCrfJUzQJj6Zcj5xRFYuRmDdrGOnljxbypPsT7R1k/6uU6QaDRuSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=manchmal.in-ulm.de; spf=pass smtp.mailfrom=manchmal.in-ulm.de; arc=none smtp.client-ip=217.10.9.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=manchmal.in-ulm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manchmal.in-ulm.de
Date: Sat, 23 Nov 2024 08:32:40 +0100
From: Christoph Biedl <linux-kernel.bfrz@manchmal.in-ulm.de>
To: the Hide <thehideat23@gmail.com>
Cc: stable@vger.kernel.org
Subject: Re:
Message-ID: <1732346861@msgid.manchmal.in-ulm.de>
References: <8db6485d-0062-4155-a623-f44b3f4c079f@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2QlCYD1iD6nwmjI2"
Content-Disposition: inline
In-Reply-To: <8db6485d-0062-4155-a623-f44b3f4c079f@gmail.com>


--2QlCYD1iD6nwmjI2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

the Hide wrote...

> Who should I contact regarding the following error
>=20
>=20
> E: Malformed entry 5 in list file
> /etc/apt/sources.list.d/additional-repositories.list (Component)
> E: The list of sources could not be read.
> E: _cache->open() failed, please report.


Assuming you're using Debian and not some derivatve: Some Debian users
mailing list, like <https://lists.debian.org/debian-user/>

=46rom the above error message I assume there's a format error in
/etc/apt/sources.list.d/additional-repositories.list - so it was wise to
include the content of that file in a message to that list.

If it's actually a bug in apt, the Debian bug tracker was the place to
go. This list here however is about development of the Linux kernel, the
stable releases, so not quite the right place.

    Christoph

--2QlCYD1iD6nwmjI2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEWXMI+726A12MfJXdxCxY61kUkv0FAmdBhRQACgkQxCxY61kU
kv3n+hAAuMmZwsYeaOR+dKeOmfO8SxUa6T+pRLLWGcXsW0AyYUAAcOkI0yeDE9Qo
i6KB/XV4FfEd1r2BnBbmKUQcmQcQsPqh2gGAHy2IrBgpPNjzlO3IXjLyj7avHY77
pY+5/iWQEU8zvQ0rzm/N6qgGLZoK347A3cLfQV0482rs7/g6vWkmr1vtaqJw1x0f
B5q/3Ff4aBQ5avuIEQPC0DgcHNh1RemC67w6VrmBYP0jGPtI3BodJGZbEqSzpTgI
JQR6y6adOHBuf2gs70xU+rxZSaPmW627LnD8Lmfc9klLVQtHCwSqhk3y8xgKJs1f
BZ0RAtBBziqLMjvCWshRWWG4MW2Ar7aX0x+iN8vbAzIHALRyV3Zryni3PItMMkyw
i90B6q3h2pNvR43yF7rvJAY7um31WGpnWy06UNg0wMomx9VBeWSulhfqK//W08FE
m8U4Ua1rmJtz6wi6F9hQAn4X5ZeI+rNaPH+lMDw+9vFbzR2GKe7NTi2DY/yPo98m
JweWypbGaW+yWYEwoI0sLgUjTulu1qRWVtyEdQyUyxEDCuJaoFL4ufm7SQVqsvug
0z5Koy+AEeDAThwBmp/+fjTUqtjD8Ac7oFNtN5G+wXs582q34CyTEgfS0R4xQIAi
7F/TNjfd0GSU/D6HLp3/T6rN5TT2LULvW3QgtS3Eoaxy//ncAC8=
=E66f
-----END PGP SIGNATURE-----

--2QlCYD1iD6nwmjI2--

