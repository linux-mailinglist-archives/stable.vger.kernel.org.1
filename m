Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6B987B001F
	for <lists+stable@lfdr.de>; Wed, 27 Sep 2023 11:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbjI0Jah (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 27 Sep 2023 05:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbjI0Jag (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 27 Sep 2023 05:30:36 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 161AAF3
        for <stable@vger.kernel.org>; Wed, 27 Sep 2023 02:30:35 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qlQs6-0006ea-UJ; Wed, 27 Sep 2023 11:30:18 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mkl@pengutronix.de>)
        id 1qlQs5-009JAV-Np; Wed, 27 Sep 2023 11:30:17 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 545D522990E;
        Wed, 27 Sep 2023 09:30:17 +0000 (UTC)
Date:   Wed, 27 Sep 2023 11:30:16 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
        linux-can@vger.kernel.org,
        =?utf-8?B?SsOpcsOpbWll?= Dautheribes 
        <jeremie.dautheribes@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        sylvain.girard@se.com, pascal.eberhard@se.com,
        stable@vger.kernel.org
Subject: Re: [PATCH net] can: sja1000: Always restart the Tx queue after an
 overrun
Message-ID: <20230927-fantasize-refuse-7fef75242672-mkl@pengutronix.de>
References: <20230922154727.591672-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dxm6ua2k77nc2p6g"
Content-Disposition: inline
In-Reply-To: <20230922154727.591672-1-miquel.raynal@bootlin.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: stable@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


--dxm6ua2k77nc2p6g
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 22.09.2023 17:47:27, Miquel Raynal wrote:
> Upstream commit 717c6ec241b5 ("can: sja1000: Prevent overrun stalls with
> a soft reset on Renesas SoCs") fixes an issue with Renesas own SJA1000
> CAN controller reception: the Rx buffer is only 5 messages long, so when
> the bus loaded (eg. a message every 50us), overrun may easily
> happen. Upon an overrun situation, due to a possible internal crosstalk
> situation, the controller enters a frozen state which only can be
> unlocked with a soft reset (experimentally). The solution was to offload
> a call to sja1000_start() in a threaded handler. This needs to happen in
> process context as this operation requires to sleep. sja1000_start()
> basically enters "reset mode", performs a proper software reset and
> returns back into "normal mode".
>=20
> Since this fix was introduced, we no longer observe any stalls in
> reception. However it was sporadically observed that the transmit path
> would now freeze. Further investigation blamed the fix mentioned above,
> and especially the reset operation. Reproducing the reset in a loop
> helped identifying what could possibly go wrong. The sja1000 is a single
> Tx queue device, which leverages the netdev helpers to process one Tx
> message at a time. The logic is: the queue is stopped, the message sent
> to the transceiver, once properly transmitted the controller sets a
> status bit which triggers an interrupt, in the interrupt handler the
> transmission status is checked and the queue woken up. Unfortunately, if
> an overrun happens, we might perform the soft reset precisely between
> the transmission of the buffer to the transceiver and the advent of the
> transmission status bit. We would then stop the transmission operation
> without re-enabling the queue, leading to all further transmissions to
> be ignored.
>=20
> The reset interrupt can only happen while the device is "open", and
> after a reset we anyway want to resume normal operations, no matter if a
> packet to transmit got dropped in the process, so we shall wake up the
> queue. Restarting the device and waking-up the queue is exactly what
> sja1000_set_mode(CAN_MODE_START) does. In order to be consistent about
> the queue state, we must acquire a lock both in the reset handler and in
> the transmit path to ensure serialization of both operations. As the
> reset handler might still be called after the transmission of a frame to
> the transceiver but before it actually gets transmitted, we must ensure
> we don't leak the skb, so we free it (the behavior is consistent, no
> matter if there was an skb on the stack or not).

Can you make use of netif_tx_disable() and netif_wake_queue() in
sja1000_reset_interrupt() instead of the lock?

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--dxm6ua2k77nc2p6g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmUT9iMACgkQvlAcSiqK
BOj+Sgf9EFmkkY2TP/KQ/K5jYDPETjFgCqGsMLuc3LvUxZdp4gp0mW5uQaSi3WVR
8R/2KoFOmJT2N0o/r6SZenLIPQ6HcyKEZNMb9cyFXuUnl9HnVFTkMXXdPCVlw2GR
8zurqbmqeg5tdLAqp7oejzrZWNNm0za/OxmSCbfNkqo0k0rKB6vJgTkB8WVsdLzA
+U1vE+6EnVxW+t1o1++M18BjxOSLNPxqpbhVv5jHJea9DVbfDVH0bi8vg8uenTch
oIvYwum5B/GToNZGZmrH/nxY6TmPh1AKvnYUueZQTAPb1vIdykpNPOOevf6MIw15
1flC3WhQK2N8uwsl9lk8/oIBzZfKSQ==
=pedi
-----END PGP SIGNATURE-----

--dxm6ua2k77nc2p6g--
