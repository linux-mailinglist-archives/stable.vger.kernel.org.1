Return-Path: <stable+bounces-144580-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D85AB9697
	for <lists+stable@lfdr.de>; Fri, 16 May 2025 09:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D21AE1BC3818
	for <lists+stable@lfdr.de>; Fri, 16 May 2025 07:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513D3224248;
	Fri, 16 May 2025 07:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="qCULTCBA"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23F82C9A;
	Fri, 16 May 2025 07:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747380783; cv=none; b=d4rQFZitXD4B44js/UGbHcsTfKleK2JTeNknFIqpxxrbK359/7dpj11209Swgufl19o1SosvgWfWlvT2KfhaAI5CL70+InxLj771zMHQAx6NERHOlNGxwrrhcon/qp+979eMouMiREpltBDV+EHw1WTmsbT1Kt631XbbiAnKwX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747380783; c=relaxed/simple;
	bh=XAyo9CtiYwDcUGxuPtMpI7pT9xtaqISwDisrxPASZaQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G/GPU4Uw3F1P6MdcE0afVHlOiUrNhzLnZRQ7uIrI12YGSjwXpEv37uaKdCdhue6rn6xKvT7sYtDdqyMJUfppsdWpgSR0XQeDR9xAJGF9IM8xxAHhFuy0IRpPGGjxOVHQnai6SIlJinuhU3tcr4IRU8nyuo37DBYmxUVBxPNPPzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=qCULTCBA; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=BYwXGPJqEjCua/FANHW8c62ptBDFOcBMAOJrBegIM48=; b=qCULTCBAQW/1m75ioAeIj6eMRB
	Hmh/dl3krr+u4uirzh1dRe6sYEiP5d/5Hwlkej4+fEwvMYAAZB/tuEJKTZttEIAIGeMtfEL/NL76C
	P6nXwX0VKOohiQFOBpWGdK0bQsYKTB5MD+jrQSr2arJSTpnxcodmXKXgSsRGPKqvRjSU6UKpyno8K
	og3CyztmiJzABoizt64TZqOE/HfyQ3HQx24C5Kou+MJpPHf7jCWMpRhuy8LB7prBloaETFHo3AYZ9
	14NXF+Sr/4ToiEYo7Kiz4ysxbPQ2gtU6Wd4CLaNYKwCN0AmAhEKq7+ixPpn4OWUJhUsUyc+pjw19m
	leq7f3TQ==;
Received: from 39-12-18-146.adsl.fetnet.net ([39.12.18.146] helo=[192.168.238.43])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1uFpSt-008yAE-Qb; Fri, 16 May 2025 09:32:42 +0200
Message-ID: <b6e00e77-4a8c-4e05-ab79-266bf05fcc2d@igalia.com>
Date: Fri, 16 May 2025 15:32:35 +0800
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
 <075ae729-1d4a-4f12-a2ba-b4f508e5d0a1@igalia.com>
 <20250516060309.GA51921@system.software.com>
