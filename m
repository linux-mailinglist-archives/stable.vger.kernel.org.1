Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59E0E6FA517
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234031AbjEHKFv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234032AbjEHKFu (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:05:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 651513017B
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:05:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C539462341
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:05:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6875C433D2;
        Mon,  8 May 2023 10:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683540348;
        bh=Q4hK5ySrl0IdJQJGzuJjLmbGEyNHig5J6jA3LEntiys=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KYdfur3Id1Y4GZI6GNgpIfBZkZOfnci2hcC7qByHnq09ZQ90bGuFeZRwlJn3O3cjw
         6v4u+G9uOxYezio7VAybA4F6lahp5oEzjWX1MqTccn/yf1AjHvwoZlyBcfPynSWd28
         5KMr0kmD2D8FhdNP0tRRR/mQDbEozZ1ggmXaGr1s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Xingui Yang <yangxingui@huawei.com>,
        Xiang Chen <chenxiang66@hisilicon.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 313/611] scsi: hisi_sas: Handle NCQ error when IPTT is valid
Date:   Mon,  8 May 2023 11:42:35 +0200
Message-Id: <20230508094432.606526880@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
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

From: Xingui Yang <yangxingui@huawei.com>

[ Upstream commit bb544224da77b96b2c11a13872bf91ede1e015be ]

If an NCQ error occurs when the IPTT is valid and slot->abort flag is set
in completion path, sas_task_abort() will be called to abort only one NCQ
command now, and the host would be set to SHOST_RECOVERY state. But this
may not kick-off EH Immediately until other outstanding QCs timeouts. As a
result, the host may remain in the SHOST_RECOVERY state for up to 30
seconds, such as follows:

[7972317.645234] hisi_sas_v3_hw 0000:74:04.0: erroneous completion iptt=3264 task=00000000466116b8 dev id=2 sas_addr=0x5000000000000502 CQ hdr: 0x1883 0x20cc0 0x40000 0x20420000 Error info: 0x0 0x0 0x200000 0x0
[7972341.508264] sas: Enter sas_scsi_recover_host busy: 32 failed: 32
[7972341.984731] sas: --- Exit sas_scsi_recover_host: busy: 0 failed: 32 tries: 1

All NCQ commands that are in the queue should be aborted when an NCQ error
occurs in this scenario.

Fixes: 05d91b557af9 ("scsi: hisi_sas: Directly trigger SCSI error handling for completion errors")
Signed-off-by: Xingui Yang <yangxingui@huawei.com>
Signed-off-by: Xiang Chen <chenxiang66@hisilicon.com>
Link: https://lore.kernel.org/r/1679283265-115066-3-git-send-email-chenxiang66@hisilicon.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/hisi_sas/hisi_sas_v1_hw.c | 6 +++++-
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c | 6 +++++-
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 6 +++++-
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
index d643c5a49aa94..70c24377c6a19 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
@@ -1258,7 +1258,11 @@ static void slot_complete_v1_hw(struct hisi_hba *hisi_hba,
 
 		slot_err_v1_hw(hisi_hba, task, slot);
 		if (unlikely(slot->abort)) {
-			sas_task_abort(task);
+			if (dev_is_sata(device) && task->ata_task.use_ncq)
+				sas_ata_device_link_abort(device, true);
+			else
+				sas_task_abort(task);
+
 			return;
 		}
 		goto out;
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
index cded42f4ca445..02575d81afca2 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
@@ -2404,7 +2404,11 @@ static void slot_complete_v2_hw(struct hisi_hba *hisi_hba,
 				 error_info[2], error_info[3]);
 
 		if (unlikely(slot->abort)) {
-			sas_task_abort(task);
+			if (dev_is_sata(device) && task->ata_task.use_ncq)
+				sas_ata_device_link_abort(device, true);
+			else
+				sas_task_abort(task);
+
 			return;
 		}
 		goto out;
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index 620dcefe7b6f4..e8a3511040af2 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -2293,7 +2293,11 @@ static void slot_complete_v3_hw(struct hisi_hba *hisi_hba,
 					error_info[0], error_info[1],
 					error_info[2], error_info[3]);
 			if (unlikely(slot->abort)) {
-				sas_task_abort(task);
+				if (dev_is_sata(device) && task->ata_task.use_ncq)
+					sas_ata_device_link_abort(device, true);
+				else
+					sas_task_abort(task);
+
 				return;
 			}
 			goto out;
-- 
2.39.2



