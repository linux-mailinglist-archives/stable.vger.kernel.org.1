Return-Path: <stable+bounces-144338-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E010AB655B
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 10:11:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE37A3A95FC
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 08:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4BE21A928;
	Wed, 14 May 2025 08:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="R/rn48uZ"
X-Original-To: stable@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5078820B81D
	for <stable@vger.kernel.org>; Wed, 14 May 2025 08:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747210282; cv=none; b=jQ3hX41xaHrQK62mOlrLT5wjE47Ogmoq1ncMyHefTUIZsXz+Zt2zT011wx98+sYybHmzDU+03P11pJUgZff2/nC8rSo5hbpY/nx0N45K+cxeSHg7sTRxaMRqRBjeRvmc8KSfTlLKbQ14sWztjzOtiNucIc24pqljqanwJVyQ+0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747210282; c=relaxed/simple;
	bh=lvKzWkNi9IKthvlDXe7w7jJgNJeImv/Xjjj2vPRnDLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T6AKTycxlgQ7oWUi/0j8FdSbNN8VS78rjLVX8jQrZjCgOuO/4iXuPr3RscaZIrEAWPyK5Jvgs05LFdPz5rRvinLjcQHzo/uARKFMDNuWjG/XcSQAg5OIP2lolLFIxbBKpZu7Ry8UfOmicrk3nhjuapzNO4lG2tXKIMUHHrkxkEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=R/rn48uZ; arc=none smtp.client-ip=212.227.17.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1747210262; x=1747815062; i=christian@heusel.eu;
	bh=yp19kCTXAzlQPM0VTZ+xoHXpUu2B4qVH44q0U8wInjk=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=R/rn48uZZzDI9SEi3EFbEzkQuXl1xSxXM825o5h/ORMXCYLQ6fqF+Z2g1zZlyW5e
	 f8y4Fnr6EB7+jU7iL4lO/3zq9cNIcGvEThyQTIny+Jhyu9o/FPpuu5Ltr7ZwryhU8
	 OP1uYNOpIhK8+4uC/3/V0g5+otP+QO8OyIBhIN0d165FuRM9RwtjVtt3FX5NMqmih
	 EVHttBa+lksz41IgOAzVmV1Hg+hkBIZqqLodhzvyq07v3QNm6N4rbUWzjbsenuko6
	 5epS2hW+hM3belqAdlq1Ppigpq1DSI0frZfE9tu8hegiCdVG54WdBDGkuoSZUSy0k
	 G+k66nDmKgwuLGTrxQ==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([129.206.223.183]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MTiLj-1uPGm30G4r-00Ytic; Wed, 14 May 2025 10:11:02 +0200
Date: Wed, 14 May 2025 10:11:00 +0200
From: Christian Heusel <christian@heusel.eu>
To: Wayne Lin <Wayne.Lin@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Harry Wentland <harry.wentland@amd.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, Alex Deucher <alexander.deucher@amd.com>, stable@vger.kernel.org
Subject: Re: [PATCH] drm/amd/display: Avoid flooding unnecessary info messages
Message-ID: <90f81e59-1f85-4c2a-9d6e-879898f83fa8@heusel.eu>
References: <20250513032026.838036-1-Wayne.Lin@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5jbs3dkqzer36ufa"
Content-Disposition: inline
In-Reply-To: <20250513032026.838036-1-Wayne.Lin@amd.com>
X-Provags-ID: V03:K1:BmqfP4SKpP6Umy+E17qUujc5PYF8npHNNs8NIAE+FvHJhDNihjl
 XNhapen9poo0Yb5ZttPs6i3vwNg7GqLL3+DJwUQOZ+KOH+x7ehXV1RbshQp/bLvKJISd3lg
 j5/iUO2WbY3WZbUkjpDf2uf+LeUxjW9BWF3IV7qEuUBOqwmvPwA2/Jt0dOdubMkC93r3gXn
 Wwns+MjrnWIkwa+cbXJ0Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:pLbrL3GubYg=;sPGkEBhMgh5oDi8gekQJaF+yoWt
 1Z8e2ymQx6hGC/sEJP2X1oENsq99qr3bG4lrp/Ja+gkgT0sjJiMFGEbtpjximBugN++5/aBPP
 VWgaXXZknw55rfIizYcJOsT+DgbfjVV9p3xlghHLfECyF7JMttyu47BJah2JMpsoCA0fLYqfb
 h+mtWT8Si+pep008GDM5qx2/vOceC8UjzXIPh7AjN+caxowfHDlsmeomRNpWE7T4TL6y3/OLN
 Q+SR6CU5J+HDVGmkxeC8D8HqsD4Wl2GfYMDE/QVvbpqCbXcLdjhE+9qbp/xyHucYntnyFBbuX
 NAk35FHCC/FjRvf29s319dLthf8pzn5g1FQOv0A5YXL9AIPkN+S4OUy98Jd+V0Cf+PHs3GlyM
 FG+HZwwNXxSQ/BDqfGapWl22cKAk2nf9N/YP98CQww0RqINb6lbtk3zoy7mou/V2qRc9Tg6wB
 ewv3uA/0oCT7dDeeW9cLvv59ghpHXqP3KJOhyayGVDvzOg0eOS0hqjMot+4zzktl9Qr+hGbhW
 IWwOSpjUTp0ssdkvaDydmfqVoyilgJ/OqFflF5XXlXIchWdWIIRVDZQbavptDapCETj/x62Ao
 mbKtd5s4yyYBq4GrYW4dhXNviPMuSV++VWQ8PdHvPH6M4e/+osVskSCjA1gThC1+2B7hBZgEY
 XVavkQxUeq2g8xfN2zLa2PQhXcGYjLRCQwg4IErxwGbLORkcPkPycT3zVoB7Zt6xuqyVtEpO2
 9WjgrYKabZbHN5IHgYtfNoWfLy1a9vg24APyj3MOyDUXOEEFMfJ1XSd9deqK0yxXVMvDWCyTW
 o6TiYip+bT75WqY/wzQuxRFZIYIvRk5fdgxF6/HCYGv2nr0sEBtpYQA0HxqVYjjaJ14RjCDja
 2Oit2mvDEG03oVp6FvrJuV0TCuaBYxfvb9PXNsnBTR7LXTHly+OchXqoNrgI3XMyLSklEpWET
 xJoRiaUN7YgEWWyQ/oycQHEFKSVpYVt7x4tmH5aFFxb7oFEsJvhU7jNbawwj6jUgQ0v1KfeFf
 r8KEy6Sju/44aWCWKk4JTj4yRHDoj7euBUbkn3pD9mdqRHzJ/0a7yYEctzs9hl/EKyCgQXqIZ
 4mU5mCou0k0Kd9nXaFmfZyYi0LemNekShJ14BoFqTAiiMv0QyUSmSv+8BUgTNoG+KrHCs97Bz
 0IIzOkgJb9RwPlhaqgOZIC+fo70W9LKn4RdLGiMzRXA65PZYZ1MdMO1N1rXIku0IIRuaSrIGw
 nSPy8G+lC2vj/tS2UEJdXr8PwA5vnCifSKQhjp1GtQSyQUp8gKrfBacFs8MYCT5ReS59izpfL
 1V4J1Sao+Fg6eJzgyqhMVsBPz54laUgViW1vWtGYk/8PC2zNar9GLvL6Kpf6J8pGXfL/FKCq/
 qqzBQaPv61uVWK/WbQOJX2BY/4wYLbbZZc/yHm6hKjGFS019wLYA7haSE0


--5jbs3dkqzer36ufa
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] drm/amd/display: Avoid flooding unnecessary info messages
MIME-Version: 1.0

