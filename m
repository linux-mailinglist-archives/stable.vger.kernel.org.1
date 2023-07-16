Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A552775550A
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232347AbjGPUgx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232360AbjGPUgw (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:36:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80457E78
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:36:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A11CA60EBD
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:36:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B13EFC433C7;
        Sun, 16 Jul 2023 20:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689539801;
        bh=oFFKqr2oZ5mp+C5sEL+TV3fd/44qwTT00JsVd85esgE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MdYtLm3Bq9uN4i8ADpX9AOmyx5fMoHSidNrlgBAWixsNukfX0bRbDAkuL1xTbZkLk
         /+vol8dLMbQfg5maVKISW6Bw+S3Iyl0zzHSRaejCeDJL1u5Ysp4q0seRhNgiPxBl7E
         R3GznOU3YUmjPk2Ohw8mD38knDY/nows/SVlUCS0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 110/591] wifi: iwlwifi: pcie: fix NULL pointer dereference in iwl_pcie_irq_rx_msix_handler()
Date:   Sun, 16 Jul 2023 21:44:09 +0200
Message-ID: <20230716194926.726960032@linuxfoundation.org>
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
index 9c9f87fe83777..b455e981faa1f 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
@@ -1620,14 +1620,14 @@ irqreturn_t iwl_pcie_irq_rx_msix_handler(int irq, void *dev_id)
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
@@ -1635,6 +1635,7 @@ irqreturn_t iwl_pcie_irq_rx_msix_handler(int irq, void *dev_id)
 		return IRQ_NONE;
 	}
 
+	rxq = &trans_pcie->rxq[entry->entry];
 	lock_map_acquire(&trans->sync_cmd_lockdep_map);
 	IWL_DEBUG_ISR(trans, "[%d] Got interrupt\n", entry->entry);
 
-- 
2.39.2



