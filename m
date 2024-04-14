Return-Path: <stable+bounces-37731-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7DA089C625
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 16:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E793285962
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 14:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 114EF80022;
	Mon,  8 Apr 2024 14:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HPd6Wexj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A3569E1C;
	Mon,  8 Apr 2024 14:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712585095; cv=none; b=t0779WJzSu0DN8Kh0L/NIKVpc+8ydC9Ljz5cQi1mbgMohUr5UBOqdhSN11fzPnss4acJhd4fKNEubWzmAgC5RnKdpU0wis1Gw/1LY3n1u6LglxSUMDcL7mYT4zDTb9ufjZs+2aXmm1GDolH0VQhivPy5iUcG20B9ykziBnWcCCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712585095; c=relaxed/simple;
	bh=cOV4J436OzbBNmrIQ8pkc8bK1MqkviTtNH7jTLyfEI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b/jz56gN1Lx7Ja3h0rAr9FsVPvALisi8N8n5n9V+SZvjLh9pGjL5mRgFGv0/p0KsNEH8VA10hjDIe8VeWVryYvElfAUPwKCgbkazgopB7uWn5fSo3xm3xeg4mb80Mg6oV1B3S9UkrBexb3g7ZQjnp1zzLI5lISB+7zG5XJK/Zu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HPd6Wexj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48F01C433F1;
	Mon,  8 Apr 2024 14:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712585095;
	bh=cOV4J436OzbBNmrIQ8pkc8bK1MqkviTtNH7jTLyfEI8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HPd6WexjM5lINq4uXrbEnUSihOjvfgPc1kJYQqXOdj702FF6WJQpeQNhqLvPAEDXJ
	 bsHPNM/rGphJMmRxFVYRYP4feeWNm2FtJFjYqne0LCQahQf5facMy/6kaW6jegcn0/
	 gMNnp5vLU9u5xdKTPWlRHjoy9nD5CDrqxeHamQvo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hugo Ferreira <hferreir@redhat.com>,
	Michal Schmidt <mschmidt@redhat.com>,
	Ivan Vecera <ivecera@redhat.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH 5.15 662/690] i40e: Enforce software interrupt during busy-poll exit
Date: Mon,  8 Apr 2024 14:58:48 +0200
Message-ID: <20240408125423.666801200@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408125359.506372836@linuxfoundation.org>
References: <20240408125359.506372836@linuxfoundation.org>
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

From: Ivan Vecera <ivecera@redhat.com>

[ Upstream commit ea558de7238bb12c3435c47f0631e9d17bf4a09f ]

As for ice bug fixed by commit b7306b42beaf ("ice: manage interrupts
during poll exit") followed by commit 23be7075b318 ("ice: fix software
generating extra interrupts") I'm seeing the similar issue also with
i40e driver.

In certain situation when busy-loop is enabled together with adaptive
coalescing, the driver occasionally misses that there are outstanding
descriptors to clean when exiting busy poll.

Try to catch the remaining work by triggering a software interrupt
when exiting busy poll. No extra interrupts will be generated when
busy polling is not used.

The issue was found when running sockperf ping-pong tcp test with
adaptive coalescing and busy poll enabled (50 as value busy_pool
and busy_read sysctl knobs) and results in huge latency spikes
with more than 100000us.

The fix is inspired from the ice driver and do the following:
1) During napi poll exit in case of busy-poll (napo_complete_done()
   returns false) this is recorded to q_vector that we were in busy
   loop.
2) Extends i40e_buildreg_itr() to be able to add an enforced software
   interrupt into built value
2) In i40e_update_enable_itr() enforces a software interrupt trigger
   if we are exiting busy poll to catch any pending clean-ups
3) Reuses unused 3rd ITR (interrupt throttle) index and set it to
   20K interrupts per second to limit the number of these sw interrupts.

Test results
============
Prior:
[root@dell-per640-07 net]# sockperf ping-pong -i 10.9.9.1 --tcp -m 1000 --mps=max -t 120
sockperf: == version #3.10-no.git ==
sockperf[CLIENT] send on:sockperf: using recvfrom() to block on socket(s)

