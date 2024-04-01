Return-Path: <stable+bounces-34285-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D490C893EAF
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 18:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8959A282320
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 16:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB7C4596E;
	Mon,  1 Apr 2024 16:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PrcwtdE+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFAF51CA8F;
	Mon,  1 Apr 2024 16:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711987607; cv=none; b=Ug1YeTU24FsI1069SqO2HW0RW981vP+B5wJm9IbbYTdbDPzHWS8Zgfu9bGItr1cyPTKgRxWF0ow9pbLpYyT7/bU3tDqmcHRHScXIzDiHm+V2pYy5zozEgzEfEBV5IzZKfBvvDENPCisLmYYrWrN9YoESX9Tc2GSHVW7rktYvn3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711987607; c=relaxed/simple;
	bh=pDDa8LleV4ol8X7xnZl+xXMUJhSUezt7VKvNz1EoEmk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=up1W1ZNhJ+mK2aGKjUNP5std5pHqbs7/Y2y6mh1k4ncTtd/d0V8WWcrrbQuJOlaVzg3HBwfrojhShilR/CuOQ5BtfnS+MKROUe/MO6pY8cfYNOrmtLZx8tdvuWeVW/jHFjLsKlY2/U97uyQiWGeK/nxskPgDaAwZwg/EcUCclRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PrcwtdE+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3033C433C7;
	Mon,  1 Apr 2024 16:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711987606;
	bh=pDDa8LleV4ol8X7xnZl+xXMUJhSUezt7VKvNz1EoEmk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PrcwtdE+/c6PTRv9HS557yNjRbztMWY126nmV0wRfT0YUPNEUxyRApFad9mhj9ThC
	 pSPMoqRU0ijb1ShWiv5n+L7DxrfRfefK6MaI8aHazn/YQ5WM+Jw2Nkn7reC9zDTUnV
	 mu4lHuT3eIzkVz6E1wNKs1Hc3leUa785spetKPgE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chris Wilson <chris@chris-wilson.co.uk>,
	Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
	Mika Kuoppala <mika.kuoppala@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Andi Shyti <andi.shyti@linux.intel.com>
Subject: [PATCH 6.8 338/399] drm/i915/gt: Reset queue_priority_hint on parking
Date: Mon,  1 Apr 2024 17:45:04 +0200
Message-ID: <20240401152559.264088577@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401152549.131030308@linuxfoundation.org>
References: <20240401152549.131030308@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chris Wilson <chris@chris-wilson.co.uk>

commit 4a3859ea5240365d21f6053ee219bb240d520895 upstream.

Originally, with strict in order execution, we could complete execution
only when the queue was empty. Preempt-to-busy allows replacement of an
active request that may complete before the preemption is processed by
HW. If that happens, the request is retired from the queue, but the
queue_priority_hint remains set, preventing direct submission until
after the next CS interrupt is processed.

This preempt-to-busy race can be triggered by the heartbeat, which will
also act as the power-management barrier and upon completion allow us to
idle the HW. We may process the completion of the heartbeat, and begin
parking the engine before the CS event that restores the
queue_priority_hint, causing us to fail the assertion that it is MIN.

