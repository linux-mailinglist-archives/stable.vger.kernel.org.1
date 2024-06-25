Return-Path: <stable+bounces-55159-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2719291612B
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 10:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5F351F22AEC
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 08:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9836114831D;
	Tue, 25 Jun 2024 08:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a63ZOu+G"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61D11474AE;
	Tue, 25 Jun 2024 08:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719304153; cv=none; b=aIvApRTV/wabj2R0cxMjcECYUTuIxJyeNoZHrT+adAg8j8QQW6LSyUmrzdtrSy45KbwE6xt+v/M6p5vAeLhx0MAGaTuurdmr8j0s9UzKPvo3l2cKZXWysgyVx9p12kY9org45r7/Z1jcWxBTqgJxKBVRXOuO/MVKfo565wwM7dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719304153; c=relaxed/simple;
	bh=wXaPYhIxd9lGgS507DARPEtzy5YeJ1pxnrulWrIPLyI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pnpXPaGJnV4/3QcUVpguLj9w5yx89y4mPB1/5Wf6q6x6oxl7zlLiFEEO2ZQFKqFywAibso2dS7TVw4z7FMsYx34Tp170RIrd0r4P+L/t06r6WXjcEGzRf1KckTP5hGT7csygwWMD/GfvDOSI8HQiB/GF/9pagpFvBUGqwhTPoTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a63ZOu+G; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719304152; x=1750840152;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wXaPYhIxd9lGgS507DARPEtzy5YeJ1pxnrulWrIPLyI=;
  b=a63ZOu+GkBLydxIcjWMTaXuYWQILWJNPArE9uGgMuf/5i5kjBRrRJ/Qd
   FJ9bznCoY0vdpsB4H+1DivhmFZ72za+Rh/0QAbKtGRqE8wtPJNQhH2vcm
   m7Zv+Ss0ZOp0/Ox6R6bv6n+7aTxyC+mwBAZruOt2rfk78O+Xatd3QZCvn
   LnT/Q+OagO+54AUViHqKFjC1C3we2H/Y3jvpnayQjPjfHqpzxxQkHeE7w
   t3x5hVrsZRK8+Kw8sd/1b6g9D1HTfrADfswRZ7nyk+0VkEBN3QxJiOdQC
   EMgYu7gftLSi28ZojuXTKPpmU96/taubBEflp4rRj189TVUz+VktrEMNh
   g==;
X-CSE-ConnectionGUID: RVRhEI9LReiJCJf68LqMEA==
X-CSE-MsgGUID: BIGmw9z/Snei87hY4K2KEw==
X-IronPort-AV: E=McAfee;i="6700,10204,11113"; a="20185439"
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="scan'208";a="20185439"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 01:29:11 -0700
X-CSE-ConnectionGUID: q0t9HT/HTlih3tIIeLeHlg==
X-CSE-MsgGUID: wkDqR0oAS0ucwoQnSdWLJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="scan'208";a="74336770"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 01:29:11 -0700
Received: from mohdfai2-iLBPG12-1.png.intel.com (mohdfai2-iLBPG12-1.png.intel.com [10.88.227.73])
	by linux.intel.com (Postfix) with ESMTP id 07B1020B5705;
	Tue, 25 Jun 2024 01:29:07 -0700 (PDT)
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
Subject: [PATCH net 1/1] igc: Fix double reset adapter triggered from a single taprio cmd
Date: Tue, 25 Jun 2024 04:26:56 -0400
Message-Id: <20240625082656.2702440-1-faizal.abdul.rahim@linux.intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Following the implementation of "igc: Add TransmissionOverrun counter"
patch, when a taprio command is triggered by user, igc processes two
commands: TAPRIO_CMD_REPLACE followed by TAPRIO_CMD_STATS. However, both
commands unconditionally pass through igc_tsn_offload_apply() which
evaluates and triggers reset adapter. The double reset causes issues in
the calculation of adapter->qbv_count in igc.

TAPRIO_CMD_REPLACE command is expected to reset the adapter since it
activates qbv. It's unexpected for TAPRIO_CMD_STATS to do the same
because it doesn't configure any driver-specific TSN settings. So, the
evaluation in igc_tsn_offload_apply() isn't needed for TAPRIO_CMD_STATS.

To address this, commands parsing are relocated to
igc_tsn_enable_qbv_scheduling(). Commands that don't require an adapter
reset will exit after processing, thus avoiding igc_tsn_offload_apply().

Fixes: d3750076d464 ("igc: Add TransmissionOverrun counter")
Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 33 ++++++++++++-----------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 87b655b839c1..33069880c86c 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -6310,21 +6310,6 @@ static int igc_save_qbv_schedule(struct igc_adapter *adapter,
 	size_t n;
 	int i;

-	switch (qopt->cmd) {
-	case TAPRIO_CMD_REPLACE:
-		break;
-	case TAPRIO_CMD_DESTROY:
-		return igc_tsn_clear_schedule(adapter);
-	case TAPRIO_CMD_STATS:
-		igc_taprio_stats(adapter->netdev, &qopt->stats);
-		return 0;
-	case TAPRIO_CMD_QUEUE_STATS:
-		igc_taprio_queue_stats(adapter->netdev, &qopt->queue_stats);
-		return 0;
-	default:
-		return -EOPNOTSUPP;
-	}
-
 	if (qopt->base_time < 0)
 		return -ERANGE;

@@ -6433,7 +6418,23 @@ static int igc_tsn_enable_qbv_scheduling(struct igc_adapter *adapter,
 	if (hw->mac.type != igc_i225)
 		return -EOPNOTSUPP;

-	err = igc_save_qbv_schedule(adapter, qopt);
+	switch (qopt->cmd) {
+	case TAPRIO_CMD_REPLACE:
+		err = igc_save_qbv_schedule(adapter, qopt);
+		break;
+	case TAPRIO_CMD_DESTROY:
+		err = igc_tsn_clear_schedule(adapter);
+		break;
+	case TAPRIO_CMD_STATS:
+		igc_taprio_stats(adapter->netdev, &qopt->stats);
+		return 0;
+	case TAPRIO_CMD_QUEUE_STATS:
+		igc_taprio_queue_stats(adapter->netdev, &qopt->queue_stats);
+		return 0;
+	default:
+		return -EOPNOTSUPP;
+	}
+
 	if (err)
 		return err;

--
2.25.1


