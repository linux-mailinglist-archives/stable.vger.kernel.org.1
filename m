Return-Path: <stable+bounces-158349-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 885D3AE6010
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 10:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86546192320B
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 08:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF57279DAA;
	Tue, 24 Jun 2025 08:58:16 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB50277CA0;
	Tue, 24 Jun 2025 08:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750755496; cv=none; b=Ibw1wIkZLJX+WOe+t3PjagZ1RKf9wfLZPlfiY2swzrSQ9uIkQYMRIfsWPV3gUu5bjsE/APqRwZUMRoOgpEi6ZQeocgyfvgaKXkvoQIzb5+2PZlKtHvLNawNdbVTqsMIfqRZjGnHcDGo2Yw68iLHMIYgJFxFEtsL9aeselXz0/40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750755496; c=relaxed/simple;
	bh=rd0kbPayIV3jkG6idYi0agpqcok4MA6jxrTw8cr2xsQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GNwkPTWOdOCCBdhHh9RbR5rlcYA6yEgtOOTpCQ5SUtnh/8Olgh8h31O46zIe1Hy3+qvX3jVTSY4PY7sCOxoJIs2iA2OpwF8pk0ahLa7tvdsfD6D9MMFRbxIpXQ98pvwkwkO4/lCR4FFN9pNpZuQYo5HEQEI7Qno2eGkQP2ZD3fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpgz7t1750755411t5e3fe4eb
X-QQ-Originating-IP: WtE51/6qCnT64a6G2/a/V/kJzfC42kHn7iz2UbHGVFo=
Received: from lap-jiawenwu.trustnetic.com ( [60.186.80.242])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 24 Jun 2025 16:56:50 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 11818108984614509413
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
Subject: [PATCH net v2 1/3] net: txgbe: request MISC IRQ in ndo_open
Date: Tue, 24 Jun 2025 16:56:32 +0800
Message-Id: <20250624085634.14372-2-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20250624085634.14372-1-jiawenwu@trustnetic.com>
References: <20250624085634.14372-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MHjGU15TxxvioRhkA8EECXHTj9IRLbA/edrvGxGtYqQrGEWkka9xtJPP
	Ddzwixk4QMi+K6ccp0WXXZ+J3p+gU5gTE00U01aVVmG3ME8B9H0rMWeWjwJhlyrwRLJd2Lb
	hO1g53sFKthzcnxfI0Digw3JichZ8Fc+eaA4S8K/NKDKiCO+/yIKdJpZUvTwkkKBa0fPi+C
	JptL4902O9lMDAx91NntC5hhmqBzKK63k0WVoTNDAs82pVAT21HOgAsnWFlq/X7ftmkRxhH
	1DW7/uiKpmPF3lm7oJaVtsxoIf2vSlvv237yyja9FFst9Xg9fGdk7udDe7yvnLDLiU0/fHr
	CvAurd9E2lUNZsjuLnaDdgtFhGJ4NRNtdZH7YL8uaBZK+/waDr0OgFXWltkrSUUUdRocoie
	nB5TRCii9CeRbrMmhqh3YOlJ1RLdqmBpkRXXpIR69+zbJutBuiE191eMbouRU/YgQUK7hr9
	dr0PpSQYW35oxJM3CZkGX5fLQ4DaPQp6nvSbaLdQBQuvcPfPb2FI8Q+kFRslMFfuRXymrDI
	HVigO9Ma/Aoatg4Lumk70Y41EodkD6SIdwsPjfdoW5QJp/Af24bsf5eapu/8UxPYOACDUZA
	DQfM9xf3r/FLtYexN/uEvqucBifxtew6cIhoRZyM+SYBAT35O7K+eWa1wovLubvul6mWI+0
	6GgO+DOosPMR1oFrOgQpMsgkHKacAF9Ms5a4d/3tAc4OwjQSUTj0D7X9sMGQGcTrIovAuPM
	KJD1It4ymO/Bwkz0bfPnCx8Qrzx/m8Nc7VZr7UmkllgJCSrAuHys6QR1Reo2Zr7s2JtXyTf
	CW4hyg6In3BvZNlQxCX9S/UCVB6wrAEEvbJck2BiGHBsbacl46eIba0BNCpBmYI8ORw/sIk
	wGexSuCImq4cbQaXQzlEi4QZDKfuMWiHQ4gCgSmf3+fMdnr9JnIU2TXet/eYLFviSU5uvcu
	d38CedqEzntG7O3qFjGS6QqaMuUdbYkw2RorElPnE1+2RwT5USBvc0QtB8TqTq4G8fc2B6U
	sL66UoUagifujG71XNva5ZctUjUMMLuUE23jlz9hxp2jKNXgicPh689UfrBOU=
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0

Move the creating of irq_domain for MISC IRQ from .probe to .ndo_open,
and free it in .ndo_stop, to maintain consistency with the queue IRQs.
This it for subsequent adjustments to the IRQ vectors.

Fixes: aefd013624a1 ("net: txgbe: use irq_domain for interrupt controller")
Cc: stable@vger.kernel.org
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
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


