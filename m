Return-Path: <stable+bounces-104952-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 613279F53D7
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 18:33:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FC3E1881AFF
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 17:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46FBD1F757B;
	Tue, 17 Dec 2024 17:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="be+Azut/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36651F76D6;
	Tue, 17 Dec 2024 17:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734456619; cv=none; b=FGPJ6T+JtIf6Th/6jJfsA75B9v6H6gurZiZJJiAkiqzuPLdFyYbx1jJAiRmlLv5oIqvuCtBweeLibDCPw2lh8Swnc6QenerlDE/VhA7SHvt8Nsn1Y9aZm5yD/fZqzaByR2PbQvwVhBidnzrDkz23K/D3cdVBGCEl9kmBnY0bmtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734456619; c=relaxed/simple;
	bh=GzkD5cXdr53tyOOkGHw10RDyqJzTxDgMT/cuJ6SXeqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d1CPbv8rarOPmB6eTv4LmyU9vMNsKfSnfgPPkgD+YSxxQkQq1QZ5LN7yOCg5iBKqbFEl2HANLTPOWUFR9s2sDde+PGGdfAm6Hf014lDIg8hjtvjOov/tC3SBZkp2j2ZvIrcPevRCfFP0FoWdY/dgrS6Dxw8tTv00UwisE5NRpbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=be+Azut/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D6DCC4CED3;
	Tue, 17 Dec 2024 17:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734456618;
	bh=GzkD5cXdr53tyOOkGHw10RDyqJzTxDgMT/cuJ6SXeqA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=be+Azut/j3O6CAcrTQpK92qshOCY2BiqwcynF7SM2IIx4e/cy5hz25sMLbtx+08Uh
	 QVikzvQ7WfULjwwQMS+R86/vuqESByGaDtPWrMVIEKKD1WIs732Huu4svqbg4BlUYE
	 +zN9bjQfpLDobBkDZ3hkkc95a2ETyagSO92CYZJI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 085/172] wifi: mac80211: fix a queue stall in certain cases of CSA
Date: Tue, 17 Dec 2024 18:07:21 +0100
Message-ID: <20241217170549.812761118@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241217170546.209657098@linuxfoundation.org>
References: <20241217170546.209657098@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

[ Upstream commit 11ac0d7c3b5ba58232fb7dacb54371cbe75ec183 ]

