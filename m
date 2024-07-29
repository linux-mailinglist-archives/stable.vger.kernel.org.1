Return-Path: <stable+bounces-62421-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E54C93F08D
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 11:01:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCC31B21124
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 09:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB0813A869;
	Mon, 29 Jul 2024 09:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="zGYOajJ0"
X-Original-To: stable@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0462D7E782;
	Mon, 29 Jul 2024 09:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722243694; cv=none; b=ApPmt3BP8mGowDyOJ+pqOVAnectglRkgDVySQwnjZ0lOQuJhfYhs9+MMYww8/NcUo5OeFW7TeazJFjvbvuszGC/gJRLpR3S/Q5SbKiEJMdptPgaDl441yL1xt5Yk2sX9FC3XFYaN2LkTorda5gd918ns4uMZX0qoP3cHaPFVHa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722243694; c=relaxed/simple;
	bh=N+NwBbz+/aJSBJUMWMagSHJ6kZuiXC8iiLcDvJJtxAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LLPYoJlmj6BS4NcImvSM67xxcxpjfbN/8WD4CS00IAwLVu3OpZTbAMbw+Rrt81e+ynEKAl/WL9y9Fy02vfhn0pMJQHhnJJSgcvDSt7kRuNU+8Apqb+hQNuG7Q/5B7EROQec7G26C/Yc55Ad9x+wmL3XMmmHV/Ssrs1dEJ4nj09A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=zGYOajJ0; arc=none smtp.client-ip=212.227.126.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1722243684; x=1722848484; i=christian@heusel.eu;
	bh=N+NwBbz+/aJSBJUMWMagSHJ6kZuiXC8iiLcDvJJtxAM=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=zGYOajJ03DwVcnKOxN1bGVpI3JtnErUyrQNPoNGG8hKJ6Us3ddPW5Jr4DssgCnF8
	 bP+DcwgFSTEsGMjfa55acrh2l19OcvuKJbkUZt0AfZtTO9cHM01HVgA2F9fuQXRt3
	 CRxEyCYjTGNe3ZZNspZeGzHcCVOWNDS7/cmDUI1j8qK0p1UiItqpyPxMZJJxF9LiB
	 cQ/uOb6eVRCe5B4792P6P/wCi4VQJyepm3ZtQ+BFEMddKSgDG9XsyMrsqg4si+d4a
	 Se7agM2gVJOnqf6L/6NteYI0NB/ByNbIjJ+jkz2WPKJ5jD6r7X7eek4EXqV0nH/Wt
	 38b+T4c9DLvaz47/og==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([141.70.80.5]) by mrelayeu.kundenserver.de (mreue012
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MVJZv-1sfBg84Bkt-00Ukrx; Mon, 29
 Jul 2024 10:48:00 +0200
Date: Mon, 29 Jul 2024 10:47:58 +0200
From: Christian Heusel <christian@heusel.eu>
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: Greg KH <gregkh@linuxfoundation.org>, "Lin, Wayne" <Wayne.Lin@amd.com>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	ML dri-devel <dri-devel@lists.freedesktop.org>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
	"Wu, Hersen" <hersenxs.wu@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, 
	"kevin@holm.dev" <kevin@holm.dev>
Subject: Re: [REGRESSION] No image on 4k display port displays connected
 through usb-c dock in kernel 6.10
Message-ID: <b7f0f3e1-522b-4763-be31-dcee1948f7b3@heusel.eu>
References: <d74a7768e957e6ce88c27a5bece0c64dff132e24@holm.dev>
 <9ca719e4-2790-4804-b2cb-4812899adfe8@leemhuis.info>
 <fd8ece71459cd79f669efcfd25e4ce38b80d4164@holm.dev>
 <CO6PR12MB54897CE472F9271B25883DF6FCB72@CO6PR12MB5489.namprd12.prod.outlook.com>
 <e2050c2e-582f-4c6c-bf5f-54c5abd375cb@leemhuis.info>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="n63a2yfaefc6qmdi"
Content-Disposition: inline
In-Reply-To: <e2050c2e-582f-4c6c-bf5f-54c5abd375cb@leemhuis.info>
X-Provags-ID: V03:K1:VUQmBHNbUxSuivJa3UWDZUqROOuD+vc3R6CCCrrh1OCODtgXJZY
 whBiOcObwswdViHJ7YQFJWyEGkXfr5cc17ziisLlaAyGJQtzW9LNeUIG1daJeIbnckfphJr
 kIfm1yEZmZtTsw+BEw6S2QdqYF3E0UzgvrM6rkWWVIL3M3rsVmwO6MxdO1CKyRkQkRKwRik
 u5VMTw6Z6RC7sZmXJ+NcQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+4I8fJmNOAo=;6USdeDx0VA9MfugZc889578EMYq
 VLc8LHLmB5hVVq/x8HSEEwKZkLM0+V95CXkZJ7c7Qe5naqciCpkaNpxFQFxxL9jfT03mq3Z7e
 qsQG3k75CdPV9MStJTPp1U3uc2HcQJz42BqzW0IBVtF0USO+HQ4GJE3wqDi9mqUpN0TnZHjgM
 eh4MarDo5i7yFwFzZ9/KY8eKy0r6HjtjZmdgDBaaYGBcxNdQ0SQQgBve8LGIT927QetoCVc58
 +kWc1r95yWkTqXayt0Rbmx8kF03w61AbuCAVGIdar7IghOQ/vPtexmMmv+O0W3/tKe4x1V1QE
 alUTZP/gUQ2c+8cRUcE8VP7CM8Up7V1JuCixC3H0SR/QM+/GeKedFKhagX/ODbrqtkM5tqeO+
 to23Zssmp03tvKoAIZGsVlukqxWFZSUWzFQLBcsC9LK7b901K+M+Q3mA3XLM5dRKtmIncQzzi
 L2lijFTHhGD5XamGxJpgFit0Zac/xp7rlemZpxhr/1fS47QELrX1rzI37HPMSd4Aay3KF+9er
 dJc94n1LWlSez+8VCj1Mx5LFIJML03GfOkUZJ/kNob/MRq3O0sDb3Z4jnavJu6BIHJyHgbwqD
 lpuLJCOKiSOpgZRF4Jvziq5cVSa5VEnmdhOyhWTP9RyRx08kgEDK5PsG9ysUUuZ3vzLHz8G9w
 vnXxGeM60ZV8mlL8ot2eSHsh5jEiyaxeYaOFvuAgpf87Q/wlJgwIKhcdN8A59OryaodPbDIv6
 i0dgEJI4td8SSs2/9e/OpA3B8V+z4BumA==


--n63a2yfaefc6qmdi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 24/07/29 10:35AM, Linux regression tracking (Thorsten Leemhuis) wrote:
> [+Greg +stable]
>=20
> On 29.07.24 10:16, Lin, Wayne wrote:
> >
> > Thanks for the report.
> >=20
> > Patch fa57924c76d995 ("drm/amd/display: Refactor function dm_dp_mst_is_=
port_support_mode()")
> > is kind of correcting problems causing by commit:
> > 4df96ba6676034 ("drm/amd/display: Add timing pixel encoding for mst mod=
e validation")
> >=20
> > Sorry if it misses fixes tag and would suggest to backport to fix it. T=
hanks!
>=20
> Greg, seem it would be wise to pick up fa57924c76d995 for 6.10.y as
> well, despite a lack of Fixes or stable tags.
>=20
> Ciao, Thorsten

The issue is that the fixing commit does not apply to the 6.10 series
without conflict and the offending commit does not revert cleanly
aswell.

Cheers,
Chris

--n63a2yfaefc6qmdi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb3ea3iR6a4oPcswTwEfU8yi1JYUFAmanVz4ACgkQwEfU8yi1
JYUDMQ//Y8/U38qoRUI7sbmJIBjtkpE62b//dAJYdlSyjbvLe2/qOs+pp0oXFn4D
bkw39ja845pauQ0ISjSOm3lJkxLxsHHhU4Ea9z1ww1wrONnPTPImpf3v7bKPnVJu
pHS6fYP61Wfpktv+lXbsscprlWyvejjRwlwSJT8NXKdPtIn7qXK/hQkmYZQg7CwO
GGjBMAOG/ocpLk9UGkmCN8ncArXDpzP+jIJMl0LE6TNtiBl6V6rtFsqEm2dVCqtJ
pLE4FT/t3/FfAaRMn2U1HyLTsxYy/FIYtQr5eogDcShmkKL2k9mHfTJuKxKhvYWU
z1qfWD0T1pxGnl+EnKUmnuX+ypACWYpGRLWdoIWJLke9aKCjpF559xEArom3djfb
KK3yOm9EjxXQYqZuroLCYn8IA+OlWuIZX8wo2g/6/WsVnxM5pb6QeuZMNAs9Il/8
UxaOxBNMx5eyGqNEvlBaG3re/wsfwKucjA3fqnjVqoc31527EpNcH/3edRtwdARd
ApvEueEJXC//c+liEQFhXwc+p+yGAWpf0jAagpd5Z3XdvQkcMOEFrejsOLuZb7/Z
nnEluHAheR+CrUAQEefHWjjjcrNx8/yFKmLj7yTeV7T9VwKkbTEW7mJFgFp56fFf
MlSoriJ2BgHDaHW7gRUisq0D+CopuNS3nQUBGc4unCALCCLlIGI=
=jOkp
-----END PGP SIGNATURE-----

--n63a2yfaefc6qmdi--

