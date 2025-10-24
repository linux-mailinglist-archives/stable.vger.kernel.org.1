Return-Path: <stable+bounces-189201-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD3DC04B33
	for <lists+stable@lfdr.de>; Fri, 24 Oct 2025 09:24:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BC4A434FDC9
	for <lists+stable@lfdr.de>; Fri, 24 Oct 2025 07:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E6BC2D0C79;
	Fri, 24 Oct 2025 07:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="pCXlOqHV"
X-Original-To: stable@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD62529B8D3;
	Fri, 24 Oct 2025 07:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761290652; cv=none; b=hC0x76ZQPpgPkYY+J1FsAmejNm9f5cMBkdezuk/WUsnBzHB+cu2ZlkQemqfW2uUVU6FZlGVHFXayi+6bQFnn5hQ6TRJeUQUdUpVA9T87tA1N/xW30KvT8UsKPwJTR2xKf5yGKWoRIXwBIXMjW6v1AwM5QbMUBdPRRQ4AbpKmYJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761290652; c=relaxed/simple;
	bh=RF60zJA+q99NBU2RjXHcSHJBVQQ4lulUt1rgrFM0DF8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K/hXkgIffKsOfAqi9kvzk2AHUgemN5l/dSMKXOPpaBnsTqbhYs3uTwY1U8hWVbOmr7w0Ms2stzWgZbcbIHcB+xjMxBdNmCwObOjCN5FFXVVp8FHPmBt788tlK1g8Y8wKR8SETtgZywQoKGXLnVPaO5gxY5HqoRaAEo1L+2i/2KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=pCXlOqHV; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1761290642; h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
	bh=hnt6wAXkZYRhv1YQz8nUi4cucmZ82JTucEdIuNR4Y9U=;
	b=pCXlOqHVBxlJrbnHgIzDDBNRMvc8x5yZEaibpGkR0sVaOgkSOB5Yq9wqfPDhVpIvacEd2d/oilCdMhqgMO+vHuGjHoOnWPFq09jRfM64LgknprrF7oNN3ts1f35+qJMLujGE7Nhm0R/L0V6bc8w5bBbGL5Jd3K8KksomNEoSnSA=
Received: from localhost(mailfrom:peng_wang@linux.alibaba.com fp:SMTPD_---0WqtO0DA_1761290598 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 24 Oct 2025 15:24:02 +0800
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
	stable@vger.kernel.org,
	vdavydov.dev@gmail.com,
	vschneid@redhat.com
Subject: [PATCH v3] sched/fair: Clear ->h_load_next when unregistering cgroup
Date: Fri, 24 Oct 2025 15:23:16 +0800
Message-Id: <bf93d41ff9f2da19ef2c1cfb505362e0b48c39de.1761290330.git.peng_wang@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <CAKfTPtC-L3R6iYA=boxQGKVafC_UhBihYq6n6qTJ6hk4Q76OZg@mail.gmail.com>
References: <CAKfTPtC-L3R6iYA=boxQGKVafC_UhBihYq6n6qTJ6hk4Q76OZg@mail.gmail.com>
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
 kernel/sched/fair.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index cee1793e8277..32b466605925 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -13418,6 +13418,8 @@ void unregister_fair_sched_group(struct task_group *tg)
 		struct rq *rq = cpu_rq(cpu);
 
 		if (se) {
+			struct cfs_rq *parent_cfs_rq = cfs_rq_of(se);
+
 			if (se->sched_delayed) {
 				guard(rq_lock_irqsave)(rq);
 				if (se->sched_delayed) {
@@ -13427,6 +13429,13 @@ void unregister_fair_sched_group(struct task_group *tg)
 				list_del_leaf_cfs_rq(cfs_rq);
 			}
 			remove_entity_load_avg(se);
+
+			/*
+			 * Clear parent's h_load_next if it points to the
+			 * sched_entity being freed to avoid stale pointer.
+			 */
+			if (READ_ONCE(parent_cfs_rq->h_load_next) == se)
+				WRITE_ONCE(parent_cfs_rq->h_load_next, NULL);
 		}
 
 		/*
-- 
2.27.0


