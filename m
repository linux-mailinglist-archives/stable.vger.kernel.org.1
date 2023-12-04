Return-Path: <stable+bounces-3904-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA9F3803BDD
	for <lists+stable@lfdr.de>; Mon,  4 Dec 2023 18:42:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76045281091
	for <lists+stable@lfdr.de>; Mon,  4 Dec 2023 17:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 578342E84B;
	Mon,  4 Dec 2023 17:42:10 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 724F9DF
	for <stable@vger.kernel.org>; Mon,  4 Dec 2023 09:42:06 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rACxI-0007A1-TU; Mon, 04 Dec 2023 18:42:04 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rACxF-00DZHx-E5; Mon, 04 Dec 2023 18:42:01 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rACxF-00ECAC-4n; Mon, 04 Dec 2023 18:42:01 +0100
Date: Mon, 4 Dec 2023 18:42:00 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Saravana Kannan <saravanak@google.com>,
	stable <stable@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Yang Yingliang <yangyingliang@huawei.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	James Clark <james.clark@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>, kernel@pengutronix.de
Subject: Re: [PATCH 5.15.y] driver core: Release all resources during unbind
 before updating device links
Message-ID: <20231204174200.6gl3fqgg7adzqdgq@pengutronix.de>
References: <2023112330-squealer-strife-0ecc@gregkh>
 <20231123132835.486026-1-u.kleine-koenig@pengutronix.de>
 <2023112401-willing-drove-581c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="y5trw4asru3mx4v7"
Content-Disposition: inline
In-Reply-To: <2023112401-willing-drove-581c@gregkh>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: stable@vger.kernel.org


--y5trw4asru3mx4v7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Greg,

On Fri, Nov 24, 2023 at 04:44:08PM +0000, Greg Kroah-Hartman wrote:
> On Thu, Nov 23, 2023 at 02:28:36PM +0100, Uwe Kleine-K=F6nig wrote:
> > From: Saravana Kannan <saravanak@google.com>
> >=20
> > [ Upstream commit 2e84dc37920012b458e9458b19fc4ed33f81bc74 ]
> >=20
> > This commit fixes a bug in commit 9ed9895370ae ("driver core: Functional
> > dependencies tracking support") where the device link status was
> > incorrectly updated in the driver unbind path before all the device's
> > resources were released.
> >=20
> > Fixes: 9ed9895370ae ("driver core: Functional dependencies tracking sup=
port")
> > Cc: stable <stable@kernel.org>
> > Reported-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > Closes: https://lore.kernel.org/all/20231014161721.f4iqyroddkcyoefo@pen=
gutronix.de/
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > Cc: Thierry Reding <thierry.reding@gmail.com>
> > Cc: Yang Yingliang <yangyingliang@huawei.com>
> > Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Cc: Mark Brown <broonie@kernel.org>
> > Cc: Matti Vaittinen <mazziesaccount@gmail.com>
> > Cc: James Clark <james.clark@arm.com>
> > Acked-by: "Rafael J. Wysocki" <rafael@kernel.org>
> > Tested-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > Link: https://lore.kernel.org/r/20231018013851.3303928-1-saravanak@goog=
le.com
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > [...]
>=20
> Thanks, I've queued this up now.

I see it landed in v5.15.140 (as
947c9e12ddd6866603fd60000c0cca8981687dd3), but not in v5.10.x and the
older stables. It should go there, too.

947c9e12ddd6866603fd60000c0cca8981687dd3 can be cherry-picked without
conflicts on top of v5.10.202, 5.4.262, 4.19.300 and 4.14.331.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--y5trw4asru3mx4v7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmVuD2gACgkQj4D7WH0S
/k7OZwf/QFu1P6Nw9kfgVpzJIb0i5W3JkhEryDvX+JQu1HG9t+eIqsdsZDo9yvTm
3FfsC3psbNMJxtiNmsUHO2cbQi0VDJQipRfPo/uRMcY+IMg8uDVrXLD7SyZ3WfTx
AgjcjOrpY4BLndGZGCkQl9hviSsBEb4aRMPQ7+ATxVP88oytKdtuKhyE5ma1ek4u
XC4WH8gYRbg56IKnBxsPdjL22QZCd081caVDFPsEiWv99vWy4vf/GDzTjEnymNcn
gKEHrLoVasM7IOEqiCirX/Y70T6c4MOLcCmkqM1OVdSeqPop4d+AVWb/IorB1QAU
0kP4kTirKJ6IkjRUurdDyKMYmgyMbw==
=37HW
-----END PGP SIGNATURE-----

--y5trw4asru3mx4v7--

