Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 847487612E6
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233870AbjGYLGa (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234018AbjGYLGR (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:06:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 232771999
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:04:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B76E6165C
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:04:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31456C433C8;
        Tue, 25 Jul 2023 11:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690283061;
        bh=O30ifgC80Ko/FDr+PbKQ2UKUgJKDx+imM009RG4ets8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IuJhpTlLdW+J1NTgtU9U1/3AUtRZ9KTNXLxg370/wONKuClaqAvzmVHs74H7anGQW
         DfGAatf5wY0zJrDfGoueDpZ2PhMbncnO0h8uk+0pbep21OVp2E4ijWeS1LkTVjd07R
         Dv+AGN1KVPhupMG2gvKa6/O0phyy3rd8wLf5HCzE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 123/183] iavf: make functions static where possible
Date:   Tue, 25 Jul 2023 12:45:51 +0200
Message-ID: <20230725104512.364590327@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104507.756981058@linuxfoundation.org>
References: <20230725104507.756981058@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Przemek Kitszel <przemyslaw.kitszel@intel.com>

[ Upstream commit a4aadf0f5905661cd25c366b96cc1c840f05b756 ]

Make all possible functions static.

Move iavf_force_wb() up to avoid forward declaration.

Suggested-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Stable-dep-of: c2ed2403f12c ("iavf: Wait for reset in callbacks which trigger it")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/iavf/iavf.h      | 10 -----
 drivers/net/ethernet/intel/iavf/iavf_main.c | 14 +++----
 drivers/net/ethernet/intel/iavf/iavf_txrx.c | 43 ++++++++++-----------
 drivers/net/ethernet/intel/iavf/iavf_txrx.h |  4 --
 4 files changed, 28 insertions(+), 43 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf.h b/drivers/net/ethernet/intel/iavf/iavf.h
index 6625625f91e47..a716ed6bb787d 100644
--- a/drivers/net/ethernet/intel/iavf/iavf.h
+++ b/drivers/net/ethernet/intel/iavf/iavf.h
@@ -523,9 +523,6 @@ void iavf_schedule_request_stats(struct iavf_adapter *adapter);
 void iavf_reset(struct iavf_adapter *adapter);
 void iavf_set_ethtool_ops(struct net_device *netdev);
 void iavf_update_stats(struct iavf_adapter *adapter);
-void iavf_reset_interrupt_capability(struct iavf_adapter *adapter);
-int iavf_init_interrupt_scheme(struct iavf_adapter *adapter);
-void iavf_irq_enable_queues(struct iavf_adapter *adapter);
 void iavf_free_all_tx_resources(struct iavf_adapter *adapter);
 void iavf_free_all_rx_resources(struct iavf_adapter *adapter);
 
@@ -579,17 +576,10 @@ void iavf_enable_vlan_stripping_v2(struct iavf_adapter *adapter, u16 tpid);
 void iavf_disable_vlan_stripping_v2(struct iavf_adapter *adapter, u16 tpid);
 void iavf_enable_vlan_insertion_v2(struct iavf_adapter *adapter, u16 tpid);
 void iavf_disable_vlan_insertion_v2(struct iavf_adapter *adapter, u16 tpid);
-int iavf_replace_primary_mac(struct iavf_adapter *adapter,
-			     const u8 *new_mac);
-void
-iavf_set_vlan_offload_features(struct iavf_adapter *adapter,
-			       netdev_features_t prev_features,
-			       netdev_features_t features);
 void iavf_add_fdir_filter(struct iavf_adapter *adapter);
 void iavf_del_fdir_filter(struct iavf_adapter *adapter);
 void iavf_add_adv_rss_cfg(struct iavf_adapter *adapter);
 void iavf_del_adv_rss_cfg(struct iavf_adapter *adapter);
 struct iavf_mac_filter *iavf_add_filter(struct iavf_adapter *adapter,
 					const u8 *macaddr);
-int iavf_lock_timeout(struct mutex *lock, unsigned int msecs);
 #endif /* _IAVF_H_ */
diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 68e951fe5e210..d5b1dcfe0ccdd 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -253,7 +253,7 @@ enum iavf_status iavf_free_virt_mem_d(struct iavf_hw *hw,
  *
  * Returns 0 on success, negative on failure
  **/
-int iavf_lock_timeout(struct mutex *lock, unsigned int msecs)
+static int iavf_lock_timeout(struct mutex *lock, unsigned int msecs)
 {
 	unsigned int wait, delay = 10;
 
@@ -362,7 +362,7 @@ static void iavf_irq_disable(struct iavf_adapter *adapter)
  * iavf_irq_enable_queues - Enable interrupt for all queues
  * @adapter: board private structure
  **/
-void iavf_irq_enable_queues(struct iavf_adapter *adapter)
+static void iavf_irq_enable_queues(struct iavf_adapter *adapter)
 {
 	struct iavf_hw *hw = &adapter->hw;
 	int i;
@@ -1003,8 +1003,8 @@ struct iavf_mac_filter *iavf_add_filter(struct iavf_adapter *adapter,
  *
  * Do not call this with mac_vlan_list_lock!
  **/
-int iavf_replace_primary_mac(struct iavf_adapter *adapter,
-			     const u8 *new_mac)
+static int iavf_replace_primary_mac(struct iavf_adapter *adapter,
+				    const u8 *new_mac)
 {
 	struct iavf_hw *hw = &adapter->hw;
 	struct iavf_mac_filter *f;
@@ -1860,7 +1860,7 @@ static void iavf_free_q_vectors(struct iavf_adapter *adapter)
  * @adapter: board private structure
  *
  **/
-void iavf_reset_interrupt_capability(struct iavf_adapter *adapter)
+static void iavf_reset_interrupt_capability(struct iavf_adapter *adapter)
 {
 	if (!adapter->msix_entries)
 		return;
@@ -1875,7 +1875,7 @@ void iavf_reset_interrupt_capability(struct iavf_adapter *adapter)
  * @adapter: board private structure to initialize
  *
  **/
-int iavf_init_interrupt_scheme(struct iavf_adapter *adapter)
+static int iavf_init_interrupt_scheme(struct iavf_adapter *adapter)
 {
 	int err;
 
@@ -2174,7 +2174,7 @@ static int iavf_process_aq_command(struct iavf_adapter *adapter)
  * the watchdog if any changes are requested to expedite the request via
  * virtchnl.
  **/
-void
+static void
 iavf_set_vlan_offload_features(struct iavf_adapter *adapter,
 			       netdev_features_t prev_features,
 			       netdev_features_t features)
diff --git a/drivers/net/ethernet/intel/iavf/iavf_txrx.c b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
index e989feda133c1..8c5f6096b0022 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_txrx.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
@@ -54,7 +54,7 @@ static void iavf_unmap_and_free_tx_resource(struct iavf_ring *ring,
  * iavf_clean_tx_ring - Free any empty Tx buffers
  * @tx_ring: ring to be cleaned
  **/
-void iavf_clean_tx_ring(struct iavf_ring *tx_ring)
+static void iavf_clean_tx_ring(struct iavf_ring *tx_ring)
 {
 	unsigned long bi_size;
 	u16 i;
@@ -110,7 +110,7 @@ void iavf_free_tx_resources(struct iavf_ring *tx_ring)
  * Since there is no access to the ring head register
  * in XL710, we need to use our local copies
  **/
-u32 iavf_get_tx_pending(struct iavf_ring *ring, bool in_sw)
+static u32 iavf_get_tx_pending(struct iavf_ring *ring, bool in_sw)
 {
 	u32 head, tail;
 
@@ -127,6 +127,24 @@ u32 iavf_get_tx_pending(struct iavf_ring *ring, bool in_sw)
 	return 0;
 }
 
+/**
+ * iavf_force_wb - Issue SW Interrupt so HW does a wb
+ * @vsi: the VSI we care about
+ * @q_vector: the vector on which to force writeback
+ **/
+static void iavf_force_wb(struct iavf_vsi *vsi, struct iavf_q_vector *q_vector)
+{
+	u32 val = IAVF_VFINT_DYN_CTLN1_INTENA_MASK |
+		  IAVF_VFINT_DYN_CTLN1_ITR_INDX_MASK | /* set noitr */
+		  IAVF_VFINT_DYN_CTLN1_SWINT_TRIG_MASK |
+		  IAVF_VFINT_DYN_CTLN1_SW_ITR_INDX_ENA_MASK
+		  /* allow 00 to be written to the index */;
+
+	wr32(&vsi->back->hw,
+	     IAVF_VFINT_DYN_CTLN1(q_vector->reg_idx),
+	     val);
+}
+
 /**
  * iavf_detect_recover_hung - Function to detect and recover hung_queues
  * @vsi:  pointer to vsi struct with tx queues
@@ -352,25 +370,6 @@ static void iavf_enable_wb_on_itr(struct iavf_vsi *vsi,
 	q_vector->arm_wb_state = true;
 }
 
-/**
- * iavf_force_wb - Issue SW Interrupt so HW does a wb
- * @vsi: the VSI we care about
- * @q_vector: the vector  on which to force writeback
- *
- **/
-void iavf_force_wb(struct iavf_vsi *vsi, struct iavf_q_vector *q_vector)
-{
-	u32 val = IAVF_VFINT_DYN_CTLN1_INTENA_MASK |
-		  IAVF_VFINT_DYN_CTLN1_ITR_INDX_MASK | /* set noitr */
-		  IAVF_VFINT_DYN_CTLN1_SWINT_TRIG_MASK |
-		  IAVF_VFINT_DYN_CTLN1_SW_ITR_INDX_ENA_MASK
-		  /* allow 00 to be written to the index */;
-
-	wr32(&vsi->back->hw,
-	     IAVF_VFINT_DYN_CTLN1(q_vector->reg_idx),
-	     val);
-}
-
 static inline bool iavf_container_is_rx(struct iavf_q_vector *q_vector,
 					struct iavf_ring_container *rc)
 {
@@ -687,7 +686,7 @@ int iavf_setup_tx_descriptors(struct iavf_ring *tx_ring)
  * iavf_clean_rx_ring - Free Rx buffers
  * @rx_ring: ring to be cleaned
  **/
-void iavf_clean_rx_ring(struct iavf_ring *rx_ring)
+static void iavf_clean_rx_ring(struct iavf_ring *rx_ring)
 {
 	unsigned long bi_size;
 	u16 i;
diff --git a/drivers/net/ethernet/intel/iavf/iavf_txrx.h b/drivers/net/ethernet/intel/iavf/iavf_txrx.h
index 2624bf6d009e3..7e6ee32d19b69 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_txrx.h
+++ b/drivers/net/ethernet/intel/iavf/iavf_txrx.h
@@ -442,15 +442,11 @@ static inline unsigned int iavf_rx_pg_order(struct iavf_ring *ring)
 
 bool iavf_alloc_rx_buffers(struct iavf_ring *rxr, u16 cleaned_count);
 netdev_tx_t iavf_xmit_frame(struct sk_buff *skb, struct net_device *netdev);
-void iavf_clean_tx_ring(struct iavf_ring *tx_ring);
-void iavf_clean_rx_ring(struct iavf_ring *rx_ring);
 int iavf_setup_tx_descriptors(struct iavf_ring *tx_ring);
 int iavf_setup_rx_descriptors(struct iavf_ring *rx_ring);
 void iavf_free_tx_resources(struct iavf_ring *tx_ring);
 void iavf_free_rx_resources(struct iavf_ring *rx_ring);
 int iavf_napi_poll(struct napi_struct *napi, int budget);
-void iavf_force_wb(struct iavf_vsi *vsi, struct iavf_q_vector *q_vector);
-u32 iavf_get_tx_pending(struct iavf_ring *ring, bool in_sw);
 void iavf_detect_recover_hung(struct iavf_vsi *vsi);
 int __iavf_maybe_stop_tx(struct iavf_ring *tx_ring, int size);
 bool __iavf_chk_linearize(struct sk_buff *skb);
-- 
2.39.2



