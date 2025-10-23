Return-Path: <stable+bounces-189062-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03C9EBFF58E
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 08:29:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EFDA3A851F
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 06:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8102989A2;
	Thu, 23 Oct 2025 06:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="pGiKyxGv"
X-Original-To: stable@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0BD28D8E8;
	Thu, 23 Oct 2025 06:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761200945; cv=none; b=mNkm2veQSZVf3nUHHrgzW0kfBG744SmWo/7rPBUT/TbKgroW/xCZ47WspRZ3UVeoNEHZbAlXsSXo+oI3YG9nxWbP+hYl9YeoYTMbuuRihzP0sm9vxcdobiNyK+Oeuc5mvVNo1hadkqQOrY8uC4gjOBvWmZa+KF9e8ylJzSfj+4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761200945; c=relaxed/simple;
	bh=EURbfh3Qjr7iDRr5voTk+s112vJJ4z1w0s1l7Id3zl8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZkVanIYuXExY8V1A5Cnf39WGKOuoQ0Ig5nGcCy1ZX2jLB+vjbroS6o8TUQYbZNI14UqFBX1URbeoFm+SJ46zsTGS6QyR5O/1IUKIwv2MOhueRsI3FsV7H9S7Rdp/69/3/Fm0Ev9Tnnk7IZGnQW/rmVczIv5BMy4as7ZZKHNK4uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=pGiKyxGv; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1761200940; h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
	bh=Y8u7TBKpIgarh974x3I1Xfo7kyw9ap5P9qTE+I4tNbI=;
	b=pGiKyxGve4LU32fHQUnRoSUUxwzleiGpSOQkh95sjbhHHyHSWDuQoPah+fu1KwqciG9zWchrhVXvYj2ZsLUvziR8I/KyDftX4taW/nVK+0/I6KaiGYO7qeKVEgh3QcBl+v9MvOJxgMUugcRCeluqp4j5o0DmmI6gvh6zvuHOjTw=
Received: from localhost(mailfrom:peng_wang@linux.alibaba.com fp:SMTPD_---0Wqq5eLk_1761200938 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 23 Oct 2025 14:28:59 +0800
From: Peng Wang <peng_wang@linux.alibaba.com>
To: vincent.guittot@linaro.org
Cc: bsegall@google.com,
	dietmar.eggemann@arm.com,
	juri.lelli@redhat.com,
	linux-kernel@vger.kernel.org,
	mgorman@suse.de,
	mingo@redhat.com,
	peng_wang@linux.alibaba.com,
	peterz@infradead.org,
	rostedt@goodmis.org,
	vdavydov.dev@gmail.com,
	vschneid@redhat.com,
	stable@vger.kernel.org
Subject: [PATCH v2] sched/fair: Clear ->h_load_next when unregistering cgroup
Date: Thu, 23 Oct 2025 14:28:27 +0800
Message-Id: <f3d77b74d72da0c627ff4b4fe9d430969da6b900.1761200831.git.peng_wang@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <CAKfTPtDJW4yU2=_4stdS1bggHwAA8K2On_ruV63=_H9=YEgdkw@mail.gmail.com>
References: <CAKfTPtDJW4yU2=_4stdS1bggHwAA8K2On_ruV63=_H9=YEgdkw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

An invalid pointer dereference bug was reported on arm64 cpu, and has
not yet been seen on x86. A partial oops looks like:

 Call trace:
  update_cfs_rq_h_load+0x80/0xb0
  wake_affine+0x158/0x168
  select_task_rq_fair+0x364/0x3a8
  try_to_wake_up+0x154/0x648
  wake_up_q+0x68/0xd0
  futex_wake_op+0x280/0x4c8
  do_futex+0x198/0x1c0
  __arm64_sys_futex+0x11c/0x198

Link: https://lore.kernel.org/all/20251013071820.1531295-1-CruzZhao@linux.alibaba.com/

We found that the task_group corresponding to the problematic se
is not in the parent task_group’s children list, indicating that
h_load_next points to an invalid address. Consider the following
cgroup and task hierarchy:

         A
        / \
       /   \
      B     E
     / \    |
    /   \   t2
   C     D
   |     |
   t0    t1

Here follows a timing sequence that may be responsible for triggering
the problem:

CPU X                   CPU Y                   CPU Z
wakeup t0
set list A->B->C
traverse A->B->C
t0 exits
destroy C
                        wakeup t2
                        set list A->E           wakeup t1
                                                set list A->B->D
                        traverse A->B->C
                        panic

CPU Z sets ->h_load_next list to A->B->D, but due to arm64 weaker memory
ordering, Y may observe A->B before it sees B->D, then in this time window,
it can traverse A->B->C and reach an invalid se.

We can avoid stale pointer accesses by clearing ->h_load_next when
unregistering cgroup.

Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
Fixes: 685207963be9 ("sched: Move h_load calculation to task_h_load()")
Cc: <stable@vger.kernel.org>
Co-developed-by: Cruz Zhao <CruzZhao@linux.alibaba.com>
Signed-off-by: Cruz Zhao <CruzZhao@linux.alibaba.com>
Signed-off-by: Peng Wang <peng_wang@linux.alibaba.com>
---
 kernel/sched/fair.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index cee1793e8277..a5fce15093d3 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -13427,6 +13427,14 @@ void unregister_fair_sched_group(struct task_group *tg)
 				list_del_leaf_cfs_rq(cfs_rq);
 			}
 			remove_entity_load_avg(se);
+			/*
+			 * Clear parent's h_load_next if it points to the
+			 * sched_entity being freed to avoid stale pointer.
+			 */
+			struct cfs_rq *parent_cfs_rq = cfs_rq_of(se);
+
+			if (READ_ONCE(parent_cfs_rq->h_load_next) == se)
+				WRITE_ONCE(parent_cfs_rq->h_load_next, NULL);
 		}
 
 		/*
-- 
2.27.0


