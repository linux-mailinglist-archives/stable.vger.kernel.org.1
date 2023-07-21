Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6434575CD46
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 18:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232483AbjGUQJm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 12:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232487AbjGUQJj (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 12:09:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C73335AF
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 09:09:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F9CE61D2D
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 16:09:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC293C433C9;
        Fri, 21 Jul 2023 16:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689955773;
        bh=252beilAe3JQidUIPxOip29vqbChoOkE7+8YWiCcDOc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c5u5IY1xUZ+PNjOOs3p3o/znsfC55SHJgUmQHuvbIPy/Enr8C1ynxFBoH/cQwG4pS
         lHnf+8XOAJYuM/c7BgRSF50eCNNC8RnItqanoDNW6mP4SU+pNDi+PEGL4KwRvIyo4j
         5oP1YmTx751GBDChep+49ZowAugZOO7ZjcMBEMd4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Tan Tee Min <tee.min.tan@linux.intel.com>,
        Chwee Lin Choong <chwee.lin.choong@intel.com>,
        Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>,
        Naama Meir <naamax.meir@linux.intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 025/292] igc: Fix TX Hang issue when QBV Gate is closed
Date:   Fri, 21 Jul 2023 18:02:14 +0200
Message-ID: <20230721160529.882522658@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160528.800311148@linuxfoundation.org>
References: <20230721160528.800311148@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>

[ Upstream commit 175c241288c09f81eb7b44d65c1ef6045efa4d1a ]

If a user schedules a Gate Control List (GCL) to close one of
the QBV gates while also transmitting a packet to that closed gate,
TX Hang will be happen. HW would not drop any packet when the gate
is closed and keep queuing up in HW TX FIFO until the gate is re-opened.
This patch implements the solution to drop the packet for the closed
gate.

This patch will also reset the adapter to perform SW initialization
for each 1st Gate Control List (GCL) to avoid hang.
This is due to the HW design, where changing to TSN transmit mode
requires SW initialization. Intel Discrete I225/6 transmit mode
cannot be changed when in dynamic mode according to Software User
Manual Section 7.5.2.1. Subsequent Gate Control List (GCL) operations
will proceed without a reset, as they already are in TSN Mode.

Step to reproduce:

DUT:
1) Configure GCL List with certain gate close.

BASE=$(date +%s%N)
tc qdisc replace dev $IFACE parent root handle 100 taprio \
    num_tc 4 \
    map 0 1 2 3 3 3 3 3 3 3 3 3 3 3 3 3 \
    queues 1@0 1@1 1@2 1@3 \
    base-time $BASE \
    sched-entry S 0x8 500000 \
    sched-entry S 0x4 500000 \
    flags 0x2

2) Transmit the packet to closed gate. You may use udp_tai
application to transmit UDP packet to any of the closed gate.

./udp_tai -i <interface> -P 100000 -p 90 -c 1 -t <0/1> -u 30004

Fixes: ec50a9d437f0 ("igc: Add support for taprio offloading")
Co-developed-by: Tan Tee Min <tee.min.tan@linux.intel.com>
Signed-off-by: Tan Tee Min <tee.min.tan@linux.intel.com>
Tested-by: Chwee Lin Choong <chwee.lin.choong@intel.com>
Signed-off-by: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
Tested-by: Naama Meir <naamax.meir@linux.intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/igc/igc.h      |  6 +++
 drivers/net/ethernet/intel/igc/igc_main.c | 58 +++++++++++++++++++++--
 drivers/net/ethernet/intel/igc/igc_tsn.c  | 41 ++++++++++------
 3 files changed, 87 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
index f09c6a65e3ab8..c0a07af36cb23 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -14,6 +14,7 @@
 #include <linux/timecounter.h>
 #include <linux/net_tstamp.h>
 #include <linux/bitfield.h>
+#include <linux/hrtimer.h>
 
 #include "igc_hw.h"
 
