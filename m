Return-Path: <stable+bounces-233690-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iIQHFGs21WmP2wcAu9opvQ
	(envelope-from <stable+bounces-233690-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 18:52:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C60EC3B218A
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 18:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2C6E83025A74
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 16:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7039F3D0912;
	Tue,  7 Apr 2026 16:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HH6LlkeR"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD903CFF4F
	for <stable@vger.kernel.org>; Tue,  7 Apr 2026 16:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775580771; cv=none; b=TzT8zkpY4VywCEmmvh57u6EFkDvjTtwmIfsnyMVzvSf9nma0W5xaGZ0HiJNYoKA/fCQSLezZ9+pHNj+8vw5ynN6OpcnM4CftgZ2RO0quMX6EMZp3eW4bgx0KyhPFQpF1q/VpbC/WGs+oQ/hpAwa4P5ISD4GrMpaj3eoalqhMg4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775580771; c=relaxed/simple;
	bh=nFIGkKG8ERZw3LskQwiey0gRWDtyMc5pMYVuMLIpg/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=idGf2upWDldlBGLAN8f/rulBadpsMphw5rDt4TbJq9uPp8c+1PXgesf6iXH94EVH/P8PHNZk89PqYaTPRsHqVV1EHHWkZZwI48OjpMzfpHLu0hG0K+I3e5BgSzFQ8JHqs25J+4uv6MleDuBQb0ehLu/HlWHrZEnIe+cVyzUsZXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HH6LlkeR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775580768;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EKZFBsNheoLVD5sdC0UG4DuUe2CBvyHTNlwHzswNDWM=;
	b=HH6LlkeRkrk9t8W0pDw8FrUYbgyDQPB/EezCbnr1R/8IdrdqOakCkrbeKVH1qjTWZ+iHH1
	lEg3iy+SfMoB6xLRjEaVswrLbw1mC9oS5nEGxyqB0NSp0swq8251UVUYk8s2flsMoyuOsE
	FDE9FpzBFUmlPeAO4uYVOFpSUBkftoI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-582-PWVNoNMPMwyCIBh0gDqkCw-1; Tue,
 07 Apr 2026 12:52:47 -0400
X-MC-Unique: PWVNoNMPMwyCIBh0gDqkCw-1
X-Mimecast-MFC-AGG-ID: PWVNoNMPMwyCIBh0gDqkCw_1775580764
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A489B195608C;
	Tue,  7 Apr 2026 16:52:44 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.48.48])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1617C300019F;
	Tue,  7 Apr 2026 16:52:40 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: netdev@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org,
	jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Jose Ignacio Tornos Martinez <jtornosm@redhat.com>,
	stable@vger.kernel.org
Subject: [PATCH net v2 3/4] iavf: send MAC change request synchronously
Date: Tue,  7 Apr 2026 18:52:05 +0200
Message-ID: <20260407165206.1121317-4-jtornosm@redhat.com>
In-Reply-To: <20260407165206.1121317-1-jtornosm@redhat.com>
References: <20260407165206.1121317-1-jtornosm@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233690-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jtornosm@redhat.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C60EC3B218A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
instead of void, allowing callers to detect failures.

Fixes: ad7c7b2172c3 ("net: hold netdev instance lock during sysfs operations")
cc: stable@vger.kernel.org
Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
---
v2: Complete rewrite using synchronous polling approach instead of dropping
    the netdev lock. New approach:
    - Polls admin queue hardware directly (similar to iavf_reset_step)
    - Processes all virtchnl messages inline while holding netdev_lock
    - Introduced generic iavf_poll_virtchnl_response() for code reuse
    - No lock dropping, following accepted pattern from ndo_change_mtu fix
v1: https://lore.kernel.org/netdev/20260406112057.906685-4-jtornosm@redhat.com/

 drivers/net/ethernet/intel/iavf/iavf.h        |   2 +-
 drivers/net/ethernet/intel/iavf/iavf_main.c   | 118 +++++++++++++++---
 .../net/ethernet/intel/iavf/iavf_virtchnl.c   |  11 +-
 3 files changed, 110 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf.h b/drivers/net/ethernet/intel/iavf/iavf.h
index e9fb0a0919e3..5bc23519fe9c 100644
--- a/drivers/net/ethernet/intel/iavf/iavf.h
+++ b/drivers/net/ethernet/intel/iavf/iavf.h
@@ -589,7 +589,7 @@ void iavf_configure_queues(struct iavf_adapter *adapter);
 void iavf_enable_queues(struct iavf_adapter *adapter);
 void iavf_disable_queues(struct iavf_adapter *adapter);
 void iavf_map_queues(struct iavf_adapter *adapter);
-void iavf_add_ether_addrs(struct iavf_adapter *adapter);
+int iavf_add_ether_addrs(struct iavf_adapter *adapter);
 void iavf_del_ether_addrs(struct iavf_adapter *adapter);
 void iavf_add_vlans(struct iavf_adapter *adapter);
 void iavf_del_vlans(struct iavf_adapter *adapter);
diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 67aa14350b1b..2ef30b1ef35c 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -1047,6 +1047,105 @@ static bool iavf_is_mac_set_handled(struct net_device *netdev,
 	return ret;
 }
 
