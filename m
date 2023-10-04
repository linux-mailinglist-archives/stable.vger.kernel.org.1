Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 600797B7CA1
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 11:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232877AbjJDJzK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 05:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232849AbjJDJzJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 05:55:09 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7138283;
        Wed,  4 Oct 2023 02:55:05 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id D888F240018;
        Wed,  4 Oct 2023 09:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1696413304;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=72iAb2IAE4FbKnYSwHehmr/svO5trIG6B6hsbHz2LRA=;
        b=pbITdmedeBgPSsbb3Nv4CdnsuGLyjUyYddo18Pae2H2Q9hxuubSi1PAWvfw7XiW0t+785/
        J/9LPS8C7aUJ9UkTyTmuneHNphvfrDwVv7S/v9WqA0SCSnpNjbEcapq9r+IrNeV8NZF+3p
        xfBSmpPABBD2C1RTPCub3YtlmHZBLJdvttbgM3tSznYJDsUTdLdKbqKwj81NV630W7ex+q
        4XazAHb08EEfTpBkOkaV8TI9qbX6WjXsQEUy2QDhLxRFpW8Ddzd9+siG26Orp2Xq5CVNIC
        7kL8sdhGf7J+EeZ9cddC/fXPgyXUvUtoA9qdCKixMg8LRMBb1nk84kjL4YuXAg==
Date:   Wed, 4 Oct 2023 11:55:00 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
        linux-can@vger.kernel.org,
        =?UTF-8?B?SsOpcsOpbWll?= Dautheribes 
        <jeremie.dautheribes@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        sylvain.girard@se.com, pascal.eberhard@se.com,
        stable@vger.kernel.org
Subject: Re: [PATCH v3] can: sja1000: Always restart the Tx queue after an
 overrun
Message-ID: <20231004115500.6648d3c7@xps-13>
In-Reply-To: <20231004-uneasy-backed-e01d77be9f51-mkl@pengutronix.de>
References: <20231002160206.190953-1-miquel.raynal@bootlin.com>
        <20231004-uneasy-backed-e01d77be9f51-mkl@pengutronix.de>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi Marc,

mkl@pengutronix.de wrote on Wed, 4 Oct 2023 11:41:08 +0200:

> On 02.10.2023 18:02:06, Miquel Raynal wrote:
> > Upstream commit 717c6ec241b5 ("can: sja1000: Prevent overrun stalls with
> > a soft reset on Renesas SoCs") fixes an issue with Renesas own SJA1000
> > CAN controller reception: the Rx buffer is only 5 messages long, so when
> > the bus loaded (eg. a message every 50us), overrun may easily
> > happen. Upon an overrun situation, due to a possible internal crosstalk
> > situation, the controller enters a frozen state which only can be
> > unlocked with a soft reset (experimentally). The solution was to offload
> > a call to sja1000_start() in a threaded handler. This needs to happen in
> > process context as this operation requires to sleep. sja1000_start()
> > basically enters "reset mode", performs a proper software reset and
> > returns back into "normal mode".
> >=20
> > Since this fix was introduced, we no longer observe any stalls in
> > reception. However it was sporadically observed that the transmit path
> > would now freeze. Further investigation blamed the fix mentioned above,
> > and especially the reset operation. Reproducing the reset in a loop
> > helped identifying what could possibly go wrong. The sja1000 is a single
> > Tx queue device, which leverages the netdev helpers to process one Tx
> > message at a time. The logic is: the queue is stopped, the message sent
> > to the transceiver, once properly transmitted the controller sets a
> > status bit which triggers an interrupt, in the interrupt handler the
> > transmission status is checked and the queue woken up. Unfortunately, if
> > an overrun happens, we might perform the soft reset precisely between
> > the transmission of the buffer to the transceiver and the advent of the
> > transmission status bit. We would then stop the transmission operation
> > without re-enabling the queue, leading to all further transmissions to
> > be ignored.
> >=20
> > The reset interrupt can only happen while the device is "open", and
> > after a reset we anyway want to resume normal operations, no matter if a
> > packet to transmit got dropped in the process, so we shall wake up the
> > queue. Restarting the device and waking-up the queue is exactly what
> > sja1000_set_mode(CAN_MODE_START) does. In order to be consistent about
> > the queue state, we must acquire a lock both in the reset handler and in
> > the transmit path to ensure serialization of both operations. It turns
> > out, a lock is already held when entering the transmit path, so we can
> > just acquire/release it as well with the regular net helpers inside the
> > threaded interrupt handler and this way we should be safe. As the
> > reset handler might still be called after the transmission of a frame to
> > the transceiver but before it actually gets transmitted, we must ensure
> > we don't leak the skb, so we free it (the behavior is consistent, no
> > matter if there was an skb on the stack or not).
> >=20
> > Fixes: 717c6ec241b5 ("can: sja1000: Prevent overrun stalls with a soft =
reset on Renesas SoCs")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com> =20
>=20
> Have you compile tested this against current net/main?
>=20
> |   CC [M]  drivers/net/can/sja1000/sja1000.o
> | drivers/net/can/sja1000/sja1000.c: In function =E2=80=98sja1000_reset_i=
nterrupt=E2=80=99:
> | drivers/net/can/sja1000/sja1000.c:398:9: error: too few arguments to fu=
nction =E2=80=98can_free_echo_skb=E2=80=99
> |   398 |         can_free_echo_skb(dev, 0);
> |       |         ^~~~~~~~~~~~~~~~~
> | In file included from include/linux/can/dev.h:22,
> |                  from drivers/net/can/sja1000/sja1000.c:62:
> | include/linux/can/skb.h:28:6: note: declared here
> |    28 | void can_free_echo_skb(struct net_device *dev, unsigned int idx,
> |       |      ^~~~~~~~~~~~~~~~~
> |
>=20
> This chance is mainline since v5.13-rc1~94^2~297^2~34. I've fixed the
> problem while applying the patch.

I didn't, I fixed that in August and forgot I was on a 5.10 when
submitting, as mainline does not run on the platform I used to test.
Thanks for fixing.

Miqu=C3=A8l
