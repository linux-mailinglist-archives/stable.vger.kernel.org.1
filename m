Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94A697A389D
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239870AbjIQTiI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238594AbjIQThi (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:37:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22BA4D9
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:37:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56052C433C7;
        Sun, 17 Sep 2023 19:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694979451;
        bh=ajlvjBe5WGgFPe8O1LlDjIuXGBY35emAclw2ZOV4Buw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CX/AOgnhvoneQ3B2rlW4THez6qycG/yOaWtuaXKlLDS7vwg39lWybMA7A7/ncwasz
         c2GkUCjgRJdcJ9R+HNFFBJ2XfmBDOY3rPhNrrbq/76X605S/Y5swc3jKOkDg17mhX/
         CEURR9SXdQI8r6BEGrhpsM2Q7Fm+ewR0SaJdwEmA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Quinn Tran <qutran@marvell.com>,
        Nilesh Javali <njavali@marvell.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 5.10 317/406] scsi: qla2xxx: Fix deletion race condition
Date:   Sun, 17 Sep 2023 21:12:51 +0200
Message-ID: <20230917191109.669385612@linuxfoundation.org>
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

commit 6dfe4344c168c6ca20fe7640649aacfcefcccb26 upstream.

System crash when using debug kernel due to link list corruption. The cause
of the link list corruption is due to session deletion was allowed to queue
up twice.  Here's the internal trace that show the same port was allowed to
double queue for deletion on different cpu.

20808683956 015 qla2xxx [0000:13:00.1]-e801:4: Scheduling sess ffff93ebf9306800 for deletion 50:06:0e:80:12:48:ff:50 fc4_type 1
20808683957 027 qla2xxx [0000:13:00.1]-e801:4: Scheduling sess ffff93ebf9306800 for deletion 50:06:0e:80:12:48:ff:50 fc4_type 1

Move the clearing/setting of deleted flag lock.

Cc: stable@vger.kernel.org
Fixes: 726b85487067 ("qla2xxx: Add framework for async fabric discovery")
Signed-off-by: Quinn Tran <qutran@marvell.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
Link: https://lore.kernel.org/r/20230714070104.40052-2-njavali@marvell.com
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/qla2xxx/qla_init.c   |   16 ++++++++++++++--
 drivers/scsi/qla2xxx/qla_target.c |   14 +++++++-------
 2 files changed, 21 insertions(+), 9 deletions(-)

