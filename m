Return-Path: <stable+bounces-144115-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D736AB4C66
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 09:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0ADA866173
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 07:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322141DE4E6;
	Tue, 13 May 2025 07:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gr3dPxB0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TQeOlI8q"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5731AED5C
	for <stable@vger.kernel.org>; Tue, 13 May 2025 07:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747119743; cv=none; b=eS0O+u2DGvIITzd+dDir0EOiji/wmvd1aFmG8L5UFkYuNn2W2HjvWtIg9P3EJW9kSluiHG9wptL/DCfD1mdhcK9lloDPqcR0Zkk8FjcG1gJpYCSg5/XZ+g5xtbaoN0mkDDGg0UZbwd1gqAUjNqrtDwHImT2pwNN8zcrm4mdZDF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747119743; c=relaxed/simple;
	bh=NYT88Hit4EJsMS1ewbwETqzx5reVtkAXpy0msK8TBrw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gvdEFxO8aDFjdZhXzsrriF14AuyLgqhsKKSYcFkedMJGg/cM3rb0SsHFx0Ybda83pfp9u+xviIE9w1ckr1F+0D84YpEvLUdr7IIu9NUa+XjkEBHrfqVoLZgOrdOqdIlin2pbqC5PXRM7IioRTJUXlDi56TGauXA5z2nJEKv/LwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gr3dPxB0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TQeOlI8q; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747119739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FhgiJLatjSCachUyT9REx3lEG/LQUSugKIItaBArwqQ=;
	b=gr3dPxB0QkJu3yPTDyxdGaWZPm+ey7l3UaxZwLOkGNdYQt1D3g2cBLJtFtrK/uX+OyjcdT
	aMXZDoRrTva4lPGzhSvnltpsr/rOGD2kdYT4IXPAJvvSVnTcNvtRhEazKDrC5EMyEZvQsW
	AaTdXOgMqROhmLjlO5YVOMmvc4oLC4m19Gpu0NaUCOhIq0lV/LVYX0ZTJiaZuZ0Ns7bMBL
	eCT0a6kOIwfgRcEIdLy0+dBdpBL90fQ/EejHsXc3uaTbikuhGzglkZ9zVuP5IiR2kqkSb4
	wopsfTgJI93xoY7+b+W4szSeoyOdANGBhfaKPcGwVQJ6iG4GbulRv6/bsvaX7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747119739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FhgiJLatjSCachUyT9REx3lEG/LQUSugKIItaBArwqQ=;
	b=TQeOlI8qX8OGScRwhBtcKX2FQxarjmiMPUGigtk1xKNC062CRP0F1W5BWCT3izP2U/m7cb
	eqmEvxcVrHpOjqCQ==
To: stable@vger.kernel.org
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 5.10.y] clocksource/i8253: Use raw_spinlock_irqsave() in clockevent_i8253_disable()
Date: Tue, 13 May 2025 09:02:01 +0200
Message-ID: <20250513070201.488210-1-bigeasy@linutronix.de>
In-Reply-To: <2025051257-skater-skeleton-9a3d@gregkh>
References: <2025051257-skater-skeleton-9a3d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

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
[ bigeasy: Dropped guard() for stable ]

Fixes: c8c4076723dac ("x86/timer: Skip PIT initialization on modern chipset=
s")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/20250404133116.p-XRWJXf@linutronix.de
(cherry picked from commit 94cff94634e506a4a44684bee1875d2dbf782722)
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/clocksource/i8253.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/i8253.c b/drivers/clocksource/i8253.c
index 39f7c2d736d16..9a91ce66e16eb 100644
--- a/drivers/clocksource/i8253.c
+++ b/drivers/clocksource/i8253.c
@@ -103,7 +103,9 @@ int __init clocksource_i8253_init(void)
 #ifdef CONFIG_CLKEVT_I8253
 void clockevent_i8253_disable(void)
 {
-	raw_spin_lock(&i8253_lock);
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&i8253_lock, flags);
=20
 	/*
 	 * Writing the MODE register should stop the counter, according to
@@ -133,7 +135,7 @@ void clockevent_i8253_disable(void)
=20
 	outb_p(0x30, PIT_MODE);
=20
-	raw_spin_unlock(&i8253_lock);
+	raw_spin_unlock_irqrestore(&i8253_lock, flags);
 }
=20
 static int pit_shutdown(struct clock_event_device *evt)
--=20
2.49.0


