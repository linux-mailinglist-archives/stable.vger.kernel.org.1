Return-Path: <stable+bounces-166666-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83812B1BDE8
	for <lists+stable@lfdr.de>; Wed,  6 Aug 2025 02:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54E6B184300
	for <lists+stable@lfdr.de>; Wed,  6 Aug 2025 00:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AFFE145A1F;
	Wed,  6 Aug 2025 00:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gnuweeb.org header.i=@gnuweeb.org header.b="CvzrkSwz"
X-Original-To: stable@vger.kernel.org
Received: from server-vie001.gnuweeb.org (server-vie001.gnuweeb.org [89.58.62.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B969A1E49F;
	Wed,  6 Aug 2025 00:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.62.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754440276; cv=none; b=tHJzmBTfethottoqTpIplsO8oKQUW5TYbF49g0Tdgj2NW6v0CNVCniLgkb58FC9l6yTzCvAdAol5wWD6WYNZGaIVhKXbA2Pu2DVUOrDEjYdPUzIafsr7/m6EYxEuzjdRhLzpuzeWQ+YeZmm836SJn9oBt30/7W2ZFvtzZ0SQN98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754440276; c=relaxed/simple;
	bh=mihGPIF3tSl1RqP6MaT1Lb5zWUmmcthYhUU66yuams8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=C7FdVXOVXNFmLoMi+94jpqIYiFkAgoLt+2QEFyJtuG7YcXmmykLDeup6gSAcwaD1QvyOdd79/hKUZtLxVf2NFRfFg9NtNO50Q+7jpskFIc5AUav2on5ZI3htTr3scui0YYyJT2n4cF7bG7mCh8TXTglk3T2TYxWvdJyZDW4fq7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gnuweeb.org; spf=pass smtp.mailfrom=gnuweeb.org; dkim=pass (2048-bit key) header.d=gnuweeb.org header.i=@gnuweeb.org header.b=CvzrkSwz; arc=none smtp.client-ip=89.58.62.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gnuweeb.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnuweeb.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
	s=new2025; t=1754440272;
	bh=mihGPIF3tSl1RqP6MaT1Lb5zWUmmcthYhUU66yuams8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:
	 Content-Transfer-Encoding:Message-ID:Date:From:Reply-To:Subject:To:
	 Cc:In-Reply-To:References:Resent-Date:Resent-From:Resent-To:
	 Resent-Cc:User-Agent:Content-Type:Content-Transfer-Encoding;
	b=CvzrkSwzubECXmQl/qdFVQMQoxcPmPeR6MJkbiC7npIzSnfwrllrCtdc/2lX1Aoio
	 Yj8E38ldIiBUS7w5lVDP1vs7SBga0iEIYV1Uwbm/9VEOgNi3VJko9xOxLOz72J3np5
	 AwUxXe5DiV23QbJoG0f4XFbrvwA96s4WhDsweXRUsMEDgQ7HbkIhjv7p5Z9Ti3CRsb
	 qS6bb6dmykgz0Gvnv/prJ7UezLIOnumIdIwbBYqpL+uAcW6XbzjCdZkyvfR2LJuDYv
	 UhbHl2FOL3e8KFPPHmM5oKpI0sU5MlRzcUcZvoBT1pgJv5E7O+5e+UMjEvAL1xnjlO
	 86jw/7qmlkh7w==
Received: from integral2.. (unknown [182.253.126.229])
	by server-vie001.gnuweeb.org (Postfix) with ESMTPSA id 393BD3127C24;
	Wed,  6 Aug 2025 00:31:09 +0000 (UTC)
From: Ammar Faizi <ammarfaizi2@gnuweeb.org>
To: Oliver Neukum <oneukum@suse.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Ammar Faizi <ammarfaizi2@gnuweeb.org>,
	Simon Horman <horms@kernel.org>,
	John Ernberg <john.ernberg@actia.se>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linux Netdev Mailing List <netdev@vger.kernel.org>,
	Linux USB Mailing List <linux-usb@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Armando Budianto <sprite@gnuweeb.org>,
	gwml@vger.gnuweeb.org,
	stable@vger.kernel.org
Subject: [PATCH net v3] net: usbnet: Fix the wrong netif_carrier_on() call
X-Gw-Bpl: wU/cy49Bu1yAPm0bW2qiliFUIEVf+EkEatAboK6pk2H2LSy2bfWlPAiP3YIeQ5aElNkQEhTV9Q==
Date: Wed,  6 Aug 2025 07:31:05 +0700
Message-Id: <20250806003105.15172-1-ammarfaizi2@gnuweeb.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The commit referenced in the Fixes tag causes usbnet to malfunction
(identified via git bisect). Post-commit, my external RJ45 LAN cable
fails to connect. Linus also reported the same issue after pulling that
commit.

The code has a logic error: netif_carrier_on() is only called when the
link is already on. Fix this by moving the netif_carrier_on() call
outside the if-statement entirely. This ensures it is always called
when EVENT_LINK_CARRIER_ON is set and properly clears it regardless
of the link state.

Cc: stable@vger.kernel.org
Cc: Armando Budianto <sprite@gnuweeb.org>
Reviewed-by: Simon Horman <horms@kernel.org>
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/all/CAHk-=wjqL4uF0MG_c8+xHX1Vv8==sPYQrtzbdA3kzi96284nuQ@mail.gmail.com
Closes: https://lore.kernel.org/netdev/CAHk-=wjKh8X4PT_mU1kD4GQrbjivMfPn-_hXa6han_BTDcXddw@mail.gmail.com
Closes: https://lore.kernel.org/netdev/0752dee6-43d6-4e1f-81d2-4248142cccd2@gnuweeb.org
Fixes: 0d9cfc9b8cb1 ("net: usbnet: Avoid potential RCU stall on LINK_CHANGE event")
Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
---

v3:
  - Move the netif_carrier_on() call outside of the if-statement
    entirely (Linus).

v2:
  - Rebase on top of the latest netdev/net tree. The previous patch was
    based on 0d9cfc9b8cb1. Line numbers have changed since then.
  Link: https://lore.gnuweeb.org/gwml/20250801190310.58443-1-ammarfaizi2@gnuweeb.org

 drivers/net/usb/usbnet.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
index a38ffbf4b3f0..511c4154cf74 100644
--- a/drivers/net/usb/usbnet.c
+++ b/drivers/net/usb/usbnet.c
@@ -1113,32 +1113,32 @@ static const struct ethtool_ops usbnet_ethtool_ops = {
 	.set_link_ksettings	= usbnet_set_link_ksettings_mii,
 };
 
 /*-------------------------------------------------------------------------*/
 
 static void __handle_link_change(struct usbnet *dev)
 {
 	if (!test_bit(EVENT_DEV_OPEN, &dev->flags))
 		return;
 
+	if (test_and_clear_bit(EVENT_LINK_CARRIER_ON, &dev->flags))
+		netif_carrier_on(dev->net);
+
 	if (!netif_carrier_ok(dev->net)) {
 		/* kill URBs for reading packets to save bus bandwidth */
 		unlink_urbs(dev, &dev->rxq);
 
 		/*
 		 * tx_timeout will unlink URBs for sending packets and
 		 * tx queue is stopped by netcore after link becomes off
 		 */
 	} else {
-		if (test_and_clear_bit(EVENT_LINK_CARRIER_ON, &dev->flags))
-			netif_carrier_on(dev->net);
-
 		/* submitting URBs for reading packets */
 		queue_work(system_bh_wq, &dev->bh_work);
 	}
 
 	/* hard_mtu or rx_urb_size may change during link change */
 	usbnet_update_max_qlen(dev);
 
 	clear_bit(EVENT_LINK_CHANGE, &dev->flags);
 }
 
-- 
Ammar Faizi


