Return-Path: <stable+bounces-142739-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B763FAAEBFB
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 21:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D8445275B9
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 19:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED25828C2B3;
	Wed,  7 May 2025 19:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Tw3Wna/c"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9893214813;
	Wed,  7 May 2025 19:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746645180; cv=none; b=cixGybQLTnpg6AiM1rzQbVyP4+wd2YgKLT+Py6dcFHLB+QDmT1fFYeE5/1WUYr0CAjSm57NVfxv+ZTZhYOPPi0nzhRxbd799Riwzh62sp18MDODATjgp5GjOi1fIERufHgGPEMYxQK+zJ6IGy4hO0tB4baHAic9EctylKAfi1jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746645180; c=relaxed/simple;
	bh=ksdHCm0dVIDfkGz2e12oj6qLdI/e1S9CU68Oz9iByVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sig46gEXJJvRBp3fBqyLamtzOfkcqsnz4KzD4EgSABfQRFmG40AMpg2WOOIHnyE113NNNO2kySfFvPN9KFkvxsnMZMlv6NS6E8MK5xG8X1zu/aIT7co71Y02Gt+4Z91+bME5neXGEBHKarogdRObhrVgZRmkahvbMpeEWJiLbVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Tw3Wna/c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3973C4CEE2;
	Wed,  7 May 2025 19:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746645180;
	bh=ksdHCm0dVIDfkGz2e12oj6qLdI/e1S9CU68Oz9iByVY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Tw3Wna/cCitlP3OVVyFmt3u0JnmrBJtNvOlPgRPNl7fYXzxETAMBOouqkrbAmZ4PG
	 tznvYucICDMlfqMYrJ9XitnSEqErWcGhhLfgqfXhnFNZalsKOwKvg4WJRLE+c4Xojr
	 ax9ESO2yTgtnyR94n259BF9QaJ+7t4eyRfPaFoRg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yonglong Liu <liuyonglong@huawei.com>,
	Jijie Shao <shaojijie@huawei.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 089/129] net: hns3: fix an interrupt residual problem
Date: Wed,  7 May 2025 20:40:25 +0200
Message-ID: <20250507183817.109945511@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250507183813.500572371@linuxfoundation.org>
References: <20250507183813.500572371@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yonglong Liu <liuyonglong@huawei.com>

[ Upstream commit 8e6b9c6ea5a55045eed6526d8ee49e93192d1a58 ]

When a VF is passthrough to a VM, and the VM is killed, the reported
interrupt may not been handled, it will remain, and won't be clear by
the nic engine even with a flr or tqp reset. When the VM restart, the
interrupt of the first vector may be dropped by the second enable_irq
in vfio, see the issue below:
https://gitlab.com/qemu-project/qemu/-/issues/2884#note_2423361621

We notice that the vfio has always behaved this way, and the interrupt
is a residue of the nic engine, so we fix the problem by moving the
vector enable process out of the enable_irq loop.

Fixes: 08a100689d4b ("net: hns3: re-organize vector handle")
Signed-off-by: Yonglong Liu <liuyonglong@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
Link: https://patch.msgid.link/20250430093052.2400464-3-shaojijie@huawei.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/hisilicon/hns3/hns3_enet.c   | 82 +++++++++----------
 1 file changed, 39 insertions(+), 43 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 801801e8803e9..0ed01f4d68061 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -473,20 +473,14 @@ static void hns3_mask_vector_irq(struct hns3_enet_tqp_vector *tqp_vector,
 	writel(mask_en, tqp_vector->mask_addr);
 }
 
-static void hns3_vector_enable(struct hns3_enet_tqp_vector *tqp_vector)
+static void hns3_irq_enable(struct hns3_enet_tqp_vector *tqp_vector)
 {
 	napi_enable(&tqp_vector->napi);
 	enable_irq(tqp_vector->vector_irq);
-
-	/* enable vector */
-	hns3_mask_vector_irq(tqp_vector, 1);
 }
 
-static void hns3_vector_disable(struct hns3_enet_tqp_vector *tqp_vector)
+static void hns3_irq_disable(struct hns3_enet_tqp_vector *tqp_vector)
 {
-	/* disable vector */
-	hns3_mask_vector_irq(tqp_vector, 0);
-
 	disable_irq(tqp_vector->vector_irq);
 	napi_disable(&tqp_vector->napi);
 	cancel_work_sync(&tqp_vector->rx_group.dim.work);
@@ -707,11 +701,42 @@ static int hns3_set_rx_cpu_rmap(struct net_device *netdev)
 	return 0;
 }
 
