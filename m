Return-Path: <stable+bounces-134203-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B1A0A92A15
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 20:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43A323B5380
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 18:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CBBC25335A;
	Thu, 17 Apr 2025 18:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GjZ36Naj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD05F3594D;
	Thu, 17 Apr 2025 18:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744915409; cv=none; b=cC1JOKxTTFlSXDS1hoHse5jCEwcivrl6iHVGmSUeN2sObP56XDdGQmZjaOO6vhSU5WHK25KFdw9gFw5zGBGtb/1w6sQoUhhwr83sNfSSEQfxEk4E0zAJOYpSJY8bSKWdddPAU3mewX2Khlms+UYxSDHmvm3ANYdyw4JzELBcRlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744915409; c=relaxed/simple;
	bh=1oVm8eiLiM82nRPnlN2mtcLHkVbeBoLboGX/iiTDIpc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WJlohKY62duoaa816ohs5/ztsxsDP00M8hZYGSqffdSZcGsxi7bPC/8mq37aKhC1J5GNR07kdAqCrpaOQV1O59uFz5ZnmI+s9uxuybLrFaMLnIIthSZyiBsOU1jp/UL1WDPGRm70jKH7L59BNh43Jg+rJVuUjK8abBR1FSesoGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GjZ36Naj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61978C4CEE4;
	Thu, 17 Apr 2025 18:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744915409;
	bh=1oVm8eiLiM82nRPnlN2mtcLHkVbeBoLboGX/iiTDIpc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GjZ36NajTHGY3kU2lOrqJwzZF+R1z8/2ljsjxUJmqL8oIdwqDtOMf73aysSBu3EZ3
	 QEgavjJgoWnf+kksSL4tV3wcCr5gweK0bcoLFMuNy/wnujb1iKFCCNCRbJM55XXDH5
	 iYFpR2xSqw1L46ddYPw9UWTYt0n8v7TDhMiYDiQs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Johannes Berg <johannes.berg@intel.com>,
	Ilan Peer <ilan.peer@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 091/393] wifi: mac80211: add strict mode disabling workarounds
Date: Thu, 17 Apr 2025 19:48:20 +0200
Message-ID: <20250417175111.257402604@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250417175107.546547190@linuxfoundation.org>
References: <20250417175107.546547190@linuxfoundation.org>
User-Agent: quilt/0.68
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

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 3ad4fce66e4f9d82abfc366707757e29cc14a9d2 ]

Add a strict mode where we disable certain workarounds and have
additional checks such as, for now, that VHT capabilities from
association response match those from beacon/probe response. We
can extend the checks in the future.

