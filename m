Return-Path: <stable+bounces-43689-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E778E8C435F
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 16:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50DC4B20BE8
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 14:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD2FB1848;
	Mon, 13 May 2024 14:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=rwahl@gmx.de header.b="FP5RlYOg"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC4B17F0;
	Mon, 13 May 2024 14:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715611193; cv=none; b=N7Thc1GG2y4PGBF4D82Mo1wprRVYMK7ZbybPRorznpS547QrDMU/RW9D2U0ITyymikjoDDR7Bja0Pckz8a+WPrLGvZOo40JJC4dJL6I3L34vlgE85AmxG4V19wRdTDCmkW72caRzGBoKdyTc4feco0+CSLHpfMizxzyRUV8DWDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715611193; c=relaxed/simple;
	bh=nBZcZltCZOCCgCCz9X3U6IvAol9wgYdcC2MRlSfWNj4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ejBeQd7IIk/cjw0U+1JHGZOIW/zQk1nkrm/TtaXEDQto/GnuBV8E56ZFRDMjw7k1zXy3V5hI0i4Hsn4L/1/1vZdA6OiQU/MyJ/yVDQjfWkXvBha+LVsrZJuL7Ve4rvUyhtZAPF8Ptb1IXnX8RzDR5pc1Cgv9rUZ00nZrG+B+iKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=rwahl@gmx.de header.b=FP5RlYOg; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1715611167; x=1716215967; i=rwahl@gmx.de;
	bh=WCImdjPm9LvjalrqDqycwUi4gWN9eNIaTR2r5ILNxqA=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=FP5RlYOgV4nTPr+ta3Q6EbyPtYAcLeEXFrViVdF4GnP1hGFtG6lGI4Cp6fAzLAav
	 ZUxisHhfdVr9/x38xDICIO3qsAojcrlAjiSWUGw8QXY1mSpAWefzy93eUNTpvVDVc
	 ktN71R+Yx+yQtfGLI6pKywtndHdJSdfYcZKimMMdryZMR7ZuuipDsOOnSXKj3t+5J
	 dF91/K/jxnTOnlSI5TItJjDZRB+gRgvNsHmmRRZskSJ76zyJ9HmlO8kE9P4/Mu6YP
	 n48UHdyf/gcOM/m8pXpeXXxOwoGncDGFqkR+in8fU6yXPWxPRg97cQwoTlPUJHu6U
	 N8sn1kIqoClaFkxA0g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from rohan.localdomain ([84.156.159.24]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MryT9-1suPz00yeL-00nxSY; Mon, 13
 May 2024 16:39:27 +0200
From: Ronald Wahl <rwahl@gmx.de>
To: Ronald Wahl <rwahl@gmx.de>
Cc: Ronald Wahl <ronald.wahl@raritan.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] net: ks8851: Fix another TX stall caused by wrong ISR flag handling
Date: Mon, 13 May 2024 16:39:22 +0200
Message-ID: <20240513143922.1330122-1-rwahl@gmx.de>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:V/8xv8BKRPLWuIfHGHa0+ngDPh6HhmfG0BbstvqlzzoWWh0LzzO
 J84huiEM6LJHHBIf/nyikhyw9huCyucjkxElO1JezBTbf4aWdfCI58xSGRtK3JFuQj0IW5D
 +/sg4yiKtWTZw2biI8tEl3PjquPprnTmsgmRJNsm6+N8SU8fOErISGxXAxCdn1bVQ0xu0OI
 x3NY1WnlZQ5vFADSuAPZg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:8WeweyECWII=;jcWaY0mCcksn0j2ds+gE9bzXBTr
 KDPGSXUlP/JvhUisQ87I7Nz+2JbJUT9YjMn57bq/f1XAxRDz7O45KIMaM1vAnP1LG8vfmVe47
 K35sSnx//f5ySUflcMh78oz0avXMCR5Fdcpu5vFrnbautH3ybgGy8rjpv3EbRl+6sq8qb1vNJ
 md/u89w/AzKPClk7SQDNnAd/aQ0xtc9NPia5ZOPNIiqmJIjmC8R6PkZquWE+9G2sUnx578hwZ
 L4BwNSpLdqxXE7mojtUeUfXDe7T6jIz456vJSih3eh4uMFgdMT5tlGWE9EAAVcraT3Oaiw9TD
 0SB71lv70os6GwtxiOHOs8zb7Jx+Xci9Uc+hS5B8/vmA3aObLj/1bAoiXcDwJiknghZta6+U3
 tAtzQNfAqoI7GJL44DTv52/UKtM5X14PLIcpRVWi7pDMJeUbVNC7JuiV7Bx/CRvTn8RCkPVr/
 xfYJaGX4Jgy5xlkTJH6okwAML+xYzd3poL4UyHUfJNDu7Yonp9Uu/r0RuZHlX5gpDAmD4OQSe
 K6u2meJMFk2qVirSJLhW02Yar1tnQLuojiS3+wMJ0KKOkTDjmEcjR7QY82ItqzToBflO+xuQv
 K9b0qCUWybjz/vX3tAQbOzPdrgUZzRMfOX1BHirsz0Q6rkHp4GBcnMelDcYdGzZMsCmlLB/Zl
 AnZ2LV/s7LAY3khFdIFFkTIqsD9twTvVAS4oMcibYH+GkJr6ujwh0mdLoP7oB2GSYyIUTqbrE
 4TdxSWHdeRZDy8IjTLmIcNCsg+z7CzX1dPhj0bqRoT1Xs6FQVqY9t2W5tZDYij/IJ0PsUDt/i
 y61UUe3roo6BOGt40/I53ylETBRyJbL7Nwb93yVlonjTI=

