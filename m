Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94DEC7E2520
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:28:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232646AbjKFN2a (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:28:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232628AbjKFN23 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:28:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA1D92;
        Mon,  6 Nov 2023 05:28:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D674C433C7;
        Mon,  6 Nov 2023 13:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699277304;
        bh=TLhSkFLAM9fPEDMgmid1ZyHt51BE1yXQJDfaiuzVLO8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OaLHgfJjNs3lkN7xphwUOpN7O2iIvEYS5C5xeuQ0OQhjoKLO85jNNpRFEgopXMCGr
         N0sKJsrxtdB12tEy4hr4iLya/rCV7DyIfy/jBz+afDHTHePOHStEY7l3pYsJaxqZjo
         v05ROzCnohpb98USa55hnUAiMoc9KBEk5TpYtv38=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "linux-can@vger.kernel.org, lukas.magel@posteo.net,
        patches@lists.linux.dev, maxime.jayat@mobile-devices.fr,
        mkl@pengutronix.de, michal.sojka@cvut.cz, Oliver Hartkopp" 
        <socketcan@hartkopp.net>, Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH 5.15 108/128] can: isotp: add local echo tx processing and tx without FC
Date:   Mon,  6 Nov 2023 14:04:28 +0100
Message-ID: <20231106130314.078069847@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130309.112650042@linuxfoundation.org>
References: <20231106130309.112650042@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Oliver Hartkopp <socketcan@hartkopp.net>

commit 4b7fe92c06901f4563af0e36d25223a5ab343782 upstream
commit 9f39d36530e5678d092d53c5c2c60d82b4dcc169 upstream
commit 051737439eaee5bdd03d3c2ef5510d54a478fd05 upstream

Due to the existing patch order applied to isotp.c in the stable kernel the
original order of depending patches the three original patches
4b7fe92c0690 ("can: isotp: add local echo tx processing for consecutive frames")
9f39d36530e5 ("can: isotp: add support for transmission without flow control")
051737439eae ("can: isotp: fix race between isotp_sendsmg() and isotp_release()")
can not be split into different patches that can be applied in working steps
to the stable tree.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/uapi/linux/can/isotp.h |   25 +-
 net/can/isotp.c                |  406 ++++++++++++++++++++++++++---------------
 2 files changed, 271 insertions(+), 160 deletions(-)

