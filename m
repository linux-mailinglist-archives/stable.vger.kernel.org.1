Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E641726B0D
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232927AbjFGUWM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232942AbjFGUWA (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:22:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD212113
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:21:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 07DC6643C7
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:20:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AF0CC433D2;
        Wed,  7 Jun 2023 20:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686169258;
        bh=0Bddund4ctp5VzkgWfxqCNkJxJGMr7Zt1rrv/fqnFxk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UqF0xZw8wp6Zjt9+eccTcODA4/BRAe5IAdTr7ADcV/deV/W6s4/VhIF+E9VO8wN7K
         lHSUqjiPiGoj6O91n6wYfWcrs+ZjA0Qdat3gdFOKLmYbq/54mQetLcSsEMYc9UYGCK
         NiVINS4WJNLVUJGCWqNy6jEdGAAVtBWwlpIm+/ts=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Vasant Hegde <vasant.hegde@amd.com>,
        Joerg Roedel <jroedel@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 013/286] iommu/amd: Handle GALog overflows
Date:   Wed,  7 Jun 2023 22:11:52 +0200
Message-ID: <20230607200923.427588032@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200922.978677727@linuxfoundation.org>
References: <20230607200922.978677727@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Joao Martins <joao.m.martins@oracle.com>

[ Upstream commit af47b0a24058e56e983881993752f88288ca6511 ]

GALog exists to propagate interrupts into all vCPUs in the system when
interrupts are marked as non running (e.g. when vCPUs aren't running). A
GALog overflow happens when there's in no space in the log to record the
GATag of the interrupt. So when the GALOverflow condition happens, the
GALog queue is processed and the GALog is restarted, as the IOMMU
manual indicates in section "2.7.4 Guest Virtual APIC Log Restart
Procedure":

| * Wait until MMIO Offset 2020h[GALogRun]=0b so that all request
|   entries are completed as circumstances allow. GALogRun must be 0b to
|   modify the guest virtual APIC log registers safely.
| * Write MMIO Offset 0018h[GALogEn]=0b.
| * As necessary, change the following values (e.g., to relocate or
| resize the guest virtual APIC event log):
|   - the Guest Virtual APIC Log Base Address Register
|      [MMIO Offset 00E0h],
|   - the Guest Virtual APIC Log Head Pointer Register
|      [MMIO Offset 2040h][GALogHead], and
|   - the Guest Virtual APIC Log Tail Pointer Register
|      [MMIO Offset 2048h][GALogTail].
| * Write MMIO Offset 2020h[GALOverflow] = 1b to clear the bit (W1C).
| * Write MMIO Offset 0018h[GALogEn] = 1b, and either set
|   MMIO Offset 0018h[GAIntEn] to enable the GA log interrupt or clear
|   the bit to disable it.

Failing to handle the GALog overflow means that none of the VFs (in any
guest) will work with IOMMU AVIC forcing the user to power cycle the
host. When handling the event it resumes the GALog without resizing
much like how it is done in the event handler overflow. The
[MMIO Offset 2020h][GALOverflow] bit might be set in status register
without the [MMIO Offset 2020h][GAInt] bit, so when deciding to poll
for GA events (to clear space in the galog), also check the overflow
bit.

[suravee: Check for GAOverflow without GAInt, toggle CONTROL_GAINT_EN]

Co-developed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
Link: https://lore.kernel.org/r/20230419201154.83880-3-joao.m.martins@oracle.com
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Stable-dep-of: 8ec4e2befef1 ("iommu/amd: Fix up merge conflict resolution")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/amd/amd_iommu.h |  1 +
 drivers/iommu/amd/init.c      | 24 ++++++++++++++++++++++++
 drivers/iommu/amd/iommu.c     |  9 ++++++++-
 3 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index c160a332ce339..24c7e6c6c0de9 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -15,6 +15,7 @@ extern irqreturn_t amd_iommu_int_thread(int irq, void *data);
 extern irqreturn_t amd_iommu_int_handler(int irq, void *data);
 extern void amd_iommu_apply_erratum_63(struct amd_iommu *iommu, u16 devid);
 extern void amd_iommu_restart_event_logging(struct amd_iommu *iommu);
+extern void amd_iommu_restart_ga_log(struct amd_iommu *iommu);
 extern int amd_iommu_init_devices(void);
 extern void amd_iommu_uninit_devices(void);
 extern void amd_iommu_init_notifier(void);
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 19a46b9f73574..fd487c33b28aa 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -751,6 +751,30 @@ void amd_iommu_restart_event_logging(struct amd_iommu *iommu)
 	iommu_feature_enable(iommu, CONTROL_EVT_LOG_EN);
 }
 
+/*
+ * This function restarts event logging in case the IOMMU experienced
+ * an GA log overflow.
+ */
+void amd_iommu_restart_ga_log(struct amd_iommu *iommu)
+{
+	u32 status;
+
+	status = readl(iommu->mmio_base + MMIO_STATUS_OFFSET);
+	if (status & MMIO_STATUS_GALOG_RUN_MASK)
+		return;
+
+	pr_info_ratelimited("IOMMU GA Log restarting\n");
+
+	iommu_feature_disable(iommu, CONTROL_GALOG_EN);
+	iommu_feature_disable(iommu, CONTROL_GAINT_EN);
+
+	writel(MMIO_STATUS_GALOG_OVERFLOW_MASK,
+	       iommu->mmio_base + MMIO_STATUS_OFFSET);
+
+	iommu_feature_enable(iommu, CONTROL_GAINT_EN);
+	iommu_feature_enable(iommu, CONTROL_GALOG_EN);
+}
+
 /*
  * This function resets the command buffer if the IOMMU stopped fetching
  * commands from it.
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 99ec06b0e09f6..478da9b4a1b14 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -845,6 +845,7 @@ amd_iommu_set_pci_msi_domain(struct device *dev, struct amd_iommu *iommu) { }
 	(MMIO_STATUS_EVT_OVERFLOW_INT_MASK | \
 	 MMIO_STATUS_EVT_INT_MASK | \
 	 MMIO_STATUS_PPR_INT_MASK | \
+	 MMIO_STATUS_GALOG_OVERFLOW_MASK | \
 	 MMIO_STATUS_GALOG_INT_MASK)
 
 irqreturn_t amd_iommu_int_thread(int irq, void *data)
@@ -868,10 +869,16 @@ irqreturn_t amd_iommu_int_thread(int irq, void *data)
 		}
 
 #ifdef CONFIG_IRQ_REMAP
-		if (status & MMIO_STATUS_GALOG_INT_MASK) {
+		if (status & (MMIO_STATUS_GALOG_INT_MASK |
+			      MMIO_STATUS_GALOG_OVERFLOW_MASK)) {
 			pr_devel("Processing IOMMU GA Log\n");
 			iommu_poll_ga_log(iommu);
 		}
+
+		if (status & MMIO_STATUS_GALOG_OVERFLOW_MASK) {
+			pr_info_ratelimited("IOMMU GA Log overflow\n");
+			amd_iommu_restart_ga_log(iommu);
+		}
 #endif
 
 		if (status & MMIO_STATUS_EVT_OVERFLOW_INT_MASK) {
-- 
2.39.2