Make it an opt-in setting by the driver so it can be set there
in some driver-specific way, for example. Also allow setting
this one hw flag through the hwflags debugfs, by writing a new
strict=0 or strict=1 value.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://patch.msgid.link/20250205110958.5cecb0469479.I4a69617dc60ba0d6308416ffbc3102cfd08ba068@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/mac80211.h |  6 ++++++
 net/mac80211/debugfs.c | 44 +++++++++++++++++++++++++++++++++++++++--
 net/mac80211/mlme.c    | 45 +++++++++++++++++++++++++++++-------------
 3 files changed, 79 insertions(+), 16 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 5b712582f9a9c..3b964f8834e71 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -2826,6 +2826,11 @@ struct ieee80211_txq {
  *	implements MLO, so operation can continue on other links when one
  *	link is switching.
  *
+ * @IEEE80211_HW_STRICT: strictly enforce certain things mandated by the spec
+ *	but otherwise ignored/worked around for interoperability. This is a
+ *	HW flag so drivers can opt in according to their own control, e.g. in
+ *	testing.
+ *
  * @NUM_IEEE80211_HW_FLAGS: number of hardware flags, used for sizing arrays
  */
 enum ieee80211_hw_flags {
@@ -2885,6 +2890,7 @@ enum ieee80211_hw_flags {
 	IEEE80211_HW_DISALLOW_PUNCTURING,
 	IEEE80211_HW_DISALLOW_PUNCTURING_5GHZ,
 	IEEE80211_HW_HANDLES_QUIET_CSA,
+	IEEE80211_HW_STRICT,
 
 	/* keep last, obviously */
 	NUM_IEEE80211_HW_FLAGS
diff --git a/net/mac80211/debugfs.c b/net/mac80211/debugfs.c
index 02b5476a4376c..a0710ae0e7a49 100644
--- a/net/mac80211/debugfs.c
+++ b/net/mac80211/debugfs.c
@@ -499,6 +499,7 @@ static const char *hw_flag_names[] = {
 	FLAG(DISALLOW_PUNCTURING),
 	FLAG(DISALLOW_PUNCTURING_5GHZ),
 	FLAG(HANDLES_QUIET_CSA),
+	FLAG(STRICT),
 #undef FLAG
 };
 
@@ -531,6 +532,46 @@ static ssize_t hwflags_read(struct file *file, char __user *user_buf,
 	return rv;
 }
 
+static ssize_t hwflags_write(struct file *file, const char __user *user_buf,
+			     size_t count, loff_t *ppos)
+{
+	struct ieee80211_local *local = file->private_data;
+	char buf[100];
+	int val;
+
+	if (count >= sizeof(buf))
+		return -EINVAL;
+
+	if (copy_from_user(buf, user_buf, count))
+		return -EFAULT;
+
+	if (count && buf[count - 1] == '\n')
+		buf[count - 1] = '\0';
+	else
+		buf[count] = '\0';
+
+	if (sscanf(buf, "strict=%d", &val) == 1) {
+		switch (val) {
+		case 0:
+			ieee80211_hw_set(&local->hw, STRICT);
+			return count;
+		case 1:
+			__clear_bit(IEEE80211_HW_STRICT, local->hw.flags);
+			return count;
+		default:
+			return -EINVAL;
+		}
+	}
+
+	return -EINVAL;
+}
+
+static const struct file_operations hwflags_ops = {
+	.open = simple_open,
+	.read = hwflags_read,
+	.write = hwflags_write,
+};
+
 static ssize_t misc_read(struct file *file, char __user *user_buf,
 			 size_t count, loff_t *ppos)
 {
@@ -581,7 +622,6 @@ static ssize_t queues_read(struct file *file, char __user *user_buf,
 	return simple_read_from_buffer(user_buf, count, ppos, buf, res);
 }
 
-DEBUGFS_READONLY_FILE_OPS(hwflags);
 DEBUGFS_READONLY_FILE_OPS(queues);
 DEBUGFS_READONLY_FILE_OPS(misc);
 
@@ -659,7 +699,7 @@ void debugfs_hw_add(struct ieee80211_local *local)
 #ifdef CONFIG_PM
 	DEBUGFS_ADD_MODE(reset, 0200);
 #endif
-	DEBUGFS_ADD(hwflags);
+	DEBUGFS_ADD_MODE(hwflags, 0600);
 	DEBUGFS_ADD(user_power);
 	DEBUGFS_ADD(power);
 	DEBUGFS_ADD(hw_conf);
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 88751b0eb317a..ad0d040569dcd 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -166,6 +166,9 @@ ieee80211_determine_ap_chan(struct ieee80211_sub_if_data *sdata,
 	bool no_vht = false;
 	u32 ht_cfreq;
 
+	if (ieee80211_hw_check(&sdata->local->hw, STRICT))
+		ignore_ht_channel_mismatch = false;
+
 	*chandef = (struct cfg80211_chan_def) {
 		.chan = channel,
 		.width = NL80211_CHAN_WIDTH_20_NOHT,
@@ -385,7 +388,7 @@ ieee80211_verify_peer_he_mcs_support(struct ieee80211_sub_if_data *sdata,
 	 * zeroes, which is nonsense, and completely inconsistent with itself
 	 * (it doesn't have 8 streams). Accept the settings in this case anyway.
 	 */
-	if (!ap_min_req_set)
+	if (!ieee80211_hw_check(&sdata->local->hw, STRICT) && !ap_min_req_set)
 		return true;
 
 	/* make sure the AP is consistent with itself
@@ -445,7 +448,7 @@ ieee80211_verify_sta_he_mcs_support(struct ieee80211_sub_if_data *sdata,
 	 * zeroes, which is nonsense, and completely inconsistent with itself
 	 * (it doesn't have 8 streams). Accept the settings in this case anyway.
 	 */
-	if (!ap_min_req_set)
+	if (!ieee80211_hw_check(&sdata->local->hw, STRICT) && !ap_min_req_set)
 		return true;
 
 	/* Need to go over for 80MHz, 160MHz and for 80+80 */
@@ -1212,13 +1215,15 @@ static bool ieee80211_add_vht_ie(struct ieee80211_sub_if_data *sdata,
 	 * Some APs apparently get confused if our capabilities are better
 	 * than theirs, so restrict what we advertise in the assoc request.
 	 */
-	if (!(ap_vht_cap->vht_cap_info &
-			cpu_to_le32(IEEE80211_VHT_CAP_SU_BEAMFORMER_CAPABLE)))
-		cap &= ~(IEEE80211_VHT_CAP_SU_BEAMFORMEE_CAPABLE |
-			 IEEE80211_VHT_CAP_MU_BEAMFORMEE_CAPABLE);
-	else if (!(ap_vht_cap->vht_cap_info &
-			cpu_to_le32(IEEE80211_VHT_CAP_MU_BEAMFORMER_CAPABLE)))
-		cap &= ~IEEE80211_VHT_CAP_MU_BEAMFORMEE_CAPABLE;
+	if (!ieee80211_hw_check(&local->hw, STRICT)) {
+		if (!(ap_vht_cap->vht_cap_info &
+				cpu_to_le32(IEEE80211_VHT_CAP_SU_BEAMFORMER_CAPABLE)))
+			cap &= ~(IEEE80211_VHT_CAP_SU_BEAMFORMEE_CAPABLE |
+				 IEEE80211_VHT_CAP_MU_BEAMFORMEE_CAPABLE);
+		else if (!(ap_vht_cap->vht_cap_info &
+				cpu_to_le32(IEEE80211_VHT_CAP_MU_BEAMFORMER_CAPABLE)))
+			cap &= ~IEEE80211_VHT_CAP_MU_BEAMFORMEE_CAPABLE;
+	}
 
 	/*
 	 * If some other vif is using the MU-MIMO capability we cannot associate
@@ -1260,14 +1265,16 @@ static bool ieee80211_add_vht_ie(struct ieee80211_sub_if_data *sdata,
 	return mu_mimo_owner;
 }
 
-static void ieee80211_assoc_add_rates(struct sk_buff *skb,
+static void ieee80211_assoc_add_rates(struct ieee80211_local *local,
+				      struct sk_buff *skb,
 				      enum nl80211_chan_width width,
 				      struct ieee80211_supported_band *sband,
 				      struct ieee80211_mgd_assoc_data *assoc_data)
 {
 	u32 rates;
 
-	if (assoc_data->supp_rates_len) {
+	if (assoc_data->supp_rates_len &&
+	    !ieee80211_hw_check(&local->hw, STRICT)) {
 		/*
 		 * Get all rates supported by the device and the AP as
 		 * some APs don't like getting a superset of their rates
@@ -1481,7 +1488,7 @@ static size_t ieee80211_assoc_link_elems(struct ieee80211_sub_if_data *sdata,
 		*capab |= WLAN_CAPABILITY_SPECTRUM_MGMT;
 
 	if (sband->band != NL80211_BAND_S1GHZ)
-		ieee80211_assoc_add_rates(skb, width, sband, assoc_data);
+		ieee80211_assoc_add_rates(local, skb, width, sband, assoc_data);
 
 	if (*capab & WLAN_CAPABILITY_SPECTRUM_MGMT ||
 	    *capab & WLAN_CAPABILITY_RADIO_MEASURE) {
@@ -1925,7 +1932,8 @@ static int ieee80211_send_assoc(struct ieee80211_sub_if_data *sdata)
 	 * for some reason check it and want it to be set, set the bit for all
 	 * pre-EHT connections as we used to do.
 	 */
-	if (link->u.mgd.conn.mode < IEEE80211_CONN_MODE_EHT)
+	if (link->u.mgd.conn.mode < IEEE80211_CONN_MODE_EHT &&
+	    !ieee80211_hw_check(&local->hw, STRICT))
 		capab |= WLAN_CAPABILITY_ESS;
 
 	/* add the elements for the assoc (main) link */
@@ -4710,7 +4718,7 @@ static bool ieee80211_assoc_config_link(struct ieee80211_link_data *link,
 	 * 2G/3G/4G wifi routers, reported models include the "Onda PN51T",
 	 * "Vodafone PocketWiFi 2", "ZTE MF60" and a similar T-Mobile device.
 	 */
-	if (!is_6ghz &&
+	if (!ieee80211_hw_check(&local->hw, STRICT) && !is_6ghz &&
 	    ((assoc_data->wmm && !elems->wmm_param) ||
 	     (link->u.mgd.conn.mode >= IEEE80211_CONN_MODE_HT &&
 	      (!elems->ht_cap_elem || !elems->ht_operation)) ||
@@ -4846,6 +4854,15 @@ static bool ieee80211_assoc_config_link(struct ieee80211_link_data *link,
 				bss_vht_cap = (const void *)elem->data;
 		}
 
+		if (ieee80211_hw_check(&local->hw, STRICT) &&
+		    (!bss_vht_cap || memcmp(bss_vht_cap, elems->vht_cap_elem,
+					    sizeof(*bss_vht_cap)))) {
+			rcu_read_unlock();
+			ret = false;
+			link_info(link, "VHT capabilities mismatch\n");
+			goto out;
+		}
+
 		ieee80211_vht_cap_ie_to_sta_vht_cap(sdata, sband,
 						    elems->vht_cap_elem,
 						    bss_vht_cap, link_sta);
-- 
2.39.5




