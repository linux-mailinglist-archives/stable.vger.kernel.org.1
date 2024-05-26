Return-Path: <stable+bounces-46242-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 718548CF3BC
	for <lists+stable@lfdr.de>; Sun, 26 May 2024 11:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CD13280E44
	for <lists+stable@lfdr.de>; Sun, 26 May 2024 09:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC70A130ACC;
	Sun, 26 May 2024 09:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P9bsLlrM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788B5130AC0;
	Sun, 26 May 2024 09:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716716618; cv=none; b=g2l8zDuASiUAkhdeMGLBO5yh4fk5VN4GqLhxN7znrk5Cnmo0GaOPc94tZXQ429tSBTV/Ci5fxetUWXjsyulSa7BS8AoYGOBW6UyuwNBFAKqnfjtvXwcXoCBM5UqcTigWvlCnh6q1HQHqV4L001q7MIq3jod5xUs77aLYtP6mBNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716716618; c=relaxed/simple;
	bh=t5ZLNJkkwz5B5CVWRiBOqONyPsDgSfGCWMzmOr2H374=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gmv15ztcHVeLHEE1EvEWljpqz9Woq/113O3fVBmn7JXWaNLYC3EQFjEl4sZVcmKpKzujtnRq10TdXTrpHBXDdEQSW/Z0j47qXwXP/6gx1OjtD7l34lRwJW+onGFtssnqAKoNrbTOZrq148YFgNdOA9Y9dyHu+doAi2scO6kURHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P9bsLlrM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00323C2BD10;
	Sun, 26 May 2024 09:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716716618;
	bh=t5ZLNJkkwz5B5CVWRiBOqONyPsDgSfGCWMzmOr2H374=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P9bsLlrMlpfcLkHAm+dj8cs+RuZcicVO+tz8L2DjbXNNoL23Dr4dEgzmddC79Y+Hr
	 Gn/gGTu4aeWIyqimXlzQ35gmn8BGupp0FDErx6xsIN8eO+R1grSIOmXEVvZPxcgjaK
	 vdtJB9hgjzPMmXikVGpum2hcZF7FYllSN63YC8a4ZThN7Cki92pkKF3wU26huqRJcP
	 95R0JGnzj3xGf7UQQ6bIZ33tGSr/rr0U8mRMKMfGY4lfuq2HdZsUPytFm8Oo8CR24t
	 aMjkIrO/fuqdDdLEXfM1qPcnowLK+xgeFDCfU9Evuw3opG8aX2US/G3HpGuFvw4AzL
	 D2mcaCEiTi+bg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zqiang <qiang.zhang1211@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	dave@stgolabs.net,
	josh@joshtriplett.org,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joel@joelfernandes.org,
	boqun.feng@gmail.com,
	rcu@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 5/7] rcutorture: Fix invalid context warning when enable srcu barrier testing
Date: Sun, 26 May 2024 05:43:25 -0400
Message-ID: <20240526094329.3413652-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240526094329.3413652-1-sashal@kernel.org>
References: <20240526094329.3413652-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.159
Content-Transfer-Encoding: 8bit

From: Zqiang <qiang.zhang1211@gmail.com>

[ Upstream commit 668c0406d887467d53f8fe79261dda1d22d5b671 ]

When the torture_type is set srcu or srcud and cb_barrier is
non-zero, running the rcutorture test will trigger the
following warning:

