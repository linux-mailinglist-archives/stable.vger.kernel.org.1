Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 352377A38E0
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239874AbjIQTlx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239900AbjIQTlc (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:41:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4428DDB
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:41:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E2DAC433C7;
        Sun, 17 Sep 2023 19:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694979686;
        bh=EcL+1UK9YJWiq0zB2VSW1ZJ1R1vWWVUdzxMZWiXNnYk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vENt+k8KXwAR0eTbw8zTIeoD2f1ihFyNpfBlLmixK2WANchTbHFB9IXtlodIYVsJW
         QnrgvVx9reX0sQG0sc1tEbJpqSnt/tJlzlxQnBx618l3oTrQT+JmFsa3cc4qslMP70
         coXIVpZFenT/G0arPbJnjVMI1Fl8Q6w7xqokOEjw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Himanshu Madhani <himanshu.madhani@oracle.com>,
        Quinn Tran <qutran@marvell.com>,
        Nilesh Javali <njavali@marvell.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 384/406] scsi: qla2xxx: Consolidate zio threshold setting for both FCP & NVMe
Date:   Sun, 17 Sep 2023 21:13:58 +0200
Message-ID: <20230917191111.400324136@linuxfoundation.org>
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

From: Quinn Tran <qutran@marvell.com>

[ Upstream commit 5777fef788a59f5ac9ab6661988a95a045fc0574 ]

Consolidate zio threshold setting for both FCP & NVMe to prevent one
protocol from clobbering the setting of the other protocol.

Link: https://lore.kernel.org/r/20210329085229.4367-5-njavali@marvell.com
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
Signed-off-by: Quinn Tran <qutran@marvell.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Stable-dep-of: 6d0b65569c0a ("scsi: qla2xxx: Flush mailbox commands on chip reset")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qla2xxx/qla_def.h |  1 -
 drivers/scsi/qla2xxx/qla_os.c  | 34 ++++++++++++++--------------------
 2 files changed, 14 insertions(+), 21 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_def.h b/drivers/scsi/qla2xxx/qla_def.h
index 06b0ad2b51bb4..676e50142baaf 100644
--- a/drivers/scsi/qla2xxx/qla_def.h
+++ b/drivers/scsi/qla2xxx/qla_def.h
@@ -4706,7 +4706,6 @@ typedef struct scsi_qla_host {
 #define FX00_CRITEMP_RECOVERY	25
 #define FX00_HOST_INFO_RESEND	26
 #define QPAIR_ONLINE_CHECK_NEEDED	27
-#define SET_NVME_ZIO_THRESHOLD_NEEDED	28
 #define DETECT_SFP_CHANGE	29
 #define N2N_LOGIN_NEEDED	30
 #define IOCB_WORK_ACTIVE	31
diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index 78a335f862cee..bf40b293dcea6 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -6973,28 +6973,23 @@ qla2x00_do_dpc(void *data)
 			mutex_unlock(&ha->mq_lock);
 		}
 
-		if (test_and_clear_bit(SET_NVME_ZIO_THRESHOLD_NEEDED,
-		    &base_vha->dpc_flags)) {
+		if (test_and_clear_bit(SET_ZIO_THRESHOLD_NEEDED,
+				       &base_vha->dpc_flags)) {
+			u16 threshold = ha->nvme_last_rptd_aen + ha->last_zio_threshold;
+
+			if (threshold > ha->orig_fw_xcb_count)
+				threshold = ha->orig_fw_xcb_count;
+
 			ql_log(ql_log_info, base_vha, 0xffffff,
-				"nvme: SET ZIO Activity exchange threshold to %d.\n",
-						ha->nvme_last_rptd_aen);
-			if (qla27xx_set_zio_threshold(base_vha,
-			    ha->nvme_last_rptd_aen)) {
+			       "SET ZIO Activity exchange threshold to %d.\n",
+			       threshold);
+			if (qla27xx_set_zio_threshold(base_vha, threshold)) {
 				ql_log(ql_log_info, base_vha, 0xffffff,
-				    "nvme: Unable to SET ZIO Activity exchange threshold to %d.\n",
-				    ha->nvme_last_rptd_aen);
+				       "Unable to SET ZIO Activity exchange threshold to %d.\n",
+				       threshold);
 			}
 		}
 
-		if (test_and_clear_bit(SET_ZIO_THRESHOLD_NEEDED,
-		    &base_vha->dpc_flags)) {
-			ql_log(ql_log_info, base_vha, 0xffffff,
-			    "SET ZIO Activity exchange threshold to %d.\n",
-			    ha->last_zio_threshold);
-			qla27xx_set_zio_threshold(base_vha,
-			    ha->last_zio_threshold);
-		}
-
 		if (!IS_QLAFX00(ha))
 			qla2x00_do_dpc_all_vps(base_vha);
 
@@ -7210,14 +7205,13 @@ qla2x00_timer(struct timer_list *t)
 	index = atomic_read(&ha->nvme_active_aen_cnt);
 	if (!vha->vp_idx &&
 	    (index != ha->nvme_last_rptd_aen) &&
-	    (index >= DEFAULT_ZIO_THRESHOLD) &&
 	    ha->zio_mode == QLA_ZIO_MODE_6 &&
 	    !ha->flags.host_shutting_down) {
+		ha->nvme_last_rptd_aen = atomic_read(&ha->nvme_active_aen_cnt);
 		ql_log(ql_log_info, vha, 0x3002,
 		    "nvme: Sched: Set ZIO exchange threshold to %d.\n",
 		    ha->nvme_last_rptd_aen);
-		ha->nvme_last_rptd_aen = atomic_read(&ha->nvme_active_aen_cnt);
-		set_bit(SET_NVME_ZIO_THRESHOLD_NEEDED, &vha->dpc_flags);
+		set_bit(SET_ZIO_THRESHOLD_NEEDED, &vha->dpc_flags);
 		start_dpc++;
 	}
 
-- 
2.40.1