[ 0] IP = 10.9.9.1        PORT = 11111 # TCP
sockperf: Warmup stage (sending a few dummy messages)...
sockperf: Starting test...
sockperf: Test end (interrupted by timer)
sockperf: Test ended
sockperf: [Total Run] RunTime=119.999 sec; Warm up time=400 msec; SentMessages=2438563; ReceivedMessages=2438562
sockperf: ========= Printing statistics for Server No: 0
sockperf: [Valid Duration] RunTime=119.549 sec; SentMessages=2429473; ReceivedMessages=2429473
sockperf: ====> avg-latency=24.571 (std-dev=93.297, mean-ad=4.904, median-ad=1.510, siqr=1.063, cv=3.797, std-error=0.060, 99.0% ci=[24.417, 24.725])
sockperf: # dropped messages = 0; # duplicated messages = 0; # out-of-order messages = 0
sockperf: Summary: Latency is 24.571 usec
sockperf: Total 2429473 observations; each percentile contains 24294.73 observations
sockperf: ---> <MAX> observation = 103294.331
sockperf: ---> percentile 99.999 =   45.633
sockperf: ---> percentile 99.990 =   37.013
sockperf: ---> percentile 99.900 =   35.910
sockperf: ---> percentile 99.000 =   33.390
sockperf: ---> percentile 90.000 =   28.626
sockperf: ---> percentile 75.000 =   27.741
sockperf: ---> percentile 50.000 =   26.743
sockperf: ---> percentile 25.000 =   25.614
sockperf: ---> <MIN> observation =   12.220

After:
[root@dell-per640-07 net]# sockperf ping-pong -i 10.9.9.1 --tcp -m 1000 --mps=max -t 120
sockperf: == version #3.10-no.git ==
sockperf[CLIENT] send on:sockperf: using recvfrom() to block on socket(s)

[ 0] IP = 10.9.9.1        PORT = 11111 # TCP
sockperf: Warmup stage (sending a few dummy messages)...
sockperf: Starting test...
sockperf: Test end (interrupted by timer)
sockperf: Test ended
sockperf: [Total Run] RunTime=119.999 sec; Warm up time=400 msec; SentMessages=2400055; ReceivedMessages=2400054
sockperf: ========= Printing statistics for Server No: 0
sockperf: [Valid Duration] RunTime=119.549 sec; SentMessages=2391186; ReceivedMessages=2391186
sockperf: ====> avg-latency=24.965 (std-dev=5.934, mean-ad=4.642, median-ad=1.485, siqr=1.067, cv=0.238, std-error=0.004, 99.0% ci=[24.955, 24.975])
sockperf: # dropped messages = 0; # duplicated messages = 0; # out-of-order messages = 0
sockperf: Summary: Latency is 24.965 usec
sockperf: Total 2391186 observations; each percentile contains 23911.86 observations
sockperf: ---> <MAX> observation =  195.841
sockperf: ---> percentile 99.999 =   45.026
sockperf: ---> percentile 99.990 =   39.009
sockperf: ---> percentile 99.900 =   35.922
sockperf: ---> percentile 99.000 =   33.482
sockperf: ---> percentile 90.000 =   28.902
sockperf: ---> percentile 75.000 =   27.821
sockperf: ---> percentile 50.000 =   26.860
sockperf: ---> percentile 25.000 =   25.685
sockperf: ---> <MIN> observation =   12.277

Fixes: 0bcd952feec7 ("ethernet/intel: consolidate NAPI and NAPI exit")
Reported-by: Hugo Ferreira <hferreir@redhat.com>
Reviewed-by: Michal Schmidt <mschmidt@redhat.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/i40e/i40e.h        |  1 +
 drivers/net/ethernet/intel/i40e/i40e_main.c   |  6 ++
 .../net/ethernet/intel/i40e/i40e_register.h   |  3 +
 drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 82 ++++++++++++++-----
 drivers/net/ethernet/intel/i40e/i40e_txrx.h   |  1 +
 5 files changed, 72 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 1580f9c2a3209..a05103e2fb522 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -973,6 +973,7 @@ struct i40e_q_vector {
 	struct rcu_head rcu;	/* to avoid race with update stats on free */
 	char name[I40E_INT_NAME_STR_LEN];
 	bool arm_wb_state;
+	bool in_busy_poll;
 	int irq_num;		/* IRQ assigned to this q_vector */
 } ____cacheline_internodealigned_in_smp;
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index d204c33409c68..676ea7d4192f7 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -3871,6 +3871,12 @@ static void i40e_vsi_configure_msix(struct i40e_vsi *vsi)
 		     q_vector->tx.target_itr >> 1);
 		q_vector->tx.current_itr = q_vector->tx.target_itr;
 
+		/* Set ITR for software interrupts triggered after exiting
+		 * busy-loop polling.
+		 */
+		wr32(hw, I40E_PFINT_ITRN(I40E_SW_ITR, vector - 1),
+		     I40E_ITR_20K);
+
 		wr32(hw, I40E_PFINT_RATEN(vector - 1),
 		     i40e_intrl_usec_to_reg(vsi->int_rate_limit));
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_register.h b/drivers/net/ethernet/intel/i40e/i40e_register.h
index 7339003aa17cd..694cb3e45c1ec 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_register.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_register.h
@@ -328,8 +328,11 @@
 #define I40E_PFINT_DYN_CTLN_ITR_INDX_SHIFT 3
 #define I40E_PFINT_DYN_CTLN_ITR_INDX_MASK I40E_MASK(0x3, I40E_PFINT_DYN_CTLN_ITR_INDX_SHIFT)
 #define I40E_PFINT_DYN_CTLN_INTERVAL_SHIFT 5
