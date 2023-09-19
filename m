Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5F467A6C46
	for <lists+stable@lfdr.de>; Tue, 19 Sep 2023 22:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232649AbjISUWl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 19 Sep 2023 16:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233237AbjISUWU (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 19 Sep 2023 16:22:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F0EC4;
        Tue, 19 Sep 2023 13:22:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D00AC433C7;
        Tue, 19 Sep 2023 20:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1695154934;
        bh=0SMFxmVNcx2Z9vxI52Pe+o2YA1Is7m6lpkBHQUToLhA=;
        h=Date:To:From:Subject:From;
        b=DIbOJqKkRhMYd09t1XhB5fMhm0eRzhC/5Qdei8Y+uOAWDnr/+gK/tJYyl8j0HQlTh
         PYIexkRY4zqIXE894YkJP52/QK1acwTB1tFttinM0BqrnSBGp8G6p7q2BcT1E0I6BK
         e6jZfNWU71Npxfl7SuEH6hsXpr+l2NMrY/cZ+oz8=
Date:   Tue, 19 Sep 2023 13:22:13 -0700
To:     mm-commits@vger.kernel.org, stable@vger.kernel.org,
        oleg@redhat.com, giulio.benetti@benettiengineering.com,
        gerg@uclinux.org, ben.wolsieffer@hefring.com,
        Ben.Wolsieffer@hefring.com, akpm@linux-foundation.org
From:   Andrew Morton <akpm@linux-foundation.org>
Subject: [merged mm-hotfixes-stable] proc-nommu-proc-pid-maps-release-mmap-read-lock.patch removed from -mm tree
Message-Id: <20230919202214.4D00AC433C7@smtp.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The quilt patch titled
     Subject: proc: nommu: /proc/<pid>/maps: release mmap read lock
has been removed from the -mm tree.  Its filename was
     proc-nommu-proc-pid-maps-release-mmap-read-lock.patch

This patch was dropped because it was merged into the mm-hotfixes-stable branch
of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

------------------------------------------------------
From: Ben Wolsieffer <Ben.Wolsieffer@hefring.com>
Subject: proc: nommu: /proc/<pid>/maps: release mmap read lock
Date: Thu, 14 Sep 2023 12:30:20 -0400

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
---

 fs/proc/task_nommu.c |   27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

--- a/fs/proc/task_nommu.c~proc-nommu-proc-pid-maps-release-mmap-read-lock
+++ a/fs/proc/task_nommu.c
@@ -192,11 +192,16 @@ static void *m_start(struct seq_file *m,
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
 
@@ -205,23 +210,21 @@ static void *m_start(struct seq_file *m,
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
_

Patches currently in -mm which might be from Ben.Wolsieffer@hefring.com are


