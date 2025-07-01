Return-Path: <stable+bounces-159118-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A425AEEEC9
	for <lists+stable@lfdr.de>; Tue,  1 Jul 2025 08:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD5BF3E11D9
	for <lists+stable@lfdr.de>; Tue,  1 Jul 2025 06:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D2EE23F42D;
	Tue,  1 Jul 2025 06:32:45 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C882190477;
	Tue,  1 Jul 2025 06:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751351565; cv=none; b=gOASwC0P2kF1OPdixYhKqLdRtNDXZPd7vJY+3KKY9rk/FkpQTCRPe2YfXC2KUQbGfnvX/oZow+ZCU9DJuD1zKLDJMn93OL+fXFTaB7cWHJYMryHlxEnAC8G7TwJWH/h9gH/vaKpeC6iik78JIOhHPlZHMooDughpXpDbocevOw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751351565; c=relaxed/simple;
	bh=XdqAjjYQ7KDAvxmL6f4pGW5ogaf6brW1bGjT4WOUXSI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VTdPhRLwpj14l/RmGxKC5lPyKD6ItSt8RXSYfcdxezHanIs1s4j1sivjtQKsINSmGUG61dX6R0sZg+wjoXI/TS3LVNEdcNmFF6oqJL0GB0Wg/VcWVA+6ppvGbYathKJgNnG6DBpwbXUK68wuD3f2LJb5ag+o/eBOXObrwijjgc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpgz13t1751351484t24544bfe
X-QQ-Originating-IP: FL5OuFQIXUwAAb0pN2Qv6vbzM/OOOret5xNB2xCYW4o=
Received: from lap-jiawenwu.trustnetic.com ( [125.120.151.178])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 01 Jul 2025 14:31:22 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14086299368930078068
EX-QQ-RecipientCnt: 13
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	michal.swiatkowski@linux.intel.com,
	larysa.zaremba@intel.com
Cc: mengyuanlou@net-swift.com,
	duanqiangwen@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	stable@vger.kernel.org
Subject: [PATCH net v4 1/3] net: txgbe: request MISC IRQ in ndo_open
Date: Tue,  1 Jul 2025 14:30:28 +0800
Message-Id: <20250701063030.59340-2-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20250701063030.59340-1-jiawenwu@trustnetic.com>
References: <20250701063030.59340-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: OSUW9vQLVhiZZzDs+i4ekew3eZMdabZN7sT0Ru8Ca5t8wArpyL2G7e+i
	KmNfvtA0tnlfaIIkjZy0C54jxiCpURBtC+S6ett/3B9zZ5KiTv2KiBxdBvkYozmWT4M+lNA
	vOmmweYLZCbR8cAMYFtld5KA4kk+h+cDtIVeeBHEXc406qqNr0GTw/I/9iX/BSzgCMfD8GG
	mUJanb0INh0+oZdhBccrkkYVbiRt3ty/yPpoA31zBSOms6GYHkQ681zWYGhtbOrcSM5Q/l8
	YoClL5k0BZahGQUr3Csqea+e4O4mYL8yMsOr529YgHsM084rPS/6oMN4alat8Jlk+YJD6co
	s1oKjKAr9roErTeTuoSL7pslKAhz0GONiGEJfMzSB8mwCI9DChYfBEiGXsANoQr4iSSCUM4
	G36Cqqhj10aUsmie6w9agSbz4RtDkhhURALYIsf8uBllLfBmGyElfCuX2Fbg7OJF5YLQCVt
	jhYL6Wkchfpguv88GMN5Z08mHntUyVjKmrON2P1O+JaqYGHP/LWGrc36ro5DzvWlYX4tajv
	1mOHsFjvi5V4Zjqkdd8ReirPI4KcS7jKHtyqqB9N6QBawYafTtOzDoIcoUwTF2f3tSRIrIu
	Lc2GzH+D6f5aSmATsItBCoXq2TCVw/H0LDt2dCVD7kDPuwEimHDAtrDubodv8trvst3vEOh
	NlSXAPPOI5IgnbN5xzfQrIrsYaPCTWFSXtA5gj6/0iDVhPFqxzUXpH1G3YJVYYMfYgqvJIr
	lKVC9Cbz5fFA5YEXgZm0wz2Idmj5pxp072pvJ6VCqc34We8mrKRLwAWD4haLWT9qBSPXG+9
	mGFMPs/JUUS0TmTXslQAtjXfrVLG3ihJ4p0LLwLyrymMg9+m/aye22Cwg06CJNXq8VtTIPk
	LEnMUlhXWXOm53W5nZbMRAscEXn2WZU+U+e78cwxAQ9BRGhVJNnlO6TF2lfiWz6Ty/espgM
	gsPhLi5kx22H0MllEm3rctdGgctO8+O0NZjdhr8Z6W8ONvizPKcXNvKPmlZwgiHjJI+5Ppu
	Y1Co2AXblvCXpS5KqrnxGLKccEHF63fsfvma0/qyJ4NDKgpBHP8eFwAt+yzKA=
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0

