Return-Path: <stable+bounces-2539-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA9C27F84C7
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 20:38:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6583A28BC40
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1584F2C1BA;
	Fri, 24 Nov 2023 19:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZdHCEggD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE78C33E9
	for <stable@vger.kernel.org>; Fri, 24 Nov 2023 19:38:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 427D7C433C7;
	Fri, 24 Nov 2023 19:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1700854687;
	bh=DP5NUUdB7xET5l6lwH7jM7TLniHfbNE/zFe/XD/9GvE=;
	h=Date:To:From:Subject:From;
	b=ZdHCEggDoNB33fYCkL3ws255VeIUGnjuT6dE/pw93s3n+XrUB/dAjK/lg2NJ3Q8WG
	 FdhKQfBTXgLwao4fDlgGPShHdt1csKT0qBkkN7McHMD7by7FgOqbY72RYSaK7K0YHs
	 BOZcl1y8BsnyCPcBZHnKBGSb4jPU3yW07sVOI38I=
Date: Fri, 24 Nov 2023 11:38:06 -0800
To: mm-commits@vger.kernel.org,surenb@google.com,stable@vger.kernel.org,mhocko@suse.com,gaoxu2@hihonor.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: [nacked] mmoom_reaper-avoid-run-queue_oom_reaper-if-task-is-not-oom.patch removed from -mm tree
Message-Id: <20231124193807.427D7C433C7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>


The quilt patch titled
     Subject: mm,oom_reaper: avoid run queue_oom_reaper if task is not oom
has been removed from the -mm tree.  Its filename was
     mmoom_reaper-avoid-run-queue_oom_reaper-if-task-is-not-oom.patch

This patch was dropped because it was nacked

------------------------------------------------------
From: gaoxu <gaoxu2@hihonor.com>
Subject: mm,oom_reaper: avoid run queue_oom_reaper if task is not oom
Date: Wed, 22 Nov 2023 12:46:44 +0000

queue_oom_reaper() tests and sets tsk->signal->oom_mm->flags.  However, it
is necessary to check if 'tsk' is an OOM victim before executing
'queue_oom_reaper' because the variable may be NULL.

We encountered such an issue, and the log is as follows:
[3701:11_see]Out of memory: Killed process 3154 (system_server)
total-vm:23662044kB, anon-rss:0kB, file-rss:0kB, shmem-rss:0kB,
UID:1000 pgtables:4056kB oom_score_adj:-900
[3701:11_see][RB/E]rb_sreason_str_set: sreason_str set null_pointer
[3701:11_see][RB/E]rb_sreason_str_set: sreason_str set unknown_addr
[3701:11_see]Unable to handle kernel NULL pointer dereference at virtual
address 0000000000000328
[3701:11_see]user pgtable: 4k pages, 39-bit VAs, pgdp=3D00000000821de000
[3701:11_see][0000000000000328] pgd=3D0000000000000000,
p4d=3D0000000000000000,pud=3D0000000000000000
[3701:11_see]tracing off
[3701:11_see]Internal error: Oops: 96000005 [#1] PREEMPT SMP
[3701:11_see]Call trace:
[3701:11_see] queue_oom_reaper+0x30/0x170
[3701:11_see] __oom_kill_process+0x590/0x860
[3701:11_see] oom_kill_process+0x140/0x274
[3701:11_see] out_of_memory+0x2f4/0x54c
[3701:11_see] __alloc_pages_slowpath+0x5d8/0xaac
[3701:11_see] __alloc_pages+0x774/0x800
[3701:11_see] wp_page_copy+0xc4/0x116c
[3701:11_see] do_wp_page+0x4bc/0x6fc
[3701:11_see] handle_pte_fault+0x98/0x2a8
[3701:11_see] __handle_mm_fault+0x368/0x700
[3701:11_see] do_handle_mm_fault+0x160/0x2cc
[3701:11_see] do_page_fault+0x3e0/0x818
[3701:11_see] do_mem_abort+0x68/0x17c
[3701:11_see] el0_da+0x3c/0xa0
[3701:11_see] el0t_64_sync_handler+0xc4/0xec
[3701:11_see] el0t_64_sync+0x1b4/0x1b8
[3701:11_see]tracing off

Link: https://lkml.kernel.org/r/400d13bddb524ef6af37cb2220808c75@hihonor.com
Signed-off-by: Gao Xu <gaoxu2@hihonor.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/oom_kill.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/mm/oom_kill.c~mmoom_reaper-avoid-run-queue_oom_reaper-if-task-is-not-oom
+++ a/mm/oom_kill.c
@@ -984,7 +984,7 @@ static void __oom_kill_process(struct ta
 	}
 	rcu_read_unlock();
 
-	if (can_oom_reap)
+	if (can_oom_reap && tsk_is_oom_victim(victim))
 		queue_oom_reaper(victim);
 
 	mmdrop(mm);
_

Patches currently in -mm which might be from gaoxu2@hihonor.com are



