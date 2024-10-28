Return-Path: <stable+bounces-88849-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D9AB9B27C5
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 07:51:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0D701C215EE
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 06:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A9618A924;
	Mon, 28 Oct 2024 06:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WO4cG4u9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B1A8837;
	Mon, 28 Oct 2024 06:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730098260; cv=none; b=GZ1wjeINdVpVDEvcmpVMln9MF/MdyMkZoorNtM8SmP/fbjdarGU7TVZNakrr1VMp2PE+myAZFgPYstTA8c/wqlh14WcCb3MmNRyJP/KJSsRT9I8klXr5b4S3yjwruSN2VRY6fuK42Yat/S4gUVfv2Plaq2o5ffhXQbVsq1bKkKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730098260; c=relaxed/simple;
	bh=frMAbJoyvu97tFgBy2xIr3sGh/LHc1VXvMoWUqo6VjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H8mVfCcxSFJ7/m4nvSbtGrYSZPmVYczyrXlFZqvShPV1/uHepDTmW3zgwhl1tSBqnBalSYOtYElOueEnJDb+8GN5fjsgSPolzEHKGR1Z/s4qfbbA5ieLK5kewoLjmvRt0//Klk8KPsgiyC0ObIXk1s9tuu+lPiPbR702h+Siuak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WO4cG4u9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CB6AC4CEC3;
	Mon, 28 Oct 2024 06:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730098260;
	bh=frMAbJoyvu97tFgBy2xIr3sGh/LHc1VXvMoWUqo6VjM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WO4cG4u9lwzAJAe1ObqAdeJjSN6ObYKhxSWTDoWj1Z/dU4+ovLk8okZ+zZ3izzwAJ
	 Lhqu9/u/p0tXucz6et1gbHqH5O93uz+GlLmJs5NbevIRuZILAp7kY88wXfoMRE90Qr
	 U80ilOoqzxsjvnoUBpHOgw0XhKY/CMxYrLEC16xg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Michael Chan <michael.chan@broadcom.com>,
	Vadim Fedorenko <vadfed@meta.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 149/261] bnxt_en: replace ptp_lock with irqsave variant
Date: Mon, 28 Oct 2024 07:24:51 +0100
Message-ID: <20241028062315.773294652@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241028062312.001273460@linuxfoundation.org>
References: <20241028062312.001273460@linuxfoundation.org>
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

From: Vadim Fedorenko <vadfed@meta.com>

[ Upstream commit 4ab3e4983bcc9d9b9dd9720253cb93f44e9e657c ]

In netpoll configuration the completion processing can happen in hard
irq context which will break with spin_lock_bh() for fullfilling RX
timestamp in case of all packets timestamping. Replace it with
spin_lock_irqsave() variant.