<3>[  166.210729] __engine_park:283 GEM_BUG_ON(engine->sched_engine->queue_priority_hint != (-((int)(~0U >> 1)) - 1))
<0>[  166.210781] Dumping ftrace buffer:
<0>[  166.210795] ---------------------------------
...
<0>[  167.302811] drm_fdin-1097      2..s1. 165741070us : trace_ports: 0000:00:02.0 rcs0: promote { ccid:20 1217:2 prio 0 }
<0>[  167.302861] drm_fdin-1097      2d.s2. 165741072us : execlists_submission_tasklet: 0000:00:02.0 rcs0: preempting last=1217:2, prio=0, hint=2147483646
<0>[  167.302928] drm_fdin-1097      2d.s2. 165741072us : __i915_request_unsubmit: 0000:00:02.0 rcs0: fence 1217:2, current 0
<0>[  167.302992] drm_fdin-1097      2d.s2. 165741073us : __i915_request_submit: 0000:00:02.0 rcs0: fence 3:4660, current 4659
<0>[  167.303044] drm_fdin-1097      2d.s1. 165741076us : execlists_submission_tasklet: 0000:00:02.0 rcs0: context:3 schedule-in, ccid:40
<0>[  167.303095] drm_fdin-1097      2d.s1. 165741077us : trace_ports: 0000:00:02.0 rcs0: submit { ccid:40 3:4660* prio 2147483646 }
<0>[  167.303159] kworker/-89       11..... 165741139us : i915_request_retire.part.0: 0000:00:02.0 rcs0: fence c90:2, current 2
<0>[  167.303208] kworker/-89       11..... 165741148us : __intel_context_do_unpin: 0000:00:02.0 rcs0: context:c90 unpin
<0>[  167.303272] kworker/-89       11..... 165741159us : i915_request_retire.part.0: 0000:00:02.0 rcs0: fence 1217:2, current 2
<0>[  167.303321] kworker/-89       11..... 165741166us : __intel_context_do_unpin: 0000:00:02.0 rcs0: context:1217 unpin
<0>[  167.303384] kworker/-89       11..... 165741170us : i915_request_retire.part.0: 0000:00:02.0 rcs0: fence 3:4660, current 4660
<0>[  167.303434] kworker/-89       11d..1. 165741172us : __intel_context_retire: 0000:00:02.0 rcs0: context:1216 retire runtime: { total:56028ns, avg:56028ns }
<0>[  167.303484] kworker/-89       11..... 165741198us : __engine_park: 0000:00:02.0 rcs0: parked
<0>[  167.303534]   <idle>-0         5d.H3. 165741207us : execlists_irq_handler: 0000:00:02.0 rcs0: semaphore yield: 00000040
<0>[  167.303583] kworker/-89       11..... 165741397us : __intel_context_retire: 0000:00:02.0 rcs0: context:1217 retire runtime: { total:325575ns, avg:0ns }
<0>[  167.303756] kworker/-89       11..... 165741777us : __intel_context_retire: 0000:00:02.0 rcs0: context:c90 retire runtime: { total:0ns, avg:0ns }
<0>[  167.303806] kworker/-89       11..... 165742017us : __engine_park: __engine_park:283 GEM_BUG_ON(engine->sched_engine->queue_priority_hint != (-((int)(~0U >> 1)) - 1))
<0>[  167.303811] ---------------------------------
<4>[  167.304722] ------------[ cut here ]------------
<2>[  167.304725] kernel BUG at drivers/gpu/drm/i915/gt/intel_engine_pm.c:283!
<4>[  167.304731] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
<4>[  167.304734] CPU: 11 PID: 89 Comm: kworker/11:1 Tainted: G        W          6.8.0-rc2-CI_DRM_14193-gc655e0fd2804+ #1
<4>[  167.304736] Hardware name: Intel Corporation Rocket Lake Client Platform/RocketLake S UDIMM 6L RVP, BIOS RKLSFWI1.R00.3173.A03.2204210138 04/21/2022
<4>[  167.304738] Workqueue: i915-unordered retire_work_handler [i915]
<4>[  167.304839] RIP: 0010:__engine_park+0x3fd/0x680 [i915]
<4>[  167.304937] Code: 00 48 c7 c2 b0 e5 86 a0 48 8d 3d 00 00 00 00 e8 79 48 d4 e0 bf 01 00 00 00 e8 ef 0a d4 e0 31 f6 bf 09 00 00 00 e8 03 49 c0 e0 <0f> 0b 0f 0b be 01 00 00 00 e8 f5 61 fd ff 31 c0 e9 34 fd ff ff 48
<4>[  167.304940] RSP: 0018:ffffc9000059fce0 EFLAGS: 00010246
<4>[  167.304942] RAX: 0000000000000200 RBX: 0000000000000000 RCX: 0000000000000006
<4>[  167.304944] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000009
<4>[  167.304946] RBP: ffff8881330ca1b0 R08: 0000000000000001 R09: 0000000000000001
<4>[  167.304947] R10: 0000000000000001 R11: 0000000000000001 R12: ffff8881330ca000
<4>[  167.304948] R13: ffff888110f02aa0 R14: ffff88812d1d0205 R15: ffff88811277d4f0
<4>[  167.304950] FS:  0000000000000000(0000) GS:ffff88844f780000(0000) knlGS:0000000000000000
<4>[  167.304952] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
<4>[  167.304953] CR2: 00007fc362200c40 CR3: 000000013306e003 CR4: 0000000000770ef0
<4>[  167.304955] PKRU: 55555554
<4>[  167.304957] Call Trace:
<4>[  167.304958]  <TASK>
<4>[  167.305573]  ____intel_wakeref_put_last+0x1d/0x80 [i915]
<4>[  167.305685]  i915_request_retire.part.0+0x34f/0x600 [i915]
<4>[  167.305800]  retire_requests+0x51/0x80 [i915]
<4>[  167.305892]  intel_gt_retire_requests_timeout+0x27f/0x700 [i915]
<4>[  167.305985]  process_scheduled_works+0x2db/0x530
<4>[  167.305990]  worker_thread+0x18c/0x350
<4>[  167.305993]  kthread+0xfe/0x130
<4>[  167.305997]  ret_from_fork+0x2c/0x50
<4>[  167.306001]  ret_from_fork_asm+0x1b/0x30
<4>[  167.306004]  </TASK>

