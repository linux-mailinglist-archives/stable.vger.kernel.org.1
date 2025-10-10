Return-Path: <stable+bounces-183847-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A147CBCB3FF
	for <lists+stable@lfdr.de>; Fri, 10 Oct 2025 02:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 61DF34EB874
	for <lists+stable@lfdr.de>; Fri, 10 Oct 2025 00:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD0D18DB1F;
	Fri, 10 Oct 2025 00:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i/Iy/c0X"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18F134BA24;
	Fri, 10 Oct 2025 00:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760054654; cv=none; b=JhlInUsk8JSI6l6JPU48S853oSpSl2QWjtEgDTjpWnpmLe/ljFrZHtmH7UQEVHm/zA0sjDsYqq05oIefG/dwwwCpeXdQ899hNtkO3nNrBWj73tJFiyQumYnbD3O6ZCG6ywzjrWx0QGHfCTcXRMBBrstBYci1w7Jc1s/Hv29TDH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760054654; c=relaxed/simple;
	bh=5Tr8aaEfST++XTnJZ+/WJ9wbOB3+Va5EmnEF0PMJm/s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d8H8deBAlwZVoWDnM3LeQfWzizyZJrQ6PEeO/cAE4ObbnEjStt/EI3RSSjhvoN4dpZBZ8fw4OE82ns9STYFnpTT/ok05LUDacSkphwaDwW4f1PGaXtf1fj5akoRGhfPa0H68Gkg0Azuvr6Razbx9LG98rGzpXSeEv+woRvjmQLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i/Iy/c0X; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760054652; x=1791590652;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=5Tr8aaEfST++XTnJZ+/WJ9wbOB3+Va5EmnEF0PMJm/s=;
  b=i/Iy/c0XQAeKC3VZegaQ5kyOTz2gKye7+g5DBvEBTZz+fD4Tvg1OcIoE
   LRctQxx5T1LFhYsiiJZg6cX5quUzCorqdyAj9hr2NdGt+vUB8tRssyzQL
   Uyg+lM5ADfTdImMhL2OZgEcq8CswrE3jkM8ZQhxcZpnDXNbVfXgo4jJ6R
   aUMT3nQQiFRn83YLFQiNspuNEmrilaqtCJvntKK0iiUwNOzDWQudBN3me
   az0VrLdhzYel2NCfRol8Ec4hpsU1leDue0/LHHRYdSpxH31Y725kkeoVr
   61AxreW1b21b61HFm8LGD5DLgUtyy1AQDHCaE40wUsBfmraQjjfZTiVLC
   Q==;
X-CSE-ConnectionGUID: NjHVu5ctTA6y7anlhXxSMQ==
X-CSE-MsgGUID: NKjCiGxmSx2Ymc6z+NhnQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11577"; a="62316077"
X-IronPort-AV: E=Sophos;i="6.19,217,1754982000"; 
   d="scan'208";a="62316077"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2025 17:04:09 -0700
X-CSE-ConnectionGUID: IbRwUlrTRISVXeRQrbF+AQ==
X-CSE-MsgGUID: Jkq6rybpR3qFIKcdIn/g3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,217,1754982000"; 
   d="scan'208";a="180858272"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.70]) ([10.166.28.70])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2025 17:04:09 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu, 09 Oct 2025 17:03:47 -0700
Subject: [PATCH net v3 2/6] ixgbevf: fix getting link speed data for E610
 devices
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251009-jk-iwl-net-2025-10-01-v3-2-ef32a425b92a@intel.com>
References: <20251009-jk-iwl-net-2025-10-01-v3-0-ef32a425b92a@intel.com>
In-Reply-To: <20251009-jk-iwl-net-2025-10-01-v3-0-ef32a425b92a@intel.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Emil Tantilov <emil.s.tantilov@intel.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>, 
 Willem de Bruijn <willemb@google.com>, 
 Sridhar Samudrala <sridhar.samudrala@intel.com>, 
 Phani Burra <phani.r.burra@intel.com>, 
 Piotr Kwapulinski <piotr.kwapulinski@intel.com>, 
 Simon Horman <horms@kernel.org>, Radoslaw Tyl <radoslawx.tyl@intel.com>, 
 Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Cc: Konstantin Ilichev <konstantin.ilichev@intel.com>, 
 Milena Olech <milena.olech@intel.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, stable@vger.kernel.org, 
 Rafal Romanowski <rafal.romanowski@intel.com>
