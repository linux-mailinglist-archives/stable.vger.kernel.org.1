Return-Path: <stable+bounces-160195-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C62AF93CF
	for <lists+stable@lfdr.de>; Fri,  4 Jul 2025 15:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBC5E3A5D52
	for <lists+stable@lfdr.de>; Fri,  4 Jul 2025 13:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B4985626;
	Fri,  4 Jul 2025 13:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W7h3IjU6"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A951FC3
	for <stable@vger.kernel.org>; Fri,  4 Jul 2025 13:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751635003; cv=none; b=svtRmGeUtvdX0QGiFG8nQCKlnKkRn3kGsdvMKXYY7sIchuZx5u0R5zzvqmTSws/AqYKuyigQMNkl/74xL6mrbsDf5ingnNxQCQ4w8pqpKCMRAyp4SFAScLOHfCbGQZHDc7YX/XsifN8ey+jUo5ZD5JGD1H95nJKuW42FeMihlIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751635003; c=relaxed/simple;
	bh=FWBOWLtiVK1Ld66RwfwCesf4zAe0GXFu3SuSIPp2AvE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VrVHZ8BKiDKK58IbHUQHDH3FVHmRNj+tJHOXT+zwZLVQzejyTmB2+BBw23O6GmYMF+A37T6l6kUyK9Lg7bRNiw9oYXTuF3g06s+RKbfwZ9vwuNQSbj2RsgQjSaNIkEXKEDpyQUSGQMUdzmxTwWTdle/2siENewDtMd/HDZSWNnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W7h3IjU6; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751635002; x=1783171002;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FWBOWLtiVK1Ld66RwfwCesf4zAe0GXFu3SuSIPp2AvE=;
  b=W7h3IjU6gq7dRRLIIR65AgJJqM7SFdLpw1qtjDetEx4hHTkowA2QlbIk
   ro5vNc/ATeItlKnGWQlr3WpamZg/D2s+yPAm3JIHLLwUhkI+RVbe9TbQT
   XxrZ8JfqQpJhCi+kzWh+MM5Q/lMdhsk36Q7yg6jgKrY1548cDZb53R9eZ
   9eNhl93G4nHHJcNXcjNgfNCN/jVxa4ra64Q7s+AJXVlMWvG5uaPqVbX1K
   3esX24l4It4diJhzipy2ecw6cZrOACvZ4vulPXeV0OnmCMphw7MMfmy62
   MJ5FWYyZx/DPHeOOneqpsTNlJAYBrE1w03t+cwjtQAs9Xf/jkCGNXbih2
   A==;
X-CSE-ConnectionGUID: UgEJ4f4jSH+FiYS5CoFdmw==
X-CSE-MsgGUID: X4jirrPkRdCLFDUCryEoLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11484"; a="71542074"
X-IronPort-AV: E=Sophos;i="6.16,287,1744095600"; 
   d="scan'208";a="71542074"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 06:16:41 -0700
X-CSE-ConnectionGUID: MO6PWSIkSRKDw7jkeWWBKQ==
X-CSE-MsgGUID: 6RuAk1aLRxCv30lM2MmN1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,287,1744095600"; 
   d="scan'208";a="155128294"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa008.jf.intel.com with ESMTP; 04 Jul 2025 06:16:39 -0700
Received: from pkitszel-desk.intel.com (unknown [10.245.245.117])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 15FD52FC54;
	Fri,  4 Jul 2025 14:16:36 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: stable@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Masakazu Asama <masakazu.asama@gmail.com>,
	Jesse Brandeburg <jbrandeburg@cloudflare.com>,
	Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 5.15] ice: safer stats processing
Date: Fri,  4 Jul 2025 15:13:59 +0200
Message-ID: <20250704131620.51803-1-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jesse Brandeburg <jesse.brandeburg@intel.com>

[ Upstream commit 1a0f25a52e08b1f67510cabbb44888d2b3c46359 ]

Fix an issue of stats growing indefinitely, minor conflict resolved:
struct ice_tx_ring replaced by struct ice_ring, as the split is not yet
present on 5.15 line. -Przemek

Original commit message:
The driver was zeroing live stats that could be fetched by
ndo_get_stats64 at any time. This could result in inconsistent
statistics, and the telltale sign was when reading stats frequently from
/proc/net/dev, the stats would go backwards.

