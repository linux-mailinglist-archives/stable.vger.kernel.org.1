Return-Path: <stable+bounces-46837-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA9E28D0B78
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 21:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A40D2284914
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 19:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4111C61FCD;
	Mon, 27 May 2024 19:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qqvqfcmH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F289917E90E;
	Mon, 27 May 2024 19:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716836982; cv=none; b=OQ/5NXOqCjuVx0txiU2kpQSz2+Kwy7dKDWDEZTBDNq5qfKweYSHlxXcRK14KboPLHIu/2N9KxhKMMQQHT/PIwqd0iiZYobppG7muSgyDOcllZJAPzKCRpLwuLO3WuGqrf8zdSXx78IxIy3lVR2gYjvwwmJ+qhCUjqBOZSbKF8Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716836982; c=relaxed/simple;
	bh=DwO0d8ByphG9DVeFLAOk8RycD62uwe8SC0sLCKyfQa4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ilKqYUjsxqaCOuuVJO+1fJqu2SJD11e1RxBA4O9EIfSTD4bgUL/z/kz/GIKT7qyklZ5LHr2EuBTxysUWWGN3m1hrKJ6NEQbB7er5TRwqwztJBs1xnhmwvbvPXTG8t19W9DpGzDAqUUrQ2FnmAF+dxf1jli5cLEj+ZSQNPHCYR04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qqvqfcmH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 878E5C2BBFC;
	Mon, 27 May 2024 19:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716836981;
	bh=DwO0d8ByphG9DVeFLAOk8RycD62uwe8SC0sLCKyfQa4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qqvqfcmHBukLW0GGso3PkxcOOMe+IGUG82TKUeZ/xncGaI0BZkUc8o+dTjU6poAMg
	 tAH5kw00gIr9NcwSHdTZ4iUJN6x8BfwRUiC5ZGyAxLFMyY/UHoWSYUPKtBHZ9dZGVF
	 4jQ4ltOIi99U6ry5K3bluDyUMiAU4yu481tYpohs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Wei Fang <wei.fang@nxp.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.9 263/427] net: fec: remove .ndo_poll_controller to avoid deadlocks
Date: Mon, 27 May 2024 20:55:10 +0200
Message-ID: <20240527185627.022765992@linuxfoundation.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240527185601.713589927@linuxfoundation.org>
References: <20240527185601.713589927@linuxfoundation.org>
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

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wei Fang <wei.fang@nxp.com>

[ Upstream commit c2e0c58b25a0a0c37ec643255558c5af4450c9f5 ]

There is a deadlock issue found in sungem driver, please refer to the
commit ac0a230f719b ("eth: sungem: remove .ndo_poll_controller to avoid
deadlocks"). The root cause of the issue is that netpoll is in atomic
context and disable_irq() is called by .ndo_poll_controller interface
of sungem driver, however, disable_irq() might sleep. After analyzing
the implementation of fec_poll_controller(), the fec driver should have
the same issue. Due to the fec driver uses NAPI for TX completions, the
.ndo_poll_controller is unnecessary to be implemented in the fec driver,
so fec_poll_controller() can be safely removed.

Fixes: 7f5c6addcdc0 ("net/fec: add poll controller function for fec nic")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
Link: https://lore.kernel.org/r/20240511062009.652918-1-wei.fang@nxp.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/freescale/fec_main.c | 26 -----------------------
 1 file changed, 26 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 8bd213da8fb6f..a72d8a2eb0b31 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -3674,29 +3674,6 @@ fec_set_mac_address(struct net_device *ndev, void *p)
 	return 0;
 }
 
-#ifdef CONFIG_NET_POLL_CONTROLLER
-/**
- * fec_poll_controller - FEC Poll controller function
- * @dev: The FEC network adapter
- *
- * Polled functionality used by netconsole and others in non interrupt mode
- *
- */
-static void fec_poll_controller(struct net_device *dev)
-{
-	int i;
-	struct fec_enet_private *fep = netdev_priv(dev);
-
-	for (i = 0; i < FEC_IRQ_NUM; i++) {
-		if (fep->irq[i] > 0) {
-			disable_irq(fep->irq[i]);
-			fec_enet_interrupt(fep->irq[i], dev);
-			enable_irq(fep->irq[i]);
-		}
-	}
-}
-#endif
-
 static inline void fec_enet_set_netdev_features(struct net_device *netdev,
 	netdev_features_t features)
 {
@@ -4003,9 +3980,6 @@ static const struct net_device_ops fec_netdev_ops = {
 	.ndo_tx_timeout		= fec_timeout,
 	.ndo_set_mac_address	= fec_set_mac_address,
 	.ndo_eth_ioctl		= phy_do_ioctl_running,
-#ifdef CONFIG_NET_POLL_CONTROLLER
-	.ndo_poll_controller	= fec_poll_controller,
-#endif
 	.ndo_set_features	= fec_set_features,
 	.ndo_bpf		= fec_enet_bpf,
 	.ndo_xdp_xmit		= fec_enet_xdp_xmit,
-- 
2.43.0




