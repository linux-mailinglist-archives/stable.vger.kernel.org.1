Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 127AE7A7B0D
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 13:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234481AbjITLs5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 07:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234630AbjITLs4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 07:48:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23416A3
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 04:48:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6263EC433C8;
        Wed, 20 Sep 2023 11:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695210529;
        bh=m06afj/Q7UsfukGDBCDi3fi5YJlyS6aU7JKCUjwZdkc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VkAwo7pKEqT0ogr+ObawvlFdAVCXbR+jCD67CqM2K+8qh0My0P+Uo0mv2w7jWSUeK
         PD4YH9wmt+mjtv2IXs9fC8Zc3WxKqJdUEBL0AfYkHNY6gUOXX4VnyNBXfALXat6jYl
         u6jDXsDVuU21cJR97vEJNnfxY5Bo7i9DK9T4BOI0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Justin Tee <justin.tee@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 111/211] scsi: lpfc: Abort outstanding ELS cmds when mailbox timeout error is detected
Date:   Wed, 20 Sep 2023 13:29:15 +0200
Message-ID: <20230920112849.238063132@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112845.859868994@linuxfoundation.org>
References: <20230920112845.859868994@linuxfoundation.org>
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

From: Justin Tee <justin.tee@broadcom.com>

[ Upstream commit 089ea22e374aa20043e72243c47b5867d5419d38 ]

A mailbox timeout error usually indicates something has gone wrong, and a
follow up reset of the HBA is a typical recovery mechanism.  Introduce a
MBX_TMO_ERR flag to detect such cases and have lpfc_els_flush_cmd abort ELS
commands if the MBX_TMO_ERR flag condition was set.  This ensures all of
the registered SGL resources meant for ELS traffic are not leaked after an
HBA reset.

Signed-off-by: Justin Tee <justin.tee@broadcom.com>
Link: https://lore.kernel.org/r/20230712180522.112722-9-justintee8345@gmail.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/lpfc/lpfc.h      |  1 +
 drivers/scsi/lpfc/lpfc_els.c  | 25 ++++++++++++++++++-------
 drivers/scsi/lpfc/lpfc_init.c | 20 +++++++++++++++++---
 drivers/scsi/lpfc/lpfc_sli.c  |  8 +++++++-
 4 files changed, 43 insertions(+), 11 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc.h b/drivers/scsi/lpfc/lpfc.h
