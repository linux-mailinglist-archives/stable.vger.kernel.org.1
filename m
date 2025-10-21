Return-Path: <stable+bounces-188322-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE0CBF5CDB
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 12:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3792B4006CB
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 10:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B5132E6AD;
	Tue, 21 Oct 2025 10:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="niA1ml5e";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KhnTW8Wh"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABF332E13D;
	Tue, 21 Oct 2025 10:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761042935; cv=none; b=qacQGGhXUwLE6zNVIWvABpeezOlD0BOGK8yn48IcrFBi6i4ZlVnAyy8nlZFvo6yaxf+tc982cpaNTTe2/oZmGhVk3y8j6XuAJlzZe2u1nyNoqXUEuba1828EVyKs6h47JHBQUbnftUMWhIemEpztIvfnCRvVJAz3fyvRDCVnjU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761042935; c=relaxed/simple;
	bh=zVekbX7BNrONOigQ+j3GYKQt2wN5bjr00EmoLwfsObE=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=bzHVOsxW+qdE7sc0GaLIlhjkJQMMQpcQ+FRTcK7iAggz5EEzpNY0apQktJP+igLEQqx4fBP8Qu94J8y5JPahDq6IwkzTSO5+6DHxkpq8BJlK4nUlMHlYHhePNwL23ekWKNb9GYnXV+kKIUxVoNWzu8ZrVGFsRFwfhKxhjRTuCfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=niA1ml5e; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KhnTW8Wh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 21 Oct 2025 10:35:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761042932;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=FpND0IMXegUNkh+nF/RWQeGIU7TZl2myMK9bJJ378vM=;
	b=niA1ml5e2ywrWvyLRxP0OH6ThgzxunsTezoDvKC5vBCIluF4G5JVOFqXpfXwf989Lo1dEV
	uRjaPHw0mfxD8v7l0/+eK7SDb02hJmlOjapP36ZxgTo45JhnHrvknC6EGRosB1DoTVDL33
	oc9yFjtr+AeMBVRrQPZo1V06qOwCQimjyaIpdhr3ErupjdA5laTwSKe2IoEd/fM8nBghGg
	gdvZVsrdrDjRfjE9db/dZeRJOCUpkrVnlb8+H7Umes2Fsn6xKCTbPbjPkPivlA5Owsn63W
	YHFyz5OmZJzb1yMMFXmLuxzCkBQViAgyL5JLgSU7+zx1pkndHxaMAUXixFPIcw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761042932;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=FpND0IMXegUNkh+nF/RWQeGIU7TZl2myMK9bJJ378vM=;
	b=KhnTW8Wh/RJHQSdWhuO4BYWuSA4Zhy06UPwV6CjzB/FJCbieYjEytH6nsU2PMGuCd4/AjU
	90TBbIaUch/LP0Dg==
From: "tip-bot2 for Alexander Sverdlin" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/spinlock/debug: Fix data-race in
 do_raw_write_lock
Cc: Adrian Freihofer <adrian.freihofer@siemens.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 "Paul E. McKenney" <paulmck@kernel.org>, Waiman Long <longman@redhat.com>,
 stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176104293117.2601451.6475877416936398769.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     c14ecb555c3ee80eeb030a4e46d00e679537f03a
Gitweb:        https://git.kernel.org/tip/c14ecb555c3ee80eeb030a4e46d00e67953=
7f03a
Author:        Alexander Sverdlin <alexander.sverdlin@siemens.com>
AuthorDate:    Fri, 19 Sep 2025 11:12:38 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 21 Oct 2025 12:31:55 +02:00

locking/spinlock/debug: Fix data-race in do_raw_write_lock

KCSAN reports:

BUG: KCSAN: data-race in do_raw_write_lock / do_raw_write_lock

write (marked) to 0xffff800009cf504c of 4 bytes by task 1102 on cpu 1:
 do_raw_write_lock+0x120/0x204
 _raw_write_lock_irq
 do_exit
 call_usermodehelper_exec_async
 ret_from_fork

read to 0xffff800009cf504c of 4 bytes by task 1103 on cpu 0:
 do_raw_write_lock+0x88/0x204
 _raw_write_lock_irq
 do_exit
 call_usermodehelper_exec_async
 ret_from_fork

value changed: 0xffffffff -> 0x00000001

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 PID: 1103 Comm: kworker/u4:1 6.1.111

Commit 1a365e822372 ("locking/spinlock/debug: Fix various data races") has
adressed most of these races, but seems to be not consistent/not complete.

>From do_raw_write_lock() only debug_write_lock_after() part has been
converted to WRITE_ONCE(), but not debug_write_lock_before() part.
Do it now.

Fixes: 1a365e822372 ("locking/spinlock/debug: Fix various data races")
Reported-by: Adrian Freihofer <adrian.freihofer@siemens.com>
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Acked-by: Waiman Long <longman@redhat.com>
Cc: stable@vger.kernel.org
---
 kernel/locking/spinlock_debug.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/spinlock_debug.c b/kernel/locking/spinlock_debug.c
index 87b03d2..2338b3a 100644
--- a/kernel/locking/spinlock_debug.c
+++ b/kernel/locking/spinlock_debug.c
@@ -184,8 +184,8 @@ void do_raw_read_unlock(rwlock_t *lock)
 static inline void debug_write_lock_before(rwlock_t *lock)
 {
 	RWLOCK_BUG_ON(lock->magic !=3D RWLOCK_MAGIC, lock, "bad magic");
-	RWLOCK_BUG_ON(lock->owner =3D=3D current, lock, "recursion");
-	RWLOCK_BUG_ON(lock->owner_cpu =3D=3D raw_smp_processor_id(),
+	RWLOCK_BUG_ON(READ_ONCE(lock->owner) =3D=3D current, lock, "recursion");
+	RWLOCK_BUG_ON(READ_ONCE(lock->owner_cpu) =3D=3D raw_smp_processor_id(),
 							lock, "cpu recursion");
 }
=20

