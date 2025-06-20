Return-Path: <stable+bounces-155013-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8FE7AE16D7
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 10:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 525553BD4EA
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 08:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5518B27CCDA;
	Fri, 20 Jun 2025 08:58:29 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC47427BF6E;
	Fri, 20 Jun 2025 08:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750409909; cv=none; b=XcHkm44B9mHHNPWUHLYlf/Ie/mumEDFFBagX+I9A8WnNKKpE/ipB7zlBRpCw7gC7CDmqOtaWRedmmMCrie3fiklmlO8fqcz29CheJ3IuOavv00XWYNlgPSnoMH/c4WEc9TrbY7C6pkfyBDkicU4JgclqC/S12dKSubVmv6wj2Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750409909; c=relaxed/simple;
	bh=YkpY1fhHra+OZEOgNIChEpJB4uSONgPIuulv97XaE58=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EUL5f5tfHaG1r0xdm6M8piaP5chPy5WoB8UhyJmR9xi+yVZDG47foObG8Ik6H5CGNCchyBR2m9bbuRb+Fle9zLTBQJVv2/6EtNN946XkZOD1DRoMij8uBEEIlZwdoDRJLKdgulsk6jTWmHS4x3dZdmqE3wIo9v5YuyNXSjR6iuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpgz12t1750409859t95de859e
X-QQ-Originating-IP: muBgwb3SUiBx7chg8HIxQPcHaCoUWyUCI3W0VE8bda4=
Received: from lap-jiawenwu.trustnetic.com ( [60.176.0.129])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 20 Jun 2025 16:57:38 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 18233739580673718109
EX-QQ-RecipientCnt: 11
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: mengyuanlou@net-swift.com,
	duanqiangwen@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	stable@vger.kernel.org
Subject: [PATCH net 1/2] net: txgbe: request MISC IRQ in ndo_open
Date: Fri, 20 Jun 2025 16:57:19 +0800
Message-Id: <20250620085720.33924-2-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20250620085720.33924-1-jiawenwu@trustnetic.com>
References: <20250620085720.33924-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: N1GwrkiB7FDZtHPjnqX6QlWYrQZ0wZEGNa6X92UbGuo5iPyYD9NElGuG
	16dRR7HyF1lvCLE6LmkNuXkt4RAH26V1/VlsYsjO97oX7dI1/Lb+YxnBxev07MV4XD07ppW
	iFyRY4YqvgchNqg2rjqLsXK4YAGoQKSab5HwkPmU86YrZtN65/RmYYOT/F8p6bUVAulxuzN
	rXkp5wvBfXld4Yo/ROJiA1QkxOw4Qhlwm/ZypVaxZs0ogBshZH8VXKWvFniU00Kc47pevMB
	PMBQIqwvNyLfTxjiML1Z051p1oHTrpwhJwIv0EmXNXCdl2Lt0NekxdEqCcG601BJY7WKTO6
	nDt1ljr2LpwFfDETsdZLhA9pos5nFX4OKlHjvT6Dcn2B80MZsm8vRZshlqV7lGfGRV4IXZo
	pYyazsYTJHwIiIdwd4fN4zgqJnu4woZilOWxXXJQ7qFOBNO8Y3dxV01trGhxck1cPjfpryU
	IgErQnP72iXfYCyJQBbS/xW/W/uIAqu97JCUHfIpYvMDU5UgKUf78wFlXK+ElO5j4eIp1yP
	/n44vqdKCcdfh15jaS3WJefIaVA62o2aYJGtNppCDOqMivnOwQ5IqPvftpVIiK99x31GVjZ
	/k4Sp+siFtT90+/9G2YlNNROp2OGEfV+vAYkbfEXTOGsmgAOEtHhQUAiyEqQ3cyOodsEOrS
	zmQV+RZBFhEAMDjUnc7VJjnbmdmsu3PSdbHjtYBoDkLQPFxhVnR+g8kq82j5991FmPDBbBF
	9X/co6xJs0XSpqSVeKWppos+8ZWzTd8Qbc9NI4fWMqxNQT1kDu6AV9Igo45DqJREC+ck8/H
	gh6bUvHusfZdNS6Dk8UX2yovytUxUf8mI0c/a5U0qBjacY+gwKGxZlN3SpfAnO1Cc1iGsuK
	jVR9PqCG4ALKFKmKqkm2rjNKxQqF3k7g2IC3IruvZizwNlGl5xw9AnNsQLqJaWpum0e3YrP
	pZKLPtyX7xHbsIu9xKryedCjbbOa90uIoA7667MpdYS21em5J3250cbWCSvDNQuF13W0xQ3
	34W9MD++Hc7uh4wMqY981l9pb5/2SOIidWv73D7Tz/KJq4idL0ooNBQ5Gz9inuh1pc1blJc
	A==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

