Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD3EF7554DE
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbjGPUe7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbjGPUe5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:34:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE69CBC
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:34:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 84D2360EAE
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:34:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92083C433C7;
        Sun, 16 Jul 2023 20:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689539695;
        bh=uDADShCfb9+b+QAGXXurp+fS+Ct/2m5G0eQXuoQ59Ik=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UEvb6OgVx9jSXIQ7zKEvf98HsVXjx+/e2YVTFOMhXRLFiKHApLNXrJSAPZ5Nw7oqt
         MIFpQAEGPy/6BQzEY4wCXmu+7yhs5/c5twf/23gwuWcPXIIZtoLD+DHJTDx9LIwEtj
         oWHgawMUXjCF6htVNLgbMmYnUhEKZA0Tl7tZJfCY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Karol Kolacinski <karol.kolacinski@intel.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        Arpana Arland <arpanax.arland@intel.com>
Subject: [PATCH 6.1 098/591] ice: handle extts in the miscellaneous interrupt thread
Date:   Sun, 16 Jul 2023 21:43:57 +0200
Message-ID: <20230716194926.414359921@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Karol Kolacinski <karol.kolacinski@intel.com>

[ Upstream commit 6e8b2c88fc8cf95ed09de25946b20b7536c88cd5 ]

The ice_ptp_extts_work() and ice_ptp_periodic_work() functions are both
scheduled on the same kthread worker, pf.ptp.kworker. The
ice_ptp_periodic_work() function sends to the firmware to interact with the
PHY, and must block to wait for responses.

This can cause delay in responding to the PFINT_OICR_TSYN_EVNT interrupt
cause, ultimately resulting in disruption to processing an input signal of
the frequency is high enough. In our testing, even 100 Hz signals get
disrupted.

Fix this by instead processing the signal inside the miscellaneous
interrupt thread prior to handling Tx timestamps.

Use atomic bits in a new pf->misc_thread bitmap in order to safely
communicate which tasks require processing within the
ice_misc_intr_thread_fn(). This ensures the communication of desired tasks
from the ice_misc_intr() are correctly processed without racing even in the
event that the interrupt triggers again before the thread function exits.

Fixes: 172db5f91d5f ("ice: add support for auxiliary input/output pins")
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Arpana Arland <arpanax.arland@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice.h      |  7 ++++++
 drivers/net/ethernet/intel/ice/ice_main.c | 29 ++++++++++++++++-------
 drivers/net/ethernet/intel/ice/ice_ptp.c  | 12 +++-------
 drivers/net/ethernet/intel/ice/ice_ptp.h  |  4 ++--
 4 files changed, 33 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index ca6b877fdde81..f2be383d97df5 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -491,6 +491,12 @@ enum ice_pf_flags {
 	ICE_PF_FLAGS_NBITS		/* must be last */
 };
 
+enum ice_misc_thread_tasks {
+	ICE_MISC_THREAD_EXTTS_EVENT,
+	ICE_MISC_THREAD_TX_TSTAMP,
+	ICE_MISC_THREAD_NBITS		/* must be last */
+};
+
 struct ice_switchdev_info {
 	struct ice_vsi *control_vsi;
 	struct ice_vsi *uplink_vsi;
@@ -532,6 +538,7 @@ struct ice_pf {
 	DECLARE_BITMAP(features, ICE_F_MAX);
 	DECLARE_BITMAP(state, ICE_STATE_NBITS);
 	DECLARE_BITMAP(flags, ICE_PF_FLAGS_NBITS);
+	DECLARE_BITMAP(misc_thread, ICE_MISC_THREAD_NBITS);
 	unsigned long *avail_txqs;	/* bitmap to track PF Tx queue usage */
 	unsigned long *avail_rxqs;	/* bitmap to track PF Rx queue usage */
 	unsigned long serv_tmr_period;
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 4095fe40dfc9b..7a5ec3ce3407a 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -3116,20 +3116,28 @@ static irqreturn_t ice_misc_intr(int __always_unused irq, void *data)
 
 	if (oicr & PFINT_OICR_TSYN_TX_M) {
 		ena_mask &= ~PFINT_OICR_TSYN_TX_M;
-		if (!hw->reset_ongoing)
+		if (!hw->reset_ongoing) {
+			set_bit(ICE_MISC_THREAD_TX_TSTAMP, pf->misc_thread);
 			ret = IRQ_WAKE_THREAD;
+		}
 	}
 
 	if (oicr & PFINT_OICR_TSYN_EVNT_M) {
 		u8 tmr_idx = hw->func_caps.ts_func_info.tmr_index_owned;
 		u32 gltsyn_stat = rd32(hw, GLTSYN_STAT(tmr_idx));
 
-		/* Save EVENTs from GTSYN register */
-		pf->ptp.ext_ts_irq |= gltsyn_stat & (GLTSYN_STAT_EVENT0_M |
-						     GLTSYN_STAT_EVENT1_M |
-						     GLTSYN_STAT_EVENT2_M);
 		ena_mask &= ~PFINT_OICR_TSYN_EVNT_M;
-		kthread_queue_work(pf->ptp.kworker, &pf->ptp.extts_work);
+
+		if (hw->func_caps.ts_func_info.src_tmr_owned) {
+			/* Save EVENTs from GLTSYN register */
+			pf->ptp.ext_ts_irq |= gltsyn_stat &
+					      (GLTSYN_STAT_EVENT0_M |
+					       GLTSYN_STAT_EVENT1_M |
+					       GLTSYN_STAT_EVENT2_M);
+
+			set_bit(ICE_MISC_THREAD_EXTTS_EVENT, pf->misc_thread);
+			ret = IRQ_WAKE_THREAD;
+		}
 	}
 
 #define ICE_AUX_CRIT_ERR (PFINT_OICR_PE_CRITERR_M | PFINT_OICR_HMC_ERR_M | PFINT_OICR_PE_PUSH_M)
@@ -3173,8 +3181,13 @@ static irqreturn_t ice_misc_intr_thread_fn(int __always_unused irq, void *data)
 	if (ice_is_reset_in_progress(pf->state))
 		return IRQ_HANDLED;
 
-	while (!ice_ptp_process_ts(pf))
-		usleep_range(50, 100);
+	if (test_and_clear_bit(ICE_MISC_THREAD_EXTTS_EVENT, pf->misc_thread))
+		ice_ptp_extts_event(pf);
+
+	if (test_and_clear_bit(ICE_MISC_THREAD_TX_TSTAMP, pf->misc_thread)) {
+		while (!ice_ptp_process_ts(pf))
+			usleep_range(50, 100);
+	}
 
 	return IRQ_HANDLED;
 }
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index a3585ede829bb..46b0063a5e128 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -1478,15 +1478,11 @@ static int ice_ptp_adjfine(struct ptp_clock_info *info, long scaled_ppm)
 }
 
 /**
- * ice_ptp_extts_work - Workqueue task function
- * @work: external timestamp work structure
- *
- * Service for PTP external clock event
+ * ice_ptp_extts_event - Process PTP external clock event
+ * @pf: Board private structure
  */
