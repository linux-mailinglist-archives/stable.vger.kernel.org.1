Return-Path: <stable+bounces-226200-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBzfCsaFuWkPJAIAu9opvQ
	(envelope-from <stable+bounces-226200-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:48:06 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B86E92AE6FE
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ADC7F305AC8D
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 16:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C66C3ED5A8;
	Tue, 17 Mar 2026 16:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PCpKU0/4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C273ECBFE;
	Tue, 17 Mar 2026 16:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773765689; cv=none; b=Z2F/QPJpYRohDtnX14J1kHmjL4yfBC4b6ko9qoVjobBKKzq66ED8JJQ1OJdqTE+zxT0jzmHV5pfgOiNIBxQyJYnEQRqAfCJBbr8htL9XVrh5eLYRkPdfECb5UyCg+4bUek9lJj9F+80p+5mFijgvYl5oHlNTqL7+2C/XW0NZqxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773765689; c=relaxed/simple;
	bh=dLgZh86ZzQyGGsYaNnfBpisKYVi9EediAs28lQJn1fQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z+jRkTF6v5jDa7ivlSzk66j3kycQ3+vSwh15r429y91TpSEZvvwQdmTnHvlyVxQjURcj7GMRjmyPD/l+dpJ3a8jBzTqldsNAzXeB4PdfqZdiIQ/jMLOYOBI/bzAXdnXwszbEPyCbm6mgBo3dfIAuLmQPCkWy249UNK+0ZMsKU9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PCpKU0/4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCA58C4CEF7;
	Tue, 17 Mar 2026 16:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773765689;
	bh=dLgZh86ZzQyGGsYaNnfBpisKYVi9EediAs28lQJn1fQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PCpKU0/4CupW/gNn+/QRR/E8XN93hxjCLFRG3NFokBudkIVI/ImYds+DA0icafG8H
	 EozzrM8irgj0Bfdr4gZjQOQunAENzExnKAB/1VkvXozC/ErfFRl0W48Iv5FvRvivBB
	 rAzpH80JVf5CMs1DuXxVgnp1yVByE9YrUWz64nAg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Raju Rangoju <Raju.Rangoju@amd.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 071/378] amd-xgbe: prevent CRC errors during RX adaptation with AN disabled
Date: Tue, 17 Mar 2026 17:30:28 +0100
Message-ID: <20260317163009.629977554@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317163006.959177102@linuxfoundation.org>
References: <20260317163006.959177102@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-226200-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid,amd.com:email,msgid.link:url]
X-Rspamd-Queue-Id: B86E92AE6FE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Raju Rangoju <Raju.Rangoju@amd.com>

[ Upstream commit 27a4dd0c702b3b2b9cf2c045d100cc2fe8720b81 ]

When operating in 10GBASE-KR mode with auto-negotiation disabled and RX
adaptation enabled, CRC errors can occur during the RX adaptation
process. This happens because the driver continues transmitting and
receiving packets while adaptation is in progress.

Fix this by stopping TX/RX immediately when the link goes down and RX
adaptation needs to be re-triggered, and only re-enabling TX/RX after
adaptation completes and the link is confirmed up. Introduce a flag to
track whether TX/RX was disabled for adaptation so it can be restored
correctly.

This prevents packets from being transmitted or received during the RX
adaptation window and avoids CRC errors from corrupted frames.

The flag tracking the data path state is synchronized with hardware
state in xgbe_start() to prevent stale state after device restarts.
This ensures that after a restart cycle (where xgbe_stop disables
TX/RX and xgbe_start re-enables them), the flag correctly reflects
that the data path is active.

Fixes: 4f3b20bfbb75 ("amd-xgbe: add support for rx-adaptation")
Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
Link: https://patch.msgid.link/20260306111629.1515676-3-Raju.Rangoju@amd.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/amd/xgbe/xgbe-drv.c    |  4 ++
 drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c | 63 ++++++++++++++++++++-
 drivers/net/ethernet/amd/xgbe/xgbe.h        |  4 ++
 3 files changed, 69 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
index 20ce2ed4cd9f7..3444ec681a11f 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
@@ -1277,6 +1277,10 @@ static int xgbe_start(struct xgbe_prv_data *pdata)
 
 	hw_if->enable_tx(pdata);
 	hw_if->enable_rx(pdata);
