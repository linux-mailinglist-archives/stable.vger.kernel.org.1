Return-Path: <stable+bounces-208296-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A6909D1B785
	for <lists+stable@lfdr.de>; Tue, 13 Jan 2026 22:47:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EB5513040231
	for <lists+stable@lfdr.de>; Tue, 13 Jan 2026 21:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB90350298;
	Tue, 13 Jan 2026 21:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="zSX9a75q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2CD34F256;
	Tue, 13 Jan 2026 21:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768340806; cv=none; b=DxiVNp92eyoy9sTA6yxOA4kqmFUAlwHp77nDwswzNUgmebTyKD7FXHZReY68BP6hcE+gy++RE9FcvS+xnavwz8tI/+tcVsBT3AaYfjMhLjIzSNtaORamy98ECKFQZhWMsYZUynBe59OqdjDoGHCZB+9TOSSKUWLmyQ1Lc66ZN/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768340806; c=relaxed/simple;
	bh=ZTDjIe3A3F2nwPPzv8C55wTsqbHPvVf8qFMA2lKaf0s=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=X0K5DfoXs081ne11cP+nxcGXFt8XMJU5u7+DcjoHyq016CmB5pQSrIF3icGfKosxgLr6i0RQ9Wvt4svMpRC27P4ALf68a31CfLhb+16zlIclq8N3JYL2PZSlKljlHAXlGpMYU9GveA/B1ervO6iO+P7MyAbFfS1azLBRA9NDOMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=zSX9a75q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 748C7C2BC87;
	Tue, 13 Jan 2026 21:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1768340806;
	bh=ZTDjIe3A3F2nwPPzv8C55wTsqbHPvVf8qFMA2lKaf0s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=zSX9a75qVNuIkBH/sYml4picIhPSQHuMbZop2DBHmr9o0xuFX/P5JgVNgGPCjXyoB
	 rfyFfGwus4dUzPUnyLTE5G0QKL/QnrNbrCSV/Vs/2cTGSgzDZJTReh/S8r6XkmzG4G
	 LzEzuNrJT+DQT/c+j1ff7t8y5JMT3e/+pO2Gmxyk=
Date: Tue, 13 Jan 2026 13:46:44 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Dennis Zhou <dennis@kernel.org>, Tejun Heo
 <tj@kernel.org>, Christoph Lameter <cl@linux.com>, Martin Liu
 <liumartin@google.com>, David Rientjes <rientjes@google.com>,
 christian.koenig@amd.com, Shakeel Butt <shakeel.butt@linux.dev>, SeongJae
 Park <sj@kernel.org>, Michal Hocko <mhocko@suse.com>, Johannes Weiner
 <hannes@cmpxchg.org>, Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R . Howlett"
 <liam.howlett@oracle.com>, Mike Rapoport <rppt@kernel.org>, Suren
 Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
 Christian Brauner <brauner@kernel.org>, Wei Yang
 <richard.weiyang@gmail.com>, David Hildenbrand <david@redhat.com>, Miaohe
 Lin <linmiaohe@huawei.com>, Al Viro <viro@zeniv.linux.org.uk>,
 linux-mm@kvack.org, stable@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Yu Zhao <yuzhao@google.com>, Roman
 Gushchin <roman.gushchin@linux.dev>, Mateusz Guzik <mjguzik@gmail.com>,
 Matthew Wilcox <willy@infradead.org>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, Aboorva Devarajan <aboorvad@linux.ibm.com>
Subject: Re: [PATCH v1 1/1] mm: Fix OOM killer and proc stats inaccuracy on
 large many-core systems
Message-Id: <20260113134644.9030ba1504b8ea41ec91a3be@linux-foundation.org>
In-Reply-To: <20260113194734.28983-2-mathieu.desnoyers@efficios.com>
References: <20260113194734.28983-1-mathieu.desnoyers@efficios.com>
	<20260113194734.28983-2-mathieu.desnoyers@efficios.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 Jan 2026 14:47:34 -0500 Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> Use the precise, albeit slower, precise RSS counter sums for the OOM
> killer task selection and proc statistics. The approximated value is
> too imprecise on large many-core systems.

Thanks.

Problem: if I also queue your "mm: Reduce latency of OOM killer task
selection" series then this single patch won't get tested, because the
larger series erases this patch, yes?

Obvious solution: aim this patch at next-merge-window and let's look at
the larger series for the next -rc cycle.  Thoughts?

> The following rss tracking issues were noted by Sweet Tea Dorminy [1],
> which lead to picking wrong tasks as OOM kill target:
> 
>   Recently, several internal services had an RSS usage regression as part of a
>   kernel upgrade. Previously, they were on a pre-6.2 kernel and were able to
>   read RSS statistics in a backup watchdog process to monitor and decide if
>   they'd overrun their memory budget. Now, however, a representative service
>   with five threads, expected to use about a hundred MB of memory, on a 250-cpu
>   machine had memory usage tens of megabytes different from the expected amount
>   -- this constituted a significant percentage of inaccuracy, causing the
>   watchdog to act.
> 
>   This was a result of commit f1a7941243c1 ("mm: convert mm's rss stats
>   into percpu_counter") [1].  Previously, the memory error was bounded by
>   64*nr_threads pages, a very livable megabyte. Now, however, as a result of
>   scheduler decisions moving the threads around the CPUs, the memory error could
>   be as large as a gigabyte.
> 
>   This is a really tremendous inaccuracy for any few-threaded program on a
>   large machine and impedes monitoring significantly. These stat counters are
>   also used to make OOM killing decisions, so this additional inaccuracy could
>   make a big difference in OOM situations -- either resulting in the wrong
>   process being killed, or in less memory being returned from an OOM-kill than
>   expected.
> 
> Here is a (possibly incomplete) list of the prior approaches that were
> used or proposed, along with their downside:
> 
> 1) Per-thread rss tracking: large error on many-thread processes.
> 
> 2) Per-CPU counters: up to 12% slower for short-lived processes and 9%
>    increased system time in make test workloads [1]. Moreover, the
>    inaccuracy increases with O(n^2) with the number of CPUs.
> 
> 3) Per-NUMA-node counters: requires atomics on fast-path (overhead),
>    error is high with systems that have lots of NUMA nodes (32 times
>    the number of NUMA nodes).
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

Please confirm - switching /proc functions from get_mm_counter_sum() to
get_mm_counter_sum() doesn't actually change anything, right?  It would
be concerning to add possible overhead to things like task_statm().

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
>                                   |  before  |  after   |
> ----------------------------------|----------|----------|
> nr_processes=40                   |  0.3 ms  |   0.5 ms |
> nr_processes=10000                |  3.0 ms  |  80.0 ms |

That seems acceptable.



