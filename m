Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 519C579B11C
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354154AbjIKVwi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239847AbjIKOaV (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:30:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D240F0
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:30:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77842C433C8;
        Mon, 11 Sep 2023 14:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694442616;
        bh=EAmQCgK+ImT6DYnBkBxhi/aCpQ2w49No2g0uW2Tvp3Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nSyg6KeaTyoTlnHo6eyBE+CDPxloABrvjWzP+iotKgishW8A/tvAN6HBpnWCm5RK9
         AVSVuK2QGWKoKNIACYeZD3HTYGmJqxeHfrfULXZgCjbmETOCH1Axa9bthhi4sISZ31
         w4Jps7zOiHC7mkbHzrpJmihgjab37/CZYMYpHO80=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Justin Tee <justin.tee@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 060/737] scsi: lpfc: Remove reftag check in DIF paths
Date:   Mon, 11 Sep 2023 15:38:39 +0200
Message-ID: <20230911134652.174444890@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
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

6.4-stable review patch.  If anyone has any objections, please let me know.

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
index e989f130434e4..e34a41fb3e1cb 100644
--- a/drivers/scsi/lpfc/lpfc_scsi.c
+++ b/drivers/scsi/lpfc/lpfc_scsi.c
@@ -109,8 +109,6 @@ lpfc_sli4_set_rsp_sgl_last(struct lpfc_hba *phba,
 	}
 }
 
-#define LPFC_INVALID_REFTAG ((u32)-1)
-
 /**
  * lpfc_rampdown_queue_depth - Post RAMP_DOWN_QUEUE event to worker thread
  * @phba: The Hba for which this call is being executed.
@@ -978,8 +976,6 @@ lpfc_bg_err_inject(struct lpfc_hba *phba, struct scsi_cmnd *sc,
 
 	sgpe = scsi_prot_sglist(sc);
 	lba = scsi_prot_ref_tag(sc);
-	if (lba == LPFC_INVALID_REFTAG)
-		return 0;
 
 	/* First check if we need to match the LBA */
 	if (phba->lpfc_injerr_lba != LPFC_INJERR_LBA_OFF) {
@@ -1560,8 +1556,6 @@ lpfc_bg_setup_bpl(struct lpfc_hba *phba, struct scsi_cmnd *sc,
 
 	/* extract some info from the scsi command for pde*/
 	reftag = scsi_prot_ref_tag(sc);
-	if (reftag == LPFC_INVALID_REFTAG)
-		goto out;
 
 #ifdef CONFIG_SCSI_LPFC_DEBUG_FS
 	rc = lpfc_bg_err_inject(phba, sc, &reftag, NULL, 1);
@@ -1723,8 +1717,6 @@ lpfc_bg_setup_bpl_prot(struct lpfc_hba *phba, struct scsi_cmnd *sc,
 	/* extract some info from the scsi command */
 	blksize = scsi_prot_interval(sc);
 	reftag = scsi_prot_ref_tag(sc);
-	if (reftag == LPFC_INVALID_REFTAG)
-		goto out;
 
 #ifdef CONFIG_SCSI_LPFC_DEBUG_FS
 	rc = lpfc_bg_err_inject(phba, sc, &reftag, NULL, 1);
@@ -1953,8 +1945,6 @@ lpfc_bg_setup_sgl(struct lpfc_hba *phba, struct scsi_cmnd *sc,
 
 	/* extract some info from the scsi command for pde*/
 	reftag = scsi_prot_ref_tag(sc);
-	if (reftag == LPFC_INVALID_REFTAG)
-		goto out;
 
 #ifdef CONFIG_SCSI_LPFC_DEBUG_FS
 	rc = lpfc_bg_err_inject(phba, sc, &reftag, NULL, 1);
@@ -2154,8 +2144,6 @@ lpfc_bg_setup_sgl_prot(struct lpfc_hba *phba, struct scsi_cmnd *sc,
 	/* extract some info from the scsi command */
 	blksize = scsi_prot_interval(sc);
 	reftag = scsi_prot_ref_tag(sc);
-	if (reftag == LPFC_INVALID_REFTAG)
-		goto out;
 
 #ifdef CONFIG_SCSI_LPFC_DEBUG_FS
 	rc = lpfc_bg_err_inject(phba, sc, &reftag, NULL, 1);
@@ -2746,8 +2734,6 @@ lpfc_calc_bg_err(struct lpfc_hba *phba, struct lpfc_io_buf *lpfc_cmd)
 
 		src = (struct scsi_dif_tuple *)sg_virt(sgpe);
 		start_ref_tag = scsi_prot_ref_tag(cmd);
-		if (start_ref_tag == LPFC_INVALID_REFTAG)
-			goto out;
 		start_app_tag = src->app_tag;
 		len = sgpe->length;
 		while (src && protsegcnt) {
@@ -3493,11 +3479,11 @@ lpfc_bg_scsi_prep_dma_buf_s4(struct lpfc_hba *phba,
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



