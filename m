Return-Path: <stable+bounces-176587-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53541B39935
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 12:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95D6C467D1B
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 10:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA933093A5;
	Thu, 28 Aug 2025 10:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BgEGeRci"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD723081CC;
	Thu, 28 Aug 2025 10:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756375775; cv=none; b=HkJwA0nwq+eFwPqs/8GlbNO4MfFzdGWWSvF7IpuSNhdhO8Vuv7/jyajOewpMbfZKxCTIbCHFtr5mGQZR2C6dLgNbB34+AEK/EEPG6KHGiEwkYho8e8bgsUUwQ4WsaHw09MfGRbkzS8Mdo8LxsQrW1M0THNdKZbXl6t7mZM5Sum0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756375775; c=relaxed/simple;
	bh=BuV6sy7akWwvmoQthUGtP+SjNRnorhCutIFVwVeEMFI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Nyl95g7eVurLVu047zTU5kuSlal3I12lDTCOelRTB25Cf9gjXVY+eGemUu0lz6z2QhnzUd31/JPJnQ4cOo3JCWyRca5jG0lD8jklg2E6yKcoG0MJcBGcb0cmZLwvH16pfXqWvaTEhi0bmRN7VyX8p329gZFff535opdF4OO6Miw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BgEGeRci; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756375774; x=1787911774;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BuV6sy7akWwvmoQthUGtP+SjNRnorhCutIFVwVeEMFI=;
  b=BgEGeRcibgRTXE1AiA49rp1wYOGgBccxWULsRYK4hsDMf/20u7W/PHFt
   Og5gr7+45efQwBSjx+IHoNCdU7+UjYxbc1R8IK3QPW6He76TLQmraXS/x
   sONmythNzi6ZAw0heqlJlvAK+l42NAkOVkuGleHq/prvCw9gm9E0hjBsf
   rEmgdpjbJLztNfKynMplZJSNZw/wCxz5zjgWAADAmR07PVz5KGSoEYsMA
   lwp8uHP9c2bXiNV/enZ44fU8WMU9Mj+VcFtBsD6Jva5vGQ3r5E8UfmGz2
   thslSAZf8I0oVWtzOe60fGLf17LN29VzMONaYFktT5fU5YNTkjnBEvU8B
   g==;
X-CSE-ConnectionGUID: zQ1agZL2T4eJ6HRDFmylYg==
X-CSE-MsgGUID: c5ZJQ7zmQdOH+KKtv6aRDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11535"; a="61274914"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="61274914"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 03:09:33 -0700
X-CSE-ConnectionGUID: cYLf9I0CSrmDdf3nrjOuJA==
X-CSE-MsgGUID: F7U3BY01RVKBMdTqdkGklA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="169972387"
Received: from os-delivery.igk.intel.com ([10.102.18.218])
  by orviesa007.jf.intel.com with ESMTP; 28 Aug 2025 03:09:31 -0700
From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	stable@vger.kernel.org,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH iwl-net v1 4/4] ixgbe: handle IXGBE_VF_FEATURES_NEGOTIATE mbox cmd
Date: Thu, 28 Aug 2025 11:52:27 +0200
Message-Id: <20250828095227.1857066-5-jedrzej.jagielski@intel.com>
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

Send to VF information about features supported by the PF driver.

Increase API version to 1.7.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.h  | 10 +++++
 .../net/ethernet/intel/ixgbe/ixgbe_sriov.c    | 37 +++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.h
index be452856531a..8a2ba77d1493 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.h
@@ -52,6 +52,7 @@ enum ixgbe_pfvf_api_rev {
 	ixgbe_mbox_api_14,	/* API version 1.4, linux/freebsd VF driver */
 	ixgbe_mbox_api_15,	/* API version 1.5, linux/freebsd VF driver */
 	ixgbe_mbox_api_16,	/* API version 1.6, linux/freebsd VF driver */
+	ixgbe_mbox_api_17,	/* API version 1.7, linux/freebsd VF driver */
 	/* This value should always be last */
 	ixgbe_mbox_api_unknown,	/* indicates that API version is not known */
 };
