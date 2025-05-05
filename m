Return-Path: <stable+bounces-139693-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92DB8AA94CD
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 15:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A2191774AD
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 13:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C331FECAF;
	Mon,  5 May 2025 13:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OgNe30Tv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="H4SnsANl"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2DA2AEF1;
	Mon,  5 May 2025 13:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746452917; cv=none; b=eRLZfNXQDUXqgjvFGhVkjn1IpRUluDrwo0dzbTdWJMVz1iWP5kz9cA46S0WN/NSwW/3rM8SSvhh2AWu6p1TSUCXGZzU1f5JNCR3T4Eyd43Hp0gf0WA3aUz3JLslkY2/UM9CKRSIfNmWLl9w+rKmngZCNAAMcKju0lgIIL7nuJ64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746452917; c=relaxed/simple;
	bh=kNxsm5kxKjKJ9Ddk5RSp90844Cv+Lkb3peI9w0obdUQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=iGxNqqUZE+ZToIRIOMCJXcGmVZpkIURnKvvY8uH3nwVF3OoUVPEz+Z2FV9BJ7ckacR3kLBE/GD5Ro4FDMBKQDisnG/p/saSLSq6LLWoDlXR9e3p+zs/Ryk9L3yxwE7r7BNW898SPqpnCjoT+gddyYEGAm/VSr1RWqokQsOsjiaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OgNe30Tv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=H4SnsANl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 05 May 2025 13:48:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746452912;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/7r/k+FmgnP/B7Qgh5RSGjtaH4XPPradoydaxmMo7gM=;
	b=OgNe30TvroPhOcP46pDmnumF6kb+mkXa4wC5771b4nJu68BdadGg6WMLQN4iPKF9qUzQ3A
	C8Ra4cUFELrhHvKZ/PCy4aVFZfPRKuz7henyhl00V91eMoJiEBe+3lJhbdFb/iS5GoFqmg
	xtQYIMZLZAooYhcvmZlVSv54ILoyCzyUkxFUDHw3yl0tnX5GYDFfdrNkRjmtjezdcUbQvG
	M+pPt+4sskQt+Qs2xDnDY9fTkp4mC1jvl4lWocDLuo+LlcIayOoH08tc5mm04zorMRMQQ8
	RpHeh6Kavw4mVgPKLN0CY0EgO6YVqsP/nHG0nz9sJAydlHVDiaf3zuJV7qGqpg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746452912;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/7r/k+FmgnP/B7Qgh5RSGjtaH4XPPradoydaxmMo7gM=;
	b=H4SnsANlbNiq7xTCkB35KzEwuCzccDLrzPRuRg/kGRFUJ3tlYKZwakcngHcayh+WtC2AlF
	/XfuaenvDp35wGDg==
From: "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] clocksource/i8253: Use raw_spinlock_irqsave() in
 clockevent_i8253_disable()
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250404133116.p-XRWJXf@linutronix.de>
References: <20250404133116.p-XRWJXf@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174645290649.22196.8650508722101472492.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     94cff94634e506a4a44684bee1875d2dbf782722
Gitweb:        https://git.kernel.org/tip/94cff94634e506a4a44684bee1875d2dbf782722
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Fri, 04 Apr 2025 15:31:16 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 05 May 2025 15:34:49 +02:00

clocksource/i8253: Use raw_spinlock_irqsave() in clockevent_i8253_disable()

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
---
 drivers/clocksource/i8253.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/clocksource/i8253.c b/drivers/clocksource/i8253.c
index 39f7c2d..b603c25 100644
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

