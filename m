Return-Path: <stable+bounces-185600-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AD51EBD836E
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 10:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4CA244FA108
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 08:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6CA430FF13;
	Tue, 14 Oct 2025 08:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="M3rH3JTA"
X-Original-To: stable@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF75630FC3E;
	Tue, 14 Oct 2025 08:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760431091; cv=none; b=HUtnbetgoOF0TH43L2bO6dwMs0yWeJr2N7CBElti/lsmwQXrSoONAbCMnDCYy9K/G3hxuXZXFOvyXao7ZcjZfLBrhaWwfprDTMdLpVfxcDYbLTR0yS4PVVkXb5DEee3U1hiSyuwLXZcRFQi5vyYwTwpyLdLORCgWE10Ub+gKfoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760431091; c=relaxed/simple;
	bh=xFxTZk9k8z1ceBZfTEHBte/M5l6HENgtLC2nPfTfCBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a49Y9pIysn9ClIk/PGzjOfCXID5/xeropoYp7dVWUri+7uflx9yeVnLLsuJi0zcuPbzQm0/TOYonglsAitqXqfLqYkCTH8xcFe4cwIOmoZw55Sr76zB5cU3zUnwVp/+4+V8xzG33AFRZayCUs6bI2vP6tNTboLj+Ya6hZ+PlJjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=M3rH3JTA; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=teelVvdHnPXhmeC0lPG5a8S5FoS735QXhS6EymF1m+s=; b=M3rH3JTAn+2Q8+raj9gahfIn1l
	3hnHsRuGMSmqmi2R7nBl1IuhQItDEyWXRsSlymaygn5upUYJ3sT63/GF9CYS0ZkZ2XUlMyqSTripQ
	L/ZQ/5LbOOPJMTPPB7r+rAOuu9YcYAPgEKHOzXKoqa4HKgcYuCcJ4+uilkNvfjEfEsfJBMs89cs3P
	w39TknT3PBmvlZGRf8MGUWsWklPP5jgL24UZ4ayH+M7RZg1cFixqdExuOlN3T7Spr9x88zZzUI7Za
	X50CnPRdUDd2QKK/M+45LfCIeXdRnlNMn/5oGERxdZyOTZft3a16hDB6uEO9yNg1kDqBP4LMv29ZM
	lQ/M4AGw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8aXV-000000052l3-1yVI;
	Tue, 14 Oct 2025 08:37:49 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E42FE300212; Tue, 14 Oct 2025 10:37:48 +0200 (CEST)
Date: Tue, 14 Oct 2025 10:37:48 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: George Kennedy <george.kennedy@oracle.com>
Cc: ravi.bangoria@amd.com, harshit.m.mogalapalli@oracle.com,
	mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, tglx@linutronix.de, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	dongli.zhang@oracle.com, stable@vger.kernel.org
Subject: Re: [PATCH] [PATCH v3] perf/x86/amd: check event before enable to
 avoid GPF
Message-ID: <20251014083748.GP3245006@noisy.programming.kicks-ass.net>
References: <1728392453-18658-1-git-send-email-george.kennedy@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1728392453-18658-1-git-send-email-george.kennedy@oracle.com>

On Tue, Oct 08, 2024 at 08:00:53AM -0500, George Kennedy wrote:
> On AMD machines cpuc->events[idx] can become NULL in a subtle race
> condition with NMI->throttle->x86_pmu_stop().
> 
> Check event for NULL in amd_pmu_enable_all() before enable to avoid a GPF.
> This appears to be an AMD only issue.
> 
> Syzkaller reported a GPF in amd_pmu_enable_all.
> 
> INFO: NMI handler (perf_event_nmi_handler) took too long to run: 13.143
>     msecs
> Oops: general protection fault, probably for non-canonical address
>     0xdffffc0000000034: 0000  PREEMPT SMP KASAN NOPTI
> KASAN: null-ptr-deref in range [0x00000000000001a0-0x00000000000001a7]
> CPU: 0 UID: 0 PID: 328415 Comm: repro_36674776 Not tainted 6.12.0-rc1-syzk
> RIP: 0010:x86_pmu_enable_event (arch/x86/events/perf_event.h:1195
>     arch/x86/events/core.c:1430)
> RSP: 0018:ffff888118009d60 EFLAGS: 00010012
> RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
> RDX: 0000000000000034 RSI: 0000000000000000 RDI: 00000000000001a0
> RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000002
> R13: ffff88811802a440 R14: ffff88811802a240 R15: ffff8881132d8601
> FS:  00007f097dfaa700(0000) GS:ffff888118000000(0000) GS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000000200001c0 CR3: 0000000103d56000 CR4: 00000000000006f0
> Call Trace:
>  <IRQ>
> amd_pmu_enable_all (arch/x86/events/amd/core.c:760 (discriminator 2))
> x86_pmu_enable (arch/x86/events/core.c:1360)
> event_sched_out (kernel/events/core.c:1191 kernel/events/core.c:1186
>     kernel/events/core.c:2346)
> __perf_remove_from_context (kernel/events/core.c:2435)
> event_function (kernel/events/core.c:259)
> remote_function (kernel/events/core.c:92 (discriminator 1)
>     kernel/events/core.c:72 (discriminator 1))
> __flush_smp_call_function_queue (./arch/x86/include/asm/jump_label.h:27
>     ./include/linux/jump_label.h:207 ./include/trace/events/csd.h:64
>     kernel/smp.c:135 kernel/smp.c:540)
> __sysvec_call_function_single (./arch/x86/include/asm/jump_label.h:27
>     ./include/linux/jump_label.h:207
>     ./arch/x86/include/asm/trace/irq_vectors.h:99 arch/x86/kernel/smp.c:272)
> sysvec_call_function_single (arch/x86/kernel/smp.c:266 (discriminator 47)
>     arch/x86/kernel/smp.c:266 (discriminator 47))
>  </IRQ>
> 
> Reported-by: syzkaller <syzkaller@googlegroups.com>
> Signed-off-by: George Kennedy <george.kennedy@oracle.com>
> ---

Without a Fixes tag it goes into perf/core.

