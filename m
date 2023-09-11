Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9F9A79BAE4
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235381AbjIKUut (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 16:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242149AbjIKPXf (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:23:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7CFBDB
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:23:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DA10C433C7;
        Mon, 11 Sep 2023 15:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694445810;
        bh=R2MB9A2/bukCMFq/BJHCejmdBRFvtpTqDdMrxg047+Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=az3EiA/rSJlTjCBQl3bw6WZcED5dKo+961PTMvsnlctB5Ptjt31r718ss3qQaES/w
         BZne4/xO18g54CPlLkFQVBz4RlicUiSbjjcEPTQgympMTnaM1v4lMiIVZIexezaSNI
         RPYycakLV+DwtJ/EyLTkL/ObdIYm00wJmJxCS7MA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Junhao He <hejunhao3@huawei.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 479/600] coresight: trbe: Fix TRBE potential sleep in atomic context
Date:   Mon, 11 Sep 2023 15:48:32 +0200
Message-ID: <20230911134647.781069920@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134633.619970489@linuxfoundation.org>
References: <20230911134633.619970489@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Junhao He <hejunhao3@huawei.com>

[ Upstream commit c0a232f1e19e378c5c4e5973a996392942c80090 ]

smp_call_function_single() will allocate an IPI interrupt vector to
the target processor and send a function call request to the interrupt
vector. After the target processor receives the IPI interrupt, it will
execute arm_trbe_remove_coresight_cpu() call request in the interrupt
handler.

According to the device_unregister() stack information, if other process
is useing the device, the down_write() may sleep, and trigger deadlocks
or unexpected errors.

  arm_trbe_remove_coresight_cpu
    coresight_unregister
      device_unregister
        device_del
          kobject_del
            __kobject_del
              sysfs_remove_dir
                kernfs_remove
                  down_write ---------> it may sleep

Add a helper arm_trbe_disable_cpu() to disable TRBE precpu irq and reset
per TRBE.
Simply call arm_trbe_remove_coresight_cpu() directly without useing the
smp_call_function_single(), which is the same as registering the TRBE
coresight device.

Fixes: 3fbf7f011f24 ("coresight: sink: Add TRBE driver")
Signed-off-by: Junhao He <hejunhao3@huawei.com>
Link: https://lore.kernel.org/r/20230814093813.19152-2-hejunhao3@huawei.com
[ Remove duplicate cpumask checks during removal ]
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
[ v3 - Remove the operation of assigning NULL to cpudata->drvdata ]
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Link: https://lore.kernel.org/r/20230818084052.10116-1-hejunhao3@huawei.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwtracing/coresight/coresight-trbe.c | 32 +++++++++++---------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
index 1fc4fd79a1c69..925f6c9cecff4 100644
--- a/drivers/hwtracing/coresight/coresight-trbe.c
+++ b/drivers/hwtracing/coresight/coresight-trbe.c
@@ -1223,6 +1223,16 @@ static void arm_trbe_enable_cpu(void *info)
 	enable_percpu_irq(drvdata->irq, IRQ_TYPE_NONE);
 }
 
+static void arm_trbe_disable_cpu(void *info)
+{
+	struct trbe_drvdata *drvdata = info;
+	struct trbe_cpudata *cpudata = this_cpu_ptr(drvdata->cpudata);
+
+	disable_percpu_irq(drvdata->irq);
+	trbe_reset_local(cpudata);
+}
+
+
 static void arm_trbe_register_coresight_cpu(struct trbe_drvdata *drvdata, int cpu)
 {
 	struct trbe_cpudata *cpudata = per_cpu_ptr(drvdata->cpudata, cpu);
@@ -1324,18 +1334,12 @@ static void arm_trbe_probe_cpu(void *info)
 	cpumask_clear_cpu(cpu, &drvdata->supported_cpus);
 }
 
-static void arm_trbe_remove_coresight_cpu(void *info)
+static void arm_trbe_remove_coresight_cpu(struct trbe_drvdata *drvdata, int cpu)
 {
-	int cpu = smp_processor_id();
-	struct trbe_drvdata *drvdata = info;
-	struct trbe_cpudata *cpudata = per_cpu_ptr(drvdata->cpudata, cpu);
 	struct coresight_device *trbe_csdev = coresight_get_percpu_sink(cpu);
 
-	disable_percpu_irq(drvdata->irq);
-	trbe_reset_local(cpudata);
 	if (trbe_csdev) {
 		coresight_unregister(trbe_csdev);
-		cpudata->drvdata = NULL;
 		coresight_set_percpu_sink(cpu, NULL);
 	}
 }
@@ -1364,8 +1368,10 @@ static int arm_trbe_remove_coresight(struct trbe_drvdata *drvdata)
 {
 	int cpu;
 
-	for_each_cpu(cpu, &drvdata->supported_cpus)
-		smp_call_function_single(cpu, arm_trbe_remove_coresight_cpu, drvdata, 1);
+	for_each_cpu(cpu, &drvdata->supported_cpus) {
+		smp_call_function_single(cpu, arm_trbe_disable_cpu, drvdata, 1);
+		arm_trbe_remove_coresight_cpu(drvdata, cpu);
+	}
 	free_percpu(drvdata->cpudata);
 	return 0;
 }
@@ -1404,12 +1410,8 @@ static int arm_trbe_cpu_teardown(unsigned int cpu, struct hlist_node *node)
 {
 	struct trbe_drvdata *drvdata = hlist_entry_safe(node, struct trbe_drvdata, hotplug_node);
 
-	if (cpumask_test_cpu(cpu, &drvdata->supported_cpus)) {
-		struct trbe_cpudata *cpudata = per_cpu_ptr(drvdata->cpudata, cpu);
-
-		disable_percpu_irq(drvdata->irq);
-		trbe_reset_local(cpudata);
-	}
+	if (cpumask_test_cpu(cpu, &drvdata->supported_cpus))
+		arm_trbe_disable_cpu(drvdata);
 	return 0;
 }
 
-- 
2.40.1



