Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F30C7E9817
	for <lists+stable@lfdr.de>; Mon, 13 Nov 2023 09:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjKMIxh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 13 Nov 2023 03:53:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjKMIxg (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 13 Nov 2023 03:53:36 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE0F10D0
        for <stable@vger.kernel.org>; Mon, 13 Nov 2023 00:53:32 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r2ShH-0003IE-Hk; Mon, 13 Nov 2023 09:53:31 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r2ShG-008gyh-Vo; Mon, 13 Nov 2023 09:53:30 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r2ShG-000ab4-Ka; Mon, 13 Nov 2023 09:53:30 +0100
Date:   Mon, 13 Nov 2023 09:53:30 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Cc:     stable-commits@vger.kernel.org, Helge Deller <deller@gmx.de>
Subject: Re: Patch "fbdev: omapfb: Drop unused remove function" has been
 added to the 6.6-stable tree
Message-ID: <20231113085330.ik34bufqhut6bt6t@pengutronix.de>
References: <20231113043603.303944-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4xsxo6iyepp3hbyi"
Content-Disposition: inline
In-Reply-To: <20231113043603.303944-1-sashal@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: stable@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


--4xsxo6iyepp3hbyi
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 12, 2023 at 11:36:02PM -0500, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
>=20
>     fbdev: omapfb: Drop unused remove function
>=20
> to the 6.6-stable tree which can be found at:
>     http://www.kernel.org/git/?p=3Dlinux/kernel/git/stable/stable-queue.g=
it;a=3Dsummary
>=20
> The filename of the patch is:
>      fbdev-omapfb-drop-unused-remove-function.patch
> and it can be found in the queue-6.6 subdirectory.
>=20
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
>=20
>=20
>=20
> commit a772de6bea2f5a9b5dad8afe0d9145fd8ee62564
> Author: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Date:   Fri Nov 3 18:35:58 2023 +0100
>=20
>     fbdev: omapfb: Drop unused remove function
>    =20
>     [ Upstream commit fc6699d62f5f4facc3e934efd25892fc36050b70 ]
>    =20
>     OMAP2_VRFB is a bool, so the vrfb driver can never be compiled as a
>     module. With that __exit_p(vrfb_remove) always evaluates to NULL and
>     vrfb_remove() is unused.
>    =20
>     If the driver was compilable as a module, it would fail to build beca=
use
>     the type of vrfb_remove() isn't compatible with struct
>     platform_driver::remove(). (The former returns void, the latter int.)
>    =20
>     Fixes: aa1e49a3752f ("OMAPDSS: VRFB: add omap_vrfb_supported()")
>     Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
>     Signed-off-by: Helge Deller <deller@gmx.de>
>     Signed-off-by: Sasha Levin <sashal@kernel.org>

While it doesn't hurt to backport this patch, I guess it also doesn't
give any benefit (apart from increasing my patch count in stable :-).

This commit just removes code that was thrown away by the compiler
before. So I'd not backport it.
=20
Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--4xsxo6iyepp3hbyi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmVR5AkACgkQj4D7WH0S
/k7s0Qf7B6JGzSohC3a5U/keYaBR68rXmOvoqJz9+x4gJxjky/I5AaOD1e7jEX4V
vEa+Az6T/DMUlRjHOqiFr0ym8qxm64Q/+Uo+WijuFM4spoNbDiD/Ojw9EJPUaKND
Lklu7zvyMV3Q4jawJn862hGu7UDMfxmovTopvwpfCIEJZpFtMsF3gwaXF8Ujkh+y
DY4XLtYWPuxz79EiKG4SAguBbnQ7mydNPgFAoOa0n9aivro7ZEMM/yiBasLxoSu3
7ajE2H/Bgc04SyfFE9wIR8LFtezONHDSb3hlD8EaLK/Dki6vhrmiSljFgqYg4Rlt
KLJeMlEjUCnqZv71D9vTv+ojZC2nzw==
=ZwXy
-----END PGP SIGNATURE-----

--4xsxo6iyepp3hbyi--
