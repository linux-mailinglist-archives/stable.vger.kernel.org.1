Return-Path: <stable+bounces-62028-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 445A093E220
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 02:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEFB4281C7D
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 00:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C5581482E6;
	Sun, 28 Jul 2024 00:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fMLAKafd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4CD187879;
	Sun, 28 Jul 2024 00:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722127759; cv=none; b=MPuEZBKPZcIHJR+eXPA4H2apyNVL/rhKBdzKF0l0+Ds2rhmdpzItqgGUIF8UVQkQokmYAHwsE7o5vbthV5pt9/56yMseGQEkqcOCPZWvsVkzUCHXp3eKCunBRcUDvHI6BB99wq3+5h6J2FB0azWJdlZuM6rYdwTW517SPesK22M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722127759; c=relaxed/simple;
	bh=qC4erWRiD1NMLPLaumCrpwFp4Pal4xIw1Xf/7QCr1Gg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dD2hMAyU9Q8pfpvf77RR7FafcNPeNN+b0V2laLQD5HWiDDYhVya9SzlH6BkbVtYj4YaaOLX7whB5QRnEpfIr+CsYJT7yGuMW6zpmff0TLmrGwNsr2FGYbOL1Ngzxzd0y7Q26Y09/ZfD2nCr087XK+nFZp9erqnuMF1tPr3f+aBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fMLAKafd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCECEC4AF09;
	Sun, 28 Jul 2024 00:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722127758;
	bh=qC4erWRiD1NMLPLaumCrpwFp4Pal4xIw1Xf/7QCr1Gg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fMLAKafdjND44E2by6HVnMDWF5CA7sznFOKYSkqLLM9kyk6GU106VmUScoXLJoxs0
	 E1aqhyQ13iH+G1uWv+/HejSdoaBdSmD1EBICRCurAtc3NS2klEzH8I0ijdw1Crh+WR
	 BPecwrFwefRnH39rRX85ONvwNR2lvfmaR6Ns1ZFnrETe7mqMCXJtPT7o1/iuFXYmdf
	 Ewnt65PooTFPfTbuUncm2ePX3A5XTSoT2hiqR1MB9EZw/RZAdahi6t145SWfwE4gfJ
	 oWxk3x8IVwIg7g6senURUh2G4jPF1Q9vvlkMoO2b+f+jE7zTKt5kw4R8UKZYYeixzy
	 Y6QplH2FcxYng==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	tglx@linutronix.de
Subject: [PATCH AUTOSEL 5.4 3/3] clocksource/drivers/sh_cmt: Address race condition for clock events
Date: Sat, 27 Jul 2024 20:49:12 -0400
Message-ID: <20240728004913.1705252-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728004913.1705252-1-sashal@kernel.org>
References: <20240728004913.1705252-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.281
Content-Transfer-Encoding: 8bit

From: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

[ Upstream commit db19d3aa77612983a02bd223b3f273f896b243cf ]

There is a race condition in the CMT interrupt handler. In the interrupt
handler the driver sets a driver private flag, FLAG_IRQCONTEXT. This
flag is used to indicate any call to set_next_event() should not be
directly propagated to the device, but instead cached. This is done as
the interrupt handler itself reprograms the device when needed before it
completes and this avoids this operation to take place twice.

It is unclear why this design was chosen, my suspicion is to allow the
struct clock_event_device.event_handler callback, which is called while
the FLAG_IRQCONTEXT is set, can update the next event without having to
write to the device twice.

