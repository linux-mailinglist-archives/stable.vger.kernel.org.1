Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42B0C7A3824
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239668AbjIQTbp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239710AbjIQTb3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:31:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EEC3DB
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:31:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80037C433C8;
        Sun, 17 Sep 2023 19:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694979081;
        bh=KeSfaUZKfqrHrblHdFjsDWTAG6UBpYYBNOQhjSP+Zuw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LlyDEKRGIXVhyLclJBvTEgsIlCD5/MDDad30oi1mBZirxXiRX71KYh01SFQZVBkZ8
         JLD/05vSV36jSFFAbqiHH5FHPf+GHLf0HnV9S/CSnYbQOmi+KIIX/puEJXn4unp0ZR
         Vc/2uyIyeRawG+AgIhPfiA9ijNbjZ1Ft/f/CQAAA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hannes Reinecke <hare@suse.com>,
        Artur Paszkiewicz <artur.paszkiewicz@intel.com>,
        Jason Yan <yanaijie@huawei.com>,
        John Garry <john.garry@huawei.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>,
        Jack Wang <jinpu.wang@ionos.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 209/406] scsi: libsas: Introduce more SAM status code aliases in enum exec_status
Date:   Sun, 17 Sep 2023 21:11:03 +0200
Message-ID: <20230917191106.710446742@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191101.035638219@linuxfoundation.org>
References: <20230917191101.035638219@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bart Van Assche <bvanassche@acm.org>

[ Upstream commit d377f415dddc18b33c88dcd41cfe4fe6d9db82fb ]

This patch prepares for converting SAM status codes into an enum. Without
this patch converting SAM status codes into an enumeration type would
trigger complaints about enum type mismatches for the SAS code.

Link: https://lore.kernel.org/r/20210524025457.11299-2-bvanassche@acm.org
Cc: Hannes Reinecke <hare@suse.com>
Cc: Artur Paszkiewicz <artur.paszkiewicz@intel.com>
Cc: Jason Yan <yanaijie@huawei.com>
Reviewed-by: John Garry <john.garry@huawei.com>
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
Acked-by: Jack Wang <jinpu.wang@ionos.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Stable-dep-of: f5393a5602ca ("scsi: hisi_sas: Fix normally completed I/O analysed as failed")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/aic94xx/aic94xx_task.c    |  2 +-
 drivers/scsi/hisi_sas/hisi_sas_v1_hw.c |  8 ++++----
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c |  8 ++++----
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c |  8 ++++----
 drivers/scsi/isci/request.c            | 10 +++++-----
 drivers/scsi/isci/task.c               |  2 +-
 drivers/scsi/libsas/sas_ata.c          |  7 ++++---
 drivers/scsi/libsas/sas_expander.c     |  2 +-
 drivers/scsi/libsas/sas_task.c         |  4 ++--
 drivers/scsi/mvsas/mv_sas.c            | 10 +++++-----
 drivers/scsi/pm8001/pm8001_hwi.c       | 16 ++++++++--------
 drivers/scsi/pm8001/pm8001_sas.c       |  4 ++--
 drivers/scsi/pm8001/pm80xx_hwi.c       | 14 +++++++-------
 include/scsi/libsas.h                  | 12 +++++++++---
 14 files changed, 57 insertions(+), 50 deletions(-)

diff --git a/drivers/scsi/aic94xx/aic94xx_task.c b/drivers/scsi/aic94xx/aic94xx_task.c
index 593b167ceefee..2eb2885ee6e2f 100644
--- a/drivers/scsi/aic94xx/aic94xx_task.c
+++ b/drivers/scsi/aic94xx/aic94xx_task.c
@@ -208,7 +208,7 @@ static void asd_task_tasklet_complete(struct asd_ascb *ascb,
 	switch (opcode) {
 	case TC_NO_ERROR:
 		ts->resp = SAS_TASK_COMPLETE;
-		ts->stat = SAM_STAT_GOOD;
+		ts->stat = SAS_SAM_STAT_GOOD;
 		break;
 	case TC_UNDERRUN:
 		ts->resp = SAS_TASK_COMPLETE;
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
index 2c1028183b242..5b54cdd6b9767 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
@@ -1152,14 +1152,14 @@ static void slot_err_v1_hw(struct hisi_hba *hisi_hba,
 		}
 		default:
 		{
-			ts->stat = SAM_STAT_CHECK_CONDITION;
+			ts->stat = SAS_SAM_STAT_CHECK_CONDITION;
 			break;
 		}
 		}
 	}
 		break;
 	case SAS_PROTOCOL_SMP:
-		ts->stat = SAM_STAT_CHECK_CONDITION;
+		ts->stat = SAS_SAM_STAT_CHECK_CONDITION;
 		break;
 
 	case SAS_PROTOCOL_SATA:
@@ -1281,7 +1281,7 @@ static void slot_complete_v1_hw(struct hisi_hba *hisi_hba,
 		struct scatterlist *sg_resp = &task->smp_task.smp_resp;
 		void *to = page_address(sg_page(sg_resp));
 
-		ts->stat = SAM_STAT_GOOD;
+		ts->stat = SAS_SAM_STAT_GOOD;
 
 		dma_unmap_sg(dev, &task->smp_task.smp_req, 1,
 			     DMA_TO_DEVICE);
@@ -1298,7 +1298,7 @@ static void slot_complete_v1_hw(struct hisi_hba *hisi_hba,
 		break;
 
 	default:
-		ts->stat = SAM_STAT_CHECK_CONDITION;
+		ts->stat = SAS_SAM_STAT_CHECK_CONDITION;
 		break;
 	}
 
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
index b75d54339e40c..4bd26c7946328 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
@@ -2168,7 +2168,7 @@ static void slot_err_v2_hw(struct hisi_hba *hisi_hba,
 	}
 		break;
 	case SAS_PROTOCOL_SMP:
-		ts->stat = SAM_STAT_CHECK_CONDITION;
+		ts->stat = SAS_SAM_STAT_CHECK_CONDITION;
 		break;
 
 	case SAS_PROTOCOL_SATA:
@@ -2427,7 +2427,7 @@ static void slot_complete_v2_hw(struct hisi_hba *hisi_hba,
 		struct scatterlist *sg_resp = &task->smp_task.smp_resp;
 		void *to = page_address(sg_page(sg_resp));
 
-		ts->stat = SAM_STAT_GOOD;
+		ts->stat = SAS_SAM_STAT_GOOD;
 
 		dma_unmap_sg(dev, &task->smp_task.smp_req, 1,
 			     DMA_TO_DEVICE);
@@ -2441,12 +2441,12 @@ static void slot_complete_v2_hw(struct hisi_hba *hisi_hba,
 	case SAS_PROTOCOL_STP:
 	case SAS_PROTOCOL_SATA | SAS_PROTOCOL_STP:
 	{
-		ts->stat = SAM_STAT_GOOD;
+		ts->stat = SAS_SAM_STAT_GOOD;
 		hisi_sas_sata_done(task, slot);
 		break;
 	}
 	default:
-		ts->stat = SAM_STAT_CHECK_CONDITION;
+		ts->stat = SAS_SAM_STAT_CHECK_CONDITION;
 		break;
 	}
 
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index e025855609336..59ac0f8e6d5c3 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -2159,7 +2159,7 @@ slot_err_v3_hw(struct hisi_hba *hisi_hba, struct sas_task *task,
 		hisi_sas_sata_done(task, slot);
 		break;
 	case SAS_PROTOCOL_SMP:
-		ts->stat = SAM_STAT_CHECK_CONDITION;
+		ts->stat = SAS_SAM_STAT_CHECK_CONDITION;
 		break;
 	default:
 		break;
@@ -2266,7 +2266,7 @@ static void slot_complete_v3_hw(struct hisi_hba *hisi_hba,
 		struct scatterlist *sg_resp = &task->smp_task.smp_resp;
 		void *to = page_address(sg_page(sg_resp));
 
-		ts->stat = SAM_STAT_GOOD;
+		ts->stat = SAS_SAM_STAT_GOOD;
 
 		dma_unmap_sg(dev, &task->smp_task.smp_req, 1,
 			     DMA_TO_DEVICE);
@@ -2279,11 +2279,11 @@ static void slot_complete_v3_hw(struct hisi_hba *hisi_hba,
 	case SAS_PROTOCOL_SATA:
 	case SAS_PROTOCOL_STP:
 	case SAS_PROTOCOL_SATA | SAS_PROTOCOL_STP:
-		ts->stat = SAM_STAT_GOOD;
+		ts->stat = SAS_SAM_STAT_GOOD;
 		hisi_sas_sata_done(task, slot);
 		break;
 	default:
-		ts->stat = SAM_STAT_CHECK_CONDITION;
+		ts->stat = SAS_SAM_STAT_CHECK_CONDITION;
 		break;
 	}
 
diff --git a/drivers/scsi/isci/request.c b/drivers/scsi/isci/request.c
index 6e0817941fa74..b6d68d871b6cb 100644
--- a/drivers/scsi/isci/request.c
+++ b/drivers/scsi/isci/request.c
@@ -2574,7 +2574,7 @@ static void isci_request_handle_controller_specific_errors(
 			if (!idev)
 				*status_ptr = SAS_DEVICE_UNKNOWN;
 			else
-				*status_ptr = SAM_STAT_TASK_ABORTED;
+				*status_ptr = SAS_SAM_STAT_TASK_ABORTED;
 
 			clear_bit(IREQ_COMPLETE_IN_TARGET, &request->flags);
 		}
@@ -2704,7 +2704,7 @@ static void isci_request_handle_controller_specific_errors(
 	default:
 		/* Task in the target is not done. */
 		*response_ptr = SAS_TASK_UNDELIVERED;
-		*status_ptr = SAM_STAT_TASK_ABORTED;
+		*status_ptr = SAS_SAM_STAT_TASK_ABORTED;
 
 		if (task->task_proto == SAS_PROTOCOL_SMP)
 			set_bit(IREQ_COMPLETE_IN_TARGET, &request->flags);
@@ -2727,7 +2727,7 @@ static void isci_process_stp_response(struct sas_task *task, struct dev_to_host_
 	if (ac_err_mask(fis->status))
 		ts->stat = SAS_PROTO_RESPONSE;
 	else
-		ts->stat = SAM_STAT_GOOD;
+		ts->stat = SAS_SAM_STAT_GOOD;
 
 	ts->resp = SAS_TASK_COMPLETE;
 }
@@ -2790,7 +2790,7 @@ static void isci_request_io_request_complete(struct isci_host *ihost,
 	case SCI_IO_SUCCESS_IO_DONE_EARLY:
 
 		response = SAS_TASK_COMPLETE;
-		status   = SAM_STAT_GOOD;
+		status   = SAS_SAM_STAT_GOOD;
 		set_bit(IREQ_COMPLETE_IN_TARGET, &request->flags);
 
 		if (completion_status == SCI_IO_SUCCESS_IO_DONE_EARLY) {
@@ -2860,7 +2860,7 @@ static void isci_request_io_request_complete(struct isci_host *ihost,
 
 		/* Fail the I/O. */
 		response = SAS_TASK_UNDELIVERED;
-		status = SAM_STAT_TASK_ABORTED;
+		status = SAS_SAM_STAT_TASK_ABORTED;
 
 		clear_bit(IREQ_COMPLETE_IN_TARGET, &request->flags);
 		break;
diff --git a/drivers/scsi/isci/task.c b/drivers/scsi/isci/task.c
index 26fa1a4d1e6bf..1d1db40a1572c 100644
--- a/drivers/scsi/isci/task.c
+++ b/drivers/scsi/isci/task.c
@@ -160,7 +160,7 @@ int isci_task_execute_task(struct sas_task *task, gfp_t gfp_flags)
 
 			isci_task_refuse(ihost, task,
 					 SAS_TASK_UNDELIVERED,
-					 SAM_STAT_TASK_ABORTED);
+					 SAS_SAM_STAT_TASK_ABORTED);
 		} else {
 			task->task_state_flags |= SAS_TASK_AT_INITIATOR;
 			spin_unlock_irqrestore(&task->task_state_lock, flags);
diff --git a/drivers/scsi/libsas/sas_ata.c b/drivers/scsi/libsas/sas_ata.c
index a1a06a832d866..f92b889369c39 100644
--- a/drivers/scsi/libsas/sas_ata.c
+++ b/drivers/scsi/libsas/sas_ata.c
@@ -122,9 +122,10 @@ static void sas_ata_task_done(struct sas_task *task)
 		}
 	}
 
-	if (stat->stat == SAS_PROTO_RESPONSE || stat->stat == SAM_STAT_GOOD ||
-	    ((stat->stat == SAM_STAT_CHECK_CONDITION &&
-	      dev->sata_dev.class == ATA_DEV_ATAPI))) {
+	if (stat->stat == SAS_PROTO_RESPONSE ||
+	    stat->stat == SAS_SAM_STAT_GOOD ||
+	    (stat->stat == SAS_SAM_STAT_CHECK_CONDITION &&
+	      dev->sata_dev.class == ATA_DEV_ATAPI)) {
 		memcpy(dev->sata_dev.fis, resp->ending_fis, ATA_RESP_FIS_SIZE);
 
 		if (!link->sactive) {
diff --git a/drivers/scsi/libsas/sas_expander.c b/drivers/scsi/libsas/sas_expander.c
index 51485d0251f2d..8444a4287ac1c 100644
--- a/drivers/scsi/libsas/sas_expander.c
+++ b/drivers/scsi/libsas/sas_expander.c
@@ -101,7 +101,7 @@ static int smp_execute_task_sg(struct domain_device *dev,
 			}
 		}
 		if (task->task_status.resp == SAS_TASK_COMPLETE &&
-		    task->task_status.stat == SAM_STAT_GOOD) {
+		    task->task_status.stat == SAS_SAM_STAT_GOOD) {
 			res = 0;
 			break;
 		}
diff --git a/drivers/scsi/libsas/sas_task.c b/drivers/scsi/libsas/sas_task.c
index e2d42593ce529..2966ead1d4217 100644
--- a/drivers/scsi/libsas/sas_task.c
+++ b/drivers/scsi/libsas/sas_task.c
@@ -20,7 +20,7 @@ void sas_ssp_task_response(struct device *dev, struct sas_task *task,
 	else if (iu->datapres == 1)
 		tstat->stat = iu->resp_data[3];
 	else if (iu->datapres == 2) {
-		tstat->stat = SAM_STAT_CHECK_CONDITION;
+		tstat->stat = SAS_SAM_STAT_CHECK_CONDITION;
 		tstat->buf_valid_size =
 			min_t(int, SAS_STATUS_BUF_SIZE,
 			      be32_to_cpu(iu->sense_data_len));
@@ -32,7 +32,7 @@ void sas_ssp_task_response(struct device *dev, struct sas_task *task,
 	}
 	else
 		/* when datapres contains corrupt/unknown value... */
-		tstat->stat = SAM_STAT_CHECK_CONDITION;
+		tstat->stat = SAS_SAM_STAT_CHECK_CONDITION;
 }
 EXPORT_SYMBOL_GPL(sas_ssp_task_response);
 
diff --git a/drivers/scsi/mvsas/mv_sas.c b/drivers/scsi/mvsas/mv_sas.c
index 484e01428da28..a2a13969c686e 100644
--- a/drivers/scsi/mvsas/mv_sas.c
+++ b/drivers/scsi/mvsas/mv_sas.c
@@ -1314,7 +1314,7 @@ static int mvs_exec_internal_tmf_task(struct domain_device *dev,
 		}
 
 		if (task->task_status.resp == SAS_TASK_COMPLETE &&
-		    task->task_status.stat == SAM_STAT_GOOD) {
+		    task->task_status.stat == SAS_SAM_STAT_GOOD) {
 			res = TMF_RESP_FUNC_COMPLETE;
 			break;
 		}
@@ -1764,7 +1764,7 @@ int mvs_slot_complete(struct mvs_info *mvi, u32 rx_desc, u32 flags)
 	case SAS_PROTOCOL_SSP:
 		/* hw says status == 0, datapres == 0 */
 		if (rx_desc & RXQ_GOOD) {
-			tstat->stat = SAM_STAT_GOOD;
+			tstat->stat = SAS_SAM_STAT_GOOD;
 			tstat->resp = SAS_TASK_COMPLETE;
 		}
 		/* response frame present */
@@ -1773,12 +1773,12 @@ int mvs_slot_complete(struct mvs_info *mvi, u32 rx_desc, u32 flags)
 						sizeof(struct mvs_err_info);
 			sas_ssp_task_response(mvi->dev, task, iu);
 		} else
-			tstat->stat = SAM_STAT_CHECK_CONDITION;
+			tstat->stat = SAS_SAM_STAT_CHECK_CONDITION;
 		break;
 
 	case SAS_PROTOCOL_SMP: {
 			struct scatterlist *sg_resp = &task->smp_task.smp_resp;
-			tstat->stat = SAM_STAT_GOOD;
+			tstat->stat = SAS_SAM_STAT_GOOD;
 			to = kmap_atomic(sg_page(sg_resp));
 			memcpy(to + sg_resp->offset,
 				slot->response + sizeof(struct mvs_err_info),
@@ -1795,7 +1795,7 @@ int mvs_slot_complete(struct mvs_info *mvi, u32 rx_desc, u32 flags)
 		}
 
 	default:
-		tstat->stat = SAM_STAT_CHECK_CONDITION;
+		tstat->stat = SAS_SAM_STAT_CHECK_CONDITION;
 		break;
 	}
 	if (!slot->port->port_attached) {
diff --git a/drivers/scsi/pm8001/pm8001_hwi.c b/drivers/scsi/pm8001/pm8001_hwi.c
index da9fbe62a34d1..e9b3485baee01 100644
--- a/drivers/scsi/pm8001/pm8001_hwi.c
+++ b/drivers/scsi/pm8001/pm8001_hwi.c
@@ -1881,7 +1881,7 @@ mpi_ssp_completion(struct pm8001_hba_info *pm8001_ha , void *piomb)
 			   param);
 		if (param == 0) {
 			ts->resp = SAS_TASK_COMPLETE;
-			ts->stat = SAM_STAT_GOOD;
+			ts->stat = SAS_SAM_STAT_GOOD;
 		} else {
 			ts->resp = SAS_TASK_COMPLETE;
 			ts->stat = SAS_PROTO_RESPONSE;
@@ -2341,7 +2341,7 @@ mpi_sata_completion(struct pm8001_hba_info *pm8001_ha, void *piomb)
 		pm8001_dbg(pm8001_ha, IO, "IO_SUCCESS\n");
 		if (param == 0) {
 			ts->resp = SAS_TASK_COMPLETE;
-			ts->stat = SAM_STAT_GOOD;
+			ts->stat = SAS_SAM_STAT_GOOD;
 			/* check if response is for SEND READ LOG */
 			if (pm8001_dev &&
 				(pm8001_dev->id & NCQ_READ_LOG_FLAG)) {
@@ -2864,7 +2864,7 @@ mpi_smp_completion(struct pm8001_hba_info *pm8001_ha, void *piomb)
 	case IO_SUCCESS:
 		pm8001_dbg(pm8001_ha, IO, "IO_SUCCESS\n");
 		ts->resp = SAS_TASK_COMPLETE;
-		ts->stat = SAM_STAT_GOOD;
+		ts->stat = SAS_SAM_STAT_GOOD;
 		if (pm8001_dev)
 			atomic_dec(&pm8001_dev->running_req);
 		break;
@@ -2891,17 +2891,17 @@ mpi_smp_completion(struct pm8001_hba_info *pm8001_ha, void *piomb)
 	case IO_ERROR_HW_TIMEOUT:
 		pm8001_dbg(pm8001_ha, IO, "IO_ERROR_HW_TIMEOUT\n");
 		ts->resp = SAS_TASK_COMPLETE;
-		ts->stat = SAM_STAT_BUSY;
+		ts->stat = SAS_SAM_STAT_BUSY;
 		break;
 	case IO_XFER_ERROR_BREAK:
 		pm8001_dbg(pm8001_ha, IO, "IO_XFER_ERROR_BREAK\n");
 		ts->resp = SAS_TASK_COMPLETE;
-		ts->stat = SAM_STAT_BUSY;
+		ts->stat = SAS_SAM_STAT_BUSY;
 		break;
 	case IO_XFER_ERROR_PHY_NOT_READY:
 		pm8001_dbg(pm8001_ha, IO, "IO_XFER_ERROR_PHY_NOT_READY\n");
 		ts->resp = SAS_TASK_COMPLETE;
-		ts->stat = SAM_STAT_BUSY;
+		ts->stat = SAS_SAM_STAT_BUSY;
 		break;
 	case IO_OPEN_CNX_ERROR_PROTOCOL_NOT_SUPPORTED:
 		pm8001_dbg(pm8001_ha, IO,
@@ -3656,7 +3656,7 @@ int pm8001_mpi_task_abort_resp(struct pm8001_hba_info *pm8001_ha, void *piomb)
 	case IO_SUCCESS:
 		pm8001_dbg(pm8001_ha, EH, "IO_SUCCESS\n");
 		ts->resp = SAS_TASK_COMPLETE;
-		ts->stat = SAM_STAT_GOOD;
+		ts->stat = SAS_SAM_STAT_GOOD;
 		break;
 	case IO_NOT_VALID:
 		pm8001_dbg(pm8001_ha, EH, "IO_NOT_VALID\n");
@@ -4288,7 +4288,7 @@ static int pm8001_chip_sata_req(struct pm8001_hba_info *pm8001_ha,
 
 			spin_lock_irqsave(&task->task_state_lock, flags);
 			ts->resp = SAS_TASK_COMPLETE;
-			ts->stat = SAM_STAT_GOOD;
+			ts->stat = SAS_SAM_STAT_GOOD;
 			task->task_state_flags &= ~SAS_TASK_STATE_PENDING;
 			task->task_state_flags &= ~SAS_TASK_AT_INITIATOR;
 			task->task_state_flags |= SAS_TASK_STATE_DONE;
diff --git a/drivers/scsi/pm8001/pm8001_sas.c b/drivers/scsi/pm8001/pm8001_sas.c
index ba5852548bee3..a16ed0695f1ae 100644
--- a/drivers/scsi/pm8001/pm8001_sas.c
+++ b/drivers/scsi/pm8001/pm8001_sas.c
@@ -764,7 +764,7 @@ static int pm8001_exec_internal_tmf_task(struct domain_device *dev,
 		}
 
 		if (task->task_status.resp == SAS_TASK_COMPLETE &&
-			task->task_status.stat == SAM_STAT_GOOD) {
+			task->task_status.stat == SAS_SAM_STAT_GOOD) {
 			res = TMF_RESP_FUNC_COMPLETE;
 			break;
 		}
@@ -846,7 +846,7 @@ pm8001_exec_internal_task_abort(struct pm8001_hba_info *pm8001_ha,
 		}
 
 		if (task->task_status.resp == SAS_TASK_COMPLETE &&
-			task->task_status.stat == SAM_STAT_GOOD) {
+			task->task_status.stat == SAS_SAM_STAT_GOOD) {
 			res = TMF_RESP_FUNC_COMPLETE;
 			break;
 
diff --git a/drivers/scsi/pm8001/pm80xx_hwi.c b/drivers/scsi/pm8001/pm80xx_hwi.c
index 0305c8999ba5d..c98c0a53a018c 100644
--- a/drivers/scsi/pm8001/pm80xx_hwi.c
+++ b/drivers/scsi/pm8001/pm80xx_hwi.c
@@ -1916,7 +1916,7 @@ mpi_ssp_completion(struct pm8001_hba_info *pm8001_ha , void *piomb)
 			   param);
 		if (param == 0) {
 			ts->resp = SAS_TASK_COMPLETE;
-			ts->stat = SAM_STAT_GOOD;
+			ts->stat = SAS_SAM_STAT_GOOD;
 		} else {
 			ts->resp = SAS_TASK_COMPLETE;
 			ts->stat = SAS_PROTO_RESPONSE;
@@ -2450,7 +2450,7 @@ mpi_sata_completion(struct pm8001_hba_info *pm8001_ha, void *piomb)
 		pm8001_dbg(pm8001_ha, IO, "IO_SUCCESS\n");
 		if (param == 0) {
 			ts->resp = SAS_TASK_COMPLETE;
-			ts->stat = SAM_STAT_GOOD;
+			ts->stat = SAS_SAM_STAT_GOOD;
 			/* check if response is for SEND READ LOG */
 			if (pm8001_dev &&
 				(pm8001_dev->id & NCQ_READ_LOG_FLAG)) {
@@ -3004,7 +3004,7 @@ mpi_smp_completion(struct pm8001_hba_info *pm8001_ha, void *piomb)
 	case IO_SUCCESS:
 		pm8001_dbg(pm8001_ha, IO, "IO_SUCCESS\n");
 		ts->resp = SAS_TASK_COMPLETE;
-		ts->stat = SAM_STAT_GOOD;
+		ts->stat = SAS_SAM_STAT_GOOD;
 		if (pm8001_dev)
 			atomic_dec(&pm8001_dev->running_req);
 		if (pm8001_ha->smp_exp_mode == SMP_DIRECT) {
@@ -3046,17 +3046,17 @@ mpi_smp_completion(struct pm8001_hba_info *pm8001_ha, void *piomb)
 	case IO_ERROR_HW_TIMEOUT:
 		pm8001_dbg(pm8001_ha, IO, "IO_ERROR_HW_TIMEOUT\n");
 		ts->resp = SAS_TASK_COMPLETE;
-		ts->stat = SAM_STAT_BUSY;
+		ts->stat = SAS_SAM_STAT_BUSY;
 		break;
 	case IO_XFER_ERROR_BREAK:
 		pm8001_dbg(pm8001_ha, IO, "IO_XFER_ERROR_BREAK\n");
 		ts->resp = SAS_TASK_COMPLETE;
-		ts->stat = SAM_STAT_BUSY;
+		ts->stat = SAS_SAM_STAT_BUSY;
 		break;
 	case IO_XFER_ERROR_PHY_NOT_READY:
 		pm8001_dbg(pm8001_ha, IO, "IO_XFER_ERROR_PHY_NOT_READY\n");
 		ts->resp = SAS_TASK_COMPLETE;
-		ts->stat = SAM_STAT_BUSY;
+		ts->stat = SAS_SAM_STAT_BUSY;
 		break;
 	case IO_OPEN_CNX_ERROR_PROTOCOL_NOT_SUPPORTED:
 		pm8001_dbg(pm8001_ha, IO,
@@ -4679,7 +4679,7 @@ static int pm80xx_chip_sata_req(struct pm8001_hba_info *pm8001_ha,
 
 			spin_lock_irqsave(&task->task_state_lock, flags);
 			ts->resp = SAS_TASK_COMPLETE;
-			ts->stat = SAM_STAT_GOOD;
+			ts->stat = SAS_SAM_STAT_GOOD;
 			task->task_state_flags &= ~SAS_TASK_STATE_PENDING;
 			task->task_state_flags &= ~SAS_TASK_AT_INITIATOR;
 			task->task_state_flags |= SAS_TASK_STATE_DONE;
diff --git a/include/scsi/libsas.h b/include/scsi/libsas.h
index e6a43163ab5b7..daf9b07956abf 100644
--- a/include/scsi/libsas.h
+++ b/include/scsi/libsas.h
@@ -474,10 +474,16 @@ enum service_response {
 };
 
 enum exec_status {
-	/* The SAM_STAT_.. codes fit in the lower 6 bits, alias some of
-	 * them here to silence 'case value not in enumerated type' warnings
+	/*
+	 * Values 0..0x7f are used to return the SAM_STAT_* codes.  To avoid
+	 * 'case value not in enumerated type' compiler warnings every value
+	 * returned through the exec_status enum needs an alias with the SAS_
+	 * prefix here.
 	 */
-	__SAM_STAT_CHECK_CONDITION = SAM_STAT_CHECK_CONDITION,
+	SAS_SAM_STAT_GOOD = SAM_STAT_GOOD,
+	SAS_SAM_STAT_BUSY = SAM_STAT_BUSY,
+	SAS_SAM_STAT_TASK_ABORTED = SAM_STAT_TASK_ABORTED,
+	SAS_SAM_STAT_CHECK_CONDITION = SAM_STAT_CHECK_CONDITION,
 
 	SAS_DEV_NO_RESPONSE = 0x80,
 	SAS_DATA_UNDERRUN,
-- 
2.40.1



