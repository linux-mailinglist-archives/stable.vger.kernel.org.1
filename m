Return-Path: <stable+bounces-208317-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B2067D1C3B7
	for <lists+stable@lfdr.de>; Wed, 14 Jan 2026 04:19:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 32E483014D01
	for <lists+stable@lfdr.de>; Wed, 14 Jan 2026 03:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA4C02E5427;
	Wed, 14 Jan 2026 03:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="O2iwD+cq"
X-Original-To: stable@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE382D5937;
	Wed, 14 Jan 2026 03:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768360739; cv=none; b=rHEtTMaCwUMrupRINzhMOMWDqoT+MbjLvk4/23R9sYqy+ZWRh4Opp7KRAZ282TlZNxuAV+rRyUZ8d13BhvCTu3rmN/39kLa8x3kwmG28k6SwzqZaCgaNbGyqdNYyarte9qVp6GdpNlQu++vC/dZMorvsKaF64Ic8CmVKJ5S0yjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768360739; c=relaxed/simple;
	bh=qsHVi41AFSjiAy8QTD0Q36OW4diuBvJcdr4+s0C7rEc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sTUrsmhUcTxDOvBKNmE0hLDOGBKUAQVGYm2zPq3NEegxnZkC2Bj3aQJzr15kpdjX4jN/LVK7PXis86zw9AZX20SLvl6QIQvNSZaP6mI+25+X3mCTG86i7wSQ8K+12ds2UU0qDnAtg3/9RJk+tVrVfEO12shSYRJTQczMtQbr0bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=O2iwD+cq; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1768360729; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=WGeHR91DnaFjXcFfiXwgbC4LRrRNSlt1d1O4e0c5nlk=;
	b=O2iwD+cqyoh3c53wMuoBPahMawT4rjK2z1ysA3fdb7jmloed7vuhlzqrndfaVB7/h2d5258KKfghhEuaRy6GuVGe8hsuU7OyeEq510BCLaV2yv8/T8TcW7NNxvBfbjST2wzVkWf4HqFg6LGJ9paq+JylKqjHtfzze2zdV0lCrMU=
Received: from 30.74.144.121(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Wx0hUXu_1768360725 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 14 Jan 2026 11:18:46 +0800
Message-ID: <b5621fc0-5fe0-4ba8-a6f1-84f09f54d186@linux.alibaba.com>
Date: Wed, 14 Jan 2026 11:18:44 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] mm: Fix OOM killer and proc stats inaccuracy on
 large many-core systems
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Dennis Zhou <dennis@kernel.org>,
 Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
 Martin Liu <liumartin@google.com>, David Rientjes <rientjes@google.com>,
 christian.koenig@amd.com, Shakeel Butt <shakeel.butt@linux.dev>,
 SeongJae Park <sj@kernel.org>, Michal Hocko <mhocko@suse.com>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R . Howlett" <liam.howlett@oracle.com>, Mike Rapoport
 <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Vlastimil Babka <vbabka@suse.cz>, Christian Brauner <brauner@kernel.org>,
 Wei Yang <richard.weiyang@gmail.com>, David Hildenbrand <david@redhat.com>,
 Miaohe Lin <linmiaohe@huawei.com>, Al Viro <viro@zeniv.linux.org.uk>,
 linux-mm@kvack.org, stable@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Yu Zhao <yuzhao@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>, Mateusz Guzik
 <mjguzik@gmail.com>, Matthew Wilcox <willy@infradead.org>,
 Aboorva Devarajan <aboorvad@linux.ibm.com>
References: <20260113194734.28983-1-mathieu.desnoyers@efficios.com>
 <20260113194734.28983-2-mathieu.desnoyers@efficios.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20260113194734.28983-2-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 1/14/26 3:47 AM, Mathieu Desnoyers wrote:
