Return-Path: <stable+bounces-135339-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96DFDA98DCD
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 16:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AB5A1897695
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 14:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E21DE1A23B0;
	Wed, 23 Apr 2025 14:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wjmtfcOu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A038A2701A0;
	Wed, 23 Apr 2025 14:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745419663; cv=none; b=rERU80J3Kh511XHlY+638+e7ckpbvx/mgB0SMFFHW58dzXvRX/Pv+j8mDBGN1MO2oB3ENbFcnuX1JwwsLF7+Fwi1McIvgAirlbSLnY2VRtTOzNlbeqBfoaOqDuruqW13giZ+H/O0Q7W9E4GEj5012eEoDKvJ6ANHFYvBiPAqzxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745419663; c=relaxed/simple;
	bh=7EkyNIrNuZOplXgfZxKxpB5jgn3FxXOYFMX/A4crUpM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J3hXmIpC4jsD1hSu4YPExb/EBV3S95j6R27AZoUEzpoL8jIvtEVQvriKt8dO9U8hzq0hUl3/fg00QgfH8kf6tDWI03OhxK+QRmRP2nPatzfEGaIaUcPM3n4nNeiBp+bs3cuKCa0R7IcWu8sJKkHyH/3AT7G29xTUPRRuejZLlNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wjmtfcOu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C27EDC4CEE2;
	Wed, 23 Apr 2025 14:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745419663;
	bh=7EkyNIrNuZOplXgfZxKxpB5jgn3FxXOYFMX/A4crUpM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wjmtfcOun/tIigt+ilc1ReZK9Jlx2eyJYlo5dKCxlR/wJ2x7bowXQ2zDuw0uiYPiE
	 BlG8BUThF2cp8wM3GAYcegcxcpxQB9akrJliRox0Yd5hArGst1wOdySE7jqj46QOdL
	 cktIECmI9i46rNVLxMoJ/+aaChvEqxDWgkl227Yw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Christopher S M Hall <christopher.s.hall@intel.com>,
	Corinna Vinschen <vinschen@redhat.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Mor Bar-Gabay <morx.bar.gabay@intel.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 038/223] igc: add lock preventing multiple simultaneous PTM transactions
Date: Wed, 23 Apr 2025 16:41:50 +0200
Message-ID: <20250423142618.680520671@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423142617.120834124@linuxfoundation.org>
References: <20250423142617.120834124@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christopher S M Hall <christopher.s.hall@intel.com>

[ Upstream commit 1a931c4f5e6862e61a4b130cb76b422e1415f644 ]

Add a mutex around the PTM transaction to prevent multiple transactors

Multiple processes try to initiate a PTM transaction, one or all may
fail. This can be reproduced by running two instances of the
following:

$ sudo phc2sys -O 0 -i tsn0 -m

PHC2SYS exits with:

"ioctl PTP_OFFSET_PRECISE: Connection timed out" when the PTM transaction
 fails

Note: Normally two instance of PHC2SYS will not run, but one process
 should not break another.

Fixes: a90ec8483732 ("igc: Add support for PTP getcrosststamp()")
Signed-off-by: Christopher S M Hall <christopher.s.hall@intel.com>
Reviewed-by: Corinna Vinschen <vinschen@redhat.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Mor Bar-Gabay <morx.bar.gabay@intel.com>
Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/igc/igc.h     |  1 +
 drivers/net/ethernet/intel/igc/igc_ptp.c | 20 ++++++++++++++++++--
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
index eac0f966e0e4c..323db1e2be388 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -319,6 +319,7 @@ struct igc_adapter {
 	struct timespec64 prev_ptp_time; /* Pre-reset PTP clock */
 	ktime_t ptp_reset_start; /* Reset time in clock mono */
 	struct system_time_snapshot snapshot;
+	struct mutex ptm_lock; /* Only allow one PTM transaction at a time */
 
 	char fw_version[32];
 
diff --git a/drivers/net/ethernet/intel/igc/igc_ptp.c b/drivers/net/ethernet/intel/igc/igc_ptp.c
index 343205bffc355..612ed26a29c5d 100644
--- a/drivers/net/ethernet/intel/igc/igc_ptp.c
+++ b/drivers/net/ethernet/intel/igc/igc_ptp.c
@@ -974,6 +974,7 @@ static void igc_ptm_log_error(struct igc_adapter *adapter, u32 ptm_stat)
 	}
 }
 
