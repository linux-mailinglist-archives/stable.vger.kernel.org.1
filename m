Return-Path: <stable+bounces-208369-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A953D1FF6C
	for <lists+stable@lfdr.de>; Wed, 14 Jan 2026 16:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 29C693006A6B
	for <lists+stable@lfdr.de>; Wed, 14 Jan 2026 15:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0303A0B09;
	Wed, 14 Jan 2026 15:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fjQGs/OQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDC039E6F3
	for <stable@vger.kernel.org>; Wed, 14 Jan 2026 15:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768406054; cv=none; b=k4miMdhL/SZbqJPRyH66S31ad5hNxIF9SdKZaDE2upWMxEZOqsXepVqhbt/pBedSBRAM5G2PIMh52lWxRT0z7PoZlsFvOw8f6eVTrW+LvjV641rgw2lb4VB8r0R1uqdrxydIoL2YykSMwGs/1LM/tmzfFJwUv6I29h7BRb92VaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768406054; c=relaxed/simple;
	bh=wjb7DV6a6LwACgVmzzJ/EBZrxDOQc5PVuk7UZ2S02XU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NBrssOVP0TYFRWXao1Vp1gSSV20TYeEjaAcSzSsj2XpCi6C6K2quhU5QWjTdfI9swLADRWnvpmAyNlNL39hLQgm2pupAp8dMLbulm0Msn5q6RUpb3+HBrw2z2CQstfWlFR/0VmVWQJfkCNZ85lkZ4uNmDdC5Vgxd+TFCatmgKQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fjQGs/OQ; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-432d2c7dd52so4858473f8f.2
        for <stable@vger.kernel.org>; Wed, 14 Jan 2026 07:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768406051; x=1769010851; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xs1zwttE7p4/0ur/jP8GIFx6Rfs9HdyvBQXhSiEgK3o=;
        b=fjQGs/OQdMpw8kQFMKC7K/MgXEWBgzzAqkvKXn7iyAsZBuuPfJ+Q+BGqqJ3vOtAu9O
         Nut96e9MZs8EY+61PMOTN0XDs8GJGg9Vy7H7ve1BOqXG8hqdsar2zfVjnPuu+rTkrj/p
         bin7OWavLJ/o5hpSgHyyMgyM3p0mQz4WDgmX4ObwhA79W4u8yGZjnhDSDlRwUzzM5ccP
         sth+bvLACak6XKLHH55e9RbkbrVw7FmG8UX9F0esGlipmM2iPQ5rckUnWlweu2cDOEUf
         pCdyrjfhDrSvFTXg5ohh9HdLgngBaMBZqsu7HwQ+G54IwaReH7rYfadqmsYV91aw/Z2L
         N2gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768406051; x=1769010851;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xs1zwttE7p4/0ur/jP8GIFx6Rfs9HdyvBQXhSiEgK3o=;
        b=X3teCdBuJsL8RNfCzsnymXa7lWbn0Kzfktfrp02Kut+Oa1v5sQbsduPLXuHNkT6ngM
         c6JlPiXf+w/Q8jPv9M0MvpxhAg3epP9UNQ1JH98UGr/PlG8TX3/aMWBRiuLHG2LZdMDF
         jvEstcEmx6KXi9+ixsT5FHWvCaRSoWqKnYpITJG0fnMs8x9XJKDeEbI0r6UcWcQlSysU
         FbZYhBBUIbNNJ96KKXR8wVhRffT1C9Hj6EWC3a5yDHWrBWSdFVMrxkaTM2598Uf7mf6v
         IRj0aqtBrFsTPGKI6pzn31fZHU94zJBT3sENikHTQU0SPYDfYPZt/BJyL+8ntwwm+Fv+
         Ig9A==
X-Forwarded-Encrypted: i=1; AJvYcCVFRae2JzLxD3oK2IPH0XsWrHfSUzSjvZhn8JhXuDl6XjAWC51pn83j2P8BvV8/MrNBv7rOULg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTCZQ90cggtHPb9XQDEFnv2ACULdvCyKe/KFZ8j50gbP2phU1U
	L7gaOu9gnS4oPpG3MhApZ6IxER/5bglMUEzXZWwjkFCZIh4/NMlzgzpBFTM1qHUvtpc=