It is necessary for the queue_priority_hint to be lower than the next
request submission upon waking up, as we rely on the hint to decide when
to kick the tasklet to submit that first request.

Fixes: 22b7a426bbe1 ("drm/i915/execlists: Preempt-to-busy")
Closes: https://gitlab.freedesktop.org/drm/intel/issues/10154
Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
Signed-off-by: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
Cc: Mika Kuoppala <mika.kuoppala@linux.intel.com>
Cc: <stable@vger.kernel.org> # v5.4+
Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
Signed-off-by: Andi Shyti <andi.shyti@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240318135906.716055-2-janusz.krzysztofik@linux.intel.com
(cherry picked from commit 98850e96cf811dc2d0a7d0af491caff9f5d49c1e)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/i915/gt/intel_engine_pm.c            |    3 ---
 drivers/gpu/drm/i915/gt/intel_execlists_submission.c |    3 +++
 2 files changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/gpu/drm/i915/gt/intel_engine_pm.c
+++ b/drivers/gpu/drm/i915/gt/intel_engine_pm.c
@@ -279,9 +279,6 @@ static int __engine_park(struct intel_wa
 	intel_engine_park_heartbeat(engine);
 	intel_breadcrumbs_park(engine->breadcrumbs);
 
-	/* Must be reset upon idling, or we may miss the busy wakeup. */
-	GEM_BUG_ON(engine->sched_engine->queue_priority_hint != INT_MIN);
-
 	if (engine->park)
 		engine->park(engine);
 
--- a/drivers/gpu/drm/i915/gt/intel_execlists_submission.c
+++ b/drivers/gpu/drm/i915/gt/intel_execlists_submission.c
@@ -3272,6 +3272,9 @@ static void execlists_park(struct intel_
 {
 	cancel_timer(&engine->execlists.timer);
 	cancel_timer(&engine->execlists.preempt);
+
+	/* Reset upon idling, or we may delay the busy wakeup. */
+	WRITE_ONCE(engine->sched_engine->queue_priority_hint, INT_MIN);
 }
 
 static void add_to_engine(struct i915_request *rq)



