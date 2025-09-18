Return-Path: <stable+bounces-171306-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4222DB2A93A
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 16:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D53CA1B616AB
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 14:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7280E220F3F;
	Mon, 18 Aug 2025 13:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VU6TF7ZL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5D7346A16;
	Mon, 18 Aug 2025 13:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755525485; cv=none; b=lOQjh2wNBOmc8mdIYumv4o51xVz97f0nWj1T2zPnWr+YMtRn3lYsjC6tPsIBcoxTZU/Jf8ZFadQZy1DLTV8NNK3k8/CCJCE3KV3vJGBuCzsD3/vs1MS0GXNWrEXMSbpBbGXMtf1N48AAuVt5OTq0o+zPqBHfpwV2bOJusmhbBbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755525485; c=relaxed/simple;
	bh=nZMtMV8n0DsNTukHcvS5Jb/GYjMoLnp+KHnzQJKkKdg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dDX/mRJol0FobL4WkLbAJv5vgD7cadV6EcS0A8bcTD4a3fftHSPk7AHRSkBWYAl5xLHt8+acZlG3fTqzAfgbZvbM84ODzUVlV1XX8qSmXpqT40b5mS90qJD5hkYs8Yo/r45Gja+qoy+mqqQJg4Fp8URMH0Zda87jJ6Ma/TNAcsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VU6TF7ZL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A62CEC4CEEB;
	Mon, 18 Aug 2025 13:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755525485;
	bh=nZMtMV8n0DsNTukHcvS5Jb/GYjMoLnp+KHnzQJKkKdg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VU6TF7ZLe9lZ5dGcd1woLo3uL2bkYx/qENcO0FShD5GL0LHd+KpTsgZZjQgYH/hwN
	 DEO0COwC3xJAyyrfkRq/bKy2O5m43Lr9gW9G2ZVZA+K09wspZNTBwMbQOZ2oPvDIIQ
	 jbgswk0dk4XnF4yuQCadHmVJpsqyBk5N/Tx7PxJo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	"Neeraj Upadhyay (AMD)" <neeraj.upadhyay@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16 236/570] rcu: Protect ->defer_qs_iw_pending from data race
Date: Mon, 18 Aug 2025 14:43:43 +0200
Message-ID: <20250818124514.915946292@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818124505.781598737@linuxfoundation.org>
References: <20250818124505.781598737@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul E. McKenney <paulmck@kernel.org>

[ Upstream commit 90c09d57caeca94e6f3f87c49e96a91edd40cbfd ]

On kernels built with CONFIG_IRQ_WORK=y, when rcu_read_unlock() is
invoked within an interrupts-disabled region of code [1], it will invoke
rcu_read_unlock_special(), which uses an irq-work handler to force the
system to notice when the RCU read-side critical section actually ends.
That end won't happen until interrupts are enabled at the soonest.

In some kernels, such as those booted with rcutree.use_softirq=y, the
irq-work handler is used unconditionally.

The per-CPU rcu_data structure's ->defer_qs_iw_pending field is
updated by the irq-work handler and is both read and updated by
rcu_read_unlock_special().  This resulted in the following KCSAN splat:

------------------------------------------------------------------------

BUG: KCSAN: data-race in rcu_preempt_deferred_qs_handler / rcu_read_unlock_special

read to 0xffff96b95f42d8d8 of 1 bytes by task 90 on cpu 8:
 rcu_read_unlock_special+0x175/0x260
 __rcu_read_unlock+0x92/0xa0
 rt_spin_unlock+0x9b/0xc0
 __local_bh_enable+0x10d/0x170
 __local_bh_enable_ip+0xfb/0x150
 rcu_do_batch+0x595/0xc40
 rcu_cpu_kthread+0x4e9/0x830
 smpboot_thread_fn+0x24d/0x3b0
 kthread+0x3bd/0x410
 ret_from_fork+0x35/0x40
 ret_from_fork_asm+0x1a/0x30

write to 0xffff96b95f42d8d8 of 1 bytes by task 88 on cpu 8:
 rcu_preempt_deferred_qs_handler+0x1e/0x30
 irq_work_single+0xaf/0x160
 run_irq_workd+0x91/0xc0
 smpboot_thread_fn+0x24d/0x3b0
 kthread+0x3bd/0x410
 ret_from_fork+0x35/0x40
 ret_from_fork_asm+0x1a/0x30

no locks held by irq_work/8/88.
irq event stamp: 200272
hardirqs last  enabled at (200272): [<ffffffffb0f56121>] finish_task_switch+0x131/0x320
hardirqs last disabled at (200271): [<ffffffffb25c7859>] __schedule+0x129/0xd70
softirqs last  enabled at (0): [<ffffffffb0ee093f>] copy_process+0x4df/0x1cc0
softirqs last disabled at (0): [<0000000000000000>] 0x0

------------------------------------------------------------------------

The problem is that irq-work handlers run with interrupts enabled, which
means that rcu_preempt_deferred_qs_handler() could be interrupted,
and that interrupt handler might contain an RCU read-side critical
section, which might invoke rcu_read_unlock_special().  In the strict
KCSAN mode of operation used by RCU, this constitutes a data race on
the ->defer_qs_iw_pending field.

This commit therefore disables interrupts across the portion of the
rcu_preempt_deferred_qs_handler() that updates the ->defer_qs_iw_pending
field.  This suffices because this handler is not a fast path.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Neeraj Upadhyay (AMD) <neeraj.upadhyay@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/rcu/tree_plugin.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 0b0f56f6abc8..a91b2322a0cd 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -624,10 +624,13 @@ notrace void rcu_preempt_deferred_qs(struct task_struct *t)
  */
 static void rcu_preempt_deferred_qs_handler(struct irq_work *iwp)
 {
+	unsigned long flags;
 	struct rcu_data *rdp;
 
 	rdp = container_of(iwp, struct rcu_data, defer_qs_iw);
+	local_irq_save(flags);
 	rdp->defer_qs_iw_pending = false;
+	local_irq_restore(flags);
 }
 
 /*
-- 
2.39.5




