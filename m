Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5DD776127E
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233863AbjGYLDP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233940AbjGYLDC (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:03:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD653C04
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:00:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C68666168F
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 10:59:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFA47C433C8;
        Tue, 25 Jul 2023 10:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690282776;
        bh=O0MYpKJAu6O2RZA8uyHT2fGeT/lXMDi55sq3TvleQ0c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PLg5Ye+1+PzWqogSt7O5/5BNVOALo08MJy3P1Cl/QYP96kknU2RLiq5suAMOyhdKd
         isU3AGJy1fhTIevnNoeCkG0gLmbkZBgka6M4sDX+ZLW21d6jLdMPBJBcsB/3ZSKkMR
         iw3r2dbdb1Ecgz2CLA/kvz0liSwSN8w2T1zeBNNQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Fedor Ross <fedor.ross@ifm.com>,
        Marek Vasut <marex@denx.de>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 6.1 022/183] can: mcp251xfd: __mcp251xfd_chip_set_mode(): increase poll timeout
Date:   Tue, 25 Jul 2023 12:44:10 +0200
Message-ID: <20230725104508.692959275@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104507.756981058@linuxfoundation.org>
References: <20230725104507.756981058@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Fedor Ross <fedor.ross@ifm.com>

commit 9efa1a5407e81265ea502cab83be4de503decc49 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c |   10 ++++++++--
 drivers/net/can/spi/mcp251xfd/mcp251xfd.h      |    1 +
 2 files changed, 9 insertions(+), 2 deletions(-)

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
@@ -246,12 +248,16 @@ __mcp251xfd_chip_set_mode(const struct m
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
 
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
@@ -387,6 +387,7 @@ static_assert(MCP251XFD_TIMESTAMP_WORK_D
 #define MCP251XFD_OSC_STAB_TIMEOUT_US (10 * MCP251XFD_OSC_STAB_SLEEP_US)
 #define MCP251XFD_POLL_SLEEP_US (10)
 #define MCP251XFD_POLL_TIMEOUT_US (USEC_PER_MSEC)
+#define MCP251XFD_FRAME_LEN_MAX_BITS (736)
 
 /* Misc */
 #define MCP251XFD_NAPI_WEIGHT 32


