Return-Path: <stable+bounces-143247-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4BBAB34EC
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 12:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DB3A17D9CA
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 10:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5F726158F;
	Mon, 12 May 2025 10:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TbZLeEk5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DAC25D1FA
	for <stable@vger.kernel.org>; Mon, 12 May 2025 10:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747045930; cv=none; b=CyUFcX0X1XNJ4D79dt1USj5cloxyW7F1td6j6AFApddqK104/a1zJ8nHkfp2/4A1Cwx60+8WUM1ImbpuRVmO/J9gOwYL0L+UZlfVl+e0+9VAk9AEFhR6Y+x8LA19TKgpoPIo3hEptlxUQis+ar9PXHuxyBfTD5LUTHIDW3p5Bvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747045930; c=relaxed/simple;
	bh=1iItMgJ8Pev70T619AhPKd0v8efysQ6AFbZP5spRW4g=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=UdFpALD0/+LGKf43VZVpHsvAw3LbEYC7l/MmD4Uy9g0PrAItx1ta9hmDsvtSnx7BnYTb2VbQrPJyfaIlInJ58LK+ImlJDf1p0MxvX9aNRn0HbFuobPqTgpmlDHZp3BKtkfgWzzZh1aA3xFc9NwZ46QsAJ/t7Cy1qsptPTopIVRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TbZLeEk5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EF1DC4CEE7;
	Mon, 12 May 2025 10:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747045930;
	bh=1iItMgJ8Pev70T619AhPKd0v8efysQ6AFbZP5spRW4g=;
	h=Subject:To:Cc:From:Date:From;
	b=TbZLeEk5wKL1rnId1kYSKlV3OMGi7ioGTYtaz1lN1zNcWdHW9cLFHUbPStO1hiN1k
	 8IggYx5qeGNTlckLcmmxtoKC+uMBv+sr4PcjPsd0OCaKI0Q+/wtSYGc+LnqyrU7pVA
	 bvwAmFnzP+lU4UTFFm5vHKe0EMxbDHHDPJ9mLbp8=
Subject: FAILED: patch "[PATCH] clocksource/i8253: Use raw_spinlock_irqsave() in" failed to apply to 5.15-stable tree
To: bigeasy@linutronix.de,tglx@linutronix.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 May 2025 12:31:57 +0200
Message-ID: <2025051256-safeguard-purchase-6c4e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 94cff94634e506a4a44684bee1875d2dbf782722
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025051256-safeguard-purchase-6c4e@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 94cff94634e506a4a44684bee1875d2dbf782722 Mon Sep 17 00:00:00 2001
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date: Fri, 4 Apr 2025 15:31:16 +0200
Subject: [PATCH] clocksource/i8253: Use raw_spinlock_irqsave() in
 clockevent_i8253_disable()

On x86 during boot, clockevent_i8253_disable() can be invoked via
x86_late_time_init -> hpet_time_init() -> pit_timer_init() which happens
with enabled interrupts.

If some of the old i8253 hardware is actually used then lockdep will notice
that i8253_lock is used in hard interrupt context. This causes lockdep to
complain because it observed the lock being acquired with interrupts
enabled and in hard interrupt context.

Make clockevent_i8253_disable() acquire the lock with
raw_spinlock_irqsave() to cure this.

[ tglx: Massage change log and use guard() ]

Fixes: c8c4076723dac ("x86/timer: Skip PIT initialization on modern chipsets")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/20250404133116.p-XRWJXf@linutronix.de

diff --git a/drivers/clocksource/i8253.c b/drivers/clocksource/i8253.c
index 39f7c2d736d1..b603c25f3dfa 100644
--- a/drivers/clocksource/i8253.c
+++ b/drivers/clocksource/i8253.c
@@ -103,7 +103,7 @@ int __init clocksource_i8253_init(void)
 #ifdef CONFIG_CLKEVT_I8253
 void clockevent_i8253_disable(void)
 {
-	raw_spin_lock(&i8253_lock);
+	guard(raw_spinlock_irqsave)(&i8253_lock);
 
 	/*
 	 * Writing the MODE register should stop the counter, according to
@@ -132,8 +132,6 @@ void clockevent_i8253_disable(void)
 	outb_p(0, PIT_CH0);
 
 	outb_p(0x30, PIT_MODE);
-
-	raw_spin_unlock(&i8253_lock);
 }
 
 static int pit_shutdown(struct clock_event_device *evt)


