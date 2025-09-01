Return-Path: <stable+bounces-176905-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB94B3EF0F
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 21:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BCE244E1A9F
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 19:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CEB6246BD8;
	Mon,  1 Sep 2025 19:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="N2nZhoK/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483F742050;
	Mon,  1 Sep 2025 19:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756756759; cv=none; b=YbSPva7EjXRlBzIejQlC9PxoysGrulb0KXXLQQG1QB6VzutDhMcPpztyvy5mu6shJfX7RpBb6DuhkJGTZpHX9Qp3n+TVY4mK00ahUoq0NFW7P2IsVGy6ECxohfPQ9YTnw/a6v3dTspE56+7LYdPv65UyVWbS+ZNKxZtlZM2CZhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756756759; c=relaxed/simple;
	bh=C4TZGfosvdpMdKEeuKbEg3eDbne8rkSeMAqsXA1tYqk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=XfEBx+frKQNuL65z8Hsl5z7I03X8MiW9TU/Rcf8rmkTyt6Wpuq5LvRD1UIAA8H+/kIiutVIjCTzCb4m2oftdVD2jOAJKzyaLERVHXfpTP52PoaPHAGOHmwZePK2EvlmWeJAhPLfQ3MjOiQ7pKQLhV2Fxt0vZfSFFspA/d6WPKj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=N2nZhoK/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46A35C4CEF0;
	Mon,  1 Sep 2025 19:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1756756758;
	bh=C4TZGfosvdpMdKEeuKbEg3eDbne8rkSeMAqsXA1tYqk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=N2nZhoK/Q21LIbrSnildvG4xpGY+k68+D5kfaDcIxkTjgeF3IUDsP7xsKzTzMKStp
	 GHMPTe3JVyTaKevz1ZPsATz3LZevBNmkcINf5YYDPMuSccRpOz243d4StJy5RGtIeb
	 xP0OlHp/akySD5KbATJbrZ5IaVKH9SRieMRW8uBg=
Date: Mon, 1 Sep 2025 12:59:17 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Ruan Shiyang <ruansy.fnst@fujitsu.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, lkp@intel.com,
 ying.huang@linux.alibaba.com, y-goto@fujitsu.com, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de,
 vschneid@redhat.com, Li Zhijian <lizhijian@fujitsu.com>, Vlastimil Babka
 <vbabka@suse.cz>, Ben Segall <bsegall@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH v3] mm: memory-tiering: fix PGPROMOTE_CANDIDATE counting
Message-Id: <20250901125917.e9792e5d0df12ba1c552c537@linux-foundation.org>
In-Reply-To: <20250901090122.124262-1-ruansy.fnst@fujitsu.com>
References: <20250729035101.1601407-1-ruansy.fnst@fujitsu.com>
	<20250901090122.124262-1-ruansy.fnst@fujitsu.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  1 Sep 2025 17:01:22 +0800 Ruan Shiyang <ruansy.fnst@fujitsu.com> wrote:

> Goto-san reported confusing pgpromote statistics where the
> pgpromote_success count significantly exceeded pgpromote_candidate.
> 
> On a system with three nodes (nodes 0-1: DRAM 4GB, node 2: NVDIMM 4GB):
>  # Enable demotion only
>  echo 1 > /sys/kernel/mm/numa/demotion_enabled
>  numactl -m 0-1 memhog -r200 3500M >/dev/null &
>  pid=$!
>  sleep 2
>  numactl memhog -r100 2500M >/dev/null &
>  sleep 10
>  kill -9 $pid # terminate the 1st memhog
>  # Enable promotion
>  echo 2 > /proc/sys/kernel/numa_balancing
> 
> After a few seconds, we observeed `pgpromote_candidate < pgpromote_success`
> $ grep -e pgpromote /proc/vmstat
> pgpromote_success 2579
> pgpromote_candidate 0
> 
> In this scenario, after terminating the first memhog, the conditions for
> pgdat_free_space_enough() are quickly met, and triggers promotion.
> However, these migrated pages are only counted for in PGPROMOTE_SUCCESS,
> not in PGPROMOTE_CANDIDATE.
> 
> To solve these confusing statistics, introduce PGPROMOTE_CANDIDATE_NRL to
> count the missed promotion pages.  And also, not counting these pages into
> PGPROMOTE_CANDIDATE is to avoid changing the existing algorithm or
> performance of the promotion rate limit.
> 
> ...
>

It would be good to have a Fixes: here, to tell people how far back to
backport it.

Could be either c6833e10008f or c959924b0dc5 afaict.  I'll go with
c6833e10008f, OK?


