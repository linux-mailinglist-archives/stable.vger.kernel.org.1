Return-Path: <stable+bounces-176586-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 082FCB39933
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 12:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AD77467B65
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 10:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D379D30C355;
	Thu, 28 Aug 2025 10:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jonCBlXu"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5473081CE;
	Thu, 28 Aug 2025 10:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756375773; cv=none; b=H/qVSmoG/7QfDsLybb5La7p6kWo4qq7Anqke+i601Ocn6KDkP9Sj5cNySQxYTb54LTTbZFzc5hQoCjQziQOwTDY1UyXrq7FSyQMXOmd79D2hS72ReEYOYWsaQlULrNjTirorXfvE8zjYJv8x6rPTyy21c8WKUD7osNvo6KLFKEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756375773; c=relaxed/simple;
	bh=JrfOFGpHaEEicJ6WSCseONdFJNLK7iyccNZeNu7weak=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hwyPSaAcarO0s1ZUngatEgFptXocn8QU+JusW7bHEweqpYqyRwSA3CkPrxu162iRY/gP7XFGuvvoCyKJkRUcO2GpFRml1X2qMY7at0MC/aEf9MFWVzKdNk4diX1uRBk3bJr4NMjQbHjhbTgdHyL0ic24szWWdDC8XqQRXaZzxco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jonCBlXu; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756375772; x=1787911772;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JrfOFGpHaEEicJ6WSCseONdFJNLK7iyccNZeNu7weak=;
  b=jonCBlXuXwKuP7Mtsh+5JTGG7V48Wa7vTPxj8I6dSuQM4SRzJuqw/Bh1
   VHvb31IqCzmMV5IJUcF7I9J/NhdZaWiT5lY0Ez4GLp/rC1YDgFuGOH65h
   8BBvD6+x6bhAP/ECGFhXEPulJK51Cd36xiPAFIDHSSK4qqJVxNmVPzU9r
   WfY4QoYFMfLqrPselunyaKxut91bHkzd26TIOFwRHfVPVkfeU4h2u71xp
   qCMfrzTO9FyMJzgeAMtQI46s0hTdYcfNe8NDomAlkQXRRedLmxZnBl9hI
   lK3Xh9IvcHoVr493hdcqMTXku6jfDMKMJKUf0hezysN3xG01f0V9kPm6g
   Q==;
X-CSE-ConnectionGUID: hH92WskmTqeNQH0qC76c/w==
X-CSE-MsgGUID: nptinJ06QqOetWPivbEjZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11535"; a="61274912"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="61274912"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 03:09:31 -0700
X-CSE-ConnectionGUID: rsu3t1ojQMS7IvmwHVAKlw==
X-CSE-MsgGUID: EIqHOP1HTCWoy/7LAwvaWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="169972362"
Received: from os-delivery.igk.intel.com ([10.102.18.218])
  by orviesa007.jf.intel.com with ESMTP; 28 Aug 2025 03:09:28 -0700
From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	stable@vger.kernel.org,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH iwl-net v1 3/4] ixgbevf: fix mailbox API compatibility by negotiating supported features
Date: Thu, 28 Aug 2025 11:52:26 +0200
Message-Id: <20250828095227.1857066-4-jedrzej.jagielski@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250828095227.1857066-1-jedrzej.jagielski@intel.com>
References: <20250828095227.1857066-1-jedrzej.jagielski@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There was backward compatibility in the terms of mailbox API. Various
drivers from various OSes supporting 10G adapters from Intel portfolio
could easily negotiate mailbox API.

This convention has been broken since introducing API 1.4.
Commit 0062e7cc955e ("ixgbevf: add VF IPsec offload code") added support
for IPSec which is specific only for the kernel ixgbe driver. None of the
rest of the Intel 10G PF/VF drivers supports it. And actually lack of
support was not included in the IPSec implementation - there were no such
code paths. No possibility to negotiate support for the feature was
introduced along with introduction of the feature itself.

