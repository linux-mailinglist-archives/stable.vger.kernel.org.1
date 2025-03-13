Return-Path: <stable+bounces-124348-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C64C3A5FEBE
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 19:03:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 247F93BCD76
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 18:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A071DC9AF;
	Thu, 13 Mar 2025 18:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="dB9XbyOt"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A1015B0EF
	for <stable@vger.kernel.org>; Thu, 13 Mar 2025 18:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741889001; cv=none; b=ezBbIf4u+971V6NRU6wx1JQKhcpOB08mfy02/zdXwMaCQJxSjsAmeyTkpLztAF5uKxWE3mRrHB21Y6aQRyUClzq8hT8cQIAGgbFi//uvhMUK2WJarU0SUcy10N7ibHPQlm2EjvzlZUCweD5SItsxI4EtPj8h1eKQC1i9i9WH7wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741889001; c=relaxed/simple;
	bh=W897u9/7Vv73VEFTxemB7SQJmVUUGe9MpZy137hdR5I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=byOeyiliRtVNxlmegEfrhxKGNIiEqwW+WOC+EgvrMj53tPLILbHQJVaP73d2dKMBs4UwnOed4PtcpprECeopWNUF3wDx0QX4z63lS8EnSDtysYNpD7TUg7LFXfm4rXLq5WVMrVpMQ1R0/GjKwiDu5OGUxdT8ctLMG8Qwih/PFgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=dB9XbyOt; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1741889000; x=1773425000;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LFnsWhAorNGHbGNWhGBhSQIigVxZZMGEIfZpzbV5sis=;
  b=dB9XbyOt4mFIbYq+iQaXX/TRN7CmsGFLXmyrNZQT499Yjp/MJFnTU6yY
   9K7qcNh5Hfv3jaCWfH5HitX8Gzw7jxFxr0uhCHx/cfg4+MB/atayP8w/2
   5ibDI4YyNFYjVQeu3tueXJ3nnSzo0Zk5ipnhNGxamkggqVesJgLWyxdRe
   g=;
X-IronPort-AV: E=Sophos;i="6.14,245,1736812800"; 
   d="scan'208";a="474859137"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 18:03:16 +0000
Received: from EX19MTAEUA001.ant.amazon.com [10.0.10.100:51736]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.7.247:2525] with esmtp (Farcaster)
 id 2b0358b2-60f4-4a55-8dba-d71676fd013c; Thu, 13 Mar 2025 18:03:15 +0000 (UTC)
X-Farcaster-Flow-ID: 2b0358b2-60f4-4a55-8dba-d71676fd013c
Received: from EX19D016EUA001.ant.amazon.com (10.252.50.245) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 13 Mar 2025 18:03:14 +0000
Received: from EX19MTAUWC002.ant.amazon.com (10.250.64.143) by
 EX19D016EUA001.ant.amazon.com (10.252.50.245) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 13 Mar 2025 18:03:14 +0000
