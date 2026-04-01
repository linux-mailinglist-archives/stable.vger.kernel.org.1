Return-Path: <stable+bounces-232798-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4BggHscvzWn7aQYAu9opvQ
	(envelope-from <stable+bounces-232798-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 16:46:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0126237C646
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 16:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C31983005321
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 14:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3CF2C0296;
	Wed,  1 Apr 2026 14:29:40 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8235B29D26E;
	Wed,  1 Apr 2026 14:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775053779; cv=none; b=jf2kFzqOToQwlIL95J9jYDuCaWW+vFfnZDn/U3VX3qQM+MvNKZcR/pfn52Tew2v4zki2Hj7+8Go2dftEO1Nn8ZGaF7NFaypN12XFXPqsb5vUIr5Q2y+wYfURKoLrGmOL6vs8ocHac91w+eMU7095VMKhmX6SmflijnhRU8opZRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775053779; c=relaxed/simple;
	bh=3/3MQ55BfCKTaGGmIrRLvZ5lLCm8E5GPtRS2WYBLfrU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LNMA5KRAY+bl2AFMRmx9UPf4IdZbeEWblAbt4AXZou2OuEqfJS9RaGYJX7ImaQmtgmvcUwY2t0rMyUB0BVEkENE1Z3WL2BVn+nZo/BKKNWxeGQts+vlY7BrKf9LqT1DWQAIwXo2gXkTlNZUNakwcgE/+gs9K2HlqGy2vFhxLEUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=intel.corp-partner.google.com; spf=fail smtp.mailfrom=intel.corp-partner.google.com; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=intel.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=intel.corp-partner.google.com
X-CSE-ConnectionGUID: 3uspcelDRmCuJLhH/D2D+w==
X-CSE-MsgGUID: b5g7+IaFSNK7CHiJ9N6vQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="78685773"
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="78685773"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 07:29:38 -0700
X-CSE-ConnectionGUID: RcdIXJ1OS1u8USRxDz97Ug==
X-CSE-MsgGUID: WaD6vHBZSwu4ZU5c6BLq3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="225675775"
Received: from intel-fishhawkfalls.iind.intel.com ([10.99.116.107])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 07:29:34 -0700
From: Sonam Sanju <sonam.sanju@intel.corp-partner.google.com>
To: Kunwu Chan <kunwu.chan@linux.dev>,
	Sean Christopherson <seanjc@google.com>,
	"Paul E . McKenney" <paulmck@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Vineeth Pillai <vineeth@bitbyteword.org>,
	Dmitry Maluka <dmaluka@chromium.org>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	rcu@vger.kernel.org,
	Sonam Sanju <sonam.sanju@intel.com>
Subject: Re: [PATCH v2] KVM: irqfd: fix deadlock by moving synchronize_srcu out of resampler_lock
Date: Wed,  1 Apr 2026 19:54:56 +0530
Message-Id: <20260401142456.2632730-1-sonam.sanju@intel.corp-partner.google.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <5194cf52-f8a8-4479-a95e-233104272839@linux.dev>
References: <5194cf52-f8a8-4479-a95e-233104272839@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [2.04 / 15.00];
	DMARC_POLICY_REJECT(2.00)[google.com : SPF not aligned (relaxed), No valid DKIM,reject];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-232798-lists,stable=lfdr.de];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sonam.sanju@intel.corp-partner.google.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.corp-partner.google.com:mid]
X-Rspamd-Queue-Id: 0126237C646
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sonam Sanju <sonam.sanju@intel.com>=0D

On Wed, Apr 01, 2026 at 05:34:58PM +0800, Kunwu Chan wrote:=0D
> Building on the discussion so far, it would be helpful from the SRCU=0D
> side to gather a bit more evidence to classify the issue.=0D
>=0D
> Calling synchronize_srcu_expedited() while holding a mutex is generally=0D
> valid, so the observed behavior may be workload-dependent.=0D
=0D
> The reported deadlock seems to rely on the assumption that SRCU grace=0D
> period progress is indirectly blocked by irqfd workqueue saturation.=0D
> It would be good to confirm whether that assumption actually holds.=0D
=0D
I went back through our logs from two independent crash instances and=0D
can now provide data for each of your questions.=0D
=0D
> 1) Are SRCU GP kthreads/workers still making forward progress when=0D
> the system is stuck?=0D
=0D
No.  In both crash instances, process_srcu work items remain permanently=0D
"pending" (never "in-flight") throughout the entire hang.=0D
=0D
Instance 1 =E2=80=94  kernel 6.18.8, pool 14 (cpus=3D3):=0D
=0D
  [  62.712760] workqueue rcu_gp: flags=3D0x108=0D
  [  62.717801]   pwq 14: cpus=3D3 node=3D0 flags=3D0x0 nice=3D0 active=3D2=
 refcnt=3D3=0D
  [  62.717801]     pending: 2*process_srcu=0D
