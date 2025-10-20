Return-Path: <stable+bounces-188239-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3E9BF34A9
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 21:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06937485C4E
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 19:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540C82C15B0;
	Mon, 20 Oct 2025 19:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YaDZRiEI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BBC25394B
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 19:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760990035; cv=none; b=KwX9CqjxD0GRiZP0sM1YBehybKR8i4fB1zSpbAg74P6DP+P3xaJlEjwJt4OjwoUlnCJ7Yy5EOxVo+fmT+vyqYb/TBBQvfBLsgOIW7gZILf0D4AXv7CKw3lkXikSV/B2B45auv46bYSQLcpexE0rHvd7CVRM1ahfZ8rBkMNmcpeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760990035; c=relaxed/simple;
	bh=2TSfTXjlzp29Qau6L5o6DBhaJ0yF+oVXVh+CsRUOgwc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AHRDn3c4CNl2rQL1k3EMMyqHlCX1jDvJBfIQOBhbgQQC4wH1QKfGudxQvBOtKfdz+2nAF/rna9asWy4/ARCADSqBtjvhyZ1EBlLwtNJau+avLMz8WrYvqB1ZbU0HOWYBvs4CO2Bfyl50fAqEnKgwmr9iqb/dOkdn/Tnc7waggD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YaDZRiEI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A822DC116C6;
	Mon, 20 Oct 2025 19:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760990034;
	bh=2TSfTXjlzp29Qau6L5o6DBhaJ0yF+oVXVh+CsRUOgwc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YaDZRiEIDF4lzno04R1WqZ3emUTIIQghHj+7qaqkQMD5ywuRQxTR+7JGSVJFDfxl3
	 Q5/mxPl6HKAStHSVTrjOjviGPIh81GdtQdOT/B2Z9sWlgKQKojhdnqqnpU9jCnpD65
	 4eSCGNXCqivKrh2ynKR5fr4uXN+38rBY6ThN6DNR7jzzHY/fVAIJiLklhtr5WJROBB
	 KjUTMpbB6FwYt7SERG5vBQEZ0h/1g7tFSuBA+5bD+3Q5rNN5Y5jxRflIgSeDkhnMqZ
	 93RFfF8+vRiYar0R8nfTAQeRd7p89Vs3HysOizFXYg7EPAqaTYTsmIVw9VT38dDyz7
	 bcLBy+ga6Ga2A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 4/4] ixgbevf: fix mailbox API compatibility by negotiating supported features
Date: Mon, 20 Oct 2025 15:53:48 -0400
Message-ID: <20251020195348.1882212-4-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020195348.1882212-1-sashal@kernel.org>
References: <2025102053-upheld-recess-9b2f@gregkh>
 <20251020195348.1882212-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>

[ Upstream commit a7075f501bd33c93570af759b6f4302ef0175168 ]

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
Closes: https://lore.kernel.org/intel-wired-lan/20241101-jk-ixgbevf-mailbox-v1-5-fixes-v1-0-f556dc9a66ed@intel.com/
Fixes: 0062e7cc955e ("ixgbevf: add VF IPsec offload code")
Fixes: 339f28964147 ("ixgbevf: Add support for new mailbox communication between PF and VF")
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: stable@vger.kernel.org
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Link: https://patch.msgid.link/20251009-jk-iwl-net-2025-10-01-v3-4-ef32a425b92a@intel.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ixgbevf/ipsec.c    | 10 +++++
 drivers/net/ethernet/intel/ixgbevf/ixgbevf.h  |  7 +++
 .../net/ethernet/intel/ixgbevf/ixgbevf_main.c | 32 ++++++++++++-
 drivers/net/ethernet/intel/ixgbevf/mbx.h      |  4 ++
 drivers/net/ethernet/intel/ixgbevf/vf.c       | 45 ++++++++++++++++++-
 drivers/net/ethernet/intel/ixgbevf/vf.h       |  1 +
 6 files changed, 96 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbevf/ipsec.c b/drivers/net/ethernet/intel/ixgbevf/ipsec.c
index 74c121d7abc90..9e92c7732c7bc 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ipsec.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ipsec.c
@@ -269,6 +269,9 @@ static int ixgbevf_ipsec_add_sa(struct xfrm_state *xs)
 	adapter = netdev_priv(dev);
 	ipsec = adapter->ipsec;
 
+	if (!(adapter->pf_features & IXGBEVF_PF_SUP_IPSEC))
+		return -EOPNOTSUPP;
+
 	if (xs->id.proto != IPPROTO_ESP && xs->id.proto != IPPROTO_AH) {
 		netdev_err(dev, "Unsupported protocol 0x%04x for IPsec offload\n",
 			   xs->id.proto);
@@ -394,6 +397,9 @@ static void ixgbevf_ipsec_del_sa(struct xfrm_state *xs)
 	adapter = netdev_priv(dev);
 	ipsec = adapter->ipsec;
 
+	if (!(adapter->pf_features & IXGBEVF_PF_SUP_IPSEC))
+		return;
+
 	if (xs->xso.dir == XFRM_DEV_OFFLOAD_IN) {
 		sa_idx = xs->xso.offload_handle - IXGBE_IPSEC_BASE_RX_INDEX;
 
@@ -622,6 +628,10 @@ void ixgbevf_init_ipsec_offload(struct ixgbevf_adapter *adapter)
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
index ca2d61c43b5e9..1e25598cc778d 100644
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
index 6f06e70bc70c8..290207f158081 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -2268,10 +2268,35 @@ static void ixgbevf_init_last_counter_stats(struct ixgbevf_adapter *adapter)
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
@@ -2292,8 +2317,9 @@ static void ixgbevf_negotiate_api(struct ixgbevf_adapter *adapter)
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
@@ -2651,6 +2677,7 @@ static void ixgbevf_set_num_queues(struct ixgbevf_adapter *adapter)
 		case ixgbe_mbox_api_14:
 		case ixgbe_mbox_api_15:
 		case ixgbe_mbox_api_16:
+		case ixgbe_mbox_api_17:
 			if (adapter->xdp_prog &&
 			    hw->mac.max_tx_queues == rss)
 				rss = rss > 3 ? 2 : 1;
@@ -4645,6 +4672,7 @@ static int ixgbevf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	case ixgbe_mbox_api_14:
 	case ixgbe_mbox_api_15:
 	case ixgbe_mbox_api_16:
+	case ixgbe_mbox_api_17:
 		netdev->max_mtu = IXGBE_MAX_JUMBO_FRAME_SIZE -
 				  (ETH_HLEN + ETH_FCS_LEN);
 		break;
diff --git a/drivers/net/ethernet/intel/ixgbevf/mbx.h b/drivers/net/ethernet/intel/ixgbevf/mbx.h
index c1494fd1f67b4..a8ed23ee66aa8 100644
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
index 55ac79f87438f..65257107dfc8a 100644
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
+ * @pf_features: bitmask of features supported by PF
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
index 2d791bc26ae4e..4f19b8900c29a 100644
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
2.51.0


