Return-Path: <stable+bounces-93775-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C4D9D0B71
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 10:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C97DF1F22396
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 09:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F60818871A;
	Mon, 18 Nov 2024 09:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RKPTA0ab";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uxCf6/VU"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C236153836;
	Mon, 18 Nov 2024 09:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731921228; cv=none; b=ILBUVC355r8OlwaFLkQgddpOTc72UaGrccZ3o2UaN9Ja+E8Vb7q+2BIxP5PZ8zL2xadF3D7lKiQ3B8FrkUeOLyK0o1h3O7f8pMQmHNoDSCPy4UtN2LlGFM2wx8WvmTmzv10Zs6n5mTYow/oje257SpWOuZCcuStieWQfwCSDdhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731921228; c=relaxed/simple;
	bh=9/hFYtDXHAk3Q/P+TKPN8uO0RhlTfi7eh4dHe9v/BIM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=A5aiXITCNSExwa+aY5BYTy3doQ9SjliU8P3cLL5lQtruuHEo3C3LVkQaEh+K5dYUBE+foW8mQpz2eEWIlwwe2zvdfobLCa7q8RCW7hToBVYcJd4a3WXCBM02lUhNOaksHOLx3CxUzdkG4wJxWpHxN6oFbMRchzyEY1XsUo7DNmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RKPTA0ab; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uxCf6/VU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731921224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HI6ICxNO251mFq7pISkNdCLNFU5x6e6AXXpGTS7HZc0=;
	b=RKPTA0abGvFnwDXfRW/uUJWtjKOZ+xjrs2u+OgXgAdzNwucwCLQ0fXvjhHZUL/gvGqhPOg
	g5Ot6j2uTspH8X9rNQnjHM3ZlrYxmPFhTOQp0X+yCqgRevHcgpynx4dbdsMhgPxqd6TUv5
	sJxqooT3Z6rHWuJUOacIFn2y+RMkKjzC417zrWWKu6V93WmONC5FuSdKOYWAck16BMs+cg
	1SulMIrrp0zKXXns//wfu/gZ9gxDK/eBzNl1Ev39KYMHcAKyUVYaSAmq+Zs1PHz6x7RDbe
	CPnotlwa+4niu3t60XQOCXR/S9nfYJHklmOVwWP8RhAVcl78iUOiKsGFXP1bDA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731921224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HI6ICxNO251mFq7pISkNdCLNFU5x6e6AXXpGTS7HZc0=;
	b=uxCf6/VUuoVknnRagY75tS1zS4IW8eP4kWbJo6q+ctC4rYf085yIrDVYhPQxhX9k9Ox3tG
	CjbuQjXKPL4hlwAg==
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	Nam Cao <namcao@linutronix.de>,
	Andreas Schwab <schwab@suse.de>,
	Song Shuai <songshuaishuai@tinylab.org>,
	Celeste Liu <coelacanthushex@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] riscv: Fix sleeping in invalid context in die()
Date: Mon, 18 Nov 2024 10:13:33 +0100
Message-Id: <20241118091333.1185288-1-namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

die() can be called in exception handler, and therefore cannot sleep.
However, die() takes spinlock_t which can sleep with PREEMPT_RT enabled.
That causes the following warning:

BUG: sleeping function called from invalid context at kernel/locking/spinlo=
ck_rt.c:48
in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 285, name: mutex
preempt_count: 110001, expected: 0
RCU nest depth: 0, expected: 0
CPU: 0 UID: 0 PID: 285 Comm: mutex Not tainted 6.12.0-rc7-00022-ge19049cf7d=
56-dirty #234
Hardware name: riscv-virtio,qemu (DT)
Call Trace:
    dump_backtrace+0x1c/0x24
    show_stack+0x2c/0x38
    dump_stack_lvl+0x5a/0x72
    dump_stack+0x14/0x1c
    __might_resched+0x130/0x13a
    rt_spin_lock+0x2a/0x5c
    die+0x24/0x112
    do_trap_insn_illegal+0xa0/0xea
    _new_vmalloc_restore_context_a0+0xcc/0xd8
Oops - illegal instruction [#1]

Switch to use raw_spinlock_t, which does not sleep even with PREEMPT_RT
enabled.

Fixes: 76d2a0493a17 ("RISC-V: Init and Halt Code")
Signed-off-by: Nam Cao <namcao@linutronix.de>
Cc: stable@vger.kernel.org
---
stable backport is probably not needed for versions earlier than 6.12
because PREEMPT_RT is not enabled. But it doesn't hurt..
---
 arch/riscv/kernel/traps.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index 51ebfd23e007..8ff8e8b36524 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -35,7 +35,7 @@
=20
 int show_unhandled_signals =3D 1;
=20
-static DEFINE_SPINLOCK(die_lock);
+static DEFINE_RAW_SPINLOCK(die_lock);
=20
 static int copy_code(struct pt_regs *regs, u16 *val, const u16 *insns)
 {
@@ -81,7 +81,7 @@ void die(struct pt_regs *regs, const char *str)
=20
 	oops_enter();
=20
-	spin_lock_irqsave(&die_lock, flags);
+	raw_spin_lock_irqsave(&die_lock, flags);
 	console_verbose();
 	bust_spinlocks(1);
=20
@@ -100,7 +100,7 @@ void die(struct pt_regs *regs, const char *str)
=20
 	bust_spinlocks(0);
 	add_taint(TAINT_DIE, LOCKDEP_NOW_UNRELIABLE);
-	spin_unlock_irqrestore(&die_lock, flags);
+	raw_spin_unlock_irqrestore(&die_lock, flags);
 	oops_exit();
=20
 	if (in_interrupt())
--=20
2.39.5


