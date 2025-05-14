Return-Path: <stable+bounces-144337-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D6DAB6558
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 10:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DC444A5798
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 08:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6B421C190;
	Wed, 14 May 2025 08:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="qhJa3wSM"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC5520B81D;
	Wed, 14 May 2025 08:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747210243; cv=none; b=nmsMbcJ01GBLvY3cOn25teu0xLQhnaLF0hr2s2sBEVNuoP6PD9eh94ElS5Z40siOXVIHskqEYeUd6mMZ379a8OioavH+2ELrt3Roy/zWGN5r5sts0HCCMbKYzEIiNPH3M0UBCdF0HysuVTozHXrhvdpFOqTQJY0p7ogyksbhohc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747210243; c=relaxed/simple;
	bh=FzXisbhiEUX6J0zLzuogmr+fn9nnvBCZOW+wrNYa9T0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R4A3Xabjb7aJzYLo6i3bB8wbjY1BRDT+EL+hAL1xI1dRrEM03wSti/EV7/4hOOA4sbsYocp1Ev08KkvCswwRPh+SQ+I+XvBhVRKkrGhAEgmnJSOkWFlY3LpkeN4Iatc9x1UAEnqHt6cGp94BY1jl+SKFFjOLx/B7FsiKZw+jwhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=qhJa3wSM; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=wlcuC/Obn9blaoTR3DxmIs5wGn43S4QO+fV7DMoCvEg=; b=qhJa3wSMDkumojp2YO3yBEseMy
	KWNe/InMsoQvUqNIH3MvPI1FVu0umdgCm/in1O/DC6DiWqFanT/Aw1kmeYRv2cpEUK/XXAFO/7Qzf
	Jq4x74zZnHXLOAt25RoE7fVJz3mEIijLCMDtAZfhSyhQUJOKvU/MTMRvZS0jXpKeFoDWVoQ7SldG9
	HZCAMkrk8cv/yprnWF+yJ2y9AgTIhVEeibvQW41rnvj/GUO0adEfcAW3knb2sDh8QipI20U5lg244
	vaWUVYxS5y9gECyPWsyxkjZj5N7uU34/9wvxerkrFH3tcIoGuEdL+qP7akHob+xMEpt5qxsw50TdM
	Okt0Ngiw==;
Received: from 27-51-1-120.adsl.fetnet.net ([27.51.1.120] helo=[192.168.238.43])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1uF76S-0082hg-Ck; Wed, 14 May 2025 10:10:19 +0200
Message-ID: <075ae729-1d4a-4f12-a2ba-b4f508e5d0a1@igalia.com>
Date: Wed, 14 May 2025 16:10:12 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/hugetlb: fix a deadlock with pagecache_folio and
 hugetlb_fault_mutex_table
To: Byungchul Park <byungchul@sk.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, muchun.song@linux.dev,
 osalvador@suse.de, akpm@linux-foundation.org, mike.kravetz@oracle.com,
 kernel-dev@igalia.com, stable@vger.kernel.org,
 Hugh Dickins <hughd@google.com>, Florent Revest <revest@google.com>,
 Gavin Shan <gshan@redhat.com>, kernel_team@skhynix.com
References: <20250513093448.592150-1-gavinguo@igalia.com>
 <20250514064729.GA17622@system.software.com>
Content-Language: en-US
From: Gavin Guo <gavinguo@igalia.com>
In-Reply-To: <20250514064729.GA17622@system.software.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Byungchul,

On 5/14/25 14:47, Byungchul Park wrote:
> On Tue, May 13, 2025 at 05:34:48PM +0800, Gavin Guo wrote:
>> The patch fixes a deadlock which can be triggered by an internal
>> syzkaller [1] reproducer and captured by bpftrace script [2] and its log
> 
> Hi,
> 
> I'm trying to reproduce using the test program [1].  But not yet
> produced.  I see a lot of segfaults while running [1].  I guess
> something goes wrong.  Is there any prerequisite condition to reproduce
> it?  Lemme know if any.  Or can you try DEPT15 with your config and
> environment by the following steps:
> 
>     1. Apply the patchset on v6.15-rc6.
>        https://lkml.kernel.org/r/20250513100730.12664-1-byungchul@sk.com
>     2. Turn on CONFIG_DEPT.
>     3. Run test program reproducing the deadlock.
>     4. Check dmesg to see if dept reported the dependency.
> 
> 	Byungchul