--- a/include/uapi/linux/can/isotp.h
+++ b/include/uapi/linux/can/isotp.h
@@ -124,18 +124,19 @@ struct can_isotp_ll_options {
 
 /* flags for isotp behaviour */
 
-#define CAN_ISOTP_LISTEN_MODE	0x001	/* listen only (do not send FC) */
-#define CAN_ISOTP_EXTEND_ADDR	0x002	/* enable extended addressing */
-#define CAN_ISOTP_TX_PADDING	0x004	/* enable CAN frame padding tx path */
-#define CAN_ISOTP_RX_PADDING	0x008	/* enable CAN frame padding rx path */
-#define CAN_ISOTP_CHK_PAD_LEN	0x010	/* check received CAN frame padding */
-#define CAN_ISOTP_CHK_PAD_DATA	0x020	/* check received CAN frame padding */
-#define CAN_ISOTP_HALF_DUPLEX	0x040	/* half duplex error state handling */
-#define CAN_ISOTP_FORCE_TXSTMIN	0x080	/* ignore stmin from received FC */
-#define CAN_ISOTP_FORCE_RXSTMIN	0x100	/* ignore CFs depending on rx stmin */
-#define CAN_ISOTP_RX_EXT_ADDR	0x200	/* different rx extended addressing */
-#define CAN_ISOTP_WAIT_TX_DONE	0x400	/* wait for tx completion */
-#define CAN_ISOTP_SF_BROADCAST	0x800	/* 1-to-N functional addressing */
+#define CAN_ISOTP_LISTEN_MODE	0x0001	/* listen only (do not send FC) */
+#define CAN_ISOTP_EXTEND_ADDR	0x0002	/* enable extended addressing */
+#define CAN_ISOTP_TX_PADDING	0x0004	/* enable CAN frame padding tx path */
+#define CAN_ISOTP_RX_PADDING	0x0008	/* enable CAN frame padding rx path */
+#define CAN_ISOTP_CHK_PAD_LEN	0x0010	/* check received CAN frame padding */
+#define CAN_ISOTP_CHK_PAD_DATA	0x0020	/* check received CAN frame padding */
+#define CAN_ISOTP_HALF_DUPLEX	0x0040	/* half duplex error state handling */
+#define CAN_ISOTP_FORCE_TXSTMIN	0x0080	/* ignore stmin from received FC */
+#define CAN_ISOTP_FORCE_RXSTMIN	0x0100	/* ignore CFs depending on rx stmin */
+#define CAN_ISOTP_RX_EXT_ADDR	0x0200	/* different rx extended addressing */
+#define CAN_ISOTP_WAIT_TX_DONE	0x0400	/* wait for tx completion */
+#define CAN_ISOTP_SF_BROADCAST	0x0800	/* 1-to-N functional addressing */
+#define CAN_ISOTP_CF_BROADCAST	0x1000	/* 1-to-N transmission w/o FC */
 
 /* protocol machine default values */
 
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -14,7 +14,6 @@
  * - use CAN_ISOTP_WAIT_TX_DONE flag to block the caller until the PDU is sent
  * - as we have static buffers the check whether the PDU fits into the buffer
  *   is done at FF reception time (no support for sending 'wait frames')
- * - take care of the tx-queue-len as traffic shaping is still on the TODO list
  *
  * Copyright (c) 2020 Volkswagen Group Electronic Research
  * All rights reserved.
@@ -105,18 +104,23 @@ MODULE_ALIAS("can-proto-6");
 #define FC_CONTENT_SZ 3	/* flow control content size in byte (FS/BS/STmin) */
 
 #define ISOTP_CHECK_PADDING (CAN_ISOTP_CHK_PAD_LEN | CAN_ISOTP_CHK_PAD_DATA)
+#define ISOTP_ALL_BC_FLAGS (CAN_ISOTP_SF_BROADCAST | CAN_ISOTP_CF_BROADCAST)
 
 /* Flow Status given in FC frame */
 #define ISOTP_FC_CTS 0		/* clear to send */
 #define ISOTP_FC_WT 1		/* wait */
 #define ISOTP_FC_OVFLW 2	/* overflow */
 
+#define ISOTP_FC_TIMEOUT 1	/* 1 sec */
+#define ISOTP_ECHO_TIMEOUT 2	/* 2 secs */
+
 enum {
 	ISOTP_IDLE = 0,
 	ISOTP_WAIT_FIRST_FC,
 	ISOTP_WAIT_FC,
 	ISOTP_WAIT_DATA,
-	ISOTP_SENDING
+	ISOTP_SENDING,
+	ISOTP_SHUTDOWN,
 };
 
 struct tpcon {
@@ -137,13 +141,14 @@ struct isotp_sock {
 	canid_t rxid;
 	ktime_t tx_gap;
 	ktime_t lastrxcf_tstamp;
-	struct hrtimer rxtimer, txtimer;
+	struct hrtimer rxtimer, txtimer, txfrtimer;
 	struct can_isotp_options opt;
 	struct can_isotp_fc_options rxfc, txfc;
 	struct can_isotp_ll_options ll;
 	u32 frame_txtime;
 	u32 force_tx_stmin;
 	u32 force_rx_stmin;
+	u32 cfecho; /* consecutive frame echo tag */
 	struct tpcon rx, tx;
 	struct list_head notifier;
 	wait_queue_head_t wait;
@@ -159,6 +164,17 @@ static inline struct isotp_sock *isotp_s
 	return (struct isotp_sock *)sk;
 }
 
+static u32 isotp_bc_flags(struct isotp_sock *so)
+{
+	return so->opt.flags & ISOTP_ALL_BC_FLAGS;
+}
+
+static bool isotp_register_rxid(struct isotp_sock *so)
+{
+	/* no broadcast modes => register rx_id for FC frame reception */
+	return (isotp_bc_flags(so) == 0);
+}
+
 static enum hrtimer_restart isotp_rx_timer_handler(struct hrtimer *hrtimer)
 {
 	struct isotp_sock *so = container_of(hrtimer, struct isotp_sock,
@@ -240,7 +256,8 @@ static int isotp_send_fc(struct sock *sk
 	so->lastrxcf_tstamp = ktime_set(0, 0);
 
 	/* start rx timeout watchdog */
-	hrtimer_start(&so->rxtimer, ktime_set(1, 0), HRTIMER_MODE_REL_SOFT);
+	hrtimer_start(&so->rxtimer, ktime_set(ISOTP_FC_TIMEOUT, 0),
+		      HRTIMER_MODE_REL_SOFT);
 	return 0;
 }
 
@@ -326,6 +343,8 @@ static int check_pad(struct isotp_sock *
 	return 0;
 }
 
+static void isotp_send_cframe(struct isotp_sock *so);
+
 static int isotp_rcv_fc(struct isotp_sock *so, struct canfd_frame *cf, int ae)
 {
 	struct sock *sk = &so->sk;
@@ -380,14 +399,15 @@ static int isotp_rcv_fc(struct isotp_soc
 	case ISOTP_FC_CTS:
 		so->tx.bs = 0;
 		so->tx.state = ISOTP_SENDING;
-		/* start cyclic timer for sending CF frame */
-		hrtimer_start(&so->txtimer, so->tx_gap,
+		/* send CF frame and enable echo timeout handling */
+		hrtimer_start(&so->txtimer, ktime_set(ISOTP_ECHO_TIMEOUT, 0),
 			      HRTIMER_MODE_REL_SOFT);
+		isotp_send_cframe(so);
 		break;
 
 	case ISOTP_FC_WT:
 		/* start timer to wait for next FC frame */
-		hrtimer_start(&so->txtimer, ktime_set(1, 0),
+		hrtimer_start(&so->txtimer, ktime_set(ISOTP_FC_TIMEOUT, 0),
 			      HRTIMER_MODE_REL_SOFT);
 		break;
 
@@ -582,7 +602,7 @@ static int isotp_rcv_cf(struct sock *sk,
 	/* perform blocksize handling, if enabled */
 	if (!so->rxfc.bs || ++so->rx.bs < so->rxfc.bs) {
 		/* start rx timeout watchdog */
-		hrtimer_start(&so->rxtimer, ktime_set(1, 0),
+		hrtimer_start(&so->rxtimer, ktime_set(ISOTP_FC_TIMEOUT, 0),
 			      HRTIMER_MODE_REL_SOFT);
 		return 0;
 	}
@@ -713,6 +733,63 @@ static void isotp_fill_dataframe(struct
 		cf->data[0] = so->opt.ext_address;
 }
 
+static void isotp_send_cframe(struct isotp_sock *so)
+{
+	struct sock *sk = &so->sk;
+	struct sk_buff *skb;
+	struct net_device *dev;
+	struct canfd_frame *cf;
+	int can_send_ret;
+	int ae = (so->opt.flags & CAN_ISOTP_EXTEND_ADDR) ? 1 : 0;
+
+	dev = dev_get_by_index(sock_net(sk), so->ifindex);
+	if (!dev)
+		return;
+
+	skb = alloc_skb(so->ll.mtu + sizeof(struct can_skb_priv), GFP_ATOMIC);
+	if (!skb) {
+		dev_put(dev);
+		return;
+	}
+
+	can_skb_reserve(skb);
+	can_skb_prv(skb)->ifindex = dev->ifindex;
+	can_skb_prv(skb)->skbcnt = 0;
+
+	cf = (struct canfd_frame *)skb->data;
+	skb_put_zero(skb, so->ll.mtu);
+
+	/* create consecutive frame */
+	isotp_fill_dataframe(cf, so, ae, 0);
+
+	/* place consecutive frame N_PCI in appropriate index */
+	cf->data[ae] = N_PCI_CF | so->tx.sn++;
+	so->tx.sn %= 16;
+	so->tx.bs++;
+
+	cf->flags = so->ll.tx_flags;
+
+	skb->dev = dev;
+	can_skb_set_owner(skb, sk);
+
+	/* cfecho should have been zero'ed by init/isotp_rcv_echo() */
+	if (so->cfecho)
+		pr_notice_once("can-isotp: cfecho is %08X != 0\n", so->cfecho);
+
+	/* set consecutive frame echo tag */
+	so->cfecho = *(u32 *)cf->data;
+
+	/* send frame with local echo enabled */
+	can_send_ret = can_send(skb, 1);
+	if (can_send_ret) {
+		pr_notice_once("can-isotp: %s: can_send_ret %pe\n",
+			       __func__, ERR_PTR(can_send_ret));
+		if (can_send_ret == -ENOBUFS)
+			pr_notice_once("can-isotp: tx queue is full\n");
+	}
+	dev_put(dev);
+}
+
 static void isotp_create_fframe(struct canfd_frame *cf, struct isotp_sock *so,
 				int ae)
 {
@@ -746,145 +823,123 @@ static void isotp_create_fframe(struct c
 		cf->data[i] = so->tx.buf[so->tx.idx++];
 
 	so->tx.sn = 1;
-	so->tx.state = ISOTP_WAIT_FIRST_FC;
 }
 
-static enum hrtimer_restart isotp_tx_timer_handler(struct hrtimer *hrtimer)
+static void isotp_rcv_echo(struct sk_buff *skb, void *data)
 {
-	struct isotp_sock *so = container_of(hrtimer, struct isotp_sock,
-					     txtimer);
-	struct sock *sk = &so->sk;
-	struct sk_buff *skb;
-	struct net_device *dev;
-	struct canfd_frame *cf;
-	enum hrtimer_restart restart = HRTIMER_NORESTART;
-	int can_send_ret;
-	int ae = (so->opt.flags & CAN_ISOTP_EXTEND_ADDR) ? 1 : 0;
+	struct sock *sk = (struct sock *)data;
+	struct isotp_sock *so = isotp_sk(sk);
+	struct canfd_frame *cf = (struct canfd_frame *)skb->data;
 
-	switch (so->tx.state) {
-	case ISOTP_WAIT_FC:
-	case ISOTP_WAIT_FIRST_FC:
+	/* only handle my own local echo CF/SF skb's (no FF!) */
+	if (skb->sk != sk || so->cfecho != *(u32 *)cf->data)
+		return;
 
-		/* we did not get any flow control frame in time */
+	/* cancel local echo timeout */
+	hrtimer_cancel(&so->txtimer);
 
-		/* report 'communication error on send' */
-		sk->sk_err = ECOMM;
-		if (!sock_flag(sk, SOCK_DEAD))
-			sk_error_report(sk);
+	/* local echo skb with consecutive frame has been consumed */
+	so->cfecho = 0;
 
-		/* reset tx state */
+	if (so->tx.idx >= so->tx.len) {
+		/* we are done */
 		so->tx.state = ISOTP_IDLE;
 		wake_up_interruptible(&so->wait);
-		break;
+		return;
+	}
 
-	case ISOTP_SENDING:
+	if (so->txfc.bs && so->tx.bs >= so->txfc.bs) {
+		/* stop and wait for FC with timeout */
+		so->tx.state = ISOTP_WAIT_FC;
+		hrtimer_start(&so->txtimer, ktime_set(ISOTP_FC_TIMEOUT, 0),
+			      HRTIMER_MODE_REL_SOFT);
+		return;
+	}
 
-		/* push out the next segmented pdu */
-		dev = dev_get_by_index(sock_net(sk), so->ifindex);
-		if (!dev)
-			break;
+	/* no gap between data frames needed => use burst mode */
+	if (!so->tx_gap) {
+		/* enable echo timeout handling */
+		hrtimer_start(&so->txtimer, ktime_set(ISOTP_ECHO_TIMEOUT, 0),
+			      HRTIMER_MODE_REL_SOFT);
+		isotp_send_cframe(so);
+		return;
+	}
 
-isotp_tx_burst:
-		skb = alloc_skb(so->ll.mtu + sizeof(struct can_skb_priv),
-				GFP_ATOMIC);
-		if (!skb) {
-			dev_put(dev);
-			break;
-		}
+	/* start timer to send next consecutive frame with correct delay */
+	hrtimer_start(&so->txfrtimer, so->tx_gap, HRTIMER_MODE_REL_SOFT);
+}
 
-		can_skb_reserve(skb);
-		can_skb_prv(skb)->ifindex = dev->ifindex;
-		can_skb_prv(skb)->skbcnt = 0;
-
-		cf = (struct canfd_frame *)skb->data;
-		skb_put_zero(skb, so->ll.mtu);
-
-		/* create consecutive frame */
-		isotp_fill_dataframe(cf, so, ae, 0);
-
-		/* place consecutive frame N_PCI in appropriate index */
-		cf->data[ae] = N_PCI_CF | so->tx.sn++;
-		so->tx.sn %= 16;
-		so->tx.bs++;
-
-		cf->flags = so->ll.tx_flags;
-
-		skb->dev = dev;
-		can_skb_set_owner(skb, sk);
-
-		can_send_ret = can_send(skb, 1);
-		if (can_send_ret) {
-			pr_notice_once("can-isotp: %s: can_send_ret %pe\n",
-				       __func__, ERR_PTR(can_send_ret));
-			if (can_send_ret == -ENOBUFS)
-				pr_notice_once("can-isotp: tx queue is full, increasing txqueuelen may prevent this error\n");
-		}
-		if (so->tx.idx >= so->tx.len) {
-			/* we are done */
-			so->tx.state = ISOTP_IDLE;
-			dev_put(dev);
-			wake_up_interruptible(&so->wait);
-			break;
-		}
+static enum hrtimer_restart isotp_tx_timer_handler(struct hrtimer *hrtimer)
+{
+	struct isotp_sock *so = container_of(hrtimer, struct isotp_sock,
+					     txtimer);
+	struct sock *sk = &so->sk;
 
-		if (so->txfc.bs && so->tx.bs >= so->txfc.bs) {
-			/* stop and wait for FC */
-			so->tx.state = ISOTP_WAIT_FC;
-			dev_put(dev);
-			hrtimer_set_expires(&so->txtimer,
-					    ktime_add(ktime_get(),
-						      ktime_set(1, 0)));
-			restart = HRTIMER_RESTART;
-			break;
-		}
+	/* don't handle timeouts in IDLE or SHUTDOWN state */
+	if (so->tx.state == ISOTP_IDLE || so->tx.state == ISOTP_SHUTDOWN)
+		return HRTIMER_NORESTART;
+
+	/* we did not get any flow control or echo frame in time */
+
+	/* report 'communication error on send' */
+	sk->sk_err = ECOMM;
+	if (!sock_flag(sk, SOCK_DEAD))
+		sk_error_report(sk);
 
-		/* no gap between data frames needed => use burst mode */
-		if (!so->tx_gap)
-			goto isotp_tx_burst;
+	/* reset tx state */
+	so->tx.state = ISOTP_IDLE;
+	wake_up_interruptible(&so->wait);
 
-		/* start timer to send next data frame with correct delay */
-		dev_put(dev);
-		hrtimer_set_expires(&so->txtimer,
-				    ktime_add(ktime_get(), so->tx_gap));
-		restart = HRTIMER_RESTART;
-		break;
+	return HRTIMER_NORESTART;
+}
 
-	default:
-		WARN_ON_ONCE(1);
-	}
+static enum hrtimer_restart isotp_txfr_timer_handler(struct hrtimer *hrtimer)
+{
+	struct isotp_sock *so = container_of(hrtimer, struct isotp_sock,
+					     txfrtimer);
 
-	return restart;
+	/* start echo timeout handling and cover below protocol error */
+	hrtimer_start(&so->txtimer, ktime_set(ISOTP_ECHO_TIMEOUT, 0),
+		      HRTIMER_MODE_REL_SOFT);
+
+	/* cfecho should be consumed by isotp_rcv_echo() here */
+	if (so->tx.state == ISOTP_SENDING && !so->cfecho)
+		isotp_send_cframe(so);
+
+	return HRTIMER_NORESTART;
 }
 
 static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 {
 	struct sock *sk = sock->sk;
 	struct isotp_sock *so = isotp_sk(sk);
-	u32 old_state = so->tx.state;
 	struct sk_buff *skb;
 	struct net_device *dev;
 	struct canfd_frame *cf;
 	int ae = (so->opt.flags & CAN_ISOTP_EXTEND_ADDR) ? 1 : 0;
 	int wait_tx_done = (so->opt.flags & CAN_ISOTP_WAIT_TX_DONE) ? 1 : 0;
-	s64 hrtimer_sec = 0;
+	s64 hrtimer_sec = ISOTP_ECHO_TIMEOUT;
 	int off;
 	int err;
 
-	if (!so->bound)
+	if (!so->bound || so->tx.state == ISOTP_SHUTDOWN)
 		return -EADDRNOTAVAIL;
 
+wait_free_buffer:
 	/* we do not support multiple buffers - for now */
-	if (cmpxchg(&so->tx.state, ISOTP_IDLE, ISOTP_SENDING) != ISOTP_IDLE ||
-	    wq_has_sleeper(&so->wait)) {
-		if (msg->msg_flags & MSG_DONTWAIT) {
-			err = -EAGAIN;
-			goto err_out;
-		}
+	if (wq_has_sleeper(&so->wait) && (msg->msg_flags & MSG_DONTWAIT))
+		return -EAGAIN;
 
-		/* wait for complete transmission of current pdu */
-		err = wait_event_interruptible(so->wait, so->tx.state == ISOTP_IDLE);
-		if (err)
-			goto err_out;
+	/* wait for complete transmission of current pdu */
+	err = wait_event_interruptible(so->wait, so->tx.state == ISOTP_IDLE);
+	if (err)
+		goto err_event_drop;
+
+	if (cmpxchg(&so->tx.state, ISOTP_IDLE, ISOTP_SENDING) != ISOTP_IDLE) {
+		if (so->tx.state == ISOTP_SHUTDOWN)
+			return -EADDRNOTAVAIL;
+
+		goto wait_free_buffer;
 	}
 
 	if (!size || size > MAX_MSG_LENGTH) {
@@ -896,7 +951,7 @@ static int isotp_sendmsg(struct socket *
 	off = (so->tx.ll_dl > CAN_MAX_DLEN) ? 1 : 0;
 
 	/* does the given data fit into a single frame for SF_BROADCAST? */
-	if ((so->opt.flags & CAN_ISOTP_SF_BROADCAST) &&
+	if ((isotp_bc_flags(so) == CAN_ISOTP_SF_BROADCAST) &&
 	    (size > so->tx.ll_dl - SF_PCI_SZ4 - ae - off)) {
 		err = -EINVAL;
 		goto err_out_drop;
@@ -929,6 +984,10 @@ static int isotp_sendmsg(struct socket *
 	cf = (struct canfd_frame *)skb->data;
 	skb_put_zero(skb, so->ll.mtu);
 
+	/* cfecho should have been zero'ed by init / former isotp_rcv_echo() */
+	if (so->cfecho)
+		pr_notice_once("can-isotp: uninit cfecho %08X\n", so->cfecho);
+
 	/* check for single frame transmission depending on TX_DL */
 	if (size <= so->tx.ll_dl - SF_PCI_SZ4 - ae - off) {
 		/* The message size generally fits into a SingleFrame - good.
@@ -954,22 +1013,40 @@ static int isotp_sendmsg(struct socket *
 		else
 			cf->data[ae] |= size;
 
-		so->tx.state = ISOTP_IDLE;
-		wake_up_interruptible(&so->wait);
-
-		/* don't enable wait queue for a single frame transmission */
-		wait_tx_done = 0;
+		/* set CF echo tag for isotp_rcv_echo() (SF-mode) */
+		so->cfecho = *(u32 *)cf->data;
 	} else {
-		/* send first frame and wait for FC */
+		/* send first frame */
 
 		isotp_create_fframe(cf, so, ae);
 
-		/* start timeout for FC */
-		hrtimer_sec = 1;
-		hrtimer_start(&so->txtimer, ktime_set(hrtimer_sec, 0),
-			      HRTIMER_MODE_REL_SOFT);
+		if (isotp_bc_flags(so) == CAN_ISOTP_CF_BROADCAST) {
+			/* set timer for FC-less operation (STmin = 0) */
+			if (so->opt.flags & CAN_ISOTP_FORCE_TXSTMIN)
+				so->tx_gap = ktime_set(0, so->force_tx_stmin);
+			else
+				so->tx_gap = ktime_set(0, so->frame_txtime);
+
+			/* disable wait for FCs due to activated block size */
+			so->txfc.bs = 0;
+
+			/* set CF echo tag for isotp_rcv_echo() (CF-mode) */
+			so->cfecho = *(u32 *)cf->data;
+		} else {
+			/* standard flow control check */
+			so->tx.state = ISOTP_WAIT_FIRST_FC;
+
+			/* start timeout for FC */
+			hrtimer_sec = ISOTP_FC_TIMEOUT;
+
+			/* no CF echo tag for isotp_rcv_echo() (FF-mode) */
+			so->cfecho = 0;
+		}
 	}
 
+	hrtimer_start(&so->txtimer, ktime_set(hrtimer_sec, 0),
+		      HRTIMER_MODE_REL_SOFT);
+
 	/* send the first or only CAN frame */
 	cf->flags = so->ll.tx_flags;
 
@@ -982,15 +1059,19 @@ static int isotp_sendmsg(struct socket *
 			       __func__, ERR_PTR(err));
 
 		/* no transmission -> no timeout monitoring */
-		if (hrtimer_sec)
-			hrtimer_cancel(&so->txtimer);
+		hrtimer_cancel(&so->txtimer);
+
+		/* reset consecutive frame echo tag */
+		so->cfecho = 0;
 
 		goto err_out_drop;
 	}
 
 	if (wait_tx_done) {
 		/* wait for complete transmission of current pdu */
-		wait_event_interruptible(so->wait, so->tx.state == ISOTP_IDLE);
+		err = wait_event_interruptible(so->wait, so->tx.state == ISOTP_IDLE);
+		if (err)
+			goto err_event_drop;
 
 		err = sock_error(sk);
 		if (err)
@@ -999,13 +1080,15 @@ static int isotp_sendmsg(struct socket *
 
 	return size;
 
+err_event_drop:
+	/* got signal: force tx state machine to be idle */
+	so->tx.state = ISOTP_IDLE;
+	hrtimer_cancel(&so->txfrtimer);
+	hrtimer_cancel(&so->txtimer);
 err_out_drop:
 	/* drop this PDU and unlock a potential wait queue */
-	old_state = ISOTP_IDLE;
-err_out:
-	so->tx.state = old_state;
-	if (so->tx.state == ISOTP_IDLE)
-		wake_up_interruptible(&so->wait);
+	so->tx.state = ISOTP_IDLE;
+	wake_up_interruptible(&so->wait);
 
 	return err;
 }
@@ -1069,10 +1152,12 @@ static int isotp_release(struct socket *
 	net = sock_net(sk);
 
 	/* wait for complete transmission of current pdu */
-	wait_event_interruptible(so->wait, so->tx.state == ISOTP_IDLE);
+	while (wait_event_interruptible(so->wait, so->tx.state == ISOTP_IDLE) == 0 &&
+	       cmpxchg(&so->tx.state, ISOTP_IDLE, ISOTP_SHUTDOWN) != ISOTP_IDLE)
+		;
 
 	/* force state machines to be idle also when a signal occurred */
-	so->tx.state = ISOTP_IDLE;
+	so->tx.state = ISOTP_SHUTDOWN;
 	so->rx.state = ISOTP_IDLE;
 
 	spin_lock(&isotp_notifier_lock);
@@ -1087,21 +1172,27 @@ static int isotp_release(struct socket *
 	lock_sock(sk);
 
 	/* remove current filters & unregister */
-	if (so->bound && (!(so->opt.flags & CAN_ISOTP_SF_BROADCAST))) {
+	if (so->bound) {
 		if (so->ifindex) {
 			struct net_device *dev;
 
 			dev = dev_get_by_index(net, so->ifindex);
 			if (dev) {
-				can_rx_unregister(net, dev, so->rxid,
-						  SINGLE_MASK(so->rxid),
-						  isotp_rcv, sk);
+				if (isotp_register_rxid(so))
+					can_rx_unregister(net, dev, so->rxid,
+							  SINGLE_MASK(so->rxid),
+							  isotp_rcv, sk);
+
+				can_rx_unregister(net, dev, so->txid,
+						  SINGLE_MASK(so->txid),
+						  isotp_rcv_echo, sk);
 				dev_put(dev);
 				synchronize_rcu();
 			}
 		}
 	}
 
+	hrtimer_cancel(&so->txfrtimer);
 	hrtimer_cancel(&so->txtimer);
 	hrtimer_cancel(&so->rxtimer);
 
@@ -1128,7 +1219,6 @@ static int isotp_bind(struct socket *soc
 	canid_t tx_id, rx_id;
 	int err = 0;
 	int notify_enetdown = 0;
-	int do_rx_reg = 1;
 
 	if (len < ISOTP_MIN_NAMELEN)
 		return -EINVAL;
@@ -1164,12 +1254,8 @@ static int isotp_bind(struct socket *soc
 		goto out;
 	}
 
-	/* do not register frame reception for functional addressing */
-	if (so->opt.flags & CAN_ISOTP_SF_BROADCAST)
-		do_rx_reg = 0;
-
-	/* do not validate rx address for functional addressing */
-	if (do_rx_reg && rx_id == tx_id) {
+	/* ensure different CAN IDs when the rx_id is to be registered */
+	if (isotp_register_rxid(so) && rx_id == tx_id) {
 		err = -EADDRNOTAVAIL;
 		goto out;
 	}
@@ -1194,10 +1280,17 @@ static int isotp_bind(struct socket *soc
 
 	ifindex = dev->ifindex;
 
-	if (do_rx_reg)
+	if (isotp_register_rxid(so))
 		can_rx_register(net, dev, rx_id, SINGLE_MASK(rx_id),
 				isotp_rcv, sk, "isotp", sk);
 
+	/* no consecutive frame echo skb in flight */
+	so->cfecho = 0;
+
+	/* register for echo skb's */
+	can_rx_register(net, dev, tx_id, SINGLE_MASK(tx_id),
+			isotp_rcv_echo, sk, "isotpe", sk);
+
 	dev_put(dev);
 
 	/* switch to new settings */
@@ -1258,6 +1351,15 @@ static int isotp_setsockopt_locked(struc
 		if (!(so->opt.flags & CAN_ISOTP_RX_EXT_ADDR))
 			so->opt.rx_ext_address = so->opt.ext_address;
 
+		/* these broadcast flags are not allowed together */
+		if (isotp_bc_flags(so) == ISOTP_ALL_BC_FLAGS) {
+			/* CAN_ISOTP_SF_BROADCAST is prioritized */
+			so->opt.flags &= ~CAN_ISOTP_CF_BROADCAST;
+
+			/* give user feedback on wrong config attempt */
+			ret = -EINVAL;
+		}
+
 		/* check for frame_txtime changes (0 => no changes) */
 		if (so->opt.frame_txtime) {
 			if (so->opt.frame_txtime == CAN_ISOTP_FRAME_TXTIME_ZERO)
@@ -1408,10 +1510,16 @@ static void isotp_notify(struct isotp_so
 	case NETDEV_UNREGISTER:
 		lock_sock(sk);
 		/* remove current filters & unregister */
-		if (so->bound && (!(so->opt.flags & CAN_ISOTP_SF_BROADCAST)))
-			can_rx_unregister(dev_net(dev), dev, so->rxid,
-					  SINGLE_MASK(so->rxid),
-					  isotp_rcv, sk);
+		if (so->bound) {
+			if (isotp_register_rxid(so))
+				can_rx_unregister(dev_net(dev), dev, so->rxid,
+						  SINGLE_MASK(so->rxid),
+						  isotp_rcv, sk);
+
+			can_rx_unregister(dev_net(dev), dev, so->txid,
+					  SINGLE_MASK(so->txid),
+					  isotp_rcv_echo, sk);
+		}
 
 		so->ifindex = 0;
 		so->bound  = 0;
@@ -1484,6 +1592,8 @@ static int isotp_init(struct sock *sk)
 	so->rxtimer.function = isotp_rx_timer_handler;
 	hrtimer_init(&so->txtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
 	so->txtimer.function = isotp_tx_timer_handler;
+	hrtimer_init(&so->txfrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
+	so->txfrtimer.function = isotp_txfr_timer_handler;
 
 	init_waitqueue_head(&so->wait);
 	spin_lock_init(&so->rx_lock);


