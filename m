Return-Path: <stable+bounces-146320-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1251AAC38C2
	for <lists+stable@lfdr.de>; Mon, 26 May 2025 06:42:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D79891886E05
	for <lists+stable@lfdr.de>; Mon, 26 May 2025 04:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB8B1B6D08;
	Mon, 26 May 2025 04:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rjrfjb6J"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501541A8F84
	for <stable@vger.kernel.org>; Mon, 26 May 2025 04:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748234509; cv=none; b=YRHqyCZUOBs5g6xptRHtjhUUfajquSa8IhpqYT5IMpIy/OvYSQMEQyVBm2fKWpJ7BDg/PDBnci+qPHgOfCP4Izw3LnC03u+A0nPgiyRB6yqVv8axHKP3GsgBMnqnuy1lW6sWib9NwmvjU9Hzq8IWOuMtlVe05jOyMVPHGA77zVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748234509; c=relaxed/simple;
	bh=YDeHe8kqcOz/BRNrmtmnFmuqih2VqSBHIvieakM/3Gg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=swEjgMLjWDw4E3FO3B20UyXsx/LuCBNV+Ov+d0Nm0QR458n8QlQVPAlkh6gavqV6ojhZSkTQMRMZWnEYQgkiI8e9ayJgf45as04jFtNM/2ivOwdKoK17WbTS4zuAWZh4LATPqefHxwt6816T7B14U/V7Nbf59d0SadW0CI5KY84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rjrfjb6J; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748234506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y6pa9Sy4TFu6ZV+BNqQ+Tm2rYejLcpHsKDhorOQOZPY=;
	b=Rjrfjb6Jc0/FjFIUUQbD8dvEluIUgpN4bDJ/KFlfQq3NbTjaEqaTbojVnc68afS3flf9/M
	5jrXkN0V2+o+iZJFF3JiqaSOTQHc0s0fFuyYfc5fh6UTngSKOqG4kCt2idp1P99N4fxog5
	y5ARFHGNsCvNJoS6aNXiYIGecmpMUJA=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-456-l2SaOGTWO9CsJ5Cczyy7WA-1; Mon, 26 May 2025 00:41:44 -0400
X-MC-Unique: l2SaOGTWO9CsJ5Cczyy7WA-1
X-Mimecast-MFC-AGG-ID: l2SaOGTWO9CsJ5Cczyy7WA_1748234504
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2323bd7f873so16475245ad.1
        for <stable@vger.kernel.org>; Sun, 25 May 2025 21:41:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748234499; x=1748839299;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y6pa9Sy4TFu6ZV+BNqQ+Tm2rYejLcpHsKDhorOQOZPY=;
        b=PlXpWU4bhf2WX2Ha2+oOYEiLyx5SEJrV03/7eYHPILqliroSPh7VExl4D3BYejGNKv
         MAckqt/EmFAtdgq4LlL27Av0QVLIJ5rtz7zBTzww9pkspW12aHjvfDwjBM4Vn0r0PrNM
         m6wwzZcfrTjkpDWeHUhvO85NFG21zV8TeMv8NVolhqn8hKvLICWWwdi+9/wNxKesbU4U
         zG2Rjyk69U0UuDngIziotbgh7FpYxgUQfpujnuJKPBHNnLTb3fUHfbGZFRWfoLUuNSB/
         o7J0wjD6woTf9x0HC3GYFB+C3CEmFob4eu8J5qx1PJgIaQeCQn1IGI37o0w3uh0ejt7+
         08NQ==
X-Forwarded-Encrypted: i=1; AJvYcCXz2hmf0SHH6Rcl/t1LmpN9coxooZj1g7jBZjcfYk7u+WH/L6/BMiK6ht/z/2JOUbP2M1en2LQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/kpst3Lqocbg7HrbMzUF4k40AfCsr9shcRP5CbANW+e9hj8xC
	m3kFKyHe+dFVkjuFiyOU0gqDGOfN+I0x9zJ4mnoiYObev/w1dYeOn0Fe5ejcgxeP2fGA6Nz7KE/
	O0KI7D2INeyVJ3yRGnoypI3aTX0QUih9WnPAgp0MNCWYqNugguhnzGBEVPQ==
