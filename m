Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5936576ACFD
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbjHAJZM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231732AbjHAJYx (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:24:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 382792D64
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:23:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1DC98613E2
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:23:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31E70C433C8;
        Tue,  1 Aug 2023 09:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690881821;
        bh=Xq5mus2cIG63O3+3LFlOgk+KOEcuPa3Z7rN4z0pHEQA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NZUntSXDG1oNcmC122sS7P35fG35Af2MWAXxfNKhKTaln20+qidb3OisZ4AvjEvT2
         ov6glvqsAcj4k80jF5Ivs8E+tJg8NZXscaKdkOHQlYkPVaNPheAeH4u2aQs+XkUrT2
         Vk+RRkMBOfBsXtNdBnL7rf2wYE5SJ9YXp2KnLU/Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, kernel test robot <lkp@intel.com>,
        Quinn Tran <qutran@marvell.com>,
        Nilesh Javali <njavali@marvell.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 041/155] scsi: qla2xxx: Fix task management cmd fail due to unavailable resource
Date:   Tue,  1 Aug 2023 11:19:13 +0200
Message-ID: <20230801091911.646416068@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091910.165050260@linuxfoundation.org>
References: <20230801091910.165050260@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Quinn Tran <qutran@marvell.com>

[ Upstream commit 6a87679626b51b53fbb6be417ad8eb083030b617 ]

Task management command failed with status 2Ch which is
a result of too many task management commands sent
to the same target. Hence limit task management commands
to 8 per target.

Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/oe-kbuild-all/202304271952.NKNmoFzv-lkp@intel.com/
Cc: stable@vger.kernel.org
Signed-off-by: Quinn Tran <qutran@marvell.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
Link: https://lore.kernel.org/r/20230428075339.32551-4-njavali@marvell.com
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qla2xxx/qla_def.h  |  3 ++
 drivers/scsi/qla2xxx/qla_init.c | 63 ++++++++++++++++++++++++++++++---
 2 files changed, 61 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_def.h b/drivers/scsi/qla2xxx/qla_def.h
index ca63aa8f33b5d..bbeb116c16cc3 100644
--- a/drivers/scsi/qla2xxx/qla_def.h
+++ b/drivers/scsi/qla2xxx/qla_def.h
@@ -2523,6 +2523,7 @@ enum rscn_addr_format {
 typedef struct fc_port {
 	struct list_head list;
 	struct scsi_qla_host *vha;
+	struct list_head tmf_pending;
 
 	unsigned int conf_compl_supported:1;
 	unsigned int deleted:2;
@@ -2543,6 +2544,8 @@ typedef struct fc_port {
 	unsigned int do_prli_nvme:1;
 
 	uint8_t nvme_flag;
+	uint8_t active_tmf;
+#define MAX_ACTIVE_TMF 8
 
 	uint8_t node_name[WWN_SIZE];
 	uint8_t port_name[WWN_SIZE];
diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index 9d9b16f7f34a6..2c42ecb2a64a5 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -2151,6 +2151,54 @@ __qla2x00_async_tm_cmd(struct tmf_arg *arg)
 	return rval;
 }
 
+static void qla_put_tmf(fc_port_t *fcport)
+{
+	struct scsi_qla_host *vha = fcport->vha;
+	struct qla_hw_data *ha = vha->hw;
+	unsigned long flags;
+
+	spin_lock_irqsave(&ha->tgt.sess_lock, flags);
+	fcport->active_tmf--;
+	spin_unlock_irqrestore(&ha->tgt.sess_lock, flags);
+}
+
+static
+int qla_get_tmf(fc_port_t *fcport)
+{
+	struct scsi_qla_host *vha = fcport->vha;
+	struct qla_hw_data *ha = vha->hw;
+	unsigned long flags;
+	int rc = 0;
+	LIST_HEAD(tmf_elem);
+
+	spin_lock_irqsave(&ha->tgt.sess_lock, flags);
+	list_add_tail(&tmf_elem, &fcport->tmf_pending);
+
+	while (fcport->active_tmf >= MAX_ACTIVE_TMF) {
+		spin_unlock_irqrestore(&ha->tgt.sess_lock, flags);
+
+		msleep(1);
+
+		spin_lock_irqsave(&ha->tgt.sess_lock, flags);
+		if (fcport->deleted) {
+			rc = EIO;
+			break;
+		}
+		if (fcport->active_tmf < MAX_ACTIVE_TMF &&
+		    list_is_first(&tmf_elem, &fcport->tmf_pending))
+			break;
+	}
+
+	list_del(&tmf_elem);
+
+	if (!rc)
+		fcport->active_tmf++;
+
+	spin_unlock_irqrestore(&ha->tgt.sess_lock, flags);
+
+	return rc;
+}
+
 int
 qla2x00_async_tm_cmd(fc_port_t *fcport, uint32_t flags, uint64_t lun,
 		     uint32_t tag)
@@ -2158,18 +2206,19 @@ qla2x00_async_tm_cmd(fc_port_t *fcport, uint32_t flags, uint64_t lun,
 	struct scsi_qla_host *vha = fcport->vha;
 	struct qla_qpair *qpair;
 	struct tmf_arg a;
-	struct completion comp;
 	int i, rval;
 
-	init_completion(&comp);
 	a.vha = fcport->vha;
 	a.fcport = fcport;
 	a.lun = lun;
-
-	if (flags & (TCF_LUN_RESET|TCF_ABORT_TASK_SET|TCF_CLEAR_TASK_SET|TCF_CLEAR_ACA))
+	if (flags & (TCF_LUN_RESET|TCF_ABORT_TASK_SET|TCF_CLEAR_TASK_SET|TCF_CLEAR_ACA)) {
 		a.modifier = MK_SYNC_ID_LUN;
-	else
+
+		if (qla_get_tmf(fcport))
+			return QLA_FUNCTION_FAILED;
+	} else {
 		a.modifier = MK_SYNC_ID;
+	}
 
 	if (vha->hw->mqenable) {
 		for (i = 0; i < vha->hw->num_qpairs; i++) {
@@ -2188,6 +2237,9 @@ qla2x00_async_tm_cmd(fc_port_t *fcport, uint32_t flags, uint64_t lun,
 	a.flags = flags;
 	rval = __qla2x00_async_tm_cmd(&a);
 
+	if (a.modifier == MK_SYNC_ID_LUN)
+		qla_put_tmf(fcport);
+
 	return rval;
 }
 
@@ -5423,6 +5475,7 @@ qla2x00_alloc_fcport(scsi_qla_host_t *vha, gfp_t flags)
 	INIT_WORK(&fcport->reg_work, qla_register_fcport_fn);
 	INIT_LIST_HEAD(&fcport->gnl_entry);
 	INIT_LIST_HEAD(&fcport->list);
+	INIT_LIST_HEAD(&fcport->tmf_pending);
 
 	INIT_LIST_HEAD(&fcport->sess_cmd_list);
 	spin_lock_init(&fcport->sess_cmd_lock);
-- 
2.39.2



