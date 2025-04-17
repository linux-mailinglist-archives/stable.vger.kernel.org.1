Return-Path: <stable+bounces-133326-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1430A92522
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 20:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89FFB1B61918
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 18:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 231B6256C77;
	Thu, 17 Apr 2025 17:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="M4hW7+l7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C2F25525A;
	Thu, 17 Apr 2025 17:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744912744; cv=none; b=Md3rNzWm3NviTmW/xu/f9e73G8HC0Z5lRtoiQvaFMPjO3KYZMNpPKNx7KjrBfqqH5tgiUsc71WGGEuHcBmilVEG3RoaHM8RT/gWzScCF+6bOZ3/gnhPVcv0nCLvsohoQHTXdLxzckSEKaJfwG6+n+rqsez/68x+B8gWbb34yRKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744912744; c=relaxed/simple;
	bh=pwNbpP5oT53udUxysYNgwAg3jN9p6GynO6dTEGswXWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=clUZvAHLA7h26PVMXIpXrP6MnOIysB/sTl4AA5NLKv5V+yCsDCxoTi6E6IMoAqNMqGZ8fWkjztBfRS4cepnf0eH1DuOWzfFGt2QZZb+4zI+ObmIcLO0y2mzqNt2SvY/iZdltv3qkclrDNrHvghHYyilXRc7D8cLAgBOb+JiigQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=M4hW7+l7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DA9DC4CEE4;
	Thu, 17 Apr 2025 17:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744912744;
	bh=pwNbpP5oT53udUxysYNgwAg3jN9p6GynO6dTEGswXWQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M4hW7+l7+aROAbGpCPfSBbuFhy0l5wExyLja08XKVilzKSwSRodnF9gfn44NepDxu
	 lsLkdmilsNWfprGeteyDhX76uRWwcTG35ypJxWRDu6VTf25E81nzuvT4kGH6wOnHhq
	 GyJ10hplBwVUe9gLcFY77+WcDVjOWPvpT9tHNBM4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 111/449] can: flexcan: Add quirk to handle separate interrupt lines for mailboxes
Date: Thu, 17 Apr 2025 19:46:39 +0200
Message-ID: <20250417175122.433047649@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250417175117.964400335@linuxfoundation.org>
References: <20250417175117.964400335@linuxfoundation.org>
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

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

[ Upstream commit 8c652cf030a769fbfc73cfc280ed3f1656343c35 ]

Introduce 'FLEXCAN_QUIRK_SECONDARY_MB_IRQ' quirk to handle a FlexCAN
hardware module integration particularity where two ranges of mailboxes
are controlled by separate hardware interrupt lines.
The same 'flexcan_irq' handler is used for both separate mailbox interrupt
lines, with no other changes.

Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Link: https://patch.msgid.link/20250113120704.522307-3-ciprianmarian.costea@oss.nxp.com
[mkl: flexcan_open(): change order and free irq_secondary_mb first]
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/can/flexcan/flexcan-core.c | 24 +++++++++++++++++++++++-
 drivers/net/can/flexcan/flexcan.h      |  5 +++++
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
index b080740bcb104..1a94586cbd11e 100644
--- a/drivers/net/can/flexcan/flexcan-core.c
+++ b/drivers/net/can/flexcan/flexcan-core.c
@@ -1762,14 +1762,25 @@ static int flexcan_open(struct net_device *dev)
 			goto out_free_irq_boff;
 	}
 
+	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SECONDARY_MB_IRQ) {
+		err = request_irq(priv->irq_secondary_mb,
+				  flexcan_irq, IRQF_SHARED, dev->name, dev);
+		if (err)
+			goto out_free_irq_err;
+	}
+
 	flexcan_chip_interrupts_enable(dev);
 
 	netif_start_queue(dev);
 
 	return 0;
 
+ out_free_irq_err:
+	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_3)
+		free_irq(priv->irq_err, dev);
  out_free_irq_boff:
-	free_irq(priv->irq_boff, dev);
+	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_3)
+		free_irq(priv->irq_boff, dev);
  out_free_irq:
 	free_irq(dev->irq, dev);
  out_can_rx_offload_disable:
@@ -1794,6 +1805,9 @@ static int flexcan_close(struct net_device *dev)
 	netif_stop_queue(dev);
 	flexcan_chip_interrupts_disable(dev);
 
+	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SECONDARY_MB_IRQ)
+		free_irq(priv->irq_secondary_mb, dev);
+
 	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_3) {
 		free_irq(priv->irq_err, dev);
 		free_irq(priv->irq_boff, dev);
@@ -2187,6 +2201,14 @@ static int flexcan_probe(struct platform_device *pdev)
 		}
 	}
 
+	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SECONDARY_MB_IRQ) {
+		priv->irq_secondary_mb = platform_get_irq_byname(pdev, "mb-1");
+		if (priv->irq_secondary_mb < 0) {
+			err = priv->irq_secondary_mb;
+			goto failed_platform_get_irq;
+		}
+	}
+
 	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SUPPORT_FD) {
 		priv->can.ctrlmode_supported |= CAN_CTRLMODE_FD |
 			CAN_CTRLMODE_FD_NON_ISO;
diff --git a/drivers/net/can/flexcan/flexcan.h b/drivers/net/can/flexcan/flexcan.h
index 4933d8c7439e6..2cf886618c962 100644
--- a/drivers/net/can/flexcan/flexcan.h
+++ b/drivers/net/can/flexcan/flexcan.h
@@ -70,6 +70,10 @@
 #define FLEXCAN_QUIRK_SUPPORT_RX_FIFO BIT(16)
 /* Setup stop mode with ATF SCMI protocol to support wakeup */
 #define FLEXCAN_QUIRK_SETUP_STOP_MODE_SCMI BIT(17)
+/* Device has two separate interrupt lines for two mailbox ranges, which
+ * both need to have an interrupt handler registered.
+ */
+#define FLEXCAN_QUIRK_SECONDARY_MB_IRQ	BIT(18)
 
 struct flexcan_devtype_data {
 	u32 quirks;		/* quirks needed for different IP cores */
@@ -107,6 +111,7 @@ struct flexcan_priv {
 
 	int irq_boff;
 	int irq_err;
+	int irq_secondary_mb;
 
 	/* IPC handle when setup stop mode by System Controller firmware(scfw) */
 	struct imx_sc_ipc *sc_ipc_handle;
-- 
2.39.5




