Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5977ECB5D
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:21:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232844AbjKOTVs (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:21:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232889AbjKOTVq (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:21:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A632B1A7
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:21:42 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F6FAC433CB;
        Wed, 15 Nov 2023 19:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076102;
        bh=OLpljzLLXledCDe+lupBRhl0UlRBP5EzBpUaZ+t+vvw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FWPDzZnDK0Zgo24WxMscW9fhDwxB0UXu/EwxSWw7rWRoNerVXQZqzPbdPI1qDfgAh
         PJT3I37tU692PeTiq/HiSHSvZJgCb2C7glR8MxY9c0Ea1Xb/Sl8DcXSHneMiOpF3kb
         e6fb2SPUgzUHU88za68S96RqN0dwXd15JzFz2ckU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Baochen Qiang <quic_bqiang@quicinc.com>,
        Jeff Johnson <quic_jjohnson@quicinc.com>,
        Kalle Valo <quic_kvalo@quicinc.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 077/550] wifi: ath11k: fix boot failure with one MSI vector
Date:   Wed, 15 Nov 2023 14:11:01 -0500
Message-ID: <20231115191606.040596069@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
References: <20231115191600.708733204@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Baochen Qiang <quic_bqiang@quicinc.com>

[ Upstream commit 39564b475ac5a589e6c22c43a08cbd283c295d2c ]

Commit 5b32b6dd96633 ("ath11k: Remove core PCI references from
PCI common code") breaks with one MSI vector because it moves
affinity setting after IRQ request, see below log:

[ 1417.278835] ath11k_pci 0000:02:00.0: failed to receive control response completion, polling..
[ 1418.302829] ath11k_pci 0000:02:00.0: Service connect timeout
[ 1418.302833] ath11k_pci 0000:02:00.0: failed to connect to HTT: -110
[ 1418.303669] ath11k_pci 0000:02:00.0: failed to start core: -110

The detail is, if do affinity request after IRQ activated,
which is done in request_irq(), kernel caches that request and
returns success directly. Later when a subsequent MHI interrupt is
fired, kernel will do the real affinity setting work, as a result,
changs the MSI vector. However at that time host has configured
old vector to hardware, so host never receives CE or DP interrupts.

Fix it by setting affinity before registering MHI controller
where host is, for the first time, doing IRQ request.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3
Tested-on: WCN6855 hw2.1 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.23
Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-01160-QCAMSLSWPLZ-1

Fixes: 5b32b6dd9663 ("ath11k: Remove core PCI references from PCI common code")
Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Link: https://lore.kernel.org/r/20230907015606.16297-1-quic_bqiang@quicinc.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath11k/pci.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index a181563ec0851..c0f00343cee93 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -853,10 +853,16 @@ static int ath11k_pci_probe(struct pci_dev *pdev,
 	if (ret)
 		goto err_pci_disable_msi;
 
+	ret = ath11k_pci_set_irq_affinity_hint(ab_pci, cpumask_of(0));
+	if (ret) {
+		ath11k_err(ab, "failed to set irq affinity %d\n", ret);
+		goto err_pci_disable_msi;
+	}
+
 	ret = ath11k_mhi_register(ab_pci);
 	if (ret) {
 		ath11k_err(ab, "failed to register mhi: %d\n", ret);
-		goto err_pci_disable_msi;
+		goto err_irq_affinity_cleanup;
 	}
 
 	ret = ath11k_hal_srng_init(ab);
@@ -877,12 +883,6 @@ static int ath11k_pci_probe(struct pci_dev *pdev,
 		goto err_ce_free;
 	}
 
-	ret = ath11k_pci_set_irq_affinity_hint(ab_pci, cpumask_of(0));
-	if (ret) {
-		ath11k_err(ab, "failed to set irq affinity %d\n", ret);
-		goto err_free_irq;
-	}
-
 	/* kernel may allocate a dummy vector before request_irq and
 	 * then allocate a real vector when request_irq is called.
 	 * So get msi_data here again to avoid spurious interrupt
@@ -891,19 +891,16 @@ static int ath11k_pci_probe(struct pci_dev *pdev,
 	ret = ath11k_pci_config_msi_data(ab_pci);
 	if (ret) {
 		ath11k_err(ab, "failed to config msi_data: %d\n", ret);
-		goto err_irq_affinity_cleanup;
+		goto err_free_irq;
 	}
 
 	ret = ath11k_core_init(ab);
 	if (ret) {
 		ath11k_err(ab, "failed to init core: %d\n", ret);
-		goto err_irq_affinity_cleanup;
+		goto err_free_irq;
 	}
 	return 0;
 
-err_irq_affinity_cleanup:
-	ath11k_pci_set_irq_affinity_hint(ab_pci, NULL);
-
 err_free_irq:
 	ath11k_pcic_free_irq(ab);
 
@@ -916,6 +913,9 @@ static int ath11k_pci_probe(struct pci_dev *pdev,
 err_mhi_unregister:
 	ath11k_mhi_unregister(ab_pci);
 
+err_irq_affinity_cleanup:
+	ath11k_pci_set_irq_affinity_hint(ab_pci, NULL);
+
 err_pci_disable_msi:
 	ath11k_pci_free_msi(ab_pci);
 
-- 
2.42.0



