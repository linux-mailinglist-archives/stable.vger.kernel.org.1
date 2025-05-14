Return-Path: <stable+bounces-144329-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 740CDAB6372
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 08:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 952AC7B42D7
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 06:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B82C1E9B07;
	Wed, 14 May 2025 06:47:44 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9868817583;
	Wed, 14 May 2025 06:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747205264; cv=none; b=OmVKaa/XTCRaOD0FucjzcEIv9R36bheMCFJv0QVIUnVjGz4cycu3cjq6M0+5j11s+BtHA9Fg66got3pw0e4aTEr5co7tQdqyowfcJfkBK7eebDs5TRfVSu0bQpizEcNfcPbwbhJofZ4zYPKCyFPHI5toDNii/lLcvDgVt+HfBD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747205264; c=relaxed/simple;
	bh=Pn0/7ryZG2o71oq4Vi8VUKZpzX00/FgZwyYXhVHNRqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FF61LgWrVBusiYwUndX8sM28kyQqkjWgeHDIhokUm2vMRk0ZWlgeY22uYKz2y616gy4e/gLX6ITKcHQmsJ0UaAhpLtKXENwkia2616brmf4yXUxJc5777SMSYyTIT/ZzyT1htLBJ1liwfqQg1lYySmPvxRcEEHG0h55d1xn2ei4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-2b-68243c86168a
Date: Wed, 14 May 2025 15:47:29 +0900
From: Byungchul Park <byungchul@sk.com>
To: Gavin Guo <gavinguo@igalia.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, muchun.song@linux.dev,
	osalvador@suse.de, akpm@linux-foundation.org,
	mike.kravetz@oracle.com, kernel-dev@igalia.com,
	stable@vger.kernel.org, Hugh Dickins <hughd@google.com>,
	Florent Revest <revest@google.com>, Gavin Shan <gshan@redhat.com>,
	kernel_team@skhynix.com
Subject: Re: [PATCH] mm/hugetlb: fix a deadlock with pagecache_folio and
 hugetlb_fault_mutex_table
Message-ID: <20250514064729.GA17622@system.software.com>
References: <20250513093448.592150-1-gavinguo@igalia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250513093448.592150-1-gavinguo@igalia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOIsWRmVeSWpSXmKPExsXC9ZZnkW6bjUqGwd+VUhZz1q9hs1iy9gyz
	xctd25gsnn7qY7E49+I7k8XlXXPYLO6t+c9q8XF/sMWynQ9ZLM5MK7LonvmD1WLBxkeMDjwe
	CzaVekyY3c3msenTJHaPEzN+s3gsbJjK7PHx6S0Wj/f7rrJ5bD5d7fF5k1wAZxSXTUpqTmZZ
	apG+XQJXxv6rt9kLlvtV7OmaydzA2G3XxcjJISFgIrFt60IWGPvNq4mMIDaLgKrEvXP7wOJs
	AuoSN278ZAaxRQSUJT5MOQgU5+JgFjjBJHFx3iJ2kISwQIrEtQPbwBp4BSwkDr+9AGRzcAgJ
	WEpcn+8MERaUODnzCVgJM9DMP/MuMYOUMAtISyz/xwERlpdo3jobbBWngJXEsq0Q5aJAaw9s
	O84EslZC4DubxJFjr5ghbpaUOLjiBssERsFZSFbMQrJiFsKKWUhWLGBkWcUolJlXlpuYmWOi
	l1GZl1mhl5yfu4kRGF3Lav9E72D8dCH4EKMAB6MSD6+FrnKGEGtiWXFl7iFGCQ5mJRHe61lA
	Id6UxMqq1KL8+KLSnNTiQ4zSHCxK4rxG38pThATSE0tSs1NTC1KLYLJMHJxSDYw1Gbnfk4WV
	mUzsdrz3qzhk8TlGpPfQ5iQT1+gXIslnf+SePL71x6xHsvumHQhXvXtOfdn5RyJi0syPFqYv
	/j6z3PvA5m73rENTrxzp3mLhV7C1UN5Ix7iXu/vy0sZFfROvdEYwlc2unaecJniZffphqVn7
	fR4kNF1LPCIkfezUzhf/bX47+ixVYinOSDTUYi4qTgQAwToKqKoCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHLMWRmVeSWpSXmKPExsXC5WfdrNtmo5Jh0HeV22LO+jVsFkvWnmG2
	eLlrG5PF0099LBbnXnxnsjg89ySrxeVdc9gs7q35z2rxcX+wxbKdD1kszkwrsuie+YPVYsHG
	R4wOvB4LNpV6TJjdzeax6dMkdo8TM36zeCxsmMrs8fHpLRaP9/uusnksfvGByWPz6WqPz5vk
	AriiuGxSUnMyy1KL9O0SuDL2X73NXrDcr2JP10zmBsZuuy5GTg4JAROJN68mMoLYLAKqEvfO
	7WMBsdkE1CVu3PjJDGKLCChLfJhyECjOxcEscIJJ4uK8RewgCWGBFIlrB7aBNfAKWEgcfnsB
	yObgEBKwlLg+3xkiLChxcuYTsBJmoJl/5l1iBilhFpCWWP6PAyIsL9G8dTbYKk4BK4llWyHK
	RYHWHth2nGkCI98sJJNmIZk0C2HSLCSTFjCyrGIUycwry03MzDHVK87OqMzLrNBLzs/dxAiM
	lWW1fybuYPxy2f0QowAHoxIPr4WucoYQa2JZcWXuIUYJDmYlEd7rWUAh3pTEyqrUovz4otKc
	1OJDjNIcLErivF7hqQlCAumJJanZqakFqUUwWSYOTqkGxvOss2zEJCc92nC5Ztk9n01tu4Ju
	zQ9+O72i66GSqNG2Ns+CblUVp9ZDKVufX311gseU8f2fY1xuD78umv3jftge/YcqGw4lBCQc
	6fy4+4Ct79xLn5eYqUU5a/cl1Yi/qozc8cL4qYlta/K3f/cN605c3XrboJT7wkaT3EvFszlu
	N0foT3vr0afEUpyRaKjFXFScCABBztgikQIAAA==
