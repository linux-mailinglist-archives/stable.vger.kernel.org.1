Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D55979F103
	for <lists+stable@lfdr.de>; Wed, 13 Sep 2023 20:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbjIMSUE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 13 Sep 2023 14:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231767AbjIMSUD (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 13 Sep 2023 14:20:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0861A1BC8
        for <stable@vger.kernel.org>; Wed, 13 Sep 2023 11:20:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2636DC433C7;
        Wed, 13 Sep 2023 18:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694629199;
        bh=eTNm0ZDGH5NJAZQQS+k6IWE4PBCq189YoU24xpwJG3c=;
        h=Subject:To:Cc:From:Date:From;
        b=ddUYlsMCZWB0RfVwog814Eom7jvdBYvOe6jSO6+af/BV81BUJV7MkfTFYgju2uuqD
         FfDpTX7spK5db9HOcXTCu36tmMsOfsMVkecUJCNA8HPcdM6ka3TtxPHQN/5+ZZ3Ml2
         S9gN0wcsStxUxW3dSUcctncS429n6c9/Wy7hb/Ig=
Subject: FAILED: patch "[PATCH] scsi: qla2xxx: Fix session hang in gnl" failed to apply to 5.10-stable tree
To:     qutran@marvell.com, himanshu.madhani@oracle.com,
        martin.petersen@oracle.com, njavali@marvell.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Wed, 13 Sep 2023 20:19:54 +0200
Message-ID: <2023091354-fantasize-premiere-2530@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
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
git cherry-pick -x 39d22740712c7563a2e18c08f033deeacdaf66e7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023091354-fantasize-premiere-2530@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

39d22740712c ("scsi: qla2xxx: Fix session hang in gnl")
31e6cdbe0eae ("scsi: qla2xxx: Implement ref count for SRB")
d4523bd6fd5d ("scsi: qla2xxx: Refactor asynchronous command initialization")
2cabf10dbbe3 ("scsi: qla2xxx: Fix hang on NVMe command timeouts")
e3d2612f583b ("scsi: qla2xxx: Fix use after free in debug code")
9efea843a906 ("scsi: qla2xxx: edif: Add detection of secure device")
dd30706e73b7 ("scsi: qla2xxx: edif: Add key update")
fac2807946c1 ("scsi: qla2xxx: edif: Add extraction of auth_els from the wire")
84318a9f01ce ("scsi: qla2xxx: edif: Add send, receive, and accept for auth_els")
7878f22a2e03 ("scsi: qla2xxx: edif: Add getfcinfo and statistic bsgs")
7ebb336e45ef ("scsi: qla2xxx: edif: Add start + stop bsgs")
d94d8158e184 ("scsi: qla2xxx: Add heartbeat check")
f7a0ed479e66 ("scsi: qla2xxx: Fix crash in PCIe error handling")
2ce35c0821af ("scsi: qla2xxx: Fix use after free in bsg")
5777fef788a5 ("scsi: qla2xxx: Consolidate zio threshold setting for both FCP & NVMe")
960204ecca5e ("scsi: qla2xxx: Simplify if statement")
a04658594399 ("scsi: qla2xxx: Wait for ABTS response on I/O timeouts for NVMe")
dbf1f53cfd23 ("scsi: qla2xxx: Implementation to get and manage host, target stats and initiator port")
707531bc2626 ("scsi: qla2xxx: If fcport is undergoing deletion complete I/O with retry")
605e74025f95 ("scsi: qla2xxx: Move sess cmd list/lock to driver")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 39d22740712c7563a2e18c08f033deeacdaf66e7 Mon Sep 17 00:00:00 2001
From: Quinn Tran <qutran@marvell.com>
Date: Fri, 14 Jul 2023 12:31:00 +0530
Subject: [PATCH] scsi: qla2xxx: Fix session hang in gnl

Connection does not resume after a host reset / chip reset. The cause of
the blockage is due to the FCF_ASYNC_ACTIVE left on. The gnl command was
interrupted by the chip reset. On exiting the command, this flag should be
turn off to allow relogin to reoccur. Clear this flag to prevent blockage.

Cc: stable@vger.kernel.org
Fixes: 17e64648aa47 ("scsi: qla2xxx: Correct fcport flags handling")
Signed-off-by: Quinn Tran <qutran@marvell.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
Link: https://lore.kernel.org/r/20230714070104.40052-7-njavali@marvell.com
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>

diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index 1236acb1fd83..7ac4738fda25 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -1141,7 +1141,7 @@ int qla24xx_async_gnl(struct scsi_qla_host *vha, fc_port_t *fcport)
 	u16 *mb;
 
 	if (!vha->flags.online || (fcport->flags & FCF_ASYNC_SENT))
-		return rval;
+		goto done;
 
 	ql_dbg(ql_dbg_disc, vha, 0x20d9,
 	    "Async-gnlist WWPN %8phC \n", fcport->port_name);
@@ -1195,8 +1195,9 @@ int qla24xx_async_gnl(struct scsi_qla_host *vha, fc_port_t *fcport)
 done_free_sp:
 	/* ref: INIT */
 	kref_put(&sp->cmd_kref, qla2x00_sp_release);
+	fcport->flags &= ~(FCF_ASYNC_SENT);
 done:
-	fcport->flags &= ~(FCF_ASYNC_ACTIVE | FCF_ASYNC_SENT);
+	fcport->flags &= ~(FCF_ASYNC_ACTIVE);
 	return rval;
 }
 