X-Gm-Gg: ASbGnctfYc0JKT1Q11u3gp8fMl/LPB3X9dCXSjZJ3pUzHZSZbToDfKpH1PtQxHwIKnH
	baZ6//I7RsWB0boYgQPBQIV7SzXpFGR2vE4Zo4g5kmOZj8lBH1UDC1bXWWkEsonWZuk4P4mA+sC
	hFOkWZtrByv+GBypRe4VltDDtw3jdszkqMGLnAtMFdye4gr5DGBHOig1VHu4JClbBmtY8F6zIt5
	4snENnKj50Mdt+0ebbvP/ff902ZGHKnAQ4Lu8VRHqhsPGfj5UKZ7hQZMAHTWeHXBDAH/HZrFFW9
	kN/7OLQEmBij
X-Received: by 2002:a17:903:46ce:b0:22e:72fe:5f9c with SMTP id d9443c01a7336-23414fc85f8mr109785475ad.42.1748234498293;
        Sun, 25 May 2025 21:41:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZhau8mYuM3muGotB9IVrJ2jRkpOlLJp1Uty1Nel7gBEru3MSknumERjnQHYIw50ZaY9K6dQ==
X-Received: by 2002:a17:903:46ce:b0:22e:72fe:5f9c with SMTP id d9443c01a7336-23414fc85f8mr109785215ad.42.1748234497818;
        Sun, 25 May 2025 21:41:37 -0700 (PDT)
Received: from [192.168.68.51] ([180.233.125.65])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23426898297sm27846695ad.245.2025.05.25.21.41.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 May 2025 21:41:37 -0700 (PDT)
Message-ID: <5f5d8f85-c082-4cb9-93ef-d207309ba807@redhat.com>
Date: Mon, 26 May 2025 14:41:31 +1000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/hugetlb: fix a deadlock with pagecache_folio and
 hugetlb_fault_mutex_table
To: Gavin Guo <gavinguo@igalia.com>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, muchun.song@linux.dev, osalvador@suse.de,
 akpm@linux-foundation.org, mike.kravetz@oracle.com, kernel-dev@igalia.com,
 stable@vger.kernel.org, Hugh Dickins <hughd@google.com>,
 Florent Revest <revest@google.com>
References: <20250513093448.592150-1-gavinguo@igalia.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20250513093448.592150-1-gavinguo@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Gavin,

