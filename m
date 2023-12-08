Return-Path: <stable+bounces-5003-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F174680A16F
	for <lists+stable@lfdr.de>; Fri,  8 Dec 2023 11:49:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A99C428195C
	for <lists+stable@lfdr.de>; Fri,  8 Dec 2023 10:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E23012B70;
	Fri,  8 Dec 2023 10:48:57 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3665F123
	for <stable@vger.kernel.org>; Fri,  8 Dec 2023 02:48:53 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rBYPQ-0000jE-Pf; Fri, 08 Dec 2023 11:48:40 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rBYPP-00EOcf-33; Fri, 08 Dec 2023 11:48:39 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rBYPO-00GMK1-Q1; Fri, 08 Dec 2023 11:48:38 +0100
Date: Fri, 8 Dec 2023 11:48:38 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Sasha Levin <sashal@kernel.org>
Cc: stable-commits@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Mark Brown <broonie@kernel.org>, NXP Linux Team <linux-imx@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, stable@vger.kernel.org
Subject: Re: Patch "spi: imx: add a device specific prepare_message callback"
 has been added to the 4.19-stable tree
Message-ID: <20231208104838.xqtiuezd72nzufd4@pengutronix.de>
References: <20231208100833.2847199-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bwbhjsactzvyazwg"
Content-Disposition: inline
In-Reply-To: <20231208100833.2847199-1-sashal@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: stable@vger.kernel.org


--bwbhjsactzvyazwg
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, Dec 08, 2023 at 05:08:32AM -0500, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
>=20
>     spi: imx: add a device specific prepare_message callback
>=20
> to the 4.19-stable tree which can be found at:
>     http://www.kernel.org/git/?p=3Dlinux/kernel/git/stable/stable-queue.g=
it;a=3Dsummary
>=20
> The filename of the patch is:
>      spi-imx-add-a-device-specific-prepare_message-callba.patch
> and it can be found in the queue-4.19 subdirectory.
>=20
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
>=20
>=20
>=20
> commit b19a3770ce84da3c16acc7142e754cd8ff80ad3d
> Author: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Date:   Fri Nov 30 07:47:05 2018 +0100
>=20
>     spi: imx: add a device specific prepare_message callback
>    =20
>     [ Upstream commit e697271c4e2987b333148e16a2eb8b5b924fd40a ]
>    =20
>     This is just preparatory work which allows to move some initialisation
>     that currently is done in the per transfer hook .config to an earlier
>     point in time in the next few patches. There is no change in behaviour
>     introduced by this patch.
>    =20
>     Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
>     Signed-off-by: Mark Brown <broonie@kernel.org>
>     Signed-off-by: Sasha Levin <sashal@kernel.org>

The patch alone shouldn't be needed for stable and there is no
indication that it's a dependency for another patch. Is this an
oversight?

Other than that: IMHO the subject for this type of report could be improved=
=2E Currently it's:

	Subject: Patch "spi: imx: add a device specific prepare_message callback" =
has been added to the 4.19-stable tree

The most important part of it is "4.19-stable", but that only appears
after character column 90 and so my MUA doesn't show it unless the
window is wider than my default setting. Maybe make this:

	Subject: for-stable-4.19: "spi: imx: add a device specific prepare_message=
 callback"

?

Another thing I wonder about is: The mail contains

	If you, or anyone else, feels it should not be added to the
	stable tree, please let <stable@vger.kernel.org> know about it.

but it wasn't sent to stable@vger.kernel.org.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--bwbhjsactzvyazwg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmVy9IUACgkQj4D7WH0S
/k7Nlgf/cnY8Mj0dtygcC8EuFigWXfVCghxO8JG3qhsm4jE1iOyiM8bFWQ49+ITR
bB9Zrx5zoks7oC+/5Om3gQS7VpyTAHNleIqhPGoi5aOCbTPrBAy1/6KCdZw1VJYT
/Ox39luxOGliIb4ZoRJuXYcUE6d/xER8RiQ/XQpHpaWa/wn16ya+YTtFBuBNlPXQ
2+JPX4AUjgOyG3aCqq13yQqsrQ1EkEVem7AvRrgmnNxYdFLM1F31wzrk8gN5X81D
Axwk/Z+gXM8C6+ALEVjt7xDVWwe4pPBpRV8m+19U6akSWxHuJcnQmx+v7tDQTiHl
Tww/ny5TtkpHefcF6v1mKZM+MGJmvQ==
=gQhS
-----END PGP SIGNATURE-----

--bwbhjsactzvyazwg--

