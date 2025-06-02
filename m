Return-Path: <stable+bounces-150222-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D6B2ACB6EE
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 17:22:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 332454A2498
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 15:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED89F22CBEC;
	Mon,  2 Jun 2025 15:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CZajKyxP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D5322D4D7;
	Mon,  2 Jun 2025 15:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748876431; cv=none; b=mzNnKfuI2daK/Z8u62zXmAMhu/8VgI8CKvGOdiyOvTo1RalQ/Il80TBhSAKyaffu8LABwIptezz9upCJLY9r/QQJgJRIDbxJslocJf/GSFgTw9FtxaERSwcAxsziNnU4EqJMuCK66iZz/HeXqQkeFFtAOEejSaSsk3T2z0u3+vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748876431; c=relaxed/simple;
	bh=Oa9knbMYmrQAZ48tOEbE4G5xQLSOn4TKE2Pab0AHpNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IluxJBzpKMXg5+YJBhaAsTRNcVqlsFRGrLv9z5KFDhlPT9CgxC9M0Lqcs9W34gCnOCi+BYyCwJmn6BV1Tu8taPywKgWsGB9liiUgbfJzEvynk4zEXbQOD6xOT/iDtj0kVoRzg9M1LhSP1WEltGNapvDq9O+Q1Ep4FhskeSorufI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CZajKyxP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4B6FC4CEEE;
	Mon,  2 Jun 2025 15:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748876431;
	bh=Oa9knbMYmrQAZ48tOEbE4G5xQLSOn4TKE2Pab0AHpNk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CZajKyxPI/80BLUtKxu0YXRMycrNFc3IGDj08k3M56bZf6iTuUDCIyMrrPOTPNtjz
	 CUPIzU9zMkaKJ1rleTxnznfHxvDnYrx5F9/LDMwpS/oc2NmeSo+PeTeQzSgrYcv6af
	 yI+/a2Zuby3gzT5U8h1GsI2yHKpaBXZwVE1m3r5o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Anderson Nascimento <anderson@allelesecurity.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH 5.15 172/207] can: bcm: add locking for bcm_op runtime updates
Date: Mon,  2 Jun 2025 15:49:04 +0200
Message-ID: <20250602134305.485473424@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602134258.769974467@linuxfoundation.org>
References: <20250602134258.769974467@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Oliver Hartkopp <socketcan@hartkopp.net>

commit c2aba69d0c36a496ab4f2e81e9c2b271f2693fd7 upstream.

The CAN broadcast manager (CAN BCM) can send a sequence of CAN frames via
hrtimer. The content and also the length of the sequence can be changed
resp reduced at runtime where the 'currframe' counter is then set to zero.

Although this appeared to be a safe operation the updates of 'currframe'
can be triggered from user space and hrtimer context in bcm_can_tx().
Anderson Nascimento created a proof of concept that triggered a KASAN
slab-out-of-bounds read access which can be prevented with a spin_lock_bh.

At the rework of bcm_can_tx() the 'count' variable has been moved into
the protected section as this variable can be modified from both contexts
too.

Fixes: ffd980f976e7 ("[CAN]: Add broadcast manager (bcm) protocol")
Reported-by: Anderson Nascimento <anderson@allelesecurity.com>
Tested-by: Anderson Nascimento <anderson@allelesecurity.com>
Reviewed-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Link: https://patch.msgid.link/20250519125027.11900-1-socketcan@hartkopp.net
Cc: stable@vger.kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/can/bcm.c |   66 +++++++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 45 insertions(+), 21 deletions(-)

--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -58,6 +58,7 @@
 #include <linux/can/skb.h>
 #include <linux/can/bcm.h>
 #include <linux/slab.h>
+#include <linux/spinlock.h>
 #include <net/sock.h>
 #include <net/net_namespace.h>
 
