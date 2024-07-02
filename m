Return-Path: <stable+bounces-56307-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD4B91EDAB
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 06:12:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 011451F22855
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 04:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA4485A788;
	Tue,  2 Jul 2024 04:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LcTqLeBo"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C498E4CE09;
	Tue,  2 Jul 2024 04:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719893512; cv=none; b=IWyexs38DvZtXttZezJGferbAtWuzp/iqvUlCe+AdyY81ww3QJr6FJary3zUwFpb3UGYPzTnuBxiPsGnynC+2hj+YWxzehAmzE05zwnmtMtY44Q2iOHYCUqRJW1pafUeolu6O7XYUoefBR9HkZJMdH40kHpTCdw6DTG0uVbwfIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719893512; c=relaxed/simple;
	bh=IG+jA6WK8oBnqv/MTjklMRjKGhlbiPGKuUuCogmTQDg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b3vZD/A8NF6v85RqP23QDISCnvWtI6LMCGqpaQ+4HGw+a6yiZyKV6ZTXqzOKO4ndX336m7N1NFKKOfcW3V0dxscwIrY7WrqiAA5zVRAT8ydqJNea6l12AuEGKLuiBJ4oHV7ccrtidrfYSO5vVk0qiVa/6w7NWbG7JB5T+1CNpFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LcTqLeBo; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719893511; x=1751429511;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IG+jA6WK8oBnqv/MTjklMRjKGhlbiPGKuUuCogmTQDg=;
  b=LcTqLeBomgrxJLSR/M1QfKQZb8kb07kwjm71LlXNaeGfxZ1VXQw72eM/
   SHFCRDcROL8brL5vtQtm+jED982Wxus4pKFg3zTUQr5aqMrDc3VWc47X5
   KcjR6aFvq54TiqqcSWrbYMqX5zWGVJYeFZRNmbDKaUknZiR9vnepwQQ9l
   7kvZ0Oq9v9heaNYzp9dqtdT5rPWoyea8Hr5Z6I9B8C/57GjwrZPpm8Ad2
   T0lg94h5mpUAxedV1EfwESXCyAXE5L6fEjyfB71P+tFm4BwkF5sTbdSMT
   4tA7Gz4QeEEcsgxc55tqAmFlZEzfyObuS28WPW+iXNkcK2KIdl9VrnEEr
   w==;
X-CSE-ConnectionGUID: A/aOv2wyT+eLSy2YJJf9Gg==
X-CSE-MsgGUID: VR63IcliTgOmvFU9j/vjMA==
X-IronPort-AV: E=McAfee;i="6700,10204,11120"; a="20916482"
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="20916482"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 21:11:50 -0700
X-CSE-ConnectionGUID: aOqUkMZvRHyxCVM5hGKQ4A==
X-CSE-MsgGUID: NKeDPlQxThqAg17vhI3IEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="46183514"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 21:11:50 -0700
Received: from mohdfai2-iLBPG12-1.png.intel.com (mohdfai2-iLBPG12-1.png.intel.com [10.88.227.73])
	by linux.intel.com (Postfix) with ESMTP id 0169F2019374;
	Mon,  1 Jul 2024 21:11:46 -0700 (PDT)
From: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
Subject: [PATCH iwl-net v1 1/4] igc: Fix qbv_config_change_errors logics
Date: Tue,  2 Jul 2024 00:09:23 -0400
Message-Id: <20240702040926.3327530-2-faizal.abdul.rahim@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240702040926.3327530-1-faizal.abdul.rahim@linux.intel.com>
References: <20240702040926.3327530-1-faizal.abdul.rahim@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When user issues these cmds:
1. Either a) or b)
   a) mqprio with hardware offload disabled
   b) taprio with txtime-assist feature enabled
2. etf
3. tc qdisc delete
4. taprio with base time in the past

At step 4, qbv_config_change_errors wrongly increased by 1.

Excerpt from IEEE 802.1Q-2018 8.6.9.3.1:
"If AdminBaseTime specifies a time in the past, and the current schedule
is running, then: Increment ConfigChangeError counter"

qbv_config_change_errors should only increase if base time is in the past
and no taprio is active. In user perspective, taprio was not active when
first triggered at step 4. However, i225/6 reuses qbv for etf, so qbv is
enabled with a dummy schedule at step 2 where it enters
igc_tsn_enable_offload() and qbv_count got incremented to 1. At step 4, it
enters igc_tsn_enable_offload() again, qbv_count is incremented to 2.
Because taprio is running, tc_setup_type is TC_SETUP_QDISC_ETF and
qbv_count > 1, qbv_config_change_errors value got incremented.

