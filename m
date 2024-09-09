Return-Path: <stable+bounces-73951-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1850970DC9
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 08:17:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CCE11F227BD
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 06:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DEB616F909;
	Mon,  9 Sep 2024 06:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rLFqEhpa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OeVIz7sN"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28169101F7
	for <stable@vger.kernel.org>; Mon,  9 Sep 2024 06:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725862619; cv=none; b=DfbkFU9+0aLbc11Te6JDJ7nd35T1nLnjaBzlcpv5IXNuCMziV8v93fmr/X2u/8XzZ98uT4J+ISJUbSMkM46BwSOj03G+RtcmZnq9IzeX6bu8m+haG9wW+Arr8Ck/Gqdc54+xd7figHe4jaz+bceukWRCBVQZRmE1R/t1ZJqalAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725862619; c=relaxed/simple;
	bh=aoWhRO1kHVgHicTB9hCBtPy+zsgDH6YpRDFg3iEyn8w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pTWl7qHoZnusnQ9jkNvYrARbvzcoMEMqvX8/GjeBE/xO9tfriI8CdW+RerBu9PqUhYetyumYUKcZ38nX7eDGkamEhrlbZpKSByeS5jEpADajPihNWIntWjSvLQm1JdK8pMt5QicID0Mg7BfPhgGrRpeT9brfz7Z2yVHe+oBM00c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rLFqEhpa; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OeVIz7sN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725862609;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a9KCWa6bobagqX8lMChjE335LFLlIdg0H5LPQp8so44=;
	b=rLFqEhpanE1qnbnginjTmgDnfPlCSKoDifLO9/FY/ArHvGXJpiyc2BFE7KHt7oX0Isbqq9
	gTitkgE8PJfCR/+SC4IoStqL2bDcziVYlwvdy6xUNB9b0snMZTCnicCk5ydwQbN5D39Yua
	aaT+/QanoV2MSZxNzdpP5g6pIWqjMqGB2uzzIPG+kKRGhj9ggdSBSFMN9mzekZ5jJiDrgX
	D5YV1zf1cd5Om7GJIbIalaZPIyTEZf0k+25uqyZ9xxcuieGXCTKeShHkZKvE4W10bKbkZH
	dfChYdynP/wZ5WZpuPjmSsoTnQH6qJaeVfE5SizkV/7Sdb3gYUTNaKsg+syfMg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725862609;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a9KCWa6bobagqX8lMChjE335LFLlIdg0H5LPQp8so44=;
	b=OeVIz7sNHx6H4WVL4O5nNkXO68WN3u2F56+1aK5cuaoW0Nvxitv+pAZpFaRqnVAUt9t27e
	HCW5evMMkaqoWlBg==
To: gregkh@linuxfoundation.org, mu001999@outlook.com
Cc: stable@vger.kernel.org
Subject: [PATCH 5.10.y, 5.4.y, 4.19.y] rtmutex: Drop rt_mutex::wait_lock
 before scheduling
In-Reply-To: <2024090850-nuclear-radar-ea2b@gregkh>
References: <2024090850-nuclear-radar-ea2b@gregkh>
Date: Mon, 09 Sep 2024 08:16:48 +0200
Message-ID: <87jzflcpwv.ffs@tglx>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


From: Roland Xu <mu001999@outlook.com>

commit d33d26036a0274b472299d7dcdaa5fb34329f91b upstream.

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
Backport to 5.10.y, 5.4.y, 4.19.y
---
 kernel/locking/rtmutex.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1205,6 +1205,7 @@ static int __sched
 }
 
 static void rt_mutex_handle_deadlock(int res, int detect_deadlock,
+				     struct rt_mutex *lock,
 				     struct rt_mutex_waiter *w)
 {
 	/*
@@ -1214,6 +1215,7 @@ static void rt_mutex_handle_deadlock(int
 	if (res != -EDEADLOCK || detect_deadlock)
 		return;
 
+	raw_spin_unlock_irq(&lock->wait_lock);
 	/*
 	 * Yell lowdly and stop the task right here.
 	 */
@@ -1269,7 +1271,7 @@ rt_mutex_slowlock(struct rt_mutex *lock,
 	if (unlikely(ret)) {
 		__set_current_state(TASK_RUNNING);
 		remove_waiter(lock, &waiter);
-		rt_mutex_handle_deadlock(ret, chwalk, &waiter);
+		rt_mutex_handle_deadlock(ret, chwalk, lock, &waiter);
 	}
 
 	/*

