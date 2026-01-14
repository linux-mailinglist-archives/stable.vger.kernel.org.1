Return-Path: <stable+bounces-208311-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D360BD1BF3A
	for <lists+stable@lfdr.de>; Wed, 14 Jan 2026 02:36:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 71A5A3024104
	for <lists+stable@lfdr.de>; Wed, 14 Jan 2026 01:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C7F2E54A3;
	Wed, 14 Jan 2026 01:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="WFWinnB3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478D22BEFFE;
	Wed, 14 Jan 2026 01:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768354535; cv=none; b=IEITUacLJeaepfywqaOo9JYXCSMXcY6fgUmtnnUiK1qQVXjVj/8gE3TlqAavscUHV+l/ywt8eTOdsoGo+kqCqpANj7wPxQk0G1CPwKZ8bqC7MPERsyS2d8/tHxUCy+nMz13o2KCJt7X2UhYZvWAJb7rUUP80g+H8j76El1ffOcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768354535; c=relaxed/simple;
	bh=6qALRjnUz1ToVYlX9uZ6rJccj/CbX4YXQwA1PWOPaaw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=fUfS/YIxjzYbYofzG5vbTLPc0OvtsgTUlIHaptVZRIJRZqoHoS5AtHqgzREJ6TJ7Vog2KF+Nz/QRWjDZp3fmsGUt3Etq8KlknOFFKGCxn0qfcEQC5Y84PxRZaB1miONr/fkiPS411c5GNCIc/c6JFz6kIf8iDBoGJjub2WomfGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=WFWinnB3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B68ADC116C6;
	Wed, 14 Jan 2026 01:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1768354534;
	bh=6qALRjnUz1ToVYlX9uZ6rJccj/CbX4YXQwA1PWOPaaw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WFWinnB350Gh+ZI0sjON+AkppzMI0aB6KQLZA9feNZIiAHT/+LubVU1LrZA37J23X
	 cQZuJtW+NS4T/g7a4HJCKBxYSPJsaPzGO7XmOwtVTchOf0Dn/7ztycXSE+cMdw+Q81
	 wyfkoQ0v7Zk0vRCzU3NQ3xqTqxAq+7jBXMDO4Lts=
Date: Tue, 13 Jan 2026 17:35:33 -0800
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
Message-Id: <20260113173533.171248b2f6c11c536e4fc65a@linux-foundation.org>
In-Reply-To: <162c241c-8dd9-4700-a538-0a308de2de8d@efficios.com>
References: <20260113194734.28983-1-mathieu.desnoyers@efficios.com>
	<20260113194734.28983-2-mathieu.desnoyers@efficios.com>
	<20260113134644.9030ba1504b8ea41ec91a3be@linux-foundation.org>
	<c5d48b86-6b8e-4695-bbfa-a308d59eba52@efficios.com>
	<20260113155541.1da4b93e2acbb2b4f2cda758@linux-foundation.org>
	<162c241c-8dd9-4700-a538-0a308de2de8d@efficios.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 Jan 2026 20:22:16 -0500 Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> On 2026-01-13 18:55, Andrew Morton wrote:
> > On Tue, 13 Jan 2026 17:16:16 -0500 Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> > 
> >> The hpcc series introduces an approximation which provides accuracy
> >> limits on the approximation that make the result is still somewhat
> >> meaninful on large many core systems.
> > 
> > Can we leave the non-oom related parts of procfs as-is for now, then
> > migrate them over to hpcc when that is available?  Safer that way.
> 
> Of course.
> 
> So AFAIU the plan is:
> 
> 1) update the oom accuracy fix to only use the precise sum for
>     the oom killer, no changes to procfs ABIs. This targets mm-new.
> 
> 2) update the hpcc series to base them on top of the new fix from (1).
>     Update their commit messages to indicate that they bring accuracy
>     improvements to the procfs ABI on large many-core systems, as well as
>     latency improvements to the oom killer. This will target upstreaming
>     after the next merge window, but I will still post it soon to gather
>     feedback.
> 
> Does that plan look OK ?

Perfect, thanks.  Except there is no "(1)".  We shall survive ;)

