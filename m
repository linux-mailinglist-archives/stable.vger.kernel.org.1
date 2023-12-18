Return-Path: <stable+bounces-7166-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B375981713C
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 14:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AAE21F234AF
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 13:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4690315AC0;
	Mon, 18 Dec 2023 13:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1vyw0Bqc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107BB129EC8;
	Mon, 18 Dec 2023 13:55:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85E6BC433C7;
	Mon, 18 Dec 2023 13:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702907738;
	bh=59IsbeIxzaf7lIV21OAyrvU73DUHfDCJJ5qQ2XNsVzY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1vyw0BqcQFIa9Y9EWTuMaFETGgEkXtJVi+SfMuhT/YoP3qjVMrWzpQ4tkxjfZIqkr
	 30opZMNfeVA3gkvCgxq/81FYoRbizpNb89UAWYK3cg9KKyk0h9kf61mRPvLE7BoYsD
	 1melbA6B2/8naRP1oHkoAHVXoJ/Kqf3m6WjrLl8M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Piotr Gardocki <piotrx.gardocki@intel.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Ranganatha Rao <ranganatha.rao@intel.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 028/106] iavf: Introduce new state machines for flow director
Date: Mon, 18 Dec 2023 14:50:42 +0100
Message-ID: <20231218135056.138324635@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218135055.005497074@linuxfoundation.org>
References: <20231218135055.005497074@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Piotr Gardocki <piotrx.gardocki@intel.com>

[ Upstream commit 3a0b5a2929fdeda63fc921c2dbed237059acf732 ]

New states introduced:

 IAVF_FDIR_FLTR_DIS_REQUEST
 IAVF_FDIR_FLTR_DIS_PENDING
 IAVF_FDIR_FLTR_INACTIVE

Current FDIR state machines (SM) are not adequate to handle a few
scenarios in the link DOWN/UP event, reset event and ntuple-feature.

For example, when VF link goes DOWN and comes back UP administratively,
the expectation is that previously installed filters should also be
restored. But with current SM, filters are not restored.
So with new SM, during link DOWN filters are marked as INACTIVE in
the iavf list but removed from PF. After link UP, SM will transition
from INACTIVE to ADD_REQUEST to restore the filter.

Similarly, with VF reset, filters will be removed from the PF, but
marked as INACTIVE in the iavf list. Filters will be restored after
reset completion.

Steps to reproduce:
-------------------

1. Create a VF. Here VF is enp8s0.

2. Assign IP addresses to VF and link partner and ping continuously
from remote. Here remote IP is 1.1.1.1.

3. Check default RX Queue of traffic.

ethtool -S enp8s0 | grep -E "rx-[[:digit:]]+\.packets"

4. Add filter - change default RX Queue (to 15 here)

ethtool -U ens8s0 flow-type ip4 src-ip 1.1.1.1 action 15 loc 5

5. Ensure filter gets added and traffic is received on RX queue 15 now.

Link event testing:
-------------------
6. Bring VF link down and up. If traffic flows to configured queue 15,
test is success, otherwise it is a failure.

Reset event testing:
--------------------
7. Reset the VF. If traffic flows to configured queue 15, test is success,
otherwise it is a failure.

Fixes: 0dbfbabb840d ("iavf: Add framework to enable ethtool ntuple filters")
Signed-off-by: Piotr Gardocki <piotrx.gardocki@intel.com>
Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>
Signed-off-by: Ranganatha Rao <ranganatha.rao@intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/iavf/iavf.h        |  1 +
 .../net/ethernet/intel/iavf/iavf_ethtool.c    | 27 ++++---
 drivers/net/ethernet/intel/iavf/iavf_fdir.h   | 15 +++-
 drivers/net/ethernet/intel/iavf/iavf_main.c   | 48 ++++++++++---
 .../net/ethernet/intel/iavf/iavf_virtchnl.c   | 71 +++++++++++++++++--
 5 files changed, 139 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf.h b/drivers/net/ethernet/intel/iavf/iavf.h
