Return-Path: <stable+bounces-233382-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aDwGFDTC02mqlgcAu9opvQ
	(envelope-from <stable+bounces-233382-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 06 Apr 2026 16:24:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E743A3F86
	for <lists+stable@lfdr.de>; Mon, 06 Apr 2026 16:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CF0443038CA0
	for <lists+stable@lfdr.de>; Mon,  6 Apr 2026 14:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB69386547;
	Mon,  6 Apr 2026 14:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VEr4Lfml"
X-Original-To: stable@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31343803E9;
	Mon,  6 Apr 2026 14:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775485273; cv=none; b=K4Chpo5IGLoIMaQkw5hWeCNjAgoWMupQpeghZiOPhVXuMAv22FCmPJaVYcF67ASL/8Bq36ECmJZRSE9TxU/Uvza+lqM60fJ/yS5DKb/l/4FvQwjkXe6aGMLcOIIjb5AkBj+SVzVp58DaYa76W8DpJjMWpsFYbEiP0NPS7vxzzPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775485273; c=relaxed/simple;
	bh=NlPY1wmoPDuqLyfrc221Y74GT+l5hGPZx3VoBnKHRIs=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=XUnsUJZGvpHMrTAoobc+q0b4HXtkVeITIj8OLSVX7DfuXd72fTIRpY4BWKZtFa4atoDcc+nrbii+K8TMwv6/1CnoN58kj+VhA9mZlBt2Itmfzdp8XtpTW3gGSYZn32+nfNTxH9lZIDQScxhSfKMrF6beB/hih/YJWV3mmYizkcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VEr4Lfml; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775485258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ufb+OfzZx201xbCL46vcsGz1STGMVK6+6YxNEx4s/o8=;
	b=VEr4LfmlWLJGB+HAjT454gCj+fsy9nWNIP8caTukTcS7k8lwrp5OnZlMEJki9wFB9BhUr3
	n/9eiCvIswjDqIeEAQVFNKx7JF2Hyl7vQv9rAz7emqDMeJzFHeYZicqtSAmAlHtM08a+lJ
	bsf1Uij37QnQFukoppcEt79nUgC1hqY=
Date: Mon, 06 Apr 2026 14:20:56 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Kunwu Chan" <kunwu.chan@linux.dev>
Message-ID: <87add1dc9bb95dc50bc20ce5c8fbfe2999185dd3@linux.dev>
TLS-Required: No
Subject: Re: [PATCH v2] KVM: irqfd: fix deadlock by moving synchronize_srcu 
 out of resampler_lock
To: "Sonam Sanju" <sonam.sanju@intel.corp-partner.google.com>, "Sean 
 Christopherson" <seanjc@google.com>, "Paul E . McKenney"
 <paulmck@kernel.org>
Cc: "Paolo Bonzini" <pbonzini@redhat.com>, "Vineeth Pillai"
 <vineeth@bitbyteword.org>, "Dmitry Maluka" <dmaluka@chromium.org>,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, rcu@vger.kernel.org, "Sonam Sanju"
 <sonam.sanju@intel.com>
In-Reply-To: <20260401142456.2632730-1-sonam.sanju@intel.corp-partner.google.com>
References: <5194cf52-f8a8-4479-a95e-233104272839@linux.dev>
 <20260401142456.2632730-1-sonam.sanju@intel.corp-partner.google.com>
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233382-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[linux.dev:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kunwu.chan@linux.dev,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E1E743A3F86
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

April 1, 2026 at 10:24 PM, "Sonam Sanju" <sonam.sanju@intel.corp-partner.=
google.com mailto:sonam.sanju@intel.corp-partner.google.com?to=3D%22Sonam=
%20Sanju%22%20%3Csonam.sanju%40intel.corp-partner.google.com%3E > wrote:


>=20
>=20From: Sonam Sanju <sonam.sanju@intel.com>
>=20
>=20On Wed, Apr 01, 2026 at 05:34:58PM +0800, Kunwu Chan wrote:
>=20
>=20>=20
>=20> Building on the discussion so far, it would be helpful from the SRC=
U
> >  side to gather a bit more evidence to classify the issue.
> >=20
>=20>  Calling synchronize_srcu_expedited() while holding a mutex is gene=
rally
> >  valid, so the observed behavior may be workload-dependent.
> >=20
>=20>  The reported deadlock seems to rely on the assumption that SRCU gr=
ace
> >  period progress is indirectly blocked by irqfd workqueue saturation.
> >  It would be good to confirm whether that assumption actually holds.
> >=20
>=20I went back through our logs from two independent crash instances and
> can now provide data for each of your questions.
>=20
>=20>=20
>=20> 1) Are SRCU GP kthreads/workers still making forward progress when
> >  the system is stuck?
> >=20
>=20No. In both crash instances, process_srcu work items remain permanent=
ly
> "pending" (never "in-flight") throughout the entire hang.
>=20
>=20Instance 1 =E2=80=94 kernel 6.18.8, pool 14 (cpus=3D3):
>=20
>=20 [ 62.712760] workqueue rcu_gp: flags=3D0x108
>  [ 62.717801] pwq 14: cpus=3D3 node=3D0 flags=3D0x0 nice=3D0 active=3D2=
 refcnt=3D3
>  [ 62.717801] pending: 2*process_srcu
>=20
>=20 [ 187.735092] workqueue rcu_gp: flags=3D0x108 (125 seconds later)
>  [ 187.735093] pwq 14: cpus=3D3 node=3D0 flags=3D0x0 nice=3D0 active=3D=
2 refcnt=3D3
>  [ 187.735093] pending: 2*process_srcu (still pending)
>=20
>=20 9 consecutive dumps from t=3D62s to t=3D312s =E2=80=94 process_srcu =
never runs.
>=20
>=20Instance 2 =E2=80=94 kernel 6.18.2, pool 22 (cpus=3D5):
>=20
>=20 [ 93.280711] workqueue rcu_gp: flags=3D0x108
>  [ 93.280713] pwq 22: cpus=3D5 node=3D0 flags=3D0x0 nice=3D0 active=3D1=
 refcnt=3D2
>  [ 93.280716] pending: process_srcu
>=20
>=20 [ 309.040801] workqueue rcu_gp: flags=3D0x108 (216 seconds later)
>  [ 309.040806] pwq 22: cpus=3D5 node=3D0 flags=3D0x0 nice=3D0 active=3D=
1 refcnt=3D2
>  [ 309.040806] pending: process_srcu (still pending)
>=20
>=20 8 consecutive dumps from t=3D93s to t=3D341s =E2=80=94 process_srcu =
never runs.
>=20
>=20In both cases, rcu_gp's process_srcu is bound to the SAME per-CPU poo=
l
> where the kvm-irqfd-cleanup workers are blocked. Both pools have idle
> workers but are marked as hung/stalled:
>=20
>=20 Instance 1: pool 14: cpus=3D3 hung=3D174s workers=3D11 idle: 4046 40=
38 4045 4039 4043 156 77 (7 idle)
>  Instance 2: pool 22: cpus=3D5 hung=3D297s workers=3D12 idle: 4242 51 4=
248 4247 4245 435 4244 4239 (8 idle)
>=20
>=20>=20
>=20> 2) How many irqfd workers are active in the reported scenario, and
> >  can they saturate CPU or worker pools?
> >=20
>=204 kvm-irqfd-cleanup workers in both instances, consistently across al=
l
> dumps:
>=20
>=20Instance 1 ( pool 14 / cpus=3D3):
>=20
>=20 [ 62.831877] workqueue kvm-irqfd-cleanup: flags=3D0x0
>  [ 62.837838] pwq 14: cpus=3D3 node=3D0 flags=3D0x0 nice=3D0 active=3D4=
 refcnt=3D5
