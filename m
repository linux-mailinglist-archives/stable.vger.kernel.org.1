Return-Path: <stable+bounces-13374-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F711837C43
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:10:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 769D3B2BDF4
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 01:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D7C154BFB;
	Tue, 23 Jan 2024 00:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vOxSZ9sG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB57415445E;
	Tue, 23 Jan 2024 00:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705969394; cv=none; b=Nme4ASf0mO4glKJ4KQvSfYrl/g7CATTU4TMT46VVmNPj1U3InRliNiUFLDWheYpUcYbh04aTDgfw1gPZ/nG8HKmgtF1HRLNCy0w+Qfe/KKbZe59Zl77ViikkZvVCh6zOY6Fb4RTC1o9LdazZX2EeG0BBOMKx996wtZKfjxkznpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705969394; c=relaxed/simple;
	bh=EsApIAujg7pxRwz+O7pudFOz2SJrsJ5bIkrk+HgQknw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z+jCxZUVsy1ujINhYYIYDKZ224XWRmsTjT/IITeg0nZ1PPvgUr+3fXpgfiqXmBUYCr2ZkMo91ebN6oI5vXmHLvavjOwVZwtVIR4P1uqOtDau3DLH8cmH33OJQgLhcve0S5h7LXuLofcXSCR6lsTUHtwV1MK3N9akkcKsOS7s990=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vOxSZ9sG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81324C433B2;
	Tue, 23 Jan 2024 00:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705969394;
	bh=EsApIAujg7pxRwz+O7pudFOz2SJrsJ5bIkrk+HgQknw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vOxSZ9sG0VTiFX0tRMH6PLjRbQ89gKRF1NQRiZVvCC/AJs2cOjGz01AZBFDekyTpi
	 ScaHoHTsKGb2YLNZHAsgTnulDMsv8v8gy9FY/tUOasfffi0LIzFF1brK6599ZiD49U
	 9TLSq+vV8Tg5stEi8LPtrCnWhPcyoinOi3/j/jdw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hou Tao <houtao@huaweicloud.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 183/641] bpf: Fix a race condition between btf_put() and map_free()
Date: Mon, 22 Jan 2024 15:51:27 -0800
Message-ID: <20240122235823.717686988@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235818.091081209@linuxfoundation.org>
References: <20240122235818.091081209@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yonghong Song <yonghong.song@linux.dev>

[ Upstream commit 59e5791f59dd83e8aa72a4e74217eabb6e8cfd90 ]