Fix by collecting stats into a local, and delaying when we write to the
structure so it's not incremental.

Fixes: fcea6f3da546 ("ice: Add stats and ethtool support")
Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Tested-by: Gurucharan G <gurucharanx.g@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Reported-by: Masakazu Asama <masakazu.asama@gmail.com>
Closes: https://lore.kernel.org/intel-wired-lan/CAP8M2pGttT4JBjt+i4GJkxy7yERbqWJ5a8R14HzoonTLByc2Cw@mail.gmail.com
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
CC: Jesse Brandeburg <jbrandeburg@cloudflare.com>
CC: Sasha Levin <sashal@kernel.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: intel-wired-lan@lists.osuosl.org

CC: kernel-team@lists.ubuntu.com
the issue was reported against Ubuntu 22.04, do you backport stable
patches by default, or should I post one more, directed to you?
---
 drivers/net/ethernet/intel/ice/ice_main.c | 29 ++++++++++++++---------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 91840ea92b0d..04e3f6c424c0 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -5731,14 +5731,15 @@ ice_fetch_u64_stats_per_ring(struct ice_ring *ring, u64 *pkts, u64 *bytes)
 /**
  * ice_update_vsi_tx_ring_stats - Update VSI Tx ring stats counters
  * @vsi: the VSI to be updated
+ * @vsi_stats: the stats struct to be updated
  * @rings: rings to work on
  * @count: number of rings
  */
 static void
-ice_update_vsi_tx_ring_stats(struct ice_vsi *vsi, struct ice_ring **rings,
-			     u16 count)
+ice_update_vsi_tx_ring_stats(struct ice_vsi *vsi,
+			     struct rtnl_link_stats64 *vsi_stats,
+			     struct ice_ring **rings, u16 count)
 {
-	struct rtnl_link_stats64 *vsi_stats = &vsi->net_stats;
 	u16 i;
 
 	for (i = 0; i < count; i++) {
@@ -5761,15 +5762,13 @@ ice_update_vsi_tx_ring_stats(struct ice_vsi *vsi, struct ice_ring **rings,
  */
 static void ice_update_vsi_ring_stats(struct ice_vsi *vsi)
 {
-	struct rtnl_link_stats64 *vsi_stats = &vsi->net_stats;
+	struct rtnl_link_stats64 *vsi_stats;
 	u64 pkts, bytes;
 	int i;
 
-	/* reset netdev stats */
-	vsi_stats->tx_packets = 0;
-	vsi_stats->tx_bytes = 0;
-	vsi_stats->rx_packets = 0;
-	vsi_stats->rx_bytes = 0;
+	vsi_stats = kzalloc(sizeof(*vsi_stats), GFP_ATOMIC);
+	if (!vsi_stats)
+		return;
 
 	/* reset non-netdev (extended) stats */
 	vsi->tx_restart = 0;
@@ -5781,7 +5780,8 @@ static void ice_update_vsi_ring_stats(struct ice_vsi *vsi)
 	rcu_read_lock();
 
 	/* update Tx rings counters */
-	ice_update_vsi_tx_ring_stats(vsi, vsi->tx_rings, vsi->num_txq);
+	ice_update_vsi_tx_ring_stats(vsi, vsi_stats, vsi->tx_rings,
+				     vsi->num_txq);
 
 	/* update Rx rings counters */
 	ice_for_each_rxq(vsi, i) {
@@ -5796,10 +5796,17 @@ static void ice_update_vsi_ring_stats(struct ice_vsi *vsi)
 
 	/* update XDP Tx rings counters */
 	if (ice_is_xdp_ena_vsi(vsi))
-		ice_update_vsi_tx_ring_stats(vsi, vsi->xdp_rings,
+		ice_update_vsi_tx_ring_stats(vsi, vsi_stats, vsi->xdp_rings,
 					     vsi->num_xdp_txq);
 
 	rcu_read_unlock();
+
+	vsi->net_stats.tx_packets = vsi_stats->tx_packets;
+	vsi->net_stats.tx_bytes = vsi_stats->tx_bytes;
+	vsi->net_stats.rx_packets = vsi_stats->rx_packets;
+	vsi->net_stats.rx_bytes = vsi_stats->rx_bytes;
+
+	kfree(vsi_stats);
 }
 
 /**
-- 
2.46.0


