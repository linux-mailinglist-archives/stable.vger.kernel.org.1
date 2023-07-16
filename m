Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F05AF7551F6
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbjGPUCN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbjGPUCI (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:02:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5197123
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:02:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 63C3760EA6
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:02:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71DEDC433C8;
        Sun, 16 Jul 2023 20:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689537725;
        bh=lFxZrl+/cXRmsQ96zGV+uRjvhjSCUjZ7xF2a0Rt3JZc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qcqBVZye2u8y0DMr1zeMFTsOJeZT5ATo4Ldz0ZMaFh2IQCcBj1oOogWtxao2e9ave
         GfqGcbdx8b8yzk6jIFRfpWDgrRPwefbgXTZsnJUMU9BTpbTxMlGQ3cbUkXbOElps7d
         I8Ygm90JsJlLCIMROLddB4dIkBL5fqquZvQveKCo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jimmy Assarsson <extja@kvaser.com>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 198/800] can: kvaser_pciefd: Set hardware timestamp on transmitted packets
Date:   Sun, 16 Jul 2023 21:40:51 +0200
Message-ID: <20230716194953.701366661@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Jimmy Assarsson <extja@kvaser.com>

[ Upstream commit ec681b91befa982477e24a150dd6452427fe6473 ]

Set hardware timestamp on transmitted packets.

Fixes: 26ad340e582d ("can: kvaser_pciefd: Add driver for Kvaser PCIEcan devices")
Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Link: https://lore.kernel.org/all/20230529134248.752036-5-extja@kvaser.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/can/kvaser_pciefd.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index 404eb90db4ca1..37f4befca0345 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -1519,6 +1519,7 @@ static void kvaser_pciefd_handle_nack_packet(struct kvaser_pciefd_can *can,
 
 	if (skb) {
 		cf->can_id |= CAN_ERR_BUSERROR;
+		kvaser_pciefd_set_skb_timestamp(can->kv_pcie, skb, p->timestamp);
 		netif_rx(skb);
 	} else {
 		stats->rx_dropped++;
@@ -1550,8 +1551,15 @@ static int kvaser_pciefd_handle_ack_packet(struct kvaser_pciefd *pcie,
 		netdev_dbg(can->can.dev, "Packet was flushed\n");
 	} else {
 		int echo_idx = p->header[0] & KVASER_PCIEFD_PACKET_SEQ_MSK;
-		int dlc = can_get_echo_skb(can->can.dev, echo_idx, NULL);
-		u8 count = ioread32(can->reg_base +
+		int dlc;
+		u8 count;
+		struct sk_buff *skb;
+
+		skb = can->can.echo_skb[echo_idx];
+		if (skb)
+			kvaser_pciefd_set_skb_timestamp(pcie, skb, p->timestamp);
+		dlc = can_get_echo_skb(can->can.dev, echo_idx, NULL);
+		count = ioread32(can->reg_base +
 				    KVASER_PCIEFD_KCAN_TX_NPACKETS_REG) & 0xff;
 
 		if (count < KVASER_PCIEFD_CAN_TX_MAX_COUNT &&
-- 
2.39.2



