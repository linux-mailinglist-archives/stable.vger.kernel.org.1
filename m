Return-Path: <stable+bounces-74346-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48048972EDB
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 11:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F403F28883D
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 09:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1EC190685;
	Tue, 10 Sep 2024 09:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CzpzoUDo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11CD13B2B0;
	Tue, 10 Sep 2024 09:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725961537; cv=none; b=TFj/shSFRJWsBf94dwtoDP9mySM4+++jM9xTiPkRBz3nLldaJJR3mOEJfyLKoJUzTveSH8QSAe4iSz//C8olnHSEodoMw2VBAm/YjtJ4ZS4S0N5FqzTfIHwD3ATRJksCclWPlx+/e9fqP370pweEttuF2Rw7CxqP998wcOp+j8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725961537; c=relaxed/simple;
	bh=LYilvmt/LwK1C9i9sW8W6ZUnMNvJZ/D/GpZrBIbqcNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EoszlbMudK7pq7QNFLZSjaNbuVvNaOYLqc2SVy/3Osia5f5+eYRE/iieAt//VyDjSBLHouwDAz5CkkzH1w4GrdZmbeZddq3rnp6PecjsmPS5X5W7OYo1/9fjP+TxnXk+BokRkhAWAn51/3nGBNdrm2QV1KHktI7kXqNW0xTndRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CzpzoUDo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59833C4CEC3;
	Tue, 10 Sep 2024 09:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725961537;
	bh=LYilvmt/LwK1C9i9sW8W6ZUnMNvJZ/D/GpZrBIbqcNU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CzpzoUDoTZu3gdAGEtnJQIhXvi+i9JgaxTbBGuoJUDDe6aawt6N0MLz7s6juW9Ll2
	 Ylnv0X1sAOxrD1QVGOjn5RsqzQgio4sNjNc3wK+sIgb2EHvgzZl4iJivtntz1S7lr1
	 k/x/+Ke/9zh/WTKmMaLgTeJJp1n7NvbDn5DtuIQE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Baochen Qiang <quic_bqiang@quicinc.com>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Kalle Valo <quic_kvalo@quicinc.com>
Subject: [PATCH 6.10 076/375] Revert "wifi: ath11k: support hibernation"
Date: Tue, 10 Sep 2024 11:27:53 +0200
Message-ID: <20240910092624.766770141@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910092622.245959861@linuxfoundation.org>
References: <20240910092622.245959861@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Baochen Qiang <quic_bqiang@quicinc.com>

commit 2f833e8948d6c88a3a257d4e426c9897b4907d5a upstream.

This reverts commit 166a490f59ac10340ee5330e51c15188ce2a7f8f.

There are several reports that this commit breaks system suspend on some specific
Lenovo platforms. Since there is no fix available, for now revert this commit
to make suspend work again on those platforms.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219196
Closes: https://bugzilla.redhat.com/show_bug.cgi?id=2301921
Cc: <stable@vger.kernel.org> # 6.10.x: d3e154d7776b: Revert "wifi: ath11k: restore country code during resume"
Cc: <stable@vger.kernel.org> # 6.10.x
Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Link: https://patch.msgid.link/20240830073420.5790-3-quic_bqiang@quicinc.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/ath/ath11k/ahb.c  |    4 -
 drivers/net/wireless/ath/ath11k/core.c |  107 +++++++++------------------------
 drivers/net/wireless/ath/ath11k/core.h |    4 -
 drivers/net/wireless/ath/ath11k/hif.h  |   12 ---
 drivers/net/wireless/ath/ath11k/mhi.c  |   12 ---
 drivers/net/wireless/ath/ath11k/mhi.h  |    3 
 drivers/net/wireless/ath/ath11k/pci.c  |   44 ++-----------
 drivers/net/wireless/ath/ath11k/qmi.c  |    2 
 8 files changed, 49 insertions(+), 139 deletions(-)

--- a/drivers/net/wireless/ath/ath11k/ahb.c
+++ b/drivers/net/wireless/ath/ath11k/ahb.c
@@ -413,7 +413,7 @@ static int ath11k_ahb_power_up(struct at
 	return ret;
 }
 