Commit 339f28964147 ("ixgbevf: Add support for new mailbox communication
between PF and VF") increasing API version to 1.5 did the same - it
introduced code supported specifically by the PF ESX driver. It altered API
version for the VF driver in the same time not touching the version
defined for the PF ixgbe driver. It led to additional discrepancies,
as the code provided within API 1.6 cannot be supported for Linux ixgbe
driver as it causes crashes.

The issue was noticed some time ago and mitigated by Jake within the commit
d0725312adf5 ("ixgbevf: stop attempting IPSEC offload on Mailbox API 1.5").
As a result we have regression for IPsec support and after increasing API
to version 1.6 ixgbevf driver stopped to support ESX MBX.

To fix this mess add new mailbox op asking PF driver about supported
features. Basing on a response determine whether to set support for IPSec
and ESX-specific enhanced mailbox.

New mailbox op, for compatibility purposes, must be added within new API
revision, as API version of OOT PF & VF drivers is already increased to
1.6 and doesn't incorporate features negotiate op.

Features negotiation mechanism gives possibility to be extended with new
features when needed in the future.

Reported-by: Jacob Keller <jacob.e.keller@intel.com>
Fixes: 0062e7cc955e ("ixgbevf: add VF IPsec offload code")
Fixes: 339f28964147 ("ixgbevf: Add support for new mailbox communication between PF and VF")
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: stable@vger.kernel.org
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
---
 drivers/net/ethernet/intel/ixgbevf/ipsec.c    | 10 +++++
 drivers/net/ethernet/intel/ixgbevf/ixgbevf.h  |  7 +++
 .../net/ethernet/intel/ixgbevf/ixgbevf_main.c | 32 ++++++++++++-
 drivers/net/ethernet/intel/ixgbevf/mbx.h      |  4 ++
 drivers/net/ethernet/intel/ixgbevf/vf.c       | 45 ++++++++++++++++++-
 drivers/net/ethernet/intel/ixgbevf/vf.h       |  1 +
 6 files changed, 96 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbevf/ipsec.c b/drivers/net/ethernet/intel/ixgbevf/ipsec.c
index 65580b9cb06f..fce35924ff8b 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ipsec.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ipsec.c
@@ -273,6 +273,9 @@ static int ixgbevf_ipsec_add_sa(struct net_device *dev,
 	adapter = netdev_priv(dev);
 	ipsec = adapter->ipsec;
 
+	if (!(adapter->pf_features & IXGBEVF_PF_SUP_IPSEC))
+		return -EOPNOTSUPP;
+
 	if (xs->id.proto != IPPROTO_ESP && xs->id.proto != IPPROTO_AH) {
 		NL_SET_ERR_MSG_MOD(extack, "Unsupported protocol for IPsec offload");
 		return -EINVAL;
@@ -405,6 +408,9 @@ static void ixgbevf_ipsec_del_sa(struct net_device *dev,
 	adapter = netdev_priv(dev);
 	ipsec = adapter->ipsec;
 
+	if (!(adapter->pf_features & IXGBEVF_PF_SUP_IPSEC))
+		return;
+
 	if (xs->xso.dir == XFRM_DEV_OFFLOAD_IN) {
 		sa_idx = xs->xso.offload_handle - IXGBE_IPSEC_BASE_RX_INDEX;
 
@@ -612,6 +618,10 @@ void ixgbevf_init_ipsec_offload(struct ixgbevf_adapter *adapter)
 	size_t size;
 
 	switch (adapter->hw.api_version) {
+	case ixgbe_mbox_api_17:
+		if (!(adapter->pf_features & IXGBEVF_PF_SUP_IPSEC))
+			return;
+		break;
 	case ixgbe_mbox_api_14:
 		break;
 	default:
diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h b/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
index 4384e892f967..96726e36b251 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
@@ -366,6 +366,13 @@ struct ixgbevf_adapter {
 	/* Interrupt Throttle Rate */
 	u32 eitr_param;
 
+	u32 pf_features;
+#define IXGBEVF_PF_SUP_IPSEC		BIT(0)
+#define IXGBEVF_PF_SUP_ESX_MBX		BIT(1)
+
+#define IXGBEVF_SUPPORTED_FEATURES	(IXGBEVF_PF_SUP_IPSEC | \
+					IXGBEVF_PF_SUP_ESX_MBX)
+
 	struct ixgbevf_hw_stats stats;
 
 	unsigned long state;
diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index 574714764791..1ecfbbb95210 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -2271,10 +2271,35 @@ static void ixgbevf_init_last_counter_stats(struct ixgbevf_adapter *adapter)
 	adapter->stats.base_vfmprc = adapter->stats.last_vfmprc;
 }
 
+/**
+ * ixgbevf_set_features - Set features supported by PF
+ * @adapter: pointer to the adapter struct
+ *
+ * Negotiate with PF supported features and then set pf_features accordingly.
+ */
+static void ixgbevf_set_features(struct ixgbevf_adapter *adapter)
+{
+	u32 *pf_features = &adapter->pf_features;
+	struct ixgbe_hw *hw = &adapter->hw;
+	int err;
+
+	err = hw->mac.ops.negotiate_features(hw, pf_features);
+	if (err && err != -EOPNOTSUPP)
+		netdev_dbg(adapter->netdev,
+			   "PF feature negotiation failed.\n");
+
+	/* Address also pre API 1.7 cases */
+	if (hw->api_version == ixgbe_mbox_api_14)
+		*pf_features |= IXGBEVF_PF_SUP_IPSEC;
+	else if (hw->api_version == ixgbe_mbox_api_15)
+		*pf_features |= IXGBEVF_PF_SUP_ESX_MBX;
+}
+
 static void ixgbevf_negotiate_api(struct ixgbevf_adapter *adapter)
 {
 	struct ixgbe_hw *hw = &adapter->hw;
 	static const int api[] = {
+		ixgbe_mbox_api_17,
 		ixgbe_mbox_api_16,
 		ixgbe_mbox_api_15,
 		ixgbe_mbox_api_14,
@@ -2295,8 +2320,9 @@ static void ixgbevf_negotiate_api(struct ixgbevf_adapter *adapter)
 		idx++;
 	}
 
-	/* Following is not supported by API 1.6, it is specific for 1.5 */
-	if (hw->api_version == ixgbe_mbox_api_15) {
+	ixgbevf_set_features(adapter);
+
+	if (adapter->pf_features & IXGBEVF_PF_SUP_ESX_MBX) {
 		hw->mbx.ops.init_params(hw);
 		memcpy(&hw->mbx.ops, &ixgbevf_mbx_ops,
 		       sizeof(struct ixgbe_mbx_operations));
@@ -2654,6 +2680,7 @@ static void ixgbevf_set_num_queues(struct ixgbevf_adapter *adapter)
 		case ixgbe_mbox_api_14:
 		case ixgbe_mbox_api_15:
 		case ixgbe_mbox_api_16:
+		case ixgbe_mbox_api_17:
 			if (adapter->xdp_prog &&
 			    hw->mac.max_tx_queues == rss)
 				rss = rss > 3 ? 2 : 1;
@@ -4649,6 +4676,7 @@ static int ixgbevf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	case ixgbe_mbox_api_14:
 	case ixgbe_mbox_api_15:
 	case ixgbe_mbox_api_16:
+	case ixgbe_mbox_api_17:
 		netdev->max_mtu = IXGBE_MAX_JUMBO_FRAME_SIZE -
 				  (ETH_HLEN + ETH_FCS_LEN);
 		break;
diff --git a/drivers/net/ethernet/intel/ixgbevf/mbx.h b/drivers/net/ethernet/intel/ixgbevf/mbx.h
index c1494fd1f67b..a8ed23ee66aa 100644
--- a/drivers/net/ethernet/intel/ixgbevf/mbx.h
+++ b/drivers/net/ethernet/intel/ixgbevf/mbx.h
@@ -67,6 +67,7 @@ enum ixgbe_pfvf_api_rev {
 	ixgbe_mbox_api_14,	/* API version 1.4, linux/freebsd VF driver */
 	ixgbe_mbox_api_15,	/* API version 1.5, linux/freebsd VF driver */
 	ixgbe_mbox_api_16,      /* API version 1.6, linux/freebsd VF driver */
+	ixgbe_mbox_api_17,	/* API version 1.7, linux/freebsd VF driver */
 	/* This value should always be last */
 	ixgbe_mbox_api_unknown,	/* indicates that API version is not known */
 };
@@ -106,6 +107,9 @@ enum ixgbe_pfvf_api_rev {
 /* mailbox API, version 1.6 VF requests */
 #define IXGBE_VF_GET_PF_LINK_STATE	0x11 /* request PF to send link info */
 
+/* mailbox API, version 1.7 VF requests */
+#define IXGBE_VF_FEATURES_NEGOTIATE	0x12 /* get features supported by PF*/
+
 /* length of permanent address message returned from PF */
 #define IXGBE_VF_PERMADDR_MSG_LEN	4
 /* word in permanent address message with the current multicast type */
diff --git a/drivers/net/ethernet/intel/ixgbevf/vf.c b/drivers/net/ethernet/intel/ixgbevf/vf.c
index 55ac79f87438..c4c7db339b99 100644
--- a/drivers/net/ethernet/intel/ixgbevf/vf.c
+++ b/drivers/net/ethernet/intel/ixgbevf/vf.c
@@ -313,6 +313,7 @@ int ixgbevf_get_reta_locked(struct ixgbe_hw *hw, u32 *reta, int num_rx_queues)
 	 * is not supported for this device type.
 	 */
 	switch (hw->api_version) {
+	case ixgbe_mbox_api_17:
 	case ixgbe_mbox_api_16:
 	case ixgbe_mbox_api_15:
 	case ixgbe_mbox_api_14:
@@ -383,6 +384,7 @@ int ixgbevf_get_rss_key_locked(struct ixgbe_hw *hw, u8 *rss_key)
 	 * or if the operation is not supported for this device type.
 	 */
 	switch (hw->api_version) {
+	case ixgbe_mbox_api_17:
 	case ixgbe_mbox_api_16:
 	case ixgbe_mbox_api_15:
 	case ixgbe_mbox_api_14:
@@ -555,6 +557,7 @@ static s32 ixgbevf_update_xcast_mode(struct ixgbe_hw *hw, int xcast_mode)
 	case ixgbe_mbox_api_14:
 	case ixgbe_mbox_api_15:
 	case ixgbe_mbox_api_16:
+	case ixgbe_mbox_api_17:
 		break;
 	default:
 		return -EOPNOTSUPP;
@@ -646,6 +649,7 @@ static int ixgbevf_get_pf_link_state(struct ixgbe_hw *hw, ixgbe_link_speed *spee
 
 	switch (hw->api_version) {
 	case ixgbe_mbox_api_16:
+	case ixgbe_mbox_api_17:
 		break;
 	default:
 		return -EOPNOTSUPP;
@@ -669,6 +673,42 @@ static int ixgbevf_get_pf_link_state(struct ixgbe_hw *hw, ixgbe_link_speed *spee
 	return err;
 }
 
+/**
+ * ixgbevf_negotiate_features_vf - negotiate supported features with PF driver
+ * @hw: pointer to the HW structure
+ * @pf_features - bitmask of features supported by PF
+ *
+ * Return: IXGBE_ERR_MBX in the  case of mailbox error,
+ * -EOPNOTSUPP if the op is not supported or 0 on success.
+ */
+static int ixgbevf_negotiate_features_vf(struct ixgbe_hw *hw, u32 *pf_features)
+{
+	u32 msgbuf[2] = {};
+	int err;
+
+	switch (hw->api_version) {
+	case ixgbe_mbox_api_17:
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	msgbuf[0] = IXGBE_VF_FEATURES_NEGOTIATE;
+	msgbuf[1] = IXGBEVF_SUPPORTED_FEATURES;
+
+	err = ixgbevf_write_msg_read_ack(hw, msgbuf, msgbuf,
+					 ARRAY_SIZE(msgbuf));
+
+	if (err || (msgbuf[0] & IXGBE_VT_MSGTYPE_FAILURE)) {
+		err = IXGBE_ERR_MBX;
+		*pf_features = 0x0;
+	} else {
+		*pf_features = msgbuf[1];
+	}
+
+	return err;
+}
+
 /**
  *  ixgbevf_set_vfta_vf - Set/Unset VLAN filter table address
  *  @hw: pointer to the HW structure
@@ -799,6 +839,7 @@ static s32 ixgbevf_check_mac_link_vf(struct ixgbe_hw *hw,
 				     bool *link_up,
 				     bool autoneg_wait_to_complete)
 {
+	struct ixgbevf_adapter *adapter = hw->back;
 	struct ixgbe_mbx_info *mbx = &hw->mbx;
 	struct ixgbe_mac_info *mac = &hw->mac;
 	s32 ret_val = 0;
@@ -825,7 +866,7 @@ static s32 ixgbevf_check_mac_link_vf(struct ixgbe_hw *hw,
 	 * until we are called again and don't report an error
 	 */
 	if (mbx->ops.read(hw, &in_msg, 1)) {
-		if (hw->api_version >= ixgbe_mbox_api_15)
+		if (adapter->pf_features & IXGBEVF_PF_SUP_ESX_MBX)
 			mac->get_link_status = false;
 		goto out;
 	}
@@ -1026,6 +1067,7 @@ int ixgbevf_get_queues(struct ixgbe_hw *hw, unsigned int *num_tcs,
 	case ixgbe_mbox_api_14:
 	case ixgbe_mbox_api_15:
 	case ixgbe_mbox_api_16:
+	case ixgbe_mbox_api_17:
 		break;
 	default:
 		return 0;
@@ -1080,6 +1122,7 @@ static const struct ixgbe_mac_operations ixgbevf_mac_ops = {
 	.setup_link		= ixgbevf_setup_mac_link_vf,
 	.check_link		= ixgbevf_check_mac_link_vf,
 	.negotiate_api_version	= ixgbevf_negotiate_api_version_vf,
+	.negotiate_features	= ixgbevf_negotiate_features_vf,
 	.set_rar		= ixgbevf_set_rar_vf,
 	.update_mc_addr_list	= ixgbevf_update_mc_addr_list_vf,
 	.update_xcast_mode	= ixgbevf_update_xcast_mode,
diff --git a/drivers/net/ethernet/intel/ixgbevf/vf.h b/drivers/net/ethernet/intel/ixgbevf/vf.h
index 2d791bc26ae4..4f19b8900c29 100644
--- a/drivers/net/ethernet/intel/ixgbevf/vf.h
+++ b/drivers/net/ethernet/intel/ixgbevf/vf.h
@@ -26,6 +26,7 @@ struct ixgbe_mac_operations {
 	s32 (*stop_adapter)(struct ixgbe_hw *);
 	s32 (*get_bus_info)(struct ixgbe_hw *);
 	s32 (*negotiate_api_version)(struct ixgbe_hw *hw, int api);
+	int (*negotiate_features)(struct ixgbe_hw *hw, u32 *pf_features);
 
 	/* Link */
 	s32 (*setup_link)(struct ixgbe_hw *, ixgbe_link_speed, bool, bool);
-- 
2.31.1


