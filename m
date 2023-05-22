Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD3270C944
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235310AbjEVTqW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235306AbjEVTqK (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:46:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B198ACA
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:46:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 091A662A05
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:41:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25093C433EF;
        Mon, 22 May 2023 19:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684784460;
        bh=2tRrkC9JHVtFCcO4a225R9L9gwQ5SJUE2MMF9SOaU48=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HR0zvqOZBM8bL1KbNrPLtbyYwWOaLmxanc4RqUFeRozv8tav6XAdp+TLM/phaB0UR
         Ds8G9yUgH4kvgKMPXwxx33+UeHZzVEHImKrKIaplCVRq6qhz5hvDjHCGDDV9qwQVgM
         0IRiR548Tbi05JWrzti05mt9malDuKpCadeQsGAE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Ramya Gnanasekar <quic_rgnanase@quicinc.com>,
        Kalle Valo <quic_kvalo@quicinc.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 090/364] wifi: ath12k: PCI ops for wakeup/release MHI
Date:   Mon, 22 May 2023 20:06:35 +0100
Message-Id: <20230522190415.003163055@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190412.801391872@linuxfoundation.org>
References: <20230522190412.801391872@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Ramya Gnanasekar <quic_rgnanase@quicinc.com>

[ Upstream commit 80e396586d0a94c42015dd9472176d89a3b0e4ca ]

Wakeup/release MHI is not needed before pci_read/write for QCN9274.
Since wakeup & release MHI is enabled for all QCN9274 and
WCN7850, below MHI assert is seen in QCN9274

[  784.906613] BUG: sleeping function called from invalid context at drivers/bus/mhi/host/pm.c:989
[  784.906633] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 0, name: swapper/3
[  784.906637] preempt_count: 503, expected: 0
[  784.906641] RCU nest depth: 0, expected: 0
[  784.906644] 2 locks held by swapper/3/0:
[  784.906646]  #0: ffff8ed348e429e0 (&ab->ce.ce_lock){+.-.}-{2:2}, at: ath12k_ce_recv_process_cb+0xb3/0x2f0 [ath12k]
[  784.906664]  #1: ffff8ed348e491f0 (&srng->lock_key#3){+.-.}-{2:2}, at: ath12k_ce_recv_process_cb+0xfb/0x2f0 [ath12k]
[  784.906678] Preemption disabled at:
[  784.906680] [<0000000000000000>] 0x0
[  784.906686] CPU: 3 PID: 0 Comm: swapper/3 Tainted: G        W  O       6.1.0-rc2+ #3
[  784.906688] Hardware name: Intel(R) Client Systems NUC8i7HVK/NUC8i7HVB, BIOS HNKBLi70.86A.0056.2019.0506.1527 05/06/2019
[  784.906690] Call Trace:
[  784.906691]  <IRQ>
[  784.906693]  dump_stack_lvl+0x56/0x7b
[  784.906698]  __might_resched+0x21c/0x270
[  784.906704]  __mhi_device_get_sync+0x7d/0x1c0 [mhi]
[  784.906714]  mhi_device_get_sync+0xd/0x20 [mhi]
[  784.906719]  ath12k_pci_write32+0x75/0x170 [ath12k]
[  784.906729]  ath12k_hal_srng_access_end+0x55/0xc0 [ath12k]
[  784.906737]  ath12k_ce_recv_process_cb+0x1f3/0x2f0 [ath12k]
[  784.906776]  ? ath12k_pci_ce_tasklet+0x11/0x30 [ath12k]
[  784.906788]  ath12k_pci_ce_tasklet+0x11/0x30 [ath12k]
[  784.906813]  tasklet_action_common.isra.18+0xb7/0xe0
[  784.906820]  __do_softirq+0xd0/0x4c9
[  784.906826]  irq_exit_rcu+0x88/0xe0
[  784.906828]  common_interrupt+0xa5/0xc0
[  784.906831]  </IRQ>
[  784.906832]  <TASK>

Adding function callbacks for MHI wakeup and release operations.
QCN9274 does not need wakeup/release, function callbacks are initialized
to NULL. In case of WCN7850, shadow registers are used to access rings.
Since, shadow register's offset is less than ACCESS_ALWAYS_OFF,
mhi_device_get_sync() or mhi_device_put() to wakeup
and release mhi will not be called during service ring accesses.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0-03171-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

Signed-off-by: Ramya Gnanasekar <quic_rgnanase@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Link: https://lore.kernel.org/r/20230123095141.5310-1-quic_rgnanase@quicinc.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath12k/pci.c | 47 ++++++++++++++++++++++-----
 drivers/net/wireless/ath/ath12k/pci.h |  6 ++++
 2 files changed, 44 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/pci.c b/drivers/net/wireless/ath/ath12k/pci.c
index f523aa15885f6..00b0080dbac38 100644
--- a/drivers/net/wireless/ath/ath12k/pci.c
+++ b/drivers/net/wireless/ath/ath12k/pci.c
@@ -119,6 +119,30 @@ static const char *irq_name[ATH12K_IRQ_NUM_MAX] = {
 	"tcl2host-status-ring",
 };
 