Content-Language: en-US
From: Gavin Guo <gavinguo@igalia.com>
In-Reply-To: <20250516060309.GA51921@system.software.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/16/25 14:03, Byungchul Park wrote:
> On Wed, May 14, 2025 at 04:10:12PM +0800, Gavin Guo wrote:
>> Hi Byungchul,
>>
>> On 5/14/25 14:47, Byungchul Park wrote:
>>> On Tue, May 13, 2025 at 05:34:48PM +0800, Gavin Guo wrote:
>>>> The patch fixes a deadlock which can be triggered by an internal
>>>> syzkaller [1] reproducer and captured by bpftrace script [2] and its log
>>>
>>> Hi,
>>>
>>> I'm trying to reproduce using the test program [1].  But not yet
>>> produced.  I see a lot of segfaults while running [1].  I guess
>>> something goes wrong.  Is there any prerequisite condition to reproduce
>>> it?  Lemme know if any.  Or can you try DEPT15 with your config and
>>> environment by the following steps:
>>>
>>>      1. Apply the patchset on v6.15-rc6.
>>>         https://lkml.kernel.org/r/20250513100730.12664-1-byungchul@sk.com
>>>      2. Turn on CONFIG_DEPT.
>>>      3. Run test program reproducing the deadlock.
>>>      4. Check dmesg to see if dept reported the dependency.
>>>
>>> 	Byungchul
>>
>> I have enabled the patchset and successfully reproduced the bug. It
>> seems that there is no warning or error log related to the lock. Did I
>> miss anything? This is the console log:
>> https://drive.google.com/file/d/1dxWNiO71qE-H-e5NMPqj7W-aW5CkGSSF/view?usp=sharing
> 
> My bad.  I think I found the problem that dept didn't report it.  You
> might see the report with the following patch applied on the top, there
> might be a lot of false positives along with that might be annoying tho.
> 
> Some of my efforts to suppress false positives, suppressed the real one.
> 
> Do you mind if I ask you to run the test with the following patch
> applied?  It'd be appreciated if you do and share the result with me.
> 
> 	Byungchul
> 
> ---
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index f31cd68f2935..fd7559e663c5 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -1138,6 +1138,7 @@ static inline bool trylock_page(struct page *page)
>   static inline void folio_lock(struct folio *folio)
>   {
>   	might_sleep();
> +	dept_page_wait_on_bit(&folio->page, PG_locked);
>   	if (!folio_trylock(folio))
>   		__folio_lock(folio);
>   }
> diff --git a/kernel/dependency/dept.c b/kernel/dependency/dept.c
> index b2fa96d984bc..4e96a6a72d02 100644
> --- a/kernel/dependency/dept.c
> +++ b/kernel/dependency/dept.c
> @@ -931,7 +931,6 @@ static void print_circle(struct dept_class *c)
>   	dept_outworld_exit();
>   
>   	do {
> -		tc->reported = true;
>   		tc = fc;
>   		fc = fc->bfs_parent;
>   	} while (tc != c);
> diff --git a/kernel/dependency/dept_unit_test.c b/kernel/dependency/dept_unit_test.c
> index 88e846b9f876..496149f31fb3 100644
> --- a/kernel/dependency/dept_unit_test.c
> +++ b/kernel/dependency/dept_unit_test.c
> @@ -125,6 +125,8 @@ static int __init dept_ut_init(void)
>   {
>   	int i;
>   
> +	return 0;
> +
>   	lockdep_off();
>   
>   	dept_ut_results.ecxt_stack_valid_cnt = 0;
> --

Please see the test result:
https://drive.google.com/file/d/1B20Gu3wLFbAeaXXb7aSQP5T6aeN9Mext/view?usp=sharing

It seems that after the first round, the deadlock is captured:
ubuntu@localhost:~$ ./repro_20250402_0225_154f8fb0580000
executing program
[   80.425842][ T3416] ===================================================
[   80.426707][ T3416] DEPT: Circular dependency has been detected.
[   80.427497][ T3416] 6.15.0-rc6+ #31 Not tainted
[   80.428084][ T3416] ---------------------------------------------------
[   80.428964][ T3416] summary
[   80.429330][ T3416] ---------------------------------------------------
[   80.430078][ T3416] *** DEADLOCK ***
[   80.430078][ T3416]
[   80.430736][ T3416] context A
[   80.431076][ T3416]    [S] (unknown)(pg_locked_map:0)
[   80.431637][ T3416]    [W] lock(&hugetlb_fault_mutex_table[i]:0)
[   80.432312][ T3416]    [E] dept_page_clear_bit(pg_locked_map:0)
[   80.432977][ T3416]
[   80.433246][ T3416] context B
[   80.433595][ T3416]    [S] lock(&hugetlb_fault_mutex_table[i]:0)
[   80.434245][ T3416]    [W] dept_page_wait_on_bit(pg_locked_map:0)
[   80.434880][ T3416]    [E] unlock(&hugetlb_fault_mutex_table[i]:0)
[   80.435592][ T3416]
[   80.435852][ T3416] [S]: start of the event context
[   80.436369][ T3416] [W]: the wait blocked
[   80.436789][ T3416] [E]: the event not reachable
[   80.437275][ T3416] ---------------------------------------------------
[   80.437950][ T3416] context A's detail
[   80.438367][ T3416] ---------------------------------------------------
[   80.439006][ T3416] context A
[   80.439337][ T3416]    [S] (unknown)(pg_locked_map:0)
[   80.439883][ T3416]    [W] lock(&hugetlb_fault_mutex_table[i]:0)
[   80.440489][ T3416]    [E] dept_page_clear_bit(pg_locked_map:0)
[   80.441075][ T3416]
[   80.441318][ T3416] [S] (unknown)(pg_locked_map:0):
[   80.441816][ T3416] (N/A)
[   80.442077][ T3416]
[   80.442309][ T3416] [W] lock(&hugetlb_fault_mutex_table[i]:0):
[   80.442872][ T3416] [<ffffffff82144644>] hugetlb_wp+0xfa4/0x3490
[   80.443502][ T3416] stacktrace:
[   80.443810][ T3416]       hugetlb_wp+0xfa4/0x3490
[   80.444267][ T3416]       hugetlb_fault+0x1505/0x2c70
[   80.444776][ T3416]       handle_mm_fault+0x1845/0x1ab0
[   80.445275][ T3416]       do_user_addr_fault+0x637/0x1450
[   80.445779][ T3416]       exc_page_fault+0x67/0x110
[   80.446239][ T3416]       asm_exc_page_fault+0x26/0x30
[   80.446722][ T3416]       __put_user_4+0xd/0x20
[   80.447157][ T3416]       copy_process+0x1f64/0x3d80
[   80.447621][ T3416]       kernel_clone+0x216/0x940
[   80.448068][ T3416]       __x64_sys_clone+0x18d/0x1f0
[   80.448548][ T3416]       do_syscall_64+0x6f/0x120
[   80.448999][ T3416]       entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   80.449556][ T3416]
[   80.449765][ T3416] [E] dept_page_clear_bit(pg_locked_map:0):
[   80.450272][ T3416] [<ffffffff8214263b>] hugetlb_fault+0x1ccb/0x2c70
[   80.450861][ T3416] stacktrace:
[   80.451148][ T3416]       hugetlb_fault+0x1ccb/0x2c70
[   80.451611][ T3416]       handle_mm_fault+0x1845/0x1ab0
[   80.452080][ T3416]       do_user_addr_fault+0x637/0x1450
[   80.452566][ T3416]       exc_page_fault+0x67/0x110
[   80.453014][ T3416]       asm_exc_page_fault+0x26/0x30
[   80.453497][ T3416]       __put_user_4+0xd/0x20
[   80.453923][ T3416]       copy_process+0x1f64/0x3d80
[   80.454379][ T3416]       kernel_clone+0x216/0x940
[   80.454817][ T3416]       __x64_sys_clone+0x18d/0x1f0
[   80.455277][ T3416]       do_syscall_64+0x6f/0x120
[   80.455722][ T3416]       entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   80.456253][ T3416] ---------------------------------------------------
[   80.456842][ T3416] context B's detail
[   80.457198][ T3416] ---------------------------------------------------
[   80.457842][ T3416] context B
[   80.458122][ T3416]    [S] lock(&hugetlb_fault_mutex_table[i]:0)
[   80.458661][ T3416]    [W] dept_page_wait_on_bit(pg_locked_map:0)
[   80.459187][ T3416]    [E] unlock(&hugetlb_fault_mutex_table[i]:0)
[   80.459763][ T3416]
[   80.459988][ T3416] [S] lock(&hugetlb_fault_mutex_table[i]:0):
[   80.460509][ T3416] [<ffffffff82140d36>] hugetlb_fault+0x3c6/0x2c70
[   80.461074][ T3416] stacktrace:
[   80.461374][ T3416]       hugetlb_fault+0x3c6/0x2c70
[   80.461812][ T3416]       handle_mm_fault+0x1845/0x1ab0
[   80.462281][ T3416]       do_user_addr_fault+0x637/0x1450
[   80.462775][ T3416]       exc_page_fault+0x67/0x110
[   80.463220][ T3416]       asm_exc_page_fault+0x26/0x30
[   80.463694][ T3416]       __put_user_4+0xd/0x20
[   80.464129][ T3416]       copy_process+0x1f64/0x3d80
[   80.464577][ T3416]       kernel_clone+0x216/0x940
[   80.464994][ T3416]       __x64_sys_clone+0x18d/0x1f0
[   80.465466][ T3416]       do_syscall_64+0x6f/0x120
[   80.465909][ T3416]       entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   80.466457][ T3416]
[   80.466660][ T3416] [W] dept_page_wait_on_bit(pg_locked_map:0):
[   80.467177][ T3416] [<ffffffff82141187>] hugetlb_fault+0x817/0x2c70
[   80.467740][ T3416] stacktrace:
[   80.468032][ T3416]       hugetlb_fault+0x817/0x2c70
[   80.468479][ T3416]       handle_mm_fault+0x1845/0x1ab0
[   80.468947][ T3416]       do_user_addr_fault+0x637/0x1450
[   80.469428][ T3416]       exc_page_fault+0x67/0x110
[   80.469865][ T3416]       asm_exc_page_fault+0x26/0x30
[   80.470332][ T3416]       __put_user_4+0xd/0x20
[   80.470742][ T3416]       copy_process+0x1f64/0x3d80
[   80.471186][ T3416]       kernel_clone+0x216/0x940
[   80.471616][ T3416]       __x64_sys_clone+0x18d/0x1f0
[   80.472060][ T3416]       do_syscall_64+0x6f/0x120
[   80.472492][ T3416]       entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   80.473040][ T3416]
[   80.473271][ T3416] [E] unlock(&hugetlb_fault_mutex_table[i]:0):
[   80.473863][ T3416] (N/A)
[   80.474124][ T3416] ---------------------------------------------------
[   80.474738][ T3416] information that might be helpful
[   80.475210][ T3416] ---------------------------------------------------
[   80.475820][ T3416] CPU: 1 UID: 1000 PID: 3416 Comm: repro_20250402_ 
Not tainted 6.15.0-rc6+ #31 NONE
[   80.475831][ T3416] Hardware name: QEMU Standard PC (Q35 + ICH9, 
2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   80.475837][ T3416] Call Trace:
[   80.475841][ T3416]  <TASK>
[   80.475845][ T3416]  dump_stack_lvl+0x1ad/0x280
[   80.475858][ T3416]  ? __pfx_dump_stack_lvl+0x10/0x10
[   80.475867][ T3416]  ? __pfx__printk+0x10/0x10
[   80.475883][ T3416]  cb_check_dl+0x24a8/0x2530
[   80.475897][ T3416]  ? bfs_extend_dep+0x271/0x290
[   80.475909][ T3416]  bfs+0x464/0x5e0
[   80.475921][ T3416]  ? __pfx_bfs+0x10/0x10
[   80.475931][ T3416]  ? add_dep+0x387/0x710
[   80.475943][ T3416]  add_dep+0x3d0/0x710
[   80.475953][ T3416]  ? __pfx_from_pool+0x10/0x10
[   80.475963][ T3416]  ? __pfx_bfs_init_check_dl+0x10/0x10
[   80.475972][ T3416]  ? __pfx_bfs_extend_dep+0x10/0x10
[   80.475981][ T3416]  ? __pfx_bfs_dequeue_dep+0x10/0x10
[   80.475990][ T3416]  ? __pfx_cb_check_dl+0x10/0x10
[   80.475999][ T3416]  ? __pfx_add_dep+0x10/0x10
[   80.476011][ T3416]  ? put_ecxt+0xda/0x4b0
[   80.476024][ T3416]  __dept_event+0xee8/0x1590
[   80.476038][ T3416]  dept_event+0x166/0x240
[   80.476047][ T3416]  ? hugetlb_fault+0x1ccb/0x2c70
[   80.476057][ T3416]  folio_unlock+0xb8/0x190
[   80.476071][ T3416]  hugetlb_fault+0x1ccb/0x2c70
[   80.476085][ T3416]  ? __pfx_hugetlb_fault+0x10/0x10
[   80.476100][ T3416]  ? mt_find+0x15a/0x5f0
[   80.476110][ T3416]  handle_mm_fault+0x1845/0x1ab0
[   80.476125][ T3416]  ? handle_mm_fault+0xdb/0x1ab0
[   80.476142][ T3416]  ? __pfx_handle_mm_fault+0x10/0x10
[   80.476156][ T3416]  ? find_vma+0xec/0x160
[   80.476164][ T3416]  ? __pfx_find_vma+0x10/0x10
[   80.476172][ T3416]  ? dept_on+0x1c/0x30
[   80.476179][ T3416]  ? dept_exit+0x1c5/0x2c0
[   80.476186][ T3416]  ? lockdep_hardirqs_on_prepare+0x21/0x280
[   80.476197][ T3416]  ? lock_mm_and_find_vma+0xa1/0x300
[   80.476211][ T3416]  do_user_addr_fault+0x637/0x1450
[   80.476219][ T3416]  ? mntput_no_expire+0xc0/0x870
[   80.476235][ T3416]  ? __pfx_do_user_addr_fault+0x10/0x10
[   80.476246][ T3416]  ? trace_irq_disable+0x60/0x180
[   80.476258][ T3416]  exc_page_fault+0x67/0x110
[   80.476272][ T3416]  asm_exc_page_fault+0x26/0x30
[   80.476280][ T3416] RIP: 0010:__put_user_4+0xd/0x20
[   80.476293][ T3416] Code: 66 89 01 31 c9 0f 1f 00 c3 cc cc cc cc 90 
90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 48 89 cb 48 c1 fb 3f 48 09 
d9 0f 1f 00 <89> 01 31 c9 0
[   80.476312][ T3416] RSP: 0018:ffffc90004dffa38 EFLAGS: 00010206
[   80.476322][ T3416] RAX: 000000000000000c RBX: 0000000000000000 RCX: 
0000200000000200
[   80.476329][ T3416] RDX: 0000000000000000 RSI: ffff888016abe300 RDI: 
ffff888017878c20
[   80.476335][ T3416] RBP: ffffc90004dffc10 R08: 0000000000000000 R09: 
0000000000000000
[   80.476340][ T3416] R10: 0000000000000000 R11: ffffffff82034b65 R12: 
ffff888017c0a1e8
[   80.476346][ T3416] R13: ffff88800d6a8200 R14: 0000000000000000 R15: 
ffff888017c08a38
[   80.476354][ T3416]  ? __might_fault+0xb5/0x130
[   80.476367][ T3416]  copy_process+0x1f64/0x3d80
[   80.476375][ T3416]  ? lockdep_hardirqs_on_prepare+0x21/0x280
[   80.476388][ T3416]  ? copy_process+0x996/0x3d80
[   80.476399][ T3416]  ? __pfx_copy_process+0x10/0x10
[   80.476406][ T3416]  ? from_pool+0x1e1/0x750
[   80.476416][ T3416]  ? handle_mm_fault+0x122e/0x1ab0
[   80.476432][ T3416]  kernel_clone+0x216/0x940
[   80.476440][ T3416]  ? __pfx_llist_del_first+0x10/0x10
[   80.476448][ T3416]  ? check_new_class+0x28a/0xe90
[   80.476458][ T3416]  ? __pfx_kernel_clone+0x10/0x10
[   80.476468][ T3416]  ? from_pool+0x1e1/0x750
[   80.476478][ T3416]  ? __pfx_from_pool+0x10/0x10
[   80.476487][ T3416]  ? __pfx_from_pool+0x10/0x10
[   80.476502][ T3416]  __x64_sys_clone+0x18d/0x1f0
[   80.476512][ T3416]  ? __pfx___x64_sys_clone+0x10/0x10
[   80.476520][ T3416]  ? llist_add_batch+0x111/0x1f0
[   80.476532][ T3416]  ? dept_task+0x5/0x20
[   80.476539][ T3416]  ? dept_on+0x1c/0x30
[   80.476545][ T3416]  ? dept_exit+0x1c5/0x2c0
[   80.476553][ T3416]  ? lockdep_hardirqs_on_prepare+0x21/0x280
[   80.476565][ T3416]  do_syscall_64+0x6f/0x120
[   80.476573][ T3416]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   80.476580][ T3416] RIP: 0033:0x41b26d
[   80.476588][ T3416] Code: b3 66 2e 0f 1f 84 00 00 00 00 00 66 90 f3 
0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 
24 08 0f 05 <48> 3d 01 f0 8
[   80.476595][ T3416] RSP: 002b:00007ffa1ad2d198 EFLAGS: 00000206 
ORIG_RAX: 0000000000000038
[   80.476604][ T3416] RAX: ffffffffffffffda RBX: 00007ffa1ad2dcdc RCX: 
000000000041b26d
[   80.476610][ T3416] RDX: 0000200000000200 RSI: 0000000000000000 RDI: 
0000000000001200
[   80.476616][ T3416] RBP: 00007ffa1ad2d1e0 R08: 0000000000000000 R09: 
0000000000000000
[   80.476621][ T3416] R10: 0000000000000000 R11: 0000000000000206 R12: 
00007ffa1ad2d6c0
[   80.476626][ T3416] R13: ffffffffffffffb8 R14: 0000000000000002 R15: 
00007ffd95d76940
[   80.476638][ T3416]  </TASK>


