Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53E3D7BCFD7
	for <lists+stable@lfdr.de>; Sun,  8 Oct 2023 21:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344511AbjJHTnZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 8 Oct 2023 15:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344467AbjJHTnZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 8 Oct 2023 15:43:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF67AC
        for <stable@vger.kernel.org>; Sun,  8 Oct 2023 12:43:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A92BC433C8;
        Sun,  8 Oct 2023 19:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696794203;
        bh=WEHuFUOlDPEMe3VBMfxensXVWG1qJnbtRSD0gXnzwY0=;
        h=Subject:To:Cc:From:Date:From;
        b=DMncjc5GKUBUq4RmkOdvOtM2OcXcAmNNnQa0iQj2LmVWIXcF6i1wyiq/Q4P1ljetv
         6v0KjOVbmoU37qhM0dm7IJi21LSdKlIi4ni6qWvJgOHlNe+dCb7bjJtTf5wlXbqMq1
         DV3GWGMlRaWEy94B8wtEuzj4FVx4uosm7N/vxyF4=
Subject: FAILED: patch "[PATCH] ksmbd: fix race condition from parallel smb2 lock requests" failed to apply to 6.1-stable tree
To:     linkinjeon@kernel.org, rootlab@huawei.com, stfrench@microsoft.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 08 Oct 2023 21:43:07 +0200
Message-ID: <2023100807-alright-overeager-19bc@gregkh>
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


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 75ac9a3dd65f7eab4d12b0a0f744234b5300a491
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023100807-alright-overeager-19bc@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

75ac9a3dd65f ("ksmbd: fix race condition from parallel smb2 lock requests")
38c8a9a52082 ("smb: move client and server files to common directory fs/smb")
3a9b557f44ea ("ksmbd: delete asynchronous work from list")
d3ca9f7aeba7 ("ksmbd: fix possible memory leak in smb2_lock()")
f8d6e7442aa7 ("ksmbd: fix typo, syncronous->synchronous")
abdb1742a312 ("cifs: get rid of mount options string parsing")
9fd29a5bae6e ("cifs: use fs_context for automounts")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 75ac9a3dd65f7eab4d12b0a0f744234b5300a491 Mon Sep 17 00:00:00 2001
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Wed, 4 Oct 2023 18:31:03 +0900
Subject: [PATCH] ksmbd: fix race condition from parallel smb2 lock requests

There is a race condition issue between parallel smb2 lock request.

                                            Time
                                             +
Thread A                                     | Thread A
smb2_lock                                    | smb2_lock
                                             |
 insert smb_lock to lock_list                |
 spin_unlock(&work->conn->llist_lock)        |
                                             |
                                             |   spin_lock(&conn->llist_lock);
                                             |   kfree(cmp_lock);
                                             |
 // UAF!                                     |
 list_add(&smb_lock->llist, &rollback_list)  +

This patch swaps the line for adding the smb lock to the rollback list and
adding the lock list of connection to fix the race issue.

Reported-by: luosili <rootlab@huawei.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index e774c9855f7f..fd6f05786ac2 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -7038,10 +7038,6 @@ int smb2_lock(struct ksmbd_work *work)
 
 				ksmbd_debug(SMB,
 					    "would have to wait for getting lock\n");
-				spin_lock(&work->conn->llist_lock);
-				list_add_tail(&smb_lock->clist,
-					      &work->conn->lock_list);
-				spin_unlock(&work->conn->llist_lock);
 				list_add(&smb_lock->llist, &rollback_list);
 
 				argv = kmalloc(sizeof(void *), GFP_KERNEL);
@@ -7072,9 +7068,6 @@ int smb2_lock(struct ksmbd_work *work)
 
 				if (work->state != KSMBD_WORK_ACTIVE) {
 					list_del(&smb_lock->llist);
-					spin_lock(&work->conn->llist_lock);
-					list_del(&smb_lock->clist);
-					spin_unlock(&work->conn->llist_lock);
 					locks_free_lock(flock);
 
 					if (work->state == KSMBD_WORK_CANCELLED) {
@@ -7094,19 +7087,16 @@ int smb2_lock(struct ksmbd_work *work)
 				}
 
 				list_del(&smb_lock->llist);
-				spin_lock(&work->conn->llist_lock);
-				list_del(&smb_lock->clist);
-				spin_unlock(&work->conn->llist_lock);
 				release_async_work(work);
 				goto retry;
 			} else if (!rc) {
+				list_add(&smb_lock->llist, &rollback_list);
 				spin_lock(&work->conn->llist_lock);
 				list_add_tail(&smb_lock->clist,
 					      &work->conn->lock_list);
 				list_add_tail(&smb_lock->flist,
 					      &fp->lock_list);
 				spin_unlock(&work->conn->llist_lock);
-				list_add(&smb_lock->llist, &rollback_list);
 				ksmbd_debug(SMB, "successful in taking lock\n");
 			} else {
 				goto out;

