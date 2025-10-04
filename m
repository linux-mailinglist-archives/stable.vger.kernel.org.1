Return-Path: <stable+bounces-183350-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3367BBB8795
	for <lists+stable@lfdr.de>; Sat, 04 Oct 2025 03:12:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9EAFF341B6A
	for <lists+stable@lfdr.de>; Sat,  4 Oct 2025 01:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C3D11A76B1;
	Sat,  4 Oct 2025 01:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a3pkdL9d"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F5513AD3F;
	Sat,  4 Oct 2025 01:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759540310; cv=none; b=rrGkKRt4D/5FXjJ/iGHTpKpPbn2qUcfMpAxitxiiuHjp7/XOufNXAoulKSY/ntJaiCpr6+zmP8E4EbU7sI1js92kIxNkw/LadMKKRqFDIEzUSL5mBxrG4CAIe9j0Vg4PvqbxiR0E3hLkJXmv6dMtyLy+v8Qc5po7hSOF037p+Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759540310; c=relaxed/simple;
	bh=SgBxelc8Gd17r4DrULY1XDXekhb40y9ZSrHm316CB6o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bJPtpQpMMr3TgLUOdS1C2bZyb/QC9pfB0Y8gTYG6ETL6kaGqqbZHvV8hshRodlLpdVK0mcgjNIqXs6g5UTYvBnPzK6/UDDAXsfQ9kmmfWtK0vsmuheTG7sMMYrTu1BimU6cxhJ7FXbbqtc7b+8jG/QcfZ13QLsYk50+MZNZKTUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a3pkdL9d; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759540307; x=1791076307;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=SgBxelc8Gd17r4DrULY1XDXekhb40y9ZSrHm316CB6o=;
  b=a3pkdL9d7cmzINOxCQFrtGeQme6kqAchtyFekQK1et/3E5UmmbfwIYtK
   R/mbTvS+2MzP/hhOCg2VzZ4c+1Ln4EExdcPiwuUqY/mHzRznwqtDAet7q
   /d9hPi6WBNHsF+iWBoNW/Kq/w0J8w7VAdCxErAkCbHCzFQYsmzo+4h6hc
   hwXID77/prdAnmHH+5xMpHoEB7od/GUZWsL6r52EsdKfDtwCACbSZW5dd
   d5032Yrf54bqFUZX+8a1J8v6XmC3kMiryqPD+XrqaIsowKCismuaO6JxA
   KLqUPLDCocJZT/ZBCCHz5xGUFRDAQVc1aFXNsKuJdc5F9z5lcjs/XVC6s
   g==;
X-CSE-ConnectionGUID: MU58TVhaTm++jhRK7/Uwpw==
X-CSE-MsgGUID: txF+/uBxQASQ/xZXaeTw8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="65650035"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="65650035"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2025 18:11:43 -0700
X-CSE-ConnectionGUID: /xYbegwcSwqxbgr1Q2c2dw==
X-CSE-MsgGUID: 4vp3+PWgTdWw0YJ7QiC7Cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,314,1751266800"; 
   d="scan'208";a="178543212"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.70]) ([10.166.28.70])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2025 18:11:43 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Fri, 03 Oct 2025 18:09:47 -0700
Subject: [PATCH net v2 4/6] ixgbevf: fix mailbox API compatibility by
 negotiating supported features
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251003-jk-iwl-net-2025-10-01-v2-4-e59b4141c1b5@intel.com>
References: <20251003-jk-iwl-net-2025-10-01-v2-0-e59b4141c1b5@intel.com>
In-Reply-To: <20251003-jk-iwl-net-2025-10-01-v2-0-e59b4141c1b5@intel.com>
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
Cc: Anton Nadezhdin <anton.nadezhdin@intel.com>, 
 Konstantin Ilichev <konstantin.ilichev@intel.com>, 
 Milena Olech <milena.olech@intel.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, stable@vger.kernel.org, 
 Rafal Romanowski <rafal.romanowski@intel.com>
X-Mailer: b4 0.15-dev-cbe0e
X-Developer-Signature: v=1; a=openpgp-sha256; l=12961;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=xbh+oumdcQQ+3XlPQU2PZmiAwYRBUGcAyDt2Gpd7+Oo=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhowHJX77wzvDWhw2etXzzsutLax9ssXIYq317OJPMxjMN
 np8N4vuKGVhEONikBVTZFFwCFl53XhCmNYbZzmYOaxMIEMYuDgFYCK/tzAy7DII6tzF+ybrbN6+
 H4nhrC9vzN97Zf0npZkhb1IrA7O3fWRkmLK7Vf31QlErV/dm9/0xTuUvSv5U/E32efT72dno7y0
 F3AA=
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8

From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>

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
---
 drivers/net/ethernet/intel/ixgbevf/ixgbevf.h      |  7 ++++
 drivers/net/ethernet/intel/ixgbevf/mbx.h          |  4 ++
 drivers/net/ethernet/intel/ixgbevf/vf.h           |  1 +
 drivers/net/ethernet/intel/ixgbevf/ipsec.c        | 10 +++++
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 32 +++++++++++++++-
 drivers/net/ethernet/intel/ixgbevf/vf.c           | 45 ++++++++++++++++++++++-
 6 files changed, 96 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h b/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
index 3a379e6a3a2a..039187607e98 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
@@ -363,6 +363,13 @@ struct ixgbevf_adapter {
 	struct ixgbe_hw hw;
 	u16 msg_enable;
 
+	u32 pf_features;
+#define IXGBEVF_PF_SUP_IPSEC		BIT(0)
+#define IXGBEVF_PF_SUP_ESX_MBX		BIT(1)
+
+#define IXGBEVF_SUPPORTED_FEATURES	(IXGBEVF_PF_SUP_IPSEC | \
+					IXGBEVF_PF_SUP_ESX_MBX)
+
 	struct ixgbevf_hw_stats stats;
 
 	unsigned long state;
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
diff --git a/drivers/net/ethernet/intel/ixgbevf/vf.c b/drivers/net/ethernet/intel/ixgbevf/vf.c
index f05246fb5a74..74d320879513 100644
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

-- 
2.51.0.rc1.197.g6d975e95c9d7