+#define I40E_PFINT_DYN_CTLN_INTERVAL_MASK I40E_MASK(0xFFF, I40E_PFINT_DYN_CTLN_INTERVAL_SHIFT)
 #define I40E_PFINT_DYN_CTLN_SW_ITR_INDX_ENA_SHIFT 24
 #define I40E_PFINT_DYN_CTLN_SW_ITR_INDX_ENA_MASK I40E_MASK(0x1, I40E_PFINT_DYN_CTLN_SW_ITR_INDX_ENA_SHIFT)
+#define I40E_PFINT_DYN_CTLN_SW_ITR_INDX_SHIFT 25
+#define I40E_PFINT_DYN_CTLN_SW_ITR_INDX_MASK I40E_MASK(0x3, I40E_PFINT_DYN_CTLN_SW_ITR_INDX_SHIFT)
 #define I40E_PFINT_ICR0 0x00038780 /* Reset: CORER */
 #define I40E_PFINT_ICR0_INTEVENT_SHIFT 0
 #define I40E_PFINT_ICR0_INTEVENT_MASK I40E_MASK(0x1, I40E_PFINT_ICR0_INTEVENT_SHIFT)
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index cf8c3d480a4a7..e2737875e3795 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -2560,7 +2560,22 @@ static int i40e_clean_rx_irq(struct i40e_ring *rx_ring, int budget)
 	return failure ? budget : (int)total_rx_packets;
 }
 
-static inline u32 i40e_buildreg_itr(const int type, u16 itr)
+/**
+ * i40e_buildreg_itr - build a value for writing to I40E_PFINT_DYN_CTLN register
+ * @itr_idx: interrupt throttling index
+ * @interval: interrupt throttling interval value in usecs
+ * @force_swint: force software interrupt
+ *
+ * The function builds a value for I40E_PFINT_DYN_CTLN register that
+ * is used to update interrupt throttling interval for specified ITR index
+ * and optionally enforces a software interrupt. If the @itr_idx is equal
+ * to I40E_ITR_NONE then no interval change is applied and only @force_swint
+ * parameter is taken into account. If the interval change and enforced
+ * software interrupt are not requested then the built value just enables
+ * appropriate vector interrupt.
+ **/
+static u32 i40e_buildreg_itr(enum i40e_dyn_idx itr_idx, u16 interval,
+			     bool force_swint)
 {
 	u32 val;
 
@@ -2574,23 +2589,33 @@ static inline u32 i40e_buildreg_itr(const int type, u16 itr)
 	 * an event in the PBA anyway so we need to rely on the automask
 	 * to hold pending events for us until the interrupt is re-enabled
 	 *
-	 * The itr value is reported in microseconds, and the register
-	 * value is recorded in 2 microsecond units. For this reason we
-	 * only need to shift by the interval shift - 1 instead of the
-	 * full value.
+	 * We have to shift the given value as it is reported in microseconds
+	 * and the register value is recorded in 2 microsecond units.
 	 */
-	itr &= I40E_ITR_MASK;
+	interval >>= 1;
 
+	/* 1. Enable vector interrupt
+	 * 2. Update the interval for the specified ITR index
+	 *    (I40E_ITR_NONE in the register is used to indicate that
+	 *     no interval update is requested)
+	 */
 	val = I40E_PFINT_DYN_CTLN_INTENA_MASK |
-	      (type << I40E_PFINT_DYN_CTLN_ITR_INDX_SHIFT) |
-	      (itr << (I40E_PFINT_DYN_CTLN_INTERVAL_SHIFT - 1));
+	      FIELD_PREP(I40E_PFINT_DYN_CTLN_ITR_INDX_MASK, itr_idx) |
+	      FIELD_PREP(I40E_PFINT_DYN_CTLN_INTERVAL_MASK, interval);
+
+	/* 3. Enforce software interrupt trigger if requested
+	 *    (These software interrupts rate is limited by ITR2 that is
+	 *     set to 20K interrupts per second)
+	 */
+	if (force_swint)
+		val |= I40E_PFINT_DYN_CTLN_SWINT_TRIG_MASK |
+		       I40E_PFINT_DYN_CTLN_SW_ITR_INDX_ENA_MASK |
+		       FIELD_PREP(I40E_PFINT_DYN_CTLN_SW_ITR_INDX_MASK,
+				  I40E_SW_ITR);
 
 	return val;
 }
 
