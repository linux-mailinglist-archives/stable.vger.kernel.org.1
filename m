Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 353A5719E10
	for <lists+stable@lfdr.de>; Thu,  1 Jun 2023 15:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234022AbjFAN3B (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 1 Jun 2023 09:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234024AbjFAN2e (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Jun 2023 09:28:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 380351BB
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 06:28:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 17C61644E8
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 13:28:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3031EC433EF;
        Thu,  1 Jun 2023 13:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685626093;
        bh=UChNkqQE+/dLPtilGfx/6WXO9kjSmsnKssmUUzMETQ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i/SC2yx+9kRK2WiL29LWHTh85BKoRdNbMlKG7c2ly+LbxvCY1q+NOSFuaB5IGWWE+
         rF+5Il62BSCF53eimdtCVDKy3AANEnyzLRMl1G5PSmt+uHCH7AgFcisy31jCaC1pBZ
         JrfTQtaUh6pqSi5c37wIvAmfpTgsKXlDUZNqWpWM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Haim Dreyfuss <haim.dreyfuss@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 28/42] wifi: iwlwifi: mvm: support wowlan info notification version 2
Date:   Thu,  1 Jun 2023 14:21:37 +0100
Message-Id: <20230601131940.270648613@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601131939.051934720@linuxfoundation.org>
References: <20230601131939.051934720@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Haim Dreyfuss <haim.dreyfuss@intel.com>

[ Upstream commit 905d50ddbc83bef0d7f3386e7f3472b0324b405b ]

As part of version 2 we don't need to have wake_packet_bufsize
and wake_packet_length. The first one is already calculated by the driver,
the latter is sent as part of the wake packet notification.

Signed-off-by: Haim Dreyfuss <haim.dreyfuss@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Link: https://lore.kernel.org/r/20230413213309.3b53213b10d4.Ibf2f15aca614def2d262dd267d1aad65931b58f1@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Stable-dep-of: 457d7fb03e6c ("wifi: iwlwifi: mvm: fix potential memory leak")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/wireless/intel/iwlwifi/fw/api/d3.h    | 37 ++++++++++++++++++-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   | 35 +++++++++++++++++-
 2 files changed, 69 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h b/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h
index df0833890e55a..8a613e150a024 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h
@@ -767,7 +767,7 @@ struct iwl_wowlan_status_v12 {
 } __packed; /* WOWLAN_STATUSES_RSP_API_S_VER_12 */
 
 /**
- * struct iwl_wowlan_info_notif - WoWLAN information notification
+ * struct iwl_wowlan_info_notif_v1 - WoWLAN information notification
  * @gtk: GTK data
  * @igtk: IGTK data
  * @replay_ctr: GTK rekey replay counter
@@ -785,7 +785,7 @@ struct iwl_wowlan_status_v12 {
  * @station_id: station id
  * @reserved2: reserved
  */
-struct iwl_wowlan_info_notif {
+struct iwl_wowlan_info_notif_v1 {
 	struct iwl_wowlan_gtk_status_v3 gtk[WOWLAN_GTK_KEYS_NUM];
 	struct iwl_wowlan_igtk_status igtk[WOWLAN_IGTK_KEYS_NUM];
 	__le64 replay_ctr;
@@ -803,6 +803,39 @@ struct iwl_wowlan_info_notif {
 	u8 reserved2[2];
 } __packed; /* WOWLAN_INFO_NTFY_API_S_VER_1 */
 
+/**
+ * struct iwl_wowlan_info_notif - WoWLAN information notification
+ * @gtk: GTK data
+ * @igtk: IGTK data
+ * @replay_ctr: GTK rekey replay counter
+ * @pattern_number: number of the matched patterns
+ * @reserved1: reserved
+ * @qos_seq_ctr: QoS sequence counters to use next
+ * @wakeup_reasons: wakeup reasons, see &enum iwl_wowlan_wakeup_reason
+ * @num_of_gtk_rekeys: number of GTK rekeys
+ * @transmitted_ndps: number of transmitted neighbor discovery packets
+ * @received_beacons: number of received beacons
+ * @tid_tear_down: bit mask of tids whose BA sessions were closed
+ *	in suspend state
+ * @station_id: station id
+ * @reserved2: reserved
+ */
+struct iwl_wowlan_info_notif {
+	struct iwl_wowlan_gtk_status_v3 gtk[WOWLAN_GTK_KEYS_NUM];
+	struct iwl_wowlan_igtk_status igtk[WOWLAN_IGTK_KEYS_NUM];
+	__le64 replay_ctr;
+	__le16 pattern_number;
+	__le16 reserved1;
+	__le16 qos_seq_ctr[8];
+	__le32 wakeup_reasons;
+	__le32 num_of_gtk_rekeys;
+	__le32 transmitted_ndps;
+	__le32 received_beacons;
+	u8 tid_tear_down;
+	u8 station_id;
+	u8 reserved2[2];
+} __packed; /* WOWLAN_INFO_NTFY_API_S_VER_2 */
+
 /**
  * struct iwl_wowlan_wake_pkt_notif - WoWLAN wake packet notification
  * @wake_packet_length: wakeup packet length
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index bbdda3e1ff3fc..0253dedb9b71a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -2011,6 +2011,12 @@ static void iwl_mvm_parse_wowlan_info_notif(struct iwl_mvm *mvm,
 {
 	u32 i;
 
+	if (!data) {
+		IWL_ERR(mvm, "iwl_wowlan_info_notif data is NULL\n");
+		status = NULL;
+		return;
+	}
+
 	if (len < sizeof(*data)) {
 		IWL_ERR(mvm, "Invalid WoWLAN info notification!\n");
 		status = NULL;
@@ -2698,10 +2704,33 @@ static bool iwl_mvm_wait_d3_notif(struct iwl_notif_wait_data *notif_wait,
 	struct iwl_d3_data *d3_data = data;
 	u32 len;
 	int ret;
+	int wowlan_info_ver = iwl_fw_lookup_notif_ver(mvm->fw,
+						      PROT_OFFLOAD_GROUP,
+						      WOWLAN_INFO_NOTIFICATION,
+						      IWL_FW_CMD_VER_UNKNOWN);
+
 
 	switch (WIDE_ID(pkt->hdr.group_id, pkt->hdr.cmd)) {
 	case WIDE_ID(PROT_OFFLOAD_GROUP, WOWLAN_INFO_NOTIFICATION): {
-		struct iwl_wowlan_info_notif *notif = (void *)pkt->data;
+		struct iwl_wowlan_info_notif *notif;
+
+		if (wowlan_info_ver < 2) {
+			struct iwl_wowlan_info_notif_v1 *notif_v1 = (void *)pkt->data;
+
+			notif = kmemdup(notif_v1,
+					offsetofend(struct iwl_wowlan_info_notif,
+						    received_beacons),
+					GFP_ATOMIC);
+
+			if (!notif)
+				return false;
+
+			notif->tid_tear_down = notif_v1->tid_tear_down;
+			notif->station_id = notif_v1->station_id;
+
+		} else {
+			notif = (void *)pkt->data;
+		}
 
 		if (d3_data->notif_received & IWL_D3_NOTIF_WOWLAN_INFO) {
 			/* We might get two notifications due to dual bss */
@@ -2714,6 +2743,10 @@ static bool iwl_mvm_wait_d3_notif(struct iwl_notif_wait_data *notif_wait,
 		len = iwl_rx_packet_payload_len(pkt);
 		iwl_mvm_parse_wowlan_info_notif(mvm, notif, d3_data->status,
 						len);
+
+		if (wowlan_info_ver < 2)
+			kfree(notif);
+
 		if (d3_data->status &&
 		    d3_data->status->wakeup_reasons & IWL_WOWLAN_WAKEUP_REASON_HAS_WAKEUP_PKT)
 			/* We are supposed to get also wake packet notif */
-- 
2.39.2



