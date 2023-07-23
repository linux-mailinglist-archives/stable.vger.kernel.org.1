Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B200075E239
	for <lists+stable@lfdr.de>; Sun, 23 Jul 2023 16:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbjGWOAV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 23 Jul 2023 10:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjGWOAV (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 23 Jul 2023 10:00:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2598BE70
        for <stable@vger.kernel.org>; Sun, 23 Jul 2023 07:00:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B039060BB8
        for <stable@vger.kernel.org>; Sun, 23 Jul 2023 14:00:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF592C433C9;
        Sun, 23 Jul 2023 14:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690120819;
        bh=q0ka98f2zeZI3XQU0yg9UWEB28dGtShAfXElc3sATSo=;
        h=Subject:To:Cc:From:Date:From;
        b=I7UjXUDdlnJyO6tu9CInuGBNbUfQMgQaiqufCAt5N6E2gNowuHfL5VIcpcQCcicDK
         5Gbm6k1Az4VACHs/c0wOpC5iY2Vh5DRrArTzkL/9GEzfLfNPUZX2tc1xiVu1gsakHx
         eWzEs4fjRhX1EaQVgSxoDO1m7EFIIk5lJ6iQcFZI=
Subject: FAILED: patch "[PATCH] can: mcp251xfd: __mcp251xfd_chip_set_mode(): increase poll" failed to apply to 5.10-stable tree
To:     fedor.ross@ifm.com, marex@denx.de, mkl@pengutronix.de
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 23 Jul 2023 16:00:14 +0200
Message-ID: <2023072314-spent-tamper-2f00@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 9efa1a5407e81265ea502cab83be4de503decc49
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023072314-spent-tamper-2f00@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

9efa1a5407e8 ("can: mcp251xfd: __mcp251xfd_chip_set_mode(): increase poll timeout")
c9e6b80dfd48 ("can: mcp251xfd: update macros describing ring, FIFO and RAM layout")
0a1f2e6502a1 ("can: mcp251xfd: ring: prepare support for runtime configurable RX/TX ring parameters")
aada74220f00 ("can: mcp251xfd: mcp251xfd_priv: introduce macros specifying the number of supported TEF/RX/TX rings")
62713f0d9a38 ("can: mcp251xfd: ring: change order of TX and RX FIFOs")
617283b9c4db ("can: mcp251xfd: ring: prepare to change order of TX and RX FIFOs")
d2d5397fcae1 ("can: mcp251xfd: mcp251xfd_ring_init(): split ring_init into separate functions")
c912f19ee382 ("can: mcp251xfd: introduce struct mcp251xfd_tx_ring::nr and ::fifo_nr and make use of it")
2a68dd8663ea ("can: mcp251xfd: add support for internal PLL")
e39ea1360ca7 ("can: mcp251xfd: mcp251xfd_chip_clock_init(): prepare for PLL support, wait for OSC ready")
a10fd91e42e8 ("can: mcp251xfd: __mcp251xfd_chip_set_mode(): prepare for PLL support: improve error handling and diagnostics")
14193ea2bfee ("can: mcp251xfd: mcp251xfd_chip_timestamp_init(): factor out into separate function")
1ba3690fa2c6 ("can: mcp251xfd: mcp251xfd_chip_sleep(): introduce function to bring chip into sleep mode")
3044a4f271d2 ("can: mcp251xfd: introduce and make use of mcp251xfd_is_fd_mode()")
55bc37c85587 ("can: mcp251xfd: move ring init into separate function")
335c818c5a7a ("can: mcp251xfd: move chip FIFO init into separate file")
1e846c7aeb06 ("can: mcp251xfd: move TEF handling into separate file")
319fdbc9433c ("can: mcp251xfd: move RX handling into separate file")
cae9071bc5ea ("can: mcp251xfd: mcp251xfd.h: sort function prototypes")
99e7cc3b3f85 ("can: mcp251xfd: mcp251xfd_tef_obj_read(): fix typo in error message")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9efa1a5407e81265ea502cab83be4de503decc49 Mon Sep 17 00:00:00 2001
From: Fedor Ross <fedor.ross@ifm.com>
Date: Thu, 4 May 2023 21:50:59 +0200
Subject: [PATCH] can: mcp251xfd: __mcp251xfd_chip_set_mode(): increase poll
 timeout

The mcp251xfd controller needs an idle bus to enter 'Normal CAN 2.0
mode' or . The maximum length of a CAN frame is 736 bits (64 data
bytes, CAN-FD, EFF mode, worst case bit stuffing and interframe
spacing). For low bit rates like 10 kbit/s the arbitrarily chosen
MCP251XFD_POLL_TIMEOUT_US of 1 ms is too small.

