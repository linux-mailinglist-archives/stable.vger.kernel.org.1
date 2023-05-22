Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52CBF70C9A6
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233430AbjEVTu2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235395AbjEVTtx (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:49:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 446C610C
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:49:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C8BA662AE6
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:49:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3CDFC433D2;
        Mon, 22 May 2023 19:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684784990;
        bh=AjGunEb8jLvW0Wi7PFoQzm/F9Uuz5nIwtBhuuH+hWdQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CK0X9M9m82DxqQcRG/ae2yUS6DWHCqJ8zYyfEaR/2f/DqPhqv14HnpB9wOk9nR2PE
         Nm3qAeDf2xgV/cvM0Ig8qkswKZ4QkGOSNSLl3n4IxAEK4mUVIrsF3b8jS34yUKTkRa
         X+Zo/wq2shk0AUCgX89r+5mQnYV4r3lqHQd7vDvw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 271/364] wifi: iwlwifi: mvm: fix cancel_delayed_work_sync() deadlock
Date:   Mon, 22 May 2023 20:09:36 +0100
Message-Id: <20230522190419.489875622@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190412.801391872@linuxfoundation.org>
References: <20230522190412.801391872@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit c2d8b7f257b2398f2d866205365895e038beca12 ]

Lockdep points out that we can deadlock here by calling
cancel_delayed_work_sync() because that might be already
running and gotten interrupted by the NAPI soft-IRQ.
Even just calling something that can sleep is wrong in
this context though.

Luckily, it doesn't even really matter since the things
we need to do are idempotent, so just drop the _sync().

Fixes: e5d153ec54f0 ("iwlwifi: mvm: fix CSA AP side")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Link: https://lore.kernel.org/r/20230514120631.b1813c823b4d.I9d20cc06d24fa40b6774d3dd95ea5e2bf8dd015b@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index e685113172c52..ad410b6efce73 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -1967,7 +1967,7 @@ void iwl_mvm_rx_mpdu_mq(struct iwl_mvm *mvm, struct napi_struct *napi,
 				RCU_INIT_POINTER(mvm->csa_tx_blocked_vif, NULL);
 				/* Unblock BCAST / MCAST station */
 				iwl_mvm_modify_all_sta_disable_tx(mvm, mvmvif, false);
-				cancel_delayed_work_sync(&mvm->cs_tx_unblock_dwork);
+				cancel_delayed_work(&mvm->cs_tx_unblock_dwork);
 			}
 		}
 
-- 
2.39.2



