Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99A6B7613F4
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234233AbjGYLPS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234239AbjGYLPD (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:15:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8482E1BF8
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:14:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 177AD6168F
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:14:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AF4BC433C9;
        Tue, 25 Jul 2023 11:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690283654;
        bh=xo7OTRTNWpR6y8jVqlhAQlnaqM2FnjxTANRKD7qHSkA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1zMm0mQCujD+7ddfcN3oeNbqnIqL6Sq+B3V/q6dMQYQXg60GBzW2rvcV2ccueIm5o
         DxjO3mYTpLiplTqIAO7igT56JZLAyleEATI+SOlPXy286B0PLambWr+cx1n7L4vmTf
         lC71px7P7S/QmjMcxeFnR4DPeDNNCImkbk2SQYQw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 075/509] wifi: iwlwifi: pull from TXQs with softirqs disabled
Date:   Tue, 25 Jul 2023 12:40:14 +0200
Message-ID: <20230725104557.134756134@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104553.588743331@linuxfoundation.org>
References: <20230725104553.588743331@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 96fb6f47db24a712d650b0a9b9074873f273fb0e ]

In mac80211, it's required that we pull from TXQs by calling
ieee80211_tx_dequeue() only with softirqs disabled. However,
in iwl_mvm_queue_state_change() we're often called with them
enabled, e.g. from flush if anything was flushed, triggering
a mac80211 warning.

Fix that by disabling the softirqs across the TX call.

Fixes: cfbc6c4c5b91 ("iwlwifi: mvm: support mac80211 TXQs model")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Link: https://lore.kernel.org/r/20230614123446.0feef7fa81db.I4dd62542d955b40dd8f0af34fa4accb9d0d17c7e@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 7c61d179895b3..5b173f21e87bf 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -1174,8 +1174,11 @@ static void iwl_mvm_queue_state_change(struct iwl_op_mode *op_mode,
 		mvmtxq = iwl_mvm_txq_from_mac80211(txq);
 		mvmtxq->stopped = !start;
 
-		if (start && mvmsta->sta_state != IEEE80211_STA_NOTEXIST)
+		if (start && mvmsta->sta_state != IEEE80211_STA_NOTEXIST) {
+			local_bh_disable();
 			iwl_mvm_mac_itxq_xmit(mvm->hw, txq);
+			local_bh_enable();
+		}
 	}
 
 out:
-- 
2.39.2



