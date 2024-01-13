Return-Path: <stable+bounces-10768-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC6E82CB8B
	for <lists+stable@lfdr.de>; Sat, 13 Jan 2024 11:00:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CE9AB22C35
	for <lists+stable@lfdr.de>; Sat, 13 Jan 2024 10:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D664D10958;
	Sat, 13 Jan 2024 10:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SBzlpuqR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4A61EEE6;
	Sat, 13 Jan 2024 10:00:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A0DBC433C7;
	Sat, 13 Jan 2024 10:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705140046;
	bh=BdVaFwYepQoWnE5D1TBFBPMh4UQysKIho0Za5qTc3Ok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SBzlpuqRGXCMX+OpUJl5E/FzR2ibtZIpWWC7OjcaNJknP9TGbaMFHkW8C8zroFt94
	 26J97lTzUWNPMfFZzes7vf1nXcdK6mT99JNzxo5ATOT6bE6fD91Gm1WnGTeb+z0NJS
	 pq+/uIAeFb4TZFwlkB1ZVWgDhtrMJA2HJqkL+XZQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Nithin Dabilpuram <ndabilpuram@marvell.com>,
	Sunil Goutham <sgoutham@marvell.com>,
	Geetha Sowjanya <gakula@marvell.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 36/59] octeontx2-af: Set NIX link credits based on max LMAC
Date: Sat, 13 Jan 2024 10:50:07 +0100
Message-ID: <20240113094210.415849316@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240113094209.301672391@linuxfoundation.org>
References: <20240113094209.301672391@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sunil Goutham <sgoutham@marvell.com>

[ Upstream commit 459f326e995ce6f02f3dc79ca5bc4e2abe33d156 ]

When number of LMACs active on a CGX/RPM are 3, then
current NIX link credit config based on per lmac fifo
length which inturn  is calculated as
'lmac_fifo_len = total_fifo_len / 3', is incorrect. In HW
one of the LMAC gets half of the FIFO and rest gets 1/4th.

Signed-off-by: Nithin Dabilpuram <ndabilpuram@marvell.com>
Signed-off-by: Sunil Goutham <sgoutham@marvell.com>
Signed-off-by: Geetha Sowjanya <gakula@marvell.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: a0d9528f6daf ("octeontx2-af: Always configure NIX TX link credits based on max frame size")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/marvell/octeontx2/af/cgx.c   | 27 +++++++++++++++
 .../marvell/octeontx2/af/lmac_common.h        |  1 +
 .../net/ethernet/marvell/octeontx2/af/rpm.c   | 30 ++++++++++++++++
 .../net/ethernet/marvell/octeontx2/af/rpm.h   |  1 +
 .../net/ethernet/marvell/octeontx2/af/rvu.h   |  2 +-
 .../ethernet/marvell/octeontx2/af/rvu_cgx.c   | 16 +++++++++
 .../ethernet/marvell/octeontx2/af/rvu_nix.c   | 34 ++++++++++++++-----
 7 files changed, 102 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
index 098504aa0fd2b..1a269a2e61fdb 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
@@ -505,6 +505,32 @@ static u8 cgx_get_lmac_type(void *cgxd, int lmac_id)
 	return (cfg >> CGX_LMAC_TYPE_SHIFT) & CGX_LMAC_TYPE_MASK;
 }
 