Unfortunately there is a race between when the FLAG_IRQCONTEXT flag is
set and later cleared where the interrupt handler have already started to
write the next event to the device. If set_next_event() is called in
this window the value is only cached in the driver but not written. This
leads to the board to misbehave, or worse lockup and produce a splat.

   rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
   rcu:     0-...!: (0 ticks this GP) idle=f5e0/0/0x0 softirq=519/519 fqs=0 (false positive?)
   rcu:     (detected by 1, t=6502 jiffies, g=-595, q=77 ncpus=2)
   Sending NMI from CPU 1 to CPUs 0:
   NMI backtrace for cpu 0
   CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.10.0-rc5-arm64-renesas-00019-g74a6f86eaf1c-dirty #20
   Hardware name: Renesas Salvator-X 2nd version board based on r8a77965 (DT)
   pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
   pc : tick_check_broadcast_expired+0xc/0x40
   lr : cpu_idle_poll.isra.0+0x8c/0x168
   sp : ffff800081c63d70
   x29: ffff800081c63d70 x28: 00000000580000c8 x27: 00000000bfee5610
   x26: 0000000000000027 x25: 0000000000000000 x24: 0000000000000000
   x23: ffff00007fbb9100 x22: ffff8000818f1008 x21: ffff8000800ef07c
   x20: ffff800081c79ec0 x19: ffff800081c70c28 x18: 0000000000000000
   x17: 0000000000000000 x16: 0000000000000000 x15: 0000ffffc2c717d8
   x14: 0000000000000000 x13: ffff000009c18080 x12: ffff8000825f7fc0
   x11: 0000000000000000 x10: ffff8000818f3cd4 x9 : 0000000000000028
   x8 : ffff800081c79ec0 x7 : ffff800081c73000 x6 : 0000000000000000
   x5 : 0000000000000000 x4 : ffff7ffffe286000 x3 : 0000000000000000
   x2 : ffff7ffffe286000 x1 : ffff800082972900 x0 : ffff8000818f1008
   Call trace:
    tick_check_broadcast_expired+0xc/0x40
    do_idle+0x9c/0x280
    cpu_startup_entry+0x34/0x40
    kernel_init+0x0/0x11c
    do_one_initcall+0x0/0x260
    __primary_switched+0x80/0x88
   rcu: rcu_preempt kthread timer wakeup didn't happen for 6501 jiffies! g-595 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402
   rcu:     Possible timer handling issue on cpu=0 timer-softirq=262
   rcu: rcu_preempt kthread starved for 6502 jiffies! g-595 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402 ->cpu=0
   rcu:     Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
   rcu: RCU grace-period kthread stack dump:
   task:rcu_preempt     state:I stack:0     pid:15    tgid:15    ppid:2      flags:0x00000008
   Call trace:
    __switch_to+0xbc/0x100
    __schedule+0x358/0xbe0
    schedule+0x48/0x148
    schedule_timeout+0xc4/0x138
    rcu_gp_fqs_loop+0x12c/0x764
    rcu_gp_kthread+0x208/0x298
    kthread+0x10c/0x110
    ret_from_fork+0x10/0x20

The design have been part of the driver since it was first merged in
early 2009. It becomes increasingly harder to trigger the issue the
older kernel version one tries. It only takes a few boots on v6.10-rc5,
while hundreds of boots are needed to trigger it on v5.10.

Close the race condition by using the CMT channel lock for the two
competing sections. The channel lock was added to the driver after its
initial design.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Link: https://lore.kernel.org/r/20240702190230.3825292-1-niklas.soderlund+renesas@ragnatech.se
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clocksource/sh_cmt.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/sh_cmt.c b/drivers/clocksource/sh_cmt.c
index b1ec79ddb7f2a..66789b3838d05 100644
--- a/drivers/clocksource/sh_cmt.c
+++ b/drivers/clocksource/sh_cmt.c
@@ -510,6 +510,7 @@ static void sh_cmt_set_next(struct sh_cmt_channel *ch, unsigned long delta)
 static irqreturn_t sh_cmt_interrupt(int irq, void *dev_id)
 {
 	struct sh_cmt_channel *ch = dev_id;
+	unsigned long flags;
 
 	/* clear flags */
 	sh_cmt_write_cmcsr(ch, sh_cmt_read_cmcsr(ch) &
@@ -540,6 +541,8 @@ static irqreturn_t sh_cmt_interrupt(int irq, void *dev_id)
 
 	ch->flags &= ~FLAG_SKIPEVENT;
 
+	raw_spin_lock_irqsave(&ch->lock, flags);
+
 	if (ch->flags & FLAG_REPROGRAM) {
 		ch->flags &= ~FLAG_REPROGRAM;
 		sh_cmt_clock_event_program_verify(ch, 1);
@@ -552,6 +555,8 @@ static irqreturn_t sh_cmt_interrupt(int irq, void *dev_id)
 
 	ch->flags &= ~FLAG_IRQCONTEXT;
 
+	raw_spin_unlock_irqrestore(&ch->lock, flags);
+
 	return IRQ_HANDLED;
 }
 
@@ -750,12 +755,18 @@ static int sh_cmt_clock_event_next(unsigned long delta,
 				   struct clock_event_device *ced)
 {
 	struct sh_cmt_channel *ch = ced_to_sh_cmt(ced);
+	unsigned long flags;
 
 	BUG_ON(!clockevent_state_oneshot(ced));
+
+	raw_spin_lock_irqsave(&ch->lock, flags);
+
 	if (likely(ch->flags & FLAG_IRQCONTEXT))
 		ch->next_match_value = delta - 1;
 	else
-		sh_cmt_set_next(ch, delta - 1);
+		__sh_cmt_set_next(ch, delta - 1);
+
+	raw_spin_unlock_irqrestore(&ch->lock, flags);
 
 	return 0;
 }
-- 
2.43.0


