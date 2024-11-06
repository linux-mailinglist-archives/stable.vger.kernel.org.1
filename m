Return-Path: <stable+bounces-91567-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17DAE9BEE91
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 14:18:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B2BC1F25685
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 13:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4CEE1DFD9D;
	Wed,  6 Nov 2024 13:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2NPyjbWS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A194F1CB310;
	Wed,  6 Nov 2024 13:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730899111; cv=none; b=OJ7lah0+y0rdVmWV3dqPYQHP6lu3+c4paYxWwIHZL8rQSh1piwHSAO8EMLvfcQSvrckE3QZMav8ha7MG4ZF/UvThnPsp9/9FlGW25G89Au7pEugaTCfZ2A0CZtFGC6/XXbE901uL8Ipkg16O1907neYrqoWbhSSm4UO9T266eHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730899111; c=relaxed/simple;
	bh=LcogdUBGuo25AJRKyK4qAo62f2Dm94uhwx5sjUqPT18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gtFieSJZ/J3logLb0ugmGCMzjq6AM74aMZLgyo1s89mOsfkdUo6MrvnckJ4QW4Fct8pU6KoThAJ6Jaa68cLe3ZYAak7O4TYgfhaDHsf6r1yAGSZDExDKooZ3/woET/jrbGrxwwnYLislnw7rjogzJzOXIki0V4c6TBgAvA8Svbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2NPyjbWS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA8DDC4CECD;
	Wed,  6 Nov 2024 13:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730899111;
	bh=LcogdUBGuo25AJRKyK4qAo62f2Dm94uhwx5sjUqPT18=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2NPyjbWS4hC8FG3t/BC5JO2l7Sp22Mbf2hd7hP/5d2sHJMM4Hp2bQcr0URKFCEclL
	 ik/wYPRk9OjDMvkVsaDUbOC0G88aMa3x2OmTiwjaEBnde1fbevifLddSSOxCPQbd0i
	 5LvnmfKwIvSFWhQnugTusbCMGJ8BM7O1X28EuMpQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Youghandhar Chintala <youghand@codeaurora.org>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 429/462] mac80211: Add support to trigger sta disconnect on hardware restart
Date: Wed,  6 Nov 2024 13:05:22 +0100
Message-ID: <20241106120342.107777364@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106120331.497003148@linuxfoundation.org>
References: <20241106120331.497003148@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Youghandhar Chintala <youghand@codeaurora.org>

[ Upstream commit 7d352ccf1e9935b5222ca84e8baeb07a0c8f94b9 ]

Currently in case of target hardware restart, we just reconfig and
re-enable the security keys and enable the network queues to start
data traffic back from where it was interrupted.

Many ath10k wifi chipsets have sequence numbers for the data
packets assigned by firmware and the mac sequence number will
restart from zero after target hardware restart leading to mismatch
in the sequence number expected by the remote peer vs the sequence
number of the frame sent by the target firmware.

This mismatch in sequence number will cause out-of-order packets
on the remote peer and all the frames sent by the device are dropped
until we reach the sequence number which was sent before we restarted
the target hardware

In order to fix this, we trigger a sta disconnect, in case of target
hw restart. After this there will be a fresh connection and thereby
avoiding the dropping of frames by remote peer.

The right fix would be to pull the entire data path into the host
which is not feasible or would need lots of complex changes and
will still be inefficient.

Tested on ath10k using WCN3990, QCA6174

