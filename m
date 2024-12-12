Return-Path: <stable+bounces-103255-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1309EF761
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 18:34:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5A3419411AD
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D46FA215764;
	Thu, 12 Dec 2024 17:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yVmpcjfD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8581F2381;
	Thu, 12 Dec 2024 17:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734024011; cv=none; b=YywQNScnlbiK35M3PbpAuIStLRRBpVgZpAki3LCOqd0IS4wZ5lEXEPbRU7vV+Ej7dE+XEqi7TIYDbk4hD4BLvCA0kExA8pEdlacBvCvAemqj6gdZMyoD0Z8jS7cg5sQvMAG5bqLK+DtWZqUpXrCPGIlzSue921V6kHr/PUWQedA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734024011; c=relaxed/simple;
	bh=N3xDhK0iq8no+M2Jc2JzGOeNR7XS8WGogrI+wIhTk0g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fO3WsPAkQYJxos5qmw0k5MqQIWkHZUAMQPExN0wyNXwQlTbHP2MaAOnitR5f29TtKkw1PSeKbqamCKkCHXwtrYfiPo6+ECqE8f5ajz1hPaHuABf83aGmofAloNtcy9HSuU5gJ/G1wg8W084MZrT6yKCORLlPMzBEVT5nfaWtLsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yVmpcjfD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A4E2C4CECE;
	Thu, 12 Dec 2024 17:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734024011;
	bh=N3xDhK0iq8no+M2Jc2JzGOeNR7XS8WGogrI+wIhTk0g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yVmpcjfDgJUiKoXBoIH6MQZq+IUmIrNn+36sjPzLO4JUSFzD6XbhOJxcHfcKCxxYC
	 3Wrz+93XoMs4bbpS6/BVCitcXOsUpCmKVTxZ6n8aLy4m2KHAHOD9VrUX3eI7KDSbC+
	 JO+E07567SUe56jVmxOO9eNxX26nBdv1q/nTg0Ls=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Christina Jacob <cjacob@marvell.com>,
	Sunil Goutham <sgoutham@marvell.com>,
	Hariprasad Kelam <hkelam@marvell.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 127/459] octeontx2-af: forward error correction configuration
Date: Thu, 12 Dec 2024 15:57:45 +0100
Message-ID: <20241212144258.523347092@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144253.511169641@linuxfoundation.org>
References: <20241212144253.511169641@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christina Jacob <cjacob@marvell.com>

[ Upstream commit 84c4f9cab4f99e774a8d9bbee299d288bdb2d792 ]

CGX block supports forward error correction modes baseR
and RS. This patch adds support to set encoding mode
and to read corrected/uncorrected block counters

Adds new mailbox handlers set_fec to configure encoding modes
and fec_stats to read counters and also increase mbox timeout
to accomdate firmware command response timeout.

Along with new CGX_CMD_SET_FEC command add other commands to
sync with kernel enum list with firmware.

Signed-off-by: Christina Jacob <cjacob@marvell.com>
Signed-off-by: Sunil Goutham <sgoutham@marvell.com>
Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: e26f8eac6bb2 ("octeontx2-pf: handle otx2_mbox_get_rsp errors in otx2_ethtool.c")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/marvell/octeontx2/af/cgx.c   | 76 +++++++++++++++++++
 .../net/ethernet/marvell/octeontx2/af/cgx.h   |  7 ++
 .../ethernet/marvell/octeontx2/af/cgx_fw_if.h | 17 ++++-
 .../net/ethernet/marvell/octeontx2/af/mbox.h  | 24 +++++-
 .../ethernet/marvell/octeontx2/af/rvu_cgx.c   | 33 ++++++++
 5 files changed, 155 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
index 7f82baf8e7403..6bcc403e031ff 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
@@ -340,6 +340,60 @@ int cgx_get_tx_stats(void *cgxd, int lmac_id, int idx, u64 *tx_stat)
 	return 0;
 }
 