I have enabled the patchset and successfully reproduced the bug. It
seems that there is no warning or error log related to the lock. Did I
miss anything? This is the console log:
https://drive.google.com/file/d/1dxWNiO71qE-H-e5NMPqj7W-aW5CkGSSF/view?usp=sharing

> 
>> [3] in this scenario:
>>
>> Process 1                              Process 2
>> ---				       ---
>> hugetlb_fault
>>    mutex_lock(B) // take B
>>    filemap_lock_hugetlb_folio
>>      filemap_lock_folio
>>        __filemap_get_folio
>>          folio_lock(A) // take A
>>    hugetlb_wp
>>      mutex_unlock(B) // release B
>>      ...                                hugetlb_fault
>>      ...                                  mutex_lock(B) // take B
>>                                           filemap_lock_hugetlb_folio
>>                                             filemap_lock_folio
>>                                               __filemap_get_folio
>>                                                 folio_lock(A) // blocked
>>      unmap_ref_private
>>      ...
>>      mutex_lock(B) // retake and blocked
>>
>> This is a ABBA deadlock involving two locks:
>> - Lock A: pagecache_folio lock
>> - Lock B: hugetlb_fault_mutex_table lock
>>
>> The deadlock occurs between two processes as follows:
>> 1. The first process (let’s call it Process 1) is handling a
>> copy-on-write (COW) operation on a hugepage via hugetlb_wp. Due to
>> insufficient reserved hugetlb pages, Process 1, owner of the reserved
>> hugetlb page, attempts to unmap a hugepage owned by another process
>> (non-owner) to satisfy the reservation. Before unmapping, Process 1
>> acquires lock B (hugetlb_fault_mutex_table lock) and then lock A
>> (pagecache_folio lock). To proceed with the unmap, it releases Lock B
>> but retains Lock A. After the unmap, Process 1 tries to reacquire Lock
>> B. However, at this point, Lock B has already been acquired by another
>> process.
>>
>> 2. The second process (Process 2) enters the hugetlb_fault handler
>> during the unmap operation. It successfully acquires Lock B
>> (hugetlb_fault_mutex_table lock) that was just released by Process 1,
>> but then attempts to acquire Lock A (pagecache_folio lock), which is
>> still held by Process 1.
>>
>> As a result, Process 1 (holding Lock A) is blocked waiting for Lock B
>> (held by Process 2), while Process 2 (holding Lock B) is blocked waiting
>> for Lock A (held by Process 1), constructing a ABBA deadlock scenario.
>>
>> The solution here is to unlock the pagecache_folio and provide the
>> pagecache_folio_unlocked variable to the caller to have the visibility
>> over the pagecache_folio status for subsequent handling.
>>
>> The error message:
>> INFO: task repro_20250402_:13229 blocked for more than 64 seconds.
>>        Not tainted 6.15.0-rc3+ #24
>> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>> task:repro_20250402_ state:D stack:25856 pid:13229 tgid:13228 ppid:3513   task_flags:0x400040 flags:0x00004006
>> Call Trace:
>>   <TASK>
>>   __schedule+0x1755/0x4f50
>>   schedule+0x158/0x330
>>   schedule_preempt_disabled+0x15/0x30
>>   __mutex_lock+0x75f/0xeb0
>>   hugetlb_wp+0xf88/0x3440
>>   hugetlb_fault+0x14c8/0x2c30
>>   trace_clock_x86_tsc+0x20/0x20
>>   do_user_addr_fault+0x61d/0x1490
>>   exc_page_fault+0x64/0x100
>>   asm_exc_page_fault+0x26/0x30
>> RIP: 0010:__put_user_4+0xd/0x20
>>   copy_process+0x1f4a/0x3d60
>>   kernel_clone+0x210/0x8f0
>>   __x64_sys_clone+0x18d/0x1f0
>>   do_syscall_64+0x6a/0x120
>>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
>> RIP: 0033:0x41b26d
>>   </TASK>
>> INFO: task repro_20250402_:13229 is blocked on a mutex likely owned by task repro_20250402_:13250.
>> task:repro_20250402_ state:D stack:28288 pid:13250 tgid:13228 ppid:3513   task_flags:0x400040 flags:0x00000006
>> Call Trace:
>>   <TASK>
>>   __schedule+0x1755/0x4f50
>>   schedule+0x158/0x330
>>   io_schedule+0x92/0x110
>>   folio_wait_bit_common+0x69a/0xba0
>>   __filemap_get_folio+0x154/0xb70
>>   hugetlb_fault+0xa50/0x2c30
>>   trace_clock_x86_tsc+0x20/0x20
>>   do_user_addr_fault+0xace/0x1490
>>   exc_page_fault+0x64/0x100
>>   asm_exc_page_fault+0x26/0x30
>> RIP: 0033:0x402619
>>   </TASK>
>> INFO: task repro_20250402_:13250 blocked for more than 65 seconds.
>>        Not tainted 6.15.0-rc3+ #24
>> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>> task:repro_20250402_ state:D stack:28288 pid:13250 tgid:13228 ppid:3513   task_flags:0x400040 flags:0x00000006
>> Call Trace:
>>   <TASK>
>>   __schedule+0x1755/0x4f50
>>   schedule+0x158/0x330
>>   io_schedule+0x92/0x110
>>   folio_wait_bit_common+0x69a/0xba0
>>   __filemap_get_folio+0x154/0xb70
>>   hugetlb_fault+0xa50/0x2c30
>>   trace_clock_x86_tsc+0x20/0x20
>>   do_user_addr_fault+0xace/0x1490
>>   exc_page_fault+0x64/0x100
>>   asm_exc_page_fault+0x26/0x30
>> RIP: 0033:0x402619
>>   </TASK>
>>
>> Showing all locks held in the system:
>> 1 lock held by khungtaskd/35:
>>   #0: ffffffff879a7440 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x30/0x180
>> 2 locks held by repro_20250402_/13229:
>>   #0: ffff888017d801e0 (&mm->mmap_lock){++++}-{4:4}, at: lock_mm_and_find_vma+0x37/0x300
>>   #1: ffff888000fec848 (&hugetlb_fault_mutex_table[i]){+.+.}-{4:4}, at: hugetlb_wp+0xf88/0x3440
>> 3 locks held by repro_20250402_/13250:
>>   #0: ffff8880177f3d08 (vm_lock){++++}-{0:0}, at: do_user_addr_fault+0x41b/0x1490
>>   #1: ffff888000fec848 (&hugetlb_fault_mutex_table[i]){+.+.}-{4:4}, at: hugetlb_fault+0x3b8/0x2c30
>>   #2: ffff8880129500e8 (&resv_map->rw_sema){++++}-{4:4}, at: hugetlb_fault+0x494/0x2c30
>>
>> Link: https://drive.google.com/file/d/1DVRnIW-vSayU5J1re9Ct_br3jJQU6Vpb/view?usp=drive_link [1]
>> Link: https://github.com/bboymimi/bpftracer/blob/master/scripts/hugetlb_lock_debug.bt [2]
>> Link: https://drive.google.com/file/d/1bWq2-8o-BJAuhoHWX7zAhI6ggfhVzQUI/view?usp=sharing [3]
>> Fixes: 40549ba8f8e0 ("hugetlb: use new vma_lock for pmd sharing synchronization")
>> Cc: <stable@vger.kernel.org>
>> Cc: Hugh Dickins <hughd@google.com>
>> Cc: Florent Revest <revest@google.com>
>> Cc: Gavin Shan <gshan@redhat.com>
>> Signed-off-by: Gavin Guo <gavinguo@igalia.com>
>> ---
>>   mm/hugetlb.c | 33 ++++++++++++++++++++++++++++-----
>>   1 file changed, 28 insertions(+), 5 deletions(-)
>>
>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>> index e3e6ac991b9c..ad54a74aa563 100644
>> --- a/mm/hugetlb.c
>> +++ b/mm/hugetlb.c
>> @@ -6115,7 +6115,8 @@ static void unmap_ref_private(struct mm_struct *mm, struct vm_area_struct *vma,
>>    * Keep the pte_same checks anyway to make transition from the mutex easier.
>>    */
>>   static vm_fault_t hugetlb_wp(struct folio *pagecache_folio,
>> -		       struct vm_fault *vmf)
>> +		       struct vm_fault *vmf,
>> +		       bool *pagecache_folio_unlocked)
>>   {
>>   	struct vm_area_struct *vma = vmf->vma;
>>   	struct mm_struct *mm = vma->vm_mm;
>> @@ -6212,6 +6213,22 @@ static vm_fault_t hugetlb_wp(struct folio *pagecache_folio,
>>   			u32 hash;
>>   
>>   			folio_put(old_folio);
>> +			/*
>> +			 * The pagecache_folio needs to be unlocked to avoid
>> +			 * deadlock and we won't re-lock it in hugetlb_wp(). The
>> +			 * pagecache_folio could be truncated after being
>> +			 * unlocked. So its state should not be relied
>> +			 * subsequently.
>> +			 *
>> +			 * Setting *pagecache_folio_unlocked to true allows the
>> +			 * caller to handle any necessary logic related to the
>> +			 * folio's unlocked state.
>> +			 */
>> +			if (pagecache_folio) {
>> +				folio_unlock(pagecache_folio);
>> +				if (pagecache_folio_unlocked)
>> +					*pagecache_folio_unlocked = true;
>> +			}
>>   			/*
>>   			 * Drop hugetlb_fault_mutex and vma_lock before
>>   			 * unmapping.  unmapping needs to hold vma_lock
>> @@ -6566,7 +6583,7 @@ static vm_fault_t hugetlb_no_page(struct address_space *mapping,
>>   	hugetlb_count_add(pages_per_huge_page(h), mm);
>>   	if ((vmf->flags & FAULT_FLAG_WRITE) && !(vma->vm_flags & VM_SHARED)) {
>>   		/* Optimization, do the COW without a second fault */
>> -		ret = hugetlb_wp(folio, vmf);
>> +		ret = hugetlb_wp(folio, vmf, NULL);
>>   	}
>>   
>>   	spin_unlock(vmf->ptl);
>> @@ -6638,6 +6655,7 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
>>   	struct hstate *h = hstate_vma(vma);
>>   	struct address_space *mapping;
>>   	int need_wait_lock = 0;
>> +	bool pagecache_folio_unlocked = false;
>>   	struct vm_fault vmf = {
>>   		.vma = vma,
>>   		.address = address & huge_page_mask(h),
>> @@ -6792,7 +6810,8 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
>>   
>>   	if (flags & (FAULT_FLAG_WRITE|FAULT_FLAG_UNSHARE)) {
>>   		if (!huge_pte_write(vmf.orig_pte)) {
>> -			ret = hugetlb_wp(pagecache_folio, &vmf);
>> +			ret = hugetlb_wp(pagecache_folio, &vmf,
>> +					&pagecache_folio_unlocked);
>>   			goto out_put_page;
>>   		} else if (likely(flags & FAULT_FLAG_WRITE)) {
>>   			vmf.orig_pte = huge_pte_mkdirty(vmf.orig_pte);
>> @@ -6809,10 +6828,14 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
>>   out_ptl:
>>   	spin_unlock(vmf.ptl);
>>   
>> -	if (pagecache_folio) {
>> +	/*
>> +	 * If the pagecache_folio is unlocked in hugetlb_wp(), we skip
>> +	 * folio_unlock() here.
>> +	 */
>> +	if (pagecache_folio && !pagecache_folio_unlocked)
>>   		folio_unlock(pagecache_folio);
>> +	if (pagecache_folio)
>>   		folio_put(pagecache_folio);
>> -	}
>>   out_mutex:
>>   	hugetlb_vma_unlock_read(vma);
>>   
>>
>> base-commit: d76bb1ebb5587f66b0f8b8099bfbb44722bc08b3
>> -- 
>> 2.43.0
>>


