Return-Path: <stable+bounces-68125-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22FAD9530C0
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 15:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8499287ED1
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 13:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0957B19AA53;
	Thu, 15 Aug 2024 13:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3ZUA6J3F";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jvF4QCfL"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FEE1714D9;
	Thu, 15 Aug 2024 13:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723729570; cv=none; b=b3YHi/QiJ1swSkSw8yI0KthOpdxVpr2uQoxqopJ6s9Ep+hkCPFP0dpL2ct/wwQ57snr5gxadvy61diU++OEfgwht16FdntVHkINhg6Vw1dGC9J+qEeL/hTw1BHU4L8+n5dwcf4SxhAY0vJoJa/CRadivfuim7dYEBGW0KLoU9zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723729570; c=relaxed/simple;
	bh=GyBZ5JcUbc/XHvnuWXeMqGP7fodtXDjKmTZ7B8cEzk4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=kYBp7E3cOBkQ6fX1eDXZRAo1zu1K8+7JcJhEyuengN8nGaupxIFxbz4vMqjdrfrqGVrk50m6l+lK9Fy72AoCqrMIn/ZQ1Y56cR1R6kUbo/akh1bQB/fxsC75SoYrvIEYFovq9rzclXIjb23Iks6gZMjXfAZ3DFrHMWAxVioS8KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3ZUA6J3F; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jvF4QCfL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 15 Aug 2024 13:46:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723729567;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+V+gUqLFe7cwaShPYD/MTvcflRm0uV8oy39eMy+7IbE=;
	b=3ZUA6J3FYpNrOLQc2Nxg/n8ip/1M9tuS+ej59gJhIlBA0ykc33+Irgat2yAR1mdPpvyXQW
	J8TP9AIWoiw8DLvSc6LdDKU9YMMFX3g2KBalisvYoRjhkFADn0FpmvpzFujSsuK78RU9GS
	yK0uWJAdaGX9hDMhb0mYY1v3fjPkG8l4tkIUlGCh1JNcp0KM9p7eky5DyDjblawy8OchI/
	Y1nrrwRbTrmVcP6k0KpV+P/iz1GwH1ZZnRlBwMGQSkValF4kbdMDeP7cdzV/pManz6jVmC
	8penNMHdx80HILDeiK0ZOBLEtxyDZTnwYz3xMG/Cl44BooMBS8h5JM87UdhwNQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723729567;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+V+gUqLFe7cwaShPYD/MTvcflRm0uV8oy39eMy+7IbE=;
	b=jvF4QCfLt3qZYfWjU+r7wIr++7np8y04TFStPbogrKtHSJksVX55eiiIifMRh2eQpwn7hb
	XhNVyaHk19YZ36Cw==
From: "tip-bot2 for Roland Xu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: locking/urgent] rtmutex: Drop rt_mutex::wait_lock before scheduling
Cc: Roland Xu <mu001999@outlook.com>, Thomas Gleixner <tglx@linutronix.de>,
 stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3CME0P300MB063599BEF0743B8FA339C2CECC802=40ME0P300MB?=
 =?utf-8?q?0635=2EAUSP300=2EPROD=2EOUTLOOK=2ECOM=3E?=
References: =?utf-8?q?=3CME0P300MB063599BEF0743B8FA339C2CECC802=40ME0P300M?=
 =?utf-8?q?B0635=2EAUSP300=2EPROD=2EOUTLOOK=2ECOM=3E?=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172372956693.2215.10534564675111967043.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     d33d26036a0274b472299d7dcdaa5fb34329f91b
Gitweb:        https://git.kernel.org/tip/d33d26036a0274b472299d7dcdaa5fb34329f91b
Author:        Roland Xu <mu001999@outlook.com>
AuthorDate:    Thu, 15 Aug 2024 10:58:13 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 15 Aug 2024 15:38:53 +02:00

rtmutex: Drop rt_mutex::wait_lock before scheduling

rt_mutex_handle_deadlock() is called with rt_mutex::wait_lock held.  In the
good case it returns with the lock held and in the deadlock case it emits a
warning and goes into an endless scheduling loop with the lock held, which
triggers the 'scheduling in atomic' warning.

Unlock rt_mutex::wait_lock in the dead lock case before issuing the warning
and dropping into the schedule for ever loop.

[ tglx: Moved unlock before the WARN(), removed the pointless comment,
  	massaged changelog, added Fixes tag ]

Fixes: 3d5c9340d194 ("rtmutex: Handle deadlock detection smarter")
Signed-off-by: Roland Xu <mu001999@outlook.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/ME0P300MB063599BEF0743B8FA339C2CECC802@ME0P300MB0635.AUSP300.PROD.OUTLOOK.COM
---
 kernel/locking/rtmutex.c |  9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 88d08ee..fba1229 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1644,6 +1644,7 @@ static int __sched rt_mutex_slowlock_block(struct rt_mutex_base *lock,
 }
 
 static void __sched rt_mutex_handle_deadlock(int res, int detect_deadlock,
+					     struct rt_mutex_base *lock,
 					     struct rt_mutex_waiter *w)
 {
 	/*
@@ -1656,10 +1657,10 @@ static void __sched rt_mutex_handle_deadlock(int res, int detect_deadlock,
 	if (build_ww_mutex() && w->ww_ctx)
 		return;
 
-	/*
-	 * Yell loudly and stop the task right here.
-	 */
+	raw_spin_unlock_irq(&lock->wait_lock);
+
 	WARN(1, "rtmutex deadlock detected\n");
+
 	while (1) {
 		set_current_state(TASK_INTERRUPTIBLE);
 		rt_mutex_schedule();
@@ -1713,7 +1714,7 @@ static int __sched __rt_mutex_slowlock(struct rt_mutex_base *lock,
 	} else {
 		__set_current_state(TASK_RUNNING);
 		remove_waiter(lock, waiter);
-		rt_mutex_handle_deadlock(ret, chwalk, waiter);
+		rt_mutex_handle_deadlock(ret, chwalk, lock, waiter);
 	}
 
 	/*

