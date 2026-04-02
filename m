Return-Path: <stable+bounces-232909-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFs4LMbzzWlLjgYAu9opvQ
	(envelope-from <stable+bounces-232909-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 06:42:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B84383B3F
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 06:42:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 01025303339D
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 04:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18117366550;
	Thu,  2 Apr 2026 04:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vWXGzyn1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IurlPxyt"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B0A366060;
	Thu,  2 Apr 2026 04:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775104958; cv=none; b=mnLs4aWBf6iOK7W4i6wBW9ej7d3FmqI5bph6FmEyeKmf2mVz8CeTJ+yLQCzTF2LqLi/8ClIXMxFlJhOyfDIVucLggw0CrBETgEmtjcDncqFILJQ5vHAGICqhceV0nr88xY5ZxBj0HlR/x4u+s9CVVfa7rk4cK7vbpukG/hMGaH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775104958; c=relaxed/simple;
	bh=XIVO2rDhF7vl2myZmgFd67wiPZXQ7C/T7hTBVST245I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qqxidG+4BXu2XvZDrPu/kW1j/CZm8ACOXyr5JdH7OUkRyfSYdPMypDCNxROD0IQJgWAQwbnfCyTuOjFSlci0gtMvtf2JGmcxmHT7WGEFzs246daPgWWyUjEaRvRw8Rv6L9brHJ83YchcHAagrpNHjeczxoZvGInxYL9CG7psk5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vWXGzyn1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IurlPxyt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1775104955;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MJvxgmla7GJ40kGY75h8wil3XQl50FCUl05/E1jznUo=;
	b=vWXGzyn1Ah4NVW1Mlx6bVWLSBj6AYX9pCd9DrDOplQTmbGujEMKDfVdk9UuQSy4q/EB+8j
	JbSoHM0OO3CXsGn4pqDs8ysla/YeDW81rKvL9oMlDSU/wJwEwNXBwVEXmKQxttdHCCtWHo
	7bMByldcwMuRdSwyAqbIbVhr09Nh5iOZuF3dTgEvAYv8muo0576uG3wW0ftYbyCT+1GWyq
	gsQhjmiz6dYjOVC7gzheLv3qXVvheTKJr8qE9ktdT2m9XlyVi9m5J2OKt1IAYR7+G81PSc
	Ccn6ATCGsbpr6A2imtJGqLjtn/4UiXtw+q2mleqWmx/aU5fGJJjqJADChxr5xg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1775104955;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MJvxgmla7GJ40kGY75h8wil3XQl50FCUl05/E1jznUo=;
	b=IurlPxyt1Bfb+kV3Q+c8hoyBvdrj8JLeMIg7p9Kgwjh781UgDqCuCKKy/ODbWXkRUht4Vn
	3iR/ddfJc1aykxAQ==
To: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>,
 jan.kiszka@siemens.com
Cc: crwood@redhat.com, florian.bezdeka@siemens.com,
 ionut.nechita@windriver.com, brauner@kernel.org,
 linux-fsdevel@vger.kernel.org, linux-rt-users@vger.kernel.org,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 frederic@kernel.org, vschneid@redhat.com, gregkh@linuxfoundation.org,
 chris.friesen@windriver.com, viorel-catalin.rapiteanu@windriver.com,
 iulian.mocanu@windriver.com
Subject: Re: [REGRESSION] osnoise: "eventpoll: Replace rwlock with spinlock"
 causes ~50us noise spikes on isolated PREEMPT_RT cores
In-Reply-To: <20260401165841.532687-1-ionut.nechita@windriver.com>
References: <22ffc044-4cc7-468c-b11d-9b838c92e82b@siemens.com>
 <20260401165841.532687-1-ionut.nechita@windriver.com>
Date: Thu, 02 Apr 2026 06:42:32 +0200
Message-ID: <878qb6x9af.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-232909-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[namcao@linutronix.de,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linutronix.de:dkim,yellow.woof:mid]
X-Rspamd-Queue-Id: 13B84383B3F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

"Ionut Nechita (Wind River)" <ionut.nechita@windriver.com> writes:
> Crystal, Jan, Florian, thanks for the detailed feedback. I've redone
> all testing addressing each point raised. All tests below use HT
> disabled (sibling cores offlined), as Jan requested.
>
> Setup:
>   - Hardware: Intel Xeon Gold 6338N (Ice Lake, single socket,
>     32 cores, HT disabled via sibling cores offlined)
>   - Boot: nohz_full=3D1-16 isolcpus=3Dnohz,domain,managed_irq,1-16
>     rcu_nocbs=3D1-31 kthread_cpus=3D0 irqaffinity=3D17-31
>     iommu=3Dpt nmi_watchdog=3D0 intel_pstate=3Dnone skew_tick=3D1
>   - eosnoise run with: ./osnoise -c 1-15
>   - Duration: 120s per test
>
> Tested kernels (all vanilla, built from upstream sources):
>   - 6.18.20-vanilla      (non-RT, PREEMPT_DYNAMIC)
>   - 6.18.20-vanilla      (PREEMPT_RT, with and without rwlock revert)
>   - 7.0.0-rc6-next-20260331 (PREEMPT_RT, with and without rwlock revert)
>
> I tested 6 configurations to isolate the exact failure mode:
>
>   #  Kernel          Config   Tool            Revert  Result
>   -- --------------- -------- --------------- ------- ----------------
>   1  6.18.20         non-RT   eosnoise        no      clean (100%)
>   2  6.18.20         RT       eosnoise        no      D state (hung)
>   3  6.18.20         RT       eosnoise        yes     clean (100%)
>   4  6.18.20         RT       kernel osnoise  no      clean (99.999%)
>   5  7.0-rc6-next    RT       eosnoise        no      93% avail, 57us
>   6  7.0-rc6-next    RT       eosnoise        yes     clean (99.99%)

Thanks for the detailed analysis.

> Key findings:
>
> 1. On 6.18.20-rt with spinlock, eosnoise hangs permanently in D state.
>
>    The process blocks in do_epoll_ctl() during perf_buffer__new() setup
>    (libbpf's perf_event_open + epoll_ctl loop). strace shows progressive
>    degradation as fds are added to the epoll instance:
>
>      CPU  0-13:  epoll_ctl  ~8 us     (normal)
>      CPU 14:     epoll_ctl  16 ms     (2000x slower)
>      CPU 15:     epoll_ctl  80 ms     (10000x slower)
>      CPU 16:     epoll_ctl  80 ms
>      CPU 17:     epoll_ctl  20 ms
>      CPU 18:     epoll_ctl  -- hung, never returns --
>
>    Kernel stack of the hung process (3+ minutes in D state):
>
>      [<0>] do_epoll_ctl+0xa57/0xf20
>      [<0>] __x64_sys_epoll_ctl+0x5d/0xa0
>      [<0>] do_syscall_64+0x7c/0xe30
>      [<0>] entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
> 2. On 7.0-rc6-next-rt with spinlock, eosnoise runs but with severe
>    noise. The difference from 6.18 is likely additional fixes in
>    linux-next that prevent the complete deadlock but not the contention.
>
> 3. Kernel osnoise tracer (test #4) shows zero noise on the same
>    6.18.20-rt+spinlock kernel where eosnoise hangs. This confirms the
>    issue is specifically in the epoll rt_mutex path, not in osnoise
>    measurement methodology.
>
>    Kernel osnoise output (6.18.20-rt, spinlock, no revert):
>      99.999% availability, 1-4 ns max noise, RES=3D6 total in 120s
>
> 4. Non-RT kernel (test #1) with the same spinlock change shows zero
>    noise. This confirms the issue is the spinlock-to-rt_mutex conversion
>    on PREEMPT_RT, not the spinlock change itself.
>
> IRQ deltas on isolated CPU1 (120s):
>
>                     6.18.20-rt   6.18.20-rt   6.18.20      6.18.20-rt
>                     spinlock     rwlock(rev)  non-RT       kernel osnoise
>   RES (IPI):        (D state)    3            1            6
>   LOC (timer):      (D state)    3,325        1,185        245
>   IWI (irq work):   (D state)    565,988      1,433        121
>
>                     7.0-rc6-rt   7.0-rc6-rt
>                     spinlock     rwlock(rev)
>   RES (IPI):        330,000+     2
>   LOC (timer):      120,585      120,585
>   IWI (irq work):   585,785      585,785
>
> The mechanism, refined:
>
> Crystal was right that this is specific to the BPF perf_event_output +
> epoll pattern, not any arbitrary epoll user. I verified this: a plain
> perf_event_open + epoll_ctl program without BPF does not trigger the
> issue.
>
> What triggers it is libbpf's perf_buffer__new(), which creates one
> PERF_COUNT_SW_BPF_OUTPUT perf_event per CPU, mmaps the ring buffer,
> and adds all fds to a single epoll instance. When BPF programs are
> attached to high-frequency tracepoints (irq_handler_entry/exit,
> softirq_entry/exit, sched_switch), every interrupt on every CPU calls
> bpf_perf_event_output() which invokes ep_poll_callback() under
> ep->lock.
>
> On PREEMPT_RT, ep->lock is an rt_mutex. With 15+ CPUs generating
> callbacks simultaneously into the same epoll instance, the rt_mutex
> PI mechanism creates unbounded contention.  On 6.18 this results in
> a permanent D state hang. On 7.0 it results in ~330,000 reschedule
> IPIs hitting isolated cores over 120 seconds (~2,750/s per core).
>
> With rwlock, ep_poll_callback() uses read_lock which allows concurrent
> readers without cross-CPU contention =E2=80=94 the callbacks execute in
> parallel without generating IPIs.

These IPIs do not exist without eosnoise running. eosnoise introduces
these noises into the system. For a noise tracer tool, it is certainly
eosnoise's responsibility to make sure it does not measure noises
originating from itself.

> This pattern (BPF tracepoint programs + perf ring buffer + epoll) is
> the standard architecture used by BCC tools (opensnoop, execsnoop,
> biolatency, tcpconnect, etc.), bpftrace, and any libbpf-based
> observability tool. A permanent D state hang when running such tools
> on PREEMPT_RT is a significant regression.

7.0-rc6-next is still using spin lock but has no hang problem. Likely
you are hitting a different problem here which appears when spin lock is
used, which has been fixed somewhere between 6.18.20 and 7.0-rc6-next.

If you still have the energy for it, a git bisect between 6.18.20 and
7.0-rc6-next will tell us which commit made the hang issue disappear.

> I'm not proposing a specific fix -- the previous suggestions
> (raw_spinlock trylock, lockless path) were rightly rejected. But the
> regression exists and needs to be addressed. The ep->lock contention
> under high-frequency BPF callbacks on PREEMPT_RT is a new problem
> that the rwlock->spinlock conversion introduced.
>
> Separate question: could eosnoise itself be improved to avoid this
> contention? For example, using one epoll instance per CPU instead of
> a single shared one, or using BPF ring buffer (BPF_MAP_TYPE_RINGBUF)
> instead of the per-cpu perf buffer which requires epoll. If the
> consensus is that the kernel side is working as intended and the tool
> should adapt, I'd like to understand what the recommended pattern is
> for BPF observability tools on PREEMPT_RT.

I am not familiar with eosnoise, I can't tell you. I tried compiling
eosnoise but that failed. I managed to fix the compile failure, then I
got run-time failure.

It depends on what eosnoise is using epoll for. If it is just waiting
for PERF_COUNT_SW_BPF_OUTPUT to happen, perhaps we can change to some
sort of polling implementation (e.g. wake up every 100ms to check for
data).

Best regards,
Nam

