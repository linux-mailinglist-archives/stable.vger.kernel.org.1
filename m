Return-Path: <stable+bounces-178524-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99358B47F02
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 22:31:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EFDB1B20E3E
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 20:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D37211A14;
	Sun,  7 Sep 2025 20:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rKiJibzJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CDC18DF89;
	Sun,  7 Sep 2025 20:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757277111; cv=none; b=FS0gPV3rdFI2IUZjCmsC/bx6MVv6cPkTkB6uH1amMujVQD/+pAVBpWdAlya5YcQ82fHM0YWPPp8m3TI4SbnWR5o2jadYEjq7vYnoM0KvnjT9uvihUTt2gr1EiXVUffsJhHiOJb0C7q3iLn0s9lyy1+kK1iKhEwVyjx0UEO+OWXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757277111; c=relaxed/simple;
	bh=gxxX7ixSHKw6VjA+QUds+4aYVKFIL+fR6SMIU/Q+hK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gIhARFBATPMfuXMsygTIJkwddhR+cRj4qz8IXGkpWZgygBFJI9izzeocvf8jI6ezxmTqO0QRsQwe+TRihqbKSHAtYoU6VuHEFSB3AJWYVXxIGnFHLnbiaaJqdyr7CYeSKQ9Qr49ZNi03L5wNxlEzhe1/fpha+k6GMQaVQlkPIAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rKiJibzJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2517C4CEF0;
	Sun,  7 Sep 2025 20:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757277111;
	bh=gxxX7ixSHKw6VjA+QUds+4aYVKFIL+fR6SMIU/Q+hK4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rKiJibzJaxnYTVBBSKKWOhNeVZTJ781Wmz7PH3ddtezexn9Nqum3FSywfjPxrbUHb
	 QqkcGSV+o71Y/OrnyyuLBShuuMWvRq8AMOTQ1NwcEUPKYxaQumG0liTVUHoP0rxnIa
	 72OLk+Q+ykMrSzlBNerMNWVjN7YBk7vSHT//2c9M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 090/175] phy: mscc: Stop taking ts_lock for tx_queue and use its own lock
Date: Sun,  7 Sep 2025 21:58:05 +0200
Message-ID: <20250907195616.968205473@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250907195614.892725141@linuxfoundation.org>
References: <20250907195614.892725141@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Horatiu Vultur <horatiu.vultur@microchip.com>

[ Upstream commit 9b2bfdbf43adb9929c5ddcdd96efedbf1c88cf53 ]

When transmitting a PTP frame which is timestamp using 2 step, the
following warning appears if CONFIG_PROVE_LOCKING is enabled:
=============================
[ BUG: Invalid wait context ]
6.17.0-rc1-00326-ge6160462704e #427 Not tainted
-----------------------------
ptp4l/119 is trying to lock:
c2a44ed4 (&vsc8531->ts_lock){+.+.}-{3:3}, at: vsc85xx_txtstamp+0x50/0xac
other info that might help us debug this:
context-{4:4}
4 locks held by ptp4l/119:
 #0: c145f068 (rcu_read_lock_bh){....}-{1:2}, at: __dev_queue_xmit+0x58/0x1440
 #1: c29df974 (dev->qdisc_tx_busylock ?: &qdisc_tx_busylock){+...}-{2:2}, at: __dev_queue_xmit+0x5c4/0x1440
 #2: c2aaaad0 (_xmit_ETHER#2){+.-.}-{2:2}, at: sch_direct_xmit+0x108/0x350
 #3: c2aac170 (&lan966x->tx_lock){+.-.}-{2:2}, at: lan966x_port_xmit+0xd0/0x350
stack backtrace:
CPU: 0 UID: 0 PID: 119 Comm: ptp4l Not tainted 6.17.0-rc1-00326-ge6160462704e #427 NONE
Hardware name: Generic DT based system
Call trace:
 unwind_backtrace from show_stack+0x10/0x14
 show_stack from dump_stack_lvl+0x7c/0xac
 dump_stack_lvl from __lock_acquire+0x8e8/0x29dc
 __lock_acquire from lock_acquire+0x108/0x38c
 lock_acquire from __mutex_lock+0xb0/0xe78
 __mutex_lock from mutex_lock_nested+0x1c/0x24
 mutex_lock_nested from vsc85xx_txtstamp+0x50/0xac
 vsc85xx_txtstamp from lan966x_fdma_xmit+0xd8/0x3a8
 lan966x_fdma_xmit from lan966x_port_xmit+0x1bc/0x350
 lan966x_port_xmit from dev_hard_start_xmit+0xc8/0x2c0
 dev_hard_start_xmit from sch_direct_xmit+0x8c/0x350
 sch_direct_xmit from __dev_queue_xmit+0x680/0x1440
 __dev_queue_xmit from packet_sendmsg+0xfa4/0x1568
 packet_sendmsg from __sys_sendto+0x110/0x19c
 __sys_sendto from sys_send+0x18/0x20
 sys_send from ret_fast_syscall+0x0/0x1c
