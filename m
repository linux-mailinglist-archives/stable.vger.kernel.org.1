Return-Path: <stable+bounces-180074-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 195CDB7E7E9
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 14:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CD12189B652
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 12:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0536F2F1FF6;
	Wed, 17 Sep 2025 12:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eDe/RYQO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FC11DE894;
	Wed, 17 Sep 2025 12:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758113298; cv=none; b=Nz2zqgKK4viuAA5p9MdGiO9NpoQYLyDsQ5FRtBUYWW4YfvnGSQ4pi/djKQYiDtEK6iHrMTLHknHaYG/BSy7pw12t3IzzZ1LFl/dQ4Oq9oZz8MwesotUeMIkPYDgPZuztVkf0pQzBm6uhCgf6ogQeKdXFYllanO3rT4biUDTfxmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758113298; c=relaxed/simple;
	bh=ZOnA+kJsBEBhRNQnT3pSVLwXYlNSmUF8GqiXy5+ipAI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RagA381gZRw3msFyAVeVLpCqDi2tzB+pNky3/zOe+g0LmF1V8KeDW1Mb7qi352zLHTDyEMY3G0Erxrs8dE3yHB+FqnxgURAJRB9Fmu+B3e4n2E7+lJTys54WczA7N41v/mYVXWYjxLJ4OKOJs6cwvpYP6H9oJAM1pKB1LXji9uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eDe/RYQO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 330D0C4CEF0;
	Wed, 17 Sep 2025 12:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758113298;
	bh=ZOnA+kJsBEBhRNQnT3pSVLwXYlNSmUF8GqiXy5+ipAI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eDe/RYQOl3L2VGtpV3FpJpbHOzjaYvZBnGTxdRb+yQv/rMt51gVEFW4X5kOeN8Am+
	 jIZkQE6KJIvtNAGs/PIha1hpRCIreCGJ9TDneMJ5ym/aA0ieolsA/SxinEFiNOkm/y
	 HqPOmbtm0xQhFoL74FHFxKDfHP244bj6tYjZiNr8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Peilin Ye <yepeilin@google.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 044/140] bpf: Tell memcg to use allow_spinning=false path in bpf_timer_init()
Date: Wed, 17 Sep 2025 14:33:36 +0200
Message-ID: <20250917123345.380217374@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250917123344.315037637@linuxfoundation.org>
References: <20250917123344.315037637@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peilin Ye <yepeilin@google.com>

[ Upstream commit 6d78b4473cdb08b74662355a9e8510bde09c511e ]

Currently, calling bpf_map_kmalloc_node() from __bpf_async_init() can
cause various locking issues; see the following stack trace (edited for
style) as one example:

...
 [10.011566]  do_raw_spin_lock.cold
 [10.011570]  try_to_wake_up             (5) double-acquiring the same
 [10.011575]  kick_pool                      rq_lock, causing a hardlockup
 [10.011579]  __queue_work
 [10.011582]  queue_work_on
 [10.011585]  kernfs_notify
 [10.011589]  cgroup_file_notify
 [10.011593]  try_charge_memcg           (4) memcg accounting raises an
 [10.011597]  obj_cgroup_charge_pages        MEMCG_MAX event
 [10.011599]  obj_cgroup_charge_account
 [10.011600]  __memcg_slab_post_alloc_hook
 [10.011603]  __kmalloc_node_noprof
...
 [10.011611]  bpf_map_kmalloc_node
 [10.011612]  __bpf_async_init
 [10.011615]  bpf_timer_init             (3) BPF calls bpf_timer_init()
 [10.011617]  bpf_prog_xxxxxxxxxxxxxxxx_fcg_runnable
 [10.011619]  bpf__sched_ext_ops_runnable
 [10.011620]  enqueue_task_scx           (2) BPF runs with rq_lock held
 [10.011622]  enqueue_task
 [10.011626]  ttwu_do_activate
 [10.011629]  sched_ttwu_pending         (1) grabs rq_lock
...

The above was reproduced on bpf-next (b338cf849ec8) by modifying
./tools/sched_ext/scx_flatcg.bpf.c to call bpf_timer_init() during
ops.runnable(), and hacking the memcg accounting code a bit to make
a bpf_timer_init() call more likely to raise an MEMCG_MAX event.

We have also run into other similar variants (both internally and on
bpf-next), including double-acquiring cgroup_file_kn_lock, the same
worker_pool::lock, etc.

As suggested by Shakeel, fix this by using __GFP_HIGH instead of
GFP_ATOMIC in __bpf_async_init(), so that e.g. if try_charge_memcg()
raises an MEMCG_MAX event, we call __memcg_memory_event() with
@allow_spinning=false and avoid calling cgroup_file_notify() there.

Depends on mm patch
"memcg: skip cgroup_file_notify if spinning is not allowed":
https://lore.kernel.org/bpf/20250905201606.66198-1-shakeel.butt@linux.dev/

v0 approach s/bpf_map_kmalloc_node/bpf_mem_alloc/
https://lore.kernel.org/bpf/20250905061919.439648-1-yepeilin@google.com/
v1 approach:
https://lore.kernel.org/bpf/20250905234547.862249-1-yepeilin@google.com/

Fixes: b00628b1c7d5 ("bpf: Introduce bpf timers.")
Suggested-by: Shakeel Butt <shakeel.butt@linux.dev>
Signed-off-by: Peilin Ye <yepeilin@google.com>
Link: https://lore.kernel.org/r/20250909095222.2121438-1-yepeilin@google.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/helpers.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index be4429463599f..a0bf39b7359aa 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1276,8 +1276,11 @@ static int __bpf_async_init(struct bpf_async_kern *async, struct bpf_map *map, u
 		goto out;
 	}
 
-	/* allocate hrtimer via map_kmalloc to use memcg accounting */
-	cb = bpf_map_kmalloc_node(map, size, GFP_ATOMIC, map->numa_node);
+	/* Allocate via bpf_map_kmalloc_node() for memcg accounting. Until
+	 * kmalloc_nolock() is available, avoid locking issues by using
+	 * __GFP_HIGH (GFP_ATOMIC & ~__GFP_RECLAIM).
+	 */
+	cb = bpf_map_kmalloc_node(map, size, __GFP_HIGH, map->numa_node);
 	if (!cb) {
 		ret = -ENOMEM;
 		goto out;
-- 
2.51.0