Signed-off-by: Youghandhar Chintala <youghand@codeaurora.org>
Link: https://lore.kernel.org/r/20220308115325.5246-2-youghand@codeaurora.org
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Stable-dep-of: 07a6e3b78a65 ("wifi: iwlwifi: mvm: Fix response handling in iwl_mvm_send_recovery_cmd()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/mac80211.h     | 10 ++++++++++
 net/mac80211/ieee80211_i.h |  3 +++
 net/mac80211/mlme.c        | 12 ++++++++++++
 net/mac80211/util.c        | 33 ++++++++++++++++++++++++++++++---
 4 files changed, 55 insertions(+), 3 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index cb5cf6bf19867..4d641580e5db4 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -5700,6 +5700,16 @@ void ieee80211_connection_loss(struct ieee80211_vif *vif);
  */
 void ieee80211_resume_disconnect(struct ieee80211_vif *vif);
 
+/**
+ * ieee80211_hw_restart_disconnect - disconnect from AP after
+ * hardware restart
+ * @vif: &struct ieee80211_vif pointer from the add_interface callback.
+ *
+ * Instructs mac80211 to disconnect from the AP after
+ * hardware restart.
+ */
+void ieee80211_hw_restart_disconnect(struct ieee80211_vif *vif);
+
 /**
  * ieee80211_cqm_rssi_notify - inform a configured connection quality monitoring
  *	rssi threshold triggered
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index e26368fab65d6..a9d064c75a15b 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -750,6 +750,8 @@ struct ieee80211_if_mesh {
  *	back to wireless media and to the local net stack.
  * @IEEE80211_SDATA_DISCONNECT_RESUME: Disconnect after resume.
  * @IEEE80211_SDATA_IN_DRIVER: indicates interface was added to driver
+ * @IEEE80211_SDATA_DISCONNECT_HW_RESTART: Disconnect after hardware restart
+ *  recovery
  */
 enum ieee80211_sub_if_data_flags {
 	IEEE80211_SDATA_ALLMULTI		= BIT(0),
@@ -757,6 +759,7 @@ enum ieee80211_sub_if_data_flags {
 	IEEE80211_SDATA_DONT_BRIDGE_PACKETS	= BIT(3),
 	IEEE80211_SDATA_DISCONNECT_RESUME	= BIT(4),
 	IEEE80211_SDATA_IN_DRIVER		= BIT(5),
+	IEEE80211_SDATA_DISCONNECT_HW_RESTART	= BIT(6),
 };
 
 /**
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index b48a09043663a..fe6ada0d79217 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -4584,6 +4584,18 @@ void ieee80211_sta_restart(struct ieee80211_sub_if_data *sdata)
 		sdata_unlock(sdata);
 		return;
 	}
+
+	if (sdata->flags & IEEE80211_SDATA_DISCONNECT_HW_RESTART) {
+		sdata->flags &= ~IEEE80211_SDATA_DISCONNECT_HW_RESTART;
+		mlme_dbg(sdata, "driver requested disconnect after hardware restart\n");
+		ieee80211_sta_connection_lost(sdata,
+					      ifmgd->associated->bssid,
+					      WLAN_REASON_UNSPECIFIED,
+					      true);
+		sdata_unlock(sdata);
+		return;
+	}
+
 	sdata_unlock(sdata);
 }
 #endif
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 8d3069c93a60a..63b66fd0a1ce6 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -2148,6 +2148,7 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 	struct cfg80211_sched_scan_request *sched_scan_req;
 	bool sched_scan_stopped = false;
 	bool suspended = local->suspended;
+	bool in_reconfig = false;
 
 	/* nothing to do if HW shouldn't run */
 	if (!local->open_count)
@@ -2499,6 +2500,7 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 		drv_reconfig_complete(local, IEEE80211_RECONFIG_TYPE_RESTART);
 
 	if (local->in_reconfig) {
+		in_reconfig = local->in_reconfig;
 		local->in_reconfig = false;
 		barrier();
 
@@ -2516,6 +2518,15 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 					IEEE80211_QUEUE_STOP_REASON_SUSPEND,
 					false);
 
+	if (in_reconfig) {
+		list_for_each_entry(sdata, &local->interfaces, list) {
+			if (!ieee80211_sdata_running(sdata))
+				continue;
+			if (sdata->vif.type == NL80211_IFTYPE_STATION)
+				ieee80211_sta_restart(sdata);
+		}
+	}
+
 	if (!suspended)
 		return 0;
 
@@ -2545,7 +2556,7 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 	return 0;
 }
 
-void ieee80211_resume_disconnect(struct ieee80211_vif *vif)
+static void ieee80211_reconfig_disconnect(struct ieee80211_vif *vif, u8 flag)
 {
 	struct ieee80211_sub_if_data *sdata;
 	struct ieee80211_local *local;
@@ -2557,19 +2568,35 @@ void ieee80211_resume_disconnect(struct ieee80211_vif *vif)
 	sdata = vif_to_sdata(vif);
 	local = sdata->local;
 
-	if (WARN_ON(!local->resuming))
+	if (WARN_ON(flag & IEEE80211_SDATA_DISCONNECT_RESUME &&
+		    !local->resuming))
+		return;
+
+	if (WARN_ON(flag & IEEE80211_SDATA_DISCONNECT_HW_RESTART &&
+		    !local->in_reconfig))
 		return;
 
 	if (WARN_ON(vif->type != NL80211_IFTYPE_STATION))
 		return;
 
-	sdata->flags |= IEEE80211_SDATA_DISCONNECT_RESUME;
+	sdata->flags |= flag;
 
 	mutex_lock(&local->key_mtx);
 	list_for_each_entry(key, &sdata->key_list, list)
 		key->flags |= KEY_FLAG_TAINTED;
 	mutex_unlock(&local->key_mtx);
 }
+
+void ieee80211_hw_restart_disconnect(struct ieee80211_vif *vif)
+{
+	ieee80211_reconfig_disconnect(vif, IEEE80211_SDATA_DISCONNECT_HW_RESTART);
+}
+EXPORT_SYMBOL_GPL(ieee80211_hw_restart_disconnect);
+
+void ieee80211_resume_disconnect(struct ieee80211_vif *vif)
+{
+	ieee80211_reconfig_disconnect(vif, IEEE80211_SDATA_DISCONNECT_RESUME);
+}
 EXPORT_SYMBOL_GPL(ieee80211_resume_disconnect);
 
 void ieee80211_recalc_smps(struct ieee80211_sub_if_data *sdata)
-- 
2.43.0




