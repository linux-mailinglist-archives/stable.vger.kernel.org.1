Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3777D7BDEC1
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376412AbjJINWm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376375AbjJINWm (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:22:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE958F
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:22:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26CCCC433C8;
        Mon,  9 Oct 2023 13:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696857760;
        bh=U7ILdv//lsdyCunomtd0+J5yZvFPzmPAMI23d8mE1MQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rZfvHWovnxUGLInXVXz01qwPPUQp74Ak9fHCauCVr7ZUWEhkLLZ9QROIzbY2tfnoo
         52fJs+pzQgWsQ0pTHPVr6xdS3kHb5GZ3F1mw/5MMxoak9PdDEMltsoZMYZiIF55KIk
         7a5uQFtvZnSerw+4daNrHDrUkePZPEbnRPuC7WZQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Bob Pearson <rpearsonhpe@gmail.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Leon Romanovsky <leon@kernel.org>
Subject: [PATCH 6.1 148/162] RDMA/srp: Do not call scsi_done() from srp_abort()
Date:   Mon,  9 Oct 2023 15:02:09 +0200
Message-ID: <20231009130126.999680850@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130122.946357448@linuxfoundation.org>
References: <20231009130122.946357448@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bart Van Assche <bvanassche@acm.org>

commit e193b7955dfad68035b983a0011f4ef3590c85eb upstream.

After scmd_eh_abort_handler() has called the SCSI LLD eh_abort_handler
callback, it performs one of the following actions:
* Call scsi_queue_insert().
* Call scsi_finish_command().
* Call scsi_eh_scmd_add().
Hence, SCSI abort handlers must not call scsi_done(). Otherwise all
the above actions would trigger a use-after-free. Hence remove the
scsi_done() call from srp_abort(). Keep the srp_free_req() call
before returning SUCCESS because we may not see the command again if
SUCCESS is returned.

Cc: Bob Pearson <rpearsonhpe@gmail.com>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Fixes: d8536670916a ("IB/srp: Avoid having aborted requests hang")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Link: https://lore.kernel.org/r/20230823205727.505681-1-bvanassche@acm.org
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/ulp/srp/ib_srp.c |   16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -2789,7 +2789,6 @@ static int srp_abort(struct scsi_cmnd *s
 	u32 tag;
 	u16 ch_idx;
 	struct srp_rdma_ch *ch;
-	int ret;
 
 	shost_printk(KERN_ERR, target->scsi_host, "SRP abort called\n");
 
@@ -2803,19 +2802,14 @@ static int srp_abort(struct scsi_cmnd *s
 	shost_printk(KERN_ERR, target->scsi_host,
 		     "Sending SRP abort for tag %#x\n", tag);
 	if (srp_send_tsk_mgmt(ch, tag, scmnd->device->lun,
-			      SRP_TSK_ABORT_TASK, NULL) == 0)
-		ret = SUCCESS;
-	else if (target->rport->state == SRP_RPORT_LOST)
-		ret = FAST_IO_FAIL;
-	else
-		ret = FAILED;
-	if (ret == SUCCESS) {
+			      SRP_TSK_ABORT_TASK, NULL) == 0) {
 		srp_free_req(ch, req, scmnd, 0);
-		scmnd->result = DID_ABORT << 16;
-		scsi_done(scmnd);
+		return SUCCESS;
 	}
+	if (target->rport->state == SRP_RPORT_LOST)
+		return FAST_IO_FAIL;
 
-	return ret;
+	return FAILED;
 }
 
 static int srp_reset_device(struct scsi_cmnd *scmnd)


