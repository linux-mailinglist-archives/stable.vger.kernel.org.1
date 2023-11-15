Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B02B7ED485
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 21:58:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344837AbjKOU6T (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 15:58:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344683AbjKOU5j (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 15:57:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B45F1985
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 12:57:28 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B750C433BB;
        Wed, 15 Nov 2023 20:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700081256;
        bh=ikwB0lo+9Wv2SnXomOKn9e5D0Hdx6g6MC5zfgcJ+yMo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NI4gFaGadJ8o91YOT/HieXS2FvDbqGS0PL4C1V+WuZmSg9LQXJzfWeoKAUEi0I3h6
         XcWZR2remNddF7PfdFspWA3LI/T3QiSqoRT4vA89E/3yWIgX7C8ElUgGGx9kdDZG9U
         BH1QOQ0Qky3MLLAL1KhsstHD9bDwbRk9sJxhcndI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Gregory Greenman <gregory.greenman@intel.com>,
        Benjamin Berg <benjamin.berg@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 044/244] wifi: iwlwifi: call napi_synchronize() before freeing rx/tx queues
Date:   Wed, 15 Nov 2023 15:33:56 -0500
Message-ID: <20231115203551.008640027@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115203548.387164783@linuxfoundation.org>
References: <20231115203548.387164783@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gregory Greenman <gregory.greenman@intel.com>

[ Upstream commit 5af2bb3168db6b0af9988eb25cccf2e3bc4455e2 ]

When rx/tx queues are being freed, on a different CPU there could be
still rx flow running. Call napi_synchronize() to prevent such a race.

Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Co-developed-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Link: https://lore.kernel.org/r/20230416154301.5171ee44dcc1.Iff18718540da412e084e7d8266447d40730600ed@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Stable-dep-of: 37fb29bd1f90 ("wifi: iwlwifi: pcie: synchronize IRQs before NAPI")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/wireless/intel/iwlwifi/pcie/internal.h |  1 +
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c   | 18 +++++++++++++++++-
 .../wireless/intel/iwlwifi/pcie/trans-gen2.c   |  1 +
 .../net/wireless/intel/iwlwifi/pcie/trans.c    |  1 +
 4 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
index 775ee03e5b128..74959de9d7002 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
@@ -480,6 +480,7 @@ int iwl_pcie_rx_stop(struct iwl_trans *trans);
 void iwl_pcie_rx_free(struct iwl_trans *trans);
 void iwl_pcie_free_rbs_pool(struct iwl_trans *trans);
 void iwl_pcie_rx_init_rxb_lists(struct iwl_rxq *rxq);
+void iwl_pcie_rx_napi_sync(struct iwl_trans *trans);
 void iwl_pcie_rxq_alloc_rbs(struct iwl_trans *trans, gfp_t priority,
 			    struct iwl_rxq *rxq);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
index 74b4280221e0f..df201d40f6c95 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2003-2014, 2018-2022 Intel Corporation
+ * Copyright (C) 2003-2014, 2018-2023 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -1050,6 +1050,22 @@ static int iwl_pcie_napi_poll_msix(struct napi_struct *napi, int budget)
 	return ret;
 }
 
+void iwl_pcie_rx_napi_sync(struct iwl_trans *trans)
+{
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+	int i;
+
+	if (unlikely(!trans_pcie->rxq))
+		return;
+
+	for (i = 0; i < trans->num_rx_queues; i++) {
+		struct iwl_rxq *rxq = &trans_pcie->rxq[i];
+
+		if (rxq && rxq->napi.poll)
+			napi_synchronize(&rxq->napi);
+	}
+}
+
 static int _iwl_pcie_rx_init(struct iwl_trans *trans)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
index a9c19be29e92e..69e2c2c98281f 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
@@ -165,6 +165,7 @@ void _iwl_trans_pcie_gen2_stop_device(struct iwl_trans *trans)
 	if (test_and_clear_bit(STATUS_DEVICE_ENABLED, &trans->status)) {
 		IWL_DEBUG_INFO(trans,
 			       "DEVICE_ENABLED bit was set and is now cleared\n");
+		iwl_pcie_rx_napi_sync(trans);
 		iwl_txq_gen2_tx_free(trans);
 		iwl_pcie_rx_stop(trans);
 	}
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 4456aef930cf4..337f26e725315 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -1197,6 +1197,7 @@ static void _iwl_trans_pcie_stop_device(struct iwl_trans *trans)
 	if (test_and_clear_bit(STATUS_DEVICE_ENABLED, &trans->status)) {
 		IWL_DEBUG_INFO(trans,
 			       "DEVICE_ENABLED bit was set and is now cleared\n");
+		iwl_pcie_rx_napi_sync(trans);
 		iwl_pcie_tx_stop(trans);
 		iwl_pcie_rx_stop(trans);
 
-- 
2.42.0



