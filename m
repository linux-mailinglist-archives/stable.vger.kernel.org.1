Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA8C75CA60
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 16:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbjGUOnP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 10:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbjGUOnM (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 10:43:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3009330F4
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 07:43:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 705E561CFD
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 14:43:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84276C433C8;
        Fri, 21 Jul 2023 14:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689950588;
        bh=uYjaJE0C8RmGU4TYIP4zhc6szjxt9KfbsemoWysALjY=;
        h=Subject:To:Cc:From:Date:From;
        b=v4VNF5lHANc4PvaBt2jf++o+tbT7b3vk1CndLsGorQyLk0QJz5Iw+xE1jv700r8Fy
         WLy42uwJyMiEVxSoI79rQyFGn9/LbnCHjOsgaGDkPBy8dsoEyG58anVK3KAIMKs00m
         XS49UXDCqs54J1hPrGOrhjkFtNZjzJiNK0CVoxiw=
Subject: FAILED: patch "[PATCH] scsi: qla2xxx: Avoid fcport pointer dereference" failed to apply to 5.4-stable tree
To:     njavali@marvell.com, himanshu.madhani@oracle.com,
        martin.petersen@oracle.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 21 Jul 2023 16:43:04 +0200
Message-ID: <2023072104-tidiness-facing-d23a@gregkh>
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


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 6b504d06976fe4a61cc05dedc68b84fadb397f77
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023072104-tidiness-facing-d23a@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

6b504d06976f ("scsi: qla2xxx: Avoid fcport pointer dereference")
e0fb8ce2bb9e ("scsi: qla2xxx: edif: Fix potential stuck session in sa update")
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

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6b504d06976fe4a61cc05dedc68b84fadb397f77 Mon Sep 17 00:00:00 2001
From: Nilesh Javali <njavali@marvell.com>
Date: Wed, 7 Jun 2023 17:08:38 +0530
Subject: [PATCH] scsi: qla2xxx: Avoid fcport pointer dereference

Klocwork reported warning of NULL pointer may be dereferenced.  The routine
exits when sa_ctl is NULL and fcport is allocated after the exit call thus
causing NULL fcport pointer to dereference at the time of exit.

To avoid fcport pointer dereference, exit the routine when sa_ctl is NULL.

Cc: stable@vger.kernel.org
Signed-off-by: Nilesh Javali <njavali@marvell.com>
Link: https://lore.kernel.org/r/20230607113843.37185-4-njavali@marvell.com
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>

diff --git a/drivers/scsi/qla2xxx/qla_edif.c b/drivers/scsi/qla2xxx/qla_edif.c
index ec0e20255bd3..26e6b3e3af43 100644
--- a/drivers/scsi/qla2xxx/qla_edif.c
+++ b/drivers/scsi/qla2xxx/qla_edif.c
@@ -2361,8 +2361,8 @@ qla24xx_issue_sa_replace_iocb(scsi_qla_host_t *vha, struct qla_work_evt *e)
 	if (!sa_ctl) {
 		ql_dbg(ql_dbg_edif, vha, 0x70e6,
 		    "sa_ctl allocation failed\n");
-		rval =  -ENOMEM;
-		goto done;
+		rval = -ENOMEM;
+		return rval;
 	}
 
 	fcport = sa_ctl->fcport;

