Return-Path: <stable+bounces-73856-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C2F97069F
	for <lists+stable@lfdr.de>; Sun,  8 Sep 2024 12:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C658B21844
	for <lists+stable@lfdr.de>; Sun,  8 Sep 2024 10:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8511B85DC;
	Sun,  8 Sep 2024 10:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kO27PiVJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092C671742
	for <stable@vger.kernel.org>; Sun,  8 Sep 2024 10:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725791461; cv=none; b=oBG1bSB6dWBpsYMOKBsPAZD/jaVFE8o1jhE+WpBaciepnplAbOURt4vBzkf/kSlitsgyAd718jrJX33q9Jc7S0ijRbBtmJTRnpEdkvk7IOqW9wlqmeaFZTjzobyou+mCTx10LFiWppA/wJ75MAvRkbZ8KY85FQ8cOrqzx6gbJVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725791461; c=relaxed/simple;
	bh=icJj2SfcUWHeMr/jtA3Y+Rr/Y3Vcky9gvNptdm1xbVM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ErXSCm97ySr1KyNgY8zbktfA5/7yvOx4/J+Ji3RBYkQNsUPVq4iZgZelpdQXEWASuV01RZm6nScmF6vrX4+cJteOldEbb0QMHlOjj4cA/DySkuxrolxDSRnuaSC9hQStbq52lWbzFIy26Zv5P12QW1DwS+GURnZQqMwg8Xb8p60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kO27PiVJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35B76C4CEC3;
	Sun,  8 Sep 2024 10:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725791460;
	bh=icJj2SfcUWHeMr/jtA3Y+Rr/Y3Vcky9gvNptdm1xbVM=;
	h=Subject:To:Cc:From:Date:From;
	b=kO27PiVJeVGMwfTRt/jFI014enqhHO7O1dlC8QOLFXb07HDT9qAE+QAxPAyMIKuU2
	 XWl4IQmF6/vfJDbZoC+N8av+sfXjssMbyUK6kS1cRtdolDU0V4wtvLzZQheiidjMhE
	 NfzfTSl/9U11Ac6/Ak5Vun1Kon/F7Q7z+aN6X3Ms=
Subject: FAILED: patch "[PATCH] rtmutex: Drop rt_mutex::wait_lock before scheduling" failed to apply to 5.4-stable tree
To: mu001999@outlook.com,tglx@linutronix.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 08 Sep 2024 12:30:49 +0200
Message-ID: <2024090849-android-shield-d1fd@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x d33d26036a0274b472299d7dcdaa5fb34329f91b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024090849-android-shield-d1fd@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

d33d26036a02 ("rtmutex: Drop rt_mutex::wait_lock before scheduling")
add461325ec5 ("locking/rtmutex: Extend the rtmutex core to support ww_mutex")
1c143c4b65da ("locking/rtmutex: Provide the spin/rwlock core lock function")
e17ba59b7e8e ("locking/rtmutex: Guard regular sleeping locks specific functions")
7980aa397cc0 ("locking/rtmutex: Use rt_mutex_wake_q_head")
c014ef69b3ac ("locking/rtmutex: Add wake_state to rt_mutex_waiter")
42254105dfe8 ("locking/rwsem: Add rtmutex based R/W semaphore implementation")
ebbdc41e90ff ("locking/rtmutex: Provide rt_mutex_slowlock_locked()")
830e6acc8a1c ("locking/rtmutex: Split out the inner parts of 'struct rtmutex'")
531ae4b06a73 ("locking/rtmutex: Split API from implementation")
785159301bed ("locking/rtmutex: Convert macros to inlines")
b41cda037655 ("locking/rtmutex: Set proper wait context for lockdep")
2f064a59a11f ("sched: Change task_struct::state")
d6c23bb3a2ad ("sched: Add get_current_state()")
b03fbd4ff24c ("sched: Introduce task_is_running()")
a9e906b71f96 ("Merge branch 'sched/urgent' into sched/core, to pick up fixes")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d33d26036a0274b472299d7dcdaa5fb34329f91b Mon Sep 17 00:00:00 2001
From: Roland Xu <mu001999@outlook.com>
Date: Thu, 15 Aug 2024 10:58:13 +0800
Subject: [PATCH] rtmutex: Drop rt_mutex::wait_lock before scheduling

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

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 88d08eeb8bc0..fba1229f1de6 100644
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


