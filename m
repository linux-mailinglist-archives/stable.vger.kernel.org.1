Return-Path: <stable+bounces-58182-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BF6E9297F1
	for <lists+stable@lfdr.de>; Sun,  7 Jul 2024 14:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A729B1C21069
	for <lists+stable@lfdr.de>; Sun,  7 Jul 2024 12:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DBE42B9DE;
	Sun,  7 Jul 2024 12:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K56SE9y3"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB34E29405;
	Sun,  7 Jul 2024 12:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720356953; cv=none; b=E5wR9oBRPLJ5ykdAp4yo6o4PDC0eKLY+nn6dHr9V740A5iUS5tVSu9AQsacJk/VZ5JNGeuaU9V5ben8+Q4GIkxJXgNbYKbpyDarK6LWcXHFfk72qpeqEMxJA0xBvdmwSvXgFx7rq7PpU3l44Zxr+HBk/vwwmegIATcyY9Z04SJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720356953; c=relaxed/simple;
	bh=MgKuto311+rIu1tuYrrUMI7N/Fp1C7l34NSqYicsNWs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DG6GVEKhnfBzRzmOj3PQ5r72O/Fa2T9DJMc+Qh5pkTt8LIv9qD/VptpGtb6UMfEFDp7zjnz8HpoGMXv0AicvwHM4x0Vxq7+x0beLE3Set/4wY/0dZj8joRqxt+GBxx3XhZ546dM+g0bZSX4oByQio81FXkbH3IYWdDuKa7EXHmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K56SE9y3; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720356953; x=1751892953;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MgKuto311+rIu1tuYrrUMI7N/Fp1C7l34NSqYicsNWs=;
  b=K56SE9y3CQ3nWbrXkjldJh14yPKcIadXg96MkKpvD8mPa+9TH7uPPCcG
   Og/0MuE6bqlimbpxkzT8T+xlF1mSIqMAajppAam/g/PQvcxeTxpO+fR8n
   b+MWu6wLIOzFZtaIgGivAPtFVb0e6pFozsxo4Sm5DOP7Jyy1g2IoaD12M
   9L3aE2whtT2GWebLu0UjirkOd7yF08jNQTHbaozbEJXHjZNn9zbQUUp4j
   fnQ0P8YTFtd6ZaP+myHqoWW8O7rSEr9ndNHt8TQ0zTllu/9prZvjWP1iB
   phcjgtbl648iLQOtqqnVcm86hZclrCl1o6DAaEs1zdAbS+tHCDhKqj3wH
   w==;
X-CSE-ConnectionGUID: 1/INWc1STOCWP6VxUBm8Yw==
X-CSE-MsgGUID: v/fHZuQSSc69sYkVhqMekQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11125"; a="21337371"
X-IronPort-AV: E=Sophos;i="6.09,190,1716274800"; 
   d="scan'208";a="21337371"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2024 05:55:52 -0700
X-CSE-ConnectionGUID: qPlxzrs1R821m7XL6DuSKQ==
X-CSE-MsgGUID: gVXbjNsnQqCjscY3lb0/SQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,190,1716274800"; 
   d="scan'208";a="47359038"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2024 05:55:51 -0700
Received: from mohdfai2-iLBPG12-1.png.intel.com (mohdfai2-iLBPG12-1.png.intel.com [10.88.227.73])
	by linux.intel.com (Postfix) with ESMTP id 1517E20738CF;
	Sun,  7 Jul 2024 05:55:46 -0700 (PDT)
From: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Simon Horman <horms@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Sasha Neftin <sasha.neftin@intel.com>
Cc: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
Subject: [PATCH iwl-net v2 2/3] igc: Fix reset adapter logics when tx mode change
Date: Sun,  7 Jul 2024 08:53:17 -0400
Message-Id: <20240707125318.3425097-3-faizal.abdul.rahim@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240707125318.3425097-1-faizal.abdul.rahim@linux.intel.com>
References: <20240707125318.3425097-1-faizal.abdul.rahim@linux.intel.com>
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
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/intel/igc/igc_tsn.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_tsn.c b/drivers/net/ethernet/intel/igc/igc_tsn.c
index f6eaa288926e..9fafe275f30f 100644
--- a/drivers/net/ethernet/intel/igc/igc_tsn.c
+++ b/drivers/net/ethernet/intel/igc/igc_tsn.c
@@ -49,6 +49,13 @@ static unsigned int igc_tsn_new_flags(struct igc_adapter *adapter)
 	return new_flags;
 }
 
+static bool igc_tsn_is_tx_mode_in_tsn(struct igc_adapter *adapter)
+{
+	struct igc_hw *hw = &adapter->hw;
+
+	return !!(rd32(IGC_TQAVCTRL) & IGC_TQAVCTRL_TRANSMIT_MODE_TSN);
+}
+
 void igc_tsn_adjust_txtime_offset(struct igc_adapter *adapter)
 {
 	struct igc_hw *hw = &adapter->hw;
@@ -331,15 +338,25 @@ int igc_tsn_reset(struct igc_adapter *adapter)
 	return err;
 }
 
+static bool igc_tsn_will_tx_mode_change(struct igc_adapter *adapter)
+{
+	bool any_tsn_enabled = (bool)(igc_tsn_new_flags(adapter) &
+			       IGC_FLAG_TSN_ANY_ENABLED);
+
+	return (any_tsn_enabled && !igc_tsn_is_tx_mode_in_tsn(adapter)) ||
+	       (!any_tsn_enabled && igc_tsn_is_tx_mode_in_tsn(adapter));
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