From: Ronald Wahl <ronald.wahl@raritan.com>

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

Fixes: 3dc5d4454545 ("net: ks8851: Fix TX stall caused by TX buffer overru=
n")
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org
Cc: stable@vger.kernel.org # 5.10+
Signed-off-by: Ronald Wahl <ronald.wahl@raritan.com>
=2D--
 drivers/net/ethernet/micrel/ks8851_common.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/micrel/ks8851_common.c b/drivers/net/eth=
ernet/micrel/ks8851_common.c
index 502518cdb461..6453c92f0fa7 100644
=2D-- a/drivers/net/ethernet/micrel/ks8851_common.c
+++ b/drivers/net/ethernet/micrel/ks8851_common.c
@@ -328,7 +328,6 @@ static irqreturn_t ks8851_irq(int irq, void *_ks)
 {
 	struct ks8851_net *ks =3D _ks;
 	struct sk_buff_head rxq;
-	unsigned handled =3D 0;
 	unsigned long flags;
 	unsigned int status;
 	struct sk_buff *skb;
@@ -336,24 +335,17 @@ static irqreturn_t ks8851_irq(int irq, void *_ks)
 	ks8851_lock(ks, &flags);

 	status =3D ks8851_rdreg16(ks, KS_ISR);
+	ks8851_wrreg16(ks, KS_ISR, status);

 	netif_dbg(ks, intr, ks->netdev,
 		  "%s: status 0x%04x\n", __func__, status);

-	if (status & IRQ_LCI)
-		handled |=3D IRQ_LCI;
-
 	if (status & IRQ_LDI) {
 		u16 pmecr =3D ks8851_rdreg16(ks, KS_PMECR);
 		pmecr &=3D ~PMECR_WKEVT_MASK;
 		ks8851_wrreg16(ks, KS_PMECR, pmecr | PMECR_WKEVT_LINK);
-
-		handled |=3D IRQ_LDI;
 	}

-	if (status & IRQ_RXPSI)
-		handled |=3D IRQ_RXPSI;
-
 	if (status & IRQ_TXI) {
 		unsigned short tx_space =3D ks8851_rdreg16(ks, KS_TXMIR);

@@ -365,20 +357,12 @@ static irqreturn_t ks8851_irq(int irq, void *_ks)
 		if (netif_queue_stopped(ks->netdev))
 			netif_wake_queue(ks->netdev);
 		spin_unlock(&ks->statelock);
-
-		handled |=3D IRQ_TXI;
 	}

-	if (status & IRQ_RXI)
-		handled |=3D IRQ_RXI;
-
 	if (status & IRQ_SPIBEI) {
 		netdev_err(ks->netdev, "%s: spi bus error\n", __func__);
-		handled |=3D IRQ_SPIBEI;
 	}

-	ks8851_wrreg16(ks, KS_ISR, handled);
-
 	if (status & IRQ_RXI) {
 		/* the datasheet says to disable the rx interrupt during
 		 * packet read-out, however we're masking the interrupt
=2D-
2.45.0