-static void ice_ptp_extts_work(struct kthread_work *work)
+void ice_ptp_extts_event(struct ice_pf *pf)
 {
-	struct ice_ptp *ptp = container_of(work, struct ice_ptp, extts_work);
-	struct ice_pf *pf = container_of(ptp, struct ice_pf, ptp);
 	struct ptp_clock_event event;
 	struct ice_hw *hw = &pf->hw;
 	u8 chan, tmr_idx;
@@ -2512,7 +2508,6 @@ void ice_ptp_prepare_for_reset(struct ice_pf *pf)
 	ice_ptp_cfg_timestamp(pf, false);
 
 	kthread_cancel_delayed_work_sync(&ptp->work);
-	kthread_cancel_work_sync(&ptp->extts_work);
 
 	if (test_bit(ICE_PFR_REQ, pf->state))
 		return;
@@ -2610,7 +2605,6 @@ static int ice_ptp_init_work(struct ice_pf *pf, struct ice_ptp *ptp)
 
 	/* Initialize work functions */
 	kthread_init_delayed_work(&ptp->work, ice_ptp_periodic_work);
-	kthread_init_work(&ptp->extts_work, ice_ptp_extts_work);
 
 	/* Allocate a kworker for handling work required for the ports
 	 * connected to the PTP hardware clock.
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.h b/drivers/net/ethernet/intel/ice/ice_ptp.h
index 028349295b719..e689c05bb001f 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.h
@@ -159,7 +159,6 @@ struct ice_ptp_port {
  * struct ice_ptp - data used for integrating with CONFIG_PTP_1588_CLOCK
  * @port: data for the PHY port initialization procedure
  * @work: delayed work function for periodic tasks
- * @extts_work: work function for handling external Tx timestamps
  * @cached_phc_time: a cached copy of the PHC time for timestamp extension
  * @cached_phc_jiffies: jiffies when cached_phc_time was last updated
  * @ext_ts_chan: the external timestamp channel in use
@@ -180,7 +179,6 @@ struct ice_ptp_port {
 struct ice_ptp {
 	struct ice_ptp_port port;
 	struct kthread_delayed_work work;
-	struct kthread_work extts_work;
 	u64 cached_phc_time;
 	unsigned long cached_phc_jiffies;
 	u8 ext_ts_chan;
@@ -246,6 +244,7 @@ int ice_ptp_get_ts_config(struct ice_pf *pf, struct ifreq *ifr);
 void ice_ptp_cfg_timestamp(struct ice_pf *pf, bool ena);
 int ice_get_ptp_clock_index(struct ice_pf *pf);
 
+void ice_ptp_extts_event(struct ice_pf *pf);
 s8 ice_ptp_request_ts(struct ice_ptp_tx *tx, struct sk_buff *skb);
 bool ice_ptp_process_ts(struct ice_pf *pf);
 
@@ -274,6 +273,7 @@ static inline int ice_get_ptp_clock_index(struct ice_pf *pf)
 	return -1;
 }
 
+static inline void ice_ptp_extts_event(struct ice_pf *pf) { }
 static inline s8
 ice_ptp_request_ts(struct ice_ptp_tx *tx, struct sk_buff *skb)
 {
-- 
2.39.2