X-CFilter-Loop: Reflected

On Tue, May 13, 2025 at 05:34:48PM +0800, Gavin Guo wrote:
> The patch fixes a deadlock which can be triggered by an internal
> syzkaller [1] reproducer and captured by bpftrace script [2] and its log

Hi,

I'm trying to reproduce using the test program [1].  But not yet
produced.  I see a lot of segfaults while running [1].  I guess
something goes wrong.  Is there any prerequisite condition to reproduce
it?  Lemme know if any.  Or can you try DEPT15 with your config and
environment by the following steps:

   1. Apply the patchset on v6.15-rc6.
      https://lkml.kernel.org/r/20250513100730.12664-1-byungchul@sk.com
   2. Turn on CONFIG_DEPT.
   3. Run test program reproducing the deadlock.
   4. Check dmesg to see if dept reported the dependency.

	Byungchul

> [3] in this scenario:
> 
> Process 1                              Process 2
> ---				       ---
> hugetlb_fault
>   mutex_lock(B) // take B
>   filemap_lock_hugetlb_folio
>     filemap_lock_folio
>       __filemap_get_folio
>         folio_lock(A) // take A
>   hugetlb_wp
>     mutex_unlock(B) // release B
>     ...                                hugetlb_fault
>     ...                                  mutex_lock(B) // take B
>                                          filemap_lock_hugetlb_folio
>                                            filemap_lock_folio
>                                              __filemap_get_folio
>                                                folio_lock(A) // blocked
>     unmap_ref_private
>     ...
>     mutex_lock(B) // retake and blocked
> 
> This is a ABBA deadlock involving two locks:
> - Lock A: pagecache_folio lock
> - Lock B: hugetlb_fault_mutex_table lock
> 
> The deadlock occurs between two processes as follows:
> 1. The first process (let’s call it Process 1) is handling a
> copy-on-write (COW) operation on a hugepage via hugetlb_wp. Due to
> insufficient reserved hugetlb pages, Process 1, owner of the reserved
> hugetlb page, attempts to unmap a hugepage owned by another process
> (non-owner) to satisfy the reservation. Before unmapping, Process 1
> acquires lock B (hugetlb_fault_mutex_table lock) and then lock A
> (pagecache_folio lock). To proceed with the unmap, it releases Lock B
> but retains Lock A. After the unmap, Process 1 tries to reacquire Lock
> B. However, at this point, Lock B has already been acquired by another
> process.
> 
> 2. The second process (Process 2) enters the hugetlb_fault handler
> during the unmap operation. It successfully acquires Lock B
> (hugetlb_fault_mutex_table lock) that was just released by Process 1,
> but then attempts to acquire Lock A (pagecache_folio lock), which is
> still held by Process 1.
> 
> As a result, Process 1 (holding Lock A) is blocked waiting for Lock B
> (held by Process 2), while Process 2 (holding Lock B) is blocked waiting
> for Lock A (held by Process 1), constructing a ABBA deadlock scenario.
> 
> The solution here is to unlock the pagecache_folio and provide the
> pagecache_folio_unlocked variable to the caller to have the visibility
> over the pagecache_folio status for subsequent handling.
> 
> The error message:
> INFO: task repro_20250402_:13229 blocked for more than 64 seconds.
>       Not tainted 6.15.0-rc3+ #24
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:repro_20250402_ state:D stack:25856 pid:13229 tgid:13228 ppid:3513   task_flags:0x400040 flags:0x00004006
> Call Trace:
>  <TASK>
>  __schedule+0x1755/0x4f50
>  schedule+0x158/0x330
>  schedule_preempt_disabled+0x15/0x30
>  __mutex_lock+0x75f/0xeb0
>  hugetlb_wp+0xf88/0x3440
>  hugetlb_fault+0x14c8/0x2c30
>  trace_clock_x86_tsc+0x20/0x20
>  do_user_addr_fault+0x61d/0x1490
>  exc_page_fault+0x64/0x100
>  asm_exc_page_fault+0x26/0x30
> RIP: 0010:__put_user_4+0xd/0x20
>  copy_process+0x1f4a/0x3d60
>  kernel_clone+0x210/0x8f0
>  __x64_sys_clone+0x18d/0x1f0
>  do_syscall_64+0x6a/0x120
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> RIP: 0033:0x41b26d
>  </TASK>
> INFO: task repro_20250402_:13229 is blocked on a mutex likely owned by task repro_20250402_:13250.
> task:repro_20250402_ state:D stack:28288 pid:13250 tgid:13228 ppid:3513   task_flags:0x400040 flags:0x00000006
> Call Trace:
>  <TASK>
>  __schedule+0x1755/0x4f50
>  schedule+0x158/0x330
>  io_schedule+0x92/0x110
>  folio_wait_bit_common+0x69a/0xba0
>  __filemap_get_folio+0x154/0xb70
>  hugetlb_fault+0xa50/0x2c30
>  trace_clock_x86_tsc+0x20/0x20
>  do_user_addr_fault+0xace/0x1490
>  exc_page_fault+0x64/0x100
>  asm_exc_page_fault+0x26/0x30
> RIP: 0033:0x402619
>  </TASK>
> INFO: task repro_20250402_:13250 blocked for more than 65 seconds.
>       Not tainted 6.15.0-rc3+ #24
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:repro_20250402_ state:D stack:28288 pid:13250 tgid:13228 ppid:3513   task_flags:0x400040 flags:0x00000006
> Call Trace:
>  <TASK>
>  __schedule+0x1755/0x4f50
>  schedule+0x158/0x330
>  io_schedule+0x92/0x110
>  folio_wait_bit_common+0x69a/0xba0
>  __filemap_get_folio+0x154/0xb70
>  hugetlb_fault+0xa50/0x2c30
>  trace_clock_x86_tsc+0x20/0x20
>  do_user_addr_fault+0xace/0x1490
>  exc_page_fault+0x64/0x100
>  asm_exc_page_fault+0x26/0x30
> RIP: 0033:0x402619
>  </TASK>
> 
> Showing all locks held in the system:
> 1 lock held by khungtaskd/35:
>  #0: ffffffff879a7440 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x30/0x180
> 2 locks held by repro_20250402_/13229:
>  #0: ffff888017d801e0 (&mm->mmap_lock){++++}-{4:4}, at: lock_mm_and_find_vma+0x37/0x300
>  #1: ffff888000fec848 (&hugetlb_fault_mutex_table[i]){+.+.}-{4:4}, at: hugetlb_wp+0xf88/0x3440
> 3 locks held by repro_20250402_/13250:
>  #0: ffff8880177f3d08 (vm_lock){++++}-{0:0}, at: do_user_addr_fault+0x41b/0x1490
>  #1: ffff888000fec848 (&hugetlb_fault_mutex_table[i]){+.+.}-{4:4}, at: hugetlb_fault+0x3b8/0x2c30
>  #2: ffff8880129500e8 (&resv_map->rw_sema){++++}-{4:4}, at: hugetlb_fault+0x494/0x2c30
> 
> Link: https://drive.google.com/file/d/1DVRnIW-vSayU5J1re9Ct_br3jJQU6Vpb/view?usp=drive_link [1]
> Link: https://github.com/bboymimi/bpftracer/blob/master/scripts/hugetlb_lock_debug.bt [2]
> Link: https://drive.google.com/file/d/1bWq2-8o-BJAuhoHWX7zAhI6ggfhVzQUI/view?usp=sharing [3]
> Fixes: 40549ba8f8e0 ("hugetlb: use new vma_lock for pmd sharing synchronization")
> Cc: <stable@vger.kernel.org>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Florent Revest <revest@google.com>
> Cc: Gavin Shan <gshan@redhat.com>
> Signed-off-by: Gavin Guo <gavinguo@igalia.com>
> ---
>  mm/hugetlb.c | 33 ++++++++++++++++++++++++++++-----
>  1 file changed, 28 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index e3e6ac991b9c..ad54a74aa563 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -6115,7 +6115,8 @@ static void unmap_ref_private(struct mm_struct *mm, struct vm_area_struct *vma,
>   * Keep the pte_same checks anyway to make transition from the mutex easier.
>   */
>  static vm_fault_t hugetlb_wp(struct folio *pagecache_folio,
> -		       struct vm_fault *vmf)
> +		       struct vm_fault *vmf,
> +		       bool *pagecache_folio_unlocked)
>  {
>  	struct vm_area_struct *vma = vmf->vma;
>  	struct mm_struct *mm = vma->vm_mm;
> @@ -6212,6 +6213,22 @@ static vm_fault_t hugetlb_wp(struct folio *pagecache_folio,
>  			u32 hash;
>  
>  			folio_put(old_folio);
> +			/*
> +			 * The pagecache_folio needs to be unlocked to avoid
> +			 * deadlock and we won't re-lock it in hugetlb_wp(). The
> +			 * pagecache_folio could be truncated after being
> +			 * unlocked. So its state should not be relied
> +			 * subsequently.
> +			 *
> +			 * Setting *pagecache_folio_unlocked to true allows the
> +			 * caller to handle any necessary logic related to the
> +			 * folio's unlocked state.
> +			 */
> +			if (pagecache_folio) {
> +				folio_unlock(pagecache_folio);
> +				if (pagecache_folio_unlocked)
> +					*pagecache_folio_unlocked = true;
> +			}
>  			/*
>  			 * Drop hugetlb_fault_mutex and vma_lock before
>  			 * unmapping.  unmapping needs to hold vma_lock
> @@ -6566,7 +6583,7 @@ static vm_fault_t hugetlb_no_page(struct address_space *mapping,
>  	hugetlb_count_add(pages_per_huge_page(h), mm);
>  	if ((vmf->flags & FAULT_FLAG_WRITE) && !(vma->vm_flags & VM_SHARED)) {
>  		/* Optimization, do the COW without a second fault */
> -		ret = hugetlb_wp(folio, vmf);
> +		ret = hugetlb_wp(folio, vmf, NULL);
>  	}
>  
>  	spin_unlock(vmf->ptl);
> @@ -6638,6 +6655,7 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
>  	struct hstate *h = hstate_vma(vma);
>  	struct address_space *mapping;
>  	int need_wait_lock = 0;
> +	bool pagecache_folio_unlocked = false;
>  	struct vm_fault vmf = {
>  		.vma = vma,
>  		.address = address & huge_page_mask(h),
> @@ -6792,7 +6810,8 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
>  
>  	if (flags & (FAULT_FLAG_WRITE|FAULT_FLAG_UNSHARE)) {
>  		if (!huge_pte_write(vmf.orig_pte)) {
> -			ret = hugetlb_wp(pagecache_folio, &vmf);
> +			ret = hugetlb_wp(pagecache_folio, &vmf,
> +					&pagecache_folio_unlocked);
>  			goto out_put_page;
>  		} else if (likely(flags & FAULT_FLAG_WRITE)) {
>  			vmf.orig_pte = huge_pte_mkdirty(vmf.orig_pte);
> @@ -6809,10 +6828,14 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
>  out_ptl:
>  	spin_unlock(vmf.ptl);
>  
> -	if (pagecache_folio) {
> +	/*
> +	 * If the pagecache_folio is unlocked in hugetlb_wp(), we skip
> +	 * folio_unlock() here.
> +	 */
> +	if (pagecache_folio && !pagecache_folio_unlocked)
>  		folio_unlock(pagecache_folio);
> +	if (pagecache_folio)
>  		folio_put(pagecache_folio);
> -	}
>  out_mutex:
>  	hugetlb_vma_unlock_read(vma);
>  
> 
> base-commit: d76bb1ebb5587f66b0f8b8099bfbb44722bc08b3
> -- 
> 2.43.0
> 

