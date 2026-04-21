Return-Path: <stable+bounces-240225-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wEFWKmHB52l4AQIAu9opvQ
	(envelope-from <stable+bounces-240225-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 20:26:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A2F443EA7D
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 20:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 259123088CA2
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 18:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3CFA36D9FE;
	Tue, 21 Apr 2026 18:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fsxr7bEV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6183436D9F8;
	Tue, 21 Apr 2026 18:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776795738; cv=none; b=Ib/7oYR2ycuX1NgSezkTYSDD06wY0zII7q68ZQmAsXrc/bcOddKdp8N/E5kUk8vUyZoY8V8aZj7OEoLFr1Yqgw5Mf7hITqLRf9uSqcsGA/Wuv2M9BR1NO60IM27J+yV29mxRaegY+k6r0OUFlRKxFeQGBpyb9bzvtFTWFVhuqqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776795738; c=relaxed/simple;
	bh=O5WgHK1O2a4ZHa0YNwooCsspiEuk/YMVn/2JzgC4fIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W5vRC/rTZrty1sZOpdKh3TodbhUSzr7nnd/4QT3PrN650w54Ml3rUb3DjqlJ5qm7mhjuR0jhmhpdKP+PocxZmNDEV0hhUzi+zN+UBO17KSEj0oNlu/RdTcR4XfzuvxVhtDABtiW1bMSGC66rCAQNjWYtmsDczx+pkuKUvL+YnyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fsxr7bEV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27B4EC2BCB0;
	Tue, 21 Apr 2026 18:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776795737;
	bh=O5WgHK1O2a4ZHa0YNwooCsspiEuk/YMVn/2JzgC4fIA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fsxr7bEV+U0q5v58qilLdHWc/3DpuGx9FE6f/4uLDc9p4/mAq0teVAcB9fb/l4DCH
	 PMoaKi+fyDzJtwN09wI03/nVdiw0sjncVkemvoTg2JP5lUxLg3B/Ybpz9ulOa+HZ3L
	 S0Bj2MdOzRHxPZFa2QPVpsLj860/u4Lep45vyl3qlULwLEbCbhpSkp85Ln/H0o0iTk
	 u3tilgVwi2VHCLzsCMy3r4sShfJ3+16zMc0tKOlNtXS57Ce7JOvoTErvgLCt8VXugH
	 wk5YU7d+6BPbmVzFVNwbolCttNL8LcDvDYhQeuA80WxC18hBe5cX/WYOYzrT+bTJmc
	 GPWocROKRtGSA==
Date: Tue, 21 Apr 2026 08:22:16 -1000
From: Tejun Heo <tj@kernel.org>
To: Sonam Sanju <sonam.sanju@intel.com>
Cc: vineeth@bitbyteword.org, dmaluka@chromium.org, kunwu.chan@linux.dev,
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
	paulmck@kernel.org, pbonzini@redhat.com, rcu@vger.kernel.org,
	seanjc@google.com, stable@vger.kernel.org
Subject: Re: [PATCH v2] KVM: eventfd: Use WQ_UNBOUND workqueue for irqfd
 cleanup - New logs confirm preemption race
Message-ID: <aefAWGcAQHeRYbs8@slm.duckdns.org>
References: <CAO7JXPjEtnsk9xer+_uSPQi9DBqCe0cSnfB=ePaKntoKv=N3tQ@mail.gmail.com>
 <20260421165455.2486211-1-sonam.sanju@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421165455.2486211-1-sonam.sanju@intel.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-240225-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,slm.duckdns.org:mid]
X-Rspamd-Queue-Id: 3A2F443EA7D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello, Sonam.

