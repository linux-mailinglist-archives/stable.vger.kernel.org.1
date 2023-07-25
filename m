Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2D7761759
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232977AbjGYLrc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232834AbjGYLrT (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:47:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC761BE1
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:47:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6DEE2616A2
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:47:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80990C433C8;
        Tue, 25 Jul 2023 11:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690285631;
        bh=tmJw3cLcouXM2+H+MvX6qdpvxlpeNrOSijpNHCjKdyM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DvOnRF3UNnnYc31Vfh2u4CRQSyFtn9VubAtDXhH2Npo8M/5dgeiWS6mjjumXqHcqB
         TjqrhJGN1I4POkV95IJxp+hcDB7IqIQEsHurUGsbjKt4YbI+0qhJxouL7WBoI36bRF
         BwIkbcaQ+/akb89+1rZ7clWKA20KB8dHJdw1f9EE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Manish Rangankar <mrangankar@marvell.com>,
        Nilesh Javali <njavali@marvell.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 5.4 274/313] scsi: qla2xxx: Remove unused nvme_ls_waitq wait queue
Date:   Tue, 25 Jul 2023 12:47:07 +0200
Message-ID: <20230725104532.919789161@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104521.167250627@linuxfoundation.org>
References: <20230725104521.167250627@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Manish Rangankar <mrangankar@marvell.com>

commit 20fce500b232b970e40312a9c97e7f3b6d7a709c upstream.

System crash when qla2x00_start_sp(sp) returns error code EGAIN and wake_up
gets called for uninitialized wait queue sp->nvme_ls_waitq.

    qla2xxx [0000:37:00.1]-2121:5: Returning existing qpair of ffff8ae2c0513400 for idx=0
    qla2xxx [0000:37:00.1]-700e:5: qla2x00_start_sp failed = 11
    BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
    PGD 0 P4D 0
    Oops: 0000 [#1] SMP NOPTI
    Hardware name: HPE ProLiant DL360 Gen10/ProLiant DL360 Gen10, BIOS U32 09/03/2021
    Workqueue: nvme-wq nvme_fc_connect_ctrl_work [nvme_fc]
    RIP: 0010:__wake_up_common+0x4c/0x190
    RSP: 0018:ffff95f3e0cb7cd0 EFLAGS: 00010086
    RAX: 0000000000000000 RBX: ffff8b08d3b26328 RCX: 0000000000000000
    RDX: 0000000000000001 RSI: 0000000000000003 RDI: ffff8b08d3b26320
    RBP: 0000000000000001 R08: 0000000000000000 R09: ffffffffffffffe8
    R10: 0000000000000000 R11: ffff95f3e0cb7a60 R12: ffff95f3e0cb7d20
    R13: 0000000000000003 R14: 0000000000000000 R15: 0000000000000000
    FS:  0000000000000000(0000) GS:ffff8b2fdf6c0000(0000) knlGS:0000000000000000
    CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
    CR2: 0000000000000000 CR3: 0000002f1e410002 CR4: 00000000007706e0
    DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
    DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
    PKRU: 55555554
    Call Trace:
     __wake_up_common_lock+0x7c/0xc0
     qla_nvme_ls_req+0x355/0x4c0 [qla2xxx]
     ? __nvme_fc_send_ls_req+0x260/0x380 [nvme_fc]
     ? nvme_fc_send_ls_req.constprop.42+0x1a/0x45 [nvme_fc]
     ? nvme_fc_connect_ctrl_work.cold.63+0x1e3/0xa7d [nvme_fc]

Remove unused nvme_ls_waitq wait queue. nvme_ls_waitq logic was removed
previously in the commits tagged Fixed: below.

Fixes: 219d27d7147e ("scsi: qla2xxx: Fix race conditions in the code for aborting SCSI commands")
Fixes: 5621b0dd7453 ("scsi: qla2xxx: Simpify unregistration of FC-NVMe local/remote ports")
Cc: stable@vger.kernel.org
Signed-off-by: Manish Rangankar <mrangankar@marvell.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
Link: https://lore.kernel.org/r/20230615074633.12721-1-njavali@marvell.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/qla2xxx/qla_def.h  |    1 -
 drivers/scsi/qla2xxx/qla_nvme.c |    3 ---
 2 files changed, 4 deletions(-)

--- a/drivers/scsi/qla2xxx/qla_def.h
+++ b/drivers/scsi/qla2xxx/qla_def.h
@@ -593,7 +593,6 @@ typedef struct srb {
 	uint8_t pad[3];
 	struct kref cmd_kref;	/* need to migrate ref_count over to this */
 	void *priv;
-	wait_queue_head_t nvme_ls_waitq;
 	struct fc_port *fcport;
 	struct scsi_qla_host *vha;
 	unsigned int start_timer:1;
--- a/drivers/scsi/qla2xxx/qla_nvme.c
+++ b/drivers/scsi/qla2xxx/qla_nvme.c
@@ -318,7 +318,6 @@ static int qla_nvme_ls_req(struct nvme_f
 	if (rval != QLA_SUCCESS) {
 		ql_log(ql_log_warn, vha, 0x700e,
 		    "qla2x00_start_sp failed = %d\n", rval);
-		wake_up(&sp->nvme_ls_waitq);
 		sp->priv = NULL;
 		priv->sp = NULL;
 		qla2x00_rel_sp(sp);
@@ -563,7 +562,6 @@ static int qla_nvme_post_cmd(struct nvme
 	if (!sp)
 		return -EBUSY;
 
-	init_waitqueue_head(&sp->nvme_ls_waitq);
 	kref_init(&sp->cmd_kref);
 	spin_lock_init(&priv->cmd_lock);
 	sp->priv = (void *)priv;
@@ -581,7 +579,6 @@ static int qla_nvme_post_cmd(struct nvme
 	if (rval != QLA_SUCCESS) {
 		ql_log(ql_log_warn, vha, 0x212d,
 		    "qla2x00_start_nvme_mq failed = %d\n", rval);
-		wake_up(&sp->nvme_ls_waitq);
 		sp->priv = NULL;
 		priv->sp = NULL;
 		qla2xxx_rel_qpair_sp(sp->qpair, sp);