This issue happens due to reliance on qbv_count field where a non-zero
value indicates that taprio is running. But qbv_count increases
regardless if taprio is triggered by user or by other tsn feature. It does
not align with qbv_config_change_errors expectation where it is only
concerned with taprio triggered by user.

Fixing this by relocating the qbv_config_change_errors logic to
igc_save_qbv_schedule(), eliminating reliance on qbv_count and its
inaccuracies from i225/6's multiple uses of qbv feature for other TSN
features.

The new function created: igc_tsn_is_taprio_activated_by_user() uses
taprio_offload_enable field to indicate that the current running taprio
was triggered by user, instead of triggered by non-qbv feature like etf.

Fixes: ae4fe4698300 ("igc: Add qbv_config_change_errors counter")
Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c |  8 ++++++--
 drivers/net/ethernet/intel/igc/igc_tsn.c  | 19 +++++++++++--------
 drivers/net/ethernet/intel/igc/igc_tsn.h  |  1 +
 3 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 305e05294a26..0f8a5ad940ec 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -6334,12 +6334,16 @@ static int igc_save_qbv_schedule(struct igc_adapter *adapter,
 	if (!validate_schedule(adapter, qopt))
 		return -EINVAL;
 
+	igc_ptp_read(adapter, &now);
+
+	if (igc_tsn_is_taprio_activated_by_user(adapter) &&
+	    is_base_time_past(qopt->base_time, &now))
+		adapter->qbv_config_change_errors++;
+
 	adapter->cycle_time = qopt->cycle_time;
 	adapter->base_time = qopt->base_time;
 	adapter->taprio_offload_enable = true;
 
-	igc_ptp_read(adapter, &now);
-
 	for (n = 0; n < qopt->num_entries; n++) {
 		struct tc_taprio_sched_entry *e = &qopt->entries[n];
 
diff --git a/drivers/net/ethernet/intel/igc/igc_tsn.c b/drivers/net/ethernet/intel/igc/igc_tsn.c
index 22cefb1eeedf..02dd41aff634 100644
--- a/drivers/net/ethernet/intel/igc/igc_tsn.c
+++ b/drivers/net/ethernet/intel/igc/igc_tsn.c
@@ -78,6 +78,17 @@ void igc_tsn_adjust_txtime_offset(struct igc_adapter *adapter)
 	wr32(IGC_GTXOFFSET, txoffset);
 }
 
+bool igc_tsn_is_taprio_activated_by_user(struct igc_adapter *adapter)
+{
+	struct igc_hw *hw = &adapter->hw;
+
+	if ((rd32(IGC_BASET_H) || rd32(IGC_BASET_L)) &&
+	    adapter->taprio_offload_enable)
+		return true;
+	else
+		return false;
+}
+
 /* Returns the TSN specific registers to their default values after
  * the adapter is reset.
  */
@@ -262,14 +273,6 @@ static int igc_tsn_enable_offload(struct igc_adapter *adapter)
 		s64 n = div64_s64(ktime_sub_ns(systim, base_time), cycle);
 
 		base_time = ktime_add_ns(base_time, (n + 1) * cycle);
-
-		/* Increase the counter if scheduling into the past while
-		 * Gate Control List (GCL) is running.
-		 */
-		if ((rd32(IGC_BASET_H) || rd32(IGC_BASET_L)) &&
-		    (adapter->tc_setup_type == TC_SETUP_QDISC_TAPRIO) &&
-		    (adapter->qbv_count > 1))
-			adapter->qbv_config_change_errors++;
 	} else {
 		if (igc_is_device_id_i226(hw)) {
 			ktime_t adjust_time, expires_time;
diff --git a/drivers/net/ethernet/intel/igc/igc_tsn.h b/drivers/net/ethernet/intel/igc/igc_tsn.h
index b53e6af560b7..98ec845a86bf 100644
--- a/drivers/net/ethernet/intel/igc/igc_tsn.h
+++ b/drivers/net/ethernet/intel/igc/igc_tsn.h
@@ -7,5 +7,6 @@
 int igc_tsn_offload_apply(struct igc_adapter *adapter);
 int igc_tsn_reset(struct igc_adapter *adapter);
 void igc_tsn_adjust_txtime_offset(struct igc_adapter *adapter);
+bool igc_tsn_is_taprio_activated_by_user(struct igc_adapter *adapter);
 
 #endif /* _IGC_BASE_H */
-- 
2.25.1


