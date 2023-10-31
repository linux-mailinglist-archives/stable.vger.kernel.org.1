Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7D177DD732
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 21:41:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233691AbjJaUla (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 16:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbjJaUl3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 16:41:29 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC09F5
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 13:41:26 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qxvYD-0000zK-1h; Tue, 31 Oct 2023 21:41:25 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qxvYC-005eEs-CK; Tue, 31 Oct 2023 21:41:24 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qxvYC-00AAZU-33; Tue, 31 Oct 2023 21:41:24 +0100
Date:   Tue, 31 Oct 2023 21:41:23 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        Takashi Iwai <tiwai@suse.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1 05/86] ASoC: codecs: wcd938x: Convert to platform
 remove callback returning void
Message-ID: <20231031204123.thehtrqhmludytt6@pengutronix.de>
References: <20231031165918.608547597@linuxfoundation.org>
 <20231031165918.777236098@linuxfoundation.org>
 <958957ff-bbaa-4fbc-a796-30e2fdf61453@sirena.org.uk>
 <2023103133-skating-last-e2f6@gregkh>
 <8744aeca-36cb-4d47-86f9-92fa70a234e1@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="c6fu7lmipstxgsjl"
Content-Disposition: inline
In-Reply-To: <8744aeca-36cb-4d47-86f9-92fa70a234e1@sirena.org.uk>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: stable@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


--c6fu7lmipstxgsjl
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 31, 2023 at 05:49:03PM +0000, Mark Brown wrote:
> On Tue, Oct 31, 2023 at 06:44:52PM +0100, Greg Kroah-Hartman wrote:
> > On Tue, Oct 31, 2023 at 05:11:27PM +0000, Mark Brown wrote:
>=20
> > > This doesn't seem like obvious stable material - it's not fixing any
> > > leaks or anything, just preparing for an API transition?
>=20
> > It was taken to make the patch after this one apply cleanly, that's all.
>=20
> Ah, I see.

The patch has a footer:

	Stable-dep-of: 69a026a2357e ("ASoC: codecs: wcd938x: fix regulator leaks o=
n probe errors")

to make this point explicit. I really like the addition of this
information to the stable backports.

Thanks to whoever had the idea and implemented that!

Best regards
Uwe



--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--c6fu7lmipstxgsjl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmVBZnMACgkQj4D7WH0S
/k6MEwf/f7FJi+RTbZrGKzccG4CQzbujzIq7pVd59QBaB9WCL8rGCtP4cWcB0IP9
djL68EiWkAEB8qFRQQOAW3N5Ah0eVa5ODSwvqZAZo4ajsxvLV+VhmLk2JCL5pFGP
4FiKHEKxEF0bWS7iZuOLSyGbNAPBZNItCA9Qvxy0xXSPGQ1Va5nS9zRJpLmY2SMU
UDTrhTOhwt5cX7yLjwmzmaq3gNxIy1Svj8511MP11nvReYzgCc4HgTUN+JcieRlM
tP3TRRrinQoOadJHKrULJZsLAtB+MSdngbJqE+pAIF/Q/68W6QnyKI389x/rVHwq
gKWc8MwSdfGAvzp2Mb0JsyLklQP+vg==
=nAJH
-----END PGP SIGNATURE-----

--c6fu7lmipstxgsjl--
