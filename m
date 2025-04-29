Return-Path: <stable+bounces-138159-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D96C8AA1720
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 19:44:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F2CD3B9D6A
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 17:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE14822DF91;
	Tue, 29 Apr 2025 17:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cwEMIZ6P"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1AA238C21;
	Tue, 29 Apr 2025 17:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745948355; cv=none; b=BWMbGlikWxKYniGWIVOic4GGx/fJyXOmbQij7o1KXNhoXwq/QHCXbe5mO77iZEuGx701xDKKfGkzxwgCD6yQnQraScowlga5U8zZ+fRWiVz9ZPILISj3A615B3DBOXP78sLnp9HAKH4DD7DV+DWbtiGmcPVGZr/0wl5Z1clhVeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745948355; c=relaxed/simple;
	bh=rmEWZLlZjbnpO0EAkTGZ4SoMpdGmdIbXOnq+jgmXLlo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IBFDDipH1rTxpdOnu9Jv/2lY1SEDjSa+0b58hoxtP+Pnl6iTW6PhtG2cCcXVY2YqvIso69EghSyt3hD8GTAHFXPKvBIl061KE1XZWY+d2IqZTL611KV6voisMVZe5iUAQd+opLqErsF4JGm9lV0ykanCZZRP+bDBdppZWvNhKUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cwEMIZ6P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08180C4CEE3;
	Tue, 29 Apr 2025 17:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745948355;
	bh=rmEWZLlZjbnpO0EAkTGZ4SoMpdGmdIbXOnq+jgmXLlo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cwEMIZ6Pqsw0wvJKQQNC+pR0OQBVYCJQmzOrgFkSGpuBJKicytok2cjqwsZ/KMn++
	 CC/JMcUCOjvNM/j66aMoPGgOhQP6o1CI0B2/2jR35L3QqVRVJdhz3780zK2yZXJpq3
	 016SzKBK1EdM1ukVJwDMYSwURBYBogoMY87Zpcq0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Thomas Gleixner <tglx@linutronix.de>,
	Fernando Fernandez Mancera <ffmancera@riseup.net>,
	Ingo Molnar <mingo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 235/280] x86/i8253: Call clockevent_i8253_disable() with interrupts disabled
Date: Tue, 29 Apr 2025 18:42:56 +0200
Message-ID: <20250429161124.733296013@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161115.008747050@linuxfoundation.org>
References: <20250429161115.008747050@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Fernando Fernandez Mancera <ffmancera@riseup.net>

[ Upstream commit 3940f5349b476197fb079c5aa19c9a988de64efb ]

There's a lockdep false positive warning related to i8253_lock:

  WARNING: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected
  ...
  systemd-sleep/3324 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
  ffffffffb2c23398 (i8253_lock){+.+.}-{2:2}, at: pcspkr_event+0x3f/0xe0 [pcspkr]

  ...
  ... which became HARDIRQ-irq-unsafe at:
  ...
    lock_acquire+0xd0/0x2f0
    _raw_spin_lock+0x30/0x40
    clockevent_i8253_disable+0x1c/0x60
    pit_timer_init+0x25/0x50
    hpet_time_init+0x46/0x50
    x86_late_time_init+0x1b/0x40
    start_kernel+0x962/0xa00
    x86_64_start_reservations+0x24/0x30
    x86_64_start_kernel+0xed/0xf0
    common_startup_64+0x13e/0x141
  ...

Lockdep complains due pit_timer_init() using the lock in an IRQ-unsafe
fashion, but it's a false positive, because there is no deadlock
possible at that point due to init ordering: at the point where
pit_timer_init() is called there is no other possible usage of
i8253_lock because the system is still in the very early boot stage
with no interrupts.

But in any case, pit_timer_init() should disable interrupts before
calling clockevent_i8253_disable() out of general principle, and to
keep lockdep working even in this scenario.

Use scoped_guard() for that, as suggested by Thomas Gleixner.

[ mingo: Cleaned up the changelog. ]

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Fernando Fernandez Mancera <ffmancera@riseup.net>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/Z-uwd4Bnn7FcCShX@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/i8253.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/i8253.c b/arch/x86/kernel/i8253.c
index 80e262bb627fe..cb9852ad60989 100644
--- a/arch/x86/kernel/i8253.c
+++ b/arch/x86/kernel/i8253.c
@@ -46,7 +46,8 @@ bool __init pit_timer_init(void)
 		 * VMMs otherwise steal CPU time just to pointlessly waggle
 		 * the (masked) IRQ.
 		 */
-		clockevent_i8253_disable();
+		scoped_guard(irq)
+			clockevent_i8253_disable();
 		return false;
 	}
 	clockevent_i8253_init(true);
-- 
2.39.5




