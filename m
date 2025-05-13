Return-Path: <stable+bounces-144119-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D974AB4CAC
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 09:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B26DA16AE7F
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 07:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4481E9B18;
	Tue, 13 May 2025 07:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4V9oT3Ln";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8jdiJMyZ"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60AD974059
	for <stable@vger.kernel.org>; Tue, 13 May 2025 07:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747121170; cv=none; b=WRsSaTsACfcgFDA+wmyDRslO2sH1CKhYkwCBViF9L64YdkUMYU2dsU9SYOpGi9NO/IbFmvyT3mhqBZJww8NwnEWpmxsGReOkDrIj1Xz5vg0R1xDOVC2tVVmCJDPeXPi4ljxxTenr0aRpS7yi4GxUFM7OO0Eyg4KnU37iZne/EfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747121170; c=relaxed/simple;
	bh=NYT88Hit4EJsMS1ewbwETqzx5reVtkAXpy0msK8TBrw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QL8edb9j4/u4NDflfdotmFNJOBMd5JgEBuooG/qw/rk6QC+Xi5fRusmsRUGat4ROz4ukg5Koqx8ml++pW9oILYv2xksaPtcfc/naPK4Ba6jLsL3myxVJzCy0zvPKLLUnTrkgp8lOj+21lqAmVT7z7iocNTCCrMSoCyOnsHrysGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4V9oT3Ln; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8jdiJMyZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747121167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FhgiJLatjSCachUyT9REx3lEG/LQUSugKIItaBArwqQ=;
	b=4V9oT3Ln/62ZzyoSDoGdh/Ib6HRKen9MZpOdhKjcGQdSK1OAF9lTD4VaMFDpd/aP47rZBy
	VqVe82VDFIbjzBJ4Y24OjPJ46a1WXAwgCQ/oyiSvyAlYX3+/2Wr6OZAlyevMFkdWJItye+
	KZ3NZzBZEG1zTYouoMO0O9T/P9xXSH0H2VExutf35bjK9npVPUBtHhC7yO3PDqh7aqIZQy
	ElYauHM8sO1M+6eE8+0zai6h4uUdau2ChZTM0aXEvLvwg9L7p87WMVtROQS1Nr3iG/59Fw
	S8rxSdfHwVWQoBkQtYRmMkJSh50NpNPchxYS/uSEyaIQDDpWKlZHuPNRv+/bKw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747121167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FhgiJLatjSCachUyT9REx3lEG/LQUSugKIItaBArwqQ=;
	b=8jdiJMyZdBbcIYTLkzJcVubqB4f9/3F1HjXERSwWbNKPvW4xbxDPokEirgTium/osZe9UD
	eRQZFwqHChijjbAg==
To: stable@vger.kernel.org
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 5.4.y] clocksource/i8253: Use raw_spinlock_irqsave() in clockevent_i8253_disable()
Date: Tue, 13 May 2025 09:26:05 +0200
Message-ID: <20250513072606.620633-1-bigeasy@linutronix.de>
In-Reply-To: <2025051258-washbowl-alongside-de3d@gregkh>
References: <2025051258-washbowl-alongside-de3d@gregkh>
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