Move the creating of irq_domain for MISC IRQ from .probe to .ndo_open,
and free it in .ndo_stop, to maintain consistency with the queue IRQs.
This it for subsequent adjustments to the IRQ vectors.

Fixes: aefd013624a1 ("net: txgbe: use irq_domain for interrupt controller")
Cc: stable@vger.kernel.org
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 .../net/ethernet/wangxun/txgbe/txgbe_irq.c    |  2 +-
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   | 22 +++++++++----------
 2 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
index 20b9a28bcb55..dc468053bdf8 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
@@ -78,7 +78,6 @@ int txgbe_request_queue_irqs(struct wx *wx)
 		free_irq(wx->msix_q_entries[vector].vector,
 			 wx->q_vector[vector]);
 	}
-	wx_reset_interrupt_capability(wx);
 	return err;
 }
 
@@ -211,6 +210,7 @@ void txgbe_free_misc_irq(struct txgbe *txgbe)
 	free_irq(txgbe->link_irq, txgbe);
 	free_irq(txgbe->misc.irq, txgbe);
 	txgbe_del_irq_domain(txgbe);
+	txgbe->wx->misc_irq_domain = false;
 }
 
 int txgbe_setup_misc_irq(struct txgbe *txgbe)
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
index f3d2778b8e35..a5867f3c93fc 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
@@ -458,10 +458,14 @@ static int txgbe_open(struct net_device *netdev)
 
 	wx_configure(wx);
 
-	err = txgbe_request_queue_irqs(wx);
+	err = txgbe_setup_misc_irq(wx->priv);
 	if (err)
 		goto err_free_resources;
 
+	err = txgbe_request_queue_irqs(wx);
+	if (err)
+		goto err_free_misc_irq;
+
 	/* Notify the stack of the actual queue counts. */
 	err = netif_set_real_num_tx_queues(netdev, wx->num_tx_queues);
 	if (err)
@@ -479,6 +483,9 @@ static int txgbe_open(struct net_device *netdev)
 
 err_free_irq:
 	wx_free_irq(wx);
+err_free_misc_irq:
+	txgbe_free_misc_irq(wx->priv);
+	wx_reset_interrupt_capability(wx);
 err_free_resources:
 	wx_free_resources(wx);
 err_reset:
@@ -519,6 +526,7 @@ static int txgbe_close(struct net_device *netdev)
 	wx_ptp_stop(wx);
 	txgbe_down(wx);
 	wx_free_irq(wx);
+	txgbe_free_misc_irq(wx->priv);
 	wx_free_resources(wx);
 	txgbe_fdir_filter_exit(wx);
 	wx_control_hw(wx, false);
@@ -564,7 +572,6 @@ static void txgbe_shutdown(struct pci_dev *pdev)
 int txgbe_setup_tc(struct net_device *dev, u8 tc)
 {
 	struct wx *wx = netdev_priv(dev);
-	struct txgbe *txgbe = wx->priv;
 
 	/* Hardware has to reinitialize queues and interrupts to
 	 * match packet buffer alignment. Unfortunately, the
@@ -575,7 +582,6 @@ int txgbe_setup_tc(struct net_device *dev, u8 tc)
 	else
 		txgbe_reset(wx);
 
-	txgbe_free_misc_irq(txgbe);
 	wx_clear_interrupt_scheme(wx);
 
 	if (tc)
@@ -584,7 +590,6 @@ int txgbe_setup_tc(struct net_device *dev, u8 tc)
 		netdev_reset_tc(dev);
 
 	wx_init_interrupt_scheme(wx);
-	txgbe_setup_misc_irq(txgbe);
 
 	if (netif_running(dev))
 		txgbe_open(dev);
@@ -882,13 +887,9 @@ static int txgbe_probe(struct pci_dev *pdev,
 
 	txgbe_init_fdir(txgbe);
 
-	err = txgbe_setup_misc_irq(txgbe);
-	if (err)
-		goto err_release_hw;
-
 	err = txgbe_init_phy(txgbe);
 	if (err)
-		goto err_free_misc_irq;
+		goto err_release_hw;
 
 	err = register_netdev(netdev);
 	if (err)
@@ -916,8 +917,6 @@ static int txgbe_probe(struct pci_dev *pdev,
 
 err_remove_phy:
 	txgbe_remove_phy(txgbe);
-err_free_misc_irq:
-	txgbe_free_misc_irq(txgbe);
 err_release_hw:
 	wx_clear_interrupt_scheme(wx);
 	wx_control_hw(wx, false);
@@ -957,7 +956,6 @@ static void txgbe_remove(struct pci_dev *pdev)
 	unregister_netdev(netdev);
 
 	txgbe_remove_phy(txgbe);
-	txgbe_free_misc_irq(txgbe);
 	wx_free_isb_resources(wx);
 
 	pci_release_selected_regions(pdev,
-- 
2.48.1


