Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF9C878AA3B
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbjH1KUO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbjH1KTx (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:19:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 430A6CE9
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:19:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 510236383C
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:19:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62E3EC433C9;
        Mon, 28 Aug 2023 10:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693217963;
        bh=k2F8HFJ25wfG8SuxTa+pB4xMFPxqD8tsvgJNWZOArpI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hdnS2NpJQqgnuUxrSjmnTKv/oO2iAV/AvKLK7ck9qs/KOzMzvFtUiBEsr4FfVCNq2
         JZp8QZkGHfXrY+gqXIwRdJMI2lsTBbdGrCWU2F218etRNVd2uo2A01FmF6qG6KMcgA
         eRpc9r5uWhuRtQ4/8yqCmWx7yxkbdsXqfuDUkFOA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Oliver Hartkopp <socketcan@hartkopp.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 038/129] can: isotp: fix support for transmission of SF without flow control
Date:   Mon, 28 Aug 2023 12:11:57 +0200
Message-ID: <20230828101158.645922569@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101157.383363777@linuxfoundation.org>
References: <20230828101157.383363777@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Oliver Hartkopp <socketcan@hartkopp.net>

[ Upstream commit 0bfe71159230bab79ee230225ae12ffecbb69f3e ]

The original implementation had a very simple handling for single frame
transmissions as it just sent the single frame without a timeout handling.

With the new echo frame handling the echo frame was also introduced for
single frames but the former exception ('simple without timers') has been
maintained by accident. This leads to a 1 second timeout when closing the
socket and to an -ECOMM error when CAN_ISOTP_WAIT_TX_DONE is selected.

As the echo handling is always active (also for single frames) remove the
wrong extra condition for single frames.

Fixes: 9f39d36530e5 ("can: isotp: add support for transmission without flow control")
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Link: https://lore.kernel.org/r/20230821144547.6658-2-socketcan@hartkopp.net
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/can/isotp.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index ca9d728d6d727..9d498a886a586 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -188,12 +188,6 @@ static bool isotp_register_rxid(struct isotp_sock *so)
 	return (isotp_bc_flags(so) == 0);
 }
 
-static bool isotp_register_txecho(struct isotp_sock *so)
-{
-	/* all modes but SF_BROADCAST register for tx echo skbs */
-	return (isotp_bc_flags(so) != CAN_ISOTP_SF_BROADCAST);
-}
-
 static enum hrtimer_restart isotp_rx_timer_handler(struct hrtimer *hrtimer)
 {
 	struct isotp_sock *so = container_of(hrtimer, struct isotp_sock,
@@ -1209,7 +1203,7 @@ static int isotp_release(struct socket *sock)
 	lock_sock(sk);
 
 	/* remove current filters & unregister */
-	if (so->bound && isotp_register_txecho(so)) {
+	if (so->bound) {
 		if (so->ifindex) {
 			struct net_device *dev;
 
@@ -1332,14 +1326,12 @@ static int isotp_bind(struct socket *sock, struct sockaddr *uaddr, int len)
 		can_rx_register(net, dev, rx_id, SINGLE_MASK(rx_id),
 				isotp_rcv, sk, "isotp", sk);
 
-	if (isotp_register_txecho(so)) {
-		/* no consecutive frame echo skb in flight */
-		so->cfecho = 0;
+	/* no consecutive frame echo skb in flight */
+	so->cfecho = 0;
 
-		/* register for echo skb's */
-		can_rx_register(net, dev, tx_id, SINGLE_MASK(tx_id),
-				isotp_rcv_echo, sk, "isotpe", sk);
-	}
+	/* register for echo skb's */
+	can_rx_register(net, dev, tx_id, SINGLE_MASK(tx_id),
+			isotp_rcv_echo, sk, "isotpe", sk);
 
 	dev_put(dev);
 
@@ -1560,7 +1552,7 @@ static void isotp_notify(struct isotp_sock *so, unsigned long msg,
 	case NETDEV_UNREGISTER:
 		lock_sock(sk);
 		/* remove current filters & unregister */
-		if (so->bound && isotp_register_txecho(so)) {
+		if (so->bound) {
 			if (isotp_register_rxid(so))
 				can_rx_unregister(dev_net(dev), dev, so->rxid,
 						  SINGLE_MASK(so->rxid),
-- 
2.40.1