+/**
+ * iavf_poll_virtchnl_response - Poll admin queue for virtchnl response
+ * @adapter: board private structure
+ * @condition: callback to check if desired response received
+ * @cond_data: context data passed to condition callback
+ * @timeout_ms: maximum time to wait in milliseconds
+ *
+ * Polls admin queue and processes all messages until condition returns true
+ * or timeout expires. Caller must hold netdev_lock. This can sleep for up to
+ * timeout_ms while polling hardware.
+ *
+ * Returns 0 on success (condition met), -EAGAIN on timeout or error
+ */
+static int iavf_poll_virtchnl_response(struct iavf_adapter *adapter,
+				       bool (*condition)(struct iavf_adapter *, void *),
+				       void *cond_data,
+				       unsigned int timeout_ms)
+{
+	struct iavf_hw *hw = &adapter->hw;
+	struct iavf_arq_event_info event;
+	enum virtchnl_ops v_op;
+	enum iavf_status v_ret;
+	unsigned long timeout;
+	int ret;
+
+	netdev_assert_locked(adapter->netdev);
+
+	event.buf_len = IAVF_MAX_AQ_BUF_SIZE;
+	event.msg_buf = kzalloc(event.buf_len, GFP_KERNEL);
+	if (!event.msg_buf)
+		return -ENOMEM;
+
+	timeout = jiffies + msecs_to_jiffies(timeout_ms);
+	while (time_before(jiffies, timeout)) {
+		if (condition(adapter, cond_data)) {
+			ret = 0;
+			goto out;
+		}
+
+		ret = iavf_clean_arq_element(hw, &event, NULL);
+		if (!ret) {
+			v_op = (enum virtchnl_ops)le32_to_cpu(event.desc.cookie_high);
+			v_ret = (enum iavf_status)le32_to_cpu(event.desc.cookie_low);
+
+			iavf_virtchnl_completion(adapter, v_op, v_ret,
+						 event.msg_buf, event.msg_len);
+
+			memset(event.msg_buf, 0, IAVF_MAX_AQ_BUF_SIZE);
+		}
+
+		usleep_range(1000, 2000);
+	}
+
+	ret = -EAGAIN;
+out:
+	kfree(event.msg_buf);
+	return ret;
+}
+
+/**
+ * iavf_mac_change_done - Check if MAC change completed
+ * @adapter: board private structure
+ * @data: MAC address being checked (as void *)
+ *
+ * Callback for iavf_poll_virtchnl_response() to check if MAC change completed.
+ *
+ * Returns true if MAC change completed, false otherwise
+ */
+static bool iavf_mac_change_done(struct iavf_adapter *adapter, void *data)
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
+ * Sends MAC change request to PF and polls admin queue for response.
+ * Caller must hold netdev_lock. This can sleep for up to 2.5 seconds.
+ *
+ * Returns 0 on success or error
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
+					   (void *)addr, 2500);
+}
+
 /**
  * iavf_set_mac - NDO callback to set port MAC address
  * @netdev: network interface device structure
@@ -1067,25 +1166,12 @@ static int iavf_set_mac(struct net_device *netdev, void *p)
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
-		return ret;
-
-	if (!ret)
-		return -EAGAIN;
+	ret = iavf_set_mac_sync(adapter, addr->sa_data);
+	if (ret)
+		return ret;
 
 	if (!ether_addr_equal(netdev->dev_addr, addr->sa_data))
 		return -EACCES;
diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
index a52c100dcbc5..fdddf4b033ca 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
@@ -555,8 +555,10 @@ iavf_set_mac_addr_type(struct virtchnl_ether_addr *virtchnl_ether_addr,
  * @adapter: adapter structure
  *
  * Request that the PF add one or more addresses to our filters.
+ *
+ * Returns 0 on success or error
  **/
-void iavf_add_ether_addrs(struct iavf_adapter *adapter)
+int iavf_add_ether_addrs(struct iavf_adapter *adapter)
 {
 	struct virtchnl_ether_addr_list *veal;
 	struct iavf_mac_filter *f;
@@ -568,7 +570,7 @@ void iavf_add_ether_addrs(struct iavf_adapter *adapter)
 		/* bail because we already have a command pending */
 		dev_err(&adapter->pdev->dev, "Cannot add filters, command %d pending\n",
 			adapter->current_op);
-		return;
+		return -EBUSY;
 	}
 
 	spin_lock_bh(&adapter->mac_vlan_list_lock);
@@ -580,7 +582,7 @@ void iavf_add_ether_addrs(struct iavf_adapter *adapter)
 	if (!count) {
 		adapter->aq_required &= ~IAVF_FLAG_AQ_ADD_MAC_FILTER;
 		spin_unlock_bh(&adapter->mac_vlan_list_lock);
-		return;
+		return 0;
 	}
 	adapter->current_op = VIRTCHNL_OP_ADD_ETH_ADDR;
 
@@ -595,7 +597,7 @@ void iavf_add_ether_addrs(struct iavf_adapter *adapter)
 	veal = kzalloc(len, GFP_ATOMIC);
 	if (!veal) {
 		spin_unlock_bh(&adapter->mac_vlan_list_lock);
-		return;
+		return -ENOMEM;
 	}
 
 	veal->vsi_id = adapter->vsi_res->vsi_id;
@@ -617,6 +619,7 @@ void iavf_add_ether_addrs(struct iavf_adapter *adapter)
 
 	iavf_send_pf_msg(adapter, VIRTCHNL_OP_ADD_ETH_ADDR, (u8 *)veal, len);
 	kfree(veal);
+	return 0;
 }
 
 /**
-- 
2.53.0


