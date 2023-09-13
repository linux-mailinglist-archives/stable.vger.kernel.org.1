Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E496479F10C
	for <lists+stable@lfdr.de>; Wed, 13 Sep 2023 20:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbjIMSVV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 13 Sep 2023 14:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231777AbjIMSVU (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 13 Sep 2023 14:21:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEAC119BF
        for <stable@vger.kernel.org>; Wed, 13 Sep 2023 11:21:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1536BC433C7;
        Wed, 13 Sep 2023 18:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694629276;
        bh=WaL1Tas8K+jb8M0srfdpuDHQMMpVtW09HziPyFWbyiA=;
        h=Subject:To:Cc:From:Date:From;
        b=ayOEIh0N941A/fKvCQADmTir53lEeoD/q8ZVSnioDmFssQchjZEu5SRRwxdPKJNLM
         /WE0tNsek8tAlwHRVyeqbSPPnreo6VCr+Q228DPVXhEUvu4IMSiSiV3iGLa/qr0Vxv
         qFEH2PFYNrTMWE39eLLg4x6ApDa2dvU0Vmo0SAvY=
Subject: FAILED: patch "[PATCH] scsi: qla2xxx: Flush mailbox commands on chip reset" failed to apply to 4.19-stable tree
To:     qutran@marvell.com, himanshu.madhani@oracle.com,
        martin.petersen@oracle.com, njavali@marvell.com,
        quinn.tran@marvell.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Wed, 13 Sep 2023 20:21:11 +0200
Message-ID: <2023091311-plunder-haste-c843@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x 6d0b65569c0a10b27c49bacd8d25bcd406003533
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023091311-plunder-haste-c843@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

6d0b65569c0a ("scsi: qla2xxx: Flush mailbox commands on chip reset")
8b4673ba3a1b ("scsi: qla2xxx: Add support for ZIO6 interrupt threshold")
b6faaaf796d7 ("scsi: qla2xxx: Serialize mailbox request")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6d0b65569c0a10b27c49bacd8d25bcd406003533 Mon Sep 17 00:00:00 2001
From: Quinn Tran <qutran@marvell.com>
Date: Mon, 21 Aug 2023 18:30:38 +0530
Subject: [PATCH] scsi: qla2xxx: Flush mailbox commands on chip reset

Fix race condition between Interrupt thread and Chip reset thread in trying
to flush the same mailbox. With the race condition, the "ha->mbx_intr_comp"
will get an extra complete() call. The extra complete call create erroneous
mailbox timeout condition when the next mailbox is sent where the mailbox
call does not wait for interrupt to arrive. Instead, it advances without
waiting.

Add lock protection around the check for mailbox completion.

Cc: stable@vger.kernel.org
Fixes: b2000805a975 ("scsi: qla2xxx: Flush mailbox commands on chip reset")
Signed-off-by: Quinn Tran <quinn.tran@marvell.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
Link: https://lore.kernel.org/r/20230821130045.34850-3-njavali@marvell.com
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>

diff --git a/drivers/scsi/qla2xxx/qla_def.h b/drivers/scsi/qla2xxx/qla_def.h
index 2007d5bb5f9f..f1cf921068e3 100644
--- a/drivers/scsi/qla2xxx/qla_def.h
+++ b/drivers/scsi/qla2xxx/qla_def.h
@@ -4418,7 +4418,6 @@ struct qla_hw_data {
 	uint8_t		aen_mbx_count;
 	atomic_t	num_pend_mbx_stage1;
 	atomic_t	num_pend_mbx_stage2;
-	atomic_t	num_pend_mbx_stage3;
 	uint16_t	frame_payload_size;
 
 	uint32_t	login_retry_count;
diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index 27644957ae4e..d38b77a29637 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -7391,14 +7391,15 @@ qla2x00_abort_isp_cleanup(scsi_qla_host_t *vha)
 	}
 
 	/* purge MBox commands */
-	if (atomic_read(&ha->num_pend_mbx_stage3)) {
+	spin_lock_irqsave(&ha->hardware_lock, flags);
+	if (test_bit(MBX_INTR_WAIT, &ha->mbx_cmd_flags)) {
 		clear_bit(MBX_INTR_WAIT, &ha->mbx_cmd_flags);
 		complete(&ha->mbx_intr_comp);
 	}
+	spin_unlock_irqrestore(&ha->hardware_lock, flags);
 
 	i = 0;
-	while (atomic_read(&ha->num_pend_mbx_stage3) ||
-	    atomic_read(&ha->num_pend_mbx_stage2) ||
+	while (atomic_read(&ha->num_pend_mbx_stage2) ||
 	    atomic_read(&ha->num_pend_mbx_stage1)) {
 		msleep(20);
 		i++;
diff --git a/drivers/scsi/qla2xxx/qla_mbx.c b/drivers/scsi/qla2xxx/qla_mbx.c
index b05f93037875..21ec32b4fb28 100644
--- a/drivers/scsi/qla2xxx/qla_mbx.c
+++ b/drivers/scsi/qla2xxx/qla_mbx.c
@@ -273,7 +273,6 @@ qla2x00_mailbox_command(scsi_qla_host_t *vha, mbx_cmd_t *mcp)
 		spin_unlock_irqrestore(&ha->hardware_lock, flags);
 
 		wait_time = jiffies;
-		atomic_inc(&ha->num_pend_mbx_stage3);
 		if (!wait_for_completion_timeout(&ha->mbx_intr_comp,
 		    mcp->tov * HZ)) {
 			ql_dbg(ql_dbg_mbx, vha, 0x117a,
@@ -290,7 +289,6 @@ qla2x00_mailbox_command(scsi_qla_host_t *vha, mbx_cmd_t *mcp)
 				spin_unlock_irqrestore(&ha->hardware_lock,
 				    flags);
 				atomic_dec(&ha->num_pend_mbx_stage2);
-				atomic_dec(&ha->num_pend_mbx_stage3);
 				rval = QLA_ABORTED;
 				goto premature_exit;
 			}
@@ -302,11 +300,9 @@ qla2x00_mailbox_command(scsi_qla_host_t *vha, mbx_cmd_t *mcp)
 			ha->flags.mbox_busy = 0;
 			spin_unlock_irqrestore(&ha->hardware_lock, flags);
 			atomic_dec(&ha->num_pend_mbx_stage2);
-			atomic_dec(&ha->num_pend_mbx_stage3);
 			rval = QLA_ABORTED;
 			goto premature_exit;
 		}
-		atomic_dec(&ha->num_pend_mbx_stage3);
 
 		if (time_after(jiffies, wait_time + 5 * HZ))
 			ql_log(ql_log_warn, vha, 0x1015, "cmd=0x%x, waited %d msecs\n",
diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index aa492489a4b8..e380634c8e25 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -3008,7 +3008,6 @@ qla2x00_probe_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	ha->max_exchg = FW_MAX_EXCHANGES_CNT;
 	atomic_set(&ha->num_pend_mbx_stage1, 0);
 	atomic_set(&ha->num_pend_mbx_stage2, 0);
-	atomic_set(&ha->num_pend_mbx_stage3, 0);
 	atomic_set(&ha->zio_threshold, DEFAULT_ZIO_THRESHOLD);
 	ha->last_zio_threshold = DEFAULT_ZIO_THRESHOLD;
 	INIT_LIST_HEAD(&ha->tmf_pending);

