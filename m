Return-Path: <stable+bounces-134971-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D46A95BCB
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 04:32:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D616E3ADF6F
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 02:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7914A26980D;
	Tue, 22 Apr 2025 02:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iGn62wjl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378D92690ED;
	Tue, 22 Apr 2025 02:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745288314; cv=none; b=f7J4B8//OGdmBx0PMbJ9tras0Q+aOs8onrBAjTJ3eAiwgTpJlYCcRU19+LjOhN27TOYIUdVdItNzq0KUm3tFDPxx2kh9agaKb+HP+dzWYELZncRDLR0bofgGLTJy5C2fQn+3faDWKF8syZzal4HaPqX7DiS6J566I3fdY40u4Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745288314; c=relaxed/simple;
	bh=R/zYyScGBky2sOpDAf0q2XG2hiACRKTyjcFhCE+ct5M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=beA8yH9o7uQTmar7S36CtLpWJ70RVifRbFn1wwwBYGp5isOFV+5OirbjMf4XTywIiMt4tCNBoPtHHZ5zm/njrLJ9eVxSO298KXRbwcF6Z3Vb14p79RoS7Yxp0zXFt7M9XQwmoHi+PZf4vEtFu0OKagJdEyXYxRHdt4b8+MAlulw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iGn62wjl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9988C4CEEE;
	Tue, 22 Apr 2025 02:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745288314;
	bh=R/zYyScGBky2sOpDAf0q2XG2hiACRKTyjcFhCE+ct5M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iGn62wjl2wGGW7KKqvVZ/fxfaWAmeUTqeGMZuTuTUjcxRYlywFJF536gJpGyt+1Qp
	 JMX7xVITlCX+uo4J4gc1hMnLFpSB3YdBxx0A2nfGWUQvuOmrrTIAWhWig/O/pPkUkS
	 JS9UREiKUK56W/RyGCwsZCZps5Mzp3elfOW8QcU8L0Wcd54rJ5pf12obCkvqMzLghw
	 a8rwWnJlBR/ppN2kDVtJMyFgZMXOJ0QziAhixhVXbyIVBdLEZ7y6n3dfUwNWFt2u1V
	 gm+ptvkTJLbI7C8kd0Ym5pnBAswQasR7frCRhfPmW817NbA+E43ikBVGQxerXAu2SU
	 CrrIJhkZ+xxMQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Fernando Fernandez Mancera <ffmancera@riseup.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	dwmw@amazon.co.uk
Subject: [PATCH AUTOSEL 6.1 04/12] x86/i8253: Call clockevent_i8253_disable() with interrupts disabled
Date: Mon, 21 Apr 2025 22:18:18 -0400
Message-Id: <20250422021826.1941778-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250422021826.1941778-1-sashal@kernel.org>
References: <20250422021826.1941778-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.134
Content-Transfer-Encoding: 8bit

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


