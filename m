Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32D7275CA4B
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 16:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbjGUOmH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 10:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231613AbjGUOly (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 10:41:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9E6430C7
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 07:41:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3380A61CB8
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 14:41:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4013CC433C8;
        Fri, 21 Jul 2023 14:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689950511;
        bh=QTqsWy4dq1+7LFjJ/nHQb4V2R0Muvf5sC4jAhwKol/U=;
        h=Subject:To:Cc:From:Date:From;
        b=yS1wLETf5rcdHzoy+Ck0jd3zJuzpvcMW7Bvi2BhRrKEc6e5X9TgCcd/utuQK4H2VC
         F9PB7M3Z+yrOAVdXUAAlKJ5mZOwoxOap/6cEb9ak858IiuD8hS/UPJcCiF6SY2SFl4
         QHkbw/ozb2yZxe0+lh3TNdAceOS1f9v7402uRd2E=
Subject: FAILED: patch "[PATCH] scsi: qla2xxx: Fix task management cmd fail due to" failed to apply to 4.14-stable tree
To:     qutran@marvell.com, himanshu.madhani@oracle.com, lkp@intel.com,
        martin.petersen@oracle.com, njavali@marvell.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 21 Jul 2023 16:41:37 +0200
Message-ID: <2023072137-fit-armless-e4a1@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
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


The patch below does not apply to the 4.14-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.14.y
git checkout FETCH_HEAD
git cherry-pick -x 6a87679626b51b53fbb6be417ad8eb083030b617
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023072137-fit-armless-e4a1@gregkh' --subject-prefix 'PATCH 4.14.y' HEAD^..

Possible dependencies:

6a87679626b5 ("scsi: qla2xxx: Fix task management cmd fail due to unavailable resource")
9803fb5d2759 ("scsi: qla2xxx: Fix task management cmd failure")
d90171dd0da5 ("scsi: qla2xxx: Multi-que support for TMF")
5f63a163ed2f ("scsi: qla2xxx: Fix exchange oversubscription for management commands")
41e5afe51f75 ("scsi: qla2xxx: Fix exchange oversubscription")
68ad83188d78 ("scsi: qla2xxx: Fix crash when I/O abort times out")
1b80addaae09 ("scsi: qla2xxx: Remove unused declarations for qla2xxx")
63ab6cb582fa ("scsi: qla2xxx: edif: Fix I/O timeout due to over-subscription")
31e6cdbe0eae ("scsi: qla2xxx: Implement ref count for SRB")
d4523bd6fd5d ("scsi: qla2xxx: Refactor asynchronous command initialization")
2cabf10dbbe3 ("scsi: qla2xxx: Fix hang on NVMe command timeouts")
e3d2612f583b ("scsi: qla2xxx: Fix use after free in debug code")
44d018577f17 ("scsi: qla2xxx: edif: Add encryption to I/O path")
7a09e8d92c6d ("scsi: qla2xxx: edif: Add doorbell notification for app")
9efea843a906 ("scsi: qla2xxx: edif: Add detection of secure device")
dd30706e73b7 ("scsi: qla2xxx: edif: Add key update")
fac2807946c1 ("scsi: qla2xxx: edif: Add extraction of auth_els from the wire")
84318a9f01ce ("scsi: qla2xxx: edif: Add send, receive, and accept for auth_els")
7878f22a2e03 ("scsi: qla2xxx: edif: Add getfcinfo and statistic bsgs")
7ebb336e45ef ("scsi: qla2xxx: edif: Add start + stop bsgs")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6a87679626b51b53fbb6be417ad8eb083030b617 Mon Sep 17 00:00:00 2001
From: Quinn Tran <qutran@marvell.com>
Date: Fri, 28 Apr 2023 00:53:35 -0700
Subject: [PATCH] scsi: qla2xxx: Fix task management cmd fail due to
 unavailable resource

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

diff --git a/drivers/scsi/qla2xxx/qla_def.h b/drivers/scsi/qla2xxx/qla_def.h
index 02287205ca2e..e345ccbff807 100644
--- a/drivers/scsi/qla2xxx/qla_def.h
+++ b/drivers/scsi/qla2xxx/qla_def.h
@@ -2542,6 +2542,7 @@ enum rscn_addr_format {
 typedef struct fc_port {
 	struct list_head list;
 	struct scsi_qla_host *vha;
+	struct list_head tmf_pending;
 
 	unsigned int conf_compl_supported:1;
 	unsigned int deleted:2;
@@ -2562,6 +2563,8 @@ typedef struct fc_port {
 	unsigned int do_prli_nvme:1;
 
 	uint8_t nvme_flag;
+	uint8_t active_tmf;
+#define MAX_ACTIVE_TMF 8
 
 	uint8_t node_name[WWN_SIZE];
 	uint8_t port_name[WWN_SIZE];
diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index bc4600bd5765..84841edcd1b5 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -2149,6 +2149,54 @@ __qla2x00_async_tm_cmd(struct tmf_arg *arg)
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
@@ -2156,18 +2204,19 @@ qla2x00_async_tm_cmd(fc_port_t *fcport, uint32_t flags, uint64_t lun,
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
@@ -2186,6 +2235,9 @@ qla2x00_async_tm_cmd(fc_port_t *fcport, uint32_t flags, uint64_t lun,
 	a.flags = flags;
 	rval = __qla2x00_async_tm_cmd(&a);
 
+	if (a.modifier == MK_SYNC_ID_LUN)
+		qla_put_tmf(fcport);
+
 	return rval;
 }
 
@@ -5400,6 +5452,7 @@ qla2x00_alloc_fcport(scsi_qla_host_t *vha, gfp_t flags)
 	INIT_WORK(&fcport->reg_work, qla_register_fcport_fn);
 	INIT_LIST_HEAD(&fcport->gnl_entry);
 	INIT_LIST_HEAD(&fcport->list);
+	INIT_LIST_HEAD(&fcport->tmf_pending);
 
 	INIT_LIST_HEAD(&fcport->sess_cmd_list);
 	spin_lock_init(&fcport->sess_cmd_lock);

