Return-Path: <stable+bounces-2798-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DBF47FA93C
	for <lists+stable@lfdr.de>; Mon, 27 Nov 2023 19:49:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC52FB20FE6
	for <lists+stable@lfdr.de>; Mon, 27 Nov 2023 18:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1BF3589D;
	Mon, 27 Nov 2023 18:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="UUUVuk9b"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD782EB13
	for <stable@vger.kernel.org>; Mon, 27 Nov 2023 18:49:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5695C433C7;
	Mon, 27 Nov 2023 18:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1701110985;
	bh=eDD4RiFZ/2PuQHKi7IYy3i2cl6GWj12gtqEoBidSLMc=;
	h=Date:To:From:Subject:From;
	b=UUUVuk9bAC2ErZ84PRpy/pBdoKI7fLApWobHdLthPPwWiyNLwVGnLSJUn7/khpo4b
	 xtDW8IK/3kXua/OpZ8t86F/tInw6VQoAA8W/GKuEeZGXIG2rJhpSkrzI06JW2H2LPO
	 KlS3CKtBHKKzM441slVa5cdk9FiQbU1IS1PLxx88=
Date: Mon, 27 Nov 2023 10:49:45 -0800
To: mm-commits@vger.kernel.org,stable@vger.kernel.org,qun-wei.lin@mediatek.com,oleg@redhat.com,matthias.bgg@gmail.com,chinwen.chang@mediatek.com,angelogioacchino.delregno@collabora.com,andreyknvl@google.com,Kuan-Ying.Lee@mediatek.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: + scripts-gdb-tasks-fix-lx-ps-command-error.patch added to mm-hotfixes-unstable branch
Message-Id: <20231127184945.D5695C433C7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>


The patch titled
     Subject: scripts/gdb/tasks: fix lx-ps command error
has been added to the -mm mm-hotfixes-unstable branch.  Its filename is
     scripts-gdb-tasks-fix-lx-ps-command-error.patch

This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/scripts-gdb-tasks-fix-lx-ps-command-error.patch

This patch will later appear in the mm-hotfixes-unstable branch at
    git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

Before you just go and hit "reply", please:
   a) Consider who else should be cc'ed
   b) Prefer to cc a suitable mailing list as well
   c) Ideally: find the original patch on the mailing list and do a
      reply-to-all to that, adding suitable additional cc's

*** Remember to use Documentation/process/submit-checklist.rst when testing your code ***

The -mm tree is included into linux-next via the mm-everything
branch at git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
and is updated there every 2-3 working days

------------------------------------------------------
From: Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
Subject: scripts/gdb/tasks: fix lx-ps command error
Date: Mon, 27 Nov 2023 15:04:01 +0800

Since commit 8e1f385104ac ("kill task_struct->thread_group") remove
the thread_group, we will encounter below issue.

(gdb) lx-ps
      TASK          PID    COMM
0xffff800086503340   0   swapper/0
Python Exception <class 'gdb.error'>: There is no member named thread_group.
Error occurred in Python: There is no member named thread_group.

We use signal->thread_head to iterate all threads instead.

Link: https://lkml.kernel.org/r/20231127070404.4192-2-Kuan-Ying.Lee@mediatek.com
Fixes: 8e1f385104ac ("kill task_struct->thread_group")
Signed-off-by: Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Chinwen Chang <chinwen.chang@mediatek.com>
Cc: Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Qun-Wei Lin <qun-wei.lin@mediatek.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: <stable@vger.kernel.org>
Cc: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 scripts/gdb/linux/tasks.py |   12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

--- a/scripts/gdb/linux/tasks.py~scripts-gdb-tasks-fix-lx-ps-command-error
+++ a/scripts/gdb/linux/tasks.py
@@ -13,7 +13,7 @@
 
 import gdb
 
-from linux import utils
+from linux import utils, lists
 
 
 task_type = utils.CachedType("struct task_struct")
@@ -25,13 +25,9 @@ def task_lists():
     t = g = init_task
 
     while True:
-        while True:
-            yield t
-
-            t = utils.container_of(t['thread_group']['next'],
-                                   task_ptr_type, "thread_group")
-            if t == g:
-                break
+        thread_head = t['signal']['thread_head']
+        for thread in lists.list_for_each_entry(thread_head, task_ptr_type, 'thread_node'):
+            yield thread
 
         t = g = utils.container_of(g['tasks']['next'],
                                    task_ptr_type, "tasks")
_

Patches currently in -mm which might be from Kuan-Ying.Lee@mediatek.com are

scripts-gdb-tasks-fix-lx-ps-command-error.patch
scripts-gdb-stackdepot-rename-pool_index_cached-to-pools_num.patch
scripts-gdb-remove-exception-handling-and-refine-print-format.patch


