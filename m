Return-Path: <stable+bounces-97071-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F2A9E22C9
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 16:29:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8644D16D093
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 15:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F44B1F7591;
	Tue,  3 Dec 2024 15:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JQGiQomu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB5C2D7BF;
	Tue,  3 Dec 2024 15:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733239437; cv=none; b=eYQOx7caMPTdzxWmTTSwIeDKi6qOGo4ZE6hoVl2qUAVKcSThtj8wQe6pkHhVa0k54XRCFQ1BSoMzh5Gj6SzlS5EHRDjwSKi5GfLhH/w2p5FNwxc5dmPLKoQzfms1/80eifmEUw7wCy4iy/ZigOB0DGIQ6+0Rg9r0Gqw60GPcgIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733239437; c=relaxed/simple;
	bh=Fvd9w0kG8+B7rzSD/ffKzxpNpXDhq63/IpaSB5QjJbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=apSHzr1awnbvNptBvbbrlR3FhIRPmINzSsbEAhaARS3VbgkNaNoB1RxgTMr4K/ofKI9rBtaUNgyXjQdtNlSq1GWMJzztQrZ3rRYTPkIZ5u8GndEokFecx6TJofTtJabaybQjZSMjL5+McPzFkWpzeuEnBvU24Cx+oDq3qggrxi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JQGiQomu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0FA0C4CED6;
	Tue,  3 Dec 2024 15:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733239437;
	bh=Fvd9w0kG8+B7rzSD/ffKzxpNpXDhq63/IpaSB5QjJbs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JQGiQomutgf8QXUE0tn/8RduBdIYKc2V0YvqbfXAI9p89C3DirwOba+AM4TB4kQf2
	 erS+FA+oLFYXMrRwL3DZP0AqWFeW0daIJOoDDE9JPW7dqHDuzucD0TNXHANfFbsR/u
	 hJMUmYupXXn+OKeJaSnrLZBDiyBPcMuyCxty0IY4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hariprasad Kelam <hkelam@marvell.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 582/817] octeontx2-af: Quiesce traffic before NIX block reset
Date: Tue,  3 Dec 2024 15:42:34 +0100
Message-ID: <20241203144018.638763624@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203143955.605130076@linuxfoundation.org>
References: <20241203143955.605130076@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hariprasad Kelam <hkelam@marvell.com>

[ Upstream commit 762ca6eed026346d9d41ed5ac633083c4f1e5071 ]

During initialization, the AF driver resets all blocks. The RPM (MAC)
block and NIX block operate on a credit-based model. When the NIX block
resets during active traffic flow, it doesn't release credits to the RPM
block. This causes the RPM FIFO to overflow, leading to receive traffic
struck.

To address this issue, the patch introduces the following changes:
1. Stop receiving traffic at the MAC level during AF driver
   initialization.
2. Perform an X2P reset (prevents RXFIFO of all LMACS from pushing data)
3. Reset the NIX block.
4. Clear the X2P reset and re-enable receiving traffic.

Fixes: 54d557815e15 ("octeontx2-af: Reset all RVU blocks")
Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/marvell/octeontx2/af/cgx.c   | 61 +++++++++++++++++++
 .../net/ethernet/marvell/octeontx2/af/cgx.h   |  4 ++
 .../marvell/octeontx2/af/lmac_common.h        |  2 +
 .../net/ethernet/marvell/octeontx2/af/rpm.c   | 42 +++++++++++++
 .../net/ethernet/marvell/octeontx2/af/rpm.h   |  4 ++
 .../net/ethernet/marvell/octeontx2/af/rvu.c   |  1 +
 .../net/ethernet/marvell/octeontx2/af/rvu.h   |  1 +
 .../ethernet/marvell/octeontx2/af/rvu_cgx.c   | 36 +++++++++--
 8 files changed, 145 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
index 2f621714c54e6..8216f843a7cd5 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
@@ -214,6 +214,24 @@ u8 cgx_lmac_get_p2x(int cgx_id, int lmac_id)
 	return (cfg & CMR_P2X_SEL_MASK) >> CMR_P2X_SEL_SHIFT;
 }
 
