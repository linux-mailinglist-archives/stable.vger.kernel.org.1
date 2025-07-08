Return-Path: <stable+bounces-161010-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC01AFD2F3
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 18:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EEF61AA4E7B
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 16:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882592DAFA3;
	Tue,  8 Jul 2025 16:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YA6+77Yc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444481DD0EF;
	Tue,  8 Jul 2025 16:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751993339; cv=none; b=PnfvYG8tFSkSL/jBdnjxpDw1WbDnNXpFEFgv0GtvSuZ228nvWRHCJaZaxOGMZkgbuBKR5kR2lKMLSJaQT17YtlM9oM5dku17IQIb6FUy7ZYqbKRYqmQABQoAiGtahX1CjHznv0Zyv3S8YRgwbdI4KFEduB5MtUGQxClwSoJsExw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751993339; c=relaxed/simple;
	bh=hBb2KBEEJvyy9hbnHnXVsw72VLoyjEvwyQRVZivrjac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zls7X9JH6deDOmaUgm1nNSpDrrJtO9K/SpsjR/a6i8HxKueNwqFGzEHKg84oxm3zFVHvhjf1WZq64NcmyiWYMPK7LHFYHLFa2wrQcYY0bsCEhT0djyt+2t4ia/QcftVjPBdebECsY1bYqV8+e2P/rGErly8srl0nuxsrOHfkjEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YA6+77Yc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1480C4CEF0;
	Tue,  8 Jul 2025 16:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751993339;
	bh=hBb2KBEEJvyy9hbnHnXVsw72VLoyjEvwyQRVZivrjac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YA6+77YcplqPBBF04KZLCydOHRYb7DrFZbqivq7wPc0izZrHVi9Qpr43b/InLOzQU
	 dVjDTmJYcvChA6PEZRyG5Ax+nPk3h4/QbdStw2LHIXXI4VHIxKzpiWD4v/vytlerjR
	 VJp9Rk4pwtaqUU78acJ3ZBldC527uiAsO9dqyhfs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 6.15 009/178] net: txgbe: request MISC IRQ in ndo_open
Date: Tue,  8 Jul 2025 18:20:46 +0200
Message-ID: <20250708162236.795871354@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250708162236.549307806@linuxfoundation.org>
References: <20250708162236.549307806@linuxfoundation.org>
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

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiawen Wu <jiawenwu@trustnetic.com>

commit cc9f7f65cd2f31150b10e6956f1f0882e1bbae49 upstream.

Move the creating of irq_domain for MISC IRQ from .probe to .ndo_open,
and free it in .ndo_stop, to maintain consistency with the queue IRQs.
This it for subsequent adjustments to the IRQ vectors.

Fixes: aefd013624a1 ("net: txgbe: use irq_domain for interrupt controller")
Cc: stable@vger.kernel.org
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Link: https://patch.msgid.link/20250701063030.59340-2-jiawenwu@trustnetic.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c  |    2 +-
 drivers/net/ethernet/wangxun/txgbe/txgbe_main.c |   22 ++++++++++------------
 2 files changed, 11 insertions(+), 13 deletions(-)

--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
@@ -68,7 +68,6 @@ free_queue_irqs:
 		free_irq(wx->msix_q_entries[vector].vector,
 			 wx->q_vector[vector]);
 	}
-	wx_reset_interrupt_capability(wx);
 	return err;
 }
 
@@ -172,6 +171,7 @@ void txgbe_free_misc_irq(struct txgbe *t
 	free_irq(txgbe->link_irq, txgbe);
 	free_irq(txgbe->misc.irq, txgbe);
 	txgbe_del_irq_domain(txgbe);
+	txgbe->wx->misc_irq_domain = false;
 }
 
 int txgbe_setup_misc_irq(struct txgbe *txgbe)
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
@@ -354,10 +354,14 @@ static int txgbe_open(struct net_device
 
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
@@ -375,6 +379,9 @@ static int txgbe_open(struct net_device
 
 err_free_irq:
 	wx_free_irq(wx);
+err_free_misc_irq:
+	txgbe_free_misc_irq(wx->priv);
+	wx_reset_interrupt_capability(wx);
 err_free_resources:
 	wx_free_resources(wx);
 err_reset:
@@ -415,6 +422,7 @@ static int txgbe_close(struct net_device
 	wx_ptp_stop(wx);
 	txgbe_down(wx);
 	wx_free_irq(wx);
+	txgbe_free_misc_irq(wx->priv);
 	wx_free_resources(wx);
 	txgbe_fdir_filter_exit(wx);
 	wx_control_hw(wx, false);
@@ -460,7 +468,6 @@ static void txgbe_shutdown(struct pci_de
 int txgbe_setup_tc(struct net_device *dev, u8 tc)
 {
 	struct wx *wx = netdev_priv(dev);
-	struct txgbe *txgbe = wx->priv;
 
 	/* Hardware has to reinitialize queues and interrupts to
 	 * match packet buffer alignment. Unfortunately, the
@@ -471,7 +478,6 @@ int txgbe_setup_tc(struct net_device *de
 	else
 		txgbe_reset(wx);
 
-	txgbe_free_misc_irq(txgbe);
 	wx_clear_interrupt_scheme(wx);
 
 	if (tc)
@@ -480,7 +486,6 @@ int txgbe_setup_tc(struct net_device *de
 		netdev_reset_tc(dev);
 
 	wx_init_interrupt_scheme(wx);
-	txgbe_setup_misc_irq(txgbe);
 
 	if (netif_running(dev))
 		txgbe_open(dev);
@@ -729,13 +734,9 @@ static int txgbe_probe(struct pci_dev *p
 
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
@@ -763,8 +764,6 @@ static int txgbe_probe(struct pci_dev *p
 
 err_remove_phy:
 	txgbe_remove_phy(txgbe);
-err_free_misc_irq:
-	txgbe_free_misc_irq(txgbe);
 err_release_hw:
 	wx_clear_interrupt_scheme(wx);
 	wx_control_hw(wx, false);
@@ -798,7 +797,6 @@ static void txgbe_remove(struct pci_dev
 	unregister_netdev(netdev);
 
 	txgbe_remove_phy(txgbe);
-	txgbe_free_misc_irq(txgbe);
 	wx_free_isb_resources(wx);
 
 	pci_release_selected_regions(pdev,



