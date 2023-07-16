Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1E0B7554F6
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232321AbjGPUfu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232318AbjGPUft (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:35:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA459F
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:35:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 695D560DD4
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:35:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D532C433C8;
        Sun, 16 Jul 2023 20:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689539747;
        bh=f8Y3PYvUpqFeAUOxRGB/dn5s4Fu5TFz+kBvif6MbHDo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WAXIAGPHgy13q6OZUlsDQWtu+pVv72mC25bg/DGyAA/kK4iKMNPVa22Vd/fNa249R
         O46c4JZy1nNXPSYSWlpLNZp8nQYJGXkAI7Tk85bt9jjERktUazPcwzXDGWUuZ4f1jn
         hJdj71ou8GWwOOsf6RVa6UTrUreB01lkZT2o5U+k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 118/591] wifi: iwlwifi: mvm: indicate HW decrypt for beacon protection
Date:   Sun, 16 Jul 2023 21:44:17 +0200
Message-ID: <20230716194926.929566950@linuxfoundation.org>
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

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 2db72b8a700943aa54dce0aabe6ff1b72b615162 ]

We've already done the 'decryption' here, so tell
mac80211 it need not do it again.

Fixes: b1fdc2505abc ("iwlwifi: mvm: advertise BIGTK client support if available")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Link: https://lore.kernel.org/r/20230620125813.a50cf68fbf2e.Ieceacbe3789d81ea02ae085ad8d1f8813a33c31b@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index 02c2a06301076..f268a31ce26d9 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -296,7 +296,8 @@ static void iwl_mvm_get_signal_strength(struct iwl_mvm *mvm,
 static int iwl_mvm_rx_mgmt_prot(struct ieee80211_sta *sta,
 				struct ieee80211_hdr *hdr,
 				struct iwl_rx_mpdu_desc *desc,
-				u32 status)
+				u32 status,
+				struct ieee80211_rx_status *stats)
 {
 	struct iwl_mvm_sta *mvmsta;
 	struct iwl_mvm_vif *mvmvif;
@@ -325,8 +326,10 @@ static int iwl_mvm_rx_mgmt_prot(struct ieee80211_sta *sta,
 
 	/* good cases */
 	if (likely(status & IWL_RX_MPDU_STATUS_MIC_OK &&
-		   !(status & IWL_RX_MPDU_STATUS_REPLAY_ERROR)))
+		   !(status & IWL_RX_MPDU_STATUS_REPLAY_ERROR))) {
+		stats->flag |= RX_FLAG_DECRYPTED;
 		return 0;
+	}
 
 	if (!sta)
 		return -1;
@@ -395,7 +398,7 @@ static int iwl_mvm_rx_crypto(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 
 	if (unlikely(ieee80211_is_mgmt(hdr->frame_control) &&
 		     !ieee80211_has_protected(hdr->frame_control)))
-		return iwl_mvm_rx_mgmt_prot(sta, hdr, desc, status);
+		return iwl_mvm_rx_mgmt_prot(sta, hdr, desc, status, stats);
 
 	if (!ieee80211_has_protected(hdr->frame_control) ||
 	    (status & IWL_RX_MPDU_STATUS_SEC_MASK) ==
-- 
2.39.2