+static int ath12k_pci_bus_wake_up(struct ath12k_base *ab)
+{
+	struct ath12k_pci *ab_pci = ath12k_pci_priv(ab);
+
+	return mhi_device_get_sync(ab_pci->mhi_ctrl->mhi_dev);
+}
+
+static void ath12k_pci_bus_release(struct ath12k_base *ab)
+{
+	struct ath12k_pci *ab_pci = ath12k_pci_priv(ab);
+
+	mhi_device_put(ab_pci->mhi_ctrl->mhi_dev);
+}
+
+static const struct ath12k_pci_ops ath12k_pci_ops_qcn9274 = {
+	.wakeup = NULL,
+	.release = NULL,
+};
+
+static const struct ath12k_pci_ops ath12k_pci_ops_wcn7850 = {
+	.wakeup = ath12k_pci_bus_wake_up,
+	.release = ath12k_pci_bus_release,
+};
+
 static void ath12k_pci_select_window(struct ath12k_pci *ab_pci, u32 offset)
 {
 	struct ath12k_base *ab = ab_pci->ab;
@@ -989,13 +1013,14 @@ u32 ath12k_pci_read32(struct ath12k_base *ab, u32 offset)
 {
 	struct ath12k_pci *ab_pci = ath12k_pci_priv(ab);
 	u32 val, window_start;
+	int ret = 0;
 
 	/* for offset beyond BAR + 4K - 32, may
 	 * need to wakeup MHI to access.
 	 */
 	if (test_bit(ATH12K_PCI_FLAG_INIT_DONE, &ab_pci->flags) &&
-	    offset >= ACCESS_ALWAYS_OFF)
-		mhi_device_get_sync(ab_pci->mhi_ctrl->mhi_dev);
+	    offset >= ACCESS_ALWAYS_OFF && ab_pci->pci_ops->wakeup)
+		ret = ab_pci->pci_ops->wakeup(ab);
 
 	if (offset < WINDOW_START) {
 		val = ioread32(ab->mem + offset);
@@ -1023,9 +1048,9 @@ u32 ath12k_pci_read32(struct ath12k_base *ab, u32 offset)
 	}
 
 	if (test_bit(ATH12K_PCI_FLAG_INIT_DONE, &ab_pci->flags) &&
-	    offset >= ACCESS_ALWAYS_OFF)
-		mhi_device_put(ab_pci->mhi_ctrl->mhi_dev);
-
+	    offset >= ACCESS_ALWAYS_OFF && ab_pci->pci_ops->release &&
+	    !ret)
+		ab_pci->pci_ops->release(ab);
 	return val;
 }
 
@@ -1033,13 +1058,14 @@ void ath12k_pci_write32(struct ath12k_base *ab, u32 offset, u32 value)
 {
 	struct ath12k_pci *ab_pci = ath12k_pci_priv(ab);
 	u32 window_start;
+	int ret = 0;
 
 	/* for offset beyond BAR + 4K - 32, may
 	 * need to wakeup MHI to access.
 	 */
 	if (test_bit(ATH12K_PCI_FLAG_INIT_DONE, &ab_pci->flags) &&
-	    offset >= ACCESS_ALWAYS_OFF)
-		mhi_device_get_sync(ab_pci->mhi_ctrl->mhi_dev);
+	    offset >= ACCESS_ALWAYS_OFF && ab_pci->pci_ops->wakeup)
+		ret = ab_pci->pci_ops->wakeup(ab);
 
 	if (offset < WINDOW_START) {
 		iowrite32(value, ab->mem + offset);
@@ -1067,8 +1093,9 @@ void ath12k_pci_write32(struct ath12k_base *ab, u32 offset, u32 value)
 	}
 
 	if (test_bit(ATH12K_PCI_FLAG_INIT_DONE, &ab_pci->flags) &&
-	    offset >= ACCESS_ALWAYS_OFF)
-		mhi_device_put(ab_pci->mhi_ctrl->mhi_dev);
+	    offset >= ACCESS_ALWAYS_OFF && ab_pci->pci_ops->release &&
+	    !ret)
+		ab_pci->pci_ops->release(ab);
 }
 
 int ath12k_pci_power_up(struct ath12k_base *ab)
@@ -1182,6 +1209,7 @@ static int ath12k_pci_probe(struct pci_dev *pdev,
 	case QCN9274_DEVICE_ID:
 		ab_pci->msi_config = &ath12k_msi_config[0];
 		ab->static_window_map = true;
+		ab_pci->pci_ops = &ath12k_pci_ops_qcn9274;
 		ath12k_pci_read_hw_version(ab, &soc_hw_version_major,
 					   &soc_hw_version_minor);
 		switch (soc_hw_version_major) {
@@ -1203,6 +1231,7 @@ static int ath12k_pci_probe(struct pci_dev *pdev,
 		ab_pci->msi_config = &ath12k_msi_config[0];
 		ab->static_window_map = false;
 		ab->hw_rev = ATH12K_HW_WCN7850_HW20;
+		ab_pci->pci_ops = &ath12k_pci_ops_wcn7850;
 		break;
 
 	default:
diff --git a/drivers/net/wireless/ath/ath12k/pci.h b/drivers/net/wireless/ath/ath12k/pci.h
index 0d9e40ab31f26..0f24fd9395cd9 100644
--- a/drivers/net/wireless/ath/ath12k/pci.h
+++ b/drivers/net/wireless/ath/ath12k/pci.h
@@ -86,6 +86,11 @@ enum ath12k_pci_flags {
 	ATH12K_PCI_ASPM_RESTORE,
 };
 
+struct ath12k_pci_ops {
+	int (*wakeup)(struct ath12k_base *ab);
+	void (*release)(struct ath12k_base *ab);
+};
+
 struct ath12k_pci {
 	struct pci_dev *pdev;
 	struct ath12k_base *ab;
@@ -103,6 +108,7 @@ struct ath12k_pci {
 	/* enum ath12k_pci_flags */
 	unsigned long flags;
 	u16 link_ctl;
+	const struct ath12k_pci_ops *pci_ops;
 };
 
 static inline struct ath12k_pci *ath12k_pci_priv(struct ath12k_base *ab)
-- 
2.39.2