X-Gm-Gg: AY/fxX6ujt1ok95boHU1uaA1hX90j+aNw8lLT1K5f5PTaYc2k4aPcb3p+ml5bWlpOjo
	BiUnWLGdyDsTYd/kqout7rFcuMN9w4lVY0+QrFM41OWzEt3ldT/xplE3tTjeC01oUSsaqOHmbp6
	R7y5E8puH/7ECdatY7lygvZ7ztZguDdfmz1Ei+Izp/JJ1uo8OsFNrFE4zEtDjsjDkgnNUD6AaeU
	6QQtuXjbPes2/0JCDQeXhWCHT8LlCkEZrbMGovuyUpb3FBZCTOUVgyxy+kcLXn5UaBa7oajGXEv
	Os5stfqGTK/Wh+yBJ6wJvc7CZKGwzkisZFqNDm8/43gbgnWyEooFhpBlzbAwweoWrRitnURoQdG
	W6mas1qJY+A9Ln3pF3InNrluyFxrobBrfFZl43Mxrq6WsLNTTr5Dimk8m6SRwqPTrC1FSpMNPQ9
	SZCiNTQ6jjfQPcC3vJdjXUyQar
X-Received: by 2002:a05:6000:40e1:b0:431:54c:6f0 with SMTP id ffacd0b85a97d-4342c4f4d19mr3125206f8f.4.1768406051369;
        Wed, 14 Jan 2026 07:54:11 -0800 (PST)
Received: from localhost (109-81-19-111.rct.o2.cz. [109.81.19.111])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5fe67csm50716588f8f.40.2026.01.14.07.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 07:54:10 -0800 (PST)
Date: Wed, 14 Jan 2026 16:54:09 +0100
From: Michal Hocko <mhocko@suse.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@linux.com>, Martin Liu <liumartin@google.com>,
	David Rientjes <rientjes@google.com>, christian.koenig@amd.com,
	Shakeel Butt <shakeel.butt@linux.dev>,
	SeongJae Park <sj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
	Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R . Howlett" <liam.howlett@oracle.com>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Wei Yang <richard.weiyang@gmail.com>,
	David Hildenbrand <david@redhat.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-mm@kvack.org,
	stable@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Yu Zhao <yuzhao@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Aboorva Devarajan <aboorvad@linux.ibm.com>
Subject: Re: [PATCH v2 1/1] mm: Fix OOM killer inaccuracy on large many-core
 systems
Message-ID: <aWe8IdTYEMJt3GTH@tiehlicka>
References: <20260114143642.47333-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114143642.47333-1-mathieu.desnoyers@efficios.com>

On Wed 14-01-26 09:36:42, Mathieu Desnoyers wrote:
> Use the precise, albeit slower, precise RSS counter sums for the OOM
> killer task selection and console dumps. The approximated value is
> too imprecise on large many-core systems.
> 
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
> commit 82241a83cd15 ("mm: fix the inaccurate memory statistics issue for
> users") introduced get_mm_counter_sum() for precise proc memory status
> queries for some proc files.
> 
> The simple fix proposed here is to do the precise per-cpu counters sum
> every time a counter value needs to be read. This applies to the OOM
> killer task selection, oom task console dumps (printk).
> 
> This change increases the latency introduced when the OOM killer
> executes in favor of doing a more precise OOM target task selection.
> Effectively, the OOM killer iterates on all tasks, for all relevant page
> types, for which the precise sum iterates on all possible CPUs.
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
> 
> Suggested-by: Michal Hocko <mhocko@suse.com>
> Fixes: f1a7941243c1 ("mm: convert mm's rss stats into percpu_counter")
> Link: https://lore.kernel.org/lkml/20250331223516.7810-2-sweettea-kernel@dorminy.me/ # [1]
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

OOM is a rare situation - therefore a slow path - and handling taking
care of a huge imprecesion is much more important than adding ~100ms
overhead to calculate more precise memory consuption.

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

-- 
Michal Hocko
SUSE Labs

