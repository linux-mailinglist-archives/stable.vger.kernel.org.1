Return-Path: <stable+bounces-75661-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC4B973A7A
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 16:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E3F71C21709
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 14:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70F419923F;
	Tue, 10 Sep 2024 14:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iUMcKLAc"
X-Original-To: stable@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C423195FF0
	for <stable@vger.kernel.org>; Tue, 10 Sep 2024 14:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725979577; cv=none; b=r6BX2CWHzC+OQTH/jBQi+qJchEp6jLUPjQx9lAK+ABTmt4oIH86dlmREOR7Z4V9Gi5Aw5hunE8hYoSIRu5Z+yetDR3qSjz5IFJyL/zxJAYX5r0wIXdTDHAy6cRm7hdlOJUcGhUpuVC0C7QoSEK60bNp26CwjL52tzAyDTqYGZg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725979577; c=relaxed/simple;
	bh=QBQk8iEl6dze3RqfOohVjGnZZGYiaro2GBcvmc5s/gY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Yeus+DJa/o9fDyc/LlcL5EPT4vFXbOEJqr765WVR5P8ErTzKEPpfWByN1846t2NqCp0ttDJrlzLeGmNqwuhpzlf0+yiMO6NmFWUnTapiDNjeZ+mcXKk/x2fkjTOB18ju2WpTU4U42TFKBLKy239qlVP5Tb7Qrv/Gl9nt1sdbwBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iUMcKLAc; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725979573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=91pcgJ708frT9old80OB7Wl+qRXeJwKQ6vzaIr7kfRI=;
	b=iUMcKLAcclvFKINvIEn1pRZj6T8D2erJuxaJyhAa98KvcntNO1uhFgFKr8vlNDnFzLRvwA
	uPmQKhUvUxySpeTByVTMsGJ61Tb0Fpzl/eRtAdcq4uaAplBVfXp3BhevPmMcuV2e171n4c
	Tb0Vm0XYKANLZktjnHPgthRO0nsTgG8=
From: Sean Anderson <sean.anderson@linux.dev>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH] net: xilinx: axienet: Fix race in axienet_stop
Date: Tue, 10 Sep 2024 10:46:07 -0400
Message-Id: <20240910144607.1441863-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

[ Upstream commit 858430db28a5f5a11f8faa3a6fa805438e6f0851 ]

axienet_dma_err_handler can race with axienet_stop in the following
manner:

CPU 1                       CPU 2
======================      ==================
axienet_stop()
    napi_disable()
    axienet_dma_stop()
                            axienet_dma_err_handler()
                                napi_disable()
                                axienet_dma_stop()
                                axienet_dma_start()
                                napi_enable()
    cancel_work_sync()
    free_irq()

Fix this by setting a flag in axienet_stop telling
axienet_dma_err_handler not to bother doing anything. I chose not to use
disable_work_sync to allow for easier backporting.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
Fixes: 8a3b7a252dca ("drivers/net/ethernet/xilinx: added Xilinx AXI Ethernet driver")
Link: https://patch.msgid.link/20240903175141.4132898-1-sean.anderson@linux.dev
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Adjusted to apply before dmaengine support ]
Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---
This patch is adjusted to apply to v6.6 kernels and earlier, which do
not contain commit 6a91b846af85 ("net: axienet: Introduce dmaengine
support").

 drivers/net/ethernet/xilinx/xilinx_axienet.h      | 3 +++
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 8 ++++++++
 2 files changed, 11 insertions(+)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet.h b/drivers/net/ethernet/xilinx/xilinx_axienet.h
index f09f10f17d7e..2facbdfbb319 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet.h
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet.h
@@ -419,6 +419,8 @@ struct axidma_bd {
  * @tx_bytes:	TX byte count for statistics
  * @tx_stat_sync: Synchronization object for TX stats
  * @dma_err_task: Work structure to process Axi DMA errors
+ * @stopping:   Set when @dma_err_task shouldn't do anything because we are
+ *              about to stop the device.
  * @tx_irq:	Axidma TX IRQ number
  * @rx_irq:	Axidma RX IRQ number
  * @eth_irq:	Ethernet core IRQ number
@@ -481,6 +483,7 @@ struct axienet_local {
 	struct u64_stats_sync tx_stat_sync;
 
 	struct work_struct dma_err_task;
+	bool stopping;
 
 	int tx_irq;
 	int rx_irq;
diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 144feb7a2fda..65d7aaad43fe 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -1162,6 +1162,7 @@ static int axienet_open(struct net_device *ndev)
 	phylink_start(lp->phylink);
 
 	/* Enable worker thread for Axi DMA error handling */
+	lp->stopping = false;
 	INIT_WORK(&lp->dma_err_task, axienet_dma_err_handler);
 
 	napi_enable(&lp->napi_rx);
@@ -1217,6 +1218,9 @@ static int axienet_stop(struct net_device *ndev)
 
 	dev_dbg(&ndev->dev, "axienet_close()\n");
 
+	WRITE_ONCE(lp->stopping, true);
+	flush_work(&lp->dma_err_task);
+
 	napi_disable(&lp->napi_tx);
 	napi_disable(&lp->napi_rx);
 
@@ -1761,6 +1765,10 @@ static void axienet_dma_err_handler(struct work_struct *work)
 						dma_err_task);
 	struct net_device *ndev = lp->ndev;
 
+	/* Don't bother if we are going to stop anyway */
+	if (READ_ONCE(lp->stopping))
+		return;
+
 	napi_disable(&lp->napi_tx);
 	napi_disable(&lp->napi_rx);
 
-- 
2.35.1.1320.gc452695387.dirty


