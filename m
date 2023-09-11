Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFE0B79BB74
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239838AbjIKVh7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239317AbjIKORh (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:17:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F3ADE
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:17:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D7EBC433C9;
        Mon, 11 Sep 2023 14:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694441851;
        bh=4l5843avEpi1/1KbUbU7MnL3t7zrI0ZENmnwQzHCgvA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QTgcc4ivDlsBlcgFnl2oppEPFrV+RG2rar5co8eeSp9piZtjq4XGK4vEAJrXoUCXM
         d1n2bfycUgGBtKm568dNhCh/5gwkSECFHRQarRNXXAwN1X8zG7j/rdgHjvOtbC/y4F
         np7xs/PtoBpoBMMAZASdiiej1fQtlt2Sp90W30Ok=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Junhao He <hejunhao3@huawei.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        James Clark <james.clark@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 559/739] coresight: trbe: Allocate platform data per device
Date:   Mon, 11 Sep 2023 15:45:58 +0200
Message-ID: <20230911134706.695135989@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Suzuki K Poulose <suzuki.poulose@arm.com>

[ Upstream commit 39744738a67de9153d73e11817937c0004feab2e ]

Coresight TRBE driver shares a single platform data (which is empty btw).
However, with the commit 4e8fe7e5c3a5
("coresight: Store pointers to connections rather than an array of them")
the coresight core would free up the pdata, resulting in multiple attempts
to free the same pdata for TRBE instances. Fix this by allocating a pdata per
coresight_device.

Fixes: 4e8fe7e5c3a5 ("coresight: Store pointers to connections rather than an array of them")
Link: https://lore.kernel.org/r/20230814093813.19152-3-hejunhao3@huawei.com
Reported-by: Junhao He <hejunhao3@huawei.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: James Clark <james.clark@arm.com>
Tested-by: Junhao He <hejunhao3@huawei.com>
Link: https://lore.kernel.org/r/20230816141008.535450-2-suzuki.poulose@arm.com
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwtracing/coresight/coresight-trbe.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
index 7720619909d65..8e4eb37e66e82 100644
--- a/drivers/hwtracing/coresight/coresight-trbe.c
+++ b/drivers/hwtracing/coresight/coresight-trbe.c
@@ -1244,10 +1244,13 @@ static void arm_trbe_register_coresight_cpu(struct trbe_drvdata *drvdata, int cp
 	if (!desc.name)
 		goto cpu_clear;
 
+	desc.pdata = coresight_get_platform_data(dev);
+	if (IS_ERR(desc.pdata))
+		goto cpu_clear;
+
 	desc.type = CORESIGHT_DEV_TYPE_SINK;
 	desc.subtype.sink_subtype = CORESIGHT_DEV_SUBTYPE_SINK_PERCPU_SYSMEM;
 	desc.ops = &arm_trbe_cs_ops;
-	desc.pdata = dev_get_platdata(dev);
 	desc.groups = arm_trbe_groups;
 	desc.dev = dev;
 	trbe_csdev = coresight_register(&desc);
@@ -1479,7 +1482,6 @@ static void arm_trbe_remove_irq(struct trbe_drvdata *drvdata)
 
 static int arm_trbe_device_probe(struct platform_device *pdev)
 {
-	struct coresight_platform_data *pdata;
 	struct trbe_drvdata *drvdata;
 	struct device *dev = &pdev->dev;
 	int ret;
@@ -1494,12 +1496,7 @@ static int arm_trbe_device_probe(struct platform_device *pdev)
 	if (!drvdata)
 		return -ENOMEM;
 
-	pdata = coresight_get_platform_data(dev);
-	if (IS_ERR(pdata))
-		return PTR_ERR(pdata);
-
 	dev_set_drvdata(dev, drvdata);
-	dev->platform_data = pdata;
 	drvdata->pdev = pdev;
 	ret = arm_trbe_probe_irq(pdev, drvdata);
 	if (ret)
-- 
2.40.1



