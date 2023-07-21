Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5183975D212
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 20:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbjGUSzx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 14:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231312AbjGUSzw (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 14:55:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 348D730E4
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 11:55:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E39861D85
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 18:55:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EB4EC433C8;
        Fri, 21 Jul 2023 18:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689965740;
        bh=kK43EC7XdeOhgPvhdYZXvcb1/bicAJ/QdHp6T1+MB6A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F/Hkg4AJpDcLKSkVmcdlswRSZMSckeQjcGFYcIGZeOfhRDmoJqRBk8UPrTYFKhQoJ
         c/xoVOW90jHUHMefPvcQjuMYa0LMkE4g18lp/88eTA8rXNFoguoeoUOAVYf8wsGXxI
         FtddNl8nZdrMc4XgXeg8IYYVWdF9IjIvgC9TilSg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 070/532] wifi: iwlwifi: pcie: fix NULL pointer dereference in iwl_pcie_irq_rx_msix_handler()
Date:   Fri, 21 Jul 2023 17:59:34 +0200
Message-ID: <20230721160618.412727127@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160614.695323302@linuxfoundation.org>
References: <20230721160614.695323302@linuxfoundation.org>
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

From: Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>

[ Upstream commit 1902f1953b8ba100ee8705cb8a6f1a9795550eca ]

rxq can be NULL only when trans_pcie->rxq is NULL and entry->entry
is zero. For the case when entry->entry is not equal to 0, rxq
won't be NULL even if trans_pcie->rxq is NULL. Modify checker to
check for trans_pcie->rxq.

Fixes: abc599efa67b ("iwlwifi: pcie: don't crash when rx queues aren't allocated in interrupt")
Signed-off-by: Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Link: https://lore.kernel.org/r/20230614123446.5a5eb3889a4a.I375a1d58f16b48cd2044e7b7caddae512d7c86fd@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
index 8885b19fd8de6..6c6512158813b 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
@@ -1601,14 +1601,14 @@ irqreturn_t iwl_pcie_irq_rx_msix_handler(int irq, void *dev_id)
 	struct msix_entry *entry = dev_id;
 	struct iwl_trans_pcie *trans_pcie = iwl_pcie_get_trans_pcie(entry);
 	struct iwl_trans *trans = trans_pcie->trans;
-	struct iwl_rxq *rxq = &trans_pcie->rxq[entry->entry];
+	struct iwl_rxq *rxq;
 
 	trace_iwlwifi_dev_irq_msix(trans->dev, entry, false, 0, 0);
 
 	if (WARN_ON(entry->entry >= trans->num_rx_queues))
 		return IRQ_NONE;
 
-	if (!rxq) {
+	if (!trans_pcie->rxq) {
 		if (net_ratelimit())
 			IWL_ERR(trans,
 				"[%d] Got MSI-X interrupt before we have Rx queues\n",
@@ -1616,6 +1616,7 @@ irqreturn_t iwl_pcie_irq_rx_msix_handler(int irq, void *dev_id)
 		return IRQ_NONE;
 	}
 
+	rxq = &trans_pcie->rxq[entry->entry];
 	lock_map_acquire(&trans->sync_cmd_lockdep_map);
 	IWL_DEBUG_ISR(trans, "[%d] Got interrupt\n", entry->entry);
 
-- 
2.39.2



