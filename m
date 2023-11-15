Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 144047ECBB1
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232535AbjKOTXx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:23:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232665AbjKOTXw (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:23:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 524481A3
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:23:48 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0016C433C8;
        Wed, 15 Nov 2023 19:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076227;
        bh=DsABJLwT+FGLyxGn1rNL2xSTOeWlwa099jLx6z6S1Eg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wmkRrIT0iY5F7S7woLYCvZrU++XFC1u5Juz3ZSvtEonwlxbzTk/QbHVDwKdg7xEzp
         hoo+2Ww+saOmLLIlaZLKWzDMqbwexVnkAzINKDDj+Kwd8eVINa+X5YzPZ7vK2GNaHF
         c7KqO4XO9pAdIGcTAht5Al62VmqywybNZFBh2544=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 139/550] wifi: iwlwifi: empty overflow queue during flush
Date:   Wed, 15 Nov 2023 14:12:03 -0500
Message-ID: <20231115191610.320175165@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
References: <20231115191600.708733204@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

[ Upstream commit 658939fc68d3241f9a0019e224cd7154438c23f2 ]

If a TX queue has no space for new TX frames, the driver will keep
these frames in the overflow queue, and during reclaim flow it
will retry to send the frames from that queue.
But if the reclaim flow was invoked from TX queue flush, we will also
TX these frames, which is wrong as we don't want to TX anything
after flush.
This might also cause assert 0x125F when removing the queue,
saying that the driver removes a non-empty queue
Fix this by TXing the overflow queue's frames only if we are
not in flush queue flow.

Fixes: a44509805895 ("iwlwifi: move reclaim flows to the queue file")
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Link: https://lore.kernel.org/r/20231022173519.caf06c8709d9.Ibf664ccb3f952e836f8fa461ea58fc08e5c46e88@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/dvm/tx.c    | 5 +++--
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h | 7 ++++---
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c    | 4 ++--
 drivers/net/wireless/intel/iwlwifi/queue/tx.c  | 9 +++++----
 drivers/net/wireless/intel/iwlwifi/queue/tx.h  | 2 +-
 5 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/tx.c b/drivers/net/wireless/intel/iwlwifi/dvm/tx.c
index 60a7b61d59aa3..ca1daec641c4f 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/tx.c
@@ -3,6 +3,7 @@
  *
  * Copyright(c) 2008 - 2014 Intel Corporation. All rights reserved.
  * Copyright (C) 2019 Intel Corporation
+ * Copyright (C) 2023 Intel Corporation
  *****************************************************************************/
 
 #include <linux/kernel.h>
@@ -1169,7 +1170,7 @@ void iwlagn_rx_reply_tx(struct iwl_priv *priv, struct iwl_rx_cmd_buffer *rxb)
 			iwlagn_check_ratid_empty(priv, sta_id, tid);
 		}
 
-		iwl_trans_reclaim(priv->trans, txq_id, ssn, &skbs);
+		iwl_trans_reclaim(priv->trans, txq_id, ssn, &skbs, false);
 
 		freed = 0;
 