+static u8 cgx_get_nix_resetbit(struct cgx *cgx)
+{
+	int first_lmac;
+	u8 p2x;
+
+	/* non 98XX silicons supports only NIX0 block */
+	if (cgx->pdev->subsystem_device != PCI_SUBSYS_DEVID_98XX)
+		return CGX_NIX0_RESET;
+
+	first_lmac = find_first_bit(&cgx->lmac_bmap, cgx->max_lmac_per_mac);
+	p2x = cgx_lmac_get_p2x(cgx->cgx_id, first_lmac);
+
+	if (p2x == CMR_P2X_SEL_NIX1)
+		return CGX_NIX1_RESET;
+	else
+		return CGX_NIX0_RESET;
+}
+
 /* Ensure the required lock for event queue(where asynchronous events are
  * posted) is acquired before calling this API. Else an asynchronous event(with
  * latest link status) can reach the destination before this function returns
@@ -1724,6 +1742,8 @@ static int cgx_lmac_init(struct cgx *cgx)
 		lmac->lmac_type = cgx->mac_ops->get_lmac_type(cgx, lmac->lmac_id);
 	}
 
+	/* Start X2P reset on given MAC block */
+	cgx->mac_ops->mac_x2p_reset(cgx, true);
 	return cgx_lmac_verify_fwi_version(cgx);
 
 err_bitmap_free:
@@ -1789,6 +1809,45 @@ static u8 cgx_get_rxid_mapoffset(struct cgx *cgx)
 		return 0x60;
 }
 
