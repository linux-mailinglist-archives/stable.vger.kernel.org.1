Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE127A3CC7
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241129AbjIQUfP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241167AbjIQUe6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:34:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E5BF101
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:34:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FB9CC433C8;
        Sun, 17 Sep 2023 20:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694982892;
        bh=13d3T8o65GmvANpixzQAT767nXrHOwa8U/IMG4ffiD8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b66DqSy8NCuMEPMAvTQZyixUxWr6Ekr1wPqAtOT6g9rkGG0AB/rXceQATG3E6Fx67
         /ntm+Tt/lPI3bJ4vn6PEjcjRlfMwffw+kioQonJKyapvet4R+opFCxh/zIFVVooh7i
         NjDwgVpOWHT+9JZ8GItXP7YueFyHvHP2BmwEVhOU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Quinn Tran <qutran@marvell.com>,
        Nilesh Javali <njavali@marvell.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 5.15 384/511] scsi: qla2xxx: Fix TMF leak through
Date:   Sun, 17 Sep 2023 21:13:31 +0200
Message-ID: <20230917191123.071226865@linuxfoundation.org>
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

From: Quinn Tran <qutran@marvell.com>

commit 5d3148d8e8b05f084e607ac3bd55a4c317a9f934 upstream.

Task management can retry up to 5 times when FW resource becomes bottle
neck. Between the retries, there is a short sleep.  Current code assumes
the chip has not reset or session has not changed.

Check for chip reset or session change before sending Task management.

Cc: stable@vger.kernel.org
Fixes: 9803fb5d2759 ("scsi: qla2xxx: Fix task management cmd failure")
Signed-off-by: Quinn Tran <qutran@marvell.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
Link: https://lore.kernel.org/r/20230714070104.40052-9-njavali@marvell.com
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/qla2xxx/qla_init.c |   20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -2040,10 +2040,14 @@ static void qla_marker_sp_done(srb_t *sp
 	complete(&tmf->u.tmf.comp);
 }
 
-#define  START_SP_W_RETRIES(_sp, _rval) \
+#define  START_SP_W_RETRIES(_sp, _rval, _chip_gen, _login_gen) \
 {\
 	int cnt = 5; \
 	do { \
+		if (_chip_gen != sp->vha->hw->chip_reset || _login_gen != sp->fcport->login_gen) {\
+			_rval = EINVAL; \
+			break; \
+		} \
 		_rval = qla2x00_start_sp(_sp); \
 		if (_rval == EAGAIN) \
 			msleep(1); \
@@ -2066,6 +2070,7 @@ qla26xx_marker(struct tmf_arg *arg)
 	srb_t *sp;
 	int rval = QLA_FUNCTION_FAILED;
 	fc_port_t *fcport = arg->fcport;
+	u32 chip_gen, login_gen;
 
 	if (TMF_NOT_READY(arg->fcport)) {
 		ql_dbg(ql_dbg_taskm, vha, 0x8039,
@@ -2075,6 +2080,9 @@ qla26xx_marker(struct tmf_arg *arg)
 		return QLA_SUSPENDED;
 	}
 
+	chip_gen = vha->hw->chip_reset;
+	login_gen = fcport->login_gen;
+
 	/* ref: INIT */
 	sp = qla2xxx_get_qpair_sp(vha, arg->qpair, fcport, GFP_KERNEL);
 	if (!sp)
@@ -2092,7 +2100,7 @@ qla26xx_marker(struct tmf_arg *arg)
 	tm_iocb->u.tmf.loop_id = fcport->loop_id;
 	tm_iocb->u.tmf.vp_index = vha->vp_idx;
 
-	START_SP_W_RETRIES(sp, rval);
+	START_SP_W_RETRIES(sp, rval, chip_gen, login_gen);
 
 	ql_dbg(ql_dbg_taskm, vha, 0x8006,
 	    "Async-marker hdl=%x loop-id=%x portid=%06x modifier=%x lun=%lld qp=%d rval %d.\n",
@@ -2161,6 +2169,9 @@ __qla2x00_async_tm_cmd(struct tmf_arg *a
 		return QLA_SUSPENDED;
 	}
 
+	chip_gen = vha->hw->chip_reset;
+	login_gen = fcport->login_gen;
+
 	/* ref: INIT */
 	sp = qla2xxx_get_qpair_sp(vha, arg->qpair, fcport, GFP_KERNEL);
 	if (!sp)
@@ -2178,7 +2189,7 @@ __qla2x00_async_tm_cmd(struct tmf_arg *a
 	tm_iocb->u.tmf.flags = arg->flags;
 	tm_iocb->u.tmf.lun = arg->lun;
 
-	START_SP_W_RETRIES(sp, rval);
+	START_SP_W_RETRIES(sp, rval, chip_gen, login_gen);
 
 	ql_dbg(ql_dbg_taskm, vha, 0x802f,
 	    "Async-tmf hdl=%x loop-id=%x portid=%06x ctrl=%x lun=%lld qp=%d rval=%x.\n",
@@ -2197,9 +2208,6 @@ __qla2x00_async_tm_cmd(struct tmf_arg *a
 	}
 
 	if (!test_bit(UNLOADING, &vha->dpc_flags) && !IS_QLAFX00(vha->hw)) {
-		chip_gen = vha->hw->chip_reset;
-		login_gen = fcport->login_gen;
-
 		jif = jiffies;
 		if (qla_tmf_wait(arg)) {
 			ql_log(ql_log_info, vha, 0x803e,


