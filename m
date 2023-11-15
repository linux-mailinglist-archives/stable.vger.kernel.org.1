Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DAEF7ECBA0
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:23:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbjKOTXa (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:23:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231745AbjKOTX3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:23:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26DEC1A7
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:23:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3908C433C7;
        Wed, 15 Nov 2023 19:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076204;
        bh=6gZxPnxjJUoPwEEdDgHk6mXmespYF6EOuAj7N92jb2g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lh4DUss6Tk2TATtb33bnXEq00YXf/QfHVM8OAAaMevSaXpq8AFXNgVyDR+XecNe58
         SBnQrgjKwMS3qnecPnno6S+bOy7nh/VAlXTKGv8eBCyOnY+Jqmhb1IsVFWEHVAHKqy
         PiOutC7MbvAXvpiDryS1CJzCk3rCWNt64ch6FtLQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yafang Shao <laoar.shao@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stanislav Fomichev <sdf@google.com>,
        Feng Zhou <zhoufeng.zf@bytedance.com>,
        KP Singh <kpsingh@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 117/550] bpf: Fix missed rcu read lock in bpf_task_under_cgroup()
Date:   Wed, 15 Nov 2023 14:11:41 -0500
Message-ID: <20231115191608.800593763@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
References: <20231115191600.708733204@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yafang Shao <laoar.shao@gmail.com>

[ Upstream commit 29a7e00ffadddd8d68eff311de1bf12ae10687bb ]

When employed within a sleepable program not under RCU protection, the
use of 'bpf_task_under_cgroup()' may trigger a warning in the kernel log,
particularly when CONFIG_PROVE_RCU is enabled:

  [ 1259.662357] WARNING: suspicious RCU usage
  [ 1259.662358] 6.5.0+ #33 Not tainted
  [ 1259.662360] -----------------------------
  [ 1259.662361] include/linux/cgroup.h:423 suspicious rcu_dereference_check() usage!

Other info that might help to debug this:

  [ 1259.662366] rcu_scheduler_active = 2, debug_locks = 1
  [ 1259.662368] 1 lock held by trace/72954:
  [ 1259.662369]  #0: ffffffffb5e3eda0 (rcu_read_lock_trace){....}-{0:0}, at: __bpf_prog_enter_sleepable+0x0/0xb0

Stack backtrace:

  [ 1259.662385] CPU: 50 PID: 72954 Comm: trace Kdump: loaded Not tainted 6.5.0+ #33
  [ 1259.662391] Call Trace:
  [ 1259.662393]  <TASK>
  [ 1259.662395]  dump_stack_lvl+0x6e/0x90
  [ 1259.662401]  dump_stack+0x10/0x20
  [ 1259.662404]  lockdep_rcu_suspicious+0x163/0x1b0
  [ 1259.662412]  task_css_set.part.0+0x23/0x30
  [ 1259.662417]  bpf_task_under_cgroup+0xe7/0xf0
  [ 1259.662422]  bpf_prog_7fffba481a3bcf88_lsm_run+0x5c/0x93
  [ 1259.662431]  bpf_trampoline_6442505574+0x60/0x1000
  [ 1259.662439]  bpf_lsm_bpf+0x5/0x20
  [ 1259.662443]  ? security_bpf+0x32/0x50
  [ 1259.662452]  __sys_bpf+0xe6/0xdd0
  [ 1259.662463]  __x64_sys_bpf+0x1a/0x30
  [ 1259.662467]  do_syscall_64+0x38/0x90
  [ 1259.662472]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
  [ 1259.662479] RIP: 0033:0x7f487baf8e29
  [...]
  [ 1259.662504]  </TASK>

This issue can be reproduced by executing a straightforward program, as
demonstrated below:

SEC("lsm.s/bpf")
int BPF_PROG(lsm_run, int cmd, union bpf_attr *attr, unsigned int size)
{
        struct cgroup *cgrp = NULL;
        struct task_struct *task;
        int ret = 0;

        if (cmd != BPF_LINK_CREATE)
                return 0;

        // The cgroup2 should be mounted first
        cgrp = bpf_cgroup_from_id(1);
        if (!cgrp)
                goto out;
        task = bpf_get_current_task_btf();
        if (bpf_task_under_cgroup(task, cgrp))
                ret = -1;
        bpf_cgroup_release(cgrp);

out:
        return ret;
}

After running the program, if you subsequently execute another BPF program,
you will encounter the warning.

It's worth noting that task_under_cgroup_hierarchy() is also utilized by
bpf_current_task_under_cgroup(). However, bpf_current_task_under_cgroup()
doesn't exhibit this issue because it cannot be used in sleepable BPF
programs.

Fixes: b5ad4cdc46c7 ("bpf: Add bpf_task_under_cgroup() kfunc")
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Stanislav Fomichev <sdf@google.com>
Cc: Feng Zhou <zhoufeng.zf@bytedance.com>
Cc: KP Singh <kpsingh@kernel.org>
Link: https://lore.kernel.org/bpf/20231007135945.4306-1-laoar.shao@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/helpers.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 8812397a5cd96..3779300002327 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2167,7 +2167,12 @@ __bpf_kfunc struct cgroup *bpf_cgroup_from_id(u64 cgid)
 __bpf_kfunc long bpf_task_under_cgroup(struct task_struct *task,
 				       struct cgroup *ancestor)
 {
-	return task_under_cgroup_hierarchy(task, ancestor);
+	long ret;
+
+	rcu_read_lock();
+	ret = task_under_cgroup_hierarchy(task, ancestor);
+	rcu_read_unlock();
+	return ret;
 }
 #endif /* CONFIG_CGROUPS */
 
-- 
2.42.0