On 25/05/13 11:20AM, Wayne Lin wrote:
> It's expected that we'll encounter temporary exceptions
> during aux transactions. Adjust logging from drm_info to
> drm_dbg_dp to prevent flooding with unnecessary log messages.
>=20
> Fixes: 6285f12bc54c ("drm/amd/display: Fix wrong handling for AUX_DEFER c=
ase")
> Cc: stable@vger.kernel.org
> Cc: Mario Limonciello <mario.limonciello@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

If it's not already applied it would of course be nice if credit for my
report could be added to the change:

Reported-by: Christian Heusel <christian@heusel.eu>
Link: https://lore.kernel.org/all/32c592ea-0afd-4753-a81d-73021b8e193c@heus=
el.eu/

Have a nice day everyone!
Chris

--5jbs3dkqzer36ufa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb3ea3iR6a4oPcswTwEfU8yi1JYUFAmgkUBQACgkQwEfU8yi1
JYU6SA/9GeRVNamI6JTz/D6bxRsFu94z5RLpIctlu5hzQ9xLgbE5eQeAysRme9DX
k3Q2wDY/aO9nNKDFQkeZHmFX7nUZh/dgA5nKiOkYoF335WjpZEsZ6W90KF8PJtaS
DuKdf+bocyc7pzgp+Hd0oIJxD7ZF35FCX7u3p8m+MD6PoTNSdhfcK5iZ9oAMEfD8
ypmrU2fnLcDfsArm4nHa8AqcfEoUZ64XQxcRv1gn8srr1Sx2XrU7JC+SiEbTEeeI
kchaJipEwvWVplQ0sLbs3RxEYTms7dtJUIvHiwuGf9ey0xXRK9SRYQPrAxB8WvBc
VSTgNgvrn0WQmY2/7cxaMsZPmbH0FxQygJ3ERQDSgPJa9e77iSmD5LJ6W851mYbg
JGkjBICBepDVt5RKpirnYoJiPCOqgPHhgnHMbBOriDHO8HIg/Uvdlj6bcSDzeJ+h
tMxZcHUS6HJrSBDAyqV3WU1vWhwiCTb5Hn9U8KHrrk3BZl5BQoPdOolWtASL02FS
70jjKa5qt79ki6fHoij43RhXgqIcYze+qW1qxQijS2yxx1eKzvcT3LvHzqIzAJE6
ssMxX8OM7jPIi4HuG0/ban1xQQmsLLph1GVaXmkK7L5qzqbuHTycfj4s5aZ61kIq
seb/DUYf2a1rt0Syp4xR7eASIQH7QEkevRKjbWPzKx9u7UdTGHM=
=Bfpm
-----END PGP SIGNATURE-----

--5jbs3dkqzer36ufa--