>  [ 62.837838] in-flight: 157:irqfd_shutdown ,4044:irqfd_shutdown ,
>  102:irqfd_shutdown ,39:irqfd_shutdown
>=20
>=20Instance 2 ( pool 22 / cpus=3D5):
>=20
>=20 [ 93.280894] workqueue kvm-irqfd-cleanup: flags=3D0x0
>  [ 93.280896] pwq 22: cpus=3D5 node=3D0 flags=3D0x0 nice=3D0 active=3D4=
 refcnt=3D5
>  [ 93.280900] in-flight: 151:irqfd_shutdown ,4246:irqfd_shutdown ,
>  4241:irqfd_shutdown ,4243:irqfd_shutdown
>=20
>=20These are from crosvm instances with multiple virtio devices
> (virtio-blk, virtio-net, virtio-input, etc.), each registering an irqfd
> with a resampler. During VM shutdown, all irqfds are detached
> concurrently, queueing that many irqfd_shutdown work items.
>=20
>=20The 4 workers are not saturating CPU =E2=80=94 they're all in D state=
. But they
> ARE all bound to the same per-CPU pool as rcu_gp's process_srcu work.
>=20
>=20>=20
>=20> 3) Do we have a concrete wait-for cycle showing that tasks blocked
> >  on resampler_lock are in turn preventing SRCU GP completion?
> >=20
>=20Yes, in both instances the hung task dump identifies the mutex holder
> stuck in synchronize_srcu, with the other workers waiting on the mutex.
>=20
>=20Instance 1 (t=3D314s):
>=20
>=20 Worker pid 4044 =E2=80=94 MUTEX HOLDER, stuck in synchronize_srcu:
>=20
>=20 [ 315.963979] task:kworker/3:8 state:D pid:4044
>  [ 315.977125] Workqueue: kvm-irqfd-cleanup irqfd_shutdown
>  [ 316.012504] __synchronize_srcu+0x100/0x130
>  [ 316.023157] irqfd_resampler_shutdown+0xf0/0x150 <-- offset 0xf0 (syn=
chronize_srcu)
>=20
>=20 Workers pid 39, 102, 157 =E2=80=94 MUTEX WAITERS:
>=20
>=20 [ 314.793025] task:kworker/3:4 state:D pid:157
>  [ 314.837472] __mutex_lock+0x409/0xd90
>  [ 314.843100] irqfd_resampler_shutdown+0x23/0x150 <-- offset 0x23 (mut=
ex_lock)
>=20
>=20Instance 2 (t=3D343s):
>=20
>=20 Worker pid 4241 =E2=80=94 MUTEX HOLDER, stuck in synchronize_srcu:
>=20
>=20 [ 343.193294] task:kworker/5:4 state:D pid:4241
>  [ 343.193299] Workqueue: kvm-irqfd-cleanup irqfd_shutdown
>  [ 343.193328] __synchronize_srcu+0x100/0x130
>  [ 343.193335] irqfd_resampler_shutdown+0xf0/0x150 <-- offset 0xf0 (syn=
chronize_srcu)
>=20
>=20 Workers pid 151, 4243, 4246 =E2=80=94 MUTEX WAITERS:
>=20
>=20 [ 343.193369] task:kworker/5:6 state:D pid:4243
>  [ 343.193397] __mutex_lock+0x37d/0xbb0
>  [ 343.193397] irqfd_resampler_shutdown+0x23/0x150 <-- offset 0x23 (mut=
ex_lock)
>=20
>=20Both instances show the identical wait-for cycle:
>=20
>=20 1. One worker holds resampler_lock, blocks in __synchronize_srcu
>  (waiting for SRCU grace period)
>  2. SRCU GP needs process_srcu to run =E2=80=94 but it stays "pending"
>  on the same pool
>  3. Other irqfd workers block on __mutex_lock in the same pool
>  4. The pool is marked "hung" and no pending work makes progress
>  for 250-300 seconds until kernel panic
>=20
>=20>=20
>=20> 4) Is the behavior reproducible in both irqfd_resampler_shutdown()
> >  and kvm_irqfd_assign() paths?
> >=20
>=20In our 4 crash instances the stuck mutex holder is always in=20
>=20irqfd_resampler_shutdown() at offset 0xf0 (synchronize_srcu). This=20
>=20is consistent =E2=80=94 these are all VM shutdown scenarios where onl=
y=20
>=20irqfd_shutdown workqueue items run.
>=20
>=20The kvm_irqfd_assign() path was identified by Vineeth Pillai (Google)
> during a VM create/destroy stress test where assign and shutdown race.
> His traces showed kvm_irqfd (the assign path) stuck in
> synchronize_srcu_expedited with irqfd_resampler_shutdown blocked on
> the mutex, and workqueue pwq 46 at active=3D1024 refcnt=3D2062.
>=20
>=20>=20
>=20> If SRCU GP remains independent, it would help distinguish whether
> >  this is a strict deadlock or a form of workqueue starvation / lock
> >  contention.
> >=20
>=20Based on the data from both instances, SRCU GP is NOT remaining
> independent. process_srcu stays permanently pending on the affected
> per-CPU pool for 250-300 seconds. But it's not just process_srcu =E2=80=
=94
> ALL pending work on the pool is stuck, including items from events,
> cgroup, mm, slub, and other workqueues.
>=20
>=20>=20
>=20> A timestamp-correlated dump (blocked stacks + workqueue state +
> >  SRCU GP activity) would likely be sufficient to classify this.
> >=20
>=20I hope the correlated dumps above from both instances are helpful.
> To summarize the timeline (consistent across both):
>=20
>=20 t=3D0: VM shutdown begins, crosvm detaches irqfds
>  t=3D~14: 4 irqfd_shutdown work items queued on WQ_PERCPU pool
>  One worker acquires resampler_lock, enters synchronize_srcu
>  Other 3 workers block on __mutex_lock
>  t=3D~43: First "BUG: workqueue lockup" =E2=80=94 pool detected stuck
>  rcu_gp: process_srcu shown as "pending" on same pool
>  t=3D~93 Through t=3D~312: Repeated dumps every ~30s
>  process_srcu remains permanently "pending"
>  Pool has idle workers but no pending work executes
>  t=3D~314: Hung task dump confirms mutex holder in __synchronize_srcu
>  t=3D~316: init triggers sysrq crash =E2=86=92 kernel panic
>=20

Thanks,=20this is useful and much clearer.

One thing that is still unclear is dispatch behavior:
`process_srcu` stays pending for a long time, while the same pwq dump sho=
ws idle workers.

So the key question is: what prevents pending work from being dispatched =
on that pwq?
Is it=20due to:
  1) pwq stalled/hung state,
  2) worker availability/affinity constraints,
  3) or another dispatch-side condition?

Also, for scope:
- your crash instances consistently show the shutdown path
  (irqfd_resampler_shutdown + synchronize_srcu),
- while assign-path evidence, per current thread data, appears to come
  from a separate stress case.

A time-aligned dump with pwq state, pending/in-flight lists, and worker s=
tates
should help clarify this.


> >=20
>=20> Happy to help look at traces if available.
> >=20
>=20I can share the full console-ramoops-0 and dmesg-ramoops-0 from both
> instances. Shall I post them or send them off-list?
>=20

If=20possible, please post sanitized ramoops/dmesg logs on-list so others=
 can validate.

Thanx, Kunwu

> Thanks,
> Sonam
>

