Return-Path: <stable+bounces-101407-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B52C19EEC43
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 16:33:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3564F169FAD
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 15:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD912185A0;
	Thu, 12 Dec 2024 15:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tEysucQ5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB5E217707;
	Thu, 12 Dec 2024 15:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734017444; cv=none; b=lMM4JTpNiMOJZKTU8BUqfvzOQ1QME1/gJYJKYAl/a6W1K5mdZlMOltt/c1EKURgn5h+fu1fKtqQ3kA7XdHOHceRPUZYzQ1p6y/V9DR6QLsueJvfOFzPQ5UE0yb9l5/leLqRdWYR7d/4sAIf97LaAzJvD7ysEwp26843HqPDzcIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734017444; c=relaxed/simple;
	bh=7npvb1wlaNZHOR7TarpoeURaYJew7mnwWPKFjbYK4Ho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d+yOc1SK8FcTb8IjqXAAtP5hh7OtQcB8Kmhb9IBVO2vHaEhB/31AHIuoE9sdJR2A1h/pedmA/R0gSgpMK/U3sp/N8fe+oL9d9sNOVBWqtzUIa83ybh0ypUM7c4ba57PUddO1UT81l1iL+CIfelGdsH3x8OVwVo0qSaXab9Ds8EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tEysucQ5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03761C4CECE;
	Thu, 12 Dec 2024 15:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734017444;
	bh=7npvb1wlaNZHOR7TarpoeURaYJew7mnwWPKFjbYK4Ho=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tEysucQ56zciPmvGvyQcCmMW0QMEPiOsLVHHedW2mmu6ywctnJbjcAph74g0aB4nb
	 QPiGVkAa/e2DpH0R8SC88kKtnYgklEiqNoRvdmHvMVrT272ZiJ3hIRHKTWsWqjUC2s
	 L0Ac65KTI4UZuso5rnajHoojeYE3DJR56E+ToJnw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 015/356] can: ems_usb: ems_usb_rx_err(): fix {rx,tx}_errors statistics
Date: Thu, 12 Dec 2024 15:55:34 +0100
Message-ID: <20241212144245.223728164@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144244.601729511@linuxfoundation.org>
References: <20241212144244.601729511@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dario Binacchi <dario.binacchi@amarulasolutions.com>

[ Upstream commit 72a7e2e74b3075959f05e622bae09b115957dffe ]

The ems_usb_rx_err() function only incremented the receive error counter
and never the transmit error counter, even if the ECC_DIR flag reported
that an error had occurred during transmission.

Increment the receive/transmit error counter based on the value of the
ECC_DIR flag.

Fixes: 702171adeed3 ("ems_usb: Added support for EMS CPC-USB/ARM7 CAN/USB interface")
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Link: https://patch.msgid.link/20241122221650.633981-12-dario.binacchi@amarulasolutions.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/can/usb/ems_usb.c | 58 ++++++++++++++++++++---------------
 1 file changed, 33 insertions(+), 25 deletions(-)

diff --git a/drivers/net/can/usb/ems_usb.c b/drivers/net/can/usb/ems_usb.c
index 050c0b49938a4..5355bac4dccbe 100644
--- a/drivers/net/can/usb/ems_usb.c
+++ b/drivers/net/can/usb/ems_usb.c
@@ -335,15 +335,14 @@ static void ems_usb_rx_err(struct ems_usb *dev, struct ems_cpc_msg *msg)
 	struct net_device_stats *stats = &dev->netdev->stats;
 
 	skb = alloc_can_err_skb(dev->netdev, &cf);
-	if (skb == NULL)
-		return;
 
 	if (msg->type == CPC_MSG_TYPE_CAN_STATE) {
 		u8 state = msg->msg.can_state;
 
 		if (state & SJA1000_SR_BS) {
 			dev->can.state = CAN_STATE_BUS_OFF;
-			cf->can_id |= CAN_ERR_BUSOFF;
+			if (skb)
+				cf->can_id |= CAN_ERR_BUSOFF;
 
 			dev->can.can_stats.bus_off++;
 			can_bus_off(dev->netdev);
@@ -361,44 +360,53 @@ static void ems_usb_rx_err(struct ems_usb *dev, struct ems_cpc_msg *msg)
 
 		/* bus error interrupt */
 		dev->can.can_stats.bus_error++;
-		stats->rx_errors++;
 
-		cf->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR;
+		if (skb) {
+			cf->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR;
 
-		switch (ecc & SJA1000_ECC_MASK) {
-		case SJA1000_ECC_BIT:
-			cf->data[2] |= CAN_ERR_PROT_BIT;
-			break;
-		case SJA1000_ECC_FORM:
-			cf->data[2] |= CAN_ERR_PROT_FORM;
-			break;
-		case SJA1000_ECC_STUFF:
-			cf->data[2] |= CAN_ERR_PROT_STUFF;
-			break;
-		default:
-			cf->data[3] = ecc & SJA1000_ECC_SEG;
-			break;
+			switch (ecc & SJA1000_ECC_MASK) {
+			case SJA1000_ECC_BIT:
+				cf->data[2] |= CAN_ERR_PROT_BIT;
+				break;
+			case SJA1000_ECC_FORM:
+				cf->data[2] |= CAN_ERR_PROT_FORM;
+				break;
+			case SJA1000_ECC_STUFF:
+				cf->data[2] |= CAN_ERR_PROT_STUFF;
+				break;
+			default:
+				cf->data[3] = ecc & SJA1000_ECC_SEG;
+				break;
+			}
 		}
 
 		/* Error occurred during transmission? */
-		if ((ecc & SJA1000_ECC_DIR) == 0)
-			cf->data[2] |= CAN_ERR_PROT_TX;
+		if ((ecc & SJA1000_ECC_DIR) == 0) {
+			stats->tx_errors++;
+			if (skb)
+				cf->data[2] |= CAN_ERR_PROT_TX;
+		} else {
+			stats->rx_errors++;
+		}
 
-		if (dev->can.state == CAN_STATE_ERROR_WARNING ||
-		    dev->can.state == CAN_STATE_ERROR_PASSIVE) {
+		if (skb && (dev->can.state == CAN_STATE_ERROR_WARNING ||
+			    dev->can.state == CAN_STATE_ERROR_PASSIVE)) {
 			cf->can_id |= CAN_ERR_CRTL;
 			cf->data[1] = (txerr > rxerr) ?
 			    CAN_ERR_CRTL_TX_PASSIVE : CAN_ERR_CRTL_RX_PASSIVE;
 		}
 	} else if (msg->type == CPC_MSG_TYPE_OVERRUN) {
-		cf->can_id |= CAN_ERR_CRTL;
-		cf->data[1] = CAN_ERR_CRTL_RX_OVERFLOW;
+		if (skb) {
+			cf->can_id |= CAN_ERR_CRTL;
+			cf->data[1] = CAN_ERR_CRTL_RX_OVERFLOW;
+		}
 
 		stats->rx_over_errors++;
 		stats->rx_errors++;
 	}
 
-	netif_rx(skb);
+	if (skb)
+		netif_rx(skb);
 }
 
 /*
-- 
2.43.0