When running `./test_progs -j` in my local vm with latest kernel,
I once hit a kasan error like below:

  [ 1887.184724] BUG: KASAN: slab-use-after-free in bpf_rb_root_free+0x1f8/0x2b0
  [ 1887.185599] Read of size 4 at addr ffff888106806910 by task kworker/u12:2/2830
  [ 1887.186498]
  [ 1887.186712] CPU: 3 PID: 2830 Comm: kworker/u12:2 Tainted: G           OEL     6.7.0-rc3-00699-g90679706d486-dirty #494
  [ 1887.188034] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
  [ 1887.189618] Workqueue: events_unbound bpf_map_free_deferred
  [ 1887.190341] Call Trace:
  [ 1887.190666]  <TASK>
  [ 1887.190949]  dump_stack_lvl+0xac/0xe0
  [ 1887.191423]  ? nf_tcp_handle_invalid+0x1b0/0x1b0
  [ 1887.192019]  ? panic+0x3c0/0x3c0
  [ 1887.192449]  print_report+0x14f/0x720
  [ 1887.192930]  ? preempt_count_sub+0x1c/0xd0
  [ 1887.193459]  ? __virt_addr_valid+0xac/0x120
  [ 1887.194004]  ? bpf_rb_root_free+0x1f8/0x2b0
  [ 1887.194572]  kasan_report+0xc3/0x100
  [ 1887.195085]  ? bpf_rb_root_free+0x1f8/0x2b0
  [ 1887.195668]  bpf_rb_root_free+0x1f8/0x2b0
  [ 1887.196183]  ? __bpf_obj_drop_impl+0xb0/0xb0
  [ 1887.196736]  ? preempt_count_sub+0x1c/0xd0
  [ 1887.197270]  ? preempt_count_sub+0x1c/0xd0
  [ 1887.197802]  ? _raw_spin_unlock+0x1f/0x40
  [ 1887.198319]  bpf_obj_free_fields+0x1d4/0x260
  [ 1887.198883]  array_map_free+0x1a3/0x260
  [ 1887.199380]  bpf_map_free_deferred+0x7b/0xe0
  [ 1887.199943]  process_scheduled_works+0x3a2/0x6c0
  [ 1887.200549]  worker_thread+0x633/0x890
  [ 1887.201047]  ? __kthread_parkme+0xd7/0xf0
  [ 1887.201574]  ? kthread+0x102/0x1d0
  [ 1887.202020]  kthread+0x1ab/0x1d0
  [ 1887.202447]  ? pr_cont_work+0x270/0x270
  [ 1887.202954]  ? kthread_blkcg+0x50/0x50
  [ 1887.203444]  ret_from_fork+0x34/0x50
  [ 1887.203914]  ? kthread_blkcg+0x50/0x50
  [ 1887.204397]  ret_from_fork_asm+0x11/0x20
  [ 1887.204913]  </TASK>
  [ 1887.204913]  </TASK>
  [ 1887.205209]
  [ 1887.205416] Allocated by task 2197:
  [ 1887.205881]  kasan_set_track+0x3f/0x60
  [ 1887.206366]  __kasan_kmalloc+0x6e/0x80
  [ 1887.206856]  __kmalloc+0xac/0x1a0
  [ 1887.207293]  btf_parse_fields+0xa15/0x1480
  [ 1887.207836]  btf_parse_struct_metas+0x566/0x670
  [ 1887.208387]  btf_new_fd+0x294/0x4d0
  [ 1887.208851]  __sys_bpf+0x4ba/0x600
  [ 1887.209292]  __x64_sys_bpf+0x41/0x50
  [ 1887.209762]  do_syscall_64+0x4c/0xf0
  [ 1887.210222]  entry_SYSCALL_64_after_hwframe+0x63/0x6b
  [ 1887.210868]
  [ 1887.211074] Freed by task 36:
  [ 1887.211460]  kasan_set_track+0x3f/0x60
  [ 1887.211951]  kasan_save_free_info+0x28/0x40
  [ 1887.212485]  ____kasan_slab_free+0x101/0x180
  [ 1887.213027]  __kmem_cache_free+0xe4/0x210
  [ 1887.213514]  btf_free+0x5b/0x130
  [ 1887.213918]  rcu_core+0x638/0xcc0
  [ 1887.214347]  __do_softirq+0x114/0x37e