Received: from email-imr-corp-prod-pdx-all-2c-619df93b.us-west-2.amazon.com
 (10.25.36.210) by mail-relay.amazon.com (10.250.64.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1544.14 via Frontend Transport; Thu, 13 Mar 2025 18:03:14 +0000
Received: from dev-dsk-kareemem-1c-885b5fe7.eu-west-1.amazon.com (dev-dsk-kareemem-1c-885b5fe7.eu-west-1.amazon.com [10.13.243.223])
	by email-imr-corp-prod-pdx-all-2c-619df93b.us-west-2.amazon.com (Postfix) with ESMTPS id 7372D406B0;
	Thu, 13 Mar 2025 18:03:12 +0000 (UTC)
From: Abdelkareem Abdelsaamad <kareemem@amazon.com>
To: <stable@vger.kernel.org>
CC: Chen Ridong <chenridong@huawei.com>, Michal Hocko <mhocko@suse.com>,
	"Roman Gushchin" <roman.gushchin@linux.dev>, Johannes Weiner
	<hannes@cmpxchg.org>, Shakeel Butt <shakeelb@google.com>, Muchun Song
	<songmuchun@bytedance.com>, =?UTF-8?q?Michal=20Koutn=C3=BD?=
	<mkoutny@suse.com>, Andrew Morton <akpm@linux-foundation.org>, Sasha Levin
	<sashal@kernel.org>, "Abdelkareem Abdelsaamad" <kareemem@amazon.com>
Subject: [PATCH 5.10.y] memcg: fix soft lockup in the OOM process
Date: Thu, 13 Mar 2025 18:03:09 +0000
Message-ID: <20250313180309.41770-1-kareemem@amazon.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

From: Chen Ridong <chenridong@huawei.com>

[ Upstream commit ade81479c7dda1ce3eedb215c78bc615bbd04f06 ]

A soft lockup issue was found in the product with about 56,000 tasks were
in the OOM cgroup, it was traversing them when the soft lockup was
triggered.

watchdog: BUG: soft lockup - CPU#2 stuck for 23s! [VM Thread:1503066]
CPU: 2 PID: 1503066 Comm: VM Thread Kdump: loaded Tainted: G
Hardware name: Huawei Cloud OpenStack Nova, BIOS
RIP: 0010:console_unlock+0x343/0x540
RSP: 0000:ffffb751447db9a0 EFLAGS: 00000247 ORIG_RAX: ffffffffffffff13
RAX: 0000000000000001 RBX: 0000000000000000 RCX: 00000000ffffffff
RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000247
RBP: ffffffffafc71f90 R08: 0000000000000000 R09: 0000000000000040
R10: 0000000000000080 R11: 0000000000000000 R12: ffffffffafc74bd0
R13: ffffffffaf60a220 R14: 0000000000000247 R15: 0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f2fe6ad91f0 CR3: 00000004b2076003 CR4: 0000000000360ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 vprintk_emit+0x193/0x280
 printk+0x52/0x6e
 dump_task+0x114/0x130
 mem_cgroup_scan_tasks+0x76/0x100
 dump_header+0x1fe/0x210
 oom_kill_process+0xd1/0x100
 out_of_memory+0x125/0x570
 mem_cgroup_out_of_memory+0xb5/0xd0
 try_charge+0x720/0x770
 mem_cgroup_try_charge+0x86/0x180
 mem_cgroup_try_charge_delay+0x1c/0x40
 do_anonymous_page+0xb5/0x390
 handle_mm_fault+0xc4/0x1f0

This is because thousands of processes are in the OOM cgroup, it takes a
long time to traverse all of them.  As a result, this lead to soft lockup
in the OOM process.

To fix this issue, call 'cond_resched' in the 'mem_cgroup_scan_tasks'
function per 1000 iterations.  For global OOM, call
'touch_softlockup_watchdog' per 1000 iterations to avoid this issue.

Link: https://lkml.kernel.org/r/20241224025238.3768787-1-chenridong@huaweicloud.com
Fixes: 9cbb78bb3143 ("mm, memcg: introduce own oom handler to iterate only over its own threads")
Signed-off-by: Chen Ridong <chenridong@huawei.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Shakeel Butt <shakeelb@google.com>
Cc: Muchun Song <songmuchun@bytedance.com>
Cc: Michal Koutný <mkoutny@suse.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
[Conflict due to
2ea465878344 ("mm: update mark_victim tracepoints field")
not in the tree]
Signed-off-by: Abdelkareem Abdelsaamad <kareemem@amazon.com>
---
 mm/memcontrol.c | 7 ++++++-
 mm/oom_kill.c   | 8 +++++++-
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 8de7c72ae025..14f26b3b0204 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1312,6 +1312,7 @@ int mem_cgroup_scan_tasks(struct mem_cgroup *memcg,
 {
 	struct mem_cgroup *iter;
 	int ret = 0;
+	int i = 0;
 
 	BUG_ON(memcg == root_mem_cgroup);
 
@@ -1320,8 +1321,12 @@ int mem_cgroup_scan_tasks(struct mem_cgroup *memcg,
 		struct task_struct *task;
 
 		css_task_iter_start(&iter->css, CSS_TASK_ITER_PROCS, &it);
-		while (!ret && (task = css_task_iter_next(&it)))
+		while (!ret && (task = css_task_iter_next(&it))) {
+			/* Avoid potential softlockup warning */
+			if ((++i & 1023) == 0)
+				cond_resched();
 			ret = fn(task, arg);
+		}
 		css_task_iter_end(&it);
 		if (ret) {
 			mem_cgroup_iter_break(memcg, iter);
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 3d7c557fb70c..ba333cc560d8 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -43,6 +43,7 @@
 #include <linux/kthread.h>
 #include <linux/init.h>
 #include <linux/mmu_notifier.h>
+#include <linux/nmi.h>
 
 #include <asm/tlb.h>
 #include "internal.h"
@@ -430,10 +431,15 @@ static void dump_tasks(struct oom_control *oc)
 		mem_cgroup_scan_tasks(oc->memcg, dump_task, oc);
 	else {
 		struct task_struct *p;
+		int i = 0;
 
 		rcu_read_lock();
-		for_each_process(p)
+		for_each_process(p) {
+			/* Avoid potential softlockup warning */
+			if ((++i & 1023) == 0)
+				touch_softlockup_watchdog();
 			dump_task(p, oc);
+		}
 		rcu_read_unlock();
 	}
 }
-- 
2.47.1


