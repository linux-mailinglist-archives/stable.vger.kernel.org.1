Return-Path: <stable+bounces-177230-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CFDECB4045E
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 15:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A9F31887412
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 13:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFEF930DD12;
	Tue,  2 Sep 2025 13:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1mmbW0aT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892FE3054E7;
	Tue,  2 Sep 2025 13:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756819995; cv=none; b=sknu3kozo7MmyNiYvihJIgjZoc0x9p5v1J4jz+jKg/JNpVIDKh4F34okyAO4+w2u583PpqqlXdM8frA0T7ZbawB9mZSjhS6DZBqOHRf7I+74MtN1bu4VFhXY5JGgUkSzb2QZ3m0wzB82JOYY/N6HbHKWou5KATMHoA5xZiYxP0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756819995; c=relaxed/simple;
	bh=cymjOLMXKfkMnEq8oBzdccR9CIR9zRFLaXiG2EQ1CXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RIG24pA98xoajYCxI2haStmYeVCFKvuplQpYRoxIsBT1bv/+9QYHXOND5kmmoINcjGuAIbZctUSolUYNUGi+grqNgdF+Phyfs3k/YUl9TOeuPCCmgCyAIYcnKR+HXjUpHKjmn6FYljLyv1PtGH0Oy0AbkjrIB5TlOHh5yA9UrCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1mmbW0aT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB4CFC4CEF5;
	Tue,  2 Sep 2025 13:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756819995;
	bh=cymjOLMXKfkMnEq8oBzdccR9CIR9zRFLaXiG2EQ1CXo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1mmbW0aTsB4MU5TxHSKoa4rWzVVSXJvcm2nWsaNpnhqJzMPXu1Gf9zLlO23u4ADA1
	 t6KnstGfcx8EOAIBDGyPTQbZR2W76bWPedrh2BrmfMRy9HAkRFCb24/fWIk8d1ogj2
	 j8/BNCIOSnLyacwdayz/zgzMYnru6mFpM5o6wgPs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dipayaan Roy <dipayanroy@linux.microsoft.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 58/95] net: hv_netvsc: fix loss of early receive events from host during channel open.
Date: Tue,  2 Sep 2025 15:20:34 +0200
Message-ID: <20250902131941.829985041@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250902131939.601201881@linuxfoundation.org>
References: <20250902131939.601201881@linuxfoundation.org>
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

From: Dipayaan Roy <dipayanroy@linux.microsoft.com>

[ Upstream commit 9448ccd853368582efa9db05db344f8bb9dffe0f ]

The hv_netvsc driver currently enables NAPI after opening the primary and
subchannels. This ordering creates a race: if the Hyper-V host places data
in the host -> guest ring buffer and signals the channel before
napi_enable() has been called, the channel callback will run but
napi_schedule_prep() will return false. As a result, the NAPI poller never
gets scheduled, the data in the ring buffer is not consumed, and the
receive queue may remain permanently stuck until another interrupt happens
to arrive.

Fix this by enabling NAPI and registering it with the RX/TX queues before
vmbus channel is opened. This guarantees that any early host signal after
open will correctly trigger NAPI scheduling and the ring buffer will be
drained.

Fixes: 76bb5db5c749d ("netvsc: fix use after free on module removal")
Signed-off-by: Dipayaan Roy <dipayanroy@linux.microsoft.com>
Link: https://patch.msgid.link/20250825115627.GA32189@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/hyperv/netvsc.c       | 17 ++++++++---------
 drivers/net/hyperv/rndis_filter.c | 23 ++++++++++++++++-------
 2 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
