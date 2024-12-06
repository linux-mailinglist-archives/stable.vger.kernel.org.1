Return-Path: <stable+bounces-99635-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 561B39E728F
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 16:10:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12591286FAA
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 15:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78EEE153836;
	Fri,  6 Dec 2024 15:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gVIu+SMj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34ECA1DFD89;
	Fri,  6 Dec 2024 15:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733497843; cv=none; b=PvVWi+honQUTs9ncVYHbe86A29AQuS8odFFV3erDMkiG6NkY/StxffNBFwuE0Yp7/e4/C3CbogsR+19r30tqVMsYbxD//IOHi0gyhyCj76jw7cX72vrDR5FOQiV4Zeh0VWwW5rbTVISm2CMvJf5ev+fGV1z39TN3C362HGhaUVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733497843; c=relaxed/simple;
	bh=io+YAiKYskJsbv+HzlFtktFCbHeRYlEjC5vTOq0BZe0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ghQVe190BxclLLhdr1W77vCbpkC5jAzBxgzNhgaMVQ41NS0W9DNM2xYlF+VvD9ApVqMG36SQZGsSH3I9D+zE/AOzxo8HJMdv0BeBndlYRJHU42AaPRnbMlf/4CTsQ7OqSgyXBJ48aL9/yAHR4OH3DACfF0MObOB4D3M0pS/cbAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gVIu+SMj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F1A3C2BCAF;
	Fri,  6 Dec 2024 15:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733497842;
	bh=io+YAiKYskJsbv+HzlFtktFCbHeRYlEjC5vTOq0BZe0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gVIu+SMjKsB/l43Hep/kh/hLiEQVHO8yC0/KYgCvkuUp6VK6ep5zrCoF7pLLMPSjB
	 bQHDbd6qBEou5NTLcsALu/EE38I/DmhUV60MKo/Hl1Gv4rjXOUGzLopBBe1JPsmnd3
	 JlnGsJk7SU69wuTMrjAGXWVQs7D+ZQSS42M5bKbI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hariprasad Kelam <hkelam@marvell.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 409/676] octeontx2-af: RPM: Fix low network performance
Date: Fri,  6 Dec 2024 15:33:48 +0100
Message-ID: <20241206143709.323139063@linuxfoundation.org>
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

From: Hariprasad Kelam <hkelam@marvell.com>

[ Upstream commit d1e8884e050c1255a9ceb477f5ff926ee9214a23 ]

Low network performance is observed even on RPMs with larger
FIFO lengths.

The cn10kb silicon has three RPM blocks with the following
FIFO sizes:

         --------------------
         | RPM0  |   256KB  |
         | RPM1  |   256KB  |
         | RPM2  |   128KB  |
         --------------------

The current design stores the FIFO length in a common structure for all
RPMs (mac_ops). As a result, the FIFO length of the last RPM is applied
to all RPMs, leading to reduced network performance.

This patch resolved the problem by storing the fifo length in per MAC
structure (cgx).

Fixes: b9d0fedc6234 ("octeontx2-af: cn10kb: Add RPM_USX MAC support")
Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/marvell/octeontx2/af/cgx.c         | 9 +++++++--
 drivers/net/ethernet/marvell/octeontx2/af/cgx.h         | 1 +
 drivers/net/ethernet/marvell/octeontx2/af/lmac_common.h | 5 ++++-
 drivers/net/ethernet/marvell/octeontx2/af/rpm.c         | 6 +++---
 drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c     | 9 ++++-----
 5 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
index 2539c985f695a..aea963017d261 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
@@ -110,6 +110,11 @@ struct mac_ops *get_mac_ops(void *cgxd)
 	return ((struct cgx *)cgxd)->mac_ops;
 }
 
+u32 cgx_get_fifo_len(void *cgxd)
+{
+	return ((struct cgx *)cgxd)->fifo_len;
+}
+
 void cgx_write(struct cgx *cgx, u64 lmac, u64 offset, u64 val)
 {
 	writeq(val, cgx->reg_base + (lmac << cgx->mac_ops->lmac_offset) +
@@ -499,7 +504,7 @@ static u32 cgx_get_lmac_fifo_len(void *cgxd, int lmac_id)
 	u8 num_lmacs;
 	u32 fifo_len;
 
-	fifo_len = cgx->mac_ops->fifo_len;
+	fifo_len = cgx->fifo_len;
 	num_lmacs = cgx->mac_ops->get_nr_lmacs(cgx);
 
 	switch (num_lmacs) {
@@ -1740,7 +1745,7 @@ static void cgx_populate_features(struct cgx *cgx)
 	u64 cfg;
 
 	cfg = cgx_read(cgx, 0, CGX_CONST);
-	cgx->mac_ops->fifo_len = FIELD_GET(CGX_CONST_RXFIFO_SIZE, cfg);
+	cgx->fifo_len = FIELD_GET(CGX_CONST_RXFIFO_SIZE, cfg);
 	cgx->max_lmac_per_mac = FIELD_GET(CGX_CONST_MAX_LMACS, cfg);
 
 	if (is_dev_rpm(cgx))
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cgx.h b/drivers/net/ethernet/marvell/octeontx2/af/cgx.h
index 6f7d1dee58308..226ff7f0df52a 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.h
@@ -184,4 +184,5 @@ int cgx_lmac_get_pfc_frm_cfg(void *cgxd, int lmac_id, u8 *tx_pause,
 int verify_lmac_fc_cfg(void *cgxd, int lmac_id, u8 tx_pause, u8 rx_pause,
 		       int pfvf_idx);
 int cgx_lmac_reset(void *cgxd, int lmac_id, u8 pf_req_flr);
+u32 cgx_get_fifo_len(void *cgxd);
 #endif /* CGX_H */
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/lmac_common.h b/drivers/net/ethernet/marvell/octeontx2/af/lmac_common.h
index 0b4cba03f2e83..50fcc436d8a79 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/lmac_common.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/lmac_common.h
@@ -72,7 +72,6 @@ struct mac_ops {
 	u8			irq_offset;
 	u8			int_ena_bit;
 	u8			lmac_fwi;
-	u32			fifo_len;
 	bool			non_contiguous_serdes_lane;
 	/* RPM & CGX differs in number of Receive/transmit stats */
 	u8			rx_stats_cnt;
@@ -141,6 +140,10 @@ struct cgx {
 	u8			lmac_count;
 	/* number of LMACs per MAC could be 4 or 8 */
 	u8			max_lmac_per_mac;
+	/* length of fifo varies depending on the number
+	 * of LMACS
+	 */
+	u32			fifo_len;
 #define MAX_LMAC_COUNT		8
 	struct lmac             *lmac_idmap[MAX_LMAC_COUNT];
 	struct			work_struct cgx_cmd_work;
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rpm.c b/drivers/net/ethernet/marvell/octeontx2/af/rpm.c
index ce584b6aa6d65..4d2d15834f9df 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rpm.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rpm.c
@@ -463,7 +463,7 @@ u32 rpm_get_lmac_fifo_len(void *rpmd, int lmac_id)
 	u8 num_lmacs;
 	u32 fifo_len;
 
-	fifo_len = rpm->mac_ops->fifo_len;
+	fifo_len = rpm->fifo_len;
 	num_lmacs = rpm->mac_ops->get_nr_lmacs(rpm);
 
 	switch (num_lmacs) {
@@ -516,9 +516,9 @@ u32 rpm2_get_lmac_fifo_len(void *rpmd, int lmac_id)
 	 */
 	max_lmac = (rpm_read(rpm, 0, CGX_CONST) >> 24) & 0xFF;
 	if (max_lmac > 4)
-		fifo_len = rpm->mac_ops->fifo_len / 2;
+		fifo_len = rpm->fifo_len / 2;
 	else
-		fifo_len = rpm->mac_ops->fifo_len;
+		fifo_len = rpm->fifo_len;
 
 	if (lmac_id < 4) {
 		num_lmacs = hweight8(lmac_info & 0xF);
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
index 19075f217d00c..898584b1aa608 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
@@ -895,13 +895,12 @@ int rvu_mbox_handler_cgx_features_get(struct rvu *rvu,
 
 u32 rvu_cgx_get_fifolen(struct rvu *rvu)
 {
-	struct mac_ops *mac_ops;
-	u32 fifo_len;
+	void *cgxd = rvu_first_cgx_pdata(rvu);
 
-	mac_ops = get_mac_ops(rvu_first_cgx_pdata(rvu));
-	fifo_len = mac_ops ? mac_ops->fifo_len : 0;
+	if (!cgxd)
+		return 0;
 
-	return fifo_len;
+	return cgx_get_fifo_len(cgxd);
 }
 
 u32 rvu_cgx_get_lmac_fifolen(struct rvu *rvu, int cgx, int lmac)
-- 
2.43.0




