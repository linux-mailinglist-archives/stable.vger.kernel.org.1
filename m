Return-Path: <stable+bounces-143245-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA1EAB34EA
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 12:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 913F7188C8CF
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 10:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 237D125B66F;
	Mon, 12 May 2025 10:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="msoneGtQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DEF2500CF
	for <stable@vger.kernel.org>; Mon, 12 May 2025 10:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747045919; cv=none; b=rJPqzbs2Iwr208gSk46EDJaeJP7Qs/8UFs7Ama98A1cXjOgC8l/HU6tJmCcR5YYReWPjYpsPxnG7y4fJrhoWBY7VY7YFyEniRLX/LfxkzoWqf8qfIyRyiuyO+sWyVsDZoDV69ALUykZYpCiew3L0Ez/PhUGbfR0ZXobAsrrHYD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747045919; c=relaxed/simple;
	bh=Bp7w5/zVOvGuXvA3a0YIdfMfEdVTJcYcp2VxZ8cjFOg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=rCOL3SH5BKxQMR3V16K0/f8eZlQp1N8nFFG5CLxWG9DnjSstVHUy+HjpspTzYwhYKFeHltSOuE7+oe9OnA+FnF/GZIpq1GX4oW1RWjZ2/FtaoCD+eOYU8L+gIcaA4pmXBrqJJolVm9z7inXx0LK2AjzHHoL25YZcpciib1nbcwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=msoneGtQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAD25C4CEE7;
	Mon, 12 May 2025 10:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747045919;
	bh=Bp7w5/zVOvGuXvA3a0YIdfMfEdVTJcYcp2VxZ8cjFOg=;
	h=Subject:To:Cc:From:Date:From;
	b=msoneGtQe1LPdzqYfn1/wUkvdhQ/9biDABAX4mhJU1NQvSfrdljhlT4OJHsObFMZ2
	 hA3t8NvAPMt6MIHoDwYFlvX/ArUWHD5Q7iiswr78GWMam2iTAq0lUifKBbU1ArqPPE
	 9W0ALmnF5PY2dJCD7MuqZtopKlCyrEBx7eGNbNNQ=
Subject: FAILED: patch "[PATCH] clocksource/i8253: Use raw_spinlock_irqsave() in" failed to apply to 6.1-stable tree
To: bigeasy@linutronix.de,tglx@linutronix.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 May 2025 12:31:56 +0200
Message-ID: <2025051256-encrust-scribe-9996@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 94cff94634e506a4a44684bee1875d2dbf782722
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025051256-encrust-scribe-9996@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

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


