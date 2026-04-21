Return-Path: <stable+bounces-240211-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mNtqF1Ot52kG/QEAu9opvQ
	(envelope-from <stable+bounces-240211-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 19:01:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0453843DB17
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 19:01:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 227CD3058CF4
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 16:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C23B37D127;
	Tue, 21 Apr 2026 16:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EK6LhhY7"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69453033E8;
	Tue, 21 Apr 2026 16:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776790783; cv=none; b=EEJkaYR4IrYXbeTXfv+BIge7jVt4yY7SohEy1fWa1GyCb8A4HVgto7RSMBCVKZx1zjinW/K5JywT4ch4r6/RGxR+tpJiC9iK9A41tTH/dQTFKP2o3SSngy+UNQ4ZoEqvWSWtUVd0aHaCbc5QYukvF+jxWI61AcasyBbW8ygYkMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776790783; c=relaxed/simple;
	bh=3xkW6Ke+o3NRCuvbOJKD2Ict0GZtRKo6boDp9ITB92A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OD7PqUkFm1zlO4TiI4ajisDWMT2V8YLzObuY9CHY0tBGu7CKqc1t0BEwRYzbT8MFXSa8CpjB6i+2otr2XeTa7qfR9URNmiP+qF79zMn41cN9zXSTfeiHnBa9fMwho+Kqp1VPGiLFpvaTlCJcQgdymQ9I9fiqz6/2p2t/iyEVwso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EK6LhhY7; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776790781; x=1808326781;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3xkW6Ke+o3NRCuvbOJKD2Ict0GZtRKo6boDp9ITB92A=;
  b=EK6LhhY7hTkxyRWHIhBr3e1lasbAQZ8Q5UYMSQBD4TgG2KYT7HmitHvq
   wFdfxysBU8vkYVVQYxYK3hETGSOZwT6Y0PRNIgv0fkTh1bOGqEtz/ssPQ
   5QwHx1HmmwRenTpX5YVF/ib9GA/ZiOrnDz9qVLaknC7lqh2w33+Eff00L
   sIqlUKjmGTtFVA4kHelJ1YXwziBMpZhuBBntSMGnTUotSV+gHpYcbg7H/
   2Gm361D3FlxXQk1xbkh2lp7XPzV8snSAqCdt/czS3/hvvCdVSlYMchr5o
   1fxFGLvAhcr3B0qtplqNmz6pPJvqQ/h6iGWBYylv8+htAlat0Hxx/MTXE
   w==;
X-CSE-ConnectionGUID: Q2FS00EWRzWRzC7iZzmFWA==
X-CSE-MsgGUID: ZJ4IwWNBS6y6QitvBjtMvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11763"; a="100390190"
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="100390190"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2026 09:59:41 -0700
X-CSE-ConnectionGUID: wsFiZVlKRuWOvyUD+jsfDA==
X-CSE-MsgGUID: GouIYHodTL6xOMN2QA0UHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="232003029"
Received: from intel-fishhawkfalls.iind.intel.com ([10.99.116.107])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2026 09:59:37 -0700
From: Sonam Sanju <sonam.sanju@intel.com>
To: vineeth@bitbyteword.org
Cc: dmaluka@chromium.org,
	kunwu.chan@linux.dev,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	paulmck@kernel.org,
	pbonzini@redhat.com,
	rcu@vger.kernel.org,
	seanjc@google.com,
	sonam.sanju@intel.com,
	stable@vger.kernel.org,
	tj@kernel.org
Subject: Re: [PATCH v2] KVM: eventfd: Use WQ_UNBOUND workqueue for irqfd cleanup - New logs confirm preemption race
Date: Tue, 21 Apr 2026 22:24:55 +0530
Message-Id: <20260421165455.2486211-1-sonam.sanju@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAO7JXPjEtnsk9xer+_uSPQi9DBqCe0cSnfB=ePaKntoKv=N3tQ@mail.gmail.com>
References: <CAO7JXPjEtnsk9xer+_uSPQi9DBqCe0cSnfB=ePaKntoKv=N3tQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-240211-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sonam.sanju@intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_TWELVE(0.00)[12];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0453843DB17
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Vineeth, Kunwu, Tejun,=0D
=0D
Collected new crash logs with additional debug instrumentation in=0D
wq_worker_sleeping(), kick_pool(), and show_one_worker_pool() to capture=0D
pool state during the hang. The results conclusively confirm Vineeth's=0D
preemption race theory.=0D
=0D
From the new logs:=0D
=0D
1. Pool dump with nr_running/nr_idle (added instrumentation):=0D
=0D
   pool 10: cpus=3D2 flags=3D0x0 hung=3D201s workers=3D11 nr_running=3D1 nr=
_idle=3D5=0D
=0D
   11 workers, 5 idle, 6 in D-state (all irqfd_shutdown) -- yet=0D
   nr_running=3D1. No worker is actually running on CPU 2.=0D
=0D
2. NMI backtrace confirms CPU 2 is completely idle:=0D
=0D
   NMI backtrace for cpu 2 skipped: idling at intel_idle+0x57/0xa0=0D
=0D
   So nr_running=3D1 is a phantom count -- no worker is running, but=0D
   the pool thinks one is.=0D
=0D
3. The first stuck worker (kworker/2:0, PID 33) shows the preemption=0D
   in wq_worker_sleeping:=0D
=0D
   kworker/2:0  state:D  Workqueue: kvm-irqfd-cleanup irqfd_shutdown=0D
     __schedule+0x87a/0xd60=0D
     preempt_schedule_irq+0x4a/0x90=0D
     asm_fred_entrypoint_kernel+0x41/0x70=0D
     ___ratelimit+0x1a1/0x1f0            <-- inside pr_info_ratelimited=0D
     wq_worker_sleeping+0x53/0x190       <-- preempted HERE=0D
     schedule+0x30/0xe0=0D
     schedule_preempt_disabled+0x10/0x20=0D
     __mutex_lock+0x413/0xe40=0D
     irqfd_resampler_shutdown+0x53/0x200=0D
     irqfd_shutdown+0xfa/0x190=0D
=0D
   This confirms the exact race: a reschedule IPI interrupted=0D
   wq_worker_sleeping() after worker->sleeping was set to 1 but=0D
   before pool->nr_running was decremented. The preemption triggered=0D
   wq_worker_running() which incremented nr_running (1->2), then=0D
   on resume the decrement brought it back to 1 instead of 0.=0D
=0D
4. The second pool dump 31 seconds later shows the stall is permanent:=0D
=0D
   pool 10: cpus=3D2 flags=3D0x0 hung=3D232s workers=3D11 nr_running=3D1 nr=
_idle=3D5=0D
=0D
   Same phantom nr_running=3D1, hung time growing.=0D
=0D
5. The deadlock chain:=0D
   - PID 33: holds resampler_lock mutex, stuck in wq_worker_sleeping=0D
   - PID 520: past mutex, stuck in synchronize_srcu_expedited=0D
   - PIDs 120, 4792, 4793, 4796: waiting on resampler_lock mutex=0D
   - crosvm_vcpu2: waiting in kvm_vm_release -> __flush_workqueue=0D
   - init (PID 1): stuck in pci_device_shutdown -> __flush_work=0D
   - Multiple userspace processes stuck in fsnotify_destroy_group=0D
   - Reboot thread timed out, system triggered sysrq crash=0D
=0D
6. kick_pool_skip debug print fired for other pools but NOT for=0D
   pool 10 -- because need_more_worker() was never true (nr_running=0D
   was never 0), so kick_pool() was never even called for this pool.=0D
=0D
Regarding a fix, we can consider a workqueue-level fix in =0D
wq_worker_sleeping() itself:=0D
=0D
  void wq_worker_sleeping(struct task_struct *task)=0D
  {=0D
      ...=0D
      if (READ_ONCE(worker->sleeping))=0D
          return;=0D
=0D
  +   preempt_disable();=0D
      WRITE_ONCE(worker->sleeping, 1);=0D
      raw_spin_lock_irq(&pool->lock);=0D
=0D
      if (worker->flags & WORKER_NOT_RUNNING) {=0D
          raw_spin_unlock_irq(&pool->lock);=0D
  +       preempt_enable();=0D
          return;=0D
      }=0D
=0D
      pool->nr_running--;=0D
      if (kick_pool(pool))=0D
          worker->current_pwq->stats[PWQ_STAT_CM_WAKEUP]++;=0D
=0D
      raw_spin_unlock_irq(&pool->lock);=0D
  +   preempt_enable();=0D
  }=0D
=0D
The idea is to disable preemption from sleeping=3D1 until we hold the pool=
=0D
lock (which disables IRQs). This prevents the reschedule IPI from=0D
triggering preempt_schedule_irq() in this window. Note that=0D
wq_worker_running() already uses preempt_disable/enable around its=0D
nr_running++ for a similar race against unbind_workers().=0D
=0D
Does this approach look correct to you?=0D
=0D
=0D
Thanks,=0D
Sonam=0D

