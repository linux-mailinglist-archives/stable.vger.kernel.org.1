Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63FFD75BF40
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 09:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbjGUHEO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 03:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjGUHEN (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 03:04:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39CA7270E
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 00:04:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 884A961335
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 07:04:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E538C433C8;
        Fri, 21 Jul 2023 07:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689923050;
        bh=BtLWx8syO8H1cuVYBd6oFgux5eekOskZ2Anm2Ks6B6E=;
        h=Subject:To:Cc:From:Date:From;
        b=LGOCsFudlQXgiyZGLDBWSyDCKSUpfDo/mkDrOArwEpTAr8W7Y55x5YUemySW2dRZ7
         xPU97SGWKCrifiHUV0khBCYSccjJSn6ut5D/eYyylvZrMpEf6oRVMGUufRnVKQdXCK
         r41hXlFxpcz5Ed+895RW2eT2hVuhaO4rcvhcMf98=
Subject: FAILED: patch "[PATCH] fs: dlm: make F_SETLK use unkillable wait_event" failed to apply to 5.10-stable tree
To:     aahringo@redhat.com, teigland@redhat.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 21 Jul 2023 09:04:05 +0200
Message-ID: <2023072105-unsmooth-laboring-3769@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
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


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 0f2b1cb89ccdbdcedf7143f4153a4da700a05f48
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023072105-unsmooth-laboring-3769@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

0f2b1cb89ccd ("fs: dlm: make F_SETLK use unkillable wait_event")
59e45c758ca1 ("fs: dlm: interrupt posix locks only when process is killed")
c847f4e20304 ("fs: dlm: fix cleanup pending ops when interrupted")
b92a4e3f86b1 ("fs: dlm: change posix lock sigint handling")
4d413ae9ced4 ("fs: dlm: use dlm_plock_info for do_unlock_close")
ea06d4cabf52 ("fs: dlm: change plock interrupted message to debug again")
19d7ca051d30 ("fs: dlm: add pid to debug log")
dc1acd5c9469 ("dlm: replace usage of found with dedicated list iterator variable")
bcfad4265ced ("dlm: improve plock logging if interrupted")
a800ba77fd28 ("dlm: rearrange async condition return")
bcbb4ba6c9ba ("dlm: cleanup plock_op vs plock_xop")
a559790caa1c ("dlm: replace sanity checks with WARN_ON")
42252d0d2aa9 ("dlm: fix plock invalid read")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0f2b1cb89ccdbdcedf7143f4153a4da700a05f48 Mon Sep 17 00:00:00 2001
From: Alexander Aring <aahringo@redhat.com>
Date: Fri, 19 May 2023 11:21:27 -0400
Subject: [PATCH] fs: dlm: make F_SETLK use unkillable wait_event

While a non-waiting posix lock request (F_SETLK) is waiting for
user space processing (in dlm_controld), wait for that processing
to complete with an unkillable wait_event(). This makes F_SETLK
behave the same way for F_RDLCK, F_WRLCK and F_UNLCK. F_SETLKW
continues to use wait_event_killable().

Cc: stable@vger.kernel.org
Signed-off-by: Alexander Aring <aahringo@redhat.com>
Signed-off-by: David Teigland <teigland@redhat.com>

diff --git a/fs/dlm/plock.c b/fs/dlm/plock.c
index 31bc601ee3d8..c9e1d5f54194 100644
--- a/fs/dlm/plock.c
+++ b/fs/dlm/plock.c
@@ -155,25 +155,29 @@ int dlm_posix_lock(dlm_lockspace_t *lockspace, u64 number, struct file *file,
 
 	send_op(op);
 
-	rv = wait_event_killable(recv_wq, (op->done != 0));
-	if (rv == -ERESTARTSYS) {
-		spin_lock(&ops_lock);
-		/* recheck under ops_lock if we got a done != 0,
-		 * if so this interrupt case should be ignored
-		 */
-		if (op->done != 0) {
+	if (op->info.wait) {
+		rv = wait_event_killable(recv_wq, (op->done != 0));
+		if (rv == -ERESTARTSYS) {
+			spin_lock(&ops_lock);
+			/* recheck under ops_lock if we got a done != 0,
+			 * if so this interrupt case should be ignored
+			 */
+			if (op->done != 0) {
+				spin_unlock(&ops_lock);
+				goto do_lock_wait;
+			}
+			list_del(&op->list);
 			spin_unlock(&ops_lock);
-			goto do_lock_wait;
-		}
-		list_del(&op->list);
-		spin_unlock(&ops_lock);
 
-		log_debug(ls, "%s: wait interrupted %x %llx pid %d",
-			  __func__, ls->ls_global_id,
-			  (unsigned long long)number, op->info.pid);
-		do_unlock_close(&op->info);
-		dlm_release_plock_op(op);
-		goto out;
+			log_debug(ls, "%s: wait interrupted %x %llx pid %d",
+				  __func__, ls->ls_global_id,
+				  (unsigned long long)number, op->info.pid);
+			do_unlock_close(&op->info);
+			dlm_release_plock_op(op);
+			goto out;
+		}
+	} else {
+		wait_event(recv_wq, (op->done != 0));
 	}
 
 do_lock_wait:

