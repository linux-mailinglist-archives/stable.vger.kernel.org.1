Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7DE7A3ACD
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240466AbjIQUJH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240471AbjIQUIm (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:08:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A6EB5
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:08:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 447F1C433C7;
        Sun, 17 Sep 2023 20:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694981316;
        bh=ZGfomXv+I6HMMcqXyBdtHWTH/YLxBnLwfi/0gm8NtLk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YYpWQn5QhDFLzgLLQ/aEd0gRiFEIe0HAXCgNPa4uy+Y38O0Pt8U9O0dNXzaeLKarC
         GsXeZQnVYY9XusMKmUOYOqug8GwmqeWNmFk9VL73dJxVccVno9pQ20KxMB67pAwxrN
         4azNFKg3jIbZ9l4ch8ExH0joqtmhMkYuFWlKto6A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Justin Tee <justin.tee@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 037/511] scsi: lpfc: Remove reftag check in DIF paths
Date:   Sun, 17 Sep 2023 21:07:44 +0200
Message-ID: <20230917191114.748926370@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191113.831992765@linuxfoundation.org>
References: <20230917191113.831992765@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Justin Tee <justin.tee@broadcom.com>

[ Upstream commit 8eebf0e84f0614cebc7347f7bbccba4056d77d42 ]

When preparing protection DIF I/O for DMA, the driver obtains reference
tags from scsi_prot_ref_tag().  Previously, there was a wrong assumption
that an all 0xffffffff value meant error and thus the driver failed the
I/O.  This patch removes the evaluation code and accepts whatever the upper
layer returns.

Signed-off-by: Justin Tee <justin.tee@broadcom.com>
Link: https://lore.kernel.org/r/20230803211932.155745-1-justintee8345@gmail.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/lpfc/lpfc_scsi.c | 20 +++-----------------
 1 file changed, 3 insertions(+), 17 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_scsi.c b/drivers/scsi/lpfc/lpfc_scsi.c
index edae98a35fc3b..4813adec0301d 100644
--- a/drivers/scsi/lpfc/lpfc_scsi.c
+++ b/drivers/scsi/lpfc/lpfc_scsi.c
@@ -117,8 +117,6 @@ lpfc_sli4_set_rsp_sgl_last(struct lpfc_hba *phba,
 	}
 }
 
-#define LPFC_INVALID_REFTAG ((u32)-1)
-
 /**
  * lpfc_update_stats - Update statistical data for the command completion
  * @vport: The virtual port on which this call is executing.
@@ -1042,8 +1040,6 @@ lpfc_bg_err_inject(struct lpfc_hba *phba, struct scsi_cmnd *sc,
 
 	sgpe = scsi_prot_sglist(sc);
 	lba = scsi_prot_ref_tag(sc);
-	if (lba == LPFC_INVALID_REFTAG)
-		return 0;
 
 	/* First check if we need to match the LBA */
 	if (phba->lpfc_injerr_lba != LPFC_INJERR_LBA_OFF) {
@@ -1624,8 +1620,6 @@ lpfc_bg_setup_bpl(struct lpfc_hba *phba, struct scsi_cmnd *sc,
 
 	/* extract some info from the scsi command for pde*/
 	reftag = scsi_prot_ref_tag(sc);
-	if (reftag == LPFC_INVALID_REFTAG)
-		goto out;
 
 #ifdef CONFIG_SCSI_LPFC_DEBUG_FS
 	rc = lpfc_bg_err_inject(phba, sc, &reftag, NULL, 1);
@@ -1787,8 +1781,6 @@ lpfc_bg_setup_bpl_prot(struct lpfc_hba *phba, struct scsi_cmnd *sc,
 	/* extract some info from the scsi command */
 	blksize = scsi_prot_interval(sc);
 	reftag = scsi_prot_ref_tag(sc);
-	if (reftag == LPFC_INVALID_REFTAG)
-		goto out;
 
 #ifdef CONFIG_SCSI_LPFC_DEBUG_FS
 	rc = lpfc_bg_err_inject(phba, sc, &reftag, NULL, 1);
@@ -2018,8 +2010,6 @@ lpfc_bg_setup_sgl(struct lpfc_hba *phba, struct scsi_cmnd *sc,
 
 	/* extract some info from the scsi command for pde*/
 	reftag = scsi_prot_ref_tag(sc);
-	if (reftag == LPFC_INVALID_REFTAG)
-		goto out;
 
 #ifdef CONFIG_SCSI_LPFC_DEBUG_FS
 	rc = lpfc_bg_err_inject(phba, sc, &reftag, NULL, 1);
@@ -2219,8 +2209,6 @@ lpfc_bg_setup_sgl_prot(struct lpfc_hba *phba, struct scsi_cmnd *sc,
 	/* extract some info from the scsi command */
 	blksize = scsi_prot_interval(sc);
 	reftag = scsi_prot_ref_tag(sc);
-	if (reftag == LPFC_INVALID_REFTAG)
-		goto out;
 
 #ifdef CONFIG_SCSI_LPFC_DEBUG_FS
 	rc = lpfc_bg_err_inject(phba, sc, &reftag, NULL, 1);
@@ -2812,8 +2800,6 @@ lpfc_calc_bg_err(struct lpfc_hba *phba, struct lpfc_io_buf *lpfc_cmd)
 
 		src = (struct scsi_dif_tuple *)sg_virt(sgpe);
 		start_ref_tag = scsi_prot_ref_tag(cmd);
-		if (start_ref_tag == LPFC_INVALID_REFTAG)
-			goto out;
 		start_app_tag = src->app_tag;
 		len = sgpe->length;
 		while (src && protsegcnt) {
@@ -3660,11 +3646,11 @@ lpfc_bg_scsi_prep_dma_buf_s4(struct lpfc_hba *phba,
 			     scsi_cmnd->sc_data_direction);
 
 	lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
-			"9084 Cannot setup S/G List for HBA"
-			"IO segs %d/%d SGL %d SCSI %d: %d %d\n",
+			"9084 Cannot setup S/G List for HBA "
+			"IO segs %d/%d SGL %d SCSI %d: %d %d %d\n",
 			lpfc_cmd->seg_cnt, lpfc_cmd->prot_seg_cnt,
 			phba->cfg_total_seg_cnt, phba->cfg_sg_seg_cnt,
-			prot_group_type, num_sge);
+			prot_group_type, num_sge, ret);
 
 	lpfc_cmd->seg_cnt = 0;
 	lpfc_cmd->prot_seg_cnt = 0;
-- 
2.40.1



