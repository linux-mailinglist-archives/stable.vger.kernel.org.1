Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 083EE7553F8
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbjGPUZG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231929AbjGPUZF (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:25:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B5FBC
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:25:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 89FA760EAE
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:25:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96AEBC433C8;
        Sun, 16 Jul 2023 20:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689539103;
        bh=Snr0b/pFiG9epAn+2ojrd2fv34mg4SxO5UgHg9/wjqM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mU4jlPmYyhucoOzm5SPsoXwfPxSlnwCZpON1YKs5xncB/b/jv+f9mazGv2zm/UqKx
         hmUTbNx4XdaPFGsmsanYw3KjQKR0rnjEQLTV9eJz+VXNbwyUcPXUnpseE/qVGEZtLh
         CLdqPF3YaQx7pNrKP6YsCMRM6NrKdmV5Pev6tfkE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hariprasad Kelam <hkelam@marvell.com>,
        Sunil Goutham <sgoutham@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 687/800] octeontx2-af: Reset MAC features in FLR
Date:   Sun, 16 Jul 2023 21:49:00 +0200
Message-ID: <20230716195005.082307120@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Hariprasad Kelam <hkelam@marvell.com>

[ Upstream commit 2e3e94c2f5dc98a8a0e93850407064bc5389c306 ]

AF driver configures MAC features like internal loopback and PFC upon
receiving the request from PF and its VF netdev. But these
features are not getting reset in FLR.  This patch fixes the issue by
resetting the same.

Fixes: 23999b30ae67 ("octeontx2-af: Enable or disable CGX internal loopback")
Fixes: 1121f6b02e7a ("octeontx2-af: Priority flow control configuration support")
Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
Signed-off-by: Sunil Goutham <sgoutham@marvell.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/marvell/octeontx2/af/cgx.c   | 26 ++++++++++++++--
 .../net/ethernet/marvell/octeontx2/af/cgx.h   |  2 ++
 .../marvell/octeontx2/af/lmac_common.h        |  3 ++
 .../net/ethernet/marvell/octeontx2/af/rpm.c   | 30 +++++++++++++++++--
 .../net/ethernet/marvell/octeontx2/af/rpm.h   |  2 ++
 .../net/ethernet/marvell/octeontx2/af/rvu.c   |  1 +
 .../net/ethernet/marvell/octeontx2/af/rvu.h   |  1 +
 .../ethernet/marvell/octeontx2/af/rvu_cgx.c   | 18 +++++++++++
 8 files changed, 77 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