Otherwise during polling for the CAN controller to enter 'Normal CAN
2.0 mode' the timeout limit is exceeded and the configuration fails
with:

| $ ip link set dev can1 up type can bitrate 10000
| [  731.911072] mcp251xfd spi2.1 can1: Controller failed to enter mode CAN 2.0 Mode (6) and stays in Configuration Mode (4) (con=0x068b0760, osc=0x00000468).
| [  731.927192] mcp251xfd spi2.1 can1: CRC read error at address 0x0e0c (length=4, data=00 00 00 00, CRC=0x0000) retrying.
| [  731.938101] A link change request failed with some changes committed already. Interface can1 may have been left with an inconsistent configuration, please check.
| RTNETLINK answers: Connection timed out

Make MCP251XFD_POLL_TIMEOUT_US timeout calculation dynamic. Use
maximum of 1ms and bit time of 1 full 64 data bytes CAN-FD frame in
EFF mode, worst case bit stuffing and interframe spacing at the
current bit rate.

For easier backporting define the macro MCP251XFD_FRAME_LEN_MAX_BITS
that holds the max frame length in bits, which is 736. This can be
replaced by can_frame_bits(true, true, true, true, CANFD_MAX_DLEN) in
a cleanup patch later.

Fixes: 55e5b97f003e8 ("can: mcp25xxfd: add driver for Microchip MCP25xxFD SPI CAN")
Signed-off-by: Fedor Ross <fedor.ross@ifm.com>
Signed-off-by: Marek Vasut <marex@denx.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/20230717-mcp251xfd-fix-increase-poll-timeout-v5-1-06600f34c684@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index 68df6d4641b5..eebf967f4711 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -227,6 +227,8 @@ static int
 __mcp251xfd_chip_set_mode(const struct mcp251xfd_priv *priv,
 			  const u8 mode_req, bool nowait)
 {
+	const struct can_bittiming *bt = &priv->can.bittiming;
+	unsigned long timeout_us = MCP251XFD_POLL_TIMEOUT_US;
 	u32 con = 0, con_reqop, osc = 0;
 	u8 mode;
 	int err;
@@ -246,12 +248,16 @@ __mcp251xfd_chip_set_mode(const struct mcp251xfd_priv *priv,
 	if (mode_req == MCP251XFD_REG_CON_MODE_SLEEP || nowait)
 		return 0;
 
+	if (bt->bitrate)
+		timeout_us = max_t(unsigned long, timeout_us,
+				   MCP251XFD_FRAME_LEN_MAX_BITS * USEC_PER_SEC /
+				   bt->bitrate);
+
 	err = regmap_read_poll_timeout(priv->map_reg, MCP251XFD_REG_CON, con,
 				       !mcp251xfd_reg_invalid(con) &&
 				       FIELD_GET(MCP251XFD_REG_CON_OPMOD_MASK,
 						 con) == mode_req,
-				       MCP251XFD_POLL_SLEEP_US,
-				       MCP251XFD_POLL_TIMEOUT_US);
+				       MCP251XFD_POLL_SLEEP_US, timeout_us);
 	if (err != -ETIMEDOUT && err != -EBADMSG)
 		return err;
 
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
index 7024ff0cc2c0..24510b3b8020 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
@@ -387,6 +387,7 @@ static_assert(MCP251XFD_TIMESTAMP_WORK_DELAY_SEC <
 #define MCP251XFD_OSC_STAB_TIMEOUT_US (10 * MCP251XFD_OSC_STAB_SLEEP_US)
 #define MCP251XFD_POLL_SLEEP_US (10)
 #define MCP251XFD_POLL_TIMEOUT_US (USEC_PER_MSEC)
+#define MCP251XFD_FRAME_LEN_MAX_BITS (736)
 
 /* Misc */
 #define MCP251XFD_NAPI_WEIGHT 32