On Tue, Apr 21, 2026 at 10:24:55PM +0530, Sonam Sanju wrote:
> 3. The first stuck worker (kworker/2:0, PID 33) shows the preemption
>    in wq_worker_sleeping:
> 
>    kworker/2:0  state:D  Workqueue: kvm-irqfd-cleanup irqfd_shutdown
>      __schedule+0x87a/0xd60
>      preempt_schedule_irq+0x4a/0x90
>      asm_fred_entrypoint_kernel+0x41/0x70
>      ___ratelimit+0x1a1/0x1f0            <-- inside pr_info_ratelimited
>      wq_worker_sleeping+0x53/0x190       <-- preempted HERE
>      schedule+0x30/0xe0
>      schedule_preempt_disabled+0x10/0x20
>      __mutex_lock+0x413/0xe40
>      irqfd_resampler_shutdown+0x53/0x200
>      irqfd_shutdown+0xfa/0x190
> 
>    This confirms the exact race: a reschedule IPI interrupted
>    wq_worker_sleeping() after worker->sleeping was set to 1 but
>    before pool->nr_running was decremented. The preemption triggered
>    wq_worker_running() which incremented nr_running (1->2), then
>    on resume the decrement brought it back to 1 instead of 0.

The problem with this theory is that this kworker, while preempted, is still
runnable and should be dispatched to its CPU once it becomes available
again. Workqueue doesn't care whether the task gets preempted or when it
gets the CPU back. It only cares about whether the task enters blocking
state (!runnable). A task which is preempted, even on the way to blocking,
still is runnable and should get put back on the CPU by the scheduler.

If you can take a crashdump of the deadlocked state, can you see whether the
task is still on the scheduler's runqueue?

[Diagnostic notes below are AI-generated - apply judgment.]

The decisive field is `task->on_rq`:

  - 0: dequeued, truly blocked - your theory requires this. Then look at
    `task->sched_contributes_to_load` (set by block_task), and if
    CONFIG_SCHED_PROXY_EXEC is on, `task->blocked_on` and
    find_proxy_task() behavior.
  - 1: still queued - scheduler should pick it and self-heal the drift,
    so the "never woken up" step doesn't hold. Then the question becomes
    why EEVDF is not picking a queued task. Check `se->sched_delayed`
    first (DELAY_DEQUEUE leaves on_rq=1 but unrunnable until next pick),
    then cfs_rq throttling up the task_group hierarchy, then the rb-tree
    contents (vruntime/deadline/vlag of the stuck se vs others).

One snippet covering both branches, for each hung worker and for the
affected CPU's rq:

  from drgn.helpers.linux.sched import task_cpu
  from drgn.helpers.linux.list import list_for_each_entry

  t = find_task(prog, PID)
  cpu = task_cpu(t)
  rq = per_cpu(prog["runqueues"], cpu)
  cfs = rq.cfs

  print(f"state={hex(t.__state)} on_rq={int(t.on_rq)} "
        f"se.on_rq={int(t.se.on_rq)} sched_delayed={int(t.se.sched_delayed)} "
        f"cpu={cpu} on_cpu={int(t.on_cpu)}")
  print(f"vruntime={int(t.se.vruntime)} deadline={int(t.se.deadline)} "
        f"vlag={int(t.se.vlag)}")
  if hasattr(t, "blocked_on"):
      print(f"blocked_on={t.blocked_on}")

  print(f"rq.curr={rq.curr.comm.string_().decode()} "
        f"nr_running={int(rq.nr_running)} "
        f"cfs.h_nr_queued={int(cfs.h_nr_queued)} "
        f"cfs.h_nr_delayed={int(cfs.h_nr_delayed)} "
        f"min_vruntime={int(cfs.min_vruntime)}")
  # Walk throttle hierarchy (needs CONFIG_FAIR_GROUP_SCHED)
  c = t.se.cfs_rq
  while c:
      print(f"  cfs_rq throttled={int(c.throttled)} "
            f"throttle_count={int(c.throttle_count)}")
      c = c.tg.parent.cfs_rq[cpu] if c.tg.parent else None

Thanks.

--
tejun

