Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4AEB73EA1B
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232302AbjFZSnf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232569AbjFZSn2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:43:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B7010D5
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:43:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F9A760F56
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:43:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38FDAC433C9;
        Mon, 26 Jun 2023 18:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687804995;
        bh=u2dFV4itYQKWLkh1s4XZWPGwMZYcyUUNkeZ9PBI3mGc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kPX+i5/pB8Zz6uaVi0cUBw8lG7Mhoyc1QtZT/Lx8A3VtIw03Pl9UW+bNMdUJsZu96
         S8qyKnPbcmbUf7E5xEz3lnbILUiM29oWxP8an1I/Frooc0SLNiHF4RJHS46pXr/cCk
         J4coeot21Kn46ECW3GP3uEzbGcYRGI/pBjLsW3pk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Gaosheng Cui <cuigaosheng1@huawei.com>,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 5.10 15/81] cgroup: Do not corrupt task iteration when rebinding subsystem
Date:   Mon, 26 Jun 2023 20:11:57 +0200
Message-ID: <20230626180745.076768581@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180744.453069285@linuxfoundation.org>
References: <20230626180744.453069285@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Xiu Jianfeng <xiujianfeng@huawei.com>

commit 6f363f5aa845561f7ea496d8b1175e3204470486 upstream.

We found a refcount UAF bug as follows:

refcount_t: addition on 0; use-after-free.
WARNING: CPU: 1 PID: 342 at lib/refcount.c:25 refcount_warn_saturate+0xa0/0x148
Workqueue: events cpuset_hotplug_workfn
Call trace:
 refcount_warn_saturate+0xa0/0x148
 __refcount_add.constprop.0+0x5c/0x80
 css_task_iter_advance_css_set+0xd8/0x210
 css_task_iter_advance+0xa8/0x120
 css_task_iter_next+0x94/0x158
 update_tasks_root_domain+0x58/0x98
 rebuild_root_domains+0xa0/0x1b0
 rebuild_sched_domains_locked+0x144/0x188
 cpuset_hotplug_workfn+0x138/0x5a0
 process_one_work+0x1e8/0x448
 worker_thread+0x228/0x3e0
 kthread+0xe0/0xf0
 ret_from_fork+0x10/0x20

then a kernel panic will be triggered as below:

Unable to handle kernel paging request at virtual address 00000000c0000010
Call trace:
 cgroup_apply_control_disable+0xa4/0x16c
 rebind_subsystems+0x224/0x590
 cgroup_destroy_root+0x64/0x2e0
 css_free_rwork_fn+0x198/0x2a0
 process_one_work+0x1d4/0x4bc
 worker_thread+0x158/0x410
 kthread+0x108/0x13c
 ret_from_fork+0x10/0x18

The race that cause this bug can be shown as below:

(hotplug cpu)                | (umount cpuset)
mutex_lock(&cpuset_mutex)    | mutex_lock(&cgroup_mutex)
cpuset_hotplug_workfn        |
 rebuild_root_domains        |  rebind_subsystems
  update_tasks_root_domain   |   spin_lock_irq(&css_set_lock)
   css_task_iter_start       |    list_move_tail(&cset->e_cset_node[ss->id]
   while(css_task_iter_next) |                  &dcgrp->e_csets[ss->id]);
   css_task_iter_end         |   spin_unlock_irq(&css_set_lock)
mutex_unlock(&cpuset_mutex)  | mutex_unlock(&cgroup_mutex)

Inside css_task_iter_start/next/end, css_set_lock is hold and then
released, so when iterating task(left side), the css_set may be moved to
another list(right side), then it->cset_head points to the old list head
and it->cset_pos->next points to the head node of new list, which can't
be used as struct css_set.

To fix this issue, switch from all css_sets to only scgrp's css_sets to
patch in-flight iterators to preserve correct iteration, and then
update it->cset_head as well.

Reported-by: Gaosheng Cui <cuigaosheng1@huawei.com>
Link: https://www.spinics.net/lists/cgroups/msg37935.html
Suggested-by: Michal Koutný <mkoutny@suse.com>
Link: https://lore.kernel.org/all/20230526114139.70274-1-xiujianfeng@huaweicloud.com/
Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
Fixes: 2d8f243a5e6e ("cgroup: implement cgroup->e_csets[]")
Cc: stable@vger.kernel.org # v3.16+
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/cgroup/cgroup.c |   20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1712,7 +1712,7 @@ int rebind_subsystems(struct cgroup_root
 {
 	struct cgroup *dcgrp = &dst_root->cgrp;
 	struct cgroup_subsys *ss;
-	int ssid, i, ret;
+	int ssid, ret;
 	u16 dfl_disable_ss_mask = 0;
 
 	lockdep_assert_held(&cgroup_mutex);
@@ -1756,7 +1756,8 @@ int rebind_subsystems(struct cgroup_root
 		struct cgroup_root *src_root = ss->root;
 		struct cgroup *scgrp = &src_root->cgrp;
 		struct cgroup_subsys_state *css = cgroup_css(scgrp, ss);
-		struct css_set *cset;
+		struct css_set *cset, *cset_pos;
+		struct css_task_iter *it;
 
 		WARN_ON(!css || cgroup_css(dcgrp, ss));
 
@@ -1774,9 +1775,22 @@ int rebind_subsystems(struct cgroup_root
 		css->cgroup = dcgrp;
 
 		spin_lock_irq(&css_set_lock);
-		hash_for_each(css_set_table, i, cset, hlist)
+		WARN_ON(!list_empty(&dcgrp->e_csets[ss->id]));
+		list_for_each_entry_safe(cset, cset_pos, &scgrp->e_csets[ss->id],
+					 e_cset_node[ss->id]) {
 			list_move_tail(&cset->e_cset_node[ss->id],
 				       &dcgrp->e_csets[ss->id]);
+			/*
+			 * all css_sets of scgrp together in same order to dcgrp,
+			 * patch in-flight iterators to preserve correct iteration.
+			 * since the iterator is always advanced right away and
+			 * finished when it->cset_pos meets it->cset_head, so only
+			 * update it->cset_head is enough here.
+			 */
+			list_for_each_entry(it, &cset->task_iters, iters_node)
+				if (it->cset_head == &scgrp->e_csets[ss->id])
+					it->cset_head = &dcgrp->e_csets[ss->id];
+		}
 		spin_unlock_irq(&css_set_lock);
 
 		/* default hierarchy doesn't enable controllers by default */


