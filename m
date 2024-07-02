Return-Path: <stable+bounces-56308-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D49491EDAF
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 06:12:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BA2DB22B0A
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 04:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D84E2BCFF;
	Tue,  2 Jul 2024 04:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KdvCPBI6"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504385FDA7;
	Tue,  2 Jul 2024 04:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719893515; cv=none; b=fNZr2gPKgm8o1bEE4AMNpUd+U0Dc8Ek1A04L2Vlsz++tODUSzKUq4/UmrJrXN+jCRl+lPvoKshOiORdpAlsdyC1fazpCzzXsBME5xdFR5nGwEGhZJTYbT2NRyETg/WjTbQGN/gMwKZ9GBbnPKaPLntDbzV5vpNQXFf2xaV9X3Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719893515; c=relaxed/simple;
	bh=q8NUF1xSMQJs5UewEtAX/h5t9cGorbCLoqFhoMPiLBo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lgusaTeRWEAEABuWUh6VbX81vT4P8UWR6vltK1Gd0EQz71SvCldRMO4ecMMoLRUvJF0WgG8/P+nlfAPcGe16I86Ix8/ixVetDdysX764J0ewdaVrSZEybomYOBS5O18pketlxQzETbaQAxEwlDZXHcEV5aberWOt+iHJ69qHbbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KdvCPBI6; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719893513; x=1751429513;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=q8NUF1xSMQJs5UewEtAX/h5t9cGorbCLoqFhoMPiLBo=;
  b=KdvCPBI6+RtCljm0QbKy4Ol5vm/13++tuoVACtECFUejmGSDU/PCGByI
   mtACTFlZkwuEXstdJDtFGcLHw/LAxFxSp/+krqTR7EJ8uQ40jL2RN9/OR
   oZZjkBnW5U8lxg7RGNsSvmu9/pxzYt4XUFjjIgifMsPuwFWdVQcZDrfVL
   hUsClF0uA8IKS8EKEj+GXH0QtAdCPUHluG2rL+uDlpmbEJ9VaWSd0A+UL
   5h14MFBQHYtCOqZqE/fHN3LUtjaex6ZzjOAi47jZixNaEYuaZAgZYh+ZN
   PFbS7MsBlrOWm199VbdG7S0fl9XqU3fz1reNXx/sgdlKnNMOaLVW17Pi+
   g==;
X-CSE-ConnectionGUID: ikryawPwT++lbaghzs4MZw==
X-CSE-MsgGUID: YkJQlCgzTC6PS9lGUIANMw==
X-IronPort-AV: E=McAfee;i="6700,10204,11120"; a="20916494"
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="20916494"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 21:11:53 -0700
X-CSE-ConnectionGUID: NlO7AS+DT9WyQ5fapWGCIw==
X-CSE-MsgGUID: U8Q8wTjRQUO5q6rLPDlH8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="46183529"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 21:11:53 -0700
Received: from mohdfai2-iLBPG12-1.png.intel.com (mohdfai2-iLBPG12-1.png.intel.com [10.88.227.73])
	by linux.intel.com (Postfix) with ESMTP id 4F5E5201A797;
	Mon,  1 Jul 2024 21:11:50 -0700 (PDT)
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
Subject: [PATCH iwl-net v1 2/4] igc: Fix reset adapter logics when tx mode change
Date: Tue,  2 Jul 2024 00:09:24 -0400
Message-Id: <20240702040926.3327530-3-faizal.abdul.rahim@linux.intel.com>
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

Following the "igc: Fix TX Hang issue when QBV Gate is close" changes,
remaining issues with the reset adapter logic in igc_tsn_offload_apply()
have been observed:

1. The reset adapter logics for i225 and i226 differ, although they should
   be the same according to the guidelines in I225/6 HW Design Section
   7.5.2.1 on software initialization during tx mode changes.