X-Mailer: b4 0.15-dev-89294
X-Developer-Signature: v=1; a=openpgp-sha256; l=10342;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=0gDafKMo5QWGyYkGwUnZJAglRZV0MGwTmXbBQH/2bMQ=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhowXvuVd+kpVC/5Mratncvd22946/UVbxwq9RoGjolvMy
 y84yip0lLIwiHExyIopsig4hKy8bjwhTOuNsxzMHFYmkCEMXJwCMJHviQz/M9dOLDrYb7uH03jl
 cuX/M00S+VoS99yq0p7sM7X9yHkZfYb/Dvckwxjez3odp3FjyY4Dn6YcqT/mJjkptOJkbJSxtFo
 EMwA=
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8

From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>

E610 adapters no longer use the VFLINKS register to read PF's link
speed and linkup state. As a result VF driver cannot get actual link
state and it incorrectly reports 10G which is the default option.
It leads to a situation where even 1G adapters print 10G as actual
link speed. The same happens when PF driver set speed different than 10G.

Add new mailbox operation to let the VF driver request a PF driver
to provide actual link data. Update the mailbox api to v1.6.

Incorporate both ways of getting link status within the legacy
ixgbe_check_mac_link_vf() function.

Fixes: 4c44b450c69b ("ixgbevf: Add support for Intel(R) E610 device")
Co-developed-by: Andrzej Wilczynski <andrzejx.wilczynski@intel.com>
Signed-off-by: Andrzej Wilczynski <andrzejx.wilczynski@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: stable@vger.kernel.org
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ixgbevf/defines.h      |   1 +
 drivers/net/ethernet/intel/ixgbevf/mbx.h          |   4 +
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c |   6 +-
 drivers/net/ethernet/intel/ixgbevf/vf.c           | 137 +++++++++++++++++-----
 4 files changed, 116 insertions(+), 32 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbevf/defines.h b/drivers/net/ethernet/intel/ixgbevf/defines.h
index a9bc96f6399d..e177d1d58696 100644
--- a/drivers/net/ethernet/intel/ixgbevf/defines.h
+++ b/drivers/net/ethernet/intel/ixgbevf/defines.h
@@ -28,6 +28,7 @@
 
 /* Link speed */
 typedef u32 ixgbe_link_speed;
+#define IXGBE_LINK_SPEED_UNKNOWN	0
 #define IXGBE_LINK_SPEED_1GB_FULL	0x0020
 #define IXGBE_LINK_SPEED_10GB_FULL	0x0080
 #define IXGBE_LINK_SPEED_100_FULL	0x0008
diff --git a/drivers/net/ethernet/intel/ixgbevf/mbx.h b/drivers/net/ethernet/intel/ixgbevf/mbx.h
index 835bbcc5cc8e..c1494fd1f67b 100644
--- a/drivers/net/ethernet/intel/ixgbevf/mbx.h
+++ b/drivers/net/ethernet/intel/ixgbevf/mbx.h
@@ -66,6 +66,7 @@ enum ixgbe_pfvf_api_rev {
 	ixgbe_mbox_api_13,	/* API version 1.3, linux/freebsd VF driver */
 	ixgbe_mbox_api_14,	/* API version 1.4, linux/freebsd VF driver */
 	ixgbe_mbox_api_15,	/* API version 1.5, linux/freebsd VF driver */
+	ixgbe_mbox_api_16,      /* API version 1.6, linux/freebsd VF driver */
 	/* This value should always be last */
 	ixgbe_mbox_api_unknown,	/* indicates that API version is not known */
 };
