Return-Path: <stable+bounces-199987-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 67FD4CA32F5
	for <lists+stable@lfdr.de>; Thu, 04 Dec 2025 11:16:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B1F903121F68
	for <lists+stable@lfdr.de>; Thu,  4 Dec 2025 10:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A3A335BA6;
	Thu,  4 Dec 2025 10:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TGUgG6yF"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CB132572B;
	Thu,  4 Dec 2025 10:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764843122; cv=none; b=oUduyiL80iGndIUsy8UKukV5Wzt66dTFpfGCby+kWAbP2urS5UULG/QxgqytjtZkI07UGEO47ecGMRJCU7IEHhCk2UqLPQ4EaE/U/kw4rdoqmKPVwec3p7XOCL4IBgrThE67SYzYbG1gsZk0C6a4lAB897q6uMAtbRoABiumvkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764843122; c=relaxed/simple;
	bh=zJENULdxlhI8gfPr4TEwrhirO/FILicaVKggLKcIUFM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZxtGeZKY14tQ6rXnKHuz2DGYGaBK9j6Pd8/feMUeu9iyXclO2UbRi+fWhjgnq07BJv+Lyk2LDPeqNawi7qKtinhuu+0lkAF4eZPG9VZ934QzM7GzCJgqbFkBCZ45GaZIFv2bkm4eOVFgnb7JXY2hzzuSbBXhYSIohZLTYXc5m2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TGUgG6yF; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764843120; x=1796379120;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zJENULdxlhI8gfPr4TEwrhirO/FILicaVKggLKcIUFM=;
  b=TGUgG6yFVQ4elSwoopR8EmtLeswCgwH0DPJWbpXcKSuS/jctV0u16PBt
   0eWn4k/nw4mOmoizzhSSnA8T+gnc3UprvjB9x5s0hldNscqFLCipbTBvI
   1dqH+INFMGn1HbXaqkCFj+z/k9n5lhuRrDglpkpqLO7ylKqld+TB0BlVF
   /Ao7ghuFmG2LltppQPcJsIWnjGJmNy1Crkrwss6F+Nh89Tl+KsPzPm/ze
   kmGtG+397IAyAbgi3ee15q+4SC+o0sY2IuNpTrFbRCnnLLs6/SH9gp1i0
   dV747pc65NespdYTusmj9b8APk+2bc9ot4nNppxYsRYSsDRQIDRTfIzVL
   Q==;
X-CSE-ConnectionGUID: SytZhw1aSMe0Avt3/cvcSg==
X-CSE-MsgGUID: /FBs17KqSLCFjHqvEsiH6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="66744379"
X-IronPort-AV: E=Sophos;i="6.20,248,1758610800"; 
   d="scan'208";a="66744379"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2025 02:12:00 -0800
X-CSE-ConnectionGUID: eTBcSIe6Q7yNpiqqYezRxA==
X-CSE-MsgGUID: lzwrxaFmS7OxcM0Z/aOQ1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,248,1758610800"; 
   d="scan'208";a="232274531"
Received: from os-delivery.igk.intel.com ([10.102.18.218])
  by orviesa001.jf.intel.com with ESMTP; 04 Dec 2025 02:11:59 -0800
From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	stable@vger.kernel.org,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Subject: [PATCH iwl-net v1] ixgbevf: fix link setup issue
Date: Thu,  4 Dec 2025 10:53:23 +0100
Message-Id: <20251204095323.149902-1-jedrzej.jagielski@intel.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It may happen that VF spawned for E610 adapter has problem with setting
link up. This happens when ixgbevf supporting mailbox API 1.6 coopearates
with PF driver which doesn't support this version of API, and hence
doesn't support new approach for getting PF link data.

In that case VF asks PF to provide link data but as PF doesn't support
it, returns -EOPNOTSUPP what leads to early bail from link configuration
sequence.

Avoid such situation by using legacy VFLINKS approach whenever negotiated
API version is less than 1.6.

Fixes: 53f0eb62b4d2 ("ixgbevf: fix getting link speed data for E610 devices")
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Cc: stable@vger.kernel.org
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
---
 drivers/net/ethernet/intel/ixgbevf/vf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbevf/vf.c b/drivers/net/ethernet/intel/ixgbevf/vf.c
index 29c5ce967938..8af88f615776 100644
--- a/drivers/net/ethernet/intel/ixgbevf/vf.c
+++ b/drivers/net/ethernet/intel/ixgbevf/vf.c
@@ -846,7 +846,8 @@ static s32 ixgbevf_check_mac_link_vf(struct ixgbe_hw *hw,
 	if (!mac->get_link_status)
 		goto out;
 
-	if (hw->mac.type == ixgbe_mac_e610_vf) {
+	if (hw->mac.type == ixgbe_mac_e610_vf &&
+	    hw->api_version >= ixgbe_mbox_api_16) {
 		ret_val = ixgbevf_get_pf_link_state(hw, speed, link_up);
 		if (ret_val)
 			goto out;
-- 
2.31.1