@@ -91,6 +92,9 @@ enum ixgbe_pfvf_api_rev {
 /* mailbox API, version 1.6 VF requests */
 #define IXGBE_VF_GET_PF_LINK_STATE	0x11 /* request PF to send link info */
 
+/* mailbox API, version 1.7 VF requests */
+#define IXGBE_VF_FEATURES_NEGOTIATE	0x12 /* get features supported by PF */
+
 /* length of permanent address message returned from PF */
 #define IXGBE_VF_PERMADDR_MSG_LEN 4
 /* word in permanent address message with the current multicast type */
@@ -101,6 +105,12 @@ enum ixgbe_pfvf_api_rev {
 #define IXGBE_VF_MBX_INIT_TIMEOUT 2000 /* number of retries on mailbox */
 #define IXGBE_VF_MBX_INIT_DELAY   500  /* microseconds between retries */
 
+/* features negotiated between PF/VF */
+#define IXGBEVF_PF_SUP_IPSEC		BIT(0)
+#define IXGBEVF_PF_SUP_ESX_MBX		BIT(1)
+
+#define IXGBE_SUPPORTED_FEATURES	IXGBEVF_PF_SUP_IPSEC
+
 struct ixgbe_hw;
 
 int ixgbe_read_mbx(struct ixgbe_hw *, u32 *, u16, u16);
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
index 2d5584c36cd0..39cd0a9c9480 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
@@ -511,6 +511,7 @@ static int ixgbe_set_vf_lpe(struct ixgbe_adapter *adapter, u32 max_frame, u32 vf
 		case ixgbe_mbox_api_13:
 		case ixgbe_mbox_api_14:
 		case ixgbe_mbox_api_16:
+		case ixgbe_mbox_api_17:
 			/* Version 1.1 supports jumbo frames on VFs if PF has
 			 * jumbo frames enabled which means legacy VFs are
 			 * disabled
@@ -1048,6 +1049,7 @@ static int ixgbe_negotiate_vf_api(struct ixgbe_adapter *adapter,
 	case ixgbe_mbox_api_13:
 	case ixgbe_mbox_api_14:
 	case ixgbe_mbox_api_16:
+	case ixgbe_mbox_api_17:
 		adapter->vfinfo[vf].vf_api = api;
 		return 0;
 	default:
@@ -1075,6 +1077,7 @@ static int ixgbe_get_vf_queues(struct ixgbe_adapter *adapter,
 	case ixgbe_mbox_api_13:
 	case ixgbe_mbox_api_14:
 	case ixgbe_mbox_api_16:
+	case ixgbe_mbox_api_17:
 		break;
 	default:
 		return -1;
@@ -1115,6 +1118,7 @@ static int ixgbe_get_vf_reta(struct ixgbe_adapter *adapter, u32 *msgbuf, u32 vf)
 
 	/* verify the PF is supporting the correct API */
 	switch (adapter->vfinfo[vf].vf_api) {
+	case ixgbe_mbox_api_17:
 	case ixgbe_mbox_api_16:
 	case ixgbe_mbox_api_14:
 	case ixgbe_mbox_api_13:
@@ -1149,6 +1153,7 @@ static int ixgbe_get_vf_rss_key(struct ixgbe_adapter *adapter,
 
 	/* verify the PF is supporting the correct API */
 	switch (adapter->vfinfo[vf].vf_api) {
+	case ixgbe_mbox_api_17:
 	case ixgbe_mbox_api_16:
 	case ixgbe_mbox_api_14:
 	case ixgbe_mbox_api_13:
@@ -1180,6 +1185,7 @@ static int ixgbe_update_vf_xcast_mode(struct ixgbe_adapter *adapter,
 	case ixgbe_mbox_api_13:
 	case ixgbe_mbox_api_14:
 	case ixgbe_mbox_api_16:
+	case ixgbe_mbox_api_17:
 		break;
 	default:
 		return -EOPNOTSUPP;
@@ -1251,6 +1257,7 @@ static int ixgbe_get_vf_link_state(struct ixgbe_adapter *adapter,
 	case ixgbe_mbox_api_13:
 	case ixgbe_mbox_api_14:
 	case ixgbe_mbox_api_16:
+	case ixgbe_mbox_api_17:
 		break;
 	default:
 		return -EOPNOTSUPP;
@@ -1278,6 +1285,7 @@ static int ixgbe_send_vf_link_status(struct ixgbe_adapter *adapter,
 
 	switch (adapter->vfinfo[vf].vf_api) {
 	case ixgbe_mbox_api_16:
+	case ixgbe_mbox_api_17:
 		if (hw->mac.type != ixgbe_mac_e610)
 			return -EOPNOTSUPP;
 		break;
@@ -1293,6 +1301,32 @@ static int ixgbe_send_vf_link_status(struct ixgbe_adapter *adapter,
 	return 0;
 }
 
+/**
+ * ixgbe_negotiate_vf_features -  negotiate supported features with VF driver
+ * @adapter: pointer to adapter struct
+ * @msgbuf: pointer to message buffers
+ * @vf: VF identifier
+ *
+ * Return: 0 on success or -EOPNOTSUPP when operation is not supported.
+ */
+static int ixgbe_negotiate_vf_features(struct ixgbe_adapter *adapter,
+				       u32 *msgbuf, u32 vf)
+{
+	u32 features = msgbuf[1];
+
+	switch (adapter->vfinfo[vf].vf_api) {
+	case ixgbe_mbox_api_17:
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	features &= IXGBE_SUPPORTED_FEATURES;
+	msgbuf[1] = features;
+
+	return 0;
+}
+
 static int ixgbe_rcv_msg_from_vf(struct ixgbe_adapter *adapter, u32 vf)
 {
 	u32 mbx_size = IXGBE_VFMAILBOX_SIZE;
@@ -1370,6 +1404,9 @@ static int ixgbe_rcv_msg_from_vf(struct ixgbe_adapter *adapter, u32 vf)
 	case IXGBE_VF_GET_PF_LINK_STATE:
 		retval = ixgbe_send_vf_link_status(adapter, msgbuf, vf);
 		break;
+	case IXGBE_VF_FEATURES_NEGOTIATE:
+		retval = ixgbe_negotiate_vf_features(adapter, msgbuf, vf);
+		break;
 	default:
 		e_err(drv, "Unhandled Msg %8.8x\n", msgbuf[0]);
 		retval = -EIO;
-- 
2.31.1