@@ -1315,7 +1316,7 @@ void iwlagn_rx_reply_compressed_ba(struct iwl_priv *priv,
 	 * block-ack window (we assume that they've been successfully
 	 * transmitted ... if not, it's too late anyway). */
 	iwl_trans_reclaim(priv->trans, scd_flow, ba_resp_scd_ssn,
-			  &reclaimed_skbs);
+			  &reclaimed_skbs, false);
 
 	IWL_DEBUG_TX_REPLY(priv, "REPLY_COMPRESSED_BA [%d] Received from %pM, "
 			   "sta_id = %d\n",
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index b248944e11df9..b1a4be0069a7e 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -588,7 +588,7 @@ struct iwl_trans_ops {
 	int (*tx)(struct iwl_trans *trans, struct sk_buff *skb,
 		  struct iwl_device_tx_cmd *dev_cmd, int queue);
 	void (*reclaim)(struct iwl_trans *trans, int queue, int ssn,
-			struct sk_buff_head *skbs);
+			struct sk_buff_head *skbs, bool is_flush);
 
 	void (*set_q_ptrs)(struct iwl_trans *trans, int queue, int ptr);
 
@@ -1270,14 +1270,15 @@ static inline int iwl_trans_tx(struct iwl_trans *trans, struct sk_buff *skb,
 }
 
 static inline void iwl_trans_reclaim(struct iwl_trans *trans, int queue,
-				     int ssn, struct sk_buff_head *skbs)
+				     int ssn, struct sk_buff_head *skbs,
+				     bool is_flush)
 {
 	if (WARN_ON_ONCE(trans->state != IWL_TRANS_FW_ALIVE)) {
 		IWL_ERR(trans, "%s bad state = %d\n", __func__, trans->state);
 		return;
 	}
 
-	trans->ops->reclaim(trans, queue, ssn, skbs);
+	trans->ops->reclaim(trans, queue, ssn, skbs, is_flush);
 }
 
 static inline void iwl_trans_set_q_ptrs(struct iwl_trans *trans, int queue,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index 8bdb239295c39..177a4628a913e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -1603,7 +1603,7 @@ static void iwl_mvm_rx_tx_cmd_single(struct iwl_mvm *mvm,
 	seq_ctl = le16_to_cpu(tx_resp->seq_ctl);
 
 	/* we can free until ssn % q.n_bd not inclusive */
-	iwl_trans_reclaim(mvm->trans, txq_id, ssn, &skbs);
+	iwl_trans_reclaim(mvm->trans, txq_id, ssn, &skbs, false);
 
 	while (!skb_queue_empty(&skbs)) {
 		struct sk_buff *skb = __skb_dequeue(&skbs);
@@ -1955,7 +1955,7 @@ static void iwl_mvm_tx_reclaim(struct iwl_mvm *mvm, int sta_id, int tid,
 	 * block-ack window (we assume that they've been successfully
 	 * transmitted ... if not, it's too late anyway).
 	 */
-	iwl_trans_reclaim(mvm->trans, txq, index, &reclaimed_skbs);
+	iwl_trans_reclaim(mvm->trans, txq, index, &reclaimed_skbs, is_flush);
 
 	skb_queue_walk(&reclaimed_skbs, skb) {
 		struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
diff --git a/drivers/net/wireless/intel/iwlwifi/queue/tx.c b/drivers/net/wireless/intel/iwlwifi/queue/tx.c
index 5bb3cc3367c9f..64dedb1d11862 100644
--- a/drivers/net/wireless/intel/iwlwifi/queue/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/queue/tx.c
@@ -1561,7 +1561,7 @@ void iwl_txq_progress(struct iwl_txq *txq)
 
 /* Frees buffers until index _not_ inclusive */
 void iwl_txq_reclaim(struct iwl_trans *trans, int txq_id, int ssn,
-		     struct sk_buff_head *skbs)
+		     struct sk_buff_head *skbs, bool is_flush)
 {
 	struct iwl_txq *txq = trans->txqs.txq[txq_id];
 	int tfd_num, read_ptr, last_to_free;
@@ -1636,9 +1636,11 @@ void iwl_txq_reclaim(struct iwl_trans *trans, int txq_id, int ssn,
 	if (iwl_txq_space(trans, txq) > txq->low_mark &&
 	    test_bit(txq_id, trans->txqs.queue_stopped)) {
 		struct sk_buff_head overflow_skbs;
+		struct sk_buff *skb;
 
 		__skb_queue_head_init(&overflow_skbs);
-		skb_queue_splice_init(&txq->overflow_q, &overflow_skbs);
+		skb_queue_splice_init(&txq->overflow_q,
+				      is_flush ? skbs : &overflow_skbs);
 
 		/*
 		 * We are going to transmit from the overflow queue.
@@ -1658,8 +1660,7 @@ void iwl_txq_reclaim(struct iwl_trans *trans, int txq_id, int ssn,
 		 */
 		spin_unlock_bh(&txq->lock);
 
-		while (!skb_queue_empty(&overflow_skbs)) {
-			struct sk_buff *skb = __skb_dequeue(&overflow_skbs);
+		while ((skb = __skb_dequeue(&overflow_skbs))) {
 			struct iwl_device_tx_cmd *dev_cmd_ptr;
 
 			dev_cmd_ptr = *(void **)((u8 *)skb->cb +
diff --git a/drivers/net/wireless/intel/iwlwifi/queue/tx.h b/drivers/net/wireless/intel/iwlwifi/queue/tx.h
index 1e4a24ab9bab2..b311426c84f05 100644
--- a/drivers/net/wireless/intel/iwlwifi/queue/tx.h
+++ b/drivers/net/wireless/intel/iwlwifi/queue/tx.h
@@ -173,7 +173,7 @@ void iwl_txq_gen1_update_byte_cnt_tbl(struct iwl_trans *trans,
 				      struct iwl_txq *txq, u16 byte_cnt,
 				      int num_tbs);
 void iwl_txq_reclaim(struct iwl_trans *trans, int txq_id, int ssn,
-		     struct sk_buff_head *skbs);
+		     struct sk_buff_head *skbs, bool is_flush);
 void iwl_txq_set_q_ptrs(struct iwl_trans *trans, int txq_id, int ptr);
 void iwl_trans_txq_freeze_timer(struct iwl_trans *trans, unsigned long txqs,
 				bool freeze);
-- 
2.42.0



