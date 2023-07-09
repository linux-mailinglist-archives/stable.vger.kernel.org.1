Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F148C74C387
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 13:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbjGILd0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 9 Jul 2023 07:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232965AbjGILdO (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 9 Jul 2023 07:33:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CAA81BB
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 04:33:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 69BFF60BA4
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 11:33:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CA30C433C8;
        Sun,  9 Jul 2023 11:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688902391;
        bh=P2CYQuiP8PZbc51ljOz5L8Hl3kOu+LBuI1VkhZCmLIM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WsagzEuzrpOI72sBKvzwLKlW8cTHj7oggUna3WhMoHIc75Lx5QVGvP7BMxjgvRWKl
         DsuAzUe5xv8ffmiWjDh9wO10wvcoyjxmPgTJKIG66FKyuZwj/mERkoBjK45b6gwzuA
         bPiI45ubNBBCLgqYbNtWu90iyhGm9tg1CbbUkAqU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Bart Van Assche <bvanassche@acm.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 359/431] scsi: ufs: core: Fix handling of lrbp->cmd
Date:   Sun,  9 Jul 2023 13:15:07 +0200
Message-ID: <20230709111459.582946177@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230709111451.101012554@linuxfoundation.org>
References: <20230709111451.101012554@linuxfoundation.org>
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

From: Bart Van Assche <bvanassche@acm.org>

[ Upstream commit 549e91a9bbaa0ee480f59357868421a61d369770 ]

ufshcd_queuecommand() may be called two times in a row for a SCSI command
before it is completed. Hence make the following changes:

 - In the functions that submit a command, do not check the old value of
   lrbp->cmd nor clear lrbp->cmd in error paths.

 - In ufshcd_release_scsi_cmd(), do not clear lrbp->cmd.

See also scsi_send_eh_cmnd().

This commit prevents that the following appears if a command times out:

WARNING: at drivers/ufs/core/ufshcd.c:2965 ufshcd_queuecommand+0x6f8/0x9a8
Call trace:
 ufshcd_queuecommand+0x6f8/0x9a8
 scsi_send_eh_cmnd+0x2c0/0x960
 scsi_eh_test_devices+0x100/0x314
 scsi_eh_ready_devs+0xd90/0x114c
 scsi_error_handler+0x2b4/0xb70
 kthread+0x16c/0x1e0

Fixes: 5a0b0cb9bee7 ("[SCSI] ufs: Add support for sending NOP OUT UPIU")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Link: https://lore.kernel.org/r/20230524203659.1394307-3-bvanassche@acm.org
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ufs/core/ufshcd.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 8bf39a83ecd7f..dc63bd60db77d 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -2917,7 +2917,6 @@ static int ufshcd_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *cmd)
 		(hba->clk_gating.state != CLKS_ON));
 
 	lrbp = &hba->lrb[tag];
-	WARN_ON(lrbp->cmd);
 	lrbp->cmd = cmd;
 	lrbp->task_tag = tag;
 	lrbp->lun = ufshcd_scsi_to_upiu_lun(cmd->device->lun);
@@ -2933,7 +2932,6 @@ static int ufshcd_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *cmd)
 
 	err = ufshcd_map_sg(hba, lrbp);
 	if (err) {
-		lrbp->cmd = NULL;
 		ufshcd_release(hba);
 		goto out;
 	}
@@ -3152,7 +3150,7 @@ static int ufshcd_exec_dev_cmd(struct ufs_hba *hba,
 	down_read(&hba->clk_scaling_lock);
 
 	lrbp = &hba->lrb[tag];
-	WARN_ON(lrbp->cmd);
+	lrbp->cmd = NULL;
 	err = ufshcd_compose_dev_cmd(hba, lrbp, cmd_type, tag);
 	if (unlikely(err))
 		goto out;
@@ -5391,7 +5389,6 @@ static void ufshcd_release_scsi_cmd(struct ufs_hba *hba,
 	struct scsi_cmnd *cmd = lrbp->cmd;
 
 	scsi_dma_unmap(cmd);
-	lrbp->cmd = NULL;	/* Mark the command as completed. */
 	ufshcd_release(hba);
 	ufshcd_clk_scaling_update_busy(hba);
 }
@@ -7006,7 +7003,6 @@ static int ufshcd_issue_devman_upiu_cmd(struct ufs_hba *hba,
 	down_read(&hba->clk_scaling_lock);
 
 	lrbp = &hba->lrb[tag];
-	WARN_ON(lrbp->cmd);
 	lrbp->cmd = NULL;
 	lrbp->task_tag = tag;
 	lrbp->lun = 0;
@@ -7178,7 +7174,6 @@ int ufshcd_advanced_rpmb_req_handler(struct ufs_hba *hba, struct utp_upiu_req *r
 	down_read(&hba->clk_scaling_lock);
 
 	lrbp = &hba->lrb[tag];
-	WARN_ON(lrbp->cmd);
 	lrbp->cmd = NULL;
 	lrbp->task_tag = tag;
 	lrbp->lun = UFS_UPIU_RPMB_WLUN;
-- 
2.39.2