index 7389855fa307a..ee0871d929302 100644
--- a/drivers/net/ethernet/intel/iavf/iavf.h
+++ b/drivers/net/ethernet/intel/iavf/iavf.h
@@ -303,6 +303,7 @@ struct iavf_adapter {
 #define IAVF_FLAG_QUEUES_DISABLED		BIT(17)
 #define IAVF_FLAG_SETUP_NETDEV_FEATURES		BIT(18)
 #define IAVF_FLAG_REINIT_MSIX_NEEDED		BIT(20)
+#define IAVF_FLAG_FDIR_ENABLED			BIT(21)
 /* duplicates for common code */
 #define IAVF_FLAG_DCB_ENABLED			0
 	/* flags for admin queue service task */
diff --git a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
index 31e02624aca48..f4ac2b164b3e9 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
@@ -1063,7 +1063,7 @@ iavf_get_ethtool_fdir_entry(struct iavf_adapter *adapter,
 	struct iavf_fdir_fltr *rule = NULL;
 	int ret = 0;
 
-	if (!FDIR_FLTR_SUPPORT(adapter))
+	if (!(adapter->flags & IAVF_FLAG_FDIR_ENABLED))
 		return -EOPNOTSUPP;
 
 	spin_lock_bh(&adapter->fdir_fltr_lock);
@@ -1205,7 +1205,7 @@ iavf_get_fdir_fltr_ids(struct iavf_adapter *adapter, struct ethtool_rxnfc *cmd,
 	unsigned int cnt = 0;
 	int val = 0;
 
-	if (!FDIR_FLTR_SUPPORT(adapter))
+	if (!(adapter->flags & IAVF_FLAG_FDIR_ENABLED))
 		return -EOPNOTSUPP;
 
 	cmd->data = IAVF_MAX_FDIR_FILTERS;
@@ -1397,7 +1397,7 @@ static int iavf_add_fdir_ethtool(struct iavf_adapter *adapter, struct ethtool_rx
 	int count = 50;
 	int err;
 
-	if (!FDIR_FLTR_SUPPORT(adapter))
+	if (!(adapter->flags & IAVF_FLAG_FDIR_ENABLED))
 		return -EOPNOTSUPP;
 
 	if (fsp->flow_type & FLOW_MAC_EXT)
@@ -1438,12 +1438,16 @@ static int iavf_add_fdir_ethtool(struct iavf_adapter *adapter, struct ethtool_rx
 	spin_lock_bh(&adapter->fdir_fltr_lock);
 	iavf_fdir_list_add_fltr(adapter, fltr);
 	adapter->fdir_active_fltr++;
-	fltr->state = IAVF_FDIR_FLTR_ADD_REQUEST;
-	adapter->aq_required |= IAVF_FLAG_AQ_ADD_FDIR_FILTER;
+	if (adapter->link_up) {
+		fltr->state = IAVF_FDIR_FLTR_ADD_REQUEST;
+		adapter->aq_required |= IAVF_FLAG_AQ_ADD_FDIR_FILTER;
+	} else {
+		fltr->state = IAVF_FDIR_FLTR_INACTIVE;
+	}
 	spin_unlock_bh(&adapter->fdir_fltr_lock);
 
-	mod_delayed_work(adapter->wq, &adapter->watchdog_task, 0);
-
+	if (adapter->link_up)
+		mod_delayed_work(adapter->wq, &adapter->watchdog_task, 0);
 ret:
 	if (err && fltr)
 		kfree(fltr);
@@ -1465,7 +1469,7 @@ static int iavf_del_fdir_ethtool(struct iavf_adapter *adapter, struct ethtool_rx
 	struct iavf_fdir_fltr *fltr = NULL;
 	int err = 0;
 
-	if (!FDIR_FLTR_SUPPORT(adapter))
+	if (!(adapter->flags & IAVF_FLAG_FDIR_ENABLED))
 		return -EOPNOTSUPP;
 
 	spin_lock_bh(&adapter->fdir_fltr_lock);
@@ -1474,6 +1478,11 @@ static int iavf_del_fdir_ethtool(struct iavf_adapter *adapter, struct ethtool_rx
 		if (fltr->state == IAVF_FDIR_FLTR_ACTIVE) {
 			fltr->state = IAVF_FDIR_FLTR_DEL_REQUEST;
 			adapter->aq_required |= IAVF_FLAG_AQ_DEL_FDIR_FILTER;
+		} else if (fltr->state == IAVF_FDIR_FLTR_INACTIVE) {
+			list_del(&fltr->list);
+			kfree(fltr);
+			adapter->fdir_active_fltr--;
+			fltr = NULL;
 		} else {
 			err = -EBUSY;
 		}
@@ -1782,7 +1791,7 @@ static int iavf_get_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *cmd,
 		ret = 0;
 		break;
 	case ETHTOOL_GRXCLSRLCNT:
-		if (!FDIR_FLTR_SUPPORT(adapter))
+		if (!(adapter->flags & IAVF_FLAG_FDIR_ENABLED))
 			break;
 		spin_lock_bh(&adapter->fdir_fltr_lock);
 		cmd->rule_cnt = adapter->fdir_active_fltr;
diff --git a/drivers/net/ethernet/intel/iavf/iavf_fdir.h b/drivers/net/ethernet/intel/iavf/iavf_fdir.h
index 9eb9f73f6adf3..d31bd923ba8cb 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_fdir.h
+++ b/drivers/net/ethernet/intel/iavf/iavf_fdir.h
@@ -6,12 +6,25 @@
 
 struct iavf_adapter;
 
-/* State of Flow Director filter */
+/* State of Flow Director filter
+ *
+ * *_REQUEST states are used to mark filter to be sent to PF driver to perform
+ * an action (either add or delete filter). *_PENDING states are an indication
+ * that request was sent to PF and the driver is waiting for response.
+ *
+ * Both DELETE and DISABLE states are being used to delete a filter in PF.
+ * The difference is that after a successful response filter in DEL_PENDING
+ * state is being deleted from VF driver as well and filter in DIS_PENDING state
+ * is being changed to INACTIVE state.
+ */
 enum iavf_fdir_fltr_state_t {
 	IAVF_FDIR_FLTR_ADD_REQUEST,	/* User requests to add filter */
 	IAVF_FDIR_FLTR_ADD_PENDING,	/* Filter pending add by the PF */
 	IAVF_FDIR_FLTR_DEL_REQUEST,	/* User requests to delete filter */
 	IAVF_FDIR_FLTR_DEL_PENDING,	/* Filter pending delete by the PF */
+	IAVF_FDIR_FLTR_DIS_REQUEST,	/* Filter scheduled to be disabled */
+	IAVF_FDIR_FLTR_DIS_PENDING,	/* Filter pending disable by the PF */
+	IAVF_FDIR_FLTR_INACTIVE,	/* Filter inactive on link down */
 	IAVF_FDIR_FLTR_ACTIVE,		/* Filter is active */
 };
 
diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 4836bac2bd09d..3a155026d9a5f 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -1368,18 +1368,20 @@ static void iavf_clear_cloud_filters(struct iavf_adapter *adapter)
  **/
 static void iavf_clear_fdir_filters(struct iavf_adapter *adapter)
 {
-	struct iavf_fdir_fltr *fdir, *fdirtmp;
+	struct iavf_fdir_fltr *fdir;
 
 	/* remove all Flow Director filters */
 	spin_lock_bh(&adapter->fdir_fltr_lock);
-	list_for_each_entry_safe(fdir, fdirtmp, &adapter->fdir_list_head,
-				 list) {
+	list_for_each_entry(fdir, &adapter->fdir_list_head, list) {
 		if (fdir->state == IAVF_FDIR_FLTR_ADD_REQUEST) {
-			list_del(&fdir->list);
-			kfree(fdir);
-			adapter->fdir_active_fltr--;
-		} else {
-			fdir->state = IAVF_FDIR_FLTR_DEL_REQUEST;
+			/* Cancel a request, keep filter as inactive */
+			fdir->state = IAVF_FDIR_FLTR_INACTIVE;
+		} else if (fdir->state == IAVF_FDIR_FLTR_ADD_PENDING ||
+			 fdir->state == IAVF_FDIR_FLTR_ACTIVE) {
+			/* Disable filters which are active or have a pending
+			 * request to PF to be added
+			 */
+			fdir->state = IAVF_FDIR_FLTR_DIS_REQUEST;
 		}
 	}
 	spin_unlock_bh(&adapter->fdir_fltr_lock);
@@ -4210,6 +4212,33 @@ static int iavf_setup_tc(struct net_device *netdev, enum tc_setup_type type,
 	}
 }
 
+/**
+ * iavf_restore_fdir_filters
+ * @adapter: board private structure
+ *
+ * Restore existing FDIR filters when VF netdev comes back up.
+ **/
+static void iavf_restore_fdir_filters(struct iavf_adapter *adapter)
+{
+	struct iavf_fdir_fltr *f;
+
+	spin_lock_bh(&adapter->fdir_fltr_lock);
+	list_for_each_entry(f, &adapter->fdir_list_head, list) {
+		if (f->state == IAVF_FDIR_FLTR_DIS_REQUEST) {
+			/* Cancel a request, keep filter as active */
+			f->state = IAVF_FDIR_FLTR_ACTIVE;
+		} else if (f->state == IAVF_FDIR_FLTR_DIS_PENDING ||
+			   f->state == IAVF_FDIR_FLTR_INACTIVE) {
+			/* Add filters which are inactive or have a pending
+			 * request to PF to be deleted
+			 */
+			f->state = IAVF_FDIR_FLTR_ADD_REQUEST;
+			adapter->aq_required |= IAVF_FLAG_AQ_ADD_FDIR_FILTER;
+		}
+	}
+	spin_unlock_bh(&adapter->fdir_fltr_lock);
+}
+
 /**
  * iavf_open - Called when a network interface is made active
  * @netdev: network interface device structure
@@ -4277,8 +4306,9 @@ static int iavf_open(struct net_device *netdev)
 
 	spin_unlock_bh(&adapter->mac_vlan_list_lock);
 
-	/* Restore VLAN filters that were removed with IFF_DOWN */
+	/* Restore filters that were removed with IFF_DOWN */
 	iavf_restore_filters(adapter);
+	iavf_restore_fdir_filters(adapter);
 
 	iavf_configure(adapter);
 
diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
index 5a66b05c03222..951ef350323a2 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
@@ -1752,8 +1752,8 @@ void iavf_add_fdir_filter(struct iavf_adapter *adapter)
  **/
 void iavf_del_fdir_filter(struct iavf_adapter *adapter)
 {
+	struct virtchnl_fdir_del f = {};
 	struct iavf_fdir_fltr *fdir;
-	struct virtchnl_fdir_del f;
 	bool process_fltr = false;
 	int len;
 
@@ -1770,11 +1770,16 @@ void iavf_del_fdir_filter(struct iavf_adapter *adapter)
 	list_for_each_entry(fdir, &adapter->fdir_list_head, list) {
 		if (fdir->state == IAVF_FDIR_FLTR_DEL_REQUEST) {
 			process_fltr = true;
-			memset(&f, 0, len);
 			f.vsi_id = fdir->vc_add_msg.vsi_id;
 			f.flow_id = fdir->flow_id;
 			fdir->state = IAVF_FDIR_FLTR_DEL_PENDING;
 			break;
+		} else if (fdir->state == IAVF_FDIR_FLTR_DIS_REQUEST) {
+			process_fltr = true;
+			f.vsi_id = fdir->vc_add_msg.vsi_id;
+			f.flow_id = fdir->flow_id;
+			fdir->state = IAVF_FDIR_FLTR_DIS_PENDING;
+			break;
 		}
 	}
 	spin_unlock_bh(&adapter->fdir_fltr_lock);
@@ -1918,6 +1923,48 @@ static void iavf_netdev_features_vlan_strip_set(struct net_device *netdev,
 		netdev->features &= ~NETIF_F_HW_VLAN_CTAG_RX;
 }
 
+/**
+ * iavf_activate_fdir_filters - Reactivate all FDIR filters after a reset
+ * @adapter: private adapter structure
+ *
+ * Called after a reset to re-add all FDIR filters and delete some of them
+ * if they were pending to be deleted.
+ */
+static void iavf_activate_fdir_filters(struct iavf_adapter *adapter)
+{
+	struct iavf_fdir_fltr *f, *ftmp;
+	bool add_filters = false;
+
+	spin_lock_bh(&adapter->fdir_fltr_lock);
+	list_for_each_entry_safe(f, ftmp, &adapter->fdir_list_head, list) {
+		if (f->state == IAVF_FDIR_FLTR_ADD_REQUEST ||
+		    f->state == IAVF_FDIR_FLTR_ADD_PENDING ||
+		    f->state == IAVF_FDIR_FLTR_ACTIVE) {
+			/* All filters and requests have been removed in PF,
+			 * restore them
+			 */
+			f->state = IAVF_FDIR_FLTR_ADD_REQUEST;
+			add_filters = true;
+		} else if (f->state == IAVF_FDIR_FLTR_DIS_REQUEST ||
+			   f->state == IAVF_FDIR_FLTR_DIS_PENDING) {
+			/* Link down state, leave filters as inactive */
+			f->state = IAVF_FDIR_FLTR_INACTIVE;
+		} else if (f->state == IAVF_FDIR_FLTR_DEL_REQUEST ||
+			   f->state == IAVF_FDIR_FLTR_DEL_PENDING) {
+			/* Delete filters that were pending to be deleted, the
+			 * list on PF is already cleared after a reset
+			 */
+			list_del(&f->list);
+			kfree(f);
+			adapter->fdir_active_fltr--;
+		}
+	}
+	spin_unlock_bh(&adapter->fdir_fltr_lock);
+
+	if (add_filters)
+		adapter->aq_required |= IAVF_FLAG_AQ_ADD_FDIR_FILTER;
+}
+
 /**
  * iavf_virtchnl_completion
  * @adapter: adapter structure
@@ -2095,7 +2142,8 @@ void iavf_virtchnl_completion(struct iavf_adapter *adapter,
 			spin_lock_bh(&adapter->fdir_fltr_lock);
 			list_for_each_entry(fdir, &adapter->fdir_list_head,
 					    list) {
-				if (fdir->state == IAVF_FDIR_FLTR_DEL_PENDING) {
+				if (fdir->state == IAVF_FDIR_FLTR_DEL_PENDING ||
+				    fdir->state == IAVF_FDIR_FLTR_DIS_PENDING) {
 					fdir->state = IAVF_FDIR_FLTR_ACTIVE;
 					dev_info(&adapter->pdev->dev, "Failed to del Flow Director filter, error %s\n",
 						 iavf_stat_str(&adapter->hw,
@@ -2232,6 +2280,8 @@ void iavf_virtchnl_completion(struct iavf_adapter *adapter,
 
 		spin_unlock_bh(&adapter->mac_vlan_list_lock);
 
+		iavf_activate_fdir_filters(adapter);
+
 		iavf_parse_vf_resource_msg(adapter);
 
 		/* negotiated VIRTCHNL_VF_OFFLOAD_VLAN_V2, so wait for the
@@ -2421,7 +2471,9 @@ void iavf_virtchnl_completion(struct iavf_adapter *adapter,
 		list_for_each_entry_safe(fdir, fdir_tmp, &adapter->fdir_list_head,
 					 list) {
 			if (fdir->state == IAVF_FDIR_FLTR_DEL_PENDING) {
-				if (del_fltr->status == VIRTCHNL_FDIR_SUCCESS) {
+				if (del_fltr->status == VIRTCHNL_FDIR_SUCCESS ||
+				    del_fltr->status ==
+				    VIRTCHNL_FDIR_FAILURE_RULE_NONEXIST) {
 					dev_info(&adapter->pdev->dev, "Flow Director filter with location %u is deleted\n",
 						 fdir->loc);
 					list_del(&fdir->list);
@@ -2433,6 +2485,17 @@ void iavf_virtchnl_completion(struct iavf_adapter *adapter,
 						 del_fltr->status);
 					iavf_print_fdir_fltr(adapter, fdir);
 				}
+			} else if (fdir->state == IAVF_FDIR_FLTR_DIS_PENDING) {
+				if (del_fltr->status == VIRTCHNL_FDIR_SUCCESS ||
+				    del_fltr->status ==
+				    VIRTCHNL_FDIR_FAILURE_RULE_NONEXIST) {
+					fdir->state = IAVF_FDIR_FLTR_INACTIVE;
+				} else {
+					fdir->state = IAVF_FDIR_FLTR_ACTIVE;
+					dev_info(&adapter->pdev->dev, "Failed to disable Flow Director filter with status: %d\n",
+						 del_fltr->status);
+					iavf_print_fdir_fltr(adapter, fdir);
+				}
 			}
 		}
 		spin_unlock_bh(&adapter->fdir_fltr_lock);
-- 
2.43.0