-static void ath11k_ahb_power_down(struct ath11k_base *ab, bool is_suspend)
+static void ath11k_ahb_power_down(struct ath11k_base *ab)
 {
 	struct ath11k_ahb *ab_ahb = ath11k_ahb_priv(ab);
 
@@ -1261,7 +1261,7 @@ static void ath11k_ahb_remove(struct pla
 	struct ath11k_base *ab = platform_get_drvdata(pdev);
 
 	if (test_bit(ATH11K_FLAG_QMI_FAIL, &ab->dev_flags)) {
-		ath11k_ahb_power_down(ab, false);
+		ath11k_ahb_power_down(ab);
 		ath11k_debugfs_soc_destroy(ab);
 		ath11k_qmi_deinit_service(ab);
 		goto qmi_fail;
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -906,6 +906,12 @@ int ath11k_core_suspend(struct ath11k_ba
 		return ret;
 	}
 
+	ret = ath11k_wow_enable(ab);
+	if (ret) {
+		ath11k_warn(ab, "failed to enable wow during suspend: %d\n", ret);
+		return ret;
+	}
+
 	ret = ath11k_dp_rx_pktlog_stop(ab, false);
 	if (ret) {
 		ath11k_warn(ab, "failed to stop dp rx pktlog during suspend: %d\n",
@@ -916,85 +922,29 @@ int ath11k_core_suspend(struct ath11k_ba
 	ath11k_ce_stop_shadow_timers(ab);
 	ath11k_dp_stop_shadow_timers(ab);
 
-	/* PM framework skips suspend_late/resume_early callbacks
-	 * if other devices report errors in their suspend callbacks.
-	 * However ath11k_core_resume() would still be called because
-	 * here we return success thus kernel put us on dpm_suspended_list.
-	 * Since we won't go through a power down/up cycle, there is
-	 * no chance to call complete(&ab->restart_completed) in
-	 * ath11k_core_restart(), making ath11k_core_resume() timeout.
-	 * So call it here to avoid this issue. This also works in case
-	 * no error happens thus suspend_late/resume_early get called,
-	 * because it will be reinitialized in ath11k_core_resume_early().
-	 */
-	complete(&ab->restart_completed);
-
-	return 0;
-}
-EXPORT_SYMBOL(ath11k_core_suspend);
-
-int ath11k_core_suspend_late(struct ath11k_base *ab)
-{
-	struct ath11k_pdev *pdev;
-	struct ath11k *ar;
-
-	if (!ab->hw_params.supports_suspend)
-		return -EOPNOTSUPP;
-
-	/* so far single_pdev_only chips have supports_suspend as true
-	 * and only the first pdev is valid.
-	 */
-	pdev = ath11k_core_get_single_pdev(ab);
-	ar = pdev->ar;
-	if (!ar || ar->state != ATH11K_STATE_OFF)
-		return 0;
-
 	ath11k_hif_irq_disable(ab);
 	ath11k_hif_ce_irq_disable(ab);
 
-	ath11k_hif_power_down(ab, true);
+	ret = ath11k_hif_suspend(ab);
+	if (ret) {
+		ath11k_warn(ab, "failed to suspend hif: %d\n", ret);
+		return ret;
+	}
 
 	return 0;
 }
-EXPORT_SYMBOL(ath11k_core_suspend_late);
-
-int ath11k_core_resume_early(struct ath11k_base *ab)
-{
-	int ret;
-	struct ath11k_pdev *pdev;
-	struct ath11k *ar;
-
-	if (!ab->hw_params.supports_suspend)
-		return -EOPNOTSUPP;
-
-	/* so far single_pdev_only chips have supports_suspend as true
-	 * and only the first pdev is valid.
-	 */
-	pdev = ath11k_core_get_single_pdev(ab);
-	ar = pdev->ar;
-	if (!ar || ar->state != ATH11K_STATE_OFF)
-		return 0;
-
-	reinit_completion(&ab->restart_completed);
-	ret = ath11k_hif_power_up(ab);
-	if (ret)
-		ath11k_warn(ab, "failed to power up hif during resume: %d\n", ret);
-
-	return ret;
-}
-EXPORT_SYMBOL(ath11k_core_resume_early);
+EXPORT_SYMBOL(ath11k_core_suspend);
 
 int ath11k_core_resume(struct ath11k_base *ab)
 {
 	int ret;
 	struct ath11k_pdev *pdev;
 	struct ath11k *ar;
-	long time_left;
 
 	if (!ab->hw_params.supports_suspend)
 		return -EOPNOTSUPP;
 
-	/* so far single_pdev_only chips have supports_suspend as true
+	/* so far signle_pdev_only chips have supports_suspend as true
 	 * and only the first pdev is valid.
 	 */
 	pdev = ath11k_core_get_single_pdev(ab);
@@ -1002,19 +952,29 @@ int ath11k_core_resume(struct ath11k_bas
 	if (!ar || ar->state != ATH11K_STATE_OFF)
 		return 0;
 
-	time_left = wait_for_completion_timeout(&ab->restart_completed,
-						ATH11K_RESET_TIMEOUT_HZ);
-	if (time_left == 0) {
-		ath11k_warn(ab, "timeout while waiting for restart complete");
-		return -ETIMEDOUT;
+	ret = ath11k_hif_resume(ab);
+	if (ret) {
+		ath11k_warn(ab, "failed to resume hif during resume: %d\n", ret);
+		return ret;
 	}
 
+	ath11k_hif_ce_irq_enable(ab);
+	ath11k_hif_irq_enable(ab);
+
 	ret = ath11k_dp_rx_pktlog_start(ab);
-	if (ret)
+	if (ret) {
 		ath11k_warn(ab, "failed to start rx pktlog during resume: %d\n",
 			    ret);
+		return ret;
+	}
 
-	return ret;
+	ret = ath11k_wow_wakeup(ab);
+	if (ret) {
+		ath11k_warn(ab, "failed to wakeup wow during resume: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
 }
 EXPORT_SYMBOL(ath11k_core_resume);
 
@@ -2109,8 +2069,6 @@ static void ath11k_core_restart(struct w
 
 	if (!ab->is_reset)
 		ath11k_core_post_reconfigure_recovery(ab);
-
-	complete(&ab->restart_completed);
 }
 
 static void ath11k_core_reset(struct work_struct *work)
@@ -2180,7 +2138,7 @@ static void ath11k_core_reset(struct wor
 	ath11k_hif_irq_disable(ab);
 	ath11k_hif_ce_irq_disable(ab);
 
-	ath11k_hif_power_down(ab, false);
+	ath11k_hif_power_down(ab);
 	ath11k_hif_power_up(ab);
 
 	ath11k_dbg(ab, ATH11K_DBG_BOOT, "reset started\n");
@@ -2253,7 +2211,7 @@ void ath11k_core_deinit(struct ath11k_ba
 
 	mutex_unlock(&ab->core_lock);
 
-	ath11k_hif_power_down(ab, false);
+	ath11k_hif_power_down(ab);
 	ath11k_mac_destroy(ab);
 	ath11k_core_soc_destroy(ab);
 	ath11k_fw_destroy(ab);
@@ -2306,7 +2264,6 @@ struct ath11k_base *ath11k_core_alloc(st
 	timer_setup(&ab->rx_replenish_retry, ath11k_ce_rx_replenish_retry, 0);
 	init_completion(&ab->htc_suspend);
 	init_completion(&ab->wow.wakeup_completed);
-	init_completion(&ab->restart_completed);
 
 	ab->dev = dev;
 	ab->hif.bus = bus;
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -1033,8 +1033,6 @@ struct ath11k_base {
 		DECLARE_BITMAP(fw_features, ATH11K_FW_FEATURE_COUNT);
 	} fw;
 
-	struct completion restart_completed;
-
 #ifdef CONFIG_NL80211_TESTMODE
 	struct {
 		u32 data_pos;
@@ -1234,10 +1232,8 @@ void ath11k_core_free_bdf(struct ath11k_
 int ath11k_core_check_dt(struct ath11k_base *ath11k);
 int ath11k_core_check_smbios(struct ath11k_base *ab);
 void ath11k_core_halt(struct ath11k *ar);
-int ath11k_core_resume_early(struct ath11k_base *ab);
 int ath11k_core_resume(struct ath11k_base *ab);
 int ath11k_core_suspend(struct ath11k_base *ab);
-int ath11k_core_suspend_late(struct ath11k_base *ab);
 void ath11k_core_pre_reconfigure_recovery(struct ath11k_base *ab);
 bool ath11k_core_coldboot_cal_support(struct ath11k_base *ab);
 
--- a/drivers/net/wireless/ath/ath11k/hif.h
+++ b/drivers/net/wireless/ath/ath11k/hif.h
@@ -18,7 +18,7 @@ struct ath11k_hif_ops {
 	int (*start)(struct ath11k_base *ab);
 	void (*stop)(struct ath11k_base *ab);
 	int (*power_up)(struct ath11k_base *ab);
-	void (*power_down)(struct ath11k_base *ab, bool is_suspend);
+	void (*power_down)(struct ath11k_base *ab);
 	int (*suspend)(struct ath11k_base *ab);
 	int (*resume)(struct ath11k_base *ab);
 	int (*map_service_to_pipe)(struct ath11k_base *ab, u16 service_id,
@@ -67,18 +67,12 @@ static inline void ath11k_hif_irq_disabl
 
 static inline int ath11k_hif_power_up(struct ath11k_base *ab)
 {
-	if (!ab->hif.ops->power_up)
-		return -EOPNOTSUPP;
-
 	return ab->hif.ops->power_up(ab);
 }
 
-static inline void ath11k_hif_power_down(struct ath11k_base *ab, bool is_suspend)
+static inline void ath11k_hif_power_down(struct ath11k_base *ab)
 {
-	if (!ab->hif.ops->power_down)
-		return;
-
-	ab->hif.ops->power_down(ab, is_suspend);
+	ab->hif.ops->power_down(ab);
 }
 
 static inline int ath11k_hif_suspend(struct ath11k_base *ab)
--- a/drivers/net/wireless/ath/ath11k/mhi.c
+++ b/drivers/net/wireless/ath/ath11k/mhi.c
@@ -453,17 +453,9 @@ int ath11k_mhi_start(struct ath11k_pci *
 	return 0;
 }
 
-void ath11k_mhi_stop(struct ath11k_pci *ab_pci, bool is_suspend)
+void ath11k_mhi_stop(struct ath11k_pci *ab_pci)
 {
-	/* During suspend we need to use mhi_power_down_keep_dev()
-	 * workaround, otherwise ath11k_core_resume() will timeout
-	 * during resume.
-	 */
-	if (is_suspend)
-		mhi_power_down_keep_dev(ab_pci->mhi_ctrl, true);
-	else
-		mhi_power_down(ab_pci->mhi_ctrl, true);
-
+	mhi_power_down(ab_pci->mhi_ctrl, true);
 	mhi_unprepare_after_power_down(ab_pci->mhi_ctrl);
 }
 
--- a/drivers/net/wireless/ath/ath11k/mhi.h
+++ b/drivers/net/wireless/ath/ath11k/mhi.h
@@ -18,7 +18,7 @@
 #define MHICTRL_RESET_MASK			0x2
 
 int ath11k_mhi_start(struct ath11k_pci *ar_pci);
-void ath11k_mhi_stop(struct ath11k_pci *ar_pci, bool is_suspend);
+void ath11k_mhi_stop(struct ath11k_pci *ar_pci);
 int ath11k_mhi_register(struct ath11k_pci *ar_pci);
 void ath11k_mhi_unregister(struct ath11k_pci *ar_pci);
 void ath11k_mhi_set_mhictrl_reset(struct ath11k_base *ab);
@@ -26,4 +26,5 @@ void ath11k_mhi_clear_vector(struct ath1
 
 int ath11k_mhi_suspend(struct ath11k_pci *ar_pci);
 int ath11k_mhi_resume(struct ath11k_pci *ar_pci);
+
 #endif
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -638,7 +638,7 @@ static int ath11k_pci_power_up(struct at
 	return 0;
 }
 
-static void ath11k_pci_power_down(struct ath11k_base *ab, bool is_suspend)
+static void ath11k_pci_power_down(struct ath11k_base *ab)
 {
 	struct ath11k_pci *ab_pci = ath11k_pci_priv(ab);
 
@@ -649,7 +649,7 @@ static void ath11k_pci_power_down(struct
 
 	ath11k_pci_msi_disable(ab_pci);
 
-	ath11k_mhi_stop(ab_pci, is_suspend);
+	ath11k_mhi_stop(ab_pci);
 	clear_bit(ATH11K_FLAG_DEVICE_INIT_DONE, &ab->dev_flags);
 	ath11k_pci_sw_reset(ab_pci->ab, false);
 }
@@ -970,7 +970,7 @@ static void ath11k_pci_remove(struct pci
 	ath11k_pci_set_irq_affinity_hint(ab_pci, NULL);
 
 	if (test_bit(ATH11K_FLAG_QMI_FAIL, &ab->dev_flags)) {
-		ath11k_pci_power_down(ab, false);
+		ath11k_pci_power_down(ab);
 		ath11k_debugfs_soc_destroy(ab);
 		ath11k_qmi_deinit_service(ab);
 		goto qmi_fail;
@@ -998,7 +998,7 @@ static void ath11k_pci_shutdown(struct p
 	struct ath11k_pci *ab_pci = ath11k_pci_priv(ab);
 
 	ath11k_pci_set_irq_affinity_hint(ab_pci, NULL);
-	ath11k_pci_power_down(ab, false);
+	ath11k_pci_power_down(ab);
 }
 
 static __maybe_unused int ath11k_pci_pm_suspend(struct device *dev)
@@ -1035,39 +1035,9 @@ static __maybe_unused int ath11k_pci_pm_
 	return ret;
 }
 
-static __maybe_unused int ath11k_pci_pm_suspend_late(struct device *dev)
-{
-	struct ath11k_base *ab = dev_get_drvdata(dev);
-	int ret;
-
-	ret = ath11k_core_suspend_late(ab);
-	if (ret)
-		ath11k_warn(ab, "failed to late suspend core: %d\n", ret);
-
-	/* Similar to ath11k_pci_pm_suspend(), we return success here
-	 * even error happens, to allow system suspend/hibernation survive.
-	 */
-	return 0;
-}
-
-static __maybe_unused int ath11k_pci_pm_resume_early(struct device *dev)
-{
-	struct ath11k_base *ab = dev_get_drvdata(dev);
-	int ret;
-
-	ret = ath11k_core_resume_early(ab);
-	if (ret)
-		ath11k_warn(ab, "failed to early resume core: %d\n", ret);
-
-	return ret;
-}
-
-static const struct dev_pm_ops __maybe_unused ath11k_pci_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(ath11k_pci_pm_suspend,
-				ath11k_pci_pm_resume)
-	SET_LATE_SYSTEM_SLEEP_PM_OPS(ath11k_pci_pm_suspend_late,
-				     ath11k_pci_pm_resume_early)
-};
+static SIMPLE_DEV_PM_OPS(ath11k_pci_pm_ops,
+			 ath11k_pci_pm_suspend,
+			 ath11k_pci_pm_resume);
 
 static struct pci_driver ath11k_pci_driver = {
 	.name = "ath11k_pci",
--- a/drivers/net/wireless/ath/ath11k/qmi.c
+++ b/drivers/net/wireless/ath/ath11k/qmi.c
@@ -2877,7 +2877,7 @@ int ath11k_qmi_fwreset_from_cold_boot(st
 	}
 
 	/* reset the firmware */
-	ath11k_hif_power_down(ab, false);
+	ath11k_hif_power_down(ab);
 	ath11k_hif_power_up(ab);
 	ath11k_dbg(ab, ATH11K_DBG_QMI, "exit wait for cold boot done\n");
 	return 0;



