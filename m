Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 001D978AB90
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbjH1KcX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231553AbjH1KcN (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:32:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08E41AD
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:31:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD4CC61A7C
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:31:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE3B7C433C7;
        Mon, 28 Aug 2023 10:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693218687;
        bh=Q7ev6SjUMvH8r93yzRCZ1Q3kSy1doWQKeMrbok7SB2c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H5YGqb7tNi8GQT+Ujhi1fwTDSpz/SsqevrPtleThf+Ct4+YJq4Y8Sgn4jcAsmWKg7
         fEkYTc7psxrIEwN5DwLKDI/i4ewmI7YRcVk2Agj98JjQzvLdTYeXdyw7nZoRuZxdmx
         3r7qcGAs/8h3H4ckT8qFrKgGkRvo5tt96tPI5Wgo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Oliver Hartkopp <socketcan@hartkopp.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 046/122] can: isotp: fix support for transmission of SF without flow control
Date:   Mon, 28 Aug 2023 12:12:41 +0200
Message-ID: <20230828101157.949950089@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101156.480754469@linuxfoundation.org>
References: <20230828101156.480754469@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

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
index b3c2a49b189cc..8c97f4061ffd7 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -175,12 +175,6 @@ static bool isotp_register_rxid(struct isotp_sock *so)
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
@@ -1176,7 +1170,7 @@ static int isotp_release(struct socket *sock)
 	lock_sock(sk);
 
 	/* remove current filters & unregister */
-	if (so->bound && isotp_register_txecho(so)) {
+	if (so->bound) {
 		if (so->ifindex) {
 			struct net_device *dev;
 
@@ -1293,14 +1287,12 @@ static int isotp_bind(struct socket *sock, struct sockaddr *uaddr, int len)
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
 
@@ -1521,7 +1513,7 @@ static void isotp_notify(struct isotp_sock *so, unsigned long msg,
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