=0D
  [  187.735092] workqueue rcu_gp: flags=3D0x108           (125 seconds lat=
er)=0D
  [  187.735093]   pwq 14: cpus=3D3 node=3D0 flags=3D0x0 nice=3D0 active=3D=
2 refcnt=3D3=0D
  [  187.735093]     pending: 2*process_srcu              (still pending)=0D
=0D
  9 consecutive dumps from t=3D62s to t=3D312s =E2=80=94 process_srcu never=
 runs.=0D
=0D
Instance 2 =E2=80=94  kernel 6.18.2, pool 22 (cpus=3D5):=0D
=0D
  [  93.280711] workqueue rcu_gp: flags=3D0x108=0D
  [  93.280713]   pwq 22: cpus=3D5 node=3D0 flags=3D0x0 nice=3D0 active=3D1=
 refcnt=3D2=0D
  [  93.280716]     pending: process_srcu=0D
=0D
  [  309.040801] workqueue rcu_gp: flags=3D0x108           (216 seconds lat=
er)=0D
  [  309.040806]   pwq 22: cpus=3D5 node=3D0 flags=3D0x0 nice=3D0 active=3D=
1 refcnt=3D2=0D
  [  309.040806]     pending: process_srcu               (still pending)=0D
=0D
  8 consecutive dumps from t=3D93s to t=3D341s =E2=80=94 process_srcu never=
 runs.=0D
=0D
In both cases, rcu_gp's process_srcu is bound to the SAME per-CPU pool=0D
where the kvm-irqfd-cleanup workers are blocked.  Both pools have idle=0D
workers but are marked as hung/stalled:=0D
=0D
  Instance 1: pool 14: cpus=3D3 hung=3D174s workers=3D11 idle: 4046 4038 40=
45 4039 4043 156 77 (7 idle)=0D
  Instance 2: pool 22: cpus=3D5 hung=3D297s workers=3D12 idle: 4242 51 4248=
 4247 4245 435 4244 4239 (8 idle)=0D
=0D
> 2) How many irqfd workers are active in the reported scenario, and=0D
> can they saturate CPU or worker pools?=0D
=0D
4 kvm-irqfd-cleanup workers in both instances, consistently across all=0D
dumps:=0D
=0D
Instance 1 ( pool 14 / cpus=3D3):=0D
=0D
  [  62.831877] workqueue kvm-irqfd-cleanup: flags=3D0x0=0D
  [  62.837838]   pwq 14: cpus=3D3 node=3D0 flags=3D0x0 nice=3D0 active=3D4=
 refcnt=3D5=0D
  [  62.837838]     in-flight: 157:irqfd_shutdown ,4044:irqfd_shutdown ,=0D
                               102:irqfd_shutdown ,39:irqfd_shutdown=0D
=0D
Instance 2 ( pool 22 / cpus=3D5):=0D
=0D
  [  93.280894] workqueue kvm-irqfd-cleanup: flags=3D0x0=0D
  [  93.280896]   pwq 22: cpus=3D5 node=3D0 flags=3D0x0 nice=3D0 active=3D4=
 refcnt=3D5=0D
  [  93.280900]     in-flight: 151:irqfd_shutdown ,4246:irqfd_shutdown ,=0D
                               4241:irqfd_shutdown ,4243:irqfd_shutdown=0D
=0D
These are from crosvm instances with multiple virtio devices=0D
(virtio-blk, virtio-net, virtio-input, etc.), each registering an irqfd=0D
with a resampler.  During VM shutdown, all irqfds are detached=0D
concurrently, queueing that many irqfd_shutdown work items.=0D
=0D
The 4 workers are not saturating CPU =E2=80=94 they're all in D state.  But=
 they=0D
ARE all bound to the same per-CPU pool as rcu_gp's process_srcu work.=0D
=0D
> 3) Do we have a concrete wait-for cycle showing that tasks blocked=0D
> on resampler_lock are in turn preventing SRCU GP completion?=0D
=0D
Yes, in both instances the hung task dump identifies the mutex holder=0D
stuck in synchronize_srcu, with the other workers waiting on the mutex.=0D
=0D
Instance 1 (t=3D314s):=0D
=0D
  Worker pid 4044 =E2=80=94 MUTEX HOLDER, stuck in synchronize_srcu:=0D
=0D
    [  315.963979] task:kworker/3:8     state:D  pid:4044=0D
    [  315.977125] Workqueue: kvm-irqfd-cleanup irqfd_shutdown=0D
    [  316.012504]  __synchronize_srcu+0x100/0x130=0D
    [  316.023157]  irqfd_resampler_shutdown+0xf0/0x150  <-- offset 0xf0 (s=
ynchronize_srcu)=0D
=0D
  Workers pid 39, 102, 157 =E2=80=94 MUTEX WAITERS:=0D
