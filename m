Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3D8476121B
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 12:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233801AbjGYK7k (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 06:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233571AbjGYK64 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 06:58:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6842F46B0
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 03:56:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 01D5961655
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 10:56:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CECCCC433C9;
        Tue, 25 Jul 2023 10:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690282561;
        bh=eJx2gVsIr7yffJtP12Ay1lX7wLAu718kf5eRI4TYVmg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U/GdLojLN6s6iT0WCnnLOgyerWL/1+41KQxDGfnN00CJuNsqiLbRH9Re1XxCssg2H
         3mR3BXy8Yv064Su1bYKK611ysHky2enn8RaxwrXRNQHjbPGXG9BPjM3GAmYw16uDKY
         /QzCQhNS6GuA2XvhXBaQSj6jnL+JtshEAZIlmO7Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Marcin Szycik <marcin.szycik@linux.intel.com>,
        Dawid Wesierski <dawidx.wesierski@intel.com>,
        Sylwester Dziedziuch <sylwesterx.dziedziuch@intel.com>,
        Kamil Maziarz <kamil.maziarz@intel.com>,
        Mateusz Palczewski <mateusz.palczewski@intel.com>,
        Rafal Romanowski <rafal.romanowski@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 174/227] iavf: Wait for reset in callbacks which trigger it
Date:   Tue, 25 Jul 2023 12:45:41 +0200
Message-ID: <20230725104522.072929915@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104514.821564989@linuxfoundation.org>
References: <20230725104514.821564989@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Marcin Szycik <marcin.szycik@linux.intel.com>

[ Upstream commit c2ed2403f12c74a74a0091ed5d830e72c58406e8 ]

There was a fail when trying to add the interface to bonding
right after changing the MTU on the interface. It was caused
by bonding interface unable to open the interface due to
interface being in __RESETTING state because of MTU change.

Add new reset_waitqueue to indicate that reset has finished.

Add waiting for reset to finish in callbacks which trigger hw reset:
iavf_set_priv_flags(), iavf_change_mtu() and iavf_set_ringparam().
We use a 5000ms timeout period because on Hyper-V based systems,
this operation takes around 3000-4000ms. In normal circumstances,
it doesn't take more than 500ms to complete.

Add a function iavf_wait_for_reset() to reuse waiting for reset code and
use it also in iavf_set_channels(), which already waits for reset.
We don't use error handling in iavf_set_channels() as this could
cause the device to be in incorrect state if the reset was scheduled
but hit timeout or the waitng function was interrupted by a signal.

Fixes: 4e5e6b5d9d13 ("iavf: Fix return of set the new channel count")
Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Co-developed-by: Dawid Wesierski <dawidx.wesierski@intel.com>
Signed-off-by: Dawid Wesierski <dawidx.wesierski@intel.com>
Signed-off-by: Sylwester Dziedziuch <sylwesterx.dziedziuch@intel.com>
Signed-off-by: Kamil Maziarz <kamil.maziarz@intel.com>
Signed-off-by: Mateusz Palczewski <mateusz.palczewski@intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/iavf/iavf.h        |  2 +
 .../net/ethernet/intel/iavf/iavf_ethtool.c    | 31 ++++++-----
 drivers/net/ethernet/intel/iavf/iavf_main.c   | 51 ++++++++++++++++++-
 .../net/ethernet/intel/iavf/iavf_virtchnl.c   |  1 +
 4 files changed, 68 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf.h b/drivers/net/ethernet/intel/iavf/iavf.h
