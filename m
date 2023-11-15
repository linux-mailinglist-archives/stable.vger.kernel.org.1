Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA9B77ED039
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235523AbjKOTxi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:53:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235521AbjKOTxh (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:53:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 595261BD
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:53:32 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C550EC433CA;
        Wed, 15 Nov 2023 19:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700078012;
        bh=2ncXf6Necq08aWDzu5rPzFoajPaiDRpzOErJy12d0qQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jeR2Kz7C88iuiZu6TqURZoH1PAPocRxZfp4d/Zph6DqUu98RpKdpK2LyFfj5/0Jio
         6P4c0JMe5RluGB5ZitByQawGubS1yGT1LK+ibEZKiRMEqjdSieuD12R3YsuzwqhOkP
         2SmJ1dVpP3uTqwJPpLKB0zh8wvd0RQQl+HhXnp4s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 030/379] wifi: iwlwifi: Use FW rate for non-data frames
Date:   Wed, 15 Nov 2023 14:21:45 -0500
Message-ID: <20231115192646.942657548@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115192645.143643130@linuxfoundation.org>
References: <20231115192645.143643130@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

[ Upstream commit 499d02790495958506a64f37ceda7e97345a50a8 ]

Currently we are setting the rate in the tx cmd for
mgmt frames (e.g. during connection establishment).
This was problematic when sending mgmt frames in eSR mode,
as we don't know what link this frame will be sent on
(This is decided by the FW), so we don't know what is the
lowest rate.
Fix this by not setting the rate in tx cmd and rely
on FW to choose the right one.
Set rate only for injected frames with fixed rate,
or when no sta is given.
Also set for important frames (EAPOL etc.) the High Priority flag.

Fixes: 055b22e770dd ("iwlwifi: mvm: Set Tx rate and flags when there is not station")
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Link: https://lore.kernel.org/r/20230913145231.6c7e59620ee0.I6eaed3ccdd6dd62b9e664facc484081fc5275843@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index 2d01f6226b7c6..9804112ea4f79 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -524,16 +524,20 @@ iwl_mvm_set_tx_params(struct iwl_mvm *mvm, struct sk_buff *skb,
 			flags |= IWL_TX_FLAGS_ENCRYPT_DIS;
 
 		/*
-		 * For data packets rate info comes from the fw. Only
-		 * set rate/antenna during connection establishment or in case
-		 * no station is given.
+		 * For data and mgmt packets rate info comes from the fw. Only
+		 * set rate/antenna for injected frames with fixed rate, or
+		 * when no sta is given.
 		 */
-		if (!sta || !ieee80211_is_data(hdr->frame_control) ||
-		    mvmsta->sta_state < IEEE80211_STA_AUTHORIZED) {
+		if (unlikely(!sta ||
+			     info->control.flags & IEEE80211_TX_CTRL_RATE_INJECT)) {
 			flags |= IWL_TX_FLAGS_CMD_RATE;
 			rate_n_flags =
 				iwl_mvm_get_tx_rate_n_flags(mvm, info, sta,
 							    hdr->frame_control);
+		} else if (!ieee80211_is_data(hdr->frame_control) ||
+			   mvmsta->sta_state < IEEE80211_STA_AUTHORIZED) {
+			/* These are important frames */
+			flags |= IWL_TX_FLAGS_HIGH_PRI;
 		}
 
 		if (mvm->trans->trans_cfg->device_family >=
-- 
2.42.0



