Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6C3F73522F
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbjFSKcN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbjFSKcD (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:32:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6AF8E5C
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:32:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5304060B58
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:32:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BA68C433C0;
        Mon, 19 Jun 2023 10:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687170721;
        bh=i+OmtVDysKCCcOCHXpE+vwMi+kJJQtG8x9OWsvL05/8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m8C23f2m6YMmLChWSg1rMOG7E8wPL8ew9RcbXKKEWlf7FabtqfBZjvcDBYX3ZCSxg
         FeqS5UjOXwa5roprX19iD0MLAM4we8Hwta5aTCIy06O1ETh4sDqQPSEU4Y/RrnHo4S
         +ZkeK6jsIVjpNIOeCSsc0OWBlTWHs/4bnatFWeQU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Zhao Gongyi <zhaogongyi@bytedance.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Tejun Heo <tj@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 004/187] cgroup: fix missing cpus_read_{lock,unlock}() in cgroup_transfer_tasks()
Date:   Mon, 19 Jun 2023 12:27:02 +0200
Message-ID: <20230619102157.829001567@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102157.579823843@linuxfoundation.org>
References: <20230619102157.579823843@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Qi Zheng <zhengqi.arch@bytedance.com>

[ Upstream commit ab1de7ead871ebe6d12a774c3c25de0388cde082 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/cgroup/cgroup-v1.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index aeef06c465ef1..5407241dbb45f 100644
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
-- 
2.39.2



