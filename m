Return-Path: <stable+bounces-45797-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28EEF8CD3F2
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 15:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B15C1C20982
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 13:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2783B14AD3E;
	Thu, 23 May 2024 13:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WxH8wXBq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D487E1E504;
	Thu, 23 May 2024 13:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716470388; cv=none; b=awbzClKDTU1asi/S2gP56Ec+d+TcnraPOCcaVdBJm62F0BHJKQl/6DZsS+SaL8Gl0Rl5TPAlAf+6NgUHUdRECdmHDynP9CU0aWlXoVYrZc8YMPLujCwenlNTtPO6HgEr0O9YZlNu19J58QjJUVR3ssYMLkgIa8HFhbfQj7Qz6hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716470388; c=relaxed/simple;
	bh=R4/lwUxBiUSlMXZuASscL6sbMfKQ47bnjEZHfHREgEo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lSbqYQM3oS8T2ocGClgIEGv1hfFgKUtqkls/0JCTDmbXX6QCOeiSJWA+wLM+B2V0HCGFD8clPz1xJv2VTVbQfGXibq+swCVf6HtzAAsDBzqlghgJCwYe5aaftJomk426Fsevb7FJuCIQfvXuht6ZbY4Z9/dA6C/ITniE8ggic+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WxH8wXBq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B6F8C2BD10;
	Thu, 23 May 2024 13:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716470388;
	bh=R4/lwUxBiUSlMXZuASscL6sbMfKQ47bnjEZHfHREgEo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WxH8wXBqcYpjgMtcGVvHCy/I95h28CdefBkXih4dxuZ1E7bY9guBhhdC2Y3HrPs+Y
	 AvOntxUlThcSfeCyz3k3mNgM+mj8j4HNGAaoRKMKLSUdGarBDPvJ0G+NydG0oXsSlB
	 o4g+iD5rDFqGIoEhw/jfagcbaDCMCSaIdMWQzINw=
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
Subject: [PATCH 6.1 02/45] net: ks8851: Fix another TX stall caused by wrong ISR flag handling
Date: Thu, 23 May 2024 15:12:53 +0200
Message-ID: <20240523130332.588507835@linuxfoundation.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240523130332.496202557@linuxfoundation.org>
References: <20240523130332.496202557@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

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



