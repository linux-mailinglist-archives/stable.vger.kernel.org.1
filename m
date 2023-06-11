Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 883B772B201
	for <lists+stable@lfdr.de>; Sun, 11 Jun 2023 15:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233630AbjFKNMp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 11 Jun 2023 09:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232910AbjFKNMo (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 11 Jun 2023 09:12:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC259F
        for <stable@vger.kernel.org>; Sun, 11 Jun 2023 06:12:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1FAF761087
        for <stable@vger.kernel.org>; Sun, 11 Jun 2023 13:12:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EE21C433EF;
        Sun, 11 Jun 2023 13:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686489162;
        bh=STNAJtrjagubnl0A10nnDXRy2p1RvWWdnMKqRNWJTFY=;
        h=Subject:To:Cc:From:Date:From;
        b=f5/fiQ1fKxTvbSp5I5+DrgRTQBgjzqAQJy3ynWl8UbgN2e/ci6+UhmMDJ8+YIl41n
         mVI+eqrJIjRPrKMhz92XMYGkVQynW74+vJBLQdMs9ZY/xE0cyn9VQf6/tIylag71nA
         6Jp8V+55vFir6Qb1+ZOn1tZkLsIdjKJDY6NEKG3Y=
Subject: FAILED: patch "[PATCH] cgroup: fix missing cpus_read_{lock,unlock}() in" failed to apply to 6.3-stable tree
To:     zhengqi.arch@bytedance.com, songmuchun@bytedance.com,
        tj@kernel.org, zhaogongyi@bytedance.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 11 Jun 2023 15:12:33 +0200
Message-ID: <2023061132-curator-unbent-d3ad@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 6.3-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.3.y
git checkout FETCH_HEAD
git cherry-pick -x ab1de7ead871ebe6d12a774c3c25de0388cde082
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023061132-curator-unbent-d3ad@gregkh' --subject-prefix 'PATCH 6.3.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ab1de7ead871ebe6d12a774c3c25de0388cde082 Mon Sep 17 00:00:00 2001
From: Qi Zheng <zhengqi.arch@bytedance.com>
Date: Wed, 17 May 2023 07:45:45 +0000
Subject: [PATCH] cgroup: fix missing cpus_read_{lock,unlock}() in
 cgroup_transfer_tasks()

The commit 4f7e7236435c ("cgroup: Fix threadgroup_rwsem <-> cpus_read_lock()
deadlock") fixed the deadlock between cgroup_threadgroup_rwsem and
cpus_read_lock() by introducing cgroup_attach_{lock,unlock}() and removing
cpus_read_{lock,unlock}() from cpuset_attach(). But cgroup_transfer_tasks()
was missed and not handled, which will cause th following warning:

 WARNING: CPU: 0 PID: 589 at kernel/cpu.c:526 lockdep_assert_cpus_held+0x32/0x40
 CPU: 0 PID: 589 Comm: kworker/1:4 Not tainted 6.4.0-rc2-next-20230517 #50
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01/2014
 Workqueue: events cpuset_hotplug_workfn
 RIP: 0010:lockdep_assert_cpus_held+0x32/0x40
 <...>
 Call Trace:
  <TASK>
  cpuset_attach+0x40/0x240
  cgroup_migrate_execute+0x452/0x5e0
  ? _raw_spin_unlock_irq+0x28/0x40
  cgroup_transfer_tasks+0x1f3/0x360
  ? find_held_lock+0x32/0x90
  ? cpuset_hotplug_workfn+0xc81/0xed0
  cpuset_hotplug_workfn+0xcb1/0xed0
  ? process_one_work+0x248/0x5b0
  process_one_work+0x2b9/0x5b0
  worker_thread+0x56/0x3b0
  ? process_one_work+0x5b0/0x5b0
  kthread+0xf1/0x120
  ? kthread_complete_and_exit+0x20/0x20
  ret_from_fork+0x1f/0x30
  </TASK>

So just use the cgroup_attach_{lock,unlock}() helper to fix it.

Reported-by: Zhao Gongyi <zhaogongyi@bytedance.com>
Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Acked-by: Muchun Song <songmuchun@bytedance.com>
Fixes: 05c7b7a92cc8 ("cgroup/cpuset: Fix a race between cpuset_attach() and cpu hotplug")
Cc: stable@vger.kernel.org # v5.17+
Signed-off-by: Tejun Heo <tj@kernel.org>

diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index aeef06c465ef..5407241dbb45 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -108,7 +108,7 @@ int cgroup_transfer_tasks(struct cgroup *to, struct cgroup *from)
 
 	cgroup_lock();
 
-	percpu_down_write(&cgroup_threadgroup_rwsem);
+	cgroup_attach_lock(true);
 
 	/* all tasks in @from are being moved, all csets are source */
 	spin_lock_irq(&css_set_lock);
@@ -144,7 +144,7 @@ int cgroup_transfer_tasks(struct cgroup *to, struct cgroup *from)
 	} while (task && !ret);
 out_err:
 	cgroup_migrate_finish(&mgctx);
-	percpu_up_write(&cgroup_threadgroup_rwsem);
+	cgroup_attach_unlock(true);
 	cgroup_unlock();
 	return ret;
 }

