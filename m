Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 672317F173E
	for <lists+stable@lfdr.de>; Mon, 20 Nov 2023 16:27:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233166AbjKTP1l (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 20 Nov 2023 10:27:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233237AbjKTP1k (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 20 Nov 2023 10:27:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E073CF
        for <stable@vger.kernel.org>; Mon, 20 Nov 2023 07:27:37 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66383C433C8;
        Mon, 20 Nov 2023 15:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700494056;
        bh=r/WxJgNQ+zyyM6iWHhqGwkPia4lJTAJWNXwRcJ9Zq5Q=;
        h=Subject:To:Cc:From:Date:From;
        b=nGM+O+FC54NB6vLVxe4leOgZTbFOUy49EWw9kFJMrDU42EB/utaFcmFp28AoPgt0K
         wVSJQ/pe56RAB+Fy9dz2Y7xgwohcMMJMt1zBrPZtH8nhVpTE85bZzUmGDVBG76yPtI
         OxUdwE9L4C3QjWEBpaMtX2YR5PUgHeOQdf03SGNM=
Subject: FAILED: patch "[PATCH] scsi: qla2xxx: Fix system crash due to bad pointer access" failed to apply to 5.10-stable tree
To:     qutran@marvell.com, martin.petersen@oracle.com, njavali@marvell.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Mon, 20 Nov 2023 16:27:33 +0100
Message-ID: <2023112033-sandworm-defrost-b47d@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 19597cad64d608aa8ac2f8aef50a50187a565223
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023112033-sandworm-defrost-b47d@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

19597cad64d6 ("scsi: qla2xxx: Fix system crash due to bad pointer access")
c7d6b2c2cd56 ("scsi: qla2xxx: Use scsi_cmd_to_rq() instead of scsi_cmnd.request")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 19597cad64d608aa8ac2f8aef50a50187a565223 Mon Sep 17 00:00:00 2001
From: Quinn Tran <qutran@marvell.com>
Date: Mon, 30 Oct 2023 12:19:12 +0530
Subject: [PATCH] scsi: qla2xxx: Fix system crash due to bad pointer access

User experiences system crash when running AER error injection.  The
perturbation causes the abort-all-I/O path to trigger. The driver assumes
all I/O on this path is FCP only. If there is both NVMe & FCP traffic, a
system crash happens. Add additional check to see if I/O is FCP or not
before access.

PID: 999019  TASK: ff35d769f24722c0  CPU: 53  COMMAND: "kworker/53:1"
 0 [ff3f78b964847b58] machine_kexec at ffffffffae86973d
 1 [ff3f78b964847ba8] __crash_kexec at ffffffffae9be29d
 2 [ff3f78b964847c70] crash_kexec at ffffffffae9bf528
 3 [ff3f78b964847c78] oops_end at ffffffffae8282ab
 4 [ff3f78b964847c98] exc_page_fault at ffffffffaf2da502
 5 [ff3f78b964847cc0] asm_exc_page_fault at ffffffffaf400b62
   [exception RIP: qla2x00_abort_srb+444]
   RIP: ffffffffc07b5f8c  RSP: ff3f78b964847d78  RFLAGS: 00010046
   RAX: 0000000000000282  RBX: ff35d74a0195a200  RCX: ff35d76886fd03a0
   RDX: 0000000000000001  RSI: ffffffffc07c5ec8  RDI: ff35d74a0195a200
   RBP: ff35d76913d22080   R8: ff35d7694d103200   R9: ff35d7694d103200
   R10: 0000000100000000  R11: ffffffffb05d6630  R12: 0000000000010000
   R13: ff3f78b964847df8  R14: ff35d768d8754000  R15: ff35d768877248e0
   ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
 6 [ff3f78b964847d70] qla2x00_abort_srb at ffffffffc07b5f84 [qla2xxx]
 7 [ff3f78b964847de0] __qla2x00_abort_all_cmds at ffffffffc07b6238 [qla2xxx]
 8 [ff3f78b964847e38] qla2x00_abort_all_cmds at ffffffffc07ba635 [qla2xxx]
 9 [ff3f78b964847e58] qla2x00_terminate_rport_io at ffffffffc08145eb [qla2xxx]
10 [ff3f78b964847e70] fc_terminate_rport_io at ffffffffc045987e [scsi_transport_fc]
11 [ff3f78b964847e88] process_one_work at ffffffffae914f15
12 [ff3f78b964847ed0] worker_thread at ffffffffae9154c0
13 [ff3f78b964847f10] kthread at ffffffffae91c456
14 [ff3f78b964847f50] ret_from_fork at ffffffffae8036ef

Cc: stable@vger.kernel.org
Fixes: f45bca8c5052 ("scsi: qla2xxx: Fix double scsi_done for abort path")
Signed-off-by: Quinn Tran <qutran@marvell.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
Link: https://lore.kernel.org/r/20231030064912.37912-1-njavali@marvell.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>

diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index 7e103d711825..d24410944f7d 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -1837,8 +1837,16 @@ static void qla2x00_abort_srb(struct qla_qpair *qp, srb_t *sp, const int res,
 		}
 
 		spin_lock_irqsave(qp->qp_lock_ptr, *flags);
-		if (ret_cmd && blk_mq_request_started(scsi_cmd_to_rq(cmd)))
-			sp->done(sp, res);
+		switch (sp->type) {
+		case SRB_SCSI_CMD:
+			if (ret_cmd && blk_mq_request_started(scsi_cmd_to_rq(cmd)))
+				sp->done(sp, res);
+			break;
+		default:
+			if (ret_cmd)
+				sp->done(sp, res);
+			break;
+		}
 	} else {
 		sp->done(sp, res);
 	}