index 87ac2a5f18091..5f14799b68c53 100644
--- a/drivers/net/hyperv/netvsc.c
+++ b/drivers/net/hyperv/netvsc.c
@@ -1811,6 +1811,11 @@ struct netvsc_device *netvsc_device_add(struct hv_device *device,
 
 	/* Enable NAPI handler before init callbacks */
 	netif_napi_add(ndev, &net_device->chan_table[0].napi, netvsc_poll);
+	napi_enable(&net_device->chan_table[0].napi);
+	netif_queue_set_napi(ndev, 0, NETDEV_QUEUE_TYPE_RX,
+			     &net_device->chan_table[0].napi);
+	netif_queue_set_napi(ndev, 0, NETDEV_QUEUE_TYPE_TX,
+			     &net_device->chan_table[0].napi);
 
 	/* Open the channel */
 	device->channel->next_request_id_callback = vmbus_next_request_id;
@@ -1830,12 +1835,6 @@ struct netvsc_device *netvsc_device_add(struct hv_device *device,
 	/* Channel is opened */
 	netdev_dbg(ndev, "hv_netvsc channel opened successfully\n");
 
-	napi_enable(&net_device->chan_table[0].napi);
-	netif_queue_set_napi(ndev, 0, NETDEV_QUEUE_TYPE_RX,
-			     &net_device->chan_table[0].napi);
-	netif_queue_set_napi(ndev, 0, NETDEV_QUEUE_TYPE_TX,
-			     &net_device->chan_table[0].napi);
-
 	/* Connect with the NetVsp */
 	ret = netvsc_connect_vsp(device, net_device, device_info);
 	if (ret != 0) {
@@ -1853,14 +1852,14 @@ struct netvsc_device *netvsc_device_add(struct hv_device *device,
 
 close:
 	RCU_INIT_POINTER(net_device_ctx->nvdev, NULL);
-	netif_queue_set_napi(ndev, 0, NETDEV_QUEUE_TYPE_TX, NULL);
-	netif_queue_set_napi(ndev, 0, NETDEV_QUEUE_TYPE_RX, NULL);
-	napi_disable(&net_device->chan_table[0].napi);
 
 	/* Now, we can close the channel safely */
 	vmbus_close(device->channel);
 
 cleanup:
+	netif_queue_set_napi(ndev, 0, NETDEV_QUEUE_TYPE_TX, NULL);
+	netif_queue_set_napi(ndev, 0, NETDEV_QUEUE_TYPE_RX, NULL);
+	napi_disable(&net_device->chan_table[0].napi);
 	netif_napi_del(&net_device->chan_table[0].napi);
 
 cleanup2:
diff --git a/drivers/net/hyperv/rndis_filter.c b/drivers/net/hyperv/rndis_filter.c
index 9b8769a8b77a1..9a92552ee35c2 100644
--- a/drivers/net/hyperv/rndis_filter.c
+++ b/drivers/net/hyperv/rndis_filter.c
@@ -1252,17 +1252,26 @@ static void netvsc_sc_open(struct vmbus_channel *new_sc)
 	new_sc->rqstor_size = netvsc_rqstor_size(netvsc_ring_bytes);
 	new_sc->max_pkt_size = NETVSC_MAX_PKT_SIZE;
 
+	/* Enable napi before opening the vmbus channel to avoid races
+	 * as the host placing data on the host->guest ring may be left
+	 * out if napi was not enabled.
+	 */
+	napi_enable(&nvchan->napi);
+	netif_queue_set_napi(ndev, chn_index, NETDEV_QUEUE_TYPE_RX,
+			     &nvchan->napi);
+	netif_queue_set_napi(ndev, chn_index, NETDEV_QUEUE_TYPE_TX,
+			     &nvchan->napi);
+
 	ret = vmbus_open(new_sc, netvsc_ring_bytes,
 			 netvsc_ring_bytes, NULL, 0,
 			 netvsc_channel_cb, nvchan);
-	if (ret == 0) {
-		napi_enable(&nvchan->napi);
-		netif_queue_set_napi(ndev, chn_index, NETDEV_QUEUE_TYPE_RX,
-				     &nvchan->napi);
-		netif_queue_set_napi(ndev, chn_index, NETDEV_QUEUE_TYPE_TX,
-				     &nvchan->napi);
-	} else {
+	if (ret != 0) {
 		netdev_notice(ndev, "sub channel open failed: %d\n", ret);
+		netif_queue_set_napi(ndev, chn_index, NETDEV_QUEUE_TYPE_TX,
+				     NULL);
+		netif_queue_set_napi(ndev, chn_index, NETDEV_QUEUE_TYPE_RX,
+				     NULL);
+		napi_disable(&nvchan->napi);
 	}
 
 	if (atomic_inc_return(&nvscdev->open_chn) == nvscdev->num_chn)
-- 
2.50.1




