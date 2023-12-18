Return-Path: <stable+bounces-7302-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD678171EE
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:05:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E81781C23E5B
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 14:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15DDF3A1AC;
	Mon, 18 Dec 2023 14:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TJR6VbQC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A9037884;
	Mon, 18 Dec 2023 14:01:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15F64C433C7;
	Mon, 18 Dec 2023 14:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702908103;
	bh=0CDsM3hDvEsjz7HJZyguAm6fYxSG4eOxUenvGlKqB7Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TJR6VbQClt/WlDnrgBsrWIepjagj/KOmNMrZedAngI9UVOCLJdoyfTAMYB0usojjs
	 5xEuMGmAnoW0bOWAWqIDSi6ykoC54QPJH1/k5RJglYqGFS8ZFkqgoRysJoIE5BK/lX
	 Y3Wl/9YS7DQJYkbOJhT54yaILMd3r2aTrSJMP1Ik=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Vikas Gupta <vikas.gupta@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 026/166] bnxt_en: Fix wrong return value check in bnxt_close_nic()
Date: Mon, 18 Dec 2023 14:49:52 +0100
Message-ID: <20231218135106.107842751@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218135104.927894164@linuxfoundation.org>
References: <20231218135104.927894164@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>

[ Upstream commit bd6781c18cb5b5e5d8c5873fa9a51668e89ec76e ]

The wait_event_interruptible_timeout() function returns 0
if the timeout elapsed, -ERESTARTSYS if it was interrupted
by a signal, and the remaining jiffies otherwise if the
condition evaluated to true before the timeout elapsed.

Driver should have checked for zero return value instead of
a positive value.

MChan: Print a warning for -ERESTARTSYS.  The close operation
will proceed anyway when wait_event_interruptible_timeout()
returns for any reason.  Since we do the close no matter what,
we should not return this error code to the caller.  Change
bnxt_close_nic() to a void function and remove all error
handling from some of the callers.

Fixes: c0c050c58d84 ("bnxt_en: New Broadcom ethernet driver.")
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Link: https://lore.kernel.org/r/20231208001658.14230-4-michael.chan@broadcom.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 13 +++++++------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  2 +-
 .../net/ethernet/broadcom/bnxt/bnxt_devlink.c | 11 ++---------
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 19 ++++---------------
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c |  5 ++---
 5 files changed, 16 insertions(+), 34 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 9f52b943fedec..4ce34a39bb5ee 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -10704,10 +10704,8 @@ static void __bnxt_close_nic(struct bnxt *bp, bool irq_re_init,
 	bnxt_free_mem(bp, irq_re_init);
 }
 