=0D
    [  314.793025] task:kworker/3:4     state:D  pid:157=0D
    [  314.837472]  __mutex_lock+0x409/0xd90=0D
    [  314.843100]  irqfd_resampler_shutdown+0x23/0x150  <-- offset 0x23 (m=
utex_lock)=0D
=0D
Instance 2 (t=3D343s):=0D
=0D
  Worker pid 4241 =E2=80=94 MUTEX HOLDER, stuck in synchronize_srcu:=0D
=0D
    [  343.193294] task:kworker/5:4     state:D  pid:4241=0D
    [  343.193299] Workqueue: kvm-irqfd-cleanup irqfd_shutdown=0D
    [  343.193328]  __synchronize_srcu+0x100/0x130=0D
    [  343.193335]  irqfd_resampler_shutdown+0xf0/0x150  <-- offset 0xf0 (s=
ynchronize_srcu)=0D
=0D
  Workers pid 151, 4243, 4246 =E2=80=94 MUTEX WAITERS:=0D
=0D
    [  343.193369] task:kworker/5:6     state:D  pid:4243=0D
    [  343.193397]  __mutex_lock+0x37d/0xbb0=0D
    [  343.193397]  irqfd_resampler_shutdown+0x23/0x150  <-- offset 0x23 (m=
utex_lock)=0D
=0D
Both instances show the identical wait-for cycle:=0D
=0D
  1. One worker holds resampler_lock, blocks in __synchronize_srcu=0D
     (waiting for SRCU grace period)=0D
  2. SRCU GP needs process_srcu to run =E2=80=94 but it stays "pending"=0D
     on the same pool=0D
  3. Other irqfd workers block on __mutex_lock in the same pool=0D
  4. The pool is marked "hung" and no pending work makes progress=0D
     for 250-300 seconds until kernel panic=0D
=0D
> 4) Is the behavior reproducible in both irqfd_resampler_shutdown()=0D
> and kvm_irqfd_assign() paths?=0D
=0D
In our 4 crash instances the stuck mutex holder is always in =0D
irqfd_resampler_shutdown() at offset 0xf0 (synchronize_srcu).  This =0D
is consistent =E2=80=94 these are all VM shutdown scenarios where only =0D
irqfd_shutdown workqueue items run.=0D
=0D
The kvm_irqfd_assign() path was identified by Vineeth Pillai (Google)=0D
during a VM create/destroy stress test where assign and shutdown race.=0D
His traces showed kvm_irqfd (the assign path) stuck in=0D
synchronize_srcu_expedited with irqfd_resampler_shutdown blocked on=0D
the mutex, and workqueue pwq 46 at active=3D1024 refcnt=3D2062.=0D
=0D
> If SRCU GP remains independent, it would help distinguish whether=0D
> this is a strict deadlock or a form of workqueue starvation / lock=0D
> contention.=0D
=0D
Based on the data from both instances, SRCU GP is NOT remaining=0D
independent.  process_srcu stays permanently pending on the affected=0D
per-CPU pool for 250-300 seconds.  But it's not just process_srcu =E2=80=94=
=0D
ALL pending work on the pool is stuck, including items from events,=0D
cgroup, mm, slub, and other workqueues.=0D
=0D
=0D
> A timestamp-correlated dump (blocked stacks + workqueue state +=0D
> SRCU GP activity) would likely be sufficient to classify this.=0D
=0D
I hope the correlated dumps above from both instances are helpful.=0D
To summarize the timeline (consistent across both):=0D
=0D
  t=3D0:   VM shutdown begins, crosvm detaches irqfds=0D
  t=3D~14: 4 irqfd_shutdown work items queued on WQ_PERCPU pool=0D
         One worker acquires resampler_lock, enters synchronize_srcu=0D
         Other 3 workers block on __mutex_lock=0D
  t=3D~43: First "BUG: workqueue lockup" =E2=80=94 pool detected stuck=0D
         rcu_gp: process_srcu shown as "pending" on same pool=0D
  t=3D~93  Through t=3D~312: Repeated dumps every ~30s=0D
         process_srcu remains permanently "pending"=0D
         Pool has idle workers but no pending work executes=0D
  t=3D~314: Hung task dump confirms mutex holder in __synchronize_srcu=0D
  t=3D~316: init triggers sysrq crash =E2=86=92 kernel panic=0D
=0D
> Happy to help look at traces if available.=0D
=0D
I can share the full console-ramoops-0 and dmesg-ramoops-0 from both=0D
instances.  Shall I post them or send them off-list?=0D
=0D
Thanks,=0D
Sonam=0D