The error happens at bpf_rb_root_free+0x1f8/0x2b0:

  00000000000034c0 <bpf_rb_root_free>:
  ; {
    34c0: f3 0f 1e fa                   endbr64
    34c4: e8 00 00 00 00                callq   0x34c9 <bpf_rb_root_free+0x9>
    34c9: 55                            pushq   %rbp
    34ca: 48 89 e5                      movq    %rsp, %rbp
  ...
  ;       if (rec && rec->refcount_off >= 0 &&
    36aa: 4d 85 ed                      testq   %r13, %r13
    36ad: 74 a9                         je      0x3658 <bpf_rb_root_free+0x198>
    36af: 49 8d 7d 10                   leaq    0x10(%r13), %rdi
    36b3: e8 00 00 00 00                callq   0x36b8 <bpf_rb_root_free+0x1f8>
                                        <==== kasan function
    36b8: 45 8b 7d 10                   movl    0x10(%r13), %r15d
                                        <==== use-after-free load
    36bc: 45 85 ff                      testl   %r15d, %r15d
    36bf: 78 8c                         js      0x364d <bpf_rb_root_free+0x18d>

So the problem is at rec->refcount_off in the above.

I did some source code analysis and find the reason.
                                  CPU A                        CPU B
  bpf_map_put:
    ...
    btf_put with rcu callback
    ...
    bpf_map_free_deferred
      with system_unbound_wq
    ...                          ...                           ...
    ...                          btf_free_rcu:                 ...
    ...                          ...                           bpf_map_free_deferred:
    ...                          ...
    ...         --------->       btf_struct_metas_free()
    ...         | race condition ...
    ...         --------->                                     map->ops->map_free()
    ...
    ...                          btf->struct_meta_tab = NULL

In the above, map_free() corresponds to array_map_free() and eventually
calling bpf_rb_root_free() which calls:
  ...
  __bpf_obj_drop_impl(obj, field->graph_root.value_rec, false);
  ...

Here, 'value_rec' is assigned in btf_check_and_fixup_fields() with following code:

  meta = btf_find_struct_meta(btf, btf_id);
  if (!meta)
    return -EFAULT;
  rec->fields[i].graph_root.value_rec = meta->record;

So basically, 'value_rec' is a pointer to the record in struct_metas_tab.
And it is possible that that particular record has been freed by
btf_struct_metas_free() and hence we have a kasan error here.

Actually it is very hard to reproduce the failure with current bpf/bpf-next
code, I only got the above error once. To increase reproducibility, I added
a delay in bpf_map_free_deferred() to delay map->ops->map_free(), which
significantly increased reproducibility.

#  diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
#  index 5e43ddd1b83f..aae5b5213e93 100644
#  --- a/kernel/bpf/syscall.c
#  +++ b/kernel/bpf/syscall.c
#  @@ -695,6 +695,7 @@ static void bpf_map_free_deferred(struct work_struct *work)
#        struct bpf_map *map = container_of(work, struct bpf_map, work);
#        struct btf_record *rec = map->record;
#
#  +     mdelay(100);
#        security_bpf_map_free(map);
#        bpf_map_release_memcg(map);
#        /* implementation dependent freeing */

Hao also provided test cases ([1]) for easily reproducing the above issue.

There are two ways to fix the issue, the v1 of the patch ([2]) moving
btf_put() after map_free callback, and the v5 of the patch ([3]) using
a kptr style fix which tries to get a btf reference during
map_check_btf(). Each approach has its pro and cons. The first approach
delays freeing btf while the second approach needs to acquire reference
depending on context which makes logic not very elegant and may
complicate things with future new data structures. Alexei
suggested in [4] going back to v1 which is what this patch
tries to do.

Rerun './test_progs -j' with the above mdelay() hack for a couple
of times and didn't observe the error for the above rb_root test cases.
Running Hou's test ([1]) is also successful.

  [1] https://lore.kernel.org/bpf/20231207141500.917136-1-houtao@huaweicloud.com/
  [2] v1: https://lore.kernel.org/bpf/20231204173946.3066377-1-yonghong.song@linux.dev/
  [3] v5: https://lore.kernel.org/bpf/20231208041621.2968241-1-yonghong.song@linux.dev/
  [4] v4: https://lore.kernel.org/bpf/CAADnVQJ3FiXUhZJwX_81sjZvSYYKCFB3BT6P8D59RS2Gu+0Z7g@mail.gmail.com/

Cc: Hou Tao <houtao@huaweicloud.com>
Fixes: 958cf2e273f0 ("bpf: Introduce bpf_obj_new")
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
Link: https://lore.kernel.org/r/20231214203815.1469107-1-yonghong.song@linux.dev
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/syscall.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index c6579067eeea..6e7e57360b81 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -694,6 +694,7 @@ static void bpf_map_free_deferred(struct work_struct *work)
 {
 	struct bpf_map *map = container_of(work, struct bpf_map, work);
 	struct btf_record *rec = map->record;
+	struct btf *btf = map->btf;
 
 	security_bpf_map_free(map);
 	bpf_map_release_memcg(map);
@@ -709,6 +710,10 @@ static void bpf_map_free_deferred(struct work_struct *work)
 	 * template bpf_map struct used during verification.
 	 */
 	btf_record_free(rec);
+	/* Delay freeing of btf for maps, as map_free callback may need
+	 * struct_meta info which will be freed with btf_put().
+	 */
+	btf_put(btf);
 }
 
 static void bpf_map_put_uref(struct bpf_map *map)
@@ -749,7 +754,6 @@ void bpf_map_put(struct bpf_map *map)
 	if (atomic64_dec_and_test(&map->refcnt)) {
 		/* bpf_map_free_id() must be called first */
 		bpf_map_free_id(map);
-		btf_put(map->btf);
 
 		if (READ_ONCE(map->free_after_mult_rcu_gp))
 			call_rcu_tasks_trace(&map->rcu, bpf_map_free_mult_rcu_gp);
-- 
2.43.0