@@ -102,6 +103,9 @@ enum ixgbe_pfvf_api_rev {
 
 #define IXGBE_VF_GET_LINK_STATE 0x10 /* get vf link state */
 
+/* mailbox API, version 1.6 VF requests */
+#define IXGBE_VF_GET_PF_LINK_STATE	0x11 /* request PF to send link info */
+
 /* length of permanent address message returned from PF */
 #define IXGBE_VF_PERMADDR_MSG_LEN	4
 /* word in permanent address message with the current multicast type */
diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index 28e25641b167..92671638b428 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -2275,6 +2275,7 @@ static void ixgbevf_negotiate_api(struct ixgbevf_adapter *adapter)
 {
 	struct ixgbe_hw *hw = &adapter->hw;
 	static const int api[] = {
+		ixgbe_mbox_api_16,
 		ixgbe_mbox_api_15,
 		ixgbe_mbox_api_14,
 		ixgbe_mbox_api_13,
@@ -2294,7 +2295,8 @@ static void ixgbevf_negotiate_api(struct ixgbevf_adapter *adapter)
 		idx++;
 	}
 
-	if (hw->api_version >= ixgbe_mbox_api_15) {
+	/* Following is not supported by API 1.6, it is specific for 1.5 */
+	if (hw->api_version == ixgbe_mbox_api_15) {
 		hw->mbx.ops.init_params(hw);
 		memcpy(&hw->mbx.ops, &ixgbevf_mbx_ops,
 		       sizeof(struct ixgbe_mbx_operations));
@@ -2651,6 +2653,7 @@ static void ixgbevf_set_num_queues(struct ixgbevf_adapter *adapter)
 		case ixgbe_mbox_api_13:
 		case ixgbe_mbox_api_14:
 		case ixgbe_mbox_api_15:
+		case ixgbe_mbox_api_16:
 			if (adapter->xdp_prog &&
 			    hw->mac.max_tx_queues == rss)
 				rss = rss > 3 ? 2 : 1;
@@ -4645,6 +4648,7 @@ static int ixgbevf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	case ixgbe_mbox_api_13:
 	case ixgbe_mbox_api_14:
 	case ixgbe_mbox_api_15:
+	case ixgbe_mbox_api_16:
 		netdev->max_mtu = IXGBE_MAX_JUMBO_FRAME_SIZE -
 				  (ETH_HLEN + ETH_FCS_LEN);
 		break;
diff --git a/drivers/net/ethernet/intel/ixgbevf/vf.c b/drivers/net/ethernet/intel/ixgbevf/vf.c
index dcaef34b88b6..f05246fb5a74 100644
--- a/drivers/net/ethernet/intel/ixgbevf/vf.c
+++ b/drivers/net/ethernet/intel/ixgbevf/vf.c
@@ -313,6 +313,7 @@ int ixgbevf_get_reta_locked(struct ixgbe_hw *hw, u32 *reta, int num_rx_queues)
 	 * is not supported for this device type.
 	 */
 	switch (hw->api_version) {
+	case ixgbe_mbox_api_16:
 	case ixgbe_mbox_api_15:
 	case ixgbe_mbox_api_14:
 	case ixgbe_mbox_api_13:
@@ -382,6 +383,7 @@ int ixgbevf_get_rss_key_locked(struct ixgbe_hw *hw, u8 *rss_key)
 	 * or if the operation is not supported for this device type.
 	 */
 	switch (hw->api_version) {
+	case ixgbe_mbox_api_16:
 	case ixgbe_mbox_api_15:
 	case ixgbe_mbox_api_14:
 	case ixgbe_mbox_api_13:
@@ -552,6 +554,7 @@ static s32 ixgbevf_update_xcast_mode(struct ixgbe_hw *hw, int xcast_mode)
 	case ixgbe_mbox_api_13:
 	case ixgbe_mbox_api_14:
 	case ixgbe_mbox_api_15:
+	case ixgbe_mbox_api_16:
 		break;
 	default:
 		return -EOPNOTSUPP;
@@ -624,6 +627,48 @@ static s32 ixgbevf_hv_get_link_state_vf(struct ixgbe_hw *hw, bool *link_state)
 	return -EOPNOTSUPP;
 }
 
+/**
+ * ixgbevf_get_pf_link_state - Get PF's link status
+ * @hw: pointer to the HW structure
+ * @speed: link speed
+ * @link_up: indicate if link is up/down
+ *
+ * Ask PF to provide link_up state and speed of the link.
+ *
+ * Return: IXGBE_ERR_MBX in the case of mailbox error,
+ * -EOPNOTSUPP if the op is not supported or 0 on success.
+ */
+static int ixgbevf_get_pf_link_state(struct ixgbe_hw *hw, ixgbe_link_speed *speed,
+				     bool *link_up)
+{
+	u32 msgbuf[3] = {};
+	int err;
+
+	switch (hw->api_version) {
+	case ixgbe_mbox_api_16:
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	msgbuf[0] = IXGBE_VF_GET_PF_LINK_STATE;
+
+	err = ixgbevf_write_msg_read_ack(hw, msgbuf, msgbuf,
+					 ARRAY_SIZE(msgbuf));
+	if (err || (msgbuf[0] & IXGBE_VT_MSGTYPE_FAILURE)) {
+		err = IXGBE_ERR_MBX;
+		*speed = IXGBE_LINK_SPEED_UNKNOWN;
+		/* No need to set @link_up to false as it will be done by
+		 * ixgbe_check_mac_link_vf().
+		 */
+	} else {
+		*speed = msgbuf[1];
+		*link_up = msgbuf[2];
+	}
+
+	return err;
+}
+
 /**
  *  ixgbevf_set_vfta_vf - Set/Unset VLAN filter table address
  *  @hw: pointer to the HW structure
@@ -658,6 +703,58 @@ static s32 ixgbevf_set_vfta_vf(struct ixgbe_hw *hw, u32 vlan, u32 vind,
 	return err;
 }
 
+/**
+ * ixgbe_read_vflinks - Read VFLINKS register
+ * @hw: pointer to the HW structure
+ * @speed: link speed
+ * @link_up: indicate if link is up/down
+ *
+ * Get linkup status and link speed from the VFLINKS register.
+ */
+static void ixgbe_read_vflinks(struct ixgbe_hw *hw, ixgbe_link_speed *speed,
+			       bool *link_up)
+{
+	u32 vflinks = IXGBE_READ_REG(hw, IXGBE_VFLINKS);
+
+	/* if link status is down no point in checking to see if PF is up */
+	if (!(vflinks & IXGBE_LINKS_UP)) {
+		*link_up = false;
+		return;
+	}
+
+	/* for SFP+ modules and DA cables on 82599 it can take up to 500usecs
+	 * before the link status is correct
+	 */
+	if (hw->mac.type == ixgbe_mac_82599_vf) {
+		for (int i = 0; i < 5; i++) {
+			udelay(100);
+			vflinks = IXGBE_READ_REG(hw, IXGBE_VFLINKS);
+
+			if (!(vflinks & IXGBE_LINKS_UP)) {
+				*link_up = false;
+				return;
+			}
+		}
+	}
+
+	/* We reached this point so there's link */
+	*link_up = true;
+
+	switch (vflinks & IXGBE_LINKS_SPEED_82599) {
+	case IXGBE_LINKS_SPEED_10G_82599:
+		*speed = IXGBE_LINK_SPEED_10GB_FULL;
+		break;
+	case IXGBE_LINKS_SPEED_1G_82599:
+		*speed = IXGBE_LINK_SPEED_1GB_FULL;
+		break;
+	case IXGBE_LINKS_SPEED_100_82599:
+		*speed = IXGBE_LINK_SPEED_100_FULL;
+		break;
+	default:
+		*speed = IXGBE_LINK_SPEED_UNKNOWN;
+	}
+}
+
 /**
  * ixgbevf_hv_set_vfta_vf - * Hyper-V variant - just a stub.
  * @hw: unused
@@ -705,7 +802,6 @@ static s32 ixgbevf_check_mac_link_vf(struct ixgbe_hw *hw,
 	struct ixgbe_mbx_info *mbx = &hw->mbx;
 	struct ixgbe_mac_info *mac = &hw->mac;
 	s32 ret_val = 0;
-	u32 links_reg;
 	u32 in_msg = 0;
 
 	/* If we were hit with a reset drop the link */
@@ -715,36 +811,14 @@ static s32 ixgbevf_check_mac_link_vf(struct ixgbe_hw *hw,
 	if (!mac->get_link_status)
 		goto out;
 
-	/* if link status is down no point in checking to see if pf is up */
-	links_reg = IXGBE_READ_REG(hw, IXGBE_VFLINKS);
-	if (!(links_reg & IXGBE_LINKS_UP))
-		goto out;
-
-	/* for SFP+ modules and DA cables on 82599 it can take up to 500usecs
-	 * before the link status is correct
-	 */
-	if (mac->type == ixgbe_mac_82599_vf) {
-		int i;
-
-		for (i = 0; i < 5; i++) {
-			udelay(100);
-			links_reg = IXGBE_READ_REG(hw, IXGBE_VFLINKS);
-
-			if (!(links_reg & IXGBE_LINKS_UP))
-				goto out;
-		}
-	}
-
-	switch (links_reg & IXGBE_LINKS_SPEED_82599) {
-	case IXGBE_LINKS_SPEED_10G_82599:
-		*speed = IXGBE_LINK_SPEED_10GB_FULL;
-		break;
-	case IXGBE_LINKS_SPEED_1G_82599:
-		*speed = IXGBE_LINK_SPEED_1GB_FULL;
-		break;
-	case IXGBE_LINKS_SPEED_100_82599:
-		*speed = IXGBE_LINK_SPEED_100_FULL;
-		break;
+	if (hw->mac.type == ixgbe_mac_e610_vf) {
+		ret_val = ixgbevf_get_pf_link_state(hw, speed, link_up);
+		if (ret_val)
+			goto out;
+	} else {
+		ixgbe_read_vflinks(hw, speed, link_up);
+		if (*link_up == false)
+			goto out;
 	}
 
 	/* if the read failed it could just be a mailbox collision, best wait
@@ -951,6 +1025,7 @@ int ixgbevf_get_queues(struct ixgbe_hw *hw, unsigned int *num_tcs,
 	case ixgbe_mbox_api_13:
 	case ixgbe_mbox_api_14:
 	case ixgbe_mbox_api_15:
+	case ixgbe_mbox_api_16:
 		break;
 	default:
 		return 0;

-- 
2.51.0.rc1.197.g6d975e95c9d7


