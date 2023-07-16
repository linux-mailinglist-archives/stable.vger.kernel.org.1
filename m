Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD609754E1D
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 11:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbjGPJjo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 05:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjGPJjn (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 05:39:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 830FBE45
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 02:39:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2019060C75
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 09:39:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28567C433C7;
        Sun, 16 Jul 2023 09:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689500381;
        bh=q1q831gwvq6ENOKeSwa2L7ZZ6ePiTj9Gwq5RafTn9JM=;
        h=Subject:To:Cc:From:Date:From;
        b=YWekrJ32P4OLtbGdpZGXZtmg/lNVCgveraCA931GCogyfZb/szwxVW96GIYoyj/ii
         oCFYl2v2GivG5WiZVEniGMbQZwPc8ytC8PRpuOHDsMP8B+itNmEVeSyEUY26ci0QB4
         EsfX3bJ80K59proz1zylsbSOfMzli7lxvRTkbbPI=
Subject: FAILED: patch "[PATCH] wifi: ath10k: Serialize wake_tx_queue ops" failed to apply to 5.4-stable tree
To:     alexander@wetzel-home.de, nbd@nbd.name, quic_kvalo@quicinc.com,
        stable@vger.kernel.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 16 Jul 2023 11:39:38 +0200
Message-ID: <2023071638-cancel-excluding-0e69@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x b719ebc37a1eacd4fd4f1264f731b016e5ec0c6e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023071638-cancel-excluding-0e69@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

b719ebc37a1e ("wifi: ath10k: Serialize wake_tx_queue ops")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b719ebc37a1eacd4fd4f1264f731b016e5ec0c6e Mon Sep 17 00:00:00 2001
From: Alexander Wetzel <alexander@wetzel-home.de>
Date: Thu, 23 Mar 2023 17:55:27 +0100
Subject: [PATCH] wifi: ath10k: Serialize wake_tx_queue ops

Serialize the ath10k implementation of the wake_tx_queue ops.
ath10k_mac_op_wake_tx_queue() must not run concurrent since it's using
ieee80211_txq_schedule_start().

The intend of this patch is to sort out an issue discovered in the discussion
referred to by the Link tag.

I can't test it with real hardware and thus just implemented the per-ac queue
lock Felix suggested. One obvious alternative to the per-ac lock would be to
bring back the txqs_lock commit bb2edb733586 ("ath10k: migrate to mac80211 txq
scheduling") dropped.

Fixes: bb2edb733586 ("ath10k: migrate to mac80211 txq scheduling")
Reported-by: Felix Fietkau <nbd@nbd.name>
Link: https://lore.kernel.org/r/519b5bb9-8899-ae7c-4eff-f3116cdfdb56@nbd.name
CC: <stable@vger.kernel.org>
Signed-off-by: Alexander Wetzel <alexander@wetzel-home.de>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Link: https://lore.kernel.org/r/20230323165527.156414-1-alexander@wetzel-home.de

diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
index 5eb131ab916f..533ed7169e11 100644
--- a/drivers/net/wireless/ath/ath10k/core.c
+++ b/drivers/net/wireless/ath/ath10k/core.c
@@ -3643,6 +3643,9 @@ struct ath10k *ath10k_core_create(size_t priv_size, struct device *dev,
 	mutex_init(&ar->dump_mutex);
 	spin_lock_init(&ar->data_lock);
 
+	for (int ac = 0; ac < IEEE80211_NUM_ACS; ac++)
+		spin_lock_init(&ar->queue_lock[ac]);
+
 	INIT_LIST_HEAD(&ar->peers);
 	init_waitqueue_head(&ar->peer_mapping_wq);
 	init_waitqueue_head(&ar->htt.empty_tx_wq);
diff --git a/drivers/net/wireless/ath/ath10k/core.h b/drivers/net/wireless/ath/ath10k/core.h
index f5de8ce8fb45..4b5239de4018 100644
--- a/drivers/net/wireless/ath/ath10k/core.h
+++ b/drivers/net/wireless/ath/ath10k/core.h
@@ -1170,6 +1170,9 @@ struct ath10k {
 	/* protects shared structure data */
 	spinlock_t data_lock;
 
+	/* serialize wake_tx_queue calls per ac */
+	spinlock_t queue_lock[IEEE80211_NUM_ACS];
+
 	struct list_head arvifs;
 	struct list_head peers;
 	struct ath10k_peer *peer_map[ATH10K_MAX_NUM_PEER_IDS];
diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index 7675858f069b..9c4bf2fdbc0f 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -4732,13 +4732,14 @@ static void ath10k_mac_op_wake_tx_queue(struct ieee80211_hw *hw,
 {
 	struct ath10k *ar = hw->priv;
 	int ret;
-	u8 ac;
+	u8 ac = txq->ac;
 
 	ath10k_htt_tx_txq_update(hw, txq);
 	if (ar->htt.tx_q_state.mode != HTT_TX_MODE_SWITCH_PUSH)
 		return;
 
-	ac = txq->ac;
+	spin_lock_bh(&ar->queue_lock[ac]);
+
 	ieee80211_txq_schedule_start(hw, ac);
 	txq = ieee80211_next_txq(hw, ac);
 	if (!txq)
@@ -4753,6 +4754,7 @@ static void ath10k_mac_op_wake_tx_queue(struct ieee80211_hw *hw,
 	ath10k_htt_tx_txq_update(hw, txq);
 out:
 	ieee80211_txq_schedule_end(hw, ac);
+	spin_unlock_bh(&ar->queue_lock[ac]);
 }
 
 /* Must not be called with conf_mutex held as workers can use that also. */

