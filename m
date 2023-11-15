Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB1DB7ECC26
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:27:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233790AbjKOT1O (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:27:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233887AbjKOT1C (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:27:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA86D5B
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:26:59 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A83D5C433C9;
        Wed, 15 Nov 2023 19:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076418;
        bh=l/WCFJ5QS6RS43NZgv3xtuFzRewO3QETHUhmrB5E71w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lpzVxLj5D/vCHOLJJnce8+fqinc3eiU61b0qwHqp0taTgXUY6plUKFD4O2wSa8wbK
         kHw14N55zcQjGAZHI9+Me3SQByqketaZCju2Xu8zPS/uPlsKqmkC2pN/D5j6eZoVpB
         5dNxyNbZWKvn0uW2pC6vVXH4dmfBs4h8ccPNiwEY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hao Chen <chenhao418@huawei.com>,
        Jijie Shao <shaojijie@huawei.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        Will Deacon <will@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 255/550] drivers/perf: hisi: use cpuhp_state_remove_instance_nocalls() for hisi_hns3_pmu uninit process
Date:   Wed, 15 Nov 2023 14:13:59 -0500
Message-ID: <20231115191618.369393848@linuxfoundation.org>
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

From: Hao Chen <chenhao418@huawei.com>

[ Upstream commit 50b560783f7f71790bcf70e9e9855155fb0af8c1 ]

When tearing down a 'hisi_hns3' PMU, we mistakenly run the CPU hotplug
callbacks after the device has been unregistered, leading to fireworks
when we try to execute empty function callbacks within the driver:

  | Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
  | CPU: 0 PID: 15 Comm: cpuhp/0 Tainted: G        W  O      5.12.0-rc4+ #1
  | Hardware name:  , BIOS KpxxxFPGA 1P B600 V143 04/22/2021
  | pstate: 80400009 (Nzcv daif +PAN -UAO -TCO BTYPE=--)
  | pc : perf_pmu_migrate_context+0x98/0x38c
  | lr : perf_pmu_migrate_context+0x94/0x38c
  |
  | Call trace:
  |  perf_pmu_migrate_context+0x98/0x38c
  |  hisi_hns3_pmu_offline_cpu+0x104/0x12c [hisi_hns3_pmu]

Use cpuhp_state_remove_instance_nocalls() instead of
cpuhp_state_remove_instance() so that the notifiers don't execute after
the PMU device has been unregistered.

Fixes: 66637ab137b4 ("drivers/perf: hisi: add driver for HNS3 PMU")
Signed-off-by: Hao Chen <chenhao418@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
Reviewed-by: Yicong Yang <yangyicong@hisilicon.com>
Link: https://lore.kernel.org/r/20231019091352.998964-1-shaojijie@huawei.com
[will: Rewrote commit message]
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/perf/hisilicon/hns3_pmu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/perf/hisilicon/hns3_pmu.c b/drivers/perf/hisilicon/hns3_pmu.c
index e0457d84af6b3..16869bf5bf4cc 100644
--- a/drivers/perf/hisilicon/hns3_pmu.c
+++ b/drivers/perf/hisilicon/hns3_pmu.c
@@ -1556,8 +1556,8 @@ static int hns3_pmu_init_pmu(struct pci_dev *pdev, struct hns3_pmu *hns3_pmu)
 	ret = perf_pmu_register(&hns3_pmu->pmu, hns3_pmu->pmu.name, -1);
 	if (ret) {
 		pci_err(pdev, "failed to register perf PMU, ret = %d.\n", ret);
-		cpuhp_state_remove_instance(CPUHP_AP_PERF_ARM_HNS3_PMU_ONLINE,
-					    &hns3_pmu->node);
+		cpuhp_state_remove_instance_nocalls(CPUHP_AP_PERF_ARM_HNS3_PMU_ONLINE,
+						    &hns3_pmu->node);
 	}
 
 	return ret;
@@ -1568,8 +1568,8 @@ static void hns3_pmu_uninit_pmu(struct pci_dev *pdev)
 	struct hns3_pmu *hns3_pmu = pci_get_drvdata(pdev);
 
 	perf_pmu_unregister(&hns3_pmu->pmu);
-	cpuhp_state_remove_instance(CPUHP_AP_PERF_ARM_HNS3_PMU_ONLINE,
-				    &hns3_pmu->node);
+	cpuhp_state_remove_instance_nocalls(CPUHP_AP_PERF_ARM_HNS3_PMU_ONLINE,
+					    &hns3_pmu->node);
 }
 
 static int hns3_pmu_init_dev(struct pci_dev *pdev)
-- 
2.42.0