--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -483,6 +483,7 @@ static
 void qla24xx_handle_adisc_event(scsi_qla_host_t *vha, struct event_arg *ea)
 {
 	struct fc_port *fcport = ea->fcport;
+	unsigned long flags;
 
 	ql_dbg(ql_dbg_disc, vha, 0x20d2,
 	    "%s %8phC DS %d LS %d rc %d login %d|%d rscn %d|%d lid %d\n",
@@ -497,9 +498,15 @@ void qla24xx_handle_adisc_event(scsi_qla
 		ql_dbg(ql_dbg_disc, vha, 0x2066,
 		    "%s %8phC: adisc fail: post delete\n",
 		    __func__, ea->fcport->port_name);
+
+		spin_lock_irqsave(&vha->work_lock, flags);
 		/* deleted = 0 & logout_on_delete = force fw cleanup */
-		fcport->deleted = 0;
+		if (fcport->deleted == QLA_SESS_DELETED)
+			fcport->deleted = 0;
+
 		fcport->logout_on_delete = 1;
+		spin_unlock_irqrestore(&vha->work_lock, flags);
+
 		qlt_schedule_sess_for_deletion(ea->fcport);
 		return;
 	}
@@ -1405,7 +1412,6 @@ void __qla24xx_handle_gpdb_event(scsi_ql
 
 	spin_lock_irqsave(&vha->hw->tgt.sess_lock, flags);
 	ea->fcport->login_gen++;
-	ea->fcport->deleted = 0;
 	ea->fcport->logout_on_delete = 1;
 
 	if (!ea->fcport->login_succ && !IS_SW_RESV_ADDR(ea->fcport->d_id)) {
@@ -5639,6 +5645,8 @@ qla2x00_reg_remote_port(scsi_qla_host_t
 void
 qla2x00_update_fcport(scsi_qla_host_t *vha, fc_port_t *fcport)
 {
+	unsigned long flags;
+
 	if (IS_SW_RESV_ADDR(fcport->d_id))
 		return;
 
@@ -5648,7 +5656,11 @@ qla2x00_update_fcport(scsi_qla_host_t *v
 	qla2x00_set_fcport_disc_state(fcport, DSC_UPD_FCPORT);
 	fcport->login_retry = vha->hw->login_retry_count;
 	fcport->flags &= ~(FCF_LOGIN_NEEDED | FCF_ASYNC_SENT);
+
+	spin_lock_irqsave(&vha->work_lock, flags);
 	fcport->deleted = 0;
+	spin_unlock_irqrestore(&vha->work_lock, flags);
+
 	if (vha->hw->current_topology == ISP_CFG_NL)
 		fcport->logout_on_delete = 0;
 	else
--- a/drivers/scsi/qla2xxx/qla_target.c
+++ b/drivers/scsi/qla2xxx/qla_target.c
@@ -1044,10 +1044,6 @@ void qlt_free_session_done(struct work_s
 			(struct imm_ntfy_from_isp *)sess->iocb, SRB_NACK_LOGO);
 	}
 
-	spin_lock_irqsave(&vha->work_lock, flags);
-	sess->flags &= ~FCF_ASYNC_SENT;
-	spin_unlock_irqrestore(&vha->work_lock, flags);
-
 	spin_lock_irqsave(&ha->tgt.sess_lock, flags);
 	if (sess->se_sess) {
 		sess->se_sess = NULL;
@@ -1057,7 +1053,6 @@ void qlt_free_session_done(struct work_s
 
 	qla2x00_set_fcport_disc_state(sess, DSC_DELETED);
 	sess->fw_login_state = DSC_LS_PORT_UNAVAIL;
-	sess->deleted = QLA_SESS_DELETED;
 
 	if (sess->login_succ && !IS_SW_RESV_ADDR(sess->d_id)) {
 		vha->fcport_count--;
@@ -1109,10 +1104,15 @@ void qlt_free_session_done(struct work_s
 
 	sess->explicit_logout = 0;
 	spin_unlock_irqrestore(&ha->tgt.sess_lock, flags);
-	sess->free_pending = 0;
 
 	qla2x00_dfs_remove_rport(vha, sess);
 
+	spin_lock_irqsave(&vha->work_lock, flags);
+	sess->flags &= ~FCF_ASYNC_SENT;
+	sess->deleted = QLA_SESS_DELETED;
+	sess->free_pending = 0;
+	spin_unlock_irqrestore(&vha->work_lock, flags);
+
 	ql_dbg(ql_dbg_disc, vha, 0xf001,
 	    "Unregistration of sess %p %8phC finished fcp_cnt %d\n",
 		sess, sess->port_name, vha->fcport_count);
@@ -1161,12 +1161,12 @@ void qlt_unreg_sess(struct fc_port *sess
 	 * management from being sent.
 	 */
 	sess->flags |= FCF_ASYNC_SENT;
+	sess->deleted = QLA_SESS_DELETION_IN_PROGRESS;
 	spin_unlock_irqrestore(&sess->vha->work_lock, flags);
 
 	if (sess->se_sess)
 		vha->hw->tgt.tgt_ops->clear_nacl_from_fcport_map(sess);
 
-	sess->deleted = QLA_SESS_DELETION_IN_PROGRESS;
 	qla2x00_set_fcport_disc_state(sess, DSC_DELETE_PEND);
 	sess->last_rscn_gen = sess->rscn_gen;
 	sess->last_login_gen = sess->login_gen;


