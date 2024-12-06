Return-Path: <stable+bounces-99637-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D529E7293
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 16:10:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6732281968
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 15:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 656FF1FCF7D;
	Fri,  6 Dec 2024 15:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zC4Yrm+i"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2384A148832;
	Fri,  6 Dec 2024 15:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733497850; cv=none; b=tW+QrgztsiPAc2X7fBGCu4U+FRGDi9g+qgpnzIkh9crZlMiNc4xHBGKHXwzRza3AbuJHqExU9+3+gle0ldVOezhz8+KX7kcYeZNeSyHDIUstssP2Dsj6DVr8LLI4DxKB0oVMlb2lqjAZsJJ8Op0gCF8ndi8cm+gD4CnhBV6Wz70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733497850; c=relaxed/simple;
	bh=4YvIGU8KnIVWPLoHsoLlezF8io20lf8lhC02aQJCz4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iX4D/bYM76Ys5X5exwB1w7EkQgnyJI8cpZ+qRY3SEFmpXwMBMtbQmgHq3sywnhC6LK3xP9juPXTlGDptvXmMyCyWvhZ6notBtX+rUsWV4WEumdXlPR0UlBd3Vx8x1+8n//Yp3Jw1MEgr9prtnQKNyswxfwOhYx84lzn67GWj4bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zC4Yrm+i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B22DC4CEED;
	Fri,  6 Dec 2024 15:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733497849;
	bh=4YvIGU8KnIVWPLoHsoLlezF8io20lf8lhC02aQJCz4k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zC4Yrm+iREo6GR7hAFxHP4qb+RZdG8O3IXkaHMT2qfO02wJRqX5JRGpZcpxsjFmRL
	 KjHLL5uu9Al4DrtEaZpMFZwaMDavsOzT0zoHjSVKrz+8yegHvBtcMsKvpo5JbZbnXw
	 SNt+TYe6KNdBzgiKStK6MaUbP+DKB6ArLv6RVVUs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hariprasad Kelam <hkelam@marvell.com>,
	Sai Krishna <saikrishnag@marvell.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 410/676] octeontx2-pf: Reset MAC stats during probe
Date: Fri,  6 Dec 2024 15:33:49 +0100
Message-ID: <20241206143709.361607757@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241206143653.344873888@linuxfoundation.org>
References: <20241206143653.344873888@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sai Krishna <saikrishnag@marvell.com>

[ Upstream commit 4c6ce450a8bb4bdf71959fd226414b079f0f0e02 ]

Reset CGX/RPM MAC HW statistics at the time of driver probe()

Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
Signed-off-by: Sai Krishna <saikrishnag@marvell.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: 07cd1eb166a3 ("octeontx2-af: RPM: fix stale RSFEC counters")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/marvell/octeontx2/af/cgx.c   | 27 +++++++++++++++++
 .../net/ethernet/marvell/octeontx2/af/cgx.h   |  1 +
 .../marvell/octeontx2/af/lmac_common.h        |  1 +
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |  1 +
 .../net/ethernet/marvell/octeontx2/af/rpm.c   | 17 +++++++++++
 .../net/ethernet/marvell/octeontx2/af/rpm.h   |  3 ++
 .../ethernet/marvell/octeontx2/af/rvu_cgx.c   | 29 +++++++++++++++++++
 .../marvell/octeontx2/nic/otx2_common.h       |  1 +
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  | 20 +++++++++++++
 9 files changed, 100 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
index aea963017d261..2e77911cbbe34 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
@@ -24,6 +24,8 @@
 #define DRV_NAME	"Marvell-CGX/RPM"
 #define DRV_STRING      "Marvell CGX/RPM Driver"
 
+#define CGX_RX_STAT_GLOBAL_INDEX	9
+
 static LIST_HEAD(cgx_list);
 
 /* Convert firmware speed encoding to user format(Mbps) */
@@ -706,6 +708,30 @@ u64 cgx_features_get(void *cgxd)
 	return ((struct cgx *)cgxd)->hw_features;
 }
 
