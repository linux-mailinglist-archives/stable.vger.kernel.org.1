Return-Path: <stable+bounces-158670-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 905FAAE98F6
	for <lists+stable@lfdr.de>; Thu, 26 Jun 2025 10:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 705911899DC7
	for <lists+stable@lfdr.de>; Thu, 26 Jun 2025 08:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AAE12C3274;
	Thu, 26 Jun 2025 08:49:29 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87213237162;
	Thu, 26 Jun 2025 08:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750927768; cv=none; b=ldADwJl12Rq8Y0opUO7YREvMAVenfF6WE92iJkSNLDhcFnf0IpAZGZ0MM0YkgebqQWq32KVXSdTNfA6IrTjVHIYF6oQkgt3luXPXxJQEd/3hJPR2fiHv0KzmBthHXIUxrNQNG+4ydqvUzpTKEl//6yGax5RkZkzg+/6HpWbnLIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750927768; c=relaxed/simple;
	bh=XdqAjjYQ7KDAvxmL6f4pGW5ogaf6brW1bGjT4WOUXSI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qulDNMK2yr3VV+mtOEfOgJir/ot87fBxB74ic97NsBjyNAiU29bf1elkLLraocScje1T4Be0W6Vg9eEDejRayrAWoNTOqjM2+bAqTnGrbbIPz5qtWf3lM1tbQuiPHn/SAzH3z2jqxcS3gZyHSoNupmqcPKX54ctczQeF+JpmTo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpsz10t1750927702t62a19487
X-QQ-Originating-IP: tLB48kySe8CaAxuRZXc9fpLmVh3m2fKmhceJ45KmPkM=
Received: from lap-jiawenwu.trustnetic.com ( [36.27.0.255])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 26 Jun 2025 16:48:20 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14218738192378290163
EX-QQ-RecipientCnt: 12
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	michal.swiatkowski@linux.intel.com
Cc: mengyuanlou@net-swift.com,
	duanqiangwen@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	stable@vger.kernel.org
Subject: [PATCH net v3 1/3] net: txgbe: request MISC IRQ in ndo_open
Date: Thu, 26 Jun 2025 16:48:02 +0800
Message-Id: <20250626084804.21044-2-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20250626084804.21044-1-jiawenwu@trustnetic.com>
References: <20250626084804.21044-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NH62s74zCdjlkturCokt1Oegcsl/u2i8S4OUXChng54g/Vaw5qrPDG8Y
	alpLPr9RVPKKhjHmPiEHYNfopLXW738p9uYYccN8FA4FmQwyyroRTYj4N0DFy5+pmNMrsQF
	pB+RmICXaDbvvKb8lV5IbwQqWVAdEL+kr8bXtkZ1MmCnOWpATVO2ZVmQ7z8sTDu9KNqj3ZY
	tfN/NcqkcwPVqhunO7odkLpUuuQ9eM6L6VHjxhWvlm9W85tjWwp+HWkzGdEeLkTN46Nh8vg
	nzHdoyeOjF8QuvXnwRgEZ9Cs5JG4fnng9y++iUMSdQw6moUClNoRZr93Pj7M0sl1mEUpx4w
	mFzfT7QrnA9gmJjycqaCv51HaKQeBClM1iaR44Z5++wI8eE4BTFlNrX6LoKkq2Ks0gdZiFY
	2Vg85L3klf5Si4lkUgflyXvPOi9oc+igLwHNb1GXBUtkrHFTKfzf7EawxvzjBlF2YRrjIgY
	aVvsPIp/uXfpwSxy9BlOX19bmWXOz9orx9Xx2OoslzGK0hGEcSE25B3Z6GGXwjcoWm4cV9P
	qXI0WCMcufbROZdTzmRXYK3VuvRtEEVPIlKzOIH23YqNwTXVZojs3/tC4YDv2La6czAGG+8
	+uV/OeTcsjh1eYTd+jTOYoKUPkYQL2MeLlK7gBsvkH0lt9v5oyXnQIHt9qd99vtIC/6n1+G
	4N6T47nR1T6r4uRt28dMClwlBQPP9iyt9o5mX2ZHFaxtsRM34um726a+E7gz9G4+q17+aMz
	nj/adXrUOF1zV98FYdR3MZhvwe+XnsjJG1mWyhBFfuT+UtQ6JsnWdRkgC+ZK7hzMY4097JB
	M9jePT2SbQk3oHezTlaQzTNWNeRUtyr6T9NqHHDKv1y3kurPXlt3CuA6gVGithdjapOpFUf
	/ygo79/88X0p/w89aatdMuEc3tW5vUSFMaqSG78xv8x3j2jBKLCmhhE2VHIDbSpt48TLWsU
	kZkNQM9sPUIs6eywbxXUTWwz/wVgFMxDszOzE4np+EGZurMpjv+ECXMUv2kcZrMV7Bv3y2Z
	EUMIimWPgNrBf4Y00OeJmSWBVKqSvfrQu6hWCf3+ctenIc4+fMN17udGKIHC0gxW1I2/oFN
	QoB95WVv8JhBzPcWu0Mjvp1MbroO31Svw==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
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


