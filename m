Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AFB57C4AE3
	for <lists+stable@lfdr.de>; Wed, 11 Oct 2023 08:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346008AbjJKGoE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 11 Oct 2023 02:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345846AbjJKGnz (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Oct 2023 02:43:55 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9012AC9
        for <stable@vger.kernel.org>; Tue, 10 Oct 2023 23:43:53 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qqSwP-0005Ho-KH; Wed, 11 Oct 2023 08:43:33 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mkl@pengutronix.de>)
        id 1qqSwO-000pu1-7x; Wed, 11 Oct 2023 08:43:32 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id D5B9E233EAF;
        Wed, 11 Oct 2023 06:43:31 +0000 (UTC)
Date:   Wed, 11 Oct 2023 08:43:31 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Francois Romieu <romieu@fr.zoreil.com>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Kalle Valo <kvalo@kernel.org>,
        Wei Fang <wei.fang@nxp.com>, kernel@pengutronix.de,
        stable@vger.kernel.org
Subject: Re: [PATCH net] net: davicom: dm9000: dm9000_phy_write(): fix
 deadlock during netdev watchdog handling
Message-ID: <20231011-said-hemlock-834e5698a7a3-mkl@pengutronix.de>
References: <20231010-dm9000-fix-deadlock-v1-1-b1f4396f83dd@pengutronix.de>
 <20231010222131.GA3324403@electric-eye.fr.zoreil.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="a4km77vwpmqilo6v"
Content-Disposition: inline
In-Reply-To: <20231010222131.GA3324403@electric-eye.fr.zoreil.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: stable@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


--a4km77vwpmqilo6v
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 11.10.2023 00:21:31, Francois Romieu wrote:
> Marc Kleine-Budde <mkl@pengutronix.de> :
> > The dm9000 takes the db->lock spin lock in dm9000_timeout() and calls
> > into dm9000_init_dm9000(). For the DM9000B the PHY is reset with
> > dm9000_phy_write(). That function again takes the db->lock spin lock,
> > which results in a deadlock. For reference the backtrace:
> [...]
> > To workaround similar problem (take mutex inside spin lock ) , a
> > "in_timeout" variable was added in 582379839bbd ("dm9000: avoid
> > sleeping in dm9000_timeout callback"). Use this variable and not take
> > the spin lock inside dm9000_phy_write() if in_timeout is true.
> >=20
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> > ---
> > During the netdev watchdog handling the dm9000 driver takes the same
> > spin lock twice. Avoid this by extending an existing workaround.
> > ---
>=20
> I can review it but I can't really endorse it. :o)
>=20
> Extending ugly workaround in pre-2000 style device drivers...
> I'd rather see the thing fixed if there is some real use for it.

There definitely are still users of this drivers on modern kernels out
there.

I too don't like the feeling of wrapping more and more duct tape
around existing drivers. How about moving the functionality to
dm9000_phy_write_locked() and leave the locking in dm9000_phy_write().
I will prepare a patch.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--a4km77vwpmqilo6v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmUmRBAACgkQvlAcSiqK
BOgEvAf/TShGqtUnCHTnvK9SdY7OpIB8DRrs2C74RY1u7SZ+3H85vhaKkDtOfk30
LKv1esaCPgWSm6R9P0NMVHZXfnoP6o0EzsY2MofK6p49RJeJplVQodM3NhKmM9Ac
MtJ2bccrI1Uo15WmI8P4X0AdrSc/Hd+cmhpiDjpKBqL3/MME91mro8n7DbwAtC9F
q0tmlz5VWw2c56la0UiZGT075UZTsSlQnFXqceX/HzEDpCWAD9As7aqmH7DjsxOd
q4pQrJWdSTLlTsNqPe7FhiS5Ir37kHKilVRj7sRZJ4/AJ2IKAU1W+mExcPX6tS0v
yNpKFDtodb0G/J0LsihRxFSFpKn0ag==
=T8KV
-----END PGP SIGNATURE-----

--a4km77vwpmqilo6v--