+static u32 cgx_get_lmac_fifo_len(void *cgxd, int lmac_id)
+{
+	struct cgx *cgx = cgxd;
+	u8 num_lmacs;
+	u32 fifo_len;
+
+	fifo_len = cgx->mac_ops->fifo_len;
+	num_lmacs = cgx->mac_ops->get_nr_lmacs(cgx);
+
+	switch (num_lmacs) {
+	case 1:
+		return fifo_len;
+	case 2:
+		return fifo_len / 2;
+	case 3:
+		/* LMAC0 gets half of the FIFO, reset 1/4th */
+		if (lmac_id == 0)
+			return fifo_len / 2;
+		return fifo_len / 4;
+	case 4:
+	default:
+		return fifo_len / 4;
+	}
+	return 0;
+}
+
 /* Configure CGX LMAC in internal loopback mode */
 int cgx_lmac_internal_loopback(void *cgxd, int lmac_id, bool enable)
 {
@@ -1557,6 +1583,7 @@ static struct mac_ops	cgx_mac_ops    = {
 	.tx_stats_cnt   =       18,
 	.get_nr_lmacs	=	cgx_get_nr_lmacs,
 	.get_lmac_type  =       cgx_get_lmac_type,
+	.lmac_fifo_len	=	cgx_get_lmac_fifo_len,
 	.mac_lmac_intl_lbk =    cgx_lmac_internal_loopback,
 	.mac_get_rx_stats  =	cgx_get_rx_stats,
 	.mac_get_tx_stats  =	cgx_get_tx_stats,
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/lmac_common.h b/drivers/net/ethernet/marvell/octeontx2/af/lmac_common.h
index b33e7d1d0851c..f6eb9fec1e8d6 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/lmac_common.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/lmac_common.h
@@ -76,6 +76,7 @@ struct mac_ops {
 	 */
 	int			(*get_nr_lmacs)(void *cgx);
 	u8                      (*get_lmac_type)(void *cgx, int lmac_id);
+	u32                     (*lmac_fifo_len)(void *cgx, int lmac_id);
 	int                     (*mac_lmac_intl_lbk)(void *cgx, int lmac_id,
 						     bool enable);
 	/* Register Stats related functions */
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rpm.c b/drivers/net/ethernet/marvell/octeontx2/af/rpm.c
index 8c0b35a868cfe..3ac26ba31e2f3 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rpm.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rpm.c
@@ -22,6 +22,7 @@ static struct mac_ops	rpm_mac_ops   = {
 	.tx_stats_cnt   =       34,
 	.get_nr_lmacs	=	rpm_get_nr_lmacs,
 	.get_lmac_type  =       rpm_get_lmac_type,
+	.lmac_fifo_len	=	rpm_get_lmac_fifo_len,
 	.mac_lmac_intl_lbk =    rpm_lmac_internal_loopback,
 	.mac_get_rx_stats  =	rpm_get_rx_stats,
 	.mac_get_tx_stats  =	rpm_get_tx_stats,
@@ -261,6 +262,35 @@ u8 rpm_get_lmac_type(void *rpmd, int lmac_id)
 	return err;
 }
 
+u32 rpm_get_lmac_fifo_len(void *rpmd, int lmac_id)
+{
+	rpm_t *rpm = rpmd;
+	u64 hi_perf_lmac;
+	u8 num_lmacs;
+	u32 fifo_len;
+
+	fifo_len = rpm->mac_ops->fifo_len;
+	num_lmacs = rpm->mac_ops->get_nr_lmacs(rpm);
+
+	switch (num_lmacs) {
+	case 1:
+		return fifo_len;
+	case 2:
+		return fifo_len / 2;
+	case 3:
+		/* LMAC marked as hi_perf gets half of the FIFO and rest 1/4th */
+		hi_perf_lmac = rpm_read(rpm, 0, CGXX_CMRX_RX_LMACS);
+		hi_perf_lmac = (hi_perf_lmac >> 4) & 0x3ULL;
+		if (lmac_id == hi_perf_lmac)
+			return fifo_len / 2;
+		return fifo_len / 4;
+	case 4:
+	default:
+		return fifo_len / 4;
+	}
+	return 0;
+}
+
 int rpm_lmac_internal_loopback(void *rpmd, int lmac_id, bool enable)
 {
 	rpm_t *rpm = rpmd;
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rpm.h b/drivers/net/ethernet/marvell/octeontx2/af/rpm.h
index ff580311edd03..39e9a1d068353 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rpm.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rpm.h
@@ -49,6 +49,7 @@
 /* Function Declarations */
 int rpm_get_nr_lmacs(void *rpmd);
 u8 rpm_get_lmac_type(void *rpmd, int lmac_id);
+u32 rpm_get_lmac_fifo_len(void *rpmd, int lmac_id);
 int rpm_lmac_internal_loopback(void *rpmd, int lmac_id, bool enable);
 void rpm_lmac_enadis_rx_pause_fwding(void *rpmd, int lmac_id, bool enable);
 int rpm_lmac_get_pause_frm_status(void *cgxd, int lmac_id, u8 *tx_pause,
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
index 9d517e6dac2f0..8d1df8a70ae0d 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
@@ -813,7 +813,7 @@ u32  rvu_cgx_get_fifolen(struct rvu *rvu);
 void *rvu_first_cgx_pdata(struct rvu *rvu);
 int cgxlmac_to_pf(struct rvu *rvu, int cgx_id, int lmac_id);
 int rvu_cgx_config_tx(void *cgxd, int lmac_id, bool enable);
-
+u32 rvu_cgx_get_lmac_fifolen(struct rvu *rvu, int cgx, int lmac);
 int npc_get_nixlf_mcam_index(struct npc_mcam *mcam, u16 pcifunc, int nixlf,
 			     int type);
 bool is_mcam_entry_enabled(struct rvu *rvu, struct npc_mcam *mcam, int blkaddr,
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
index f4c7bb6bf053a..4bd511b007cbc 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
@@ -831,6 +831,22 @@ u32 rvu_cgx_get_fifolen(struct rvu *rvu)
 	return fifo_len;
 }
 
+u32 rvu_cgx_get_lmac_fifolen(struct rvu *rvu, int cgx, int lmac)
+{
+	struct mac_ops *mac_ops;
+	void *cgxd;
+
+	cgxd = rvu_cgx_pdata(cgx, rvu);
+	if (!cgxd)
+		return 0;
+
+	mac_ops = get_mac_ops(cgxd);
+	if (!mac_ops->lmac_fifo_len)
+		return 0;
+
+	return mac_ops->lmac_fifo_len(cgxd, lmac);
+}
+
 static int rvu_cgx_config_intlbk(struct rvu *rvu, u16 pcifunc, bool en)
 {
 	int pf = rvu_get_pf(pcifunc);
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index 1ab9dc544eeea..874248499ef9a 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -4036,9 +4036,13 @@ int rvu_mbox_handler_nix_set_hw_frs(struct rvu *rvu, struct nix_frs_cfg *req,
 		return 0;
 
 	/* Update transmit credits for CGX links */
-	lmac_fifo_len =
-		rvu_cgx_get_fifolen(rvu) /
-		cgx_get_lmac_cnt(rvu_cgx_pdata(cgx, rvu));
+	lmac_fifo_len = rvu_cgx_get_lmac_fifolen(rvu, cgx, lmac);
+	if (!lmac_fifo_len) {
+		dev_err(rvu->dev,
+			"%s: Failed to get CGX/RPM%d:LMAC%d FIFO size\n",
+			__func__, cgx, lmac);
+		return 0;
+	}
 	return nix_config_link_credits(rvu, blkaddr, link, pcifunc,
 				       (lmac_fifo_len - req->maxlen) / 16);
 }
@@ -4086,7 +4090,10 @@ static void nix_link_config(struct rvu *rvu, int blkaddr,
 	struct rvu_hwinfo *hw = rvu->hw;
 	int cgx, lmac_cnt, slink, link;
 	u16 lbk_max_frs, lmac_max_frs;
+	unsigned long lmac_bmap;
 	u64 tx_credits, cfg;
+	u64 lmac_fifo_len;
+	int iter;
 
 	rvu_get_lbk_link_max_frs(rvu, &lbk_max_frs);
 	rvu_get_lmac_link_max_frs(rvu, &lmac_max_frs);
@@ -4120,12 +4127,23 @@ static void nix_link_config(struct rvu *rvu, int blkaddr,
 		/* Skip when cgx is not available or lmac cnt is zero */
 		if (lmac_cnt <= 0)
 			continue;
-		tx_credits = ((rvu_cgx_get_fifolen(rvu) / lmac_cnt) -
-			       lmac_max_frs) / 16;
-		/* Enable credits and set credit pkt count to max allowed */
-		cfg =  (tx_credits << 12) | (0x1FF << 2) | BIT_ULL(1);
 		slink = cgx * hw->lmac_per_cgx;
-		for (link = slink; link < (slink + lmac_cnt); link++) {
+
+		/* Get LMAC id's from bitmap */
+		lmac_bmap = cgx_get_lmac_bmap(rvu_cgx_pdata(cgx, rvu));
+		for_each_set_bit(iter, &lmac_bmap, MAX_LMAC_PER_CGX) {
+			lmac_fifo_len = rvu_cgx_get_lmac_fifolen(rvu, cgx, iter);
+			if (!lmac_fifo_len) {
+				dev_err(rvu->dev,
+					"%s: Failed to get CGX/RPM%d:LMAC%d FIFO size\n",
+					__func__, cgx, iter);
+				continue;
+			}
+			tx_credits = (lmac_fifo_len - lmac_max_frs) / 16;
+			/* Enable credits and set credit pkt count to max allowed */
+			cfg =  (tx_credits << 12) | (0x1FF << 2) | BIT_ULL(1);
+
+			link = iter + slink;
 			nix_hw->tx_credits[link] = tx_credits;
 			rvu_write64(rvu, blkaddr,
 				    NIX_AF_TX_LINKX_NORM_CREDIT(link), cfg);
-- 
2.43.0