+static int cgx_set_fec_stats_count(struct cgx_link_user_info *linfo)
+{
+	if (!linfo->fec)
+		return 0;
+
+	switch (linfo->lmac_type_id) {
+	case LMAC_MODE_SGMII:
+	case LMAC_MODE_XAUI:
+	case LMAC_MODE_RXAUI:
+	case LMAC_MODE_QSGMII:
+		return 0;
+	case LMAC_MODE_10G_R:
+	case LMAC_MODE_25G_R:
+	case LMAC_MODE_100G_R:
+	case LMAC_MODE_USXGMII:
+		return 1;
+	case LMAC_MODE_40G_R:
+		return 4;
+	case LMAC_MODE_50G_R:
+		if (linfo->fec == OTX2_FEC_BASER)
+			return 2;
+		else
+			return 1;
+	default:
+		return 0;
+	}
+}
+
+int cgx_get_fec_stats(void *cgxd, int lmac_id, struct cgx_fec_stats_rsp *rsp)
+{
+	int stats, fec_stats_count = 0;
+	int corr_reg, uncorr_reg;
+	struct cgx *cgx = cgxd;
+
+	if (!cgx || lmac_id >= cgx->lmac_count)
+		return -ENODEV;
+	fec_stats_count =
+		cgx_set_fec_stats_count(&cgx->lmac_idmap[lmac_id]->link_info);
+	if (cgx->lmac_idmap[lmac_id]->link_info.fec == OTX2_FEC_BASER) {
+		corr_reg = CGXX_SPUX_LNX_FEC_CORR_BLOCKS;
+		uncorr_reg = CGXX_SPUX_LNX_FEC_UNCORR_BLOCKS;
+	} else {
+		corr_reg = CGXX_SPUX_RSFEC_CORR;
+		uncorr_reg = CGXX_SPUX_RSFEC_UNCORR;
+	}
+	for (stats = 0; stats < fec_stats_count; stats++) {
+		rsp->fec_corr_blks +=
+			cgx_read(cgx, lmac_id, corr_reg + (stats * 8));
+		rsp->fec_uncorr_blks +=
+			cgx_read(cgx, lmac_id, uncorr_reg + (stats * 8));
+	}
+	return 0;
+}
+
 int cgx_lmac_rx_tx_enable(void *cgxd, int lmac_id, bool enable)
 {
 	struct cgx *cgx = cgxd;
@@ -620,6 +674,7 @@ static inline void link_status_user_format(u64 lstat,
 	linfo->link_up = FIELD_GET(RESP_LINKSTAT_UP, lstat);
 	linfo->full_duplex = FIELD_GET(RESP_LINKSTAT_FDUPLEX, lstat);
 	linfo->speed = cgx_speed_mbps[FIELD_GET(RESP_LINKSTAT_SPEED, lstat)];
+	linfo->fec = FIELD_GET(RESP_LINKSTAT_FEC, lstat);
 	linfo->lmac_type_id = cgx_get_lmac_type(cgx, lmac_id);
 	lmac_string = cgx_lmactype_string[linfo->lmac_type_id];
 	strncpy(linfo->lmac_type, lmac_string, LMACTYPE_STR_LEN - 1);
@@ -790,6 +845,27 @@ int cgx_get_fwdata_base(u64 *base)
 	return err;
 }
 
+int cgx_set_fec(u64 fec, int cgx_id, int lmac_id)
+{
+	u64 req = 0, resp;
+	struct cgx *cgx;
+	int err = 0;
+
+	cgx = cgx_get_pdata(cgx_id);
+	if (!cgx)
+		return -ENXIO;
+
+	req = FIELD_SET(CMDREG_ID, CGX_CMD_SET_FEC, req);
+	req = FIELD_SET(CMDSETFEC, fec, req);
+	err = cgx_fwi_cmd_generic(req, &resp, cgx, lmac_id);
+	if (err)
+		return err;
+
+	cgx->lmac_idmap[lmac_id]->link_info.fec =
+			FIELD_GET(RESP_LINKSTAT_FEC, resp);
+	return cgx->lmac_idmap[lmac_id]->link_info.fec;
+}
+
 static int cgx_fwi_link_change(struct cgx *cgx, int lmac_id, bool enable)
 {
 	u64 req = 0;
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cgx.h b/drivers/net/ethernet/marvell/octeontx2/af/cgx.h
index e176a6c654ef2..6295a6963ff78 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.h
@@ -55,6 +55,11 @@
 #define CGXX_SCRATCH1_REG		0x1058
 #define CGX_CONST			0x2000
 #define CGXX_SPUX_CONTROL1		0x10000
+#define CGXX_SPUX_LNX_FEC_CORR_BLOCKS	0x10700
+#define CGXX_SPUX_LNX_FEC_UNCORR_BLOCKS	0x10800
+#define CGXX_SPUX_RSFEC_CORR		0x10088
+#define CGXX_SPUX_RSFEC_UNCORR		0x10090
+
 #define CGXX_SPUX_CONTROL1_LBK		BIT_ULL(14)
 #define CGXX_GMP_PCS_MRX_CTL		0x30000
 #define CGXX_GMP_PCS_MRX_CTL_LBK	BIT_ULL(14)
@@ -146,5 +151,7 @@ int cgx_lmac_set_pause_frm(void *cgxd, int lmac_id,
 			   u8 tx_pause, u8 rx_pause);
 void cgx_lmac_ptp_config(void *cgxd, int lmac_id, bool enable);
 u8 cgx_lmac_get_p2x(int cgx_id, int lmac_id);
+int cgx_set_fec(u64 fec, int cgx_id, int lmac_id);
+int cgx_get_fec_stats(void *cgxd, int lmac_id, struct cgx_fec_stats_rsp *rsp);
 
 #endif /* CGX_H */
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cgx_fw_if.h b/drivers/net/ethernet/marvell/octeontx2/af/cgx_fw_if.h
index c3702fa58b6bd..3485596c0ed6c 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cgx_fw_if.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx_fw_if.h
@@ -81,6 +81,14 @@ enum cgx_cmd_id {
 	CGX_CMD_GET_MKEX_PRFL_SIZE,
 	CGX_CMD_GET_MKEX_PRFL_ADDR,
 	CGX_CMD_GET_FWD_BASE,		/* get base address of shared FW data */
+	CGX_CMD_GET_LINK_MODES,		/* Supported Link Modes */
+	CGX_CMD_SET_LINK_MODE,
+	CGX_CMD_GET_SUPPORTED_FEC,
+	CGX_CMD_SET_FEC,
+	CGX_CMD_GET_AN,
+	CGX_CMD_SET_AN,
+	CGX_CMD_GET_ADV_LINK_MODES,
+	CGX_CMD_GET_ADV_FEC,
 };
 
 /* async event ids */
@@ -171,13 +179,19 @@ struct cgx_lnk_sts {
 	uint64_t full_duplex:1;
 	uint64_t speed:4;		/* cgx_link_speed */
 	uint64_t err_type:10;
-	uint64_t reserved2:39;
+	uint64_t an:1;			/* AN supported or not */
+	uint64_t fec:2;			/* FEC type if enabled, if not 0 */
+	uint64_t port:8;
+	uint64_t reserved2:28;
 };
 
 #define RESP_LINKSTAT_UP		GENMASK_ULL(9, 9)
 #define RESP_LINKSTAT_FDUPLEX		GENMASK_ULL(10, 10)
 #define RESP_LINKSTAT_SPEED		GENMASK_ULL(14, 11)
 #define RESP_LINKSTAT_ERRTYPE		GENMASK_ULL(24, 15)
+#define RESP_LINKSTAT_AN		GENMASK_ULL(25, 25)
+#define RESP_LINKSTAT_FEC		GENMASK_ULL(27, 26)
+#define RESP_LINKSTAT_PORT		GENMASK_ULL(35, 28)
 
 /* scratchx(1) CSR used for non-secure SW->ATF communication
  * This CSR acts as a command register
@@ -199,4 +213,5 @@ struct cgx_lnk_sts {
 #define CMDLINKCHANGE_FULLDPLX	BIT_ULL(9)
 #define CMDLINKCHANGE_SPEED	GENMASK_ULL(13, 10)
 
+#define CMDSETFEC			GENMASK_ULL(9, 8)
 #endif /* __CGX_FW_INTF_H__ */
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index f46de8419b770..9a135d1cf102d 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -36,7 +36,7 @@
 
 #define INTR_MASK(pfvfs) ((pfvfs < 64) ? (BIT_ULL(pfvfs) - 1) : (~0ull))
 
-#define MBOX_RSP_TIMEOUT	2000 /* Time(ms) to wait for mbox response */
+#define MBOX_RSP_TIMEOUT	3000 /* Time(ms) to wait for mbox response */
 
 #define MBOX_MSG_ALIGN		16  /* Align mbox msg start to 16bytes */
 
@@ -149,6 +149,9 @@ M(CGX_PTP_RX_ENABLE,	0x20C, cgx_ptp_rx_enable, msg_req, msg_rsp)	\
 M(CGX_PTP_RX_DISABLE,	0x20D, cgx_ptp_rx_disable, msg_req, msg_rsp)	\
 M(CGX_CFG_PAUSE_FRM,	0x20E, cgx_cfg_pause_frm, cgx_pause_frm_cfg,	\
 			       cgx_pause_frm_cfg)			\
+M(CGX_FEC_SET,		0x210, cgx_set_fec_param, fec_mode, fec_mode)   \
+M(CGX_FEC_STATS,	0x211, cgx_fec_stats, msg_req, cgx_fec_stats_rsp) \
+ /* NPA mbox IDs (range 0x400 - 0x5FF) */				\
 /* NPA mbox IDs (range 0x400 - 0x5FF) */				\
 M(NPA_LF_ALLOC,		0x400, npa_lf_alloc,				\
 				npa_lf_alloc_req, npa_lf_alloc_rsp)	\
@@ -346,6 +349,11 @@ struct cgx_stats_rsp {
 	u64 tx_stats[CGX_TX_STATS_COUNT];
 };
 
+struct cgx_fec_stats_rsp {
+	struct mbox_msghdr hdr;
+	u64 fec_corr_blks;
+	u64 fec_uncorr_blks;
+};
 /* Structure for requesting the operation for
  * setting/getting mac address in the CGX interface
  */
@@ -359,6 +367,7 @@ struct cgx_link_user_info {
 	uint64_t full_duplex:1;
 	uint64_t lmac_type_id:4;
 	uint64_t speed:20; /* speed in Mbps */
+	uint64_t fec:2;	 /* FEC type if enabled else 0 */
 #define LMACTYPE_STR_LEN 16
 	char lmac_type[LMACTYPE_STR_LEN];
 };
@@ -377,6 +386,19 @@ struct cgx_pause_frm_cfg {
 	u8 tx_pause;
 };
 
+enum fec_type {
+	OTX2_FEC_NONE,
+	OTX2_FEC_BASER,
+	OTX2_FEC_RS,
+	OTX2_FEC_STATS_CNT = 2,
+	OTX2_FEC_OFF,
+};
+
+struct fec_mode {
+	struct mbox_msghdr hdr;
+	int fec;
+};
+
 /* NPA mbox message formats */
 
 /* NPA mailbox error codes
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
index 83743e15326d7..05ef3a104748a 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
@@ -462,6 +462,22 @@ int rvu_mbox_handler_cgx_stats(struct rvu *rvu, struct msg_req *req,
 	return 0;
 }
 
+int rvu_mbox_handler_cgx_fec_stats(struct rvu *rvu,
+				   struct msg_req *req,
+				   struct cgx_fec_stats_rsp *rsp)
+{
+	int pf = rvu_get_pf(req->hdr.pcifunc);
+	u8 cgx_idx, lmac;
+	void *cgxd;
+
+	if (!is_cgx_config_permitted(rvu, req->hdr.pcifunc))
+		return -EPERM;
+	rvu_get_cgx_lmac_id(rvu->pf2cgxlmac_map[pf], &cgx_idx, &lmac);
+
+	cgxd = rvu_cgx_pdata(cgx_idx, rvu);
+	return cgx_get_fec_stats(cgxd, lmac, rsp);
+}
+
 int rvu_mbox_handler_cgx_mac_addr_set(struct rvu *rvu,
 				      struct cgx_mac_addr_set_or_get *req,
 				      struct cgx_mac_addr_set_or_get *rsp)
@@ -767,3 +783,20 @@ int rvu_cgx_start_stop_io(struct rvu *rvu, u16 pcifunc, bool start)
 	mutex_unlock(&rvu->cgx_cfg_lock);
 	return err;
 }
+
+int rvu_mbox_handler_cgx_set_fec_param(struct rvu *rvu,
+				       struct fec_mode *req,
+				       struct fec_mode *rsp)
+{
+	int pf = rvu_get_pf(req->hdr.pcifunc);
+	u8 cgx_id, lmac_id;
+
+	if (!is_pf_cgxmapped(rvu, pf))
+		return -EPERM;
+
+	if (req->fec == OTX2_FEC_OFF)
+		req->fec = OTX2_FEC_NONE;
+	rvu_get_cgx_lmac_id(rvu->pf2cgxlmac_map[pf], &cgx_id, &lmac_id);
+	rsp->fec = cgx_set_fec(req->fec, cgx_id, lmac_id);
+	return 0;
+}
-- 
2.43.0




