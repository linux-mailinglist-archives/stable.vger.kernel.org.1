Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC3D75568A
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232894AbjGPUve (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232889AbjGPUvd (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:51:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0CDCD9
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:51:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5EBBD60DD4
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:51:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 684A4C433C7;
        Sun, 16 Jul 2023 20:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689540691;
        bh=bYu5xYqkgGLkR2u921pFEK17Nkwd0nNAFAYva1ybE6s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IscSxCugctneibqY4B7M2YtI69eYob1rw3CNO2aFlA26G1wnBdakWYJbIWfqsp+hx
         PjderMHxHLpm4MNafq3+JXHf4N/HDAdpoThd2ukUFmPOXhXxIExc0X6ZhWa3E4WOSG
         nQ05lOGko31IZvETVkN+FcV9IFVISI/U6JhJErGk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 453/591] hwtracing: hisi_ptt: Fix potential sleep in atomic context
Date:   Sun, 16 Jul 2023 21:49:52 +0200
Message-ID: <20230716194935.628588593@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Yicong Yang <yangyicong@hisilicon.com>

[ Upstream commit 6c50384ef8b94a527445e3694ae6549e1f15d859 ]

We're using pci_irq_vector() to obtain the interrupt number and then
bind it to the CPU start perf under the protection of spinlock in
pmu::start(). pci_irq_vector() might sleep since [1] because it will
call msi_domain_get_virq() to get the MSI interrupt number and it
needs to acquire dev->msi.data->mutex. Getting a mutex will sleep on
contention. So use pci_irq_vector() in an atomic context is problematic.

This patch cached the interrupt number in the probe() and uses the
cached data instead to avoid potential sleep.

[1] commit 82ff8e6b78fc ("PCI/MSI: Use msi_get_virq() in pci_get_vector()")

Fixes: ff0de066b463 ("hwtracing: hisi_ptt: Add trace function support for HiSilicon PCIe Tune and Trace device")
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Link: https://lore.kernel.org/r/20230621092804.15120-6-yangyicong@huawei.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwtracing/ptt/hisi_ptt.c | 12 +++++-------
 drivers/hwtracing/ptt/hisi_ptt.h |  2 ++
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/hwtracing/ptt/hisi_ptt.c b/drivers/hwtracing/ptt/hisi_ptt.c
index 30f1525639b57..4140efd664097 100644
--- a/drivers/hwtracing/ptt/hisi_ptt.c
+++ b/drivers/hwtracing/ptt/hisi_ptt.c
@@ -341,13 +341,13 @@ static int hisi_ptt_register_irq(struct hisi_ptt *hisi_ptt)
 	if (ret < 0)
 		return ret;
 
-	ret = devm_request_threaded_irq(&pdev->dev,
-					pci_irq_vector(pdev, HISI_PTT_TRACE_DMA_IRQ),
+	hisi_ptt->trace_irq = pci_irq_vector(pdev, HISI_PTT_TRACE_DMA_IRQ);
+	ret = devm_request_threaded_irq(&pdev->dev, hisi_ptt->trace_irq,
 					NULL, hisi_ptt_isr, 0,
 					DRV_NAME, hisi_ptt);
 	if (ret) {
 		pci_err(pdev, "failed to request irq %d, ret = %d\n",
-			pci_irq_vector(pdev, HISI_PTT_TRACE_DMA_IRQ), ret);
+			hisi_ptt->trace_irq, ret);
 		return ret;
 	}
 
@@ -757,8 +757,7 @@ static void hisi_ptt_pmu_start(struct perf_event *event, int flags)
 	 * core in event_function_local(). If CPU passed is offline we'll fail
 	 * here, just log it since we can do nothing here.
 	 */
-	ret = irq_set_affinity(pci_irq_vector(hisi_ptt->pdev, HISI_PTT_TRACE_DMA_IRQ),
-					      cpumask_of(cpu));
+	ret = irq_set_affinity(hisi_ptt->trace_irq, cpumask_of(cpu));
 	if (ret)
 		dev_warn(dev, "failed to set the affinity of trace interrupt\n");
 
@@ -1018,8 +1017,7 @@ static int hisi_ptt_cpu_teardown(unsigned int cpu, struct hlist_node *node)
 	 * Also make sure the interrupt bind to the migrated CPU as well. Warn
 	 * the user on failure here.
 	 */
-	if (irq_set_affinity(pci_irq_vector(hisi_ptt->pdev, HISI_PTT_TRACE_DMA_IRQ),
-					    cpumask_of(target)))
+	if (irq_set_affinity(hisi_ptt->trace_irq, cpumask_of(target)))
 		dev_warn(dev, "failed to set the affinity of trace interrupt\n");
 
 	hisi_ptt->trace_ctrl.on_cpu = target;
diff --git a/drivers/hwtracing/ptt/hisi_ptt.h b/drivers/hwtracing/ptt/hisi_ptt.h
index 5beb1648c93ab..948a4c4231527 100644
--- a/drivers/hwtracing/ptt/hisi_ptt.h
+++ b/drivers/hwtracing/ptt/hisi_ptt.h
@@ -166,6 +166,7 @@ struct hisi_ptt_pmu_buf {
  * @pdev:         pci_dev of this PTT device
  * @tune_lock:    lock to serialize the tune process
  * @pmu_lock:     lock to serialize the perf process
+ * @trace_irq:    interrupt number used by trace
  * @upper_bdf:    the upper BDF range of the PCI devices managed by this PTT device
  * @lower_bdf:    the lower BDF range of the PCI devices managed by this PTT device
  * @port_filters: the filter list of root ports
@@ -180,6 +181,7 @@ struct hisi_ptt {
 	struct pci_dev *pdev;
 	struct mutex tune_lock;
 	spinlock_t pmu_lock;
+	int trace_irq;
 	u32 upper_bdf;
 	u32 lower_bdf;
 
-- 
2.39.2



