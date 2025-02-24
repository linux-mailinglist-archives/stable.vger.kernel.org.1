Return-Path: <stable+bounces-118913-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC74A41F02
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 13:30:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CE237A6861
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 12:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDBA9233705;
	Mon, 24 Feb 2025 12:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XE0UiHbI"
X-Original-To: stable@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA750221F28;
	Mon, 24 Feb 2025 12:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740400240; cv=none; b=Y7H0eYRMN5QzRnRBxw5IS8TWJJ3AZZ2NAAxkig/LjNxQ+5KhyW+4ovm3XZKtTCchCvdnF/+kWa147TM3h1+yRGuYKziIp60Wv9EWWn3pMbUZFXxnigYZ6wQ3TJv44iPX3avdSxgMFJfxRmbKJr5eu1LXEVDgE7hjh0ZkyeZuBYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740400240; c=relaxed/simple;
	bh=KKSDuwiqxV1KoGt8i3X/NyTVkTA4R2O1wM6NK5q9Hlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nnLdIBivTayOgC0K22V+aPp6ciDNcDZkNTi3MU3+4JTYiotUcXnICpGnQ1Yw8c8urD37KED9lg93j+XEpfnW6k+Umj1m8Aw5VicKeQ38gMyRLqYtz3mBGcQlvFTiQFVznzT1eUn3AKlOlw9mG01A9qlE+/2IQuEFJgKvIrpa0CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XE0UiHbI; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Cuml9pjheHqYp5UhUUUvrYoTl+l5pewIdTK7K+O6jLY=; b=XE0UiHbI+NIl7R3h6OxQ3DfU10
	Ix069tOLklr23NJKZosDB2SmOQhXvm7k/ZZh6zasd/GGSxP2svaj/BYeGZQ/nr/Z0XLb88n+arXnr
	OlO7v73KvzzqAob093PbnQ8I6/imQrAKlrUU+Xv7IfiPo2sqQQoLUQ9VBlRZCA7x35nc1Qe+mhxLF
	16OVZHEIykPkO2SNxwlQmQpKDA7d4n+NQnaQD6UOLVA9ILX4Xsc9ZGPmkUvbNSaDkf72ntJBz9Tej
	04JgyqD+GGKU6x1nXNxWHCi9pOVJ+EQmHGia8JPGcYNS8+6pF4K8tH/XSUeW0V9k4+RMpnTW0NHF7
	9+Y+pjPg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tmXbF-000000075Wj-27N8;
	Mon, 24 Feb 2025 12:30:17 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 977BC300164; Mon, 24 Feb 2025 13:30:16 +0100 (CET)
Date: Mon, 24 Feb 2025 13:30:16 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Breno Leitao <leitao@debian.org>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	kuba@kernel.org, kernel-team@meta.com, stable@vger.kernel.org
Subject: Re: [PATCH] perf: Add RCU read lock protection to perf_iterate_ctx()
Message-ID: <20250224123016.GA17456@noisy.programming.kicks-ass.net>
References: <20250117-fix_perf_rcu-v1-1-13cb9210fc6a@debian.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250117-fix_perf_rcu-v1-1-13cb9210fc6a@debian.org>

On Fri, Jan 17, 2025 at 06:41:07AM -0800, Breno Leitao wrote:
> The perf_iterate_ctx() function performs RCU list traversal but
> currently lacks RCU read lock protection. This causes lockdep warnings
> when running perf probe with unshare(1) under CONFIG_PROVE_RCU_LIST=y:
> 
> 	WARNING: suspicious RCU usage
> 	kernel/events/core.c:8168 RCU-list traversed in non-reader section!!
> 
> 	 Call Trace:
> 	  lockdep_rcu_suspicious
> 	  ? perf_event_addr_filters_apply
> 	  perf_iterate_ctx
> 	  perf_event_exec
> 	  begin_new_exec
> 	  ? load_elf_phdrs
> 	  load_elf_binary
> 	  ? lock_acquire
> 	  ? find_held_lock
> 	  ? bprm_execve
> 	  bprm_execve
> 	  do_execveat_common.isra.0
> 	  __x64_sys_execve
> 	  do_syscall_64
> 	  entry_SYSCALL_64_after_hwframe
> 
> This protection was previously present but was removed in commit
> bd2756811766 ("perf: Rewrite core context handling"). Add back the
> necessary rcu_read_lock()/rcu_read_unlock() pair around
> perf_iterate_ctx() call in perf_event_exec().

Hurm, I think it got ripped out because we no longer need to refer that
perf_event_ctxp[].

Anyway, please write it like so:


diff --git a/kernel/events/core.c b/kernel/events/core.c
index 0f8c55990783..b77f95089d62 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -8320,7 +8320,8 @@ void perf_event_exec(void)
 
 	perf_event_enable_on_exec(ctx);
 	perf_event_remove_on_exec(ctx);
-	perf_iterate_ctx(ctx, perf_event_addr_filters_exec, NULL, true);
+	scoped_guard(rcu)
+		perf_iterate_ctx(ctx, perf_event_addr_filters_exec, NULL, true);
 
 	perf_unpin_context(ctx);
 	put_ctx(ctx);