index 9a89636843693..e8d7eeeb21856 100644
--- a/drivers/scsi/lpfc/lpfc.h
+++ b/drivers/scsi/lpfc/lpfc.h
@@ -872,6 +872,7 @@ enum lpfc_irq_chann_mode {
 enum lpfc_hba_bit_flags {
 	FABRIC_COMANDS_BLOCKED,
 	HBA_PCI_ERR,
+	MBX_TMO_ERR,
 };
 
 struct lpfc_hba {
diff --git a/drivers/scsi/lpfc/lpfc_els.c b/drivers/scsi/lpfc/lpfc_els.c
index 2bad9954c355f..6f6ef5235ee3b 100644
--- a/drivers/scsi/lpfc/lpfc_els.c
+++ b/drivers/scsi/lpfc/lpfc_els.c
@@ -9588,11 +9588,13 @@ void
 lpfc_els_flush_cmd(struct lpfc_vport *vport)
 {
 	LIST_HEAD(abort_list);
+	LIST_HEAD(cancel_list);
 	struct lpfc_hba  *phba = vport->phba;
 	struct lpfc_sli_ring *pring;
 	struct lpfc_iocbq *tmp_iocb, *piocb;
 	u32 ulp_command;
 	unsigned long iflags = 0;
+	bool mbx_tmo_err;
 
 	lpfc_fabric_abort_vport(vport);
 
@@ -9614,15 +9616,16 @@ lpfc_els_flush_cmd(struct lpfc_vport *vport)
 	if (phba->sli_rev == LPFC_SLI_REV4)
 		spin_lock(&pring->ring_lock);
 
+	mbx_tmo_err = test_bit(MBX_TMO_ERR, &phba->bit_flags);
 	/* First we need to issue aborts to outstanding cmds on txcmpl */
 	list_for_each_entry_safe(piocb, tmp_iocb, &pring->txcmplq, list) {
-		if (piocb->cmd_flag & LPFC_IO_LIBDFC)
+		if (piocb->cmd_flag & LPFC_IO_LIBDFC && !mbx_tmo_err)
 			continue;
 
 		if (piocb->vport != vport)
 			continue;
 
-		if (piocb->cmd_flag & LPFC_DRIVER_ABORTED)
+		if (piocb->cmd_flag & LPFC_DRIVER_ABORTED && !mbx_tmo_err)
 			continue;
 
 		/* On the ELS ring we can have ELS_REQUESTs or
@@ -9641,8 +9644,8 @@ lpfc_els_flush_cmd(struct lpfc_vport *vport)
 			 */
 			if (phba->link_state == LPFC_LINK_DOWN)
 				piocb->cmd_cmpl = lpfc_cmpl_els_link_down;
-		}
-		if (ulp_command == CMD_GEN_REQUEST64_CR)
+		} else if (ulp_command == CMD_GEN_REQUEST64_CR ||
+			   mbx_tmo_err)
 			list_add_tail(&piocb->dlist, &abort_list);
 	}
 
@@ -9654,11 +9657,19 @@ lpfc_els_flush_cmd(struct lpfc_vport *vport)
 	list_for_each_entry_safe(piocb, tmp_iocb, &abort_list, dlist) {
 		spin_lock_irqsave(&phba->hbalock, iflags);
 		list_del_init(&piocb->dlist);
-		lpfc_sli_issue_abort_iotag(phba, pring, piocb, NULL);
+		if (mbx_tmo_err)
+			list_move_tail(&piocb->list, &cancel_list);
+		else
+			lpfc_sli_issue_abort_iotag(phba, pring, piocb, NULL);
+
 		spin_unlock_irqrestore(&phba->hbalock, iflags);
 	}
-	/* Make sure HBA is alive */
-	lpfc_issue_hb_tmo(phba);
+	if (!list_empty(&cancel_list))
+		lpfc_sli_cancel_iocbs(phba, &cancel_list, IOSTAT_LOCAL_REJECT,
+				      IOERR_SLI_ABORTED);
+	else
+		/* Make sure HBA is alive */
+		lpfc_issue_hb_tmo(phba);
 
 	if (!list_empty(&abort_list))
 		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index 3221a934066bb..ce9e4cdd6004c 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -7550,6 +7550,8 @@ lpfc_disable_pci_dev(struct lpfc_hba *phba)
 void
 lpfc_reset_hba(struct lpfc_hba *phba)
 {
+	int rc = 0;
+
 	/* If resets are disabled then set error state and return. */
 	if (!phba->cfg_enable_hba_reset) {
 		phba->link_state = LPFC_HBA_ERROR;
@@ -7560,13 +7562,25 @@ lpfc_reset_hba(struct lpfc_hba *phba)
 	if (phba->sli.sli_flag & LPFC_SLI_ACTIVE) {
 		lpfc_offline_prep(phba, LPFC_MBX_WAIT);
 	} else {
+		if (test_bit(MBX_TMO_ERR, &phba->bit_flags)) {
+			/* Perform a PCI function reset to start from clean */
+			rc = lpfc_pci_function_reset(phba);
+			lpfc_els_flush_all_cmd(phba);
+		}
 		lpfc_offline_prep(phba, LPFC_MBX_NO_WAIT);
 		lpfc_sli_flush_io_rings(phba);
 	}
 	lpfc_offline(phba);
-	lpfc_sli_brdrestart(phba);
-	lpfc_online(phba);
-	lpfc_unblock_mgmt_io(phba);
+	clear_bit(MBX_TMO_ERR, &phba->bit_flags);
+	if (unlikely(rc)) {
+		lpfc_printf_log(phba, KERN_ERR, LOG_SLI,
+				"8888 PCI function reset failed rc %x\n",
+				rc);
+	} else {
+		lpfc_sli_brdrestart(phba);
+		lpfc_online(phba);
+		lpfc_unblock_mgmt_io(phba);
+	}
 }
 
 /**
diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
index 58d10f8f75a78..4dfadf254a727 100644
--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -3935,6 +3935,8 @@ void lpfc_poll_eratt(struct timer_list *t)
 	uint64_t sli_intr, cnt;
 
 	phba = from_timer(phba, t, eratt_poll);
+	if (!(phba->hba_flag & HBA_SETUP))
+		return;
 
 	/* Here we will also keep track of interrupts per sec of the hba */
 	sli_intr = phba->sli.slistat.sli_intr;
@@ -7693,7 +7695,9 @@ lpfc_sli4_repost_sgl_list(struct lpfc_hba *phba,
 		spin_unlock_irq(&phba->hbalock);
 	} else {
 		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
-				"3161 Failure to post sgl to port.\n");
+				"3161 Failure to post sgl to port,status %x "
+				"blkcnt %d totalcnt %d postcnt %d\n",
+				status, block_cnt, total_cnt, post_cnt);
 		return -EIO;
 	}
 
@@ -8478,6 +8482,7 @@ lpfc_sli4_hba_setup(struct lpfc_hba *phba)
 			spin_unlock_irq(&phba->hbalock);
 		}
 	}
+	phba->hba_flag &= ~HBA_SETUP;
 
 	lpfc_sli4_dip(phba);
 
@@ -9282,6 +9287,7 @@ lpfc_mbox_timeout_handler(struct lpfc_hba *phba)
 	 * would get IOCB_ERROR from lpfc_sli_issue_iocb, allowing
 	 * it to fail all outstanding SCSI IO.
 	 */
+	set_bit(MBX_TMO_ERR, &phba->bit_flags);
 	spin_lock_irq(&phba->pport->work_port_lock);
 	phba->pport->work_port_events &= ~WORKER_MBOX_TMO;
 	spin_unlock_irq(&phba->pport->work_port_lock);
-- 
2.40.1