index f4bdca662d616..592037f4e55b6 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
@@ -537,14 +537,15 @@ static u32 cgx_get_lmac_fifo_len(void *cgxd, int lmac_id)
 int cgx_lmac_internal_loopback(void *cgxd, int lmac_id, bool enable)
 {
 	struct cgx *cgx = cgxd;
-	u8 lmac_type;
+	struct lmac *lmac;
 	u64 cfg;
 
 	if (!is_lmac_valid(cgx, lmac_id))
 		return -ENODEV;
 
-	lmac_type = cgx->mac_ops->get_lmac_type(cgx, lmac_id);
-	if (lmac_type == LMAC_MODE_SGMII || lmac_type == LMAC_MODE_QSGMII) {
+	lmac = lmac_pdata(lmac_id, cgx);
+	if (lmac->lmac_type == LMAC_MODE_SGMII ||
+	    lmac->lmac_type == LMAC_MODE_QSGMII) {
 		cfg = cgx_read(cgx, lmac_id, CGXX_GMP_PCS_MRX_CTL);
 		if (enable)
 			cfg |= CGXX_GMP_PCS_MRX_CTL_LBK;
@@ -1563,6 +1564,23 @@ int cgx_lmac_linkup_start(void *cgxd)
 	return 0;
 }
 
+int cgx_lmac_reset(void *cgxd, int lmac_id, u8 pf_req_flr)
+{
+	struct cgx *cgx = cgxd;
+	u64 cfg;
+
+	if (!is_lmac_valid(cgx, lmac_id))
+		return -ENODEV;
+
+	/* Resetting PFC related CSRs */
+	cfg = 0xff;
+	cgx_write(cgxd, lmac_id, CGXX_CMRX_RX_LOGL_XON, cfg);
+
+	if (pf_req_flr)
+		cgx_lmac_internal_loopback(cgxd, lmac_id, false);
+	return 0;
+}
+
 static int cgx_configure_interrupt(struct cgx *cgx, struct lmac *lmac,
 				   int cnt, bool req_free)
 {
@@ -1682,6 +1700,7 @@ static int cgx_lmac_init(struct cgx *cgx)
 		cgx->lmac_idmap[lmac->lmac_id] = lmac;
 		set_bit(lmac->lmac_id, &cgx->lmac_bmap);
 		cgx->mac_ops->mac_pause_frm_config(cgx, lmac->lmac_id, true);
+		lmac->lmac_type = cgx->mac_ops->get_lmac_type(cgx, lmac->lmac_id);
 	}
 
 	return cgx_lmac_verify_fwi_version(cgx);
@@ -1778,6 +1797,7 @@ static struct mac_ops	cgx_mac_ops    = {
 	.mac_tx_enable =		cgx_lmac_tx_enable,
 	.pfc_config =                   cgx_lmac_pfc_config,
 	.mac_get_pfc_frm_cfg   =        cgx_lmac_get_pfc_frm_cfg,
+	.mac_reset   =			cgx_lmac_reset,
 };
 
 static int cgx_probe(struct pci_dev *pdev, const struct pci_device_id *id)
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cgx.h b/drivers/net/ethernet/marvell/octeontx2/af/cgx.h
index 5a20d93004c71..5741141796880 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.h
@@ -35,6 +35,7 @@
 #define CGXX_CMRX_INT_ENA_W1S		0x058
 #define CGXX_CMRX_RX_ID_MAP		0x060
 #define CGXX_CMRX_RX_STAT0		0x070
+#define CGXX_CMRX_RX_LOGL_XON		0x100
 #define CGXX_CMRX_RX_LMACS		0x128
 #define CGXX_CMRX_RX_DMAC_CTL0		(0x1F8 + mac_ops->csr_offset)
 #define CGX_DMAC_CTL0_CAM_ENABLE	BIT_ULL(3)
@@ -181,4 +182,5 @@ int cgx_lmac_get_pfc_frm_cfg(void *cgxd, int lmac_id, u8 *tx_pause,
 			     u8 *rx_pause);
 int verify_lmac_fc_cfg(void *cgxd, int lmac_id, u8 tx_pause, u8 rx_pause,
 		       int pfvf_idx);
+int cgx_lmac_reset(void *cgxd, int lmac_id, u8 pf_req_flr);
 #endif /* CGX_H */
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/lmac_common.h b/drivers/net/ethernet/marvell/octeontx2/af/lmac_common.h
index 39aaf0e4467dc..0b4cba03f2e83 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/lmac_common.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/lmac_common.h
@@ -24,6 +24,7 @@
  * @cgx:		parent cgx port
  * @mcast_filters_count:  Number of multicast filters installed
  * @lmac_id:		lmac port id
+ * @lmac_type:	        lmac type like SGMII/XAUI
  * @cmd_pend:		flag set before new command is started
  *			flag cleared after command response is received
  * @name:		lmac port name
@@ -43,6 +44,7 @@ struct lmac {
 	struct cgx *cgx;
 	u8 mcast_filters_count;
 	u8 lmac_id;
+	u8 lmac_type;
 	bool cmd_pend;
 	char *name;
 };
@@ -125,6 +127,7 @@ struct mac_ops {
 
 	int                     (*mac_get_pfc_frm_cfg)(void *cgxd, int lmac_id,
 						       u8 *tx_pause, u8 *rx_pause);
+	int			(*mac_reset)(void *cgxd, int lmac_id, u8 pf_req_flr);
 
 	/* FEC stats */
 	int			(*get_fec_stats)(void *cgxd, int lmac_id,
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rpm.c b/drivers/net/ethernet/marvell/octeontx2/af/rpm.c
index a433f92c51eae..b4fcb20c3f4fd 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rpm.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rpm.c
@@ -37,6 +37,7 @@ static struct mac_ops		rpm_mac_ops   = {
 	.mac_tx_enable =		rpm_lmac_tx_enable,
 	.pfc_config =                   rpm_lmac_pfc_config,
 	.mac_get_pfc_frm_cfg   =        rpm_lmac_get_pfc_frm_cfg,
+	.mac_reset   =			rpm_lmac_reset,
 };
 
 static struct mac_ops		rpm2_mac_ops   = {
@@ -68,6 +69,7 @@ static struct mac_ops		rpm2_mac_ops   = {
 	.mac_tx_enable =		rpm_lmac_tx_enable,
 	.pfc_config =                   rpm_lmac_pfc_config,
 	.mac_get_pfc_frm_cfg   =        rpm_lmac_get_pfc_frm_cfg,
+	.mac_reset   =			rpm_lmac_reset,
 };
 
 bool is_dev_rpm2(void *rpmd)
@@ -537,14 +539,15 @@ u32 rpm2_get_lmac_fifo_len(void *rpmd, int lmac_id)
 int rpm_lmac_internal_loopback(void *rpmd, int lmac_id, bool enable)
 {
 	rpm_t *rpm = rpmd;
-	u8 lmac_type;
+	struct lmac *lmac;
 	u64 cfg;
 
 	if (!is_lmac_valid(rpm, lmac_id))
 		return -ENODEV;
-	lmac_type = rpm->mac_ops->get_lmac_type(rpm, lmac_id);
 
-	if (lmac_type == LMAC_MODE_QSGMII || lmac_type == LMAC_MODE_SGMII) {
+	lmac = lmac_pdata(lmac_id, rpm);
+	if (lmac->lmac_type == LMAC_MODE_QSGMII ||
+	    lmac->lmac_type == LMAC_MODE_SGMII) {
 		dev_err(&rpm->pdev->dev, "loopback not supported for LPC mode\n");
 		return 0;
 	}
@@ -713,3 +716,24 @@ int rpm_get_fec_stats(void *rpmd, int lmac_id, struct cgx_fec_stats_rsp *rsp)
 
 	return 0;
 }
+
+int rpm_lmac_reset(void *rpmd, int lmac_id, u8 pf_req_flr)
+{
+	u64 rx_logl_xon, cfg;
+	rpm_t *rpm = rpmd;
+
+	if (!is_lmac_valid(rpm, lmac_id))
+		return -ENODEV;
+
+	/* Resetting PFC related CSRs */
+	rx_logl_xon = is_dev_rpm2(rpm) ? RPM2_CMRX_RX_LOGL_XON :
+					 RPMX_CMRX_RX_LOGL_XON;
+	cfg = 0xff;
+
+	rpm_write(rpm, lmac_id, rx_logl_xon, cfg);
+
+	if (pf_req_flr)
+		rpm_lmac_internal_loopback(rpm, lmac_id, false);
+
+	return 0;
+}
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rpm.h b/drivers/net/ethernet/marvell/octeontx2/af/rpm.h
index be294eebab265..b79cfbc6f8770 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rpm.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rpm.h
@@ -74,6 +74,7 @@
 #define RPMX_MTI_MAC100X_CL01_PAUSE_QUANTA              0x80A8
 #define RPMX_MTI_MAC100X_CL89_PAUSE_QUANTA		0x8108
 #define RPM_DEFAULT_PAUSE_TIME                          0x7FF
+#define RPMX_CMRX_RX_LOGL_XON				0x4100
 
 #define RPMX_MTI_MAC100X_XIF_MODE		        0x8100
 #define RPMX_ONESTEP_ENABLE				BIT_ULL(5)
@@ -132,4 +133,5 @@ int rpm_lmac_get_pfc_frm_cfg(void *rpmd, int lmac_id, u8 *tx_pause,
 int rpm2_get_nr_lmacs(void *rpmd);
 bool is_dev_rpm2(void *rpmd);
 int rpm_get_fec_stats(void *cgxd, int lmac_id, struct cgx_fec_stats_rsp *rsp);
+int rpm_lmac_reset(void *rpmd, int lmac_id, u8 pf_req_flr);
 #endif /* RPM_H */
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
index 9f673bda9dbdd..b26b013216933 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
@@ -2629,6 +2629,7 @@ static void __rvu_flr_handler(struct rvu *rvu, u16 pcifunc)
 	 * Since LF is detached use LF number as -1.
 	 */
 	rvu_npc_free_mcam_entries(rvu, pcifunc, -1);
+	rvu_mac_reset(rvu, pcifunc);
 
 	mutex_unlock(&rvu->flr_lock);
 }
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
index 68ff3244a84a2..be279cd1fd729 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
@@ -875,6 +875,7 @@ int rvu_cgx_config_tx(void *cgxd, int lmac_id, bool enable);
 int rvu_cgx_prio_flow_ctrl_cfg(struct rvu *rvu, u16 pcifunc, u8 tx_pause, u8 rx_pause,
 			       u16 pfc_en);
 int rvu_cgx_cfg_pause_frm(struct rvu *rvu, u16 pcifunc, u8 tx_pause, u8 rx_pause);
+void rvu_mac_reset(struct rvu *rvu, u16 pcifunc);
 u32 rvu_cgx_get_lmac_fifolen(struct rvu *rvu, int cgx, int lmac);
 int npc_get_nixlf_mcam_index(struct npc_mcam *mcam, u16 pcifunc, int nixlf,
 			     int type);
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
index 48611e6032284..4b8559ac0404f 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
@@ -1250,3 +1250,21 @@ int rvu_mbox_handler_cgx_prio_flow_ctrl_cfg(struct rvu *rvu,
 	mac_ops->mac_get_pfc_frm_cfg(cgxd, lmac_id, &rsp->tx_pause, &rsp->rx_pause);
 	return err;
 }
+
+void rvu_mac_reset(struct rvu *rvu, u16 pcifunc)
+{
+	int pf = rvu_get_pf(pcifunc);
+	struct mac_ops *mac_ops;
+	struct cgx *cgxd;
+	u8 cgx, lmac;
+
+	if (!is_pf_cgxmapped(rvu, pf))
+		return;
+
+	rvu_get_cgx_lmac_id(rvu->pf2cgxlmac_map[pf], &cgx, &lmac);
+	cgxd = rvu_cgx_pdata(cgx, rvu);
+	mac_ops = get_mac_ops(cgxd);
+
+	if (mac_ops->mac_reset(cgxd, lmac, !is_vf(pcifunc)))
+		dev_err(rvu->dev, "Failed to reset MAC\n");
+}
-- 
2.39.2