If we got an unprotected action frame with CSA and then we heard the
beacon with the CSA IE, we'll block the queues with the CSA reason
twice. Since this reason is refcounted, we won't wake up the queues
since we wake them up only once and the ref count will never reach 0.
This led to blocked queues that prevented any activity (even
disconnection wouldn't reset the queue state and the only way to recover
would be to reload the kernel module.

Fix this by not refcounting the CSA reason.
It becomes now pointless to maintain the csa_blocked_queues state.
Remove it.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Fixes: 414e090bc41d ("wifi: mac80211: restrict public action ECSA frame handling")
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219447
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://patch.msgid.link/20241119173108.5ea90828c2cc.I4f89e58572fb71ae48e47a81e74595cac410fbac@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c |  2 +-
 include/net/mac80211.h                        |  4 +-
 net/mac80211/cfg.c                            |  3 +-
 net/mac80211/ieee80211_i.h                    | 49 +++++++++++++++----
 net/mac80211/iface.c                          | 12 ++---
 net/mac80211/mlme.c                           |  2 -
 net/mac80211/util.c                           | 23 ++-------
 7 files changed, 50 insertions(+), 45 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
index a7a10e716e65..e96ddaeeeeff 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
@@ -1967,7 +1967,7 @@ void iwl_mvm_channel_switch_error_notif(struct iwl_mvm *mvm,
 	if (csa_err_mask & (CS_ERR_COUNT_ERROR |
 			    CS_ERR_LONG_DELAY_AFTER_CS |
 			    CS_ERR_TX_BLOCK_TIMER_EXPIRED))
-		ieee80211_channel_switch_disconnect(vif, true);
+		ieee80211_channel_switch_disconnect(vif);
 	rcu_read_unlock();
 }
 
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 333e0fae6796..5b712582f9a9 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -6770,14 +6770,12 @@ void ieee80211_chswitch_done(struct ieee80211_vif *vif, bool success,
 /**
  * ieee80211_channel_switch_disconnect - disconnect due to channel switch error
  * @vif: &struct ieee80211_vif pointer from the add_interface callback.
- * @block_tx: if %true, do not send deauth frame.
  *
  * Instruct mac80211 to disconnect due to a channel switch error. The channel
  * switch can request to block the tx and so, we need to make sure we do not send
  * a deauth frame in this case.
  */
-void ieee80211_channel_switch_disconnect(struct ieee80211_vif *vif,
-					 bool block_tx);
+void ieee80211_channel_switch_disconnect(struct ieee80211_vif *vif);
 
 /**
  * ieee80211_request_smps - request SM PS transition
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 242b718b1cd9..16d47123a73c 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -3674,13 +3674,12 @@ void ieee80211_csa_finish(struct ieee80211_vif *vif, unsigned int link_id)
 }
 EXPORT_SYMBOL(ieee80211_csa_finish);
 
-void ieee80211_channel_switch_disconnect(struct ieee80211_vif *vif, bool block_tx)
+void ieee80211_channel_switch_disconnect(struct ieee80211_vif *vif)
 {
 	struct ieee80211_sub_if_data *sdata = vif_to_sdata(vif);
 	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
 	struct ieee80211_local *local = sdata->local;
 
-	sdata->csa_blocked_queues = block_tx;
 	sdata_info(sdata, "channel switch failed, disconnecting\n");
 	wiphy_work_queue(local->hw.wiphy, &ifmgd->csa_connection_drop_work);
 }
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 3d3c9139ff5e..7a0242e937d3 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1106,8 +1106,6 @@ struct ieee80211_sub_if_data {
 
 	unsigned long state;
 
-	bool csa_blocked_queues;
-
 	char name[IFNAMSIZ];
 
 	struct ieee80211_fragment_cache frags;
@@ -2411,17 +2409,13 @@ void ieee80211_send_4addr_nullfunc(struct ieee80211_local *local,
 				   struct ieee80211_sub_if_data *sdata);
 void ieee80211_sta_tx_notify(struct ieee80211_sub_if_data *sdata,
 			     struct ieee80211_hdr *hdr, bool ack, u16 tx_time);
-
+unsigned int
+ieee80211_get_vif_queues(struct ieee80211_local *local,
+			 struct ieee80211_sub_if_data *sdata);
 void ieee80211_wake_queues_by_reason(struct ieee80211_hw *hw,
 				     unsigned long queues,
 				     enum queue_stop_reason reason,
 				     bool refcounted);
-void ieee80211_stop_vif_queues(struct ieee80211_local *local,
-			       struct ieee80211_sub_if_data *sdata,
-			       enum queue_stop_reason reason);
-void ieee80211_wake_vif_queues(struct ieee80211_local *local,
-			       struct ieee80211_sub_if_data *sdata,
-			       enum queue_stop_reason reason);
 void ieee80211_stop_queues_by_reason(struct ieee80211_hw *hw,
 				     unsigned long queues,
 				     enum queue_stop_reason reason,
@@ -2432,6 +2426,43 @@ void ieee80211_wake_queue_by_reason(struct ieee80211_hw *hw, int queue,
 void ieee80211_stop_queue_by_reason(struct ieee80211_hw *hw, int queue,
 				    enum queue_stop_reason reason,
 				    bool refcounted);
+static inline void
+ieee80211_stop_vif_queues(struct ieee80211_local *local,
+			  struct ieee80211_sub_if_data *sdata,
+			  enum queue_stop_reason reason)
+{
+	ieee80211_stop_queues_by_reason(&local->hw,
+					ieee80211_get_vif_queues(local, sdata),
+					reason, true);
+}
+
+static inline void
+ieee80211_wake_vif_queues(struct ieee80211_local *local,
+			  struct ieee80211_sub_if_data *sdata,
+			  enum queue_stop_reason reason)
+{
+	ieee80211_wake_queues_by_reason(&local->hw,
+					ieee80211_get_vif_queues(local, sdata),
+					reason, true);
+}
+static inline void
+ieee80211_stop_vif_queues_norefcount(struct ieee80211_local *local,
+				     struct ieee80211_sub_if_data *sdata,
+				     enum queue_stop_reason reason)
+{
+	ieee80211_stop_queues_by_reason(&local->hw,
+					ieee80211_get_vif_queues(local, sdata),
+					reason, false);
+}
+static inline void
+ieee80211_wake_vif_queues_norefcount(struct ieee80211_local *local,
+				     struct ieee80211_sub_if_data *sdata,
+				     enum queue_stop_reason reason)
+{
+	ieee80211_wake_queues_by_reason(&local->hw,
+					ieee80211_get_vif_queues(local, sdata),
+					reason, false);
+}
 void ieee80211_add_pending_skb(struct ieee80211_local *local,
 			       struct sk_buff *skb);
 void ieee80211_add_pending_skbs(struct ieee80211_local *local,
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 6ef0990d3d29..af9055252e6d 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -2364,18 +2364,14 @@ void ieee80211_vif_block_queues_csa(struct ieee80211_sub_if_data *sdata)
 	if (ieee80211_hw_check(&local->hw, HANDLES_QUIET_CSA))
 		return;
 
-	ieee80211_stop_vif_queues(local, sdata,
-				  IEEE80211_QUEUE_STOP_REASON_CSA);
-	sdata->csa_blocked_queues = true;
+	ieee80211_stop_vif_queues_norefcount(local, sdata,
+					     IEEE80211_QUEUE_STOP_REASON_CSA);
 }
 
 void ieee80211_vif_unblock_queues_csa(struct ieee80211_sub_if_data *sdata)
 {
 	struct ieee80211_local *local = sdata->local;
 
-	if (sdata->csa_blocked_queues) {
-		ieee80211_wake_vif_queues(local, sdata,
-					  IEEE80211_QUEUE_STOP_REASON_CSA);
-		sdata->csa_blocked_queues = false;
-	}
+	ieee80211_wake_vif_queues_norefcount(local, sdata,
+					     IEEE80211_QUEUE_STOP_REASON_CSA);
 }
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 0303972c23e4..111066928b96 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -2636,8 +2636,6 @@ ieee80211_sta_process_chanswitch(struct ieee80211_link_data *link,
 	 */
 	link->conf->csa_active = true;
 	link->u.mgd.csa.blocked_tx = csa_ie.mode;
-	sdata->csa_blocked_queues =
-		csa_ie.mode && !ieee80211_hw_check(&local->hw, HANDLES_QUIET_CSA);
 
 	wiphy_work_queue(sdata->local->hw.wiphy,
 			 &ifmgd->csa_connection_drop_work);
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index f94faa86ba8a..b4814e97cf74 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -657,7 +657,7 @@ void ieee80211_wake_queues(struct ieee80211_hw *hw)
 }
 EXPORT_SYMBOL(ieee80211_wake_queues);
 
-static unsigned int
+unsigned int
 ieee80211_get_vif_queues(struct ieee80211_local *local,
 			 struct ieee80211_sub_if_data *sdata)
 {
@@ -669,7 +669,8 @@ ieee80211_get_vif_queues(struct ieee80211_local *local,
 		queues = 0;
 
 		for (ac = 0; ac < IEEE80211_NUM_ACS; ac++)
-			queues |= BIT(sdata->vif.hw_queue[ac]);
+			if (sdata->vif.hw_queue[ac] != IEEE80211_INVAL_HW_QUEUE)
+				queues |= BIT(sdata->vif.hw_queue[ac]);
 		if (sdata->vif.cab_queue != IEEE80211_INVAL_HW_QUEUE)
 			queues |= BIT(sdata->vif.cab_queue);
 	} else {
@@ -724,24 +725,6 @@ void ieee80211_flush_queues(struct ieee80211_local *local,
 	__ieee80211_flush_queues(local, sdata, 0, drop);
 }
 
-void ieee80211_stop_vif_queues(struct ieee80211_local *local,
-			       struct ieee80211_sub_if_data *sdata,
-			       enum queue_stop_reason reason)
-{
-	ieee80211_stop_queues_by_reason(&local->hw,
-					ieee80211_get_vif_queues(local, sdata),
-					reason, true);
-}
-
-void ieee80211_wake_vif_queues(struct ieee80211_local *local,
-			       struct ieee80211_sub_if_data *sdata,
-			       enum queue_stop_reason reason)
-{
-	ieee80211_wake_queues_by_reason(&local->hw,
-					ieee80211_get_vif_queues(local, sdata),
-					reason, true);
-}
-
 static void __iterate_interfaces(struct ieee80211_local *local,
 				 u32 iter_flags,
 				 void (*iterator)(void *data, u8 *mac,
-- 
2.39.5




