Return-Path: <stable+bounces-252989-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6IIKIZAADmo95QUAu9opvQ
	(envelope-from <stable+bounces-252989-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:42:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD395970A9
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:42:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D3DE2310B866
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F293FC5DB;
	Wed, 20 May 2026 18:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aYmPkO+X"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0ECC3FA5D5;
	Wed, 20 May 2026 18:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779302113; cv=none; b=NG26m5DPutciVk01HJ8LqNPh59vtxIOTUEilOU3eu71k0rTO9sXuzkY95VugRepjcZfqwbkPN36AoQWjYwBtFIvLWItF5esmZCsqArW1hVDmH/ijKCZPunGRWKXfD13zJbKyKvVjlQEA8IXFZxL5NOKdbHmwtvmx0CehrMOcCTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779302113; c=relaxed/simple;
	bh=Zf3VBXSY/3kLoJVdH3JvV3MEJWUFN81Sa00KYhoyUNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g+JdfCea5AODA4dI4ja+/P4jOT5g4ALtRAcGoNGPK+9e1B2JpUX1XS+zkaFJQ36LSxDM1ufNl8zmH5oz6PaX4FvhBzF04zLdMxOjrCHhdGi5KaL3HB8DJHzuxAVcuHHJbN98DtNpqOYpld9zFp+MVdnN8IOD2XSbZMk0F9SXl1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aYmPkO+X; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779302111; x=1810838111;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Zf3VBXSY/3kLoJVdH3JvV3MEJWUFN81Sa00KYhoyUNQ=;
  b=aYmPkO+X1Cs+JCxYVk0h+WMv0pA8kH6gkFVzV7ADokmKktXIqGAiIXib
   CB+Th5/U/k+Lk8eynqOuI/w0qAjmHKsVhITQtZK4v68jf3fN0tRGNxQFk
   xrntcQIbdvy5va5dGPNICr6Y6J0dMA8SQA+IM/lcDAFW9hMdx0aMHqwz5
   e8m0Fyn8/oIHflYIAyxWPN+OtXZd0M8BM9OLZnlEqGq9Ps5vWbK2ytxnl
   +zH4kRgFLXKhuWLm8avconner9bFxqMXkesacKH4ptR2rwEBe8UV2ysms
   0W775aH9hpdvGnPJr90yDAZTbal2/hhtLamH1PIg5WHZF154RbsH0aQ1q
   Q==;
X-CSE-ConnectionGUID: zVPpZUE0QuCvsgtsXOEgaA==
X-CSE-MsgGUID: mjWPq3h+SpOH4OcXVUWiAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="80391769"
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; 
   d="scan'208";a="80391769"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 11:35:08 -0700
X-CSE-ConnectionGUID: VVA/haYJStS5Tx/FCF09oQ==
X-CSE-MsgGUID: pqqmPqejQWC/wfrVzFW0tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; 
   d="scan'208";a="239423898"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa010.jf.intel.com with ESMTP; 20 May 2026 11:35:08 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	jacob.e.keller@intel.com,
	horms@kernel.org,
	stable@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net 5/8] iavf: send MAC change request synchronously
Date: Wed, 20 May 2026 11:34:53 -0700
Message-ID: <20260520183501.3360810-6-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260520183501.3360810-1-anthony.l.nguyen@intel.com>
References: <20260520183501.3360810-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252989-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,intel.com:email,intel.com:mid,intel.com:dkim]
X-Rspamd-Queue-Id: EFD395970A9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>

