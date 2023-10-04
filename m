Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99A017B8432
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 17:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242969AbjJDPvR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 11:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242958AbjJDPvQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 11:51:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F5DC9E
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 08:51:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1C02C433C7;
        Wed,  4 Oct 2023 15:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696434673;
        bh=TsXqEMQwPNDkUu6sPZoO1w5Pxl+LR80dBncpJ4ul5MQ=;
        h=Subject:To:Cc:From:Date:From;
        b=LYYXkdQWjWCefPEtxmwNZKECWar7/FcXvlkZF6IjvisTSiTXsCljPx6nM8jxIwuJN
         RiR3+kw4powdHGsbWPXOzKz/hgESIpBZKPUzlBuVa0jn9xNvfQ0YxSs1nFqr3x2gJn
         647Ix7DGejBJoeFGkYZQSI9Y6Gm890RGMz8LqDKM=
Subject: FAILED: patch "[PATCH] proc: nommu: /proc/<pid>/maps: release mmap read lock" failed to apply to 4.19-stable tree
To:     Ben.Wolsieffer@hefring.com, akpm@linux-foundation.org,
        ben.wolsieffer@hefring.com, gerg@uclinux.org,
        giulio.benetti@benettiengineering.com, oleg@redhat.com,
        stable@vger.kernel.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Wed, 04 Oct 2023 17:51:08 +0200
Message-ID: <2023100408-swab-depict-d818@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x 578d7699e5c2add8c2e9549d9d75dfb56c460cb3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023100408-swab-depict-d818@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 578d7699e5c2add8c2e9549d9d75dfb56c460cb3 Mon Sep 17 00:00:00 2001
From: Ben Wolsieffer <Ben.Wolsieffer@hefring.com>
Date: Thu, 14 Sep 2023 12:30:20 -0400
Subject: [PATCH] proc: nommu: /proc/<pid>/maps: release mmap read lock

The no-MMU implementation of /proc/<pid>/map doesn't normally release
the mmap read lock, because it uses !IS_ERR_OR_NULL(_vml) to determine
whether to release the lock.  Since _vml is NULL when the end of the
mappings is reached, the lock is not released.

Reading /proc/1/maps twice doesn't cause a hang because it only
takes the read lock, which can be taken multiple times and therefore
doesn't show any problem if the lock isn't released. Instead, you need
to perform some operation that attempts to take the write lock after
reading /proc/<pid>/maps. To actually reproduce the bug, compile the
following code as 'proc_maps_bug':

#include <stdio.h>
#include <unistd.h>
#include <sys/mman.h>

int main(int argc, char *argv[]) {
        void *buf;
        sleep(1);
        buf = mmap(NULL, 4096, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
        puts("mmap returned");
        return 0;
}

Then, run:

  ./proc_maps_bug &; cat /proc/$!/maps; fg

Without this patch, mmap() will hang and the command will never
complete.

This code was incorrectly adapted from the MMU implementation, which at
the time released the lock in m_next() before returning the last entry.

The MMU implementation has diverged further from the no-MMU version since
then, so this patch brings their locking and error handling into sync,
fixing the bug and hopefully avoiding similar issues in the future.

Link: https://lkml.kernel.org/r/20230914163019.4050530-2-ben.wolsieffer@hefring.com
Fixes: 47fecca15c09 ("fs/proc/task_nommu.c: don't use priv->task->mm")
Signed-off-by: Ben Wolsieffer <ben.wolsieffer@hefring.com>
Acked-by: Oleg Nesterov <oleg@redhat.com>
Cc: Giulio Benetti <giulio.benetti@benettiengineering.com>
Cc: Greg Ungerer <gerg@uclinux.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/fs/proc/task_nommu.c b/fs/proc/task_nommu.c
index a8ac0dd8041e..bc2e843f4810 100644
--- a/fs/proc/task_nommu.c
+++ b/fs/proc/task_nommu.c
@@ -192,11 +192,16 @@ static void *m_start(struct seq_file *m, loff_t *pos)
 		return ERR_PTR(-ESRCH);
 
 	mm = priv->mm;
-	if (!mm || !mmget_not_zero(mm))
+	if (!mm || !mmget_not_zero(mm)) {
+		put_task_struct(priv->task);
+		priv->task = NULL;
 		return NULL;
+	}
 
 	if (mmap_read_lock_killable(mm)) {
 		mmput(mm);
+		put_task_struct(priv->task);
+		priv->task = NULL;
 		return ERR_PTR(-EINTR);
 	}
 
@@ -205,23 +210,21 @@ static void *m_start(struct seq_file *m, loff_t *pos)
 	if (vma)
 		return vma;
 
-	mmap_read_unlock(mm);
-	mmput(mm);
 	return NULL;
 }
 
-static void m_stop(struct seq_file *m, void *_vml)
+static void m_stop(struct seq_file *m, void *v)
 {
 	struct proc_maps_private *priv = m->private;
+	struct mm_struct *mm = priv->mm;
 
-	if (!IS_ERR_OR_NULL(_vml)) {
-		mmap_read_unlock(priv->mm);
-		mmput(priv->mm);
-	}
-	if (priv->task) {
-		put_task_struct(priv->task);
-		priv->task = NULL;
-	}
+	if (!priv->task)
+		return;
+
+	mmap_read_unlock(mm);
+	mmput(mm);
+	put_task_struct(priv->task);
+	priv->task = NULL;
 }
 
 static void *m_next(struct seq_file *m, void *_p, loff_t *pos)

