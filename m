Return-Path: <stable+bounces-7153-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E3F81712C
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 14:55:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C13F82810D6
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 13:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF88A101D4;
	Mon, 18 Dec 2023 13:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="C6iGWSBI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EEF1D126;
	Mon, 18 Dec 2023 13:55:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D5C5C433C7;
	Mon, 18 Dec 2023 13:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702907703;
	bh=gVXSBf4k7QfaaW0Bb+7/g7FyvCM7JVeC3HSxSG9hc/M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C6iGWSBIGoJhbIxVDfhfR8OwtoutYSfPUVQAXyw9ZiErr9edNyDkVa8uMZWAwFQv0
	 BBI2E13WqamKHWPVxYOxVJ4fmBnRy/em41fsS80zuxB5ToKzSqbJJxAaStswN6HrY/
	 kaG29CaU1QM+07/I4X7DwKOGpimjAC8Q8N1qAW8k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ajit Khaparde <ajit.khaparde@broadcom.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 016/106] bnxt_en: Save ring error counters across reset
Date: Mon, 18 Dec 2023 14:50:30 +0100
Message-ID: <20231218135055.652970408@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218135055.005497074@linuxfoundation.org>
References: <20231218135055.005497074@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Chan <michael.chan@broadcom.com>

[ Upstream commit 4c70dbe3c0087b439b9e5015057e3e378cf5d8b1 ]

Currently, the ring counters are stored in the per ring datastructure.
During reset, all the rings are freed together with the associated
datastructures.  As a result, all the ring error counters will be reset
to zero.

Add logic to keep track of the total error counts of all the rings
and save them before reset (including ifdown).  The next patch will
display these total ring error counters under ethtool -S.

Link: https://lore.kernel.org/netdev/CACKFLimD-bKmJ1tGZOLYRjWzEwxkri-Mw7iFme1x2Dr0twdCeg@mail.gmail.com/
Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Link: https://lore.kernel.org/r/20230817231911.165035-5-michael.chan@broadcom.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: bd6781c18cb5 ("bnxt_en: Fix wrong return value check in bnxt_close_nic()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 32 ++++++++++++++++++++++-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h | 15 +++++++++++
 2 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 44d88bc1fcbd6..1d2836373df97 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -10708,8 +10708,10 @@ static void __bnxt_close_nic(struct bnxt *bp, bool irq_re_init,
 	bnxt_free_skbs(bp);
 
 	/* Save ring stats before shutdown */
-	if (bp->bnapi && irq_re_init)
+	if (bp->bnapi && irq_re_init) {
 		bnxt_get_ring_stats(bp, &bp->net_stats_prev);
+		bnxt_get_ring_err_stats(bp, &bp->ring_err_stats_prev);
+	}
 	if (irq_re_init) {
 		bnxt_free_irq(bp);
 		bnxt_del_napi(bp);
@@ -10958,6 +10960,34 @@ bnxt_get_stats64(struct net_device *dev, struct rtnl_link_stats64 *stats)
 	clear_bit(BNXT_STATE_READ_STATS, &bp->state);
 }
 
+static void bnxt_get_one_ring_err_stats(struct bnxt *bp,
+					struct bnxt_total_ring_err_stats *stats,
+					struct bnxt_cp_ring_info *cpr)
+{
+	struct bnxt_sw_stats *sw_stats = &cpr->sw_stats;
+	u64 *hw_stats = cpr->stats.sw_stats;
+
+	stats->rx_total_l4_csum_errors += sw_stats->rx.rx_l4_csum_errors;
+	stats->rx_total_resets += sw_stats->rx.rx_resets;
+	stats->rx_total_buf_errors += sw_stats->rx.rx_buf_errors;
+	stats->rx_total_oom_discards += sw_stats->rx.rx_oom_discards;
+	stats->rx_total_netpoll_discards += sw_stats->rx.rx_netpoll_discards;
+	stats->rx_total_ring_discards +=
+		BNXT_GET_RING_STATS64(hw_stats, rx_discard_pkts);
+	stats->tx_total_ring_discards +=
+		BNXT_GET_RING_STATS64(hw_stats, tx_discard_pkts);
+	stats->total_missed_irqs += sw_stats->cmn.missed_irqs;
+}
+
+void bnxt_get_ring_err_stats(struct bnxt *bp,
+			     struct bnxt_total_ring_err_stats *stats)
+{
+	int i;
+
+	for (i = 0; i < bp->cp_nr_rings; i++)
+		bnxt_get_one_ring_err_stats(bp, stats, &bp->bnapi[i]->cp_ring);
+}
+
 static bool bnxt_mc_list_updated(struct bnxt *bp, u32 *rx_mask)
 {
 	struct net_device *dev = bp->dev;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 1d2588c92977e..c872cf1bc8783 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -950,6 +950,17 @@ struct bnxt_sw_stats {
 	struct bnxt_cmn_sw_stats cmn;
 };
 
+struct bnxt_total_ring_err_stats {
+	u64			rx_total_l4_csum_errors;
+	u64			rx_total_resets;
+	u64			rx_total_buf_errors;
+	u64			rx_total_oom_discards;
+	u64			rx_total_netpoll_discards;
+	u64			rx_total_ring_discards;
+	u64			tx_total_ring_discards;
+	u64			total_missed_irqs;
+};
+
 struct bnxt_stats_mem {
 	u64		*sw_stats;
 	u64		*hw_masks;
@@ -2007,6 +2018,8 @@ struct bnxt {
 	u8			pri2cos_idx[8];
 	u8			pri2cos_valid;
 
+	struct bnxt_total_ring_err_stats ring_err_stats_prev;
+
 	u16			hwrm_max_req_len;
 	u16			hwrm_max_ext_req_len;
 	unsigned int		hwrm_cmd_timeout;
@@ -2331,6 +2344,8 @@ int bnxt_half_open_nic(struct bnxt *bp);
 void bnxt_half_close_nic(struct bnxt *bp);
 void bnxt_reenable_sriov(struct bnxt *bp);
 int bnxt_close_nic(struct bnxt *, bool, bool);
+void bnxt_get_ring_err_stats(struct bnxt *bp,
+			     struct bnxt_total_ring_err_stats *stats);
 int bnxt_dbg_hwrm_rd_reg(struct bnxt *bp, u32 reg_off, u16 num_words,
 			 u32 *reg_buf);
 void bnxt_fw_exception(struct bnxt *bp);
-- 
2.43.0