Move the creating of irq_domain for MISC IRQ from .probe to .ndo_open,
and free it in .ndo_stop, to maintain consistency with the queue IRQs.
This it for subsequent adjustments to the IRQ vectors.

Fixes: aefd013624a1 ("net: txgbe: use irq_domain for interrupt controller")
Cc: stable@vger.kernel.org
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   | 21 ++++++++-----------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
index f3d2778b8e35..b4a864c97db3 100644
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
@@ -479,6 +483,8 @@ static int txgbe_open(struct net_device *netdev)
 
 err_free_irq:
 	wx_free_irq(wx);
+err_free_misc_irq:
+	txgbe_free_misc_irq(wx->priv);
 err_free_resources:
 	wx_free_resources(wx);
 err_reset:
@@ -519,6 +525,7 @@ static int txgbe_close(struct net_device *netdev)
 	wx_ptp_stop(wx);
 	txgbe_down(wx);
 	wx_free_irq(wx);
+	txgbe_free_misc_irq(wx->priv);
 	wx_free_resources(wx);
 	txgbe_fdir_filter_exit(wx);
 	wx_control_hw(wx, false);
@@ -564,7 +571,6 @@ static void txgbe_shutdown(struct pci_dev *pdev)
 int txgbe_setup_tc(struct net_device *dev, u8 tc)
 {
 	struct wx *wx = netdev_priv(dev);
-	struct txgbe *txgbe = wx->priv;
 
 	/* Hardware has to reinitialize queues and interrupts to
 	 * match packet buffer alignment. Unfortunately, the
@@ -575,7 +581,6 @@ int txgbe_setup_tc(struct net_device *dev, u8 tc)
 	else
 		txgbe_reset(wx);
 
-	txgbe_free_misc_irq(txgbe);
 	wx_clear_interrupt_scheme(wx);
 
 	if (tc)
@@ -584,7 +589,6 @@ int txgbe_setup_tc(struct net_device *dev, u8 tc)
 		netdev_reset_tc(dev);
 
 	wx_init_interrupt_scheme(wx);
-	txgbe_setup_misc_irq(txgbe);
 
 	if (netif_running(dev))
 		txgbe_open(dev);
@@ -882,13 +886,9 @@ static int txgbe_probe(struct pci_dev *pdev,
 
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
@@ -916,8 +916,6 @@ static int txgbe_probe(struct pci_dev *pdev,
 
 err_remove_phy:
 	txgbe_remove_phy(txgbe);
-err_free_misc_irq:
-	txgbe_free_misc_irq(txgbe);
 err_release_hw:
 	wx_clear_interrupt_scheme(wx);
 	wx_control_hw(wx, false);
@@ -957,7 +955,6 @@ static void txgbe_remove(struct pci_dev *pdev)
 	unregister_netdev(netdev);
 
 	txgbe_remove_phy(txgbe);
-	txgbe_free_misc_irq(txgbe);
 	wx_free_isb_resources(wx);
 
 	pci_release_selected_regions(pdev,
-- 
2.48.1


