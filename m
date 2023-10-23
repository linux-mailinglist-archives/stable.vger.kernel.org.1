Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E45A87D3CC2
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 18:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232894AbjJWQlG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 12:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233270AbjJWQlE (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 12:41:04 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 359C5E5
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 09:40:59 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1quxz8-0000kX-4c; Mon, 23 Oct 2023 18:40:58 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1quxz7-003knD-IX; Mon, 23 Oct 2023 18:40:57 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1quxz7-004SVW-9F; Mon, 23 Oct 2023 18:40:57 +0200
Date:   Mon, 23 Oct 2023 18:40:57 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        Hans de Goede <hdegoede@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.19 06/98] platform/x86: hp-wmi:: Mark driver struct
 with __refdata to prevent section mismatch warning
Message-ID: <20231023164057.7rlec7423jeha6sg@pengutronix.de>
References: <20231023104813.580375891@linuxfoundation.org>
 <20231023104813.808917387@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3ytwruby3bw72jlh"
Content-Disposition: inline
In-Reply-To: <20231023104813.808917387@linuxfoundation.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: stable@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


--3ytwruby3bw72jlh
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 23, 2023 at 12:55:55PM +0200, Greg Kroah-Hartman wrote:
> 4.19-stable review patch.  If anyone has any objections, please let me kn=
ow.
>=20
> ------------------
>=20
> From: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
>=20
> [ Upstream commit 5b44abbc39ca15df80d0da4756078c98c831090f ]
>=20
> As described in the added code comment, a reference to .exit.text is ok
> for drivers registered via module_platform_driver_probe(). Make this
> explicit to prevent a section mismatch warning:
>=20
> 	WARNING: modpost: drivers/platform/x86/hp/hp-wmi: section mismatch in re=
ference: hp_wmi_driver+0x8 (section: .data) -> hp_wmi_bios_remove (section:=
 .exit.text)

While that __ref is actually missing since the blamed commit, modpost
only warns about .data -> .exit.text mismatches since

	f177cd0c15fc ("modpost: Don't let "driver"s reference .exit.*")

(currently in next). So if your goal is to silence warnings in stable,
patches of this type don't need to be backported unless f177cd0c15fc is
backported, too. (But they don't hurt either.)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--3ytwruby3bw72jlh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmU2ohgACgkQj4D7WH0S
/k67NAf/cwJACbeWsHfiFrzBD+mQFMDTgFaKsnA23c8NkBuOsDADy+eXIQs9t2Zf
+4ZaNAneodJsAa608GV6XOMmH1l+CqrUDp1QZJYvlgo74MU37OMWmA0+T3TioJJo
NGtOKsSGFe/zYT3aPad44tGQvj6rcSwPQCdtpSJk9eYX402BWZWyt9+WOuaPShlz
ls9QSXCJ+7OCLUmWvA9GJYIbx+xc0DYU4+SOvvKmPi6YSYQMhoJoEupKlu1irpHS
QRvl7wXUhPy+GVpfRGtMB1UEe787+xwuVtWwk0M9QjSNk25H94CqJxUw1Io2Cn6H
LJedYJKQufSq6Yo+sWkxongnb/POaA==
=0Fgb
-----END PGP SIGNATURE-----

--3ytwruby3bw72jlh--