Fixes: 7f5515d19cd7 ("bnxt_en: Get the RX packet timestamp")
Reviewed-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
Message-ID: <20241016195234.2622004-1-vadfed@meta.com>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 22 +++---
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c | 70 +++++++++++--------
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h | 12 ++--
 3 files changed, 63 insertions(+), 41 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 04a623b3eee29..103e6aa604c33 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -2257,10 +2257,11 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 
 			if (!bnxt_get_rx_ts_p5(bp, &ts, cmpl_ts)) {
 				struct bnxt_ptp_cfg *ptp = bp->ptp_cfg;
+				unsigned long flags;
 
-				spin_lock_bh(&ptp->ptp_lock);
+				spin_lock_irqsave(&ptp->ptp_lock, flags);
 				ns = timecounter_cyc2time(&ptp->tc, ts);
-				spin_unlock_bh(&ptp->ptp_lock);
+				spin_unlock_irqrestore(&ptp->ptp_lock, flags);
 				memset(skb_hwtstamps(skb), 0,
 				       sizeof(*skb_hwtstamps(skb)));
 				skb_hwtstamps(skb)->hwtstamp = ns_to_ktime(ns);
@@ -2760,17 +2761,18 @@ static int bnxt_async_event_process(struct bnxt *bp,
 		case ASYNC_EVENT_CMPL_PHC_UPDATE_EVENT_DATA1_FLAGS_PHC_RTC_UPDATE:
 			if (BNXT_PTP_USE_RTC(bp)) {
 				struct bnxt_ptp_cfg *ptp = bp->ptp_cfg;
+				unsigned long flags;
 				u64 ns;
 
 				if (!ptp)
 					goto async_event_process_exit;
 
-				spin_lock_bh(&ptp->ptp_lock);
+				spin_lock_irqsave(&ptp->ptp_lock, flags);
 				bnxt_ptp_update_current_time(bp);
 				ns = (((u64)BNXT_EVENT_PHC_RTC_UPDATE(data1) <<
 				       BNXT_PHC_BITS) | ptp->current_time);
 				bnxt_ptp_rtc_timecounter_init(ptp, ns);
-				spin_unlock_bh(&ptp->ptp_lock);
+				spin_unlock_irqrestore(&ptp->ptp_lock, flags);
 			}
 			break;
 		}
@@ -13484,9 +13486,11 @@ static void bnxt_force_fw_reset(struct bnxt *bp)
 		return;
 
 	if (ptp) {
-		spin_lock_bh(&ptp->ptp_lock);
+		unsigned long flags;
+
+		spin_lock_irqsave(&ptp->ptp_lock, flags);
 		set_bit(BNXT_STATE_IN_FW_RESET, &bp->state);
-		spin_unlock_bh(&ptp->ptp_lock);
+		spin_unlock_irqrestore(&ptp->ptp_lock, flags);
 	} else {
 		set_bit(BNXT_STATE_IN_FW_RESET, &bp->state);
 	}
@@ -13551,9 +13555,11 @@ void bnxt_fw_reset(struct bnxt *bp)
 		int n = 0, tmo;
 
 		if (ptp) {
-			spin_lock_bh(&ptp->ptp_lock);
+			unsigned long flags;
+
+			spin_lock_irqsave(&ptp->ptp_lock, flags);
 			set_bit(BNXT_STATE_IN_FW_RESET, &bp->state);
-			spin_unlock_bh(&ptp->ptp_lock);
+			spin_unlock_irqrestore(&ptp->ptp_lock, flags);
 		} else {
 			set_bit(BNXT_STATE_IN_FW_RESET, &bp->state);
 		}
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
index 37d42423459c8..fa514be876502 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
@@ -62,13 +62,14 @@ static int bnxt_ptp_settime(struct ptp_clock_info *ptp_info,
 	struct bnxt_ptp_cfg *ptp = container_of(ptp_info, struct bnxt_ptp_cfg,
 						ptp_info);
 	u64 ns = timespec64_to_ns(ts);
+	unsigned long flags;
 
 	if (BNXT_PTP_USE_RTC(ptp->bp))
 		return bnxt_ptp_cfg_settime(ptp->bp, ns);
 
-	spin_lock_bh(&ptp->ptp_lock);
+	spin_lock_irqsave(&ptp->ptp_lock, flags);
 	timecounter_init(&ptp->tc, &ptp->cc, ns);
-	spin_unlock_bh(&ptp->ptp_lock);
+	spin_unlock_irqrestore(&ptp->ptp_lock, flags);
 	return 0;
 }
 
@@ -100,13 +101,14 @@ static int bnxt_refclk_read(struct bnxt *bp, struct ptp_system_timestamp *sts,
 static void bnxt_ptp_get_current_time(struct bnxt *bp)
 {
 	struct bnxt_ptp_cfg *ptp = bp->ptp_cfg;
+	unsigned long flags;
 
 	if (!ptp)
 		return;
-	spin_lock_bh(&ptp->ptp_lock);
+	spin_lock_irqsave(&ptp->ptp_lock, flags);
 	WRITE_ONCE(ptp->old_time, ptp->current_time);
 	bnxt_refclk_read(bp, NULL, &ptp->current_time);
-	spin_unlock_bh(&ptp->ptp_lock);
+	spin_unlock_irqrestore(&ptp->ptp_lock, flags);
 }
 
 static int bnxt_hwrm_port_ts_query(struct bnxt *bp, u32 flags, u64 *ts,
@@ -149,17 +151,18 @@ static int bnxt_ptp_gettimex(struct ptp_clock_info *ptp_info,
 {
 	struct bnxt_ptp_cfg *ptp = container_of(ptp_info, struct bnxt_ptp_cfg,
 						ptp_info);
+	unsigned long flags;
 	u64 ns, cycles;
 	int rc;
 
-	spin_lock_bh(&ptp->ptp_lock);
+	spin_lock_irqsave(&ptp->ptp_lock, flags);
 	rc = bnxt_refclk_read(ptp->bp, sts, &cycles);
 	if (rc) {
-		spin_unlock_bh(&ptp->ptp_lock);
+		spin_unlock_irqrestore(&ptp->ptp_lock, flags);
 		return rc;
 	}
 	ns = timecounter_cyc2time(&ptp->tc, cycles);
-	spin_unlock_bh(&ptp->ptp_lock);
+	spin_unlock_irqrestore(&ptp->ptp_lock, flags);
 	*ts = ns_to_timespec64(ns);
 
 	return 0;
@@ -177,6 +180,7 @@ void bnxt_ptp_update_current_time(struct bnxt *bp)
 static int bnxt_ptp_adjphc(struct bnxt_ptp_cfg *ptp, s64 delta)
 {
 	struct hwrm_port_mac_cfg_input *req;
+	unsigned long flags;
 	int rc;
 
 	rc = hwrm_req_init(ptp->bp, req, HWRM_PORT_MAC_CFG);
@@ -190,9 +194,9 @@ static int bnxt_ptp_adjphc(struct bnxt_ptp_cfg *ptp, s64 delta)
 	if (rc) {
 		netdev_err(ptp->bp->dev, "ptp adjphc failed. rc = %x\n", rc);
 	} else {
-		spin_lock_bh(&ptp->ptp_lock);
+		spin_lock_irqsave(&ptp->ptp_lock, flags);
 		bnxt_ptp_update_current_time(ptp->bp);
-		spin_unlock_bh(&ptp->ptp_lock);
+		spin_unlock_irqrestore(&ptp->ptp_lock, flags);
 	}
 
 	return rc;
@@ -202,13 +206,14 @@ static int bnxt_ptp_adjtime(struct ptp_clock_info *ptp_info, s64 delta)
 {
 	struct bnxt_ptp_cfg *ptp = container_of(ptp_info, struct bnxt_ptp_cfg,
 						ptp_info);
+	unsigned long flags;
 
 	if (BNXT_PTP_USE_RTC(ptp->bp))
 		return bnxt_ptp_adjphc(ptp, delta);
 
-	spin_lock_bh(&ptp->ptp_lock);
+	spin_lock_irqsave(&ptp->ptp_lock, flags);
 	timecounter_adjtime(&ptp->tc, delta);
-	spin_unlock_bh(&ptp->ptp_lock);
+	spin_unlock_irqrestore(&ptp->ptp_lock, flags);
 	return 0;
 }
 
@@ -236,14 +241,15 @@ static int bnxt_ptp_adjfine(struct ptp_clock_info *ptp_info, long scaled_ppm)
 	struct bnxt_ptp_cfg *ptp = container_of(ptp_info, struct bnxt_ptp_cfg,
 						ptp_info);
 	struct bnxt *bp = ptp->bp;
+	unsigned long flags;
 
 	if (!BNXT_MH(bp))
 		return bnxt_ptp_adjfine_rtc(bp, scaled_ppm);
 
-	spin_lock_bh(&ptp->ptp_lock);
+	spin_lock_irqsave(&ptp->ptp_lock, flags);
 	timecounter_read(&ptp->tc);
 	ptp->cc.mult = adjust_by_scaled_ppm(ptp->cmult, scaled_ppm);
-	spin_unlock_bh(&ptp->ptp_lock);
+	spin_unlock_irqrestore(&ptp->ptp_lock, flags);
 	return 0;
 }
 
@@ -251,12 +257,13 @@ void bnxt_ptp_pps_event(struct bnxt *bp, u32 data1, u32 data2)
 {
 	struct bnxt_ptp_cfg *ptp = bp->ptp_cfg;
 	struct ptp_clock_event event;
+	unsigned long flags;
 	u64 ns, pps_ts;
 
 	pps_ts = EVENT_PPS_TS(data2, data1);
-	spin_lock_bh(&ptp->ptp_lock);
+	spin_lock_irqsave(&ptp->ptp_lock, flags);
 	ns = timecounter_cyc2time(&ptp->tc, pps_ts);
-	spin_unlock_bh(&ptp->ptp_lock);
+	spin_unlock_irqrestore(&ptp->ptp_lock, flags);
 
 	switch (EVENT_DATA2_PPS_EVENT_TYPE(data2)) {
 	case ASYNC_EVENT_CMPL_PPS_TIMESTAMP_EVENT_DATA2_EVENT_TYPE_INTERNAL:
@@ -393,16 +400,17 @@ static int bnxt_get_target_cycles(struct bnxt_ptp_cfg *ptp, u64 target_ns,
 {
 	u64 cycles_now;
 	u64 nsec_now, nsec_delta;
+	unsigned long flags;
 	int rc;
 
-	spin_lock_bh(&ptp->ptp_lock);
+	spin_lock_irqsave(&ptp->ptp_lock, flags);
 	rc = bnxt_refclk_read(ptp->bp, NULL, &cycles_now);
 	if (rc) {
-		spin_unlock_bh(&ptp->ptp_lock);
+		spin_unlock_irqrestore(&ptp->ptp_lock, flags);
 		return rc;
 	}
 	nsec_now = timecounter_cyc2time(&ptp->tc, cycles_now);
-	spin_unlock_bh(&ptp->ptp_lock);
+	spin_unlock_irqrestore(&ptp->ptp_lock, flags);
 
 	nsec_delta = target_ns - nsec_now;
 	*cycles_delta = div64_u64(nsec_delta << ptp->cc.shift, ptp->cc.mult);
@@ -689,6 +697,7 @@ static int bnxt_stamp_tx_skb(struct bnxt *bp, int slot)
 	struct skb_shared_hwtstamps timestamp;
 	struct bnxt_ptp_tx_req *txts_req;
 	unsigned long now = jiffies;
+	unsigned long flags;
 	u64 ts = 0, ns = 0;
 	u32 tmo = 0;
 	int rc;
@@ -702,9 +711,9 @@ static int bnxt_stamp_tx_skb(struct bnxt *bp, int slot)
 				     tmo, slot);
 	if (!rc) {
 		memset(&timestamp, 0, sizeof(timestamp));
-		spin_lock_bh(&ptp->ptp_lock);
+		spin_lock_irqsave(&ptp->ptp_lock, flags);
 		ns = timecounter_cyc2time(&ptp->tc, ts);
-		spin_unlock_bh(&ptp->ptp_lock);
+		spin_unlock_irqrestore(&ptp->ptp_lock, flags);
 		timestamp.hwtstamp = ns_to_ktime(ns);
 		skb_tstamp_tx(txts_req->tx_skb, &timestamp);
 		ptp->stats.ts_pkts++;
@@ -730,6 +739,7 @@ static long bnxt_ptp_ts_aux_work(struct ptp_clock_info *ptp_info)
 	unsigned long now = jiffies;
 	struct bnxt *bp = ptp->bp;
 	u16 cons = ptp->txts_cons;
+	unsigned long flags;
 	u32 num_requests;
 	int rc = 0;
 
@@ -757,9 +767,9 @@ static long bnxt_ptp_ts_aux_work(struct ptp_clock_info *ptp_info)
 	bnxt_ptp_get_current_time(bp);
 	ptp->next_period = now + HZ;
 	if (time_after_eq(now, ptp->next_overflow_check)) {
-		spin_lock_bh(&ptp->ptp_lock);
+		spin_lock_irqsave(&ptp->ptp_lock, flags);
 		timecounter_read(&ptp->tc);
-		spin_unlock_bh(&ptp->ptp_lock);
+		spin_unlock_irqrestore(&ptp->ptp_lock, flags);
 		ptp->next_overflow_check = now + BNXT_PHC_OVERFLOW_PERIOD;
 	}
 	if (rc == -EAGAIN)
@@ -819,6 +829,7 @@ void bnxt_tx_ts_cmp(struct bnxt *bp, struct bnxt_napi *bnapi,
 	u32 opaque = tscmp->tx_ts_cmp_opaque;
 	struct bnxt_tx_ring_info *txr;
 	struct bnxt_sw_tx_bd *tx_buf;
+	unsigned long flags;
 	u64 ts, ns;
 	u16 cons;
 
@@ -833,9 +844,9 @@ void bnxt_tx_ts_cmp(struct bnxt *bp, struct bnxt_napi *bnapi,
 				   le32_to_cpu(tscmp->tx_ts_cmp_flags_type),
 				   le32_to_cpu(tscmp->tx_ts_cmp_errors_v));
 		} else {
-			spin_lock_bh(&ptp->ptp_lock);
+			spin_lock_irqsave(&ptp->ptp_lock, flags);
 			ns = timecounter_cyc2time(&ptp->tc, ts);
-			spin_unlock_bh(&ptp->ptp_lock);
+			spin_unlock_irqrestore(&ptp->ptp_lock, flags);
 			timestamp.hwtstamp = ns_to_ktime(ns);
 			skb_tstamp_tx(tx_buf->skb, &timestamp);
 		}
@@ -975,6 +986,7 @@ void bnxt_ptp_rtc_timecounter_init(struct bnxt_ptp_cfg *ptp, u64 ns)
 int bnxt_ptp_init_rtc(struct bnxt *bp, bool phc_cfg)
 {
 	struct timespec64 tsp;
+	unsigned long flags;
 	u64 ns;
 	int rc;
 
@@ -993,9 +1005,9 @@ int bnxt_ptp_init_rtc(struct bnxt *bp, bool phc_cfg)
 		if (rc)
 			return rc;
 	}
-	spin_lock_bh(&bp->ptp_cfg->ptp_lock);
+	spin_lock_irqsave(&bp->ptp_cfg->ptp_lock, flags);
 	bnxt_ptp_rtc_timecounter_init(bp->ptp_cfg, ns);
-	spin_unlock_bh(&bp->ptp_cfg->ptp_lock);
+	spin_unlock_irqrestore(&bp->ptp_cfg->ptp_lock, flags);
 
 	return 0;
 }
@@ -1063,10 +1075,12 @@ int bnxt_ptp_init(struct bnxt *bp, bool phc_cfg)
 	atomic64_set(&ptp->stats.ts_err, 0);
 
 	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS) {
-		spin_lock_bh(&ptp->ptp_lock);
+		unsigned long flags;
+
+		spin_lock_irqsave(&ptp->ptp_lock, flags);
 		bnxt_refclk_read(bp, NULL, &ptp->current_time);
 		WRITE_ONCE(ptp->old_time, ptp->current_time);
-		spin_unlock_bh(&ptp->ptp_lock);
+		spin_unlock_irqrestore(&ptp->ptp_lock, flags);
 		ptp_schedule_worker(ptp->ptp_clock, 0);
 	}
 	ptp->txts_tmo = BNXT_PTP_DFLT_TX_TMO;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h
index a9a2f9a18c9ca..f322466ecad35 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h
@@ -146,11 +146,13 @@ struct bnxt_ptp_cfg {
 };
 
 #if BITS_PER_LONG == 32
-#define BNXT_READ_TIME64(ptp, dst, src)		\
-do {						\
-	spin_lock_bh(&(ptp)->ptp_lock);		\
-	(dst) = (src);				\
-	spin_unlock_bh(&(ptp)->ptp_lock);	\
+#define BNXT_READ_TIME64(ptp, dst, src)				\
+do {								\
+	unsigned long flags;					\
+								\
+	spin_lock_irqsave(&(ptp)->ptp_lock, flags);		\
+	(dst) = (src);						\
+	spin_unlock_irqrestore(&(ptp)->ptp_lock, flags);	\
 } while (0)
 #else
 #define BNXT_READ_TIME64(ptp, dst, src)		\
-- 
2.43.0




