Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A35E7556EC
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233029AbjGPUzS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233026AbjGPUzR (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:55:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C835BE41
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:55:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6713A60EAE
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:55:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7274FC433C8;
        Sun, 16 Jul 2023 20:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689540915;
        bh=3l40eiHJj/NNMHQm6yEZpJZ2YspLPD7oLd4/khaIQdU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GumDwm6+8+nazfuc9q/ZPk7i3JGAnIjjMH0NImNhpb3p1gKyppVrqFlv+ykHmjeII
         Zl+uFQhQjxjk1UE1+4hlvDw4SRiGC2vrfguHjyeLov+g+fYefLHlshQUgZ6HgXhXcN
         d6knw68fPvGCvBk0rhp8TqRIBPRUFDFfkA3jZGmA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Felix Fietkau <nbd@nbd.name>,
        Alexander Wetzel <alexander@wetzel-home.de>,
        Kalle Valo <quic_kvalo@quicinc.com>
Subject: [PATCH 6.1 534/591] wifi: ath10k: Serialize wake_tx_queue ops
Date:   Sun, 16 Jul 2023 21:51:13 +0200
Message-ID: <20230716194937.683811653@linuxfoundation.org>
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

From: Alexander Wetzel <alexander@wetzel-home.de>

commit b719ebc37a1eacd4fd4f1264f731b016e5ec0c6e upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/ath/ath10k/core.c |    3 +++
 drivers/net/wireless/ath/ath10k/core.h |    3 +++
 drivers/net/wireless/ath/ath10k/mac.c  |    6 ++++--
 3 files changed, 10 insertions(+), 2 deletions(-)

--- a/drivers/net/wireless/ath/ath10k/core.c
+++ b/drivers/net/wireless/ath/ath10k/core.c
@@ -3634,6 +3634,9 @@ struct ath10k *ath10k_core_create(size_t
 	mutex_init(&ar->dump_mutex);
 	spin_lock_init(&ar->data_lock);
 
+	for (int ac = 0; ac < IEEE80211_NUM_ACS; ac++)
+		spin_lock_init(&ar->queue_lock[ac]);
+
 	INIT_LIST_HEAD(&ar->peers);
 	init_waitqueue_head(&ar->peer_mapping_wq);
 	init_waitqueue_head(&ar->htt.empty_tx_wq);
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
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -4732,13 +4732,14 @@ static void ath10k_mac_op_wake_tx_queue(
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
@@ -4753,6 +4754,7 @@ static void ath10k_mac_op_wake_tx_queue(
 	ath10k_htt_tx_txq_update(hw, txq);
 out:
 	ieee80211_txq_schedule_end(hw, ac);
+	spin_unlock_bh(&ar->queue_lock[ac]);
 }
 
 /* Must not be called with conf_mutex held as workers can use that also. */