+int cgx_stats_reset(void *cgxd, int lmac_id)
+{
+	struct cgx *cgx = cgxd;
+	int stat_id;
+
+	if (!is_lmac_valid(cgx, lmac_id))
+		return -ENODEV;
+
+	for (stat_id = 0 ; stat_id < CGX_RX_STATS_COUNT; stat_id++) {
+		if (stat_id >= CGX_RX_STAT_GLOBAL_INDEX)
+		/* pass lmac as 0 for CGX_CMR_RX_STAT9-12 */
+			cgx_write(cgx, 0,
+				  (CGXX_CMRX_RX_STAT0 + (stat_id * 8)), 0);
+		else
+			cgx_write(cgx, lmac_id,
+				  (CGXX_CMRX_RX_STAT0 + (stat_id * 8)), 0);
+	}
+
+	for (stat_id = 0 ; stat_id < CGX_TX_STATS_COUNT; stat_id++)
+		cgx_write(cgx, lmac_id, CGXX_CMRX_TX_STAT0 + (stat_id * 8), 0);
+
+	return 0;
+}
+
 static int cgx_set_fec_stats_count(struct cgx_link_user_info *linfo)
 {
 	if (!linfo->fec)
@@ -1795,6 +1821,7 @@ static struct mac_ops	cgx_mac_ops    = {
 	.pfc_config =                   cgx_lmac_pfc_config,
 	.mac_get_pfc_frm_cfg   =        cgx_lmac_get_pfc_frm_cfg,
 	.mac_reset   =			cgx_lmac_reset,
+	.mac_stats_reset       =	cgx_stats_reset,
 };
 
 static int cgx_probe(struct pci_dev *pdev, const struct pci_device_id *id)
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cgx.h b/drivers/net/ethernet/marvell/octeontx2/af/cgx.h
index 226ff7f0df52a..f9cd4b58f0c02 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.h
@@ -141,6 +141,7 @@ int cgx_lmac_evh_register(struct cgx_event_cb *cb, void *cgxd, int lmac_id);
 int cgx_lmac_evh_unregister(void *cgxd, int lmac_id);
 int cgx_get_tx_stats(void *cgxd, int lmac_id, int idx, u64 *tx_stat);
 int cgx_get_rx_stats(void *cgxd, int lmac_id, int idx, u64 *rx_stat);
+int cgx_stats_reset(void *cgxd, int lmac_id);
 int cgx_lmac_rx_tx_enable(void *cgxd, int lmac_id, bool enable);
 int cgx_lmac_tx_enable(void *cgxd, int lmac_id, bool enable);
 int cgx_lmac_addr_set(u8 cgx_id, u8 lmac_id, u8 *mac_addr);
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/lmac_common.h b/drivers/net/ethernet/marvell/octeontx2/af/lmac_common.h
index 50fcc436d8a79..c43ff68ef1408 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/lmac_common.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/lmac_common.h
@@ -131,6 +131,7 @@ struct mac_ops {
 	/* FEC stats */
 	int			(*get_fec_stats)(void *cgxd, int lmac_id,
 						 struct cgx_fec_stats_rsp *rsp);
+	int			(*mac_stats_reset)(void *cgxd, int lmac_id);
 };
 
 struct cgx {
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index e883c0929b1a9..b4b23e475c95f 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -174,6 +174,7 @@ M(CGX_FEC_STATS,	0x217, cgx_fec_stats, msg_req, cgx_fec_stats_rsp) \
 M(CGX_SET_LINK_MODE,	0x218, cgx_set_link_mode, cgx_set_link_mode_req,\
 			       cgx_set_link_mode_rsp)	\
 M(CGX_GET_PHY_FEC_STATS, 0x219, cgx_get_phy_fec_stats, msg_req, msg_rsp) \
+M(CGX_STATS_RST,	0x21A, cgx_stats_rst, msg_req, msg_rsp)		\
 M(CGX_FEATURES_GET,	0x21B, cgx_features_get, msg_req,		\
 			       cgx_features_info_msg)			\
 M(RPM_STATS,		0x21C, rpm_stats, msg_req, rpm_stats_rsp)	\
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rpm.c b/drivers/net/ethernet/marvell/octeontx2/af/rpm.c
index 4d2d15834f9df..22dd50a3fcd3a 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rpm.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rpm.c
@@ -38,6 +38,7 @@ static struct mac_ops		rpm_mac_ops   = {
 	.pfc_config =                   rpm_lmac_pfc_config,
 	.mac_get_pfc_frm_cfg   =        rpm_lmac_get_pfc_frm_cfg,
 	.mac_reset   =			rpm_lmac_reset,
+	.mac_stats_reset		 =	  rpm_stats_reset,
 };
 
 static struct mac_ops		rpm2_mac_ops   = {
@@ -70,6 +71,7 @@ static struct mac_ops		rpm2_mac_ops   = {
 	.pfc_config =                   rpm_lmac_pfc_config,
 	.mac_get_pfc_frm_cfg   =        rpm_lmac_get_pfc_frm_cfg,
 	.mac_reset   =			rpm_lmac_reset,
+	.mac_stats_reset	    =	rpm_stats_reset,
 };
 
 bool is_dev_rpm2(void *rpmd)
@@ -443,6 +445,21 @@ int rpm_get_tx_stats(void *rpmd, int lmac_id, int idx, u64 *tx_stat)
 	return 0;
 }
 
+int rpm_stats_reset(void *rpmd, int lmac_id)
+{
+	rpm_t *rpm = rpmd;
+	u64 cfg;
+
+	if (!is_lmac_valid(rpm, lmac_id))
+		return -ENODEV;
+
+	cfg = rpm_read(rpm, 0, RPMX_MTI_STAT_STATN_CONTROL);
+	cfg |= RPMX_CMD_CLEAR_TX | RPMX_CMD_CLEAR_RX | BIT_ULL(lmac_id);
+	rpm_write(rpm, 0, RPMX_MTI_STAT_STATN_CONTROL, cfg);
+
+	return 0;
+}
+
 u8 rpm_get_lmac_type(void *rpmd, int lmac_id)
 {
 	rpm_t *rpm = rpmd;
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rpm.h b/drivers/net/ethernet/marvell/octeontx2/af/rpm.h
index b79cfbc6f8770..34b11deb0f3c1 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rpm.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rpm.h
@@ -85,6 +85,8 @@
 #define RPMX_MTI_STAT_STATN_CONTROL			0x10018
 #define RPMX_MTI_STAT_DATA_HI_CDC			0x10038
 #define RPMX_RSFEC_RX_CAPTURE				BIT_ULL(27)
+#define RPMX_CMD_CLEAR_RX				BIT_ULL(30)
+#define RPMX_CMD_CLEAR_TX				BIT_ULL(31)
 #define RPMX_MTI_RSFEC_STAT_COUNTER_CAPTURE_2		0x40050
 #define RPMX_MTI_RSFEC_STAT_COUNTER_CAPTURE_3		0x40058
 #define RPMX_MTI_FCFECX_VL0_CCW_LO			0x38618
@@ -134,4 +136,5 @@ int rpm2_get_nr_lmacs(void *rpmd);
 bool is_dev_rpm2(void *rpmd);
 int rpm_get_fec_stats(void *cgxd, int lmac_id, struct cgx_fec_stats_rsp *rsp);
 int rpm_lmac_reset(void *rpmd, int lmac_id, u8 pf_req_flr);
+int rpm_stats_reset(void *rpmd, int lmac_id);
 #endif /* RPM_H */
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
index 898584b1aa608..7fc094419ef2b 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
@@ -604,6 +604,35 @@ int rvu_mbox_handler_rpm_stats(struct rvu *rvu, struct msg_req *req,
 	return rvu_lmac_get_stats(rvu, req, (void *)rsp);
 }
 
+int rvu_mbox_handler_cgx_stats_rst(struct rvu *rvu, struct msg_req *req,
+				   struct msg_rsp *rsp)
+{
+	int pf = rvu_get_pf(req->hdr.pcifunc);
+	struct rvu_pfvf	*parent_pf;
+	struct mac_ops *mac_ops;
+	u8 cgx_idx, lmac;
+	void *cgxd;
+
+	if (!is_cgx_config_permitted(rvu, req->hdr.pcifunc))
+		return LMAC_AF_ERR_PERM_DENIED;
+
+	parent_pf = &rvu->pf[pf];
+	/* To ensure reset cgx stats won't affect VF stats,
+	 *  check if it used by only PF interface.
+	 *  If not, return
+	 */
+	if (parent_pf->cgx_users > 1) {
+		dev_info(rvu->dev, "CGX busy, could not reset statistics\n");
+		return 0;
+	}
+
+	rvu_get_cgx_lmac_id(rvu->pf2cgxlmac_map[pf], &cgx_idx, &lmac);
+	cgxd = rvu_cgx_pdata(cgx_idx, rvu);
+	mac_ops = get_mac_ops(cgxd);
+
+	return mac_ops->mac_stats_reset(cgxd, lmac);
+}
+
 int rvu_mbox_handler_cgx_fec_stats(struct rvu *rvu,
 				   struct msg_req *req,
 				   struct cgx_fec_stats_rsp *rsp)
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
index 7e16a341ec588..c5de3ba33e2f0 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
@@ -961,6 +961,7 @@ void otx2_get_mac_from_af(struct net_device *netdev);
 void otx2_config_irq_coalescing(struct otx2_nic *pfvf, int qidx);
 int otx2_config_pause_frm(struct otx2_nic *pfvf);
 void otx2_setup_segmentation(struct otx2_nic *pfvf);
+int otx2_reset_mac_stats(struct otx2_nic *pfvf);
 
 /* RVU block related APIs */
 int otx2_attach_npa_nix(struct otx2_nic *pfvf);
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index 3f46d5e0fb2ec..b4194ec2a1f2d 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -1150,6 +1150,23 @@ static int otx2_cgx_config_linkevents(struct otx2_nic *pf, bool enable)
 	return err;
 }
 
+int otx2_reset_mac_stats(struct otx2_nic *pfvf)
+{
+	struct msg_req *req;
+	int err;
+
+	mutex_lock(&pfvf->mbox.lock);
+	req = otx2_mbox_alloc_msg_cgx_stats_rst(&pfvf->mbox);
+	if (!req) {
+		mutex_unlock(&pfvf->mbox.lock);
+		return -ENOMEM;
+	}
+
+	err = otx2_sync_mbox_msg(&pfvf->mbox);
+	mutex_unlock(&pfvf->mbox.lock);
+	return err;
+}
+
 static int otx2_cgx_config_loopback(struct otx2_nic *pf, bool enable)
 {
 	struct msg_req *msg;
@@ -3038,6 +3055,9 @@ static int otx2_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	netdev->min_mtu = OTX2_MIN_MTU;
 	netdev->max_mtu = otx2_get_max_mtu(pf);
 
+	/* reset CGX/RPM MAC stats */
+	otx2_reset_mac_stats(pf);
+
 	err = register_netdev(netdev);
 	if (err) {
 		dev_err(dev, "Failed to register netdevice\n");
-- 
2.43.0