[  163.910989][    C1] BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
[  163.910994][    C1] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 0, name: swapper/1
[  163.910999][    C1] preempt_count: 10001, expected: 0
[  163.911002][    C1] RCU nest depth: 0, expected: 0
[  163.911005][    C1] INFO: lockdep is turned off.
[  163.911007][    C1] irq event stamp: 30964
[  163.911010][    C1] hardirqs last  enabled at (30963): [<ffffffffabc7df52>] do_idle+0x362/0x500
[  163.911018][    C1] hardirqs last disabled at (30964): [<ffffffffae616eff>] sysvec_call_function_single+0xf/0xd0
[  163.911025][    C1] softirqs last  enabled at (0): [<ffffffffabb6475f>] copy_process+0x16ff/0x6580
[  163.911033][    C1] softirqs last disabled at (0): [<0000000000000000>] 0x0
[  163.911038][    C1] Preemption disabled at:
[  163.911039][    C1] [<ffffffffacf1964b>] stack_depot_save_flags+0x24b/0x6c0
[  163.911063][    C1] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G        W          6.8.0-rc4-rt4-yocto-preempt-rt+ #3 1e39aa9a737dd024a3275c4f835a872f673a7d3a
[  163.911071][    C1] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.2-0-gea1b7a073390-prebuilt.qemu.org 04/01/2014
[  163.911075][    C1] Call Trace:
[  163.911078][    C1]  <IRQ>
[  163.911080][    C1]  dump_stack_lvl+0x88/0xd0
[  163.911089][    C1]  dump_stack+0x10/0x20
[  163.911095][    C1]  __might_resched+0x36f/0x530
[  163.911105][    C1]  rt_spin_lock+0x82/0x1c0
[  163.911112][    C1]  spin_lock_irqsave_ssp_contention+0xb8/0x100
[  163.911121][    C1]  srcu_gp_start_if_needed+0x782/0xf00
[  163.911128][    C1]  ? _raw_spin_unlock_irqrestore+0x46/0x70
[  163.911136][    C1]  ? debug_object_active_state+0x336/0x470
[  163.911148][    C1]  ? __pfx_srcu_gp_start_if_needed+0x10/0x10
[  163.911156][    C1]  ? __pfx_lock_release+0x10/0x10
[  163.911165][    C1]  ? __pfx_rcu_torture_barrier_cbf+0x10/0x10
[  163.911188][    C1]  __call_srcu+0x9f/0xe0
[  163.911196][    C1]  call_srcu+0x13/0x20
[  163.911201][    C1]  srcu_torture_call+0x1b/0x30
[  163.911224][    C1]  rcu_torture_barrier1cb+0x4a/0x60
[  163.911247][    C1]  __flush_smp_call_function_queue+0x267/0xca0
[  163.911256][    C1]  ? __pfx_rcu_torture_barrier1cb+0x10/0x10
[  163.911281][    C1]  generic_smp_call_function_single_interrupt+0x13/0x20
[  163.911288][    C1]  __sysvec_call_function_single+0x7d/0x280
[  163.911295][    C1]  sysvec_call_function_single+0x93/0xd0
[  163.911302][    C1]  </IRQ>
[  163.911304][    C1]  <TASK>
[  163.911308][    C1]  asm_sysvec_call_function_single+0x1b/0x20
[  163.911313][    C1] RIP: 0010:default_idle+0x17/0x20
[  163.911326][    C1] RSP: 0018:ffff888001997dc8 EFLAGS: 00000246
[  163.911333][    C1] RAX: 0000000000000000 RBX: dffffc0000000000 RCX: ffffffffae618b51
[  163.911337][    C1] RDX: 0000000000000000 RSI: ffffffffaea80920 RDI: ffffffffaec2de80
[  163.911342][    C1] RBP: ffff888001997dc8 R08: 0000000000000001 R09: ffffed100d740cad
[  163.911346][    C1] R10: ffffed100d740cac R11: ffff88806ba06563 R12: 0000000000000001
[  163.911350][    C1] R13: ffffffffafe460c0 R14: ffffffffafe460c0 R15: 0000000000000000
[  163.911358][    C1]  ? ct_kernel_exit.constprop.3+0x121/0x160
[  163.911369][    C1]  ? lockdep_hardirqs_on+0xc4/0x150
[  163.911376][    C1]  arch_cpu_idle+0x9/0x10
[  163.911383][    C1]  default_idle_call+0x7a/0xb0
[  163.911390][    C1]  do_idle+0x362/0x500
[  163.911398][    C1]  ? __pfx_do_idle+0x10/0x10
[  163.911404][    C1]  ? complete_with_flags+0x8b/0xb0
[  163.911416][    C1]  cpu_startup_entry+0x58/0x70
[  163.911423][    C1]  start_secondary+0x221/0x280
[  163.911430][    C1]  ? __pfx_start_secondary+0x10/0x10
[  163.911440][    C1]  secondary_startup_64_no_verify+0x17f/0x18b
[  163.911455][    C1]  </TASK>

This commit therefore use smp_call_on_cpu() instead of
smp_call_function_single(), make rcu_torture_barrier1cb() invoked
happens on task-context.

Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/rcu/rcutorture.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index e9323cc5da73b..9d8d1f233d7bd 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -2533,11 +2533,12 @@ static void rcu_torture_barrier_cbf(struct rcu_head *rcu)
 }
 
 /* IPI handler to get callback posted on desired CPU, if online. */
-static void rcu_torture_barrier1cb(void *rcu_void)
+static int rcu_torture_barrier1cb(void *rcu_void)
 {
 	struct rcu_head *rhp = rcu_void;
 
 	cur_ops->call(rhp, rcu_torture_barrier_cbf);
+	return 0;
 }
 
 /* kthread function to register callbacks used to test RCU barriers. */
@@ -2563,11 +2564,9 @@ static int rcu_torture_barrier_cbs(void *arg)
 		 * The above smp_load_acquire() ensures barrier_phase load
 		 * is ordered before the following ->call().
 		 */
-		if (smp_call_function_single(myid, rcu_torture_barrier1cb,
-					     &rcu, 1)) {
-			// IPI failed, so use direct call from current CPU.
+		if (smp_call_on_cpu(myid, rcu_torture_barrier1cb, &rcu, 1))
 			cur_ops->call(&rcu, rcu_torture_barrier_cbf);
-		}
+
 		if (atomic_dec_and_test(&barrier_cbs_count))
 			wake_up(&barrier_wq);
 	} while (!torture_must_stop());
-- 
2.43.0


