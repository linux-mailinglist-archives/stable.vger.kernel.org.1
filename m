Return-Path: <stable+bounces-45580-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2778CC3EA
	for <lists+stable@lfdr.de>; Wed, 22 May 2024 17:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6556E1F2166F
	for <lists+stable@lfdr.de>; Wed, 22 May 2024 15:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22BB224B2A;
	Wed, 22 May 2024 15:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fhsGe28F"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D497F25755
	for <stable@vger.kernel.org>; Wed, 22 May 2024 15:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716390807; cv=none; b=Q7BjMgb3x6X430lzAzUjT/L4CLqEIWvFZ0lwLG93kt78J5AodOnMGJD5BA1bD6M0M8VgaK3ByuqhswhH2bO3l57etZ8oYL9M1ckcdtZY1qIFQOLia0FHtJFtYLhKF4Boq+kInn6IysVQPsDAnRq2lA+FuVx/nJeY8kXrkVu21r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716390807; c=relaxed/simple;
	bh=ev7OPdtw+ncSK21uW3x6TzO48KphEF1xGua/oag92Lo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=sPyzJ8uTO33DB7pWskmMmHcvVD+hm4MZUCgy7siVD9xxwqgzCsLEzjdyCCE5J9w0ub+MZdNsOv2ZguMAg8dqDGyJv+sz2f/bia6+ZC1scXP6KxL42oJOuybXzimUt+uE07zR9VKjaOmqfcrW0whed0ZnwGg4IFdKAmwmt6tECcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fhsGe28F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57B2CC2BBFC;
	Wed, 22 May 2024 15:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716390807;
	bh=ev7OPdtw+ncSK21uW3x6TzO48KphEF1xGua/oag92Lo=;
	h=Subject:To:Cc:From:Date:From;
	b=fhsGe28FSTynPgmnbfwhFJyyCqTjIzbneISsc6/ENi6c+6hQdGwXnfF6g4V0AcX1q
	 7xjh8NBuz0mwLukxLC3W2Xg7h9bNDPewTvf2qKr2SuoTGXWRWQqyu98uNpqKv96Q78
	 WrbdL35GZ/EbfCQ34NsmXZvd7fem8d58qVwaRR9k=
Subject: FAILED: patch "[PATCH] net: ks8851: Fix another TX stall caused by wrong ISR flag" failed to apply to 5.15-stable tree
To: ronald.wahl@raritan.com,davem@davemloft.net,edumazet@google.com,horms@kernel.org,kuba@kernel.org,pabeni@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 22 May 2024 17:13:16 +0200
Message-ID: <2024052216-jaws-pester-a65d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 317a215d4932
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024052216-jaws-pester-a65d@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 317a215d493230da361028ea8a4675de334bfa1a Mon Sep 17 00:00:00 2001
From: Ronald Wahl <ronald.wahl@raritan.com>
Date: Mon, 13 May 2024 16:39:22 +0200
Subject: [PATCH] net: ks8851: Fix another TX stall caused by wrong ISR flag
 handling

Under some circumstances it may happen that the ks8851 Ethernet driver
stops sending data.

Currently the interrupt handler resets the interrupt status flags in the
hardware after handling TX. With this approach we may lose interrupts in
the time window between handling the TX interrupt and resetting the TX
interrupt status bit.

When all of the three following conditions are true then transmitting
data stops:

  - TX queue is stopped to wait for room in the hardware TX buffer
  - no queued SKBs in the driver (txq) that wait for being written to hw
  - hardware TX buffer is empty and the last TX interrupt was lost

This is because reenabling the TX queue happens when handling the TX
interrupt status but if the TX status bit has already been cleared then
this interrupt will never come.

With this commit the interrupt status flags will be cleared before they
are handled. That way we stop losing interrupts.

The wrong handling of the ISR flags was there from the beginning but
with commit 3dc5d4454545 ("net: ks8851: Fix TX stall caused by TX
buffer overrun") the issue becomes apparent.

Fixes: 3dc5d4454545 ("net: ks8851: Fix TX stall caused by TX buffer overrun")
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org
Cc: stable@vger.kernel.org # 5.10+
Signed-off-by: Ronald Wahl <ronald.wahl@raritan.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/drivers/net/ethernet/micrel/ks8851_common.c b/drivers/net/ethernet/micrel/ks8851_common.c
index 502518cdb461..6453c92f0fa7 100644
--- a/drivers/net/ethernet/micrel/ks8851_common.c
+++ b/drivers/net/ethernet/micrel/ks8851_common.c
@@ -328,7 +328,6 @@ static irqreturn_t ks8851_irq(int irq, void *_ks)
 {
 	struct ks8851_net *ks = _ks;
 	struct sk_buff_head rxq;
-	unsigned handled = 0;
 	unsigned long flags;
 	unsigned int status;
 	struct sk_buff *skb;
@@ -336,24 +335,17 @@ static irqreturn_t ks8851_irq(int irq, void *_ks)
 	ks8851_lock(ks, &flags);
 
 	status = ks8851_rdreg16(ks, KS_ISR);
+	ks8851_wrreg16(ks, KS_ISR, status);
 
 	netif_dbg(ks, intr, ks->netdev,
 		  "%s: status 0x%04x\n", __func__, status);
 
-	if (status & IRQ_LCI)
-		handled |= IRQ_LCI;
-
 	if (status & IRQ_LDI) {
 		u16 pmecr = ks8851_rdreg16(ks, KS_PMECR);
 		pmecr &= ~PMECR_WKEVT_MASK;
 		ks8851_wrreg16(ks, KS_PMECR, pmecr | PMECR_WKEVT_LINK);
-
-		handled |= IRQ_LDI;
 	}
 
-	if (status & IRQ_RXPSI)
-		handled |= IRQ_RXPSI;
-
 	if (status & IRQ_TXI) {
 		unsigned short tx_space = ks8851_rdreg16(ks, KS_TXMIR);
 
@@ -365,20 +357,12 @@ static irqreturn_t ks8851_irq(int irq, void *_ks)
 		if (netif_queue_stopped(ks->netdev))
 			netif_wake_queue(ks->netdev);
 		spin_unlock(&ks->statelock);
-
-		handled |= IRQ_TXI;
 	}
 
-	if (status & IRQ_RXI)
-		handled |= IRQ_RXI;
-
 	if (status & IRQ_SPIBEI) {
 		netdev_err(ks->netdev, "%s: spi bus error\n", __func__);
-		handled |= IRQ_SPIBEI;
 	}
 
-	ks8851_wrreg16(ks, KS_ISR, handled);
-
 	if (status & IRQ_RXI) {
 		/* the datasheet says to disable the rx interrupt during
 		 * packet read-out, however we're masking the interrupt


