Return-Path: <stable+bounces-143395-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1243CAB3F9F
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 19:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 255C1465DAD
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 17:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA8A296FD3;
	Mon, 12 May 2025 17:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Q9OD/nJG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5993A296153;
	Mon, 12 May 2025 17:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747071836; cv=none; b=afLJ4dRBJVyXdiVQaXF5f5mGZN60yFzbF1/q/O9fA+nBgL1q+BtPmBgrQyrYvB4jtND3WckhsQxAoMaajCpipIyM56iLtnAR8bndSnDTcqv1rt2xQ81LehNX/k/+XRLFeMUwWrweeabdZgEMD8JB5jZ+dFQZC+GZP5ipq3kj8R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747071836; c=relaxed/simple;
	bh=LSmYA1oz8CGunlfPdiim7l/j/sassYtzmLz/7uXslQk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c0QXRWBcg2HCC0i3Z0f5MSka+RtZpdrWNZV9wsOTxnQb6MxyUEozDRzKs3ZK3FmVWz+TUd7fYAsLhFkCQ++H/rsvpQjV0Sraf+vuXr6YkM+tiRsnmeuRx1XDpfOgkNROp3yOJxKkwXeo4Jgb57i1+ubcnPu/p1FhMM2UjRfBc9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Q9OD/nJG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE190C4CEEF;
	Mon, 12 May 2025 17:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747071836;
	bh=LSmYA1oz8CGunlfPdiim7l/j/sassYtzmLz/7uXslQk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q9OD/nJG/DDzf9s8f8laxhwnZdfrzA34UYQ6LGp5yEn9UNFHnoo5RsTcn3qGEygAE
	 xDanFg9jQEKl/isXXGPd7dw7eHc2qUKooaKHuwO/43PI3cwHwa4MTwTyMx7fEG3jeG
	 rDydqoJZ5IbgIE0lSBNg+CGDdawUa2kVuhb64GVM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alexander Duyck <alexanderduyck@fb.com>,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 046/197] fbnic: Gate AXI read/write enabling on FW mailbox
Date: Mon, 12 May 2025 19:38:16 +0200
Message-ID: <20250512172046.265615885@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250512172044.326436266@linuxfoundation.org>
References: <20250512172044.326436266@linuxfoundation.org>
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

From: Alexander Duyck <alexanderduyck@fb.com>

[ Upstream commit 3b12f00ddd08e888273b2ac0488d396d90a836fc ]

In order to prevent the device from throwing spurious writes and/or reads
at us we need to gate the AXI fabric interface to the PCIe until such time
as we know the FW is in a known good state.

To accomplish this we use the mailbox as a mechanism for us to recognize
that the FW has acknowledged our presence and is no longer sending any
stale message data to us.

We start in fbnic_mbx_init by calling fbnic_mbx_reset_desc_ring function,
disabling the DMA in both directions, and then invalidating all the
descriptors in each ring.

We then poll the mailbox in fbnic_mbx_poll_tx_ready and when the interrupt
is set by the FW we pick it up and mark the mailboxes as ready, while also
enabling the DMA.

Once we have completed all the transactions and need to shut down we call
into fbnic_mbx_clean which will in turn call fbnic_mbx_reset_desc_ring for
each ring and shut down the DMA and once again invalidate the descriptors.

Fixes: 3646153161f1 ("eth: fbnic: Add register init to set PCIe/Ethernet device config")
Fixes: da3cde08209e ("eth: fbnic: Add FW communication mechanism")
Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Link: https://patch.msgid.link/174654718623.499179.7445197308109347982.stgit@ahduyck-xeon-server.home.arpa
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/meta/fbnic/fbnic_csr.h |  2 ++
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c  | 38 +++++++++++++++++----
 drivers/net/ethernet/meta/fbnic/fbnic_mac.c |  6 ----
 3 files changed, 33 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
index 02bb81b3c5063..bf1655edeed2a 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
@@ -785,8 +785,10 @@ enum {
 /* PUL User Registers */
 #define FBNIC_CSR_START_PUL_USER	0x31000	/* CSR section delimiter */
 #define FBNIC_PUL_OB_TLP_HDR_AW_CFG	0x3103d		/* 0xc40f4 */
+#define FBNIC_PUL_OB_TLP_HDR_AW_CFG_FLUSH	CSR_BIT(19)
 #define FBNIC_PUL_OB_TLP_HDR_AW_CFG_BME		CSR_BIT(18)
 #define FBNIC_PUL_OB_TLP_HDR_AR_CFG	0x3103e		/* 0xc40f8 */
+#define FBNIC_PUL_OB_TLP_HDR_AR_CFG_FLUSH	CSR_BIT(19)
 #define FBNIC_PUL_OB_TLP_HDR_AR_CFG_BME		CSR_BIT(18)
 #define FBNIC_CSR_END_PUL_USER	0x31080	/* CSR section delimiter */
 
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
index 9996a70a1f872..dc90df287c0a8 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
@@ -51,10 +51,26 @@ static u64 __fbnic_mbx_rd_desc(struct fbnic_dev *fbd, int mbx_idx, int desc_idx)
 	return desc;
 }
 