-/* a small macro to shorten up some long lines */
-#define INTREG I40E_PFINT_DYN_CTLN
-
 /* The act of updating the ITR will cause it to immediately trigger. In order
  * to prevent this from throwing off adaptive update statistics we defer the
  * update so that it can only happen so often. So after either Tx or Rx are
@@ -2609,8 +2634,10 @@ static inline u32 i40e_buildreg_itr(const int type, u16 itr)
 static inline void i40e_update_enable_itr(struct i40e_vsi *vsi,
 					  struct i40e_q_vector *q_vector)
 {
+	enum i40e_dyn_idx itr_idx = I40E_ITR_NONE;
 	struct i40e_hw *hw = &vsi->back->hw;
-	u32 intval;
+	u16 interval = 0;
+	u32 itr_val;
 
 	/* If we don't have MSIX, then we only need to re-enable icr0 */
 	if (!(vsi->back->flags & I40E_FLAG_MSIX_ENABLED)) {
@@ -2632,8 +2659,8 @@ static inline void i40e_update_enable_itr(struct i40e_vsi *vsi,
 	 */
 	if (q_vector->rx.target_itr < q_vector->rx.current_itr) {
 		/* Rx ITR needs to be reduced, this is highest priority */
-		intval = i40e_buildreg_itr(I40E_RX_ITR,
-					   q_vector->rx.target_itr);
+		itr_idx = I40E_RX_ITR;
+		interval = q_vector->rx.target_itr;
 		q_vector->rx.current_itr = q_vector->rx.target_itr;
 		q_vector->itr_countdown = ITR_COUNTDOWN_START;
 	} else if ((q_vector->tx.target_itr < q_vector->tx.current_itr) ||
@@ -2642,25 +2669,36 @@ static inline void i40e_update_enable_itr(struct i40e_vsi *vsi,
 		/* Tx ITR needs to be reduced, this is second priority
 		 * Tx ITR needs to be increased more than Rx, fourth priority
 		 */
-		intval = i40e_buildreg_itr(I40E_TX_ITR,
-					   q_vector->tx.target_itr);
+		itr_idx = I40E_TX_ITR;
+		interval = q_vector->tx.target_itr;
 		q_vector->tx.current_itr = q_vector->tx.target_itr;
 		q_vector->itr_countdown = ITR_COUNTDOWN_START;
 	} else if (q_vector->rx.current_itr != q_vector->rx.target_itr) {
 		/* Rx ITR needs to be increased, third priority */
-		intval = i40e_buildreg_itr(I40E_RX_ITR,
-					   q_vector->rx.target_itr);
+		itr_idx = I40E_RX_ITR;
+		interval = q_vector->rx.target_itr;
 		q_vector->rx.current_itr = q_vector->rx.target_itr;
 		q_vector->itr_countdown = ITR_COUNTDOWN_START;
 	} else {
 		/* No ITR update, lowest priority */
-		intval = i40e_buildreg_itr(I40E_ITR_NONE, 0);
 		if (q_vector->itr_countdown)
 			q_vector->itr_countdown--;
 	}
 
-	if (!test_bit(__I40E_VSI_DOWN, vsi->state))
-		wr32(hw, INTREG(q_vector->reg_idx), intval);
+	/* Do not update interrupt control register if VSI is down */
+	if (test_bit(__I40E_VSI_DOWN, vsi->state))
+		return;
+
+	/* Update ITR interval if necessary and enforce software interrupt
+	 * if we are exiting busy poll.
+	 */
+	if (q_vector->in_busy_poll) {
+		itr_val = i40e_buildreg_itr(itr_idx, interval, true);
+		q_vector->in_busy_poll = false;
+	} else {
+		itr_val = i40e_buildreg_itr(itr_idx, interval, false);
+	}
+	wr32(hw, I40E_PFINT_DYN_CTLN(q_vector->reg_idx), itr_val);
 }
 
 /**
@@ -2767,6 +2805,8 @@ int i40e_napi_poll(struct napi_struct *napi, int budget)
 	 */
 	if (likely(napi_complete_done(napi, work_done)))
 		i40e_update_enable_itr(vsi, q_vector);
+	else
+		q_vector->in_busy_poll = true;
 
 	return min(work_done, budget - 1);
 }
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.h b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
index a4f38ab0ecca9..054b7d1632e16 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
@@ -67,6 +67,7 @@ enum i40e_dyn_idx {
 /* these are indexes into ITRN registers */
 #define I40E_RX_ITR    I40E_IDX_ITR0
 #define I40E_TX_ITR    I40E_IDX_ITR1
+#define I40E_SW_ITR    I40E_IDX_ITR2
 
 /* Supported RSS offloads */
 #define I40E_DEFAULT_RSS_HENA ( \
-- 
2.43.0