+static void hns3_enable_irqs_and_tqps(struct net_device *netdev)
+{
+	struct hns3_nic_priv *priv = netdev_priv(netdev);
+	struct hnae3_handle *h = priv->ae_handle;
+	u16 i;
+
+	for (i = 0; i < priv->vector_num; i++)
+		hns3_irq_enable(&priv->tqp_vector[i]);
+
+	for (i = 0; i < priv->vector_num; i++)
+		hns3_mask_vector_irq(&priv->tqp_vector[i], 1);
+
+	for (i = 0; i < h->kinfo.num_tqps; i++)
+		hns3_tqp_enable(h->kinfo.tqp[i]);
+}
+
+static void hns3_disable_irqs_and_tqps(struct net_device *netdev)
+{
+	struct hns3_nic_priv *priv = netdev_priv(netdev);
+	struct hnae3_handle *h = priv->ae_handle;
+	u16 i;
+
+	for (i = 0; i < h->kinfo.num_tqps; i++)
+		hns3_tqp_disable(h->kinfo.tqp[i]);
+
+	for (i = 0; i < priv->vector_num; i++)
+		hns3_mask_vector_irq(&priv->tqp_vector[i], 0);
+
+	for (i = 0; i < priv->vector_num; i++)
+		hns3_irq_disable(&priv->tqp_vector[i]);
+}
+
 static int hns3_nic_net_up(struct net_device *netdev)
 {
 	struct hns3_nic_priv *priv = netdev_priv(netdev);
 	struct hnae3_handle *h = priv->ae_handle;
-	int i, j;
 	int ret;
 
 	ret = hns3_nic_reset_all_ring(h);
@@ -720,23 +745,13 @@ static int hns3_nic_net_up(struct net_device *netdev)
 
 	clear_bit(HNS3_NIC_STATE_DOWN, &priv->state);
 
-	/* enable the vectors */
-	for (i = 0; i < priv->vector_num; i++)
-		hns3_vector_enable(&priv->tqp_vector[i]);
-
-	/* enable rcb */
-	for (j = 0; j < h->kinfo.num_tqps; j++)
-		hns3_tqp_enable(h->kinfo.tqp[j]);
+	hns3_enable_irqs_and_tqps(netdev);
 
 	/* start the ae_dev */
 	ret = h->ae_algo->ops->start ? h->ae_algo->ops->start(h) : 0;
 	if (ret) {
 		set_bit(HNS3_NIC_STATE_DOWN, &priv->state);
-		while (j--)
-			hns3_tqp_disable(h->kinfo.tqp[j]);
-
-		for (j = i - 1; j >= 0; j--)
-			hns3_vector_disable(&priv->tqp_vector[j]);
+		hns3_disable_irqs_and_tqps(netdev);
 	}
 
 	return ret;
@@ -823,17 +838,9 @@ static void hns3_reset_tx_queue(struct hnae3_handle *h)
 static void hns3_nic_net_down(struct net_device *netdev)
 {
 	struct hns3_nic_priv *priv = netdev_priv(netdev);
-	struct hnae3_handle *h = hns3_get_handle(netdev);
 	const struct hnae3_ae_ops *ops;
-	int i;
 
-	/* disable vectors */
-	for (i = 0; i < priv->vector_num; i++)
-		hns3_vector_disable(&priv->tqp_vector[i]);
-
-	/* disable rcb */
-	for (i = 0; i < h->kinfo.num_tqps; i++)
-		hns3_tqp_disable(h->kinfo.tqp[i]);
+	hns3_disable_irqs_and_tqps(netdev);
 
 	/* stop ae_dev */
 	ops = priv->ae_handle->ae_algo->ops;
@@ -5870,8 +5877,6 @@ int hns3_set_channels(struct net_device *netdev,
 void hns3_external_lb_prepare(struct net_device *ndev, bool if_running)
 {
 	struct hns3_nic_priv *priv = netdev_priv(ndev);
-	struct hnae3_handle *h = priv->ae_handle;
-	int i;
 
 	if (!if_running)
 		return;
@@ -5882,11 +5887,7 @@ void hns3_external_lb_prepare(struct net_device *ndev, bool if_running)
 	netif_carrier_off(ndev);
 	netif_tx_disable(ndev);
 
-	for (i = 0; i < priv->vector_num; i++)
-		hns3_vector_disable(&priv->tqp_vector[i]);
-
-	for (i = 0; i < h->kinfo.num_tqps; i++)
-		hns3_tqp_disable(h->kinfo.tqp[i]);
+	hns3_disable_irqs_and_tqps(ndev);
 
 	/* delay ring buffer clearing to hns3_reset_notify_uninit_enet
 	 * during reset process, because driver may not be able
@@ -5902,7 +5903,6 @@ void hns3_external_lb_restore(struct net_device *ndev, bool if_running)
 {
 	struct hns3_nic_priv *priv = netdev_priv(ndev);
 	struct hnae3_handle *h = priv->ae_handle;
-	int i;
 
 	if (!if_running)
 		return;
@@ -5918,11 +5918,7 @@ void hns3_external_lb_restore(struct net_device *ndev, bool if_running)
 
 	clear_bit(HNS3_NIC_STATE_DOWN, &priv->state);
 
-	for (i = 0; i < priv->vector_num; i++)
-		hns3_vector_enable(&priv->tqp_vector[i]);
-
-	for (i = 0; i < h->kinfo.num_tqps; i++)
-		hns3_tqp_enable(h->kinfo.tqp[i]);
+	hns3_enable_irqs_and_tqps(ndev);
 
 	netif_tx_wake_all_queues(ndev);
 
-- 
2.39.5