@@ -101,6 +102,8 @@ struct igc_ring {
 	u32 start_time;
 	u32 end_time;
 	u32 max_sdu;
+	bool oper_gate_closed;		/* Operating gate. True if the TX Queue is closed */
+	bool admin_gate_closed;		/* Future gate. True if the TX Queue will be closed */
 
 	/* CBS parameters */
 	bool cbs_enable;                /* indicates if CBS is enabled */
@@ -160,6 +163,7 @@ struct igc_adapter {
 	struct timer_list watchdog_timer;
 	struct timer_list dma_err_timer;
 	struct timer_list phy_info_timer;
+	struct hrtimer hrtimer;
 
 	u32 wol;
 	u32 en_mng_pt;
@@ -189,6 +193,8 @@ struct igc_adapter {
 	ktime_t cycle_time;
 	bool qbv_enable;
 	u32 qbv_config_change_errors;
+	bool qbv_transition;
+	unsigned int qbv_count;
 
 	/* OS defined structs */
 	struct pci_dev *pdev;
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index c0e21701e7817..826556e609800 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -1572,6 +1572,9 @@ static netdev_tx_t igc_xmit_frame_ring(struct sk_buff *skb,
 	first->bytecount = skb->len;
 	first->gso_segs = 1;
 
+	if (adapter->qbv_transition || tx_ring->oper_gate_closed)
+		goto out_drop;
+
 	if (tx_ring->max_sdu > 0) {
 		u32 max_sdu = 0;
 
@@ -3004,8 +3007,8 @@ static bool igc_clean_tx_irq(struct igc_q_vector *q_vector, int napi_budget)
 		    time_after(jiffies, tx_buffer->time_stamp +
 		    (adapter->tx_timeout_factor * HZ)) &&
 		    !(rd32(IGC_STATUS) & IGC_STATUS_TXOFF) &&
-		    (rd32(IGC_TDH(tx_ring->reg_idx)) !=
-		     readl(tx_ring->tail))) {
+		    (rd32(IGC_TDH(tx_ring->reg_idx)) != readl(tx_ring->tail)) &&
+		    !tx_ring->oper_gate_closed) {
 			/* detected Tx unit hang */
 			netdev_err(tx_ring->netdev,
 				   "Detected Tx Unit Hang\n"
@@ -6095,6 +6098,8 @@ static int igc_tsn_clear_schedule(struct igc_adapter *adapter)
 	adapter->base_time = 0;
 	adapter->cycle_time = NSEC_PER_SEC;
 	adapter->qbv_config_change_errors = 0;
+	adapter->qbv_transition = false;
+	adapter->qbv_count = 0;
 
 	for (i = 0; i < adapter->num_tx_queues; i++) {
 		struct igc_ring *ring = adapter->tx_ring[i];
@@ -6102,6 +6107,8 @@ static int igc_tsn_clear_schedule(struct igc_adapter *adapter)
 		ring->start_time = 0;
 		ring->end_time = NSEC_PER_SEC;
 		ring->max_sdu = 0;
+		ring->oper_gate_closed = false;
+		ring->admin_gate_closed = false;
 	}
 
 	return 0;
@@ -6113,6 +6120,7 @@ static int igc_save_qbv_schedule(struct igc_adapter *adapter,
 	bool queue_configured[IGC_MAX_TX_QUEUES] = { };
 	struct igc_hw *hw = &adapter->hw;
 	u32 start_time = 0, end_time = 0;
+	struct timespec64 now;
 	size_t n;
 	int i;
 
@@ -6133,6 +6141,8 @@ static int igc_save_qbv_schedule(struct igc_adapter *adapter,
 	adapter->cycle_time = qopt->cycle_time;
 	adapter->base_time = qopt->base_time;
 
+	igc_ptp_read(adapter, &now);
+
 	for (n = 0; n < qopt->num_entries; n++) {
 		struct tc_taprio_sched_entry *e = &qopt->entries[n];
 
@@ -6167,7 +6177,10 @@ static int igc_save_qbv_schedule(struct igc_adapter *adapter,
 				ring->start_time = start_time;
 			ring->end_time = end_time;
 
-			queue_configured[i] = true;
+			if (ring->start_time >= adapter->cycle_time)
+				queue_configured[i] = false;
+			else
+				queue_configured[i] = true;
 		}
 
 		start_time += e->interval;
@@ -6177,8 +6190,20 @@ static int igc_save_qbv_schedule(struct igc_adapter *adapter,
 	 * If not, set the start and end time to be end time.
 	 */
 	for (i = 0; i < adapter->num_tx_queues; i++) {
+		struct igc_ring *ring = adapter->tx_ring[i];
+
+		if (!is_base_time_past(qopt->base_time, &now)) {
+			ring->admin_gate_closed = false;
+		} else {
+			ring->oper_gate_closed = false;
+			ring->admin_gate_closed = false;
+		}
+
 		if (!queue_configured[i]) {
-			struct igc_ring *ring = adapter->tx_ring[i];
+			if (!is_base_time_past(qopt->base_time, &now))
+				ring->admin_gate_closed = true;
+			else
+				ring->oper_gate_closed = true;
 
 			ring->start_time = end_time;
 			ring->end_time = end_time;
@@ -6542,6 +6567,27 @@ static const struct xdp_metadata_ops igc_xdp_metadata_ops = {
 	.xmo_rx_hash			= igc_xdp_rx_hash,
 };
 
+static enum hrtimer_restart igc_qbv_scheduling_timer(struct hrtimer *timer)
+{
+	struct igc_adapter *adapter = container_of(timer, struct igc_adapter,
+						   hrtimer);
+	unsigned int i;
+
+	adapter->qbv_transition = true;
+	for (i = 0; i < adapter->num_tx_queues; i++) {
+		struct igc_ring *tx_ring = adapter->tx_ring[i];
+
+		if (tx_ring->admin_gate_closed) {
+			tx_ring->admin_gate_closed = false;
+			tx_ring->oper_gate_closed = true;
+		} else {
+			tx_ring->oper_gate_closed = false;
+		}
+	}
+	adapter->qbv_transition = false;
+	return HRTIMER_NORESTART;
+}
+
 /**
  * igc_probe - Device Initialization Routine
  * @pdev: PCI device information struct
@@ -6720,6 +6766,9 @@ static int igc_probe(struct pci_dev *pdev,
 	INIT_WORK(&adapter->reset_task, igc_reset_task);
 	INIT_WORK(&adapter->watchdog_task, igc_watchdog_task);
 
+	hrtimer_init(&adapter->hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	adapter->hrtimer.function = &igc_qbv_scheduling_timer;
+
 	/* Initialize link properties that are user-changeable */
 	adapter->fc_autoneg = true;
 	hw->mac.autoneg = true;
@@ -6823,6 +6872,7 @@ static void igc_remove(struct pci_dev *pdev)
 
 	cancel_work_sync(&adapter->reset_task);
 	cancel_work_sync(&adapter->watchdog_task);
+	hrtimer_cancel(&adapter->hrtimer);
 
 	/* Release control of h/w to f/w.  If f/w is AMT enabled, this
 	 * would have already happened in close and is redundant.
diff --git a/drivers/net/ethernet/intel/igc/igc_tsn.c b/drivers/net/ethernet/intel/igc/igc_tsn.c
index 6b299b83e7ef2..3cdb0c9887283 100644
--- a/drivers/net/ethernet/intel/igc/igc_tsn.c
+++ b/drivers/net/ethernet/intel/igc/igc_tsn.c
@@ -114,7 +114,6 @@ static int igc_tsn_disable_offload(struct igc_adapter *adapter)
 static int igc_tsn_enable_offload(struct igc_adapter *adapter)
 {
 	struct igc_hw *hw = &adapter->hw;
-	bool tsn_mode_reconfig = false;
 	u32 tqavctrl, baset_l, baset_h;
 	u32 sec, nsec, cycle;
 	ktime_t base_time, systim;
@@ -228,11 +227,10 @@ static int igc_tsn_enable_offload(struct igc_adapter *adapter)
 
 	tqavctrl = rd32(IGC_TQAVCTRL) & ~IGC_TQAVCTRL_FUTSCDDIS;
 
-	if (tqavctrl & IGC_TQAVCTRL_TRANSMIT_MODE_TSN)
-		tsn_mode_reconfig = true;
-
 	tqavctrl |= IGC_TQAVCTRL_TRANSMIT_MODE_TSN | IGC_TQAVCTRL_ENHANCED_QAV;
 
+	adapter->qbv_count++;
+
 	cycle = adapter->cycle_time;
 	base_time = adapter->base_time;
 
@@ -250,17 +248,28 @@ static int igc_tsn_enable_offload(struct igc_adapter *adapter)
 		 */
 		if ((rd32(IGC_BASET_H) || rd32(IGC_BASET_L)) &&
 		    (adapter->tc_setup_type == TC_SETUP_QDISC_TAPRIO) &&
-		    tsn_mode_reconfig)
+		    (adapter->qbv_count > 1))
 			adapter->qbv_config_change_errors++;
 	} else {
-		/* According to datasheet section 7.5.2.9.3.3, FutScdDis bit
-		 * has to be configured before the cycle time and base time.
-		 * Tx won't hang if there is a GCL is already running,
-		 * so in this case we don't need to set FutScdDis.
-		 */
-		if (igc_is_device_id_i226(hw) &&
-		    !(rd32(IGC_BASET_H) || rd32(IGC_BASET_L)))
-			tqavctrl |= IGC_TQAVCTRL_FUTSCDDIS;
+		if (igc_is_device_id_i226(hw)) {
+			ktime_t adjust_time, expires_time;
+
+		       /* According to datasheet section 7.5.2.9.3.3, FutScdDis bit
+			* has to be configured before the cycle time and base time.
+			* Tx won't hang if a GCL is already running,
+			* so in this case we don't need to set FutScdDis.
+			*/
+			if (!(rd32(IGC_BASET_H) || rd32(IGC_BASET_L)))
+				tqavctrl |= IGC_TQAVCTRL_FUTSCDDIS;
+
+			nsec = rd32(IGC_SYSTIML);
+			sec = rd32(IGC_SYSTIMH);
+			systim = ktime_set(sec, nsec);
+
+			adjust_time = adapter->base_time;
+			expires_time = ktime_sub_ns(adjust_time, systim);
+			hrtimer_start(&adapter->hrtimer, expires_time, HRTIMER_MODE_REL);
+		}
 	}
 
 	wr32(IGC_TQAVCTRL, tqavctrl);
@@ -306,7 +315,11 @@ int igc_tsn_offload_apply(struct igc_adapter *adapter)
 {
 	struct igc_hw *hw = &adapter->hw;
 
-	if (netif_running(adapter->netdev) && igc_is_device_id_i225(hw)) {
+	/* Per I225/6 HW Design Section 7.5.2.1, transmit mode
+	 * cannot be changed dynamically. Require reset the adapter.
+	 */
+	if (netif_running(adapter->netdev) &&
+	    (igc_is_device_id_i225(hw) || !adapter->qbv_count)) {
 		schedule_work(&adapter->reset_task);
 		return 0;
 	}
-- 
2.39.2



