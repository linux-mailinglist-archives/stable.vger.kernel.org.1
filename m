Return-Path: <stable+bounces-103226-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D378B9EF5AB
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 18:18:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7828A28BC2A
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EDD72153DD;
	Thu, 12 Dec 2024 17:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jtoC3vPm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0EC4F218;
	Thu, 12 Dec 2024 17:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734023924; cv=none; b=VHmByrsdszRJmWButhnokekz60MoY8B9iBLml82tPJC5d891/VdidBWIV4icxw9LEl134pYCwml4on6nsVhhIqbHT/t6v3nBHaWgPscffaXVh878Okh4NmEzpe/IbWTVTOIl4/EcxmAyW0mgBRyXqFkjMYvd9dJi3s1icPsfTRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734023924; c=relaxed/simple;
	bh=1O2nLAzmycZHVszrK6ADrEfEa3qYdaLVb7HH9KhpBaM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jSPvLmBNYOxTdX/siyniEU1VY4nwBzuOa73xT4Gpz4l9Nc6/JOFYYQjSVjqMLpiFP81XtlKztMrRt1S6sFRme8i85m4g1ZYGRYtdGTwqw8tlnb1PpavWPLG6THDpTdSIE2QoVxEQ7VUytUt/6/Jndt4P5GXROpsXJW9NXxJ6rGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jtoC3vPm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12E6CC4CECE;
	Thu, 12 Dec 2024 17:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734023923;
	bh=1O2nLAzmycZHVszrK6ADrEfEa3qYdaLVb7HH9KhpBaM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jtoC3vPmh3DI3FsMmGUG/HKLqCkCd1DusV0BfBSBEQ4mDiceRmaf77eW4hnpbS2/n
	 gcBzH5Sp18d8NdjZ2jRgNhGSPzPS58dANjUQdr/DJBV9nRX9aXzOzrgUbUZkgyk+iP
	 Z/QEIFl9NYld+SiyWMhGfFhhM18BQQtm+WSqg76I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Felix Manlunas <fmanlunas@marvell.com>,
	Christina Jacob <cjacob@marvell.com>,
	Sunil Goutham <sgoutham@marvell.com>,
	Hariprasad Kelam <hkelam@marvell.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 128/459] octeontx2-af: Add new CGX_CMD to get PHY FEC statistics
Date: Thu, 12 Dec 2024 15:57:46 +0100
Message-ID: <20241212144258.561839989@linuxfoundation.org>
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

From: Felix Manlunas <fmanlunas@marvell.com>

[ Upstream commit bd74d4ea29cc3c0520d9af109bb7a7c769325746 ]

This patch adds support to fetch fec stats from PHY. The stats are
put in the shared data struct fwdata.  A PHY driver indicates
that it has FEC stats by setting the flag fwdata.phy.misc.has_fec_stats

Besides CGX_CMD_GET_PHY_FEC_STATS, also add CGX_CMD_PRBS and
CGX_CMD_DISPLAY_EYE to enum cgx_cmd_id so that Linux's enum list is in sync
with firmware's enum list.

Signed-off-by: Felix Manlunas <fmanlunas@marvell.com>
Signed-off-by: Christina Jacob <cjacob@marvell.com>
Signed-off-by: Sunil Goutham <sgoutham@marvell.com>
Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: e26f8eac6bb2 ("octeontx2-pf: handle otx2_mbox_get_rsp errors in otx2_ethtool.c")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/marvell/octeontx2/af/cgx.c   | 12 ++++++
 .../net/ethernet/marvell/octeontx2/af/cgx.h   |  1 +
 .../ethernet/marvell/octeontx2/af/cgx_fw_if.h |  5 +++
 .../net/ethernet/marvell/octeontx2/af/mbox.h  | 43 +++++++++++++++++++
 .../net/ethernet/marvell/octeontx2/af/rvu.h   |  4 ++
 .../ethernet/marvell/octeontx2/af/rvu_cgx.c   | 32 ++++++++++++++
 6 files changed, 97 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