@@ -120,6 +121,7 @@ struct bcm_op {
 	struct canfd_frame last_sframe;
 	struct sock *sk;
 	struct net_device *rx_reg_dev;
+	spinlock_t bcm_tx_lock; /* protect currframe/count in runtime updates */
 };
 
 struct bcm_sock {
@@ -273,13 +275,18 @@ static void bcm_can_tx(struct bcm_op *op
 {
 	struct sk_buff *skb;
 	struct net_device *dev;
-	struct canfd_frame *cf = op->frames + op->cfsiz * op->currframe;
+	struct canfd_frame *cf;
 	int err;
 
 	/* no target device? => exit */
 	if (!op->ifindex)
 		return;
 
+	/* read currframe under lock protection */
+	spin_lock_bh(&op->bcm_tx_lock);
+	cf = op->frames + op->cfsiz * op->currframe;
+	spin_unlock_bh(&op->bcm_tx_lock);
+
 	dev = dev_get_by_index(sock_net(op->sk), op->ifindex);
 	if (!dev) {
 		/* RFC: should this bcm_op remove itself here? */
@@ -300,6 +307,10 @@ static void bcm_can_tx(struct bcm_op *op
 	skb->dev = dev;
 	can_skb_set_owner(skb, op->sk);
 	err = can_send(skb, 1);
+
+	/* update currframe and count under lock protection */
+	spin_lock_bh(&op->bcm_tx_lock);
+
 	if (!err)
 		op->frames_abs++;
 
@@ -308,6 +319,11 @@ static void bcm_can_tx(struct bcm_op *op
 	/* reached last frame? */
 	if (op->currframe >= op->nframes)
 		op->currframe = 0;
+
+	if (op->count > 0)
+		op->count--;
+
+	spin_unlock_bh(&op->bcm_tx_lock);
 out:
 	dev_put(dev);
 }
@@ -404,7 +420,7 @@ static enum hrtimer_restart bcm_tx_timeo
 	struct bcm_msg_head msg_head;
 
 	if (op->kt_ival1 && (op->count > 0)) {
-		op->count--;
+		bcm_can_tx(op);
 		if (!op->count && (op->flags & TX_COUNTEVT)) {
 
 			/* create notification to user */
@@ -419,7 +435,6 @@ static enum hrtimer_restart bcm_tx_timeo
 
 			bcm_send_to_user(op, &msg_head, NULL, 0);
 		}
-		bcm_can_tx(op);
 
 	} else if (op->kt_ival2) {
 		bcm_can_tx(op);
@@ -909,6 +924,27 @@ static int bcm_tx_setup(struct bcm_msg_h
 		}
 		op->flags = msg_head->flags;
 
+		/* only lock for unlikely count/nframes/currframe changes */
+		if (op->nframes != msg_head->nframes ||
+		    op->flags & TX_RESET_MULTI_IDX ||
+		    op->flags & SETTIMER) {
+
+			spin_lock_bh(&op->bcm_tx_lock);
+
+			if (op->nframes != msg_head->nframes ||
+			    op->flags & TX_RESET_MULTI_IDX) {
+				/* potentially update changed nframes */
+				op->nframes = msg_head->nframes;
+				/* restart multiple frame transmission */
+				op->currframe = 0;
+			}
+
+			if (op->flags & SETTIMER)
+				op->count = msg_head->count;
+
+			spin_unlock_bh(&op->bcm_tx_lock);
+		}
+
 	} else {
 		/* insert new BCM operation for the given can_id */
 
@@ -916,9 +952,14 @@ static int bcm_tx_setup(struct bcm_msg_h
 		if (!op)
 			return -ENOMEM;
 
+		spin_lock_init(&op->bcm_tx_lock);
 		op->can_id = msg_head->can_id;
 		op->cfsiz = CFSIZ(msg_head->flags);
 		op->flags = msg_head->flags;
+		op->nframes = msg_head->nframes;
+
+		if (op->flags & SETTIMER)
+			op->count = msg_head->count;
 
 		/* create array for CAN frames and copy the data */
 		if (msg_head->nframes > 1) {
@@ -977,22 +1018,8 @@ static int bcm_tx_setup(struct bcm_msg_h
 
 	} /* if ((op = bcm_find_op(&bo->tx_ops, msg_head->can_id, ifindex))) */
 
-	if (op->nframes != msg_head->nframes) {
-		op->nframes   = msg_head->nframes;
-		/* start multiple frame transmission with index 0 */
-		op->currframe = 0;
-	}
-
-	/* check flags */
-
-	if (op->flags & TX_RESET_MULTI_IDX) {
-		/* start multiple frame transmission with index 0 */
-		op->currframe = 0;
-	}
-
 	if (op->flags & SETTIMER) {
 		/* set timer values */
-		op->count = msg_head->count;
 		op->ival1 = msg_head->ival1;
 		op->ival2 = msg_head->ival2;
 		op->kt_ival1 = bcm_timeval_to_ktime(msg_head->ival1);
@@ -1009,11 +1036,8 @@ static int bcm_tx_setup(struct bcm_msg_h
 		op->flags |= TX_ANNOUNCE;
 	}
 
-	if (op->flags & TX_ANNOUNCE) {
+	if (op->flags & TX_ANNOUNCE)
 		bcm_can_tx(op);
-		if (op->count)
-			op->count--;
-	}
 
 	if (op->flags & STARTTIMER)
 		bcm_tx_start_timer(op);