index f80f2735e6886..a5cab19eb6a8b 100644
--- a/drivers/net/ethernet/intel/iavf/iavf.h
+++ b/drivers/net/ethernet/intel/iavf/iavf.h
@@ -257,6 +257,7 @@ struct iavf_adapter {
 	struct work_struct adminq_task;
 	struct delayed_work client_task;
 	wait_queue_head_t down_waitqueue;
+	wait_queue_head_t reset_waitqueue;
 	wait_queue_head_t vc_waitqueue;
 	struct iavf_q_vector *q_vectors;
 	struct list_head vlan_filter_list;
@@ -582,4 +583,5 @@ void iavf_add_adv_rss_cfg(struct iavf_adapter *adapter);
 void iavf_del_adv_rss_cfg(struct iavf_adapter *adapter);
 struct iavf_mac_filter *iavf_add_filter(struct iavf_adapter *adapter,
 					const u8 *macaddr);
+int iavf_wait_for_reset(struct iavf_adapter *adapter);
 #endif /* _IAVF_H_ */
diff --git a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
index 92443f8e9fbdf..b7141c2a941d1 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
@@ -484,6 +484,7 @@ static int iavf_set_priv_flags(struct net_device *netdev, u32 flags)
 {
 	struct iavf_adapter *adapter = netdev_priv(netdev);
 	u32 orig_flags, new_flags, changed_flags;
+	int ret = 0;
 	u32 i;
 
 	orig_flags = READ_ONCE(adapter->flags);
@@ -533,10 +534,13 @@ static int iavf_set_priv_flags(struct net_device *netdev, u32 flags)
 		if (netif_running(netdev)) {
 			adapter->flags |= IAVF_FLAG_RESET_NEEDED;
 			queue_work(adapter->wq, &adapter->reset_task);
+			ret = iavf_wait_for_reset(adapter);
+			if (ret)
+				netdev_warn(netdev, "Changing private flags timeout or interrupted waiting for reset");
 		}
 	}
 
-	return 0;
+	return ret;
 }
 
 /**
@@ -627,6 +631,7 @@ static int iavf_set_ringparam(struct net_device *netdev,
 {
 	struct iavf_adapter *adapter = netdev_priv(netdev);
 	u32 new_rx_count, new_tx_count;
+	int ret = 0;
 
 	if ((ring->rx_mini_pending) || (ring->rx_jumbo_pending))
 		return -EINVAL;
@@ -673,9 +678,12 @@ static int iavf_set_ringparam(struct net_device *netdev,
 	if (netif_running(netdev)) {
 		adapter->flags |= IAVF_FLAG_RESET_NEEDED;
 		queue_work(adapter->wq, &adapter->reset_task);
+		ret = iavf_wait_for_reset(adapter);
+		if (ret)
+			netdev_warn(netdev, "Changing ring parameters timeout or interrupted waiting for reset");
 	}
 
-	return 0;
+	return ret;
 }
 
 /**
@@ -1830,7 +1838,7 @@ static int iavf_set_channels(struct net_device *netdev,
 {
 	struct iavf_adapter *adapter = netdev_priv(netdev);
 	u32 num_req = ch->combined_count;
-	int i;
+	int ret = 0;
 
 	if ((adapter->vf_res->vf_cap_flags & VIRTCHNL_VF_OFFLOAD_ADQ) &&
 	    adapter->num_tc) {
@@ -1854,20 +1862,11 @@ static int iavf_set_channels(struct net_device *netdev,
 	adapter->flags |= IAVF_FLAG_REINIT_ITR_NEEDED;
 	iavf_schedule_reset(adapter);
 
-	/* wait for the reset is done */
-	for (i = 0; i < IAVF_RESET_WAIT_COMPLETE_COUNT; i++) {
-		msleep(IAVF_RESET_WAIT_MS);
-		if (adapter->flags & IAVF_FLAG_RESET_PENDING)
-			continue;
-		break;
-	}
-	if (i == IAVF_RESET_WAIT_COMPLETE_COUNT) {
-		adapter->flags &= ~IAVF_FLAG_REINIT_ITR_NEEDED;
-		adapter->num_req_queues = 0;
-		return -EOPNOTSUPP;
-	}
+	ret = iavf_wait_for_reset(adapter);
+	if (ret)
+		netdev_warn(netdev, "Changing channel count timeout or interrupted waiting for reset");
 
-	return 0;
+	return ret;
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index b24e54823e6ae..8cb9b74b3ebea 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -166,6 +166,45 @@ static struct iavf_adapter *iavf_pdev_to_adapter(struct pci_dev *pdev)
 	return netdev_priv(pci_get_drvdata(pdev));
 }
 
+/**
+ * iavf_is_reset_in_progress - Check if a reset is in progress
+ * @adapter: board private structure
+ */
+static bool iavf_is_reset_in_progress(struct iavf_adapter *adapter)
+{
+	if (adapter->state == __IAVF_RESETTING ||
+	    adapter->flags & (IAVF_FLAG_RESET_PENDING |
+			      IAVF_FLAG_RESET_NEEDED))
+		return true;
+
+	return false;
+}
+
+/**
+ * iavf_wait_for_reset - Wait for reset to finish.
+ * @adapter: board private structure
+ *
+ * Returns 0 if reset finished successfully, negative on timeout or interrupt.
+ */
+int iavf_wait_for_reset(struct iavf_adapter *adapter)
+{
+	int ret = wait_event_interruptible_timeout(adapter->reset_waitqueue,
+					!iavf_is_reset_in_progress(adapter),
+					msecs_to_jiffies(5000));
+
+	/* If ret < 0 then it means wait was interrupted.
+	 * If ret == 0 then it means we got a timeout while waiting
+	 * for reset to finish.
+	 * If ret > 0 it means reset has finished.
+	 */
+	if (ret > 0)
+		return 0;
+	else if (ret < 0)
+		return -EINTR;
+	else
+		return -EBUSY;
+}
+
 /**
  * iavf_allocate_dma_mem_d - OS specific memory alloc for shared code
  * @hw:   pointer to the HW structure
@@ -3161,6 +3200,7 @@ static void iavf_reset_task(struct work_struct *work)
 
 	adapter->flags &= ~IAVF_FLAG_REINIT_ITR_NEEDED;
 
+	wake_up(&adapter->reset_waitqueue);
 	mutex_unlock(&adapter->client_lock);
 	mutex_unlock(&adapter->crit_lock);
 
@@ -4325,6 +4365,7 @@ static int iavf_close(struct net_device *netdev)
 static int iavf_change_mtu(struct net_device *netdev, int new_mtu)
 {
 	struct iavf_adapter *adapter = netdev_priv(netdev);
+	int ret = 0;
 
 	netdev_dbg(netdev, "changing MTU from %d to %d\n",
 		   netdev->mtu, new_mtu);
@@ -4337,9 +4378,14 @@ static int iavf_change_mtu(struct net_device *netdev, int new_mtu)
 	if (netif_running(netdev)) {
 		adapter->flags |= IAVF_FLAG_RESET_NEEDED;
 		queue_work(adapter->wq, &adapter->reset_task);
+		ret = iavf_wait_for_reset(adapter);
+		if (ret < 0)
+			netdev_warn(netdev, "MTU change interrupted waiting for reset");
+		else if (ret)
+			netdev_warn(netdev, "MTU change timed out waiting for reset");
 	}
 
-	return 0;
+	return ret;
 }
 
 #define NETIF_VLAN_OFFLOAD_FEATURES	(NETIF_F_HW_VLAN_CTAG_RX | \
@@ -4940,6 +4986,9 @@ static int iavf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	/* Setup the wait queue for indicating transition to down status */
 	init_waitqueue_head(&adapter->down_waitqueue);
 
+	/* Setup the wait queue for indicating transition to running state */
+	init_waitqueue_head(&adapter->reset_waitqueue);
+
 	/* Setup the wait queue for indicating virtchannel events */
 	init_waitqueue_head(&adapter->vc_waitqueue);
 
diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
index 7c0578b5457b9..1bab896aaf40c 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
@@ -2285,6 +2285,7 @@ void iavf_virtchnl_completion(struct iavf_adapter *adapter,
 	case VIRTCHNL_OP_ENABLE_QUEUES:
 		/* enable transmits */
 		iavf_irq_enable(adapter, true);
+		wake_up(&adapter->reset_waitqueue);
 		adapter->flags &= ~IAVF_FLAG_QUEUES_DISABLED;
 		break;
 	case VIRTCHNL_OP_DISABLE_QUEUES:
-- 
2.39.2