+	/* Synchronize flag with hardware state after enabling TX/RX.
+	 * This prevents stale state after device restart cycles.
+	 */
+	pdata->data_path_stopped = false;
 
 	udp_tunnel_nic_reset_ntf(netdev);
 
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c b/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c
index 13c556dc0d67a..b8cf6ccfe6414 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c
@@ -2017,6 +2017,48 @@ static void xgbe_phy_rx_adaptation(struct xgbe_prv_data *pdata)
 	xgbe_rx_adaptation(pdata);
 }
 
+/*
+ * xgbe_phy_stop_data_path - Stop TX/RX to prevent packet corruption
+ * @pdata: driver private data
+ *
+ * This function stops the data path (TX and RX) to prevent packet
+ * corruption during critical PHY operations like RX adaptation.
+ * Must be called before initiating RX adaptation when link goes down.
+ */
+static void xgbe_phy_stop_data_path(struct xgbe_prv_data *pdata)
+{
+	if (pdata->data_path_stopped)
+		return;
+
+	/* Stop TX/RX to prevent packet corruption during RX adaptation */
+	pdata->hw_if.disable_tx(pdata);
+	pdata->hw_if.disable_rx(pdata);
+	pdata->data_path_stopped = true;
+
+	netif_dbg(pdata, link, pdata->netdev,
+		  "stopping data path for RX adaptation\n");
+}
+
+/*
+ * xgbe_phy_start_data_path - Re-enable TX/RX after RX adaptation
+ * @pdata: driver private data
+ *
+ * This function re-enables the data path (TX and RX) after RX adaptation
+ * has completed successfully. Only called when link is confirmed up.
+ */
+static void xgbe_phy_start_data_path(struct xgbe_prv_data *pdata)
+{
+	if (!pdata->data_path_stopped)
+		return;
+
+	pdata->hw_if.enable_rx(pdata);
+	pdata->hw_if.enable_tx(pdata);
+	pdata->data_path_stopped = false;
+
+	netif_dbg(pdata, link, pdata->netdev,
+		  "restarting data path after RX adaptation\n");
+}
+
 static void xgbe_phy_rx_reset(struct xgbe_prv_data *pdata)
 {
 	int reg;
@@ -2810,13 +2852,27 @@ static int xgbe_phy_link_status(struct xgbe_prv_data *pdata, int *an_restart)
 	if (pdata->en_rx_adap) {
 		/* if the link is available and adaptation is done,
 		 * declare link up
+		 *
+		 * Note: When link is up and adaptation is done, we can
+		 * safely re-enable the data path if it was stopped
+		 * for adaptation.
 		 */
-		if ((reg & MDIO_STAT1_LSTATUS) && pdata->rx_adapt_done)
+		if ((reg & MDIO_STAT1_LSTATUS) && pdata->rx_adapt_done) {
+			xgbe_phy_start_data_path(pdata);
 			return 1;
+		}
 		/* If either link is not available or adaptation is not done,
 		 * retrigger the adaptation logic. (if the mode is not set,
 		 * then issue mailbox command first)
 		 */
+
+		/* CRITICAL: Stop data path BEFORE triggering RX adaptation
+		 * to prevent CRC errors from packets corrupted during
+		 * the adaptation process. This is especially important
+		 * when AN is OFF in 10G KR mode.
+		 */
+		xgbe_phy_stop_data_path(pdata);
+
 		if (pdata->mode_set) {
 			xgbe_phy_rx_adaptation(pdata);
 		} else {
@@ -2824,8 +2880,11 @@ static int xgbe_phy_link_status(struct xgbe_prv_data *pdata, int *an_restart)
 			xgbe_phy_set_mode(pdata, phy_data->cur_mode);
 		}
 
-		if (pdata->rx_adapt_done)
+		if (pdata->rx_adapt_done) {
+			/* Adaptation complete, safe to re-enable data path */
+			xgbe_phy_start_data_path(pdata);
 			return 1;
+		}
 	} else if (reg & MDIO_STAT1_LSTATUS)
 		return 1;
 
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe.h b/drivers/net/ethernet/amd/xgbe/xgbe.h
index 4ba23779b2b7e..3bc748c7cb24d 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe.h
+++ b/drivers/net/ethernet/amd/xgbe/xgbe.h
@@ -1242,6 +1242,10 @@ struct xgbe_prv_data {
 	bool en_rx_adap;
 	int rx_adapt_retries;
 	bool rx_adapt_done;
+	/* Flag to track if data path (TX/RX) was stopped for RX adaptation.
+	 * This prevents packet corruption during the adaptation window.
+	 */
+	bool data_path_stopped;
 	bool mode_set;
 	bool sph;
 };
-- 
2.51.0




