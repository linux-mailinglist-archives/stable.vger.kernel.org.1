Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8C175531D
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbjGPUPb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231610AbjGPUPb (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:15:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A9690
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:15:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D792B60E65
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:15:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6AF9C433C7;
        Sun, 16 Jul 2023 20:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689538529;
        bh=Ijck6D/iOChlxu9ogpKp+lkp6gVdHoeJfaGoVG9kfQ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d1HDEM+5wY+8zebc93FwmtTrz4K9j9tNU5uDmSkEih5zDUhHV7VgbYO0Q3FYGjNQX
         h80pPcIMm06sk29bv4fBXh3birimaoRHdbwrxzRt1Qur+NVlEscWjViYOVsf5eRzus
         THeZkFuvPaGqiOSXRrqdspnNai26hNWkxJ9DQHf4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Can Guo <quic_cang@quicinc.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Po-Wen Kao <powen.kao@mediatek.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 483/800] scsi: ufs: core: mcq: Fix the incorrect OCS value for the device command
Date:   Sun, 16 Jul 2023 21:45:36 +0200
Message-ID: <20230716195000.298077041@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
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

From: Stanley Chu <stanley.chu@mediatek.com>

[ Upstream commit 0fef6bb730c490fcdc4347dbd21646d3ffe62cf5 ]

In MCQ mode, when a device command uses a hardware queue shared with other
commands, a race condition may occur in the following scenario:

 1. A device command is completed in CQx with CQE entry "e".

 2. The interrupt handler copies the "cqe" pointer to "hba->dev_cmd.cqe"
    and completes "hba->dev_cmd.complete".

 3. The "ufshcd_wait_for_dev_cmd()" function is awakened and retrieves the
    OCS value from "hba->dev_cmd.cqe".

However, there is a possibility that the CQE entry "e" will be overwritten
by newly completed commands in CQx, resulting in an incorrect OCS value
being received by "ufshcd_wait_for_dev_cmd()".

To avoid this race condition, the OCS value should be immediately copied to
the struct "lrb" of the device command. Then "ufshcd_wait_for_dev_cmd()"
can retrieve the OCS value from the struct "lrb".

Fixes: 57b1c0ef89ac ("scsi: ufs: core: mcq: Add support to allocate multiple queues")
Suggested-by: Can Guo <quic_cang@quicinc.com>
Signed-off-by: Stanley Chu <stanley.chu@mediatek.com>
Link: https://lore.kernel.org/r/20230610021553.1213-2-powen.kao@mediatek.com
Tested-by: Po-Wen Kao <powen.kao@mediatek.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ufs/core/ufshcd.c | 10 +++++++---
 include/ufs/ufshcd.h      |  1 -
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 41f383b588865..6d8ef80d9cbc4 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -3097,7 +3097,7 @@ static int ufshcd_wait_for_dev_cmd(struct ufs_hba *hba,
 		 * not trigger any race conditions.
 		 */
 		hba->dev_cmd.complete = NULL;
-		err = ufshcd_get_tr_ocs(lrbp, hba->dev_cmd.cqe);
+		err = ufshcd_get_tr_ocs(lrbp, NULL);
 		if (!err)
 			err = ufshcd_dev_cmd_completion(hba, lrbp);
 	} else {
@@ -3184,7 +3184,6 @@ static int ufshcd_exec_dev_cmd(struct ufs_hba *hba,
 		goto out;
 
 	hba->dev_cmd.complete = &wait;
-	hba->dev_cmd.cqe = NULL;
 
 	ufshcd_add_query_upiu_trace(hba, UFS_QUERY_SEND, lrbp->ucd_req_ptr);
 
@@ -5435,6 +5434,7 @@ void ufshcd_compl_one_cqe(struct ufs_hba *hba, int task_tag,
 {
 	struct ufshcd_lrb *lrbp;
 	struct scsi_cmnd *cmd;
+	enum utp_ocs ocs;
 
 	lrbp = &hba->lrb[task_tag];
 	lrbp->compl_time_stamp = ktime_get();
@@ -5450,7 +5450,11 @@ void ufshcd_compl_one_cqe(struct ufs_hba *hba, int task_tag,
 	} else if (lrbp->command_type == UTP_CMD_TYPE_DEV_MANAGE ||
 		   lrbp->command_type == UTP_CMD_TYPE_UFS_STORAGE) {
 		if (hba->dev_cmd.complete) {
-			hba->dev_cmd.cqe = cqe;
+			if (cqe) {
+				ocs = le32_to_cpu(cqe->status) & MASK_OCS;
+				lrbp->utr_descriptor_ptr->header.dword_2 =
+					cpu_to_le32(ocs);
+			}
 			complete(hba->dev_cmd.complete);
 			ufshcd_clk_scaling_update_busy(hba);
 		}
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index df1d04f7a5424..8eecbb3766158 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -225,7 +225,6 @@ struct ufs_dev_cmd {
 	struct mutex lock;
 	struct completion *complete;
 	struct ufs_query query;
-	struct cq_entry *cqe;
 };
 
 /**
-- 
2.39.2



