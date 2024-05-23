Return-Path: <stable+bounces-45843-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD2F8CD429
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 15:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DA60B22A78
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 13:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2D314B06E;
	Thu, 23 May 2024 13:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1DiIk+qm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3831F13C3D8;
	Thu, 23 May 2024 13:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716470521; cv=none; b=VNd50DoXktzlfFfFe4dyrpTvmTKTnV8+35qA2j98UAOSXZTehSoRn+ujEFyoEvMFk/a3ZLQUX8yoIXlzS4jVvQLxm1JXsN+y4TY0KP9fi997O/7omgpTG/AsXRcRuv+gFVYot4Iv632LH/C1ZfTVft87tjdKd4F9il3ya1ee4Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716470521; c=relaxed/simple;
	bh=Kj9mnkguZksjRUd8X+oukDSd1TeuQkq1vL8/hhgSwrA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d2CyzgcLtLJiTbbP/w3Uzyxz6vps5dkXPS295IRzEbTAfuuciZ5GxfYww0F8Xj5WRKOUu/Sg5CE6f5jV2/TnyHMU8R24HeIi9wjjwpHM8bJ3FPhfatm7tlZim90+i0fODyf72Sb2TREy21vaXhX5HsqDL74ZjZmcltUJ6kbasSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1DiIk+qm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B766DC32781;
	Thu, 23 May 2024 13:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716470521;
	bh=Kj9mnkguZksjRUd8X+oukDSd1TeuQkq1vL8/hhgSwrA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1DiIk+qmOR3OVhWQfuRbIJ7qVRMEgDKneLJS9VNPU6J8YXiWx+ZlSiH6IUv2gTyfN
	 26rLoP7xG7YzZkIXG5VW8mT2dWelfxbvS5BR1pfU8PXWeuSEQtWJFjKrR3QHh3+nC7
	 2+ys4bKD56/bR8lOWx+S1pmGseF1BsXqaV6oY4bw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	Ronald Wahl <ronald.wahl@raritan.com>
Subject: [PATCH 6.8 02/23] net: ks8851: Fix another TX stall caused by wrong ISR flag handling
Date: Thu, 23 May 2024 15:13:29 +0200
Message-ID: <20240523130329.840598598@linuxfoundation.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240523130329.745905823@linuxfoundation.org>
References: <20240523130329.745905823@linuxfoundation.org>
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

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ronald Wahl <ronald.wahl@raritan.com>

commit 317a215d493230da361028ea8a4675de334bfa1a upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/micrel/ks8851_common.c |   18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

--- a/drivers/net/ethernet/micrel/ks8851_common.c
+++ b/drivers/net/ethernet/micrel/ks8851_common.c
@@ -328,7 +328,6 @@ static irqreturn_t ks8851_irq(int irq, v
 {
 	struct ks8851_net *ks = _ks;
 	struct sk_buff_head rxq;
-	unsigned handled = 0;
 	unsigned long flags;
 	unsigned int status;
 	struct sk_buff *skb;
@@ -336,24 +335,17 @@ static irqreturn_t ks8851_irq(int irq, v
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
 
@@ -365,20 +357,12 @@ static irqreturn_t ks8851_irq(int irq, v
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