-int bnxt_close_nic(struct bnxt *bp, bool irq_re_init, bool link_re_init)
+void bnxt_close_nic(struct bnxt *bp, bool irq_re_init, bool link_re_init)
 {
-	int rc = 0;
-
 	if (test_bit(BNXT_STATE_IN_FW_RESET, &bp->state)) {
 		/* If we get here, it means firmware reset is in progress
 		 * while we are trying to close.  We can safely proceed with
@@ -10722,15 +10720,18 @@ int bnxt_close_nic(struct bnxt *bp, bool irq_re_init, bool link_re_init)
 
 #ifdef CONFIG_BNXT_SRIOV
 	if (bp->sriov_cfg) {
+		int rc;
+
 		rc = wait_event_interruptible_timeout(bp->sriov_cfg_wait,
 						      !bp->sriov_cfg,
 						      BNXT_SRIOV_CFG_WAIT_TMO);
-		if (rc)
-			netdev_warn(bp->dev, "timeout waiting for SRIOV config operation to complete!\n");
+		if (!rc)
+			netdev_warn(bp->dev, "timeout waiting for SRIOV config operation to complete, proceeding to close!\n");
+		else if (rc < 0)
+			netdev_warn(bp->dev, "SRIOV config operation interrupted, proceeding to close!\n");
 	}
 #endif
 	__bnxt_close_nic(bp, irq_re_init, link_re_init);
-	return rc;
 }
 
 static int bnxt_close(struct net_device *dev)
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 84cbcfa61bc12..ea0f47eceea7c 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2362,7 +2362,7 @@ int bnxt_open_nic(struct bnxt *, bool, bool);
 int bnxt_half_open_nic(struct bnxt *bp);
 void bnxt_half_close_nic(struct bnxt *bp);
 void bnxt_reenable_sriov(struct bnxt *bp);
-int bnxt_close_nic(struct bnxt *, bool, bool);
+void bnxt_close_nic(struct bnxt *, bool, bool);
 void bnxt_get_ring_err_stats(struct bnxt *bp,
 			     struct bnxt_total_ring_err_stats *stats);
 int bnxt_dbg_hwrm_rd_reg(struct bnxt *bp, u32 reg_off, u16 num_words,
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
index 8b3e7697390f7..9d39f194b260f 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
@@ -478,15 +478,8 @@ static int bnxt_dl_reload_down(struct devlink *dl, bool netns_change,
 			return -ENODEV;
 		}
 		bnxt_ulp_stop(bp);
-		if (netif_running(bp->dev)) {
-			rc = bnxt_close_nic(bp, true, true);
-			if (rc) {
-				NL_SET_ERR_MSG_MOD(extack, "Failed to close");
-				dev_close(bp->dev);
-				rtnl_unlock();
-				break;
-			}
-		}
+		if (netif_running(bp->dev))
+			bnxt_close_nic(bp, true, true);
 		bnxt_vf_reps_free(bp);
 		rc = bnxt_hwrm_func_drv_unrgtr(bp);
 		if (rc) {
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 547247d98eba2..3c36dd8051485 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -164,9 +164,8 @@ static int bnxt_set_coalesce(struct net_device *dev,
 reset_coalesce:
 	if (test_bit(BNXT_STATE_OPEN, &bp->state)) {
 		if (update_stats) {
-			rc = bnxt_close_nic(bp, true, false);
-			if (!rc)
-				rc = bnxt_open_nic(bp, true, false);
+			bnxt_close_nic(bp, true, false);
+			rc = bnxt_open_nic(bp, true, false);
 		} else {
 			rc = bnxt_hwrm_set_coal(bp);
 		}
@@ -955,12 +954,7 @@ static int bnxt_set_channels(struct net_device *dev,
 			 * before PF unload
 			 */
 		}
-		rc = bnxt_close_nic(bp, true, false);
-		if (rc) {
-			netdev_err(bp->dev, "Set channel failure rc :%x\n",
-				   rc);
-			return rc;
-		}
+		bnxt_close_nic(bp, true, false);
 	}
 
 	if (sh) {
@@ -3737,12 +3731,7 @@ static void bnxt_self_test(struct net_device *dev, struct ethtool_test *etest,
 		bnxt_run_fw_tests(bp, test_mask, &test_results);
 	} else {
 		bnxt_ulp_stop(bp);
-		rc = bnxt_close_nic(bp, true, false);
-		if (rc) {
-			etest->flags |= ETH_TEST_FL_FAILED;
-			bnxt_ulp_start(bp, rc);
-			return;
-		}
+		bnxt_close_nic(bp, true, false);
 		bnxt_run_fw_tests(bp, test_mask, &test_results);
 
 		buf[BNXT_MACLPBK_TEST_IDX] = 1;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
index f3886710e7787..6e3da3362bd61 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
@@ -521,9 +521,8 @@ static int bnxt_hwrm_ptp_cfg(struct bnxt *bp)
 
 	if (netif_running(bp->dev)) {
 		if (ptp->rx_filter == HWTSTAMP_FILTER_ALL) {
-			rc = bnxt_close_nic(bp, false, false);
-			if (!rc)
-				rc = bnxt_open_nic(bp, false, false);
+			bnxt_close_nic(bp, false, false);
+			rc = bnxt_open_nic(bp, false, false);
 		} else {
 			bnxt_ptp_cfg_tstamp_filters(bp);
 		}
-- 
2.43.0




