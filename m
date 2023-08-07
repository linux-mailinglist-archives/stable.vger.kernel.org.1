Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2153E771AD0
	for <lists+stable@lfdr.de>; Mon,  7 Aug 2023 08:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbjHGGyF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 7 Aug 2023 02:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231432AbjHGGx5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 7 Aug 2023 02:53:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF872105
        for <stable@vger.kernel.org>; Sun,  6 Aug 2023 23:53:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5550661547
        for <stable@vger.kernel.org>; Mon,  7 Aug 2023 06:53:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BEB8C433C8;
        Mon,  7 Aug 2023 06:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691391200;
        bh=BHgst8JXRYpPT0txlKxBFo1PIpQ6oIxifxENXK4kn4M=;
        h=Subject:To:Cc:From:Date:From;
        b=Jin0xDLqmgcD+6nHS5bUJ3OyjgWv4SHia+sU08336qISTMmFYr070y+JdPF+81yfa
         +qJkHtfq/FuZ8qtK/HOYs0wm5aM8RDEOAouXkRPOgMWqll++xBCdCG2vrHSnmir1Z4
         Ag7Kdof93z1OgMIHK1Nr3MS4hNlXDdHc9a02bjzI=
Subject: FAILED: patch "[PATCH] scsi: zfcp: Defer fc_rport blocking until after ADISC" failed to apply to 4.14-stable tree
To:     maier@linux.ibm.com, bblock@linux.ibm.com, loshakov@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Mon, 07 Aug 2023 08:53:17 +0200
Message-ID: <2023080717-repair-pessimism-cb11@gregkh>
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
git cherry-pick -x e65851989001c0c9ba9177564b13b38201c0854c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023080717-repair-pessimism-cb11@gregkh' --subject-prefix 'PATCH 4.14.y' HEAD^..

Possible dependencies:

e65851989001 ("scsi: zfcp: Defer fc_rport blocking until after ADISC response")
8c9db6679be4 ("scsi: zfcp: Fix failed recovery on gone remote port with non-NPIV FCP devices")
5c750d58e9d7 ("scsi: zfcp: workqueue: set description for port work items with their WWPN as context")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e65851989001c0c9ba9177564b13b38201c0854c Mon Sep 17 00:00:00 2001
From: Steffen Maier <maier@linux.ibm.com>
Date: Mon, 24 Jul 2023 16:51:56 +0200
Subject: [PATCH] scsi: zfcp: Defer fc_rport blocking until after ADISC
 response

Storage devices are free to send RSCNs, e.g. for internal state changes. If
this happens on all connected paths, zfcp risks temporarily losing all
paths at the same time. This has strong requirements on multipath
configuration such as "no_path_retry queue".

Avoid such situations by deferring fc_rport blocking until after the ADISC
response, when any actual state change of the remote port became clear.
The already existing port recovery triggers explicitly block the fc_rport.
The triggers are: on ADISC reject or timeout (typical cable pull case), and
on ADISC indicating that the remote port has changed its WWPN or
the port is meanwhile no longer open.

As a side effect, this also removes a confusing direct function call to
another work item function zfcp_scsi_rport_work() instead of scheduling
that other work item. It was probably done that way to have the rport block
side effect immediate and synchronous to the caller.

Fixes: a2fa0aede07c ("[SCSI] zfcp: Block FC transport rports early on errors")
Cc: stable@vger.kernel.org #v2.6.30+
Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
Reviewed-by: Fedor Loshakov <loshakov@linux.ibm.com>
Signed-off-by: Steffen Maier <maier@linux.ibm.com>
Link: https://lore.kernel.org/r/20230724145156.3920244-1-maier@linux.ibm.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>

diff --git a/drivers/s390/scsi/zfcp_fc.c b/drivers/s390/scsi/zfcp_fc.c
index f21307537829..4f0d0e55f0d4 100644
--- a/drivers/s390/scsi/zfcp_fc.c
+++ b/drivers/s390/scsi/zfcp_fc.c
@@ -534,8 +534,7 @@ static void zfcp_fc_adisc_handler(void *data)
 
 	/* re-init to undo drop from zfcp_fc_adisc() */
 	port->d_id = ntoh24(adisc_resp->adisc_port_id);
-	/* port is good, unblock rport without going through erp */
-	zfcp_scsi_schedule_rport_register(port);
+	/* port is still good, nothing to do */
  out:
 	atomic_andnot(ZFCP_STATUS_PORT_LINK_TEST, &port->status);
 	put_device(&port->dev);
@@ -595,9 +594,6 @@ void zfcp_fc_link_test_work(struct work_struct *work)
 	int retval;
 
 	set_worker_desc("zadisc%16llx", port->wwpn); /* < WORKER_DESC_LEN=24 */
-	get_device(&port->dev);
-	port->rport_task = RPORT_DEL;
-	zfcp_scsi_rport_work(&port->rport_work);
 
 	/* only issue one test command at one time per port */
 	if (atomic_read(&port->status) & ZFCP_STATUS_PORT_LINK_TEST)