> Use the precise, albeit slower, precise RSS counter sums for the OOM
> killer task selection and proc statistics. The approximated value is
> too imprecise on large many-core systems.
> 
> The following rss tracking issues were noted by Sweet Tea Dorminy [1],
> which lead to picking wrong tasks as OOM kill target:
> 
>    Recently, several internal services had an RSS usage regression as part of a
>    kernel upgrade. Previously, they were on a pre-6.2 kernel and were able to
>    read RSS statistics in a backup watchdog process to monitor and decide if
>    they'd overrun their memory budget. Now, however, a representative service
>    with five threads, expected to use about a hundred MB of memory, on a 250-cpu
>    machine had memory usage tens of megabytes different from the expected amount
>    -- this constituted a significant percentage of inaccuracy, causing the
>    watchdog to act.
> 
>    This was a result of commit f1a7941243c1 ("mm: convert mm's rss stats
>    into percpu_counter") [1].  Previously, the memory error was bounded by
>    64*nr_threads pages, a very livable megabyte. Now, however, as a result of
>    scheduler decisions moving the threads around the CPUs, the memory error could
>    be as large as a gigabyte.
> 
>    This is a really tremendous inaccuracy for any few-threaded program on a
>    large machine and impedes monitoring significantly. These stat counters are
>    also used to make OOM killing decisions, so this additional inaccuracy could
>    make a big difference in OOM situations -- either resulting in the wrong
>    process being killed, or in less memory being returned from an OOM-kill than
>    expected.
> 
> Here is a (possibly incomplete) list of the prior approaches that were
> used or proposed, along with their downside:
> 
> 1) Per-thread rss tracking: large error on many-thread processes.
> 
> 2) Per-CPU counters: up to 12% slower for short-lived processes and 9%
>     increased system time in make test workloads [1]. Moreover, the
>     inaccuracy increases with O(n^2) with the number of CPUs.
> 
> 3) Per-NUMA-node counters: requires atomics on fast-path (overhead),
>     error is high with systems that have lots of NUMA nodes (32 times
>     the number of NUMA nodes).
> 
> The simple fix proposed here is to do the precise per-cpu counters sum
> every time a counter value needs to be read. This applies to the OOM
> killer task selection, to the /proc statistics, and to the oom mark_victim
> trace event.
> 
> Note that commit 82241a83cd15 ("mm: fix the inaccurate memory statistics
> issue for users") introduced get_mm_counter_sum() for precise proc
> memory status queries for _some_ proc files. This change renames
> get_mm_counter_sum() to get_mm_counter(), thus moving the rest of the
> proc files to the precise sum.

I'm not against this patch. However, I’m concerned that it may affect 
not only the rest of the proc files, but also fork(), which calls 
get_mm_rss(). At least we should evaluate its impact on fork()?

> This change effectively increases the latency introduced when the OOM
> killer executes in favor of doing a more precise OOM target task
> selection. Effectively, the OOM killer iterates on all tasks, for all
> relevant page types, for which the precise sum iterates on all possible
> CPUs.
> 
> As a reference, here is the execution time of the OOM killer
> before/after the change:
> 
> AMD EPYC 9654 96-Core (2 sockets)
> Within a KVM, configured with 256 logical cpus.
> 
>                                    |  before  |  after   |
> ----------------------------------|----------|----------|
> nr_processes=40                   |  0.3 ms  |   0.5 ms |
> nr_processes=10000                |  3.0 ms  |  80.0 ms |
> 
> Suggested-by: Michal Hocko <mhocko@suse.com>
> Fixes: f1a7941243c1 ("mm: convert mm's rss stats into percpu_counter")
> Link: https://lore.kernel.org/lkml/20250331223516.7810-2-sweettea-kernel@dorminy.me/ # [1]
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Dennis Zhou <dennis@kernel.org>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Christoph Lameter <cl@linux.com>
> Cc: Martin Liu <liumartin@google.com>
> Cc: David Rientjes <rientjes@google.com>
> Cc: christian.koenig@amd.com
> Cc: Shakeel Butt <shakeel.butt@linux.dev>
> Cc: SeongJae Park <sj@kernel.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: "Liam R . Howlett" <liam.howlett@oracle.com>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Wei Yang <richard.weiyang@gmail.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Miaohe Lin <linmiaohe@huawei.com>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: linux-mm@kvack.org
> Cc: stable@vger.kernel.org
> Cc: linux-trace-kernel@vger.kernel.org
> Cc: Yu Zhao <yuzhao@google.com>
> Cc: Roman Gushchin <roman.gushchin@linux.dev>
> Cc: Mateusz Guzik <mjguzik@gmail.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: Aboorva Devarajan <aboorvad@linux.ibm.com>
> ---
>   fs/proc/task_mmu.c | 14 +++++++-------
>   include/linux/mm.h |  5 -----
>   2 files changed, 7 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 81dfc26bfae8..8ca4fbf53fc5 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -39,9 +39,9 @@ void task_mem(struct seq_file *m, struct mm_struct *mm)
>   	unsigned long text, lib, swap, anon, file, shmem;
>   	unsigned long hiwater_vm, total_vm, hiwater_rss, total_rss;
>   
> -	anon = get_mm_counter_sum(mm, MM_ANONPAGES);
> -	file = get_mm_counter_sum(mm, MM_FILEPAGES);
> -	shmem = get_mm_counter_sum(mm, MM_SHMEMPAGES);
> +	anon = get_mm_counter(mm, MM_ANONPAGES);
> +	file = get_mm_counter(mm, MM_FILEPAGES);
> +	shmem = get_mm_counter(mm, MM_SHMEMPAGES);
>   
>   	/*
>   	 * Note: to minimize their overhead, mm maintains hiwater_vm and
> @@ -62,7 +62,7 @@ void task_mem(struct seq_file *m, struct mm_struct *mm)
>   	text = min(text, mm->exec_vm << PAGE_SHIFT);
>   	lib = (mm->exec_vm << PAGE_SHIFT) - text;
>   
> -	swap = get_mm_counter_sum(mm, MM_SWAPENTS);
> +	swap = get_mm_counter(mm, MM_SWAPENTS);
>   	SEQ_PUT_DEC("VmPeak:\t", hiwater_vm);
>   	SEQ_PUT_DEC(" kB\nVmSize:\t", total_vm);
>   	SEQ_PUT_DEC(" kB\nVmLck:\t", mm->locked_vm);
> @@ -95,12 +95,12 @@ unsigned long task_statm(struct mm_struct *mm,
>   			 unsigned long *shared, unsigned long *text,
>   			 unsigned long *data, unsigned long *resident)
>   {
> -	*shared = get_mm_counter_sum(mm, MM_FILEPAGES) +
> -			get_mm_counter_sum(mm, MM_SHMEMPAGES);
> +	*shared = get_mm_counter(mm, MM_FILEPAGES) +
> +			get_mm_counter(mm, MM_SHMEMPAGES);
>   	*text = (PAGE_ALIGN(mm->end_code) - (mm->start_code & PAGE_MASK))
>   								>> PAGE_SHIFT;
>   	*data = mm->data_vm + mm->stack_vm;
> -	*resident = *shared + get_mm_counter_sum(mm, MM_ANONPAGES);
> +	*resident = *shared + get_mm_counter(mm, MM_ANONPAGES);
>   	return mm->total_vm;
>   }
>   
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 6f959d8ca4b4..d096bb3593ba 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2847,11 +2847,6 @@ static inline bool get_user_page_fast_only(unsigned long addr,
>    * per-process(per-mm_struct) statistics.
>    */
>   static inline unsigned long get_mm_counter(struct mm_struct *mm, int member)
> -{
> -	return percpu_counter_read_positive(&mm->rss_stat[member]);
> -}
> -
> -static inline unsigned long get_mm_counter_sum(struct mm_struct *mm, int member)
>   {
>   	return percpu_counter_sum_positive(&mm->rss_stat[member]);
>   }


