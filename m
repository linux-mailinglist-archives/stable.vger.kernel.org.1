Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8F9734BE7
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 08:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjFSGyV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 02:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjFSGyV (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 02:54:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09C5AC6
        for <stable@vger.kernel.org>; Sun, 18 Jun 2023 23:54:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9AFC2614D6
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 06:54:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 879BBC433C0;
        Mon, 19 Jun 2023 06:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687157659;
        bh=ip78dtoFW7RN/OFb/B+EorKL7Y/lgjX4yVsnOG8B6oI=;
        h=Subject:To:Cc:From:Date:From;
        b=saxEuO0WXuid+ZmQKi4/u+J2br3HlYUvJfutIqVcFdOurv0Cv7H9kTuEELZ+VThjo
         us8eypE6m7ZzQAuLytnKJlo9VdBgi97U8vh7E29h/QKbebST2WAAsG1UHRGzAxOWGc
         uxqRRPQZl/I2G3Gs1lCv3uwNH3KR2bEjm3vXwRIw=
Subject: FAILED: patch "[PATCH] wifi: iwlwifi: mvm: spin_lock_bh() to fix lockdep regression" failed to apply to 6.1-stable tree
To:     hughd@google.com, johannes.berg@intel.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Mon, 19 Jun 2023 08:54:07 +0200
Message-ID: <2023061907-salami-everyday-f129@gregkh>
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


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x f1a0898b5d6a77d332d036da03bad6fa9770de5b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023061907-salami-everyday-f129@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f1a0898b5d6a77d332d036da03bad6fa9770de5b Mon Sep 17 00:00:00 2001
From: Hugh Dickins <hughd@google.com>
Date: Fri, 9 Jun 2023 14:29:39 -0700
Subject: [PATCH] wifi: iwlwifi: mvm: spin_lock_bh() to fix lockdep regression

Lockdep on 6.4-rc on ThinkPad X1 Carbon 5th says
=====================================================
WARNING: SOFTIRQ-safe -> SOFTIRQ-unsafe lock order detected
6.4.0-rc5 #1 Not tainted
-----------------------------------------------------
kworker/3:1/49 [HC0[0]:SC0[4]:HE1:SE0] is trying to acquire:
ffff8881066fa368 (&mvm_sta->deflink.lq_sta.rs_drv.pers.lock){+.+.}-{2:2}, at: rs_drv_get_rate+0x46/0xe7

and this task is already holding:
ffff8881066f80a8 (&sta->rate_ctrl_lock){+.-.}-{2:2}, at: rate_control_get_rate+0xbd/0x126
which would create a new lock dependency:
 (&sta->rate_ctrl_lock){+.-.}-{2:2} -> (&mvm_sta->deflink.lq_sta.rs_drv.pers.lock){+.+.}-{2:2}

but this new dependency connects a SOFTIRQ-irq-safe lock:
 (&sta->rate_ctrl_lock){+.-.}-{2:2}
etc. etc. etc.

Changing the spin_lock() in rs_drv_get_rate() to spin_lock_bh() was not
enough to pacify lockdep, but changing them all on pers.lock has worked.

Fixes: a8938bc881d2 ("wifi: iwlwifi: mvm: Add locking to the rate read flow")
Signed-off-by: Hugh Dickins <hughd@google.com>
Link: https://lore.kernel.org/r/79ffcc22-9775-cb6d-3ffd-1a517c40beef@google.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs.c b/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
index 23266d0c9ce4..9a20468345e4 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
@@ -2692,7 +2692,7 @@ static void rs_drv_get_rate(void *mvm_r, struct ieee80211_sta *sta,
 
 	lq_sta = mvm_sta;
 
-	spin_lock(&lq_sta->pers.lock);
+	spin_lock_bh(&lq_sta->pers.lock);
 	iwl_mvm_hwrate_to_tx_rate_v1(lq_sta->last_rate_n_flags,
 				     info->band, &info->control.rates[0]);
 	info->control.rates[0].count = 1;
@@ -2707,7 +2707,7 @@ static void rs_drv_get_rate(void *mvm_r, struct ieee80211_sta *sta,
 		iwl_mvm_hwrate_to_tx_rate_v1(last_ucode_rate, info->band,
 					     &txrc->reported_rate);
 	}
-	spin_unlock(&lq_sta->pers.lock);
+	spin_unlock_bh(&lq_sta->pers.lock);
 }
 
 static void *rs_drv_alloc_sta(void *mvm_rate, struct ieee80211_sta *sta,
@@ -3264,11 +3264,11 @@ void iwl_mvm_rs_tx_status(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 	/* If it's locked we are in middle of init flow
 	 * just wait for next tx status to update the lq_sta data
 	 */
-	if (!spin_trylock(&mvmsta->deflink.lq_sta.rs_drv.pers.lock))
+	if (!spin_trylock_bh(&mvmsta->deflink.lq_sta.rs_drv.pers.lock))
 		return;
 
 	__iwl_mvm_rs_tx_status(mvm, sta, tid, info, ndp);
-	spin_unlock(&mvmsta->deflink.lq_sta.rs_drv.pers.lock);
+	spin_unlock_bh(&mvmsta->deflink.lq_sta.rs_drv.pers.lock);
 }
 
 #ifdef CONFIG_MAC80211_DEBUGFS
@@ -4117,9 +4117,9 @@ void iwl_mvm_rs_rate_init(struct iwl_mvm *mvm,
 	} else {
 		struct iwl_mvm_sta *mvmsta = iwl_mvm_sta_from_mac80211(sta);
 
-		spin_lock(&mvmsta->deflink.lq_sta.rs_drv.pers.lock);
+		spin_lock_bh(&mvmsta->deflink.lq_sta.rs_drv.pers.lock);
 		rs_drv_rate_init(mvm, sta, band);
-		spin_unlock(&mvmsta->deflink.lq_sta.rs_drv.pers.lock);
+		spin_unlock_bh(&mvmsta->deflink.lq_sta.rs_drv.pers.lock);
 	}
 }
 