index 6bcc403e031ff..1eaf728d5e79f 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
@@ -866,6 +866,18 @@ int cgx_set_fec(u64 fec, int cgx_id, int lmac_id)
 	return cgx->lmac_idmap[lmac_id]->link_info.fec;
 }
 
+int cgx_get_phy_fec_stats(void *cgxd, int lmac_id)
+{
+	struct cgx *cgx = cgxd;
+	u64 req = 0, resp;
+
+	if (!cgx)
+		return -ENODEV;
+
+	req = FIELD_SET(CMDREG_ID, CGX_CMD_GET_PHY_FEC_STATS, req);
+	return cgx_fwi_cmd_generic(req, &resp, cgx, lmac_id);
+}
+
 static int cgx_fwi_link_change(struct cgx *cgx, int lmac_id, bool enable)
 {
 	u64 req = 0;
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cgx.h b/drivers/net/ethernet/marvell/octeontx2/af/cgx.h
index 6295a6963ff78..82563a88fe1bb 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.h
@@ -153,5 +153,6 @@ void cgx_lmac_ptp_config(void *cgxd, int lmac_id, bool enable);
 u8 cgx_lmac_get_p2x(int cgx_id, int lmac_id);
 int cgx_set_fec(u64 fec, int cgx_id, int lmac_id);
 int cgx_get_fec_stats(void *cgxd, int lmac_id, struct cgx_fec_stats_rsp *rsp);
+int cgx_get_phy_fec_stats(void *cgxd, int lmac_id);
 
 #endif /* CGX_H */
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cgx_fw_if.h b/drivers/net/ethernet/marvell/octeontx2/af/cgx_fw_if.h
index 3485596c0ed6c..65f832ac39cf1 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cgx_fw_if.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx_fw_if.h
@@ -89,6 +89,11 @@ enum cgx_cmd_id {
 	CGX_CMD_SET_AN,
 	CGX_CMD_GET_ADV_LINK_MODES,
 	CGX_CMD_GET_ADV_FEC,
+	CGX_CMD_GET_PHY_MOD_TYPE, /* line-side modulation type: NRZ or PAM4 */
+	CGX_CMD_SET_PHY_MOD_TYPE,
+	CGX_CMD_PRBS,
+	CGX_CMD_DISPLAY_EYE,
+	CGX_CMD_GET_PHY_FEC_STATS,
 };
 
 /* async event ids */
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index 9a135d1cf102d..ccd58d378fe48 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -151,6 +151,8 @@ M(CGX_CFG_PAUSE_FRM,	0x20E, cgx_cfg_pause_frm, cgx_pause_frm_cfg,	\
 			       cgx_pause_frm_cfg)			\
 M(CGX_FEC_SET,		0x210, cgx_set_fec_param, fec_mode, fec_mode)   \
 M(CGX_FEC_STATS,	0x211, cgx_fec_stats, msg_req, cgx_fec_stats_rsp) \
+M(CGX_GET_PHY_FEC_STATS, 0x212, cgx_get_phy_fec_stats, msg_req, msg_rsp) \
+M(CGX_FW_DATA_GET,	0x213, cgx_get_aux_link_info, msg_req, cgx_fw_data) \
  /* NPA mbox IDs (range 0x400 - 0x5FF) */				\
 /* NPA mbox IDs (range 0x400 - 0x5FF) */				\
 M(NPA_LF_ALLOC,		0x400, npa_lf_alloc,				\
@@ -399,6 +401,47 @@ struct fec_mode {
 	int fec;
 };
 
+struct sfp_eeprom_s {
+#define SFP_EEPROM_SIZE 256
+	u16 sff_id;
+	u8 buf[SFP_EEPROM_SIZE];
+	u64 reserved;
+};
+
+struct phy_s {
+	struct {
+		u64 can_change_mod_type:1;
+		u64 mod_type:1;
+		u64 has_fec_stats:1;
+	} misc;
+	struct fec_stats_s {
+		u32 rsfec_corr_cws;
+		u32 rsfec_uncorr_cws;
+		u32 brfec_corr_blks;
+		u32 brfec_uncorr_blks;
+	} fec_stats;
+};
+
+struct cgx_lmac_fwdata_s {
+	u16 rw_valid;
+	u64 supported_fec;
+	u64 supported_an;
+	u64 supported_link_modes;
+	/* only applicable if AN is supported */
+	u64 advertised_fec;
+	u64 advertised_link_modes;
+	/* Only applicable if SFP/QSFP slot is present */
+	struct sfp_eeprom_s sfp_eeprom;
+	struct phy_s phy;
+#define LMAC_FWDATA_RESERVED_MEM 1021
+	u64 reserved[LMAC_FWDATA_RESERVED_MEM];
+};
+
+struct cgx_fw_data {
+	struct mbox_msghdr hdr;
+	struct cgx_lmac_fwdata_s fwdata;
+};
+
 /* NPA mbox message formats */
 
 /* NPA mailbox error codes
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
index ec9a291e866c7..da8ab4ac4280d 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
@@ -291,6 +291,10 @@ struct rvu_fwdata {
 	u64 msixtr_base;
 #define FWDATA_RESERVED_MEM 1023
 	u64 reserved[FWDATA_RESERVED_MEM];
+#define CGX_MAX         5
+#define CGX_LMACS_MAX   4
+	struct cgx_lmac_fwdata_s cgx_fw_data[CGX_MAX][CGX_LMACS_MAX];
+	/* Do not add new fields below this line */
 };
 
 struct ptp;
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
index 05ef3a104748a..8f116d681ff42 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
@@ -692,6 +692,19 @@ int rvu_mbox_handler_cgx_cfg_pause_frm(struct rvu *rvu,
 	return 0;
 }
 
+int rvu_mbox_handler_cgx_get_phy_fec_stats(struct rvu *rvu, struct msg_req *req,
+					   struct msg_rsp *rsp)
+{
+	int pf = rvu_get_pf(req->hdr.pcifunc);
+	u8 cgx_id, lmac_id;
+
+	if (!is_pf_cgxmapped(rvu, pf))
+		return -EPERM;
+
+	rvu_get_cgx_lmac_id(rvu->pf2cgxlmac_map[pf], &cgx_id, &lmac_id);
+	return cgx_get_phy_fec_stats(rvu_cgx_pdata(cgx_id, rvu), lmac_id);
+}
+
 /* Finds cumulative status of NIX rx/tx counters from LF of a PF and those
  * from its VFs as well. ie. NIX rx/tx counters at the CGX port level
  */
@@ -800,3 +813,22 @@ int rvu_mbox_handler_cgx_set_fec_param(struct rvu *rvu,
 	rsp->fec = cgx_set_fec(req->fec, cgx_id, lmac_id);
 	return 0;
 }
+
+int rvu_mbox_handler_cgx_get_aux_link_info(struct rvu *rvu, struct msg_req *req,
+					   struct cgx_fw_data *rsp)
+{
+	int pf = rvu_get_pf(req->hdr.pcifunc);
+	u8 cgx_id, lmac_id;
+
+	if (!rvu->fwdata)
+		return -ENXIO;
+
+	if (!is_pf_cgxmapped(rvu, pf))
+		return -EPERM;
+
+	rvu_get_cgx_lmac_id(rvu->pf2cgxlmac_map[pf], &cgx_id, &lmac_id);
+
+	memcpy(&rsp->fwdata, &rvu->fwdata->cgx_fw_data[cgx_id][lmac_id],
+	       sizeof(struct cgx_lmac_fwdata_s));
+	return 0;
+}
-- 
2.43.0