-static void fbnic_mbx_init_desc_ring(struct fbnic_dev *fbd, int mbx_idx)
+static void fbnic_mbx_reset_desc_ring(struct fbnic_dev *fbd, int mbx_idx)
 {
 	int desc_idx;
 
+	/* Disable DMA transactions from the device,
+	 * and flush any transactions triggered during cleaning
+	 */
+	switch (mbx_idx) {
+	case FBNIC_IPC_MBX_RX_IDX:
+		wr32(fbd, FBNIC_PUL_OB_TLP_HDR_AW_CFG,
+		     FBNIC_PUL_OB_TLP_HDR_AW_CFG_FLUSH);
+		break;
+	case FBNIC_IPC_MBX_TX_IDX:
+		wr32(fbd, FBNIC_PUL_OB_TLP_HDR_AR_CFG,
+		     FBNIC_PUL_OB_TLP_HDR_AR_CFG_FLUSH);
+		break;
+	}
+
+	wrfl(fbd);
+
 	/* Initialize first descriptor to all 0s. Doing this gives us a
 	 * solid stop for the firmware to hit when it is done looping
 	 * through the ring.
@@ -90,7 +106,7 @@ void fbnic_mbx_init(struct fbnic_dev *fbd)
 	wr32(fbd, FBNIC_INTR_CLEAR(0), 1u << FBNIC_FW_MSIX_ENTRY);
 
 	for (i = 0; i < FBNIC_IPC_MBX_INDICES; i++)
-		fbnic_mbx_init_desc_ring(fbd, i);
+		fbnic_mbx_reset_desc_ring(fbd, i);
 }
 
 static int fbnic_mbx_map_msg(struct fbnic_dev *fbd, int mbx_idx,
@@ -155,7 +171,7 @@ static void fbnic_mbx_clean_desc_ring(struct fbnic_dev *fbd, int mbx_idx)
 {
 	int i;
 
-	fbnic_mbx_init_desc_ring(fbd, mbx_idx);
+	fbnic_mbx_reset_desc_ring(fbd, mbx_idx);
 
 	for (i = FBNIC_IPC_MBX_DESC_LEN; i--;)
 		fbnic_mbx_unmap_and_free_msg(fbd, mbx_idx, i);
@@ -354,7 +370,7 @@ static int fbnic_fw_xmit_cap_msg(struct fbnic_dev *fbd)
 	return (err == -EOPNOTSUPP) ? 0 : err;
 }
 
-static void fbnic_mbx_postinit_desc_ring(struct fbnic_dev *fbd, int mbx_idx)
+static void fbnic_mbx_init_desc_ring(struct fbnic_dev *fbd, int mbx_idx)
 {
 	struct fbnic_fw_mbx *mbx = &fbd->mbx[mbx_idx];
 
@@ -366,10 +382,18 @@ static void fbnic_mbx_postinit_desc_ring(struct fbnic_dev *fbd, int mbx_idx)
 
 	switch (mbx_idx) {
 	case FBNIC_IPC_MBX_RX_IDX:
+		/* Enable DMA writes from the device */
+		wr32(fbd, FBNIC_PUL_OB_TLP_HDR_AW_CFG,
+		     FBNIC_PUL_OB_TLP_HDR_AW_CFG_BME);
+
 		/* Make sure we have a page for the FW to write to */
 		fbnic_mbx_alloc_rx_msgs(fbd);
 		break;
 	case FBNIC_IPC_MBX_TX_IDX:
+		/* Enable DMA reads from the device */
+		wr32(fbd, FBNIC_PUL_OB_TLP_HDR_AR_CFG,
+		     FBNIC_PUL_OB_TLP_HDR_AR_CFG_BME);
+
 		/* Force version to 1 if we successfully requested an update
 		 * from the firmware. This should be overwritten once we get
 		 * the actual version from the firmware in the capabilities
@@ -386,7 +410,7 @@ static void fbnic_mbx_postinit(struct fbnic_dev *fbd)
 {
 	int i;
 
-	/* We only need to do this on the first interrupt following init.
+	/* We only need to do this on the first interrupt following reset.
 	 * this primes the mailbox so that we will have cleared all the
 	 * skip descriptors.
 	 */
@@ -396,7 +420,7 @@ static void fbnic_mbx_postinit(struct fbnic_dev *fbd)
 	wr32(fbd, FBNIC_INTR_CLEAR(0), 1u << FBNIC_FW_MSIX_ENTRY);
 
 	for (i = 0; i < FBNIC_IPC_MBX_INDICES; i++)
-		fbnic_mbx_postinit_desc_ring(fbd, i);
+		fbnic_mbx_init_desc_ring(fbd, i);
 }
 
 /**
@@ -899,7 +923,7 @@ int fbnic_mbx_poll_tx_ready(struct fbnic_dev *fbd)
 		 * avoid the mailbox getting stuck closed if the interrupt
 		 * is reset.
 		 */
-		fbnic_mbx_init_desc_ring(fbd, FBNIC_IPC_MBX_TX_IDX);
+		fbnic_mbx_reset_desc_ring(fbd, FBNIC_IPC_MBX_TX_IDX);
 
 		msleep(200);
 
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_mac.c b/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
index 14291401f4632..dde4a37116e20 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
@@ -79,12 +79,6 @@ static void fbnic_mac_init_axi(struct fbnic_dev *fbd)
 	fbnic_init_readrq(fbd, FBNIC_QM_RNI_RBP_CTL, cls, readrq);
 	fbnic_init_mps(fbd, FBNIC_QM_RNI_RDE_CTL, cls, mps);
 	fbnic_init_mps(fbd, FBNIC_QM_RNI_RCM_CTL, cls, mps);
-
-	/* Enable XALI AR/AW outbound */
-	wr32(fbd, FBNIC_PUL_OB_TLP_HDR_AW_CFG,
-	     FBNIC_PUL_OB_TLP_HDR_AW_CFG_BME);
-	wr32(fbd, FBNIC_PUL_OB_TLP_HDR_AR_CFG,
-	     FBNIC_PUL_OB_TLP_HDR_AR_CFG_BME);
 }
 
 static void fbnic_mac_init_qm(struct fbnic_dev *fbd)
-- 
2.39.5




