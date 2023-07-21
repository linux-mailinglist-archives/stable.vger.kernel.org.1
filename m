Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32ECA75BF44
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 09:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjGUHEa (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 03:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbjGUHE3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 03:04:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 357E8270B
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 00:04:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD19361059
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 07:04:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A501BC433C8;
        Fri, 21 Jul 2023 07:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689923067;
        bh=z06YZxR5JtbdAS9zkzqQthN9PRlVKM0Zrv1ElqwdFhc=;
        h=Subject:To:Cc:From:Date:From;
        b=fhUcysXzY8CXIkSVeYia8bQeGlOiVnX8GVELKxd2ENkcYHDdWWl8gcADb1CF6q1px
         1w0SE3LuumANoTGwpOsflLbD43Jg6i6iPxyVENSSpK1PKZy0+JsJ1sZFCznn7omP5e
         gsgW2wXgRyMhIcvEHAT0FwJxqjgBA4aRABFHYWs8=
Subject: FAILED: patch "[PATCH] fs: dlm: fix mismatch of plock results from userspace" failed to apply to 5.15-stable tree
To:     aahringo@redhat.com, teigland@redhat.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 21 Jul 2023 09:04:24 +0200
Message-ID: <2023072124-delicacy-thrower-2b56@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 57e2c2f2d94cfd551af91cedfa1af6d972487197
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023072124-delicacy-thrower-2b56@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

57e2c2f2d94c ("fs: dlm: fix mismatch of plock results from userspace")
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

From 57e2c2f2d94cfd551af91cedfa1af6d972487197 Mon Sep 17 00:00:00 2001
From: Alexander Aring <aahringo@redhat.com>
Date: Wed, 24 May 2023 12:02:04 -0400
Subject: [PATCH] fs: dlm: fix mismatch of plock results from userspace

When a waiting plock request (F_SETLKW) is sent to userspace
for processing (dlm_controld), the result is returned at a
later time. That result could be incorrectly matched to a
different waiting request in cases where the owner field is
the same (e.g. different threads in a process.) This is fixed
by comparing all the properties in the request and reply.

The results for non-waiting plock requests are now matched
based on list order because the results are returned in the
same order they were sent.

Cc: stable@vger.kernel.org
Signed-off-by: Alexander Aring <aahringo@redhat.com>
Signed-off-by: David Teigland <teigland@redhat.com>

diff --git a/fs/dlm/plock.c b/fs/dlm/plock.c
index c9e1d5f54194..70a4752ed913 100644
--- a/fs/dlm/plock.c
+++ b/fs/dlm/plock.c
@@ -395,7 +395,7 @@ static ssize_t dev_read(struct file *file, char __user *u, size_t count,
 		if (op->info.flags & DLM_PLOCK_FL_CLOSE)
 			list_del(&op->list);
 		else
-			list_move(&op->list, &recv_list);
+			list_move_tail(&op->list, &recv_list);
 		memcpy(&info, &op->info, sizeof(info));
 	}
 	spin_unlock(&ops_lock);
@@ -433,20 +433,52 @@ static ssize_t dev_write(struct file *file, const char __user *u, size_t count,
 	if (check_version(&info))
 		return -EINVAL;
 
+	/*
+	 * The results for waiting ops (SETLKW) can be returned in any
+	 * order, so match all fields to find the op.  The results for
+	 * non-waiting ops are returned in the order that they were sent
+	 * to userspace, so match the result with the first non-waiting op.
+	 */
 	spin_lock(&ops_lock);
-	list_for_each_entry(iter, &recv_list, list) {
-		if (iter->info.fsid == info.fsid &&
-		    iter->info.number == info.number &&
-		    iter->info.owner == info.owner) {
-			list_del_init(&iter->list);
-			memcpy(&iter->info, &info, sizeof(info));
-			if (iter->data)
-				do_callback = 1;
-			else
-				iter->done = 1;
-			op = iter;
-			break;
+	if (info.wait) {
+		list_for_each_entry(iter, &recv_list, list) {
+			if (iter->info.fsid == info.fsid &&
+			    iter->info.number == info.number &&
+			    iter->info.owner == info.owner &&
+			    iter->info.pid == info.pid &&
+			    iter->info.start == info.start &&
+			    iter->info.end == info.end &&
+			    iter->info.ex == info.ex &&
+			    iter->info.wait) {
+				op = iter;
+				break;
+			}
 		}
+	} else {
+		list_for_each_entry(iter, &recv_list, list) {
+			if (!iter->info.wait) {
+				op = iter;
+				break;
+			}
+		}
+	}
+
+	if (op) {
+		/* Sanity check that op and info match. */
+		if (info.wait)
+			WARN_ON(op->info.optype != DLM_PLOCK_OP_LOCK);
+		else
+			WARN_ON(op->info.fsid != info.fsid ||
+				op->info.number != info.number ||
+				op->info.owner != info.owner ||
+				op->info.optype != info.optype);
+
+		list_del_init(&op->list);
+		memcpy(&op->info, &info, sizeof(info));
+		if (op->data)
+			do_callback = 1;
+		else
+			op->done = 1;
 	}
 	spin_unlock(&ops_lock);
 