After commit ad7c7b2172c3 ("net: hold netdev instance lock during sysfs
operations"), iavf_set_mac() is called with the netdev instance lock
already held.

The function queues a MAC address change request via
iavf_replace_primary_mac() and then waits for completion. However, in
the current flow, the actual virtchnl message is sent by the watchdog
task, which also needs to acquire the netdev lock to run. Additionally,
the adminq_task which processes virtchnl responses also needs the netdev
lock.

This creates a deadlock scenario:
1. iavf_set_mac() holds netdev lock and waits for MAC change
2. Watchdog needs netdev lock to send the request -> blocked
3. Even if request is sent, adminq_task needs netdev lock to process
   PF response -> blocked
4. MAC change times out after 2.5 seconds
5. iavf_set_mac() returns -EAGAIN

This particularly affects VFs during bonding setup when multiple VFs are
enslaved in quick succession.

Fix by implementing a synchronous MAC change operation similar to the
approach used in commit fdadbf6e84c4 ("iavf: fix incorrect reset handling
in callbacks").

The solution:
1. Send the virtchnl ADD_ETH_ADDR message directly (not via watchdog)
2. Poll the admin queue hardware directly for responses
3. Process all received messages (including non-MAC messages)
4. Return when MAC change completes or times out

A new generic function iavf_poll_virtchnl_response() is introduced that
can be reused for any future synchronous virtchnl operations. It takes a
callback to check completion, allowing flexible condition checking.

This allows the operation to complete synchronously while holding
netdev_lock, without relying on watchdog or adminq_task. The function
can sleep for up to 2.5 seconds polling hardware, but this is acceptable
since netdev_lock is per-device and only serializes operations on the
same interface.

To support this, change iavf_add_ether_addrs() to return an error code
instead of void, allowing callers to detect failures. Additionally,
export iavf_mac_add_reject() to enable proper rollback on local failures
(timeouts, send errors) - PF rejections are already handled automatically
by iavf_virtchnl_completion().

Remove vc_waitqueue entirely because iavf_set_mac was the only waiter on
this waitqueue and after the changes it is not needed.

Fixes: ad7c7b2172c3 ("net: hold netdev instance lock during sysfs operations")
cc: stable@vger.kernel.org
Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf.h        |  10 +-
 drivers/net/ethernet/intel/iavf/iavf_main.c   |  71 +++++++++----
 .../net/ethernet/intel/iavf/iavf_virtchnl.c   | 100 ++++++++++++++++--
 3 files changed, 151 insertions(+), 30 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf.h b/drivers/net/ethernet/intel/iavf/iavf.h
index 050f8241ef5e..06eb19b00527 100644
--- a/drivers/net/ethernet/intel/iavf/iavf.h
+++ b/drivers/net/ethernet/intel/iavf/iavf.h
@@ -259,7 +259,6 @@ struct iavf_adapter {
 	struct work_struct adminq_task;
 	struct work_struct finish_config;
 	wait_queue_head_t down_waitqueue;
-	wait_queue_head_t vc_waitqueue;
 	struct iavf_q_vector *q_vectors;
 	struct list_head vlan_filter_list;
 	int num_vlan_filters;
@@ -588,8 +587,9 @@ void iavf_configure_queues(struct iavf_adapter *adapter);
 void iavf_enable_queues(struct iavf_adapter *adapter);
 void iavf_disable_queues(struct iavf_adapter *adapter);
 void iavf_map_queues(struct iavf_adapter *adapter);
-void iavf_add_ether_addrs(struct iavf_adapter *adapter);
+int iavf_add_ether_addrs(struct iavf_adapter *adapter);
 void iavf_del_ether_addrs(struct iavf_adapter *adapter);
+void iavf_mac_add_reject(struct iavf_adapter *adapter);
 void iavf_add_vlans(struct iavf_adapter *adapter);
 void iavf_del_vlans(struct iavf_adapter *adapter);
 void iavf_set_promiscuous(struct iavf_adapter *adapter);
@@ -606,6 +606,12 @@ void iavf_disable_vlan_stripping(struct iavf_adapter *adapter);
 void iavf_virtchnl_completion(struct iavf_adapter *adapter,
 			      enum virtchnl_ops v_opcode,
 			      enum iavf_status v_retval, u8 *msg, u16 msglen);
+int iavf_poll_virtchnl_response(struct iavf_adapter *adapter,
+				bool (*condition)(struct iavf_adapter *adapter,
+						  const void *data,
+						  enum virtchnl_ops v_op),
+				const void *cond_data,
+				unsigned int timeout_ms);
 int iavf_config_rss(struct iavf_adapter *adapter);
 void iavf_cfg_queues_bw(struct iavf_adapter *adapter);
 void iavf_cfg_queues_quanta_size(struct iavf_adapter *adapter);
diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 78c59a58e0b2..ed790dc3de6b 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -1029,6 +1029,48 @@ static bool iavf_is_mac_set_handled(struct net_device *netdev,
 	return ret;
 }
 
+/**
+ * iavf_mac_change_done - Check if MAC change completed
+ * @adapter: board private structure
+ * @data: MAC address being checked (as const void *)
+ * @v_op: virtchnl opcode from processed message
+ *
+ * Callback for iavf_poll_virtchnl_response() to check if MAC change completed.
+ *
+ * Return: true if MAC change completed, false otherwise
+ */
+static bool iavf_mac_change_done(struct iavf_adapter *adapter,
+				 const void *data, enum virtchnl_ops v_op)
+{
+	const u8 *addr = data;
+
+	return iavf_is_mac_set_handled(adapter->netdev, addr);
+}
+
+/**
+ * iavf_set_mac_sync - Synchronously change MAC address
+ * @adapter: board private structure
+ * @addr: MAC address to set
+ *
+ * Send MAC change request to PF and poll admin queue for response.
+ * Caller must hold netdev_lock. This can sleep for up to 2.5 seconds.
+ *
+ * Return: 0 on success, negative on failure
+ */
+static int iavf_set_mac_sync(struct iavf_adapter *adapter, const u8 *addr)
+{
+	int ret;
+
+	netdev_assert_locked(adapter->netdev);
+
+	ret = iavf_add_ether_addrs(adapter);
+	if (ret)
+		return ret;
+
+	return iavf_poll_virtchnl_response(adapter, iavf_mac_change_done,
+					   addr, 2500);
+}
+
 /**
  * iavf_set_mac - NDO callback to set port MAC address
  * @netdev: network interface device structure
@@ -1049,25 +1091,21 @@ static int iavf_set_mac(struct net_device *netdev, void *p)
 		return -EADDRNOTAVAIL;
 
 	ret = iavf_replace_primary_mac(adapter, addr->sa_data);
-
 	if (ret)
 		return ret;
 
-	ret = wait_event_interruptible_timeout(adapter->vc_waitqueue,
-					       iavf_is_mac_set_handled(netdev, addr->sa_data),
-					       msecs_to_jiffies(2500));
-
-	/* If ret < 0 then it means wait was interrupted.
-	 * If ret == 0 then it means we got a timeout.
-	 * else it means we got response for set MAC from PF,
-	 * check if netdev MAC was updated to requested MAC,
-	 * if yes then set MAC succeeded otherwise it failed return -EACCES
-	 */
-	if (ret < 0)
+	ret = iavf_set_mac_sync(adapter, addr->sa_data);
+	if (ret) {
+		/* Rollback for local failures (timeout, send error, -EBUSY).
+		 * Note: If PF rejects the request (sends error response),
+		 * iavf_virtchnl_completion() automatically calls
+		 * iavf_mac_add_reject(), ret=0, and this is not executed.
+		 * Only local failures (no PF response received) need manual rollback.
+		 */
+		iavf_mac_add_reject(adapter);
+		ether_addr_copy(adapter->hw.mac.addr, netdev->dev_addr);
 		return ret;
-
-	if (!ret)
-		return -EAGAIN;
+	}
 
 	if (!ether_addr_equal(netdev->dev_addr, addr->sa_data))
 		return -EACCES;
@@ -5393,9 +5431,6 @@ static int iavf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	/* Setup the wait queue for indicating transition to down status */
 	init_waitqueue_head(&adapter->down_waitqueue);
 
-	/* Setup the wait queue for indicating virtchannel events */
-	init_waitqueue_head(&adapter->vc_waitqueue);
-
 	INIT_LIST_HEAD(&adapter->ptp.aq_cmds);
 	init_waitqueue_head(&adapter->ptp.phc_time_waitqueue);
 	mutex_init(&adapter->ptp.aq_cmd_lock);
diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
index 4f2defd2331b..cd5211b9a798 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
@@ -2,6 +2,7 @@
 /* Copyright(c) 2013 - 2018 Intel Corporation. */
 
 #include <linux/net/intel/libie/rx.h>
+#include <net/netdev_lock.h>
 
 #include "iavf.h"
 #include "iavf_ptp.h"
@@ -555,20 +556,23 @@ iavf_set_mac_addr_type(struct virtchnl_ether_addr *virtchnl_ether_addr,
  * @adapter: adapter structure
  *
  * Request that the PF add one or more addresses to our filters.
- **/
-void iavf_add_ether_addrs(struct iavf_adapter *adapter)
+ *
+ * Return: 0 on success, negative on failure
+ */
+int iavf_add_ether_addrs(struct iavf_adapter *adapter)
 {
 	struct virtchnl_ether_addr_list *veal;
 	struct iavf_mac_filter *f;
 	int i = 0, count = 0;
 	bool more = false;
 	size_t len;
+	int ret;
 
 	if (adapter->current_op != VIRTCHNL_OP_UNKNOWN) {
 		/* bail because we already have a command pending */
 		dev_err(&adapter->pdev->dev, "Cannot add filters, command %d pending\n",
 			adapter->current_op);
-		return;
+		return -EBUSY;
 	}
 
 	spin_lock_bh(&adapter->mac_vlan_list_lock);
@@ -580,7 +584,7 @@ void iavf_add_ether_addrs(struct iavf_adapter *adapter)
 	if (!count) {
 		adapter->aq_required &= ~IAVF_FLAG_AQ_ADD_MAC_FILTER;
 		spin_unlock_bh(&adapter->mac_vlan_list_lock);
-		return;
+		return 0;
 	}
 	adapter->current_op = VIRTCHNL_OP_ADD_ETH_ADDR;
 
@@ -594,8 +598,9 @@ void iavf_add_ether_addrs(struct iavf_adapter *adapter)
 
 	veal = kzalloc(len, GFP_ATOMIC);
 	if (!veal) {
+		adapter->current_op = VIRTCHNL_OP_UNKNOWN;
 		spin_unlock_bh(&adapter->mac_vlan_list_lock);
-		return;
+		return -ENOMEM;
 	}
 
 	veal->vsi_id = adapter->vsi_res->vsi_id;
@@ -615,8 +620,15 @@ void iavf_add_ether_addrs(struct iavf_adapter *adapter)
 
 	spin_unlock_bh(&adapter->mac_vlan_list_lock);
 
-	iavf_send_pf_msg(adapter, VIRTCHNL_OP_ADD_ETH_ADDR, (u8 *)veal, len);
+	ret = iavf_send_pf_msg(adapter, VIRTCHNL_OP_ADD_ETH_ADDR, (u8 *)veal, len);
 	kfree(veal);
+	if (ret) {
+		dev_err(&adapter->pdev->dev,
+			"Unable to send ADD_ETH_ADDR message to PF, error %d\n", ret);
+		adapter->current_op = VIRTCHNL_OP_UNKNOWN;
+	}
+
+	return ret;
 }
 
 /**
@@ -712,8 +724,8 @@ static void iavf_mac_add_ok(struct iavf_adapter *adapter)
  * @adapter: adapter structure
  *
  * Remove filters from list based on PF response.
- **/
-static void iavf_mac_add_reject(struct iavf_adapter *adapter)
+ */
+void iavf_mac_add_reject(struct iavf_adapter *adapter)
 {
 	struct net_device *netdev = adapter->netdev;
 	struct iavf_mac_filter *f, *ftmp;
@@ -2364,7 +2376,6 @@ void iavf_virtchnl_completion(struct iavf_adapter *adapter,
 			iavf_mac_add_reject(adapter);
 			/* restore administratively set MAC address */
 			ether_addr_copy(adapter->hw.mac.addr, netdev->dev_addr);
-			wake_up(&adapter->vc_waitqueue);
 			break;
 		case VIRTCHNL_OP_DEL_ETH_ADDR:
 			dev_err(&adapter->pdev->dev, "Failed to delete MAC filter, error %s\n",
@@ -2557,7 +2568,6 @@ void iavf_virtchnl_completion(struct iavf_adapter *adapter,
 				eth_hw_addr_set(netdev, adapter->hw.mac.addr);
 				netif_addr_unlock_bh(netdev);
 			}
-		wake_up(&adapter->vc_waitqueue);
 		break;
 	case VIRTCHNL_OP_GET_STATS: {
 		struct iavf_eth_stats *stats =
@@ -2952,3 +2962,73 @@ void iavf_virtchnl_completion(struct iavf_adapter *adapter,
 	} /* switch v_opcode */
 	adapter->current_op = VIRTCHNL_OP_UNKNOWN;
 }
+
+/**
+ * iavf_poll_virtchnl_response - Poll admin queue for virtchnl response
+ * @adapter: adapter structure
+ * @condition: callback to check if desired response received
+ * @cond_data: context data passed to condition callback
+ * @timeout_ms: maximum time to wait in milliseconds
+ *
+ * Polls the admin queue and processes all incoming virtchnl messages.
+ * After processing each valid message, calls the condition callback to check
+ * if the expected response has been received. The callback receives the opcode
+ * of the processed message to identify which response was received. Continues
+ * polling until the callback returns true or timeout expires.
+ * Caller must hold netdev_lock. This can sleep for up to timeout_ms while
+ * polling hardware.
+ *
+ * Return: 0 on success (condition met), -EAGAIN on timeout, or error code
+ */
+int iavf_poll_virtchnl_response(struct iavf_adapter *adapter,
+				bool (*condition)(struct iavf_adapter *adapter,
+						  const void *data,
+						  enum virtchnl_ops v_op),
+				const void *cond_data,
+				unsigned int timeout_ms)
+{
+	struct iavf_hw *hw = &adapter->hw;
+	struct iavf_arq_event_info event;
+	enum virtchnl_ops received_op;
+	unsigned long timeout;
+	int ret = -EAGAIN;
+	u16 pending = 0;
+	u32 v_retval;
+
+	netdev_assert_locked(adapter->netdev);
+
+	event.buf_len = IAVF_MAX_AQ_BUF_SIZE;
+	event.msg_buf = kzalloc(event.buf_len, GFP_KERNEL);
+	if (!event.msg_buf)
+		return -ENOMEM;
+
+	timeout = jiffies + msecs_to_jiffies(timeout_ms);
+	do {
+		if (!pending)
+			usleep_range(50, 75);
+
+		if (iavf_clean_arq_element(hw, &event, &pending) == IAVF_SUCCESS) {
+			received_op = (enum virtchnl_ops)le32_to_cpu(event.desc.cookie_high);
+			if (received_op != VIRTCHNL_OP_UNKNOWN) {
+				v_retval = le32_to_cpu(event.desc.cookie_low);
+
+				iavf_virtchnl_completion(adapter, received_op,
+							 (enum iavf_status)v_retval,
+							 event.msg_buf, event.msg_len);
+
+				if (condition(adapter, cond_data, received_op)) {
+					ret = 0;
+					break;
+				}
+			}
+
+			memset(event.msg_buf, 0, IAVF_MAX_AQ_BUF_SIZE);
+
+			if (pending)
+				continue;
+		}
+	} while (time_before(jiffies, timeout));
+
+	kfree(event.msg_buf);
+	return ret;
+}
-- 
2.47.1


