Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA057D347A
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234248AbjJWLkC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233678AbjJWLkB (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:40:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8643E4
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:39:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05796C433C7;
        Mon, 23 Oct 2023 11:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698061199;
        bh=Ei0TWvd0Nh3lCNlmezKgWdah7thm0FOr/mcr3hfh4Pc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g6vN0QFF5Q0qMYzwvj1HgfwfFUE7+/vAx7EcF5MKhhDXyKJY/EHtV5/N+RGTuUPYK
         sSOgDjz5+FQRyntpnE0MYDTL++UGkAfJX2TaItYn3g7IHJU7CmO3PN4yPVJr9XLCm1
         h2IgyHCY5GbXpcUBnsROalR1EN+d2iUEdA4XhlJ4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ben Greear <greearb@candelatech.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 079/137] wifi: iwlwifi: Ensure ack flag is properly cleared.
Date:   Mon, 23 Oct 2023 12:57:16 +0200
Message-ID: <20231023104823.580148196@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104820.849461819@linuxfoundation.org>
References: <20231023104820.849461819@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ben Greear <greearb@candelatech.com>

[ Upstream commit e8fbe99e87877f0412655f40d7c45bf8471470ac ]

Debugging indicates that nothing else is clearing the info->flags,
so some frames were flagged as ACKed when they should not be.
Explicitly clear the ack flag to ensure this does not happen.

Signed-off-by: Ben Greear <greearb@candelatech.com>
Acked-by: Gregory Greenman <gregory.greenman@intel.com>
Link: https://lore.kernel.org/r/20230808205605.4105670-1-greearb@candelatech.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index e354918c2480f..b127e0b527ce0 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -1445,6 +1445,7 @@ static void iwl_mvm_rx_tx_cmd_single(struct iwl_mvm *mvm,
 		iwl_trans_free_tx_cmd(mvm->trans, info->driver_data[1]);
 
 		memset(&info->status, 0, sizeof(info->status));
+		info->flags &= ~(IEEE80211_TX_STAT_ACK | IEEE80211_TX_STAT_TX_FILTERED);
 
 		/* inform mac80211 about what happened with the frame */
 		switch (status & TX_STATUS_MSK) {
@@ -1790,6 +1791,8 @@ static void iwl_mvm_tx_reclaim(struct iwl_mvm *mvm, int sta_id, int tid,
 		 */
 		if (!is_flush)
 			info->flags |= IEEE80211_TX_STAT_ACK;
+		else
+			info->flags &= ~IEEE80211_TX_STAT_ACK;
 	}
 
 	/*
-- 
2.40.1



