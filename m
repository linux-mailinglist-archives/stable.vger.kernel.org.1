Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B769C7BF4A2
	for <lists+stable@lfdr.de>; Tue, 10 Oct 2023 09:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442419AbjJJHnK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 10 Oct 2023 03:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442446AbjJJHnJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 10 Oct 2023 03:43:09 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E9F9E
        for <stable@vger.kernel.org>; Tue, 10 Oct 2023 00:43:08 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qq7OK-0007AR-Op; Tue, 10 Oct 2023 09:42:56 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mkl@pengutronix.de>)
        id 1qq7OK-000bhI-7R; Tue, 10 Oct 2023 09:42:56 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id D04022332F5;
        Tue, 10 Oct 2023 07:42:55 +0000 (UTC)
Date:   Tue, 10 Oct 2023 09:42:55 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Francois Romieu <romieu@fr.zoreil.com>,
        Kalle Valo <kvalo@kernel.org>, Wei Fang <wei.fang@nxp.com>,
        kernel@pengutronix.de, stable@vger.kernel.org
Subject: Re: [PATCH net] net: davicom: dm9000: dm9000_phy_write(): fix
 deadlock during netdev watchdog handling
Message-ID: <20231010-smite-populace-090139229be1-mkl@pengutronix.de>
References: <20231010-dm9000-fix-deadlock-v1-1-b1f4396f83dd@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2ujovxvoj2fa5hkv"
Content-Disposition: inline
In-Reply-To: <20231010-dm9000-fix-deadlock-v1-1-b1f4396f83dd@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: stable@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


--2ujovxvoj2fa5hkv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 10.10.2023 09:35:19, Marc Kleine-Budde wrote:
> The dm9000 takes the db->lock spin lock in dm9000_timeout() and calls
> into dm9000_init_dm9000(). For the DM9000B the PHY is reset with
> dm9000_phy_write(). That function again takes the db->lock spin lock,
> which results in a deadlock. For reference the backtrace:
>=20
> | [<c0425050>] (rt_spin_lock_slowlock_locked) from [<c0425100>] (rt_spin_=
lock_slowlock+0x60/0xc4)
> | [<c0425100>] (rt_spin_lock_slowlock) from [<c02e1174>] (dm9000_phy_writ=
e+0x2c/0x1a4)
> | [<c02e1174>] (dm9000_phy_write) from [<c02e16b0>] (dm9000_init_dm9000+0=
x288/0x2a4)
> | [<c02e16b0>] (dm9000_init_dm9000) from [<c02e1724>] (dm9000_timeout+0x5=
8/0xd4)
> | [<c02e1724>] (dm9000_timeout) from [<c036f298>] (dev_watchdog+0x258/0x2=
a8)
> | [<c036f298>] (dev_watchdog) from [<c0068168>] (call_timer_fn+0x20/0x88)
> | [<c0068168>] (call_timer_fn) from [<c00687c8>] (expire_timers+0xf0/0x19=
4)
> | [<c00687c8>] (expire_timers) from [<c0068920>] (run_timer_softirq+0xb4/=
0x25c)
> | [<c0068920>] (run_timer_softirq) from [<c0021a30>] (do_current_softirqs=
+0x16c/0x228)
> | [<c0021a30>] (do_current_softirqs) from [<c0021b14>] (run_ksoftirqd+0x2=
8/0x4c)
> | [<c0021b14>] (run_ksoftirqd) from [<c0040488>] (smpboot_thread_fn+0x278=
/0x290)
> | [<c0040488>] (smpboot_thread_fn) from [<c003c28c>] (kthread+0x124/0x164)
> | [<c003c28c>] (kthread) from [<c00090f0>] (ret_from_fork+0x14/0x24)
>=20
> To workaround similar problem (take mutex inside spin lock ) , a
> "in_timeout" variable was added in 582379839bbd ("dm9000: avoid
> sleeping in dm9000_timeout callback"). Use this variable and not take
> the spin lock inside dm9000_phy_write() if in_timeout is true.
>=20
> Cc: stable@vger.kernel.org
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

Fixes: a1365275e745 ("[PATCH] DM9000 network driver")

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--2ujovxvoj2fa5hkv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmUlAHwACgkQvlAcSiqK
BOjNsAf/WenQ7YsHEiBxYftZny6AIRNMWWzyxI4UVTNYDHd8ygrFvirD5fUpRVuM
7DFpjUs2RDe30UqZ9z4u/mDH6ZK/pXvM2+MSYfJoDJhP62Y3Zp2jaOW24A90ahIb
U953NIKiuDofWEzKOe/h34TvUvWOMo1FbbWlWF4P0Wd6uIOE76qyRkkjEA7S49Z7
XH07fXYZxBHYdj4IYgZ21sRDRRIzLtG1xtPWqswhVUmwcfP1DhJaR7Iatg/hpF0c
npaAlDLgxJw7mggWfr7wEXlIyRm3OqnjCn0z4RMPNJ8ZDzBOMtyHbaSKH9dqo9bX
sVn2AjxEVOXnlL88yYMDGVIwA9A0XA==
=uL7L
-----END PGP SIGNATURE-----

--2ujovxvoj2fa5hkv--
