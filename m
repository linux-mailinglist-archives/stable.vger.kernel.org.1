Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D73EC7BCC6F
	for <lists+stable@lfdr.de>; Sun,  8 Oct 2023 07:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344398AbjJHFdc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 8 Oct 2023 01:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344389AbjJHFdb (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 8 Oct 2023 01:33:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B9A3B6
        for <stable@vger.kernel.org>; Sat,  7 Oct 2023 22:33:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67339C433C7;
        Sun,  8 Oct 2023 05:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696743209;
        bh=MYhJM/diTSFtZME+CJyQbO/IUF5oSJDH5d1rWxPKbiE=;
        h=Subject:To:Cc:From:Date:From;
        b=ExQcQmVgEh5YQJqRjbQW0XMwf28oHep3gwwW9cymWlggAWDLCZFN98sgdeLM9EQcI
         ox3QecZYZOAGPGndrisldKB0zNE4L5sxsPOJ9S3DbrrQS3tflvarcG0Y2HphaJs7Ww
         d/nKTneJl12L12iPy2FeHMkgps8QOAhCaU+fiCmU=
Subject: FAILED: patch "[PATCH] RDMA/srp: Do not call scsi_done() from srp_abort()" failed to apply to 4.14-stable tree
To:     bvanassche@acm.org, leon@kernel.org, rpearsonhpe@gmail.com,
        shinichiro.kawasaki@wdc.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 08 Oct 2023 07:33:16 +0200
Message-ID: <2023100815-gratify-carrot-85a6@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
git cherry-pick -x e193b7955dfad68035b983a0011f4ef3590c85eb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023100815-gratify-carrot-85a6@gregkh' --subject-prefix 'PATCH 4.14.y' HEAD^..

Possible dependencies:

e193b7955dfa ("RDMA/srp: Do not call scsi_done() from srp_abort()")
5f9ae9eecb15 ("scsi: ib_srp: Call scsi_done() directly")
ad215aaea4f9 ("RDMA/srp: Make struct scsi_cmnd and struct srp_request adjacent")
7ec2e27a3aff ("RDMA/srp: Fix a recently introduced memory leak")
2b5715fc1738 ("RDMA/srp: Fix support for unpopulated and unbalanced NUMA nodes")
f273ad4f8d90 ("RDMA/srp: Remove support for FMR memory registration")
87fee61c3513 ("RDMA/srp: Make the channel count configurable per target")
547ed331bbe8 ("RDMA/srp: Add parse function for maximum initiator to target IU size")
a163afc88556 ("IB/core: Remove ib_sg_dma_address() and ib_sg_dma_len()")
882981f4a411 ("RDMA/srp: Add support for immediate data")
513d5647116b ("RDMA/srp: Rework handling of the maximum information unit length")
4f6d498c360c ("RDMA/srp: Move srp_rdma_ch.max_ti_iu_len declaration")
482fffc43c03 ("RDMA/srp: Handle large SCSI CDBs correctly")
3023a1e93656 ("RDMA: Start use ib_device_ops")
02a42f8e40ca ("RDMA/rdmavt: Initialize ib_device_ops struct")
521ed0d92ab0 ("RDMA/core: Introduce ib_device_ops")
9af3f5cf9d64 ("RDMA/core: Validate port number in query_pkey verb")
7eebced1bae0 ("RDMA/uverbs: Simplify ib_uverbs_ex_query_device")
9a0738575f26 ("RDMA/uverbs: Use uverbs_response() for remaining response copying")
07f05f40d956 ("RDMA/uverbs: Use uverbs_attr_bundle to pass udata for ioctl()")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e193b7955dfad68035b983a0011f4ef3590c85eb Mon Sep 17 00:00:00 2001
From: Bart Van Assche <bvanassche@acm.org>
Date: Wed, 23 Aug 2023 13:57:27 -0700
Subject: [PATCH] RDMA/srp: Do not call scsi_done() from srp_abort()

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

diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
index 1574218764e0..2916e77f589b 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -2784,7 +2784,6 @@ static int srp_abort(struct scsi_cmnd *scmnd)
 	u32 tag;
 	u16 ch_idx;
 	struct srp_rdma_ch *ch;
-	int ret;
 
 	shost_printk(KERN_ERR, target->scsi_host, "SRP abort called\n");
 
@@ -2798,19 +2797,14 @@ static int srp_abort(struct scsi_cmnd *scmnd)
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

