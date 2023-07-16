Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3397554BF
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjGPUd7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232301AbjGPUdt (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:33:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 363C89F
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:33:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D13560EBD
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:33:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 987B9C433C7;
        Sun, 16 Jul 2023 20:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689539625;
        bh=89SQEVf0lQM8880A6H8IGfJKnr6zGoUg/V5DVQri4fc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PnWJBszzdEU5Txk/iLm4by1e+oszjALRbZQYOi9dKZjVnY/3iRCgXc4HWJ5omPswn
         ohwgoXJm+0ynFE/4K//TNmippu+X11KS65Lcbxd8/P9W2IJ/skeF1kY0dfQCbK2jdN
         dwN3Zscl4spgM5Hp9ek4IlA+kYkzUahxxaoxfOos=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Junhao He <hejunhao3@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 046/591] drivers/perf: hisi: Dont migrate perf to the CPU going to teardown
Date:   Sun, 16 Jul 2023 21:43:05 +0200
Message-ID: <20230716194925.074393372@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Junhao He <hejunhao3@huawei.com>

[ Upstream commit 7a6a9f1c5a0a875a421db798d4b2ee022dc1ee1a ]

The driver needs to migrate the perf context if the current using CPU going
to teardown. By the time calling the cpuhp::teardown() callback the
cpu_online_mask() hasn't updated yet and still includes the CPU going to
teardown. In current driver's implementation we may migrate the context
to the teardown CPU and leads to the below calltrace:

...
[  368.104662][  T932] task:cpuhp/0         state:D stack:    0 pid:   15 ppid:     2 flags:0x00000008
[  368.113699][  T932] Call trace:
[  368.116834][  T932]  __switch_to+0x7c/0xbc
[  368.120924][  T932]  __schedule+0x338/0x6f0
[  368.125098][  T932]  schedule+0x50/0xe0
[  368.128926][  T932]  schedule_preempt_disabled+0x18/0x24
[  368.134229][  T932]  __mutex_lock.constprop.0+0x1d4/0x5dc
[  368.139617][  T932]  __mutex_lock_slowpath+0x1c/0x30
[  368.144573][  T932]  mutex_lock+0x50/0x60
[  368.148579][  T932]  perf_pmu_migrate_context+0x84/0x2b0
[  368.153884][  T932]  hisi_pcie_pmu_offline_cpu+0x90/0xe0 [hisi_pcie_pmu]
[  368.160579][  T932]  cpuhp_invoke_callback+0x2a0/0x650
[  368.165707][  T932]  cpuhp_thread_fun+0xe4/0x190
[  368.170316][  T932]  smpboot_thread_fn+0x15c/0x1a0
[  368.175099][  T932]  kthread+0x108/0x13c
[  368.179012][  T932]  ret_from_fork+0x10/0x18
...

Use function cpumask_any_but() to find one correct active cpu to fixes
this issue.

Fixes: 8404b0fbc7fb ("drivers/perf: hisi: Add driver for HiSilicon PCIe PMU")
Signed-off-by: Junhao He <hejunhao3@huawei.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Yicong Yang <yangyicong@hisilicon.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Link: https://lore.kernel.org/r/20230608114326.27649-1-hejunhao3@huawei.com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/perf/hisilicon/hisi_pcie_pmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/perf/hisilicon/hisi_pcie_pmu.c b/drivers/perf/hisilicon/hisi_pcie_pmu.c
index 071e63d9a9ac6..b61f1f9aba214 100644
--- a/drivers/perf/hisilicon/hisi_pcie_pmu.c
+++ b/drivers/perf/hisilicon/hisi_pcie_pmu.c
@@ -672,7 +672,7 @@ static int hisi_pcie_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
 
 	pcie_pmu->on_cpu = -1;
 	/* Choose a new CPU from all online cpus. */
-	target = cpumask_first(cpu_online_mask);
+	target = cpumask_any_but(cpu_online_mask, cpu);
 	if (target >= nr_cpu_ids) {
 		pci_err(pcie_pmu->pdev, "There is no CPU to set\n");
 		return 0;
-- 
2.39.2