On 5/13/25 7:34 PM, Gavin Guo wrote:
> The patch fixes a deadlock which can be triggered by an internal
> syzkaller [1] reproducer and captured by bpftrace script [2] and its log
> [3] in this scenario:
> 
> Process 1                              Process 2
> ---				       ---
> hugetlb_fault
>    mutex_lock(B) // take B
>    filemap_lock_hugetlb_folio
>      filemap_lock_folio
>        __filemap_get_folio
>          folio_lock(A) // take A
>    hugetlb_wp
>      mutex_unlock(B) // release B
>      ...                                hugetlb_fault
>      ...                                  mutex_lock(B) // take B
>                                           filemap_lock_hugetlb_folio
>                                             filemap_lock_folio
>                                               __filemap_get_folio
>                                                 folio_lock(A) // blocked
>      unmap_ref_private
>      ...
>      mutex_lock(B) // retake and blocked
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
>        Not tainted 6.15.0-rc3+ #24
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:repro_20250402_ state:D stack:25856 pid:13229 tgid:13228 ppid:3513   task_flags:0x400040 flags:0x00004006
> Call Trace:
>   <TASK>
>   __schedule+0x1755/0x4f50
>   schedule+0x158/0x330
>   schedule_preempt_disabled+0x15/0x30
>   __mutex_lock+0x75f/0xeb0
>   hugetlb_wp+0xf88/0x3440
>   hugetlb_fault+0x14c8/0x2c30
>   trace_clock_x86_tsc+0x20/0x20
>   do_user_addr_fault+0x61d/0x1490
>   exc_page_fault+0x64/0x100
>   asm_exc_page_fault+0x26/0x30
> RIP: 0010:__put_user_4+0xd/0x20
>   copy_process+0x1f4a/0x3d60
>   kernel_clone+0x210/0x8f0
>   __x64_sys_clone+0x18d/0x1f0
>   do_syscall_64+0x6a/0x120
>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
> RIP: 0033:0x41b26d
>   </TASK>
> INFO: task repro_20250402_:13229 is blocked on a mutex likely owned by task repro_20250402_:13250.
> task:repro_20250402_ state:D stack:28288 pid:13250 tgid:13228 ppid:3513   task_flags:0x400040 flags:0x00000006
> Call Trace:
>   <TASK>
>   __schedule+0x1755/0x4f50
>   schedule+0x158/0x330
>   io_schedule+0x92/0x110
>   folio_wait_bit_common+0x69a/0xba0
>   __filemap_get_folio+0x154/0xb70
>   hugetlb_fault+0xa50/0x2c30
>   trace_clock_x86_tsc+0x20/0x20
>   do_user_addr_fault+0xace/0x1490
>   exc_page_fault+0x64/0x100
>   asm_exc_page_fault+0x26/0x30
> RIP: 0033:0x402619
>   </TASK>
> INFO: task repro_20250402_:13250 blocked for more than 65 seconds.
>        Not tainted 6.15.0-rc3+ #24
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:repro_20250402_ state:D stack:28288 pid:13250 tgid:13228 ppid:3513   task_flags:0x400040 flags:0x00000006
> Call Trace:
>   <TASK>
>   __schedule+0x1755/0x4f50
>   schedule+0x158/0x330
>   io_schedule+0x92/0x110
>   folio_wait_bit_common+0x69a/0xba0
>   __filemap_get_folio+0x154/0xb70
>   hugetlb_fault+0xa50/0x2c30
>   trace_clock_x86_tsc+0x20/0x20
>   do_user_addr_fault+0xace/0x1490
>   exc_page_fault+0x64/0x100
>   asm_exc_page_fault+0x26/0x30
> RIP: 0033:0x402619
>   </TASK>
> 
> Showing all locks held in the system:
> 1 lock held by khungtaskd/35:
>   #0: ffffffff879a7440 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x30/0x180
> 2 locks held by repro_20250402_/13229:
>   #0: ffff888017d801e0 (&mm->mmap_lock){++++}-{4:4}, at: lock_mm_and_find_vma+0x37/0x300
>   #1: ffff888000fec848 (&hugetlb_fault_mutex_table[i]){+.+.}-{4:4}, at: hugetlb_wp+0xf88/0x3440
> 3 locks held by repro_20250402_/13250:
>   #0: ffff8880177f3d08 (vm_lock){++++}-{0:0}, at: do_user_addr_fault+0x41b/0x1490
>   #1: ffff888000fec848 (&hugetlb_fault_mutex_table[i]){+.+.}-{4:4}, at: hugetlb_fault+0x3b8/0x2c30
>   #2: ffff8880129500e8 (&resv_map->rw_sema){++++}-{4:4}, at: hugetlb_fault+0x494/0x2c30
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
>   mm/hugetlb.c | 33 ++++++++++++++++++++++++++++-----
>   1 file changed, 28 insertions(+), 5 deletions(-)
> 

I guess the change log can become concise after the kernel log is dropped. The summarized
stack trace is sufficient to indicate how the dead locking scenario happens. Besides,
it's no need to mention bpftrace and its output. So the changelog would be simplified
to something like below. Please polish it a bit if you would to take it. The solution
looks good except some nitpicks as below.

---

There is ABBA dead locking scenario happening between hugetlb_fault() and hugetlb_wp() on
the pagecache folio's lock and hugetlb global mutex, which is reproducible with syzkaller
[1]. As below stack traces reveal, process-1 tries to take the hugetlb global mutex (A3),
but with the pagecache folio's lock hold. Process-2 took the hugetlb global mutex but tries
to take the pagecache folio's lock.

[1] https://drive.google.com/file/d/1DVRnIW-vSayU5J1re9Ct_br3jJQU6Vpb/view?usp=drive_link

Process-1                                       Process-2
=========                                       =========
hugetlb_fault
   mutex_lock                  (A1)
   filemap_lock_hugetlb_folio  (B1)
   hugetlb_wp
     alloc_hugetlb_folio       #error
       mutex_unlock            (A2)
                                                hugetlb_fault
                                                  mutex_lock                  (A4)
                                                  filemap_lock_hugetlb_folio  (B4)
       unmap_ref_private
       mutex_lock              (A3)

Fix it by releasing the pagecache folio's lock at (A2) of process-1 so that pagecache folio's
lock is available to process-2 at (B4), to avoid the deadlock. In process-1, a new variable
is added to track if the pagecache folio's lock has been released by its child function
hugetlb_wp() to avoid double releases on the lock in hugetlb_fault(). The similar changes
are applied to hugetlb_no_page().

> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index e3e6ac991b9c..ad54a74aa563 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -6115,7 +6115,8 @@ static void unmap_ref_private(struct mm_struct *mm, struct vm_area_struct *vma,
>    * Keep the pte_same checks anyway to make transition from the mutex easier.
>    */
>   static vm_fault_t hugetlb_wp(struct folio *pagecache_folio,
> -		       struct vm_fault *vmf)
> +		       struct vm_fault *vmf,
> +		       bool *pagecache_folio_unlocked)

Nitpick: the variable may be renamed to 'pagecache_folio_locked' if you're happy
with.

>   {
>   	struct vm_area_struct *vma = vmf->vma;
>   	struct mm_struct *mm = vma->vm_mm;
> @@ -6212,6 +6213,22 @@ static vm_fault_t hugetlb_wp(struct folio *pagecache_folio,
>   			u32 hash;
>   
>   			folio_put(old_folio);
> +			/*
> +			 * The pagecache_folio needs to be unlocked to avoid
                                                ^^^^^^^^

                                                has to be (?)

> +			 * deadlock and we won't re-lock it in hugetlb_wp(). The
> +			 * pagecache_folio could be truncated after being
> +			 * unlocked. So its state should not be relied
                                                                 ^^^^^^
                                                                 reliable (?)
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

The second section of the comments looks a bit redundant since the code changes
are self-explaining enough :-)

>   			/*
>   			 * Drop hugetlb_fault_mutex and vma_lock before
>   			 * unmapping.  unmapping needs to hold vma_lock
> @@ -6566,7 +6583,7 @@ static vm_fault_t hugetlb_no_page(struct address_space *mapping,
>   	hugetlb_count_add(pages_per_huge_page(h), mm);
>   	if ((vmf->flags & FAULT_FLAG_WRITE) && !(vma->vm_flags & VM_SHARED)) {
>   		/* Optimization, do the COW without a second fault */
> -		ret = hugetlb_wp(folio, vmf);
> +		ret = hugetlb_wp(folio, vmf, NULL);

It's not certain if we have another deadlock between hugetlb_no_page() and hugetlb_wp(),
similar to the existing one between hugetlb_fault() and hugetlb_wp(). So I think it's
reasonable to pass '&pagecache_folio_locked' to hugetlb_wp() here and skip to unlock
on pagecache_folio_locked == false in hugetlb_no_page(). It's not harmful at least.

>   	}
>   
>   	spin_unlock(vmf->ptl);
> @@ -6638,6 +6655,7 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
>   	struct hstate *h = hstate_vma(vma);
>   	struct address_space *mapping;
>   	int need_wait_lock = 0;
> +	bool pagecache_folio_unlocked = false;
>   	struct vm_fault vmf = {
>   		.vma = vma,
>   		.address = address & huge_page_mask(h),
> @@ -6792,7 +6810,8 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
>   
>   	if (flags & (FAULT_FLAG_WRITE|FAULT_FLAG_UNSHARE)) {
>   		if (!huge_pte_write(vmf.orig_pte)) {
> -			ret = hugetlb_wp(pagecache_folio, &vmf);
> +			ret = hugetlb_wp(pagecache_folio, &vmf,
> +					&pagecache_folio_unlocked);
>   			goto out_put_page;
>   		} else if (likely(flags & FAULT_FLAG_WRITE)) {
>   			vmf.orig_pte = huge_pte_mkdirty(vmf.orig_pte);
> @@ -6809,10 +6828,14 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
>   out_ptl:
>   	spin_unlock(vmf.ptl);
>   
> -	if (pagecache_folio) {
> +	/*
> +	 * If the pagecache_folio is unlocked in hugetlb_wp(), we skip
> +	 * folio_unlock() here.
> +	 */
> +	if (pagecache_folio && !pagecache_folio_unlocked)
>   		folio_unlock(pagecache_folio);
> +	if (pagecache_folio)
>   		folio_put(pagecache_folio);
> -	}

The comments seem redundant since the code changes are self-explaining.
Besides, no need to validate 'pagecache_folio' for twice.

	if (pagecache_folio) {
		if (pagecache_folio_locked)
			folio_unlock(pagecache_folio);

		folio_put(pagecache_folio);
	}

>   out_mutex:
>   	hugetlb_vma_unlock_read(vma);
>   
> 
> base-commit: d76bb1ebb5587f66b0f8b8099bfbb44722bc08b3

Thanks,
Gavin


