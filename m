Return-Path: <stable+bounces-208307-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 34105D1BC22
	for <lists+stable@lfdr.de>; Wed, 14 Jan 2026 00:55:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A01730198D2
	for <lists+stable@lfdr.de>; Tue, 13 Jan 2026 23:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D28355050;
	Tue, 13 Jan 2026 23:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="oNDPTWg3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636C028EA72;
	Tue, 13 Jan 2026 23:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768348543; cv=none; b=I1hdCkYbo0jSQP1ZEHGaucGNBTPqufQmu++6XbTaSMAJLlIJ1M4CvdjbB4uyHCiTRqdcbHjTcX0cNKyxdh7u2lBgOkGAa909xlRjhcQsEgBh1hIlTHoImXmcncfDiFnJppCKGtZy/qIphXbgsxwTDCILMCO0+R1oVgJbzgRn+6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768348543; c=relaxed/simple;
	bh=wFoCy9Y9KpIUogkM2AHajucOyerXJdtm/9lw1BUwhns=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=gv1VKqqe/OeaF+du6MLBIulFsyiU8rz+hlV2GNOiO91js+YonWQMInOwdZ0ZIwFLJwZeAHxvd6I8nXrs1ay5dwVlLNfe0L23yl3s1Z2o/fR9fsyqtV/ZBuHGnY1K9vU4/Z+jtgjIdjAqU0M6vYYnNpRmNb6EXVIEYz1GPH+UqvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=oNDPTWg3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E48ADC116C6;
	Tue, 13 Jan 2026 23:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1768348542;
	bh=wFoCy9Y9KpIUogkM2AHajucOyerXJdtm/9lw1BUwhns=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oNDPTWg3As9b4/IoWoDYObKJbmE2BB/hi0wmGKS5YwB53tgMgdYTyaqeZRLCuXEHq
	 GJjdm0tTbmUSA8x/ZOXB59//Cnpt/kq7KUphyJ80w+zEVXgFISjYFt4Fx/JbcRJTnd
	 yvESKNRQiaSKpc9jZoqeV61AmDuB6ASSj+30c9zk=
Date: Tue, 13 Jan 2026 15:55:41 -0800
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
Message-Id: <20260113155541.1da4b93e2acbb2b4f2cda758@linux-foundation.org>
In-Reply-To: <c5d48b86-6b8e-4695-bbfa-a308d59eba52@efficios.com>
References: <20260113194734.28983-1-mathieu.desnoyers@efficios.com>
	<20260113194734.28983-2-mathieu.desnoyers@efficios.com>
	<20260113134644.9030ba1504b8ea41ec91a3be@linux-foundation.org>
	<c5d48b86-6b8e-4695-bbfa-a308d59eba52@efficios.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 Jan 2026 17:16:16 -0500 Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> On 2026-01-13 16:46, Andrew Morton wrote:
> > On Tue, 13 Jan 2026 14:47:34 -0500 Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> > 
> >> Use the precise, albeit slower, precise RSS counter sums for the OOM
> >> killer task selection and proc statistics. The approximated value is
> >> too imprecise on large many-core systems.
> > 
> > Thanks.
> > 
> > Problem: if I also queue your "mm: Reduce latency of OOM killer task
> > selection" series then this single patch won't get tested, because the
> > larger series erases this patch, yes?
> 
> That's a good point.
> 
> > 
> > Obvious solution: aim this patch at next-merge-window and let's look at
> > the larger series for the next -rc cycle.  Thoughts?
> 
> Yes, that works for me. Does it mean I should re-submit the hpcc
> series after the next merge window closes, or do you keep a queue of
> stuff waiting for the next -rc cycle somewhere ?

I do keep such a queue, but I rarely use it - things go stale quickly. 
So a fresh version would be best please.

> >> Note that commit 82241a83cd15 ("mm: fix the inaccurate memory statistics
> >> issue for users") introduced get_mm_counter_sum() for precise proc
> >> memory status queries for _some_ proc files. This change renames
> >> get_mm_counter_sum() to get_mm_counter(), thus moving the rest of the
> >> proc files to the precise sum.
> > 
> > Please confirm - switching /proc functions from get_mm_counter_sum() to
> > get_mm_counter_sum() doesn't actually change anything, right?  It would
> > be concerning to add possible overhead to things like task_statm().
> 
> The approach proposed by this patch is to switch all proc ABIs which
> query RSS to the precise sum to eliminate any discrepancy caused by too
> imprecise approximate sums. It's a big hammer, and it can slow down
> those proc interfaces, including task_statm().

Oh, so I misunderstood.

> Is it an issue ?

Well it might be - there are a lot of users out there and they do the
weirdest stuff.

> The hpcc series introduces an approximation which provides accuracy
> limits on the approximation that make the result is still somewhat
> meaninful on large many core systems.

Can we leave the non-oom related parts of procfs as-is for now, then
migrate them over to hpcc when that is available?  Safer that way.

> The overall approach here would be to move back those proc interfaces
> which care about low overhead to the hpcc approximate sum when it lands
> upstream. But in order to learn that, we need to know which proc
> interface files are performance-sensitive. How can we get that data ?

Gee.  Wait for the unhappy emails :(

People do sometimes search all-of-open-source for API changes, but that
doesn't cover in-house things, and tools which whack away at /proc
files are often in-house-only.


