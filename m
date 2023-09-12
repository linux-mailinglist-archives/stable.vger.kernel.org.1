Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBAA879B689
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbjIKWtr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241988AbjIKPT7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:19:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F3C5FA
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:19:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0223FC433C8;
        Mon, 11 Sep 2023 15:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694445592;
        bh=QdJQL/9DPFT/h3TPHn2ZE3IiDh/BU23BNvrrpnjomYM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=alr128qZZmpQRZ24hAE9PvFi+X5VaWLKXfJROpoOpB3zzCJ7VifOPFjmAGlzHqgjt
         dh26m35GbQfaT9p4fBm9YQYXEiaEGMNo5SrNZElQgXFSG9k1TTXpRA7dDV5Si+o3EN
         aj9lH98aXtlZSWHRAjMnX1KXmCeoGHtMj4zQfhk8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Xingui Yang <yangxingui@huawei.com>,
        Xiang Chen <chenxiang66@hisilicon.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 403/600] scsi: hisi_sas: Fix normally completed I/O analysed as failed
Date:   Mon, 11 Sep 2023 15:47:16 +0200
Message-ID: <20230911134645.572179375@linuxfoundation.org>
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

From: Xingui Yang <yangxingui@huawei.com>

[ Upstream commit f5393a5602cacfda2014e0ff8220e5a7564e7cd1 ]

The PIO read command has no response frame and the struct iu[1024] won't be
filled. I/Os which are normally completed will be treated as failed in
sas_ata_task_done() when iu contains abnormal dirty data.

Consequently ending_fis should not be filled by iu when the response frame
hasn't been written to memory.

Fixes: d380f55503ed ("scsi: hisi_sas: Don't bother clearing status buffer IU in task prep")
Signed-off-by: Xingui Yang <yangxingui@huawei.com>
Signed-off-by: Xiang Chen <chenxiang66@hisilicon.com>
Link: https://lore.kernel.org/r/1689045300-44318-2-git-send-email-chenxiang66@hisilicon.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c | 11 +++++++++--
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c |  6 ++++--
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
index 02575d81afca2..50697672146ad 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
@@ -2026,6 +2026,11 @@ static void slot_err_v2_hw(struct hisi_hba *hisi_hba,
 	u16 dma_tx_err_type = le16_to_cpu(err_record->dma_tx_err_type);
 	u16 sipc_rx_err_type = le16_to_cpu(err_record->sipc_rx_err_type);
 	u32 dma_rx_err_type = le32_to_cpu(err_record->dma_rx_err_type);
+	struct hisi_sas_complete_v2_hdr *complete_queue =
+			hisi_hba->complete_hdr[slot->cmplt_queue];
+	struct hisi_sas_complete_v2_hdr *complete_hdr =
+			&complete_queue[slot->cmplt_queue_slot];
+	u32 dw0 = le32_to_cpu(complete_hdr->dw0);
 	int error = -1;
 
 	if (err_phase == 1) {
@@ -2310,7 +2315,8 @@ static void slot_err_v2_hw(struct hisi_hba *hisi_hba,
 			break;
 		}
 		}
-		hisi_sas_sata_done(task, slot);
+		if (dw0 & CMPLT_HDR_RSPNS_XFRD_MSK)
+			hisi_sas_sata_done(task, slot);
 	}
 		break;
 	default:
@@ -2443,7 +2449,8 @@ static void slot_complete_v2_hw(struct hisi_hba *hisi_hba,
 	case SAS_PROTOCOL_SATA | SAS_PROTOCOL_STP:
 	{
 		ts->stat = SAS_SAM_STAT_GOOD;
-		hisi_sas_sata_done(task, slot);
+		if (dw0 & CMPLT_HDR_RSPNS_XFRD_MSK)
+			hisi_sas_sata_done(task, slot);
 		break;
 	}
 	default:
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index 8544c1554f5ff..c0e74d768716d 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -2203,7 +2203,8 @@ slot_err_v3_hw(struct hisi_hba *hisi_hba, struct sas_task *task,
 			ts->stat = SAS_OPEN_REJECT;
 			ts->open_rej_reason = SAS_OREJ_RSVD_RETRY;
 		}
-		hisi_sas_sata_done(task, slot);
+		if (dw0 & CMPLT_HDR_RSPNS_XFRD_MSK)
+			hisi_sas_sata_done(task, slot);
 		break;
 	case SAS_PROTOCOL_SMP:
 		ts->stat = SAS_SAM_STAT_CHECK_CONDITION;
@@ -2330,7 +2331,8 @@ static void slot_complete_v3_hw(struct hisi_hba *hisi_hba,
 	case SAS_PROTOCOL_STP:
 	case SAS_PROTOCOL_SATA | SAS_PROTOCOL_STP:
 		ts->stat = SAS_SAM_STAT_GOOD;
-		hisi_sas_sata_done(task, slot);
+		if (dw0 & CMPLT_HDR_RSPNS_XFRD_MSK)
+			hisi_sas_sata_done(task, slot);
 		break;
 	default:
 		ts->stat = SAS_SAM_STAT_CHECK_CONDITION;
-- 
2.40.1