Exception stack(0xf0b05fa8 to 0xf0b05ff0)
5fa0:                   00000001 0000000e 0000000e 0004b47a 0000003a 00000000
5fc0: 00000001 0000000e 00000000 00000121 0004af58 00044874 00000000 00000000
5fe0: 00000001 bee9d420 00025a10 b6e75c7c

So, instead of using the ts_lock for tx_queue, use the spinlock that
skb_buff_head has.

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Fixes: 7d272e63e0979d ("net: phy: mscc: timestamping and PHC support")
Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
Link: https://patch.msgid.link/20250902121259.3257536-1-horatiu.vultur@microchip.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/mscc/mscc_ptp.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/net/phy/mscc/mscc_ptp.c b/drivers/net/phy/mscc/mscc_ptp.c
index 920f35f8f84e7..fa24ba8f6bff0 100644
--- a/drivers/net/phy/mscc/mscc_ptp.c
+++ b/drivers/net/phy/mscc/mscc_ptp.c
@@ -455,12 +455,12 @@ static void vsc85xx_dequeue_skb(struct vsc85xx_ptp *ptp)
 		*p++ = (reg >> 24) & 0xff;
 	}
 
-	len = skb_queue_len(&ptp->tx_queue);
+	len = skb_queue_len_lockless(&ptp->tx_queue);
 	if (len < 1)
 		return;
 
 	while (len--) {
-		skb = __skb_dequeue(&ptp->tx_queue);
+		skb = skb_dequeue(&ptp->tx_queue);
 		if (!skb)
 			return;
 
@@ -485,7 +485,7 @@ static void vsc85xx_dequeue_skb(struct vsc85xx_ptp *ptp)
 		 * packet in the FIFO right now, reschedule it for later
 		 * packets.
 		 */
-		__skb_queue_tail(&ptp->tx_queue, skb);
+		skb_queue_tail(&ptp->tx_queue, skb);
 	}
 }
 
@@ -1065,6 +1065,7 @@ static int vsc85xx_hwtstamp(struct mii_timestamper *mii_ts,
 	case HWTSTAMP_TX_ON:
 		break;
 	case HWTSTAMP_TX_OFF:
+		skb_queue_purge(&vsc8531->ptp->tx_queue);
 		break;
 	default:
 		return -ERANGE;
@@ -1089,9 +1090,6 @@ static int vsc85xx_hwtstamp(struct mii_timestamper *mii_ts,
 
 	mutex_lock(&vsc8531->ts_lock);
 
-	__skb_queue_purge(&vsc8531->ptp->tx_queue);
-	__skb_queue_head_init(&vsc8531->ptp->tx_queue);
-
 	/* Disable predictor while configuring the 1588 block */
 	val = vsc85xx_ts_read_csr(phydev, PROCESSOR,
 				  MSCC_PHY_PTP_INGR_PREDICTOR);
@@ -1177,9 +1175,7 @@ static void vsc85xx_txtstamp(struct mii_timestamper *mii_ts,
 
 	skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
 
-	mutex_lock(&vsc8531->ts_lock);
-	__skb_queue_tail(&vsc8531->ptp->tx_queue, skb);
-	mutex_unlock(&vsc8531->ts_lock);
+	skb_queue_tail(&vsc8531->ptp->tx_queue, skb);
 	return;
 
 out:
@@ -1545,6 +1541,7 @@ void vsc8584_ptp_deinit(struct phy_device *phydev)
 	if (vsc8531->ptp->ptp_clock) {
 		ptp_clock_unregister(vsc8531->ptp->ptp_clock);
 		skb_queue_purge(&vsc8531->rx_skbs_list);
+		skb_queue_purge(&vsc8531->ptp->tx_queue);
 	}
 }
 
@@ -1568,7 +1565,7 @@ irqreturn_t vsc8584_handle_ts_interrupt(struct phy_device *phydev)
 	if (rc & VSC85XX_1588_INT_FIFO_ADD) {
 		vsc85xx_get_tx_ts(priv->ptp);
 	} else if (rc & VSC85XX_1588_INT_FIFO_OVERFLOW) {
-		__skb_queue_purge(&priv->ptp->tx_queue);
+		skb_queue_purge(&priv->ptp->tx_queue);
 		vsc85xx_ts_reset_fifo(phydev);
 	}
 
@@ -1588,6 +1585,7 @@ int vsc8584_ptp_probe(struct phy_device *phydev)
 	mutex_init(&vsc8531->phc_lock);
 	mutex_init(&vsc8531->ts_lock);
 	skb_queue_head_init(&vsc8531->rx_skbs_list);
+	skb_queue_head_init(&vsc8531->ptp->tx_queue);
 
 	/* Retrieve the shared load/save GPIO. Request it as non exclusive as
 	 * the same GPIO can be requested by all the PHYs of the same package.
-- 
2.50.1