+static void cgx_x2p_reset(void *cgxd, bool enable)
+{
+	struct cgx *cgx = cgxd;
+	int lmac_id;
+	u64 cfg;
+
+	if (enable) {
+		for_each_set_bit(lmac_id, &cgx->lmac_bmap, cgx->max_lmac_per_mac)
+			cgx->mac_ops->mac_enadis_rx(cgx, lmac_id, false);
+
+		usleep_range(1000, 2000);
+
+		cfg = cgx_read(cgx, 0, CGXX_CMR_GLOBAL_CONFIG);
+		cfg |= cgx_get_nix_resetbit(cgx) | CGX_NSCI_DROP;
+		cgx_write(cgx, 0, CGXX_CMR_GLOBAL_CONFIG, cfg);
+	} else {
+		cfg = cgx_read(cgx, 0, CGXX_CMR_GLOBAL_CONFIG);
+		cfg &= ~(cgx_get_nix_resetbit(cgx) | CGX_NSCI_DROP);
+		cgx_write(cgx, 0, CGXX_CMR_GLOBAL_CONFIG, cfg);
+	}
+}
+
+static int cgx_enadis_rx(void *cgxd, int lmac_id, bool enable)
+{
+	struct cgx *cgx = cgxd;
+	u64 cfg;
+
+	if (!is_lmac_valid(cgx, lmac_id))
+		return -ENODEV;
+
+	cfg = cgx_read(cgx, lmac_id, CGXX_CMRX_CFG);
+	if (enable)
+		cfg |= DATA_PKT_RX_EN;
+	else
+		cfg &= ~DATA_PKT_RX_EN;
+	cgx_write(cgx, lmac_id, CGXX_CMRX_CFG, cfg);
+	return 0;
+}
+
 static struct mac_ops	cgx_mac_ops    = {
 	.name		=       "cgx",
 	.csr_offset	=       0,
@@ -1820,6 +1879,8 @@ static struct mac_ops	cgx_mac_ops    = {
 	.mac_get_pfc_frm_cfg   =        cgx_lmac_get_pfc_frm_cfg,
 	.mac_reset   =			cgx_lmac_reset,
 	.mac_stats_reset       =	cgx_stats_reset,
+	.mac_x2p_reset                   =      cgx_x2p_reset,
+	.mac_enadis_rx			 =      cgx_enadis_rx,
 };
 
 static int cgx_probe(struct pci_dev *pdev, const struct pci_device_id *id)
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cgx.h b/drivers/net/ethernet/marvell/octeontx2/af/cgx.h
index f9cd4b58f0c02..1cf12e5c7da87 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.h
@@ -32,6 +32,10 @@
 #define CGX_LMAC_TYPE_MASK		0xF
 #define CGXX_CMRX_INT			0x040
 #define FW_CGX_INT			BIT_ULL(1)
+#define CGXX_CMR_GLOBAL_CONFIG          0x08
+#define CGX_NIX0_RESET			BIT_ULL(2)
+#define CGX_NIX1_RESET			BIT_ULL(3)
+#define CGX_NSCI_DROP			BIT_ULL(9)
 #define CGXX_CMRX_INT_ENA_W1S		0x058
 #define CGXX_CMRX_RX_ID_MAP		0x060
 #define CGXX_CMRX_RX_STAT0		0x070
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/lmac_common.h b/drivers/net/ethernet/marvell/octeontx2/af/lmac_common.h
index c43ff68ef1408..6180e68e1765a 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/lmac_common.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/lmac_common.h
@@ -132,6 +132,8 @@ struct mac_ops {
 	int			(*get_fec_stats)(void *cgxd, int lmac_id,
 						 struct cgx_fec_stats_rsp *rsp);
 	int			(*mac_stats_reset)(void *cgxd, int lmac_id);
+	void                    (*mac_x2p_reset)(void *cgxd, bool enable);
+	int			(*mac_enadis_rx)(void *cgxd, int lmac_id, bool enable);
 };
 
 struct cgx {
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rpm.c b/drivers/net/ethernet/marvell/octeontx2/af/rpm.c
index e97fcc51d7f24..2e9945446199e 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rpm.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rpm.c
@@ -39,6 +39,8 @@ static struct mac_ops		rpm_mac_ops   = {
 	.mac_get_pfc_frm_cfg   =        rpm_lmac_get_pfc_frm_cfg,
 	.mac_reset   =			rpm_lmac_reset,
 	.mac_stats_reset		 =	  rpm_stats_reset,
+	.mac_x2p_reset                   =        rpm_x2p_reset,
+	.mac_enadis_rx			 =        rpm_enadis_rx,
 };
 
 static struct mac_ops		rpm2_mac_ops   = {
@@ -72,6 +74,8 @@ static struct mac_ops		rpm2_mac_ops   = {
 	.mac_get_pfc_frm_cfg   =        rpm_lmac_get_pfc_frm_cfg,
 	.mac_reset   =			rpm_lmac_reset,
 	.mac_stats_reset	    =	rpm_stats_reset,
+	.mac_x2p_reset              =   rpm_x2p_reset,
+	.mac_enadis_rx		    =   rpm_enadis_rx,
 };
 
 bool is_dev_rpm2(void *rpmd)
@@ -768,3 +772,41 @@ int rpm_lmac_reset(void *rpmd, int lmac_id, u8 pf_req_flr)
 
 	return 0;
 }
+
+void rpm_x2p_reset(void *rpmd, bool enable)
+{
+	rpm_t *rpm = rpmd;
+	int lmac_id;
+	u64 cfg;
+
+	if (enable) {
+		for_each_set_bit(lmac_id, &rpm->lmac_bmap, rpm->max_lmac_per_mac)
+			rpm->mac_ops->mac_enadis_rx(rpm, lmac_id, false);
+
+		usleep_range(1000, 2000);
+
+		cfg = rpm_read(rpm, 0, RPMX_CMR_GLOBAL_CFG);
+		rpm_write(rpm, 0, RPMX_CMR_GLOBAL_CFG, cfg | RPM_NIX0_RESET);
+	} else {
+		cfg = rpm_read(rpm, 0, RPMX_CMR_GLOBAL_CFG);
+		cfg &= ~RPM_NIX0_RESET;
+		rpm_write(rpm, 0, RPMX_CMR_GLOBAL_CFG, cfg);
+	}
+}
+
+int rpm_enadis_rx(void *rpmd, int lmac_id, bool enable)
+{
+	rpm_t *rpm = rpmd;
+	u64 cfg;
+
+	if (!is_lmac_valid(rpm, lmac_id))
+		return -ENODEV;
+
+	cfg = rpm_read(rpm, lmac_id, RPMX_MTI_MAC100X_COMMAND_CONFIG);
+	if (enable)
+		cfg |= RPM_RX_EN;
+	else
+		cfg &= ~RPM_RX_EN;
+	rpm_write(rpm, lmac_id, RPMX_MTI_MAC100X_COMMAND_CONFIG, cfg);
+	return 0;
+}
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rpm.h b/drivers/net/ethernet/marvell/octeontx2/af/rpm.h
index 5194fec4c3b8e..b8d3972e096ae 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rpm.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rpm.h
@@ -17,6 +17,8 @@
 
 /* Registers */
 #define RPMX_CMRX_CFG			0x00
+#define RPMX_CMR_GLOBAL_CFG		0x08
+#define RPM_NIX0_RESET			BIT_ULL(3)
 #define RPMX_RX_TS_PREPEND              BIT_ULL(22)
 #define RPMX_TX_PTP_1S_SUPPORT          BIT_ULL(17)
 #define RPMX_CMRX_RX_ID_MAP		0x80
@@ -139,4 +141,6 @@ bool is_dev_rpm2(void *rpmd);
 int rpm_get_fec_stats(void *cgxd, int lmac_id, struct cgx_fec_stats_rsp *rsp);
 int rpm_lmac_reset(void *rpmd, int lmac_id, u8 pf_req_flr);
 int rpm_stats_reset(void *rpmd, int lmac_id);
+void rpm_x2p_reset(void *rpmd, bool enable);
+int rpm_enadis_rx(void *rpmd, int lmac_id, bool enable);
 #endif /* RPM_H */
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
index ac7ee3f3598c9..02ebfe71b6910 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
@@ -1162,6 +1162,7 @@ static int rvu_setup_hw_resources(struct rvu *rvu)
 	}
 
 	rvu_program_channels(rvu);
+	cgx_start_linkup(rvu);
 
 	err = rvu_mcs_init(rvu);
 	if (err) {
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
index db2db0738ee42..9ada11f114b1e 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
@@ -967,6 +967,7 @@ int rvu_cgx_prio_flow_ctrl_cfg(struct rvu *rvu, u16 pcifunc, u8 tx_pause, u8 rx_
 int rvu_cgx_cfg_pause_frm(struct rvu *rvu, u16 pcifunc, u8 tx_pause, u8 rx_pause);
 void rvu_mac_reset(struct rvu *rvu, u16 pcifunc);
 u32 rvu_cgx_get_lmac_fifolen(struct rvu *rvu, int cgx, int lmac);
+void cgx_start_linkup(struct rvu *rvu);
 int npc_get_nixlf_mcam_index(struct npc_mcam *mcam, u16 pcifunc, int nixlf,
 			     int type);
 bool is_mcam_entry_enabled(struct rvu *rvu, struct npc_mcam *mcam, int blkaddr,
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
index 4dcd7bfcad4e4..992fa0b82e8d2 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
@@ -349,6 +349,7 @@ static void rvu_cgx_wq_destroy(struct rvu *rvu)
 
 int rvu_cgx_init(struct rvu *rvu)
 {
+	struct mac_ops *mac_ops;
 	int cgx, err;
 	void *cgxd;
 
@@ -375,6 +376,15 @@ int rvu_cgx_init(struct rvu *rvu)
 	if (err)
 		return err;
 
+	/* Clear X2P reset on all MAC blocks */
+	for (cgx = 0; cgx < rvu->cgx_cnt_max; cgx++) {
+		cgxd = rvu_cgx_pdata(cgx, rvu);
+		if (!cgxd)
+			continue;
+		mac_ops = get_mac_ops(cgxd);
+		mac_ops->mac_x2p_reset(cgxd, false);
+	}
+
 	/* Register for CGX events */
 	err = cgx_lmac_event_handler_init(rvu);
 	if (err)
@@ -382,10 +392,26 @@ int rvu_cgx_init(struct rvu *rvu)
 
 	mutex_init(&rvu->cgx_cfg_lock);
 
-	/* Ensure event handler registration is completed, before
-	 * we turn on the links
-	 */
-	mb();
+	return 0;
+}
+
+void cgx_start_linkup(struct rvu *rvu)
+{
+	unsigned long lmac_bmap;
+	struct mac_ops *mac_ops;
+	int cgx, lmac, err;
+	void *cgxd;
+
+	/* Enable receive on all LMACS */
+	for (cgx = 0; cgx <= rvu->cgx_cnt_max; cgx++) {
+		cgxd = rvu_cgx_pdata(cgx, rvu);
+		if (!cgxd)
+			continue;
+		mac_ops = get_mac_ops(cgxd);
+		lmac_bmap = cgx_get_lmac_bmap(cgxd);
+		for_each_set_bit(lmac, &lmac_bmap, rvu->hw->lmac_per_cgx)
+			mac_ops->mac_enadis_rx(cgxd, lmac, true);
+	}
 
 	/* Do link up for all CGX ports */
 	for (cgx = 0; cgx <= rvu->cgx_cnt_max; cgx++) {
@@ -398,8 +424,6 @@ int rvu_cgx_init(struct rvu *rvu)
 				"Link up process failed to start on cgx %d\n",
 				cgx);
 	}
-
-	return 0;
 }
 
 int rvu_cgx_exit(struct rvu *rvu)
-- 
2.43.0