+/* The PTM lock: adapter->ptm_lock must be held when calling igc_ptm_trigger() */
 static void igc_ptm_trigger(struct igc_hw *hw)
 {
 	u32 ctrl;
@@ -990,6 +991,7 @@ static void igc_ptm_trigger(struct igc_hw *hw)
 	wrfl();
 }
 
+/* The PTM lock: adapter->ptm_lock must be held when calling igc_ptm_reset() */
 static void igc_ptm_reset(struct igc_hw *hw)
 {
 	u32 ctrl;
@@ -1068,9 +1070,16 @@ static int igc_ptp_getcrosststamp(struct ptp_clock_info *ptp,
 {
 	struct igc_adapter *adapter = container_of(ptp, struct igc_adapter,
 						   ptp_caps);
+	int ret;
 
-	return get_device_system_crosststamp(igc_phc_get_syncdevicetime,
-					     adapter, &adapter->snapshot, cts);
+	/* This blocks until any in progress PTM transactions complete */
+	mutex_lock(&adapter->ptm_lock);
+
+	ret = get_device_system_crosststamp(igc_phc_get_syncdevicetime,
+					    adapter, &adapter->snapshot, cts);
+	mutex_unlock(&adapter->ptm_lock);
+
+	return ret;
 }
 
 static int igc_ptp_getcyclesx64(struct ptp_clock_info *ptp,
@@ -1169,6 +1178,7 @@ void igc_ptp_init(struct igc_adapter *adapter)
 	spin_lock_init(&adapter->ptp_tx_lock);
 	spin_lock_init(&adapter->free_timer_lock);
 	spin_lock_init(&adapter->tmreg_lock);
+	mutex_init(&adapter->ptm_lock);
 
 	adapter->tstamp_config.rx_filter = HWTSTAMP_FILTER_NONE;
 	adapter->tstamp_config.tx_type = HWTSTAMP_TX_OFF;
@@ -1181,6 +1191,7 @@ void igc_ptp_init(struct igc_adapter *adapter)
 	if (IS_ERR(adapter->ptp_clock)) {
 		adapter->ptp_clock = NULL;
 		netdev_err(netdev, "ptp_clock_register failed\n");
+		mutex_destroy(&adapter->ptm_lock);
 	} else if (adapter->ptp_clock) {
 		netdev_info(netdev, "PHC added\n");
 		adapter->ptp_flags |= IGC_PTP_ENABLED;
@@ -1210,10 +1221,12 @@ static void igc_ptm_stop(struct igc_adapter *adapter)
 	struct igc_hw *hw = &adapter->hw;
 	u32 ctrl;
 
+	mutex_lock(&adapter->ptm_lock);
 	ctrl = rd32(IGC_PTM_CTRL);
 	ctrl &= ~IGC_PTM_CTRL_EN;
 
 	wr32(IGC_PTM_CTRL, ctrl);
+	mutex_unlock(&adapter->ptm_lock);
 }
 
 /**
@@ -1255,6 +1268,7 @@ void igc_ptp_stop(struct igc_adapter *adapter)
 		netdev_info(adapter->netdev, "PHC removed\n");
 		adapter->ptp_flags &= ~IGC_PTP_ENABLED;
 	}
+	mutex_destroy(&adapter->ptm_lock);
 }
 
 /**
@@ -1294,6 +1308,7 @@ void igc_ptp_reset(struct igc_adapter *adapter)
 		if (!igc_is_crosststamp_supported(adapter))
 			break;
 
+		mutex_lock(&adapter->ptm_lock);
 		wr32(IGC_PCIE_DIG_DELAY, IGC_PCIE_DIG_DELAY_DEFAULT);
 		wr32(IGC_PCIE_PHY_DELAY, IGC_PCIE_PHY_DELAY_DEFAULT);
 
@@ -1317,6 +1332,7 @@ void igc_ptp_reset(struct igc_adapter *adapter)
 			netdev_err(adapter->netdev, "Timeout reading IGC_PTM_STAT register\n");
 
 		igc_ptm_reset(hw);
+		mutex_unlock(&adapter->ptm_lock);
 		break;
 	default:
 		/* No work to do. */
-- 
2.39.5