2. The i225 resets adapter every time, even though tx mode doesn't change.
   This occurs solely based on the condition  igc_is_device_id_i225() when
   calling schedule_work().
3. i226 doesn't reset adapter for tsn->legacy tx mode changes. It only
   resets adapter for legacy->tsn tx mode transitions.
4. qbv_count introduced in the patch is actually not needed; in this
   context, a non-zero value of qbv_count is used to indicate if tx mode
   was unconditionally set to tsn in igc_tsn_enable_offload(). This could
   be replaced by checking the existing register
   IGC_TQAVCTRL_TRANSMIT_MODE_TSN bit.

This patch resolves all issues and enters schedule_work() to reset the
adapter only when changing tx mode. It also removes reliance on qbv_count.

qbv_count field will be removed in a future patch.

Test ran:

1. Verify reset adapter behaviour in i225/6:
   a) Enrol a new GCL
      Reset adapter observed (tx mode change legacy->tsn)
   b) Enrol a new GCL without deleting qdisc
      No reset adapter observed (tx mode remain tsn->tsn)
   c) Delete qdisc
      Reset adapter observed (tx mode change tsn->legacy)

2. Tested scenario from "igc: Fix TX Hang issue when QBV Gate is closed"
   to confirm it remains resolved.

Fixes: 175c241288c0 ("igc: Fix TX Hang issue when QBV Gate is closed")
Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
---
 drivers/net/ethernet/intel/igc/igc_tsn.c | 26 +++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_tsn.c b/drivers/net/ethernet/intel/igc/igc_tsn.c
index 02dd41aff634..61f047ebf34d 100644
--- a/drivers/net/ethernet/intel/igc/igc_tsn.c
+++ b/drivers/net/ethernet/intel/igc/igc_tsn.c
@@ -49,6 +49,13 @@ static unsigned int igc_tsn_new_flags(struct igc_adapter *adapter)
 	return new_flags;
 }
 
+static bool igc_tsn_is_tx_mode_in_tsn(struct igc_adapter *adapter)
+{
+	struct igc_hw *hw = &adapter->hw;
+
+	return (bool)(rd32(IGC_TQAVCTRL) & IGC_TQAVCTRL_TRANSMIT_MODE_TSN);
+}
+
 void igc_tsn_adjust_txtime_offset(struct igc_adapter *adapter)
 {
 	struct igc_hw *hw = &adapter->hw;
@@ -334,15 +341,28 @@ int igc_tsn_reset(struct igc_adapter *adapter)
 	return err;
 }
 
+static bool igc_tsn_will_tx_mode_change(struct igc_adapter *adapter)
+{
+	bool any_tsn_enabled = (bool)(igc_tsn_new_flags(adapter) &
+			       IGC_FLAG_TSN_ANY_ENABLED);
+
+	if ((any_tsn_enabled && !igc_tsn_is_tx_mode_in_tsn(adapter)) ||
+	    (!any_tsn_enabled && igc_tsn_is_tx_mode_in_tsn(adapter)))
+		return true;
+	else
+		return false;
+}
+
 int igc_tsn_offload_apply(struct igc_adapter *adapter)
 {
 	struct igc_hw *hw = &adapter->hw;
 
-	/* Per I225/6 HW Design Section 7.5.2.1, transmit mode
-	 * cannot be changed dynamically. Require reset the adapter.
+	/* Per I225/6 HW Design Section 7.5.2.1 guideline, if tx mode change
+	 * from legacy->tsn or tsn->legacy, then reset adapter is needed.
 	 */
 	if (netif_running(adapter->netdev) &&
-	    (igc_is_device_id_i225(hw) || !adapter->qbv_count)) {
+	    (igc_is_device_id_i225(hw) || igc_is_device_id_i226(hw)) &&
+	     igc_tsn_will_tx_mode_change(adapter)) {
 		schedule_work(&adapter->reset_task);
 		return 0;
 	}
-- 
2.25.1


