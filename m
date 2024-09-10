Return-Path: <stable+bounces-75007-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A84E8973288
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 12:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9AF31C24300
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 10:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA46194082;
	Tue, 10 Sep 2024 10:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZG/+vLNV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDBB190493;
	Tue, 10 Sep 2024 10:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725963477; cv=none; b=NvOVABN2S3VUn3VL9bnfh2FJTz+BSb3WtghNzIAAVpHNlH+PeWYARc2F3Amq//Wmv8S+MvRp2F+bixhLZfK1dmKSMglWh1FPC9emceTTXyKwc3IUjGEd4oCsmlVKQgiNqgBeBQO2onolRqZTVV3MdMgaq4zH43PiHStgwqnYXL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725963477; c=relaxed/simple;
	bh=4CiWa8YH8DtcNg/vPE/WkpQjaOK5u2aYEugQ/mmXjVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZqxLbwqZCGwlCmxoKwWrqs5aWfif5wz6TodHympOamvB9aabKalYIPj1AhpORo0T4NX/XGQ7RYwmDf3Lr/pBIuA3S6Ewd/FaG2N/+bEQsxXkvS7z3k+uJh9oC/ZnjO2bUc/V+oHkCrruOi/YNe88lqhOzMDtCnKKq8REzvgxgm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZG/+vLNV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E280C4CEC3;
	Tue, 10 Sep 2024 10:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725963476;
	bh=4CiWa8YH8DtcNg/vPE/WkpQjaOK5u2aYEugQ/mmXjVM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZG/+vLNVo0K0qKlS1uZVXCuRRCjC7T6qOiWNm0AGrQrStXW98Taqm7eabBrilsULo
	 6vzAr47rDfP3okzpoQaaKEQUHxVXword6fF4CObWUCq7zeS237aTdrV1IcCauT2BSA
	 E9sRXuVQjMdR8BwhDM7fVVBL4dg2XAVw+F+sWUQQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Roland Xu <mu001999@outlook.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 5.15 071/214] rtmutex: Drop rt_mutex::wait_lock before scheduling
Date: Tue, 10 Sep 2024 11:31:33 +0200
Message-ID: <20240910092601.641902330@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910092558.714365667@linuxfoundation.org>
References: <20240910092558.714365667@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/locking/rtmutex.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1613,6 +1613,7 @@ static int __sched rt_mutex_slowlock_blo
 }
 
 static void __sched rt_mutex_handle_deadlock(int res, int detect_deadlock,
+					     struct rt_mutex_base *lock,
 					     struct rt_mutex_waiter *w)
 {
 	/*
@@ -1625,10 +1626,10 @@ static void __sched rt_mutex_handle_dead
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
 		schedule();
@@ -1680,7 +1681,7 @@ static int __sched __rt_mutex_slowlock(s
 	} else {
 		__set_current_state(TASK_RUNNING);
 		remove_waiter(lock, waiter);
-		rt_mutex_handle_deadlock(ret, chwalk, waiter);
+		rt_mutex_handle_deadlock(ret, chwalk, lock, waiter);
 	}
 
 	/*



