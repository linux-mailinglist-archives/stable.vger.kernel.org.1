Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19E5A7B877A
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243799AbjJDSFt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243800AbjJDSFt (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:05:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BBBAA6
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:05:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5503FC433C8;
        Wed,  4 Oct 2023 18:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696442744;
        bh=1353e5wBrFiCtZQzqQoqS5XC6HURudgldN+GGyx/3h4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kYaR5VW4CHoUPdsRN6gFpWs2M5pHvKUivOwrBvFVbgNoUZ22cYwy6BSCtKxtPmHIl
         TpQ6EfS9PVy7gy59VRDgG3cwDhTGDpDoV+4Jenv5GhskH1Wyl5XiQUk80nHBMNGSdU
         cdc0PGAEk9laW9rnvQM0UiuhYIIBkz5OkXlR07AE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>,
        Naama Meir <naamax.meir@linux.intel.com>,
        Simon Horman <horms@kernel.org>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 066/183] igc: Expose tx-usecs coalesce setting to user
Date:   Wed,  4 Oct 2023 19:54:57 +0200
Message-ID: <20231004175206.627008691@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175203.943277832@linuxfoundation.org>
References: <20231004175203.943277832@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>

[ Upstream commit 1703b2e0de653b459ca6230be32ce7f2ea0ae7ee ]

When users attempt to obtain the coalesce setting using the
ethtool command, current code always returns 0 for tx-usecs.
This is because I225/6 always uses a queue pair setting, hence
tx_coalesce_usecs does not return a value during the
igc_ethtool_get_coalesce() callback process. The pair queue
condition checking in igc_ethtool_get_coalesce() is removed by
this patch so that the user gets information of the value of tx-usecs.

Even if i225/6 is using queue pair setting, there is no harm in
notifying the user of the tx-usecs. The implementation of the current
code may have previously been a copy of the legacy code i210.
Since I225 has the queue pair setting enabled, tx-usecs will always adhere
to the user-set rx-usecs value. An error message will appear when the user
attempts to set the tx-usecs value for the input parameters because,
by default, they should only set the rx-usecs value.

This patch also adds the helper function to get the
previous rx coalesce value similar to tx coalesce.

How to test:
User can get the coalesce value using ethtool command.

Example command:
Get: ethtool -c <interface>

Previous output:

rx-usecs: 3
rx-frames: n/a
rx-usecs-irq: n/a
rx-frames-irq: n/a

tx-usecs: 0
tx-frames: n/a
tx-usecs-irq: n/a
tx-frames-irq: n/a

New output:

rx-usecs: 3
rx-frames: n/a
rx-usecs-irq: n/a
rx-frames-irq: n/a

tx-usecs: 3
tx-frames: n/a
tx-usecs-irq: n/a
tx-frames-irq: n/a

Fixes: 8c5ad0dae93c ("igc: Add ethtool support")
Signed-off-by: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
Tested-by: Naama Meir <naamax.meir@linux.intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Link: https://lore.kernel.org/r/20230919170331.1581031-1-anthony.l.nguyen@intel.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/igc/igc_ethtool.c | 31 ++++++++++++--------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
index 859ddc07fbbfe..17cb4c13d0020 100644
--- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
+++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
@@ -861,6 +861,18 @@ static void igc_ethtool_get_stats(struct net_device *netdev,
 	spin_unlock(&adapter->stats64_lock);
 }
 
+static int igc_ethtool_get_previous_rx_coalesce(struct igc_adapter *adapter)
+{
+	return (adapter->rx_itr_setting <= 3) ?
+		adapter->rx_itr_setting : adapter->rx_itr_setting >> 2;
+}
+
+static int igc_ethtool_get_previous_tx_coalesce(struct igc_adapter *adapter)
+{
+	return (adapter->tx_itr_setting <= 3) ?
+		adapter->tx_itr_setting : adapter->tx_itr_setting >> 2;
+}
+
 static int igc_ethtool_get_coalesce(struct net_device *netdev,
 				    struct ethtool_coalesce *ec,
 				    struct kernel_ethtool_coalesce *kernel_coal,
@@ -868,17 +880,8 @@ static int igc_ethtool_get_coalesce(struct net_device *netdev,
 {
 	struct igc_adapter *adapter = netdev_priv(netdev);
 
-	if (adapter->rx_itr_setting <= 3)
-		ec->rx_coalesce_usecs = adapter->rx_itr_setting;
-	else
-		ec->rx_coalesce_usecs = adapter->rx_itr_setting >> 2;
-
-	if (!(adapter->flags & IGC_FLAG_QUEUE_PAIRS)) {
-		if (adapter->tx_itr_setting <= 3)
-			ec->tx_coalesce_usecs = adapter->tx_itr_setting;
-		else
-			ec->tx_coalesce_usecs = adapter->tx_itr_setting >> 2;
-	}
+	ec->rx_coalesce_usecs = igc_ethtool_get_previous_rx_coalesce(adapter);
+	ec->tx_coalesce_usecs = igc_ethtool_get_previous_tx_coalesce(adapter);
 
 	return 0;
 }
@@ -903,8 +906,12 @@ static int igc_ethtool_set_coalesce(struct net_device *netdev,
 	    ec->tx_coalesce_usecs == 2)
 		return -EINVAL;
 
-	if ((adapter->flags & IGC_FLAG_QUEUE_PAIRS) && ec->tx_coalesce_usecs)
+	if ((adapter->flags & IGC_FLAG_QUEUE_PAIRS) &&
+	    ec->tx_coalesce_usecs != igc_ethtool_get_previous_tx_coalesce(adapter)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Queue Pair mode enabled, both Rx and Tx coalescing controlled by rx-usecs");
 		return -EINVAL;
+	}
 
 	/* If ITR is disabled, disable DMAC */
 	if (ec->rx_coalesce_usecs == 0) {
-- 
2.40.1



