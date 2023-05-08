Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDB096FA6AD
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234459AbjEHKXM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234453AbjEHKW2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:22:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B904D04B
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:21:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 16E3162561
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:21:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D3EEC433EF;
        Mon,  8 May 2023 10:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683541316;
        bh=Zhw3seNwclcY1xsjtNPI1K+SbmYITXkLX6uOEZnocbs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a1PyLf7I0Ibz+yB+UJN6eqQWNLDVd51BAmih6up7mGUPcU8DWJvMEuwt+Do5uSrVJ
         TO0zVevMEM3HW3GoXxXzB2RFl0NKAHTYFaYxz3VrTxXUX3dXYlkzhYjBhHgZGvv/eK
         YvdGcV1ZLUXLhHDB5wBcapDQ9B0R/AMUCCk/n9wQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Manivannan Sadhasivam <mani@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 6.2 076/663] cpufreq: qcom-cpufreq-hw: fix double IO unmap and resource release on exit
Date:   Mon,  8 May 2023 11:38:22 +0200
Message-Id: <20230508094430.924465040@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
References: <20230508094428.384831245@linuxfoundation.org>
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

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

commit ba5e770c9698782bc203bbf5cf3b36a77720bdbe upstream.

Commit 054a3ef683a1 ("cpufreq: qcom-hw: Allocate qcom_cpufreq_data
during probe") moved getting memory resource and iomap from
qcom_cpufreq_hw_cpu_init() to the probe function, however it left
untouched cleanup in qcom_cpufreq_hw_cpu_exit().

During device unbind this will lead to doule release of resource and
double iounmap(), first by qcom_cpufreq_hw_cpu_exit() and second via
managed resources:

  resource: Trying to free nonexistent resource <0x0000000018593000-0x0000000018593fff>
  Trying to vunmap() nonexistent vm area (0000000088a7d4dc)
  ...
  vunmap (mm/vmalloc.c:2771 (discriminator 1))
  iounmap (mm/ioremap.c:60)
  devm_ioremap_release (lib/devres.c:19)
  devres_release_all (drivers/base/devres.c:506 drivers/base/devres.c:535)
  device_unbind_cleanup (drivers/base/dd.c:523)
  device_release_driver_internal (drivers/base/dd.c:1248 drivers/base/dd.c:1263)
  device_driver_detach (drivers/base/dd.c:1300)
  unbind_store (drivers/base/bus.c:243)
  drv_attr_store (drivers/base/bus.c:127)
  sysfs_kf_write (fs/sysfs/file.c:137)
  kernfs_fop_write_iter (fs/kernfs/file.c:334)
  vfs_write (include/linux/fs.h:1851 fs/read_write.c:491 fs/read_write.c:584)
  ksys_write (fs/read_write.c:637)
  __arm64_sys_write (fs/read_write.c:646)
  invoke_syscall (arch/arm64/include/asm/current.h:19 arch/arm64/kernel/syscall.c:57)
  el0_svc_common.constprop.0 (arch/arm64/include/asm/daifflags.h:28 arch/arm64/kernel/syscall.c:150)
  do_el0_svc (arch/arm64/kernel/syscall.c:194)
  el0_svc (arch/arm64/include/asm/daifflags.h:28 arch/arm64/kernel/entry-common.c:133 arch/arm64/kernel/entry-common.c:142 arch/arm64/kernel/entry-common.c:638)
  el0t_64_sync_handler (arch/arm64/kernel/entry-common.c:656)
  el0t_64_sync (arch/arm64/kernel/entry.S:591)

Fixes: 054a3ef683a1 ("cpufreq: qcom-hw: Allocate qcom_cpufreq_data during probe")
Cc: <stable@vger.kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Reviewed-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/cpufreq/qcom-cpufreq-hw.c |   11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -43,7 +43,6 @@ struct qcom_cpufreq_soc_data {
 
 struct qcom_cpufreq_data {
 	void __iomem *base;
-	struct resource *res;
 
 	/*
 	 * Mutex to synchronize between de-init sequence and re-starting LMh
@@ -590,16 +589,12 @@ static int qcom_cpufreq_hw_cpu_exit(stru
 {
 	struct device *cpu_dev = get_cpu_device(policy->cpu);
 	struct qcom_cpufreq_data *data = policy->driver_data;
-	struct resource *res = data->res;
-	void __iomem *base = data->base;
 
 	dev_pm_opp_remove_all_dynamic(cpu_dev);
 	dev_pm_opp_of_cpumask_remove_table(policy->related_cpus);
 	qcom_cpufreq_hw_lmh_exit(data);
 	kfree(policy->freq_table);
 	kfree(data);
-	iounmap(base);
-	release_mem_region(res->start, resource_size(res));
 
 	return 0;
 }
@@ -718,17 +713,15 @@ static int qcom_cpufreq_hw_driver_probe(
 	for (i = 0; i < num_domains; i++) {
 		struct qcom_cpufreq_data *data = &qcom_cpufreq.data[i];
 		struct clk_init_data clk_init = {};
-		struct resource *res;
 		void __iomem *base;
 
-		base = devm_platform_get_and_ioremap_resource(pdev, i, &res);
+		base = devm_platform_ioremap_resource(pdev, i);
 		if (IS_ERR(base)) {
-			dev_err(dev, "Failed to map resource %pR\n", res);
+			dev_err(dev, "Failed to map resource index %d\n", i);
 			return PTR_ERR(base);
 		}
 
 		data->base = base;
-		data->res = res;
 
 		/* Register CPU clock for each frequency domain */
 		clk_init.name = kasprintf(GFP_KERNEL, "qcom_cpufreq%d", i);


