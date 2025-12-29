Return-Path: <stable+bounces-203492-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 31892CE68AC
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 12:34:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE89B3008F9F
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 11:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 974AC30C605;
	Mon, 29 Dec 2025 11:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ewtyy3Uh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7922EB5A6
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 11:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767008062; cv=none; b=jZkeQn/u+NQYAHOE6x7TrFsmG/FofQoCVnhVG0yh8H3T+DLCU+uq9jVbTyVkKAhSe7NRo5kGk8IvFiWZzDY5akYRm06ugKoyb2a7OIUgIehwpvROJ7Tn6QK7gRicdfY2lbVf6xsa55mWGiKVtMP0yGovsLAzFowyIpfvMUYWxOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767008062; c=relaxed/simple;
	bh=87OOJeSx9dhZSo2bkmQrZDIEaHqBZx98V98EguXOsYk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=P0/UkS7sm14Axbbv4UcWZpLlW7bE19uP4lQNFMcvG0GU9oGhZqChYfFp1+GwO3WX9SHCBwvBO4ChyNq8j3jIhDvvZon+JaAR/MUZrob0rW9yL7apqUcqkh+wYdvuvkmm8rHQ85K/EH98E7wKJrXOtYRyhl78BSruxLxNEEsSn9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ewtyy3Uh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35E72C4CEF7;
	Mon, 29 Dec 2025 11:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767008058;
	bh=87OOJeSx9dhZSo2bkmQrZDIEaHqBZx98V98EguXOsYk=;
	h=Subject:To:Cc:From:Date:From;
	b=ewtyy3UhjVwrIIG2jehZzS7Z7xA1qDIwIoyJBD6ePKL0+Zl6FraajuA5N3qK1KOjm
	 GVYa2i+bMiQ1uvbhoO9rjVfluCVNVPYuPsF6Zja9FnkwGm4NkbK4CuR6GCc24Ufdah
	 ZwYMv/f/D7VtyLj1HJ4Dxl0Myhx6RN5dLy7Oa5mU=
Subject: FAILED: patch "[PATCH] io_uring: fix min_wait wakeups for SQPOLL" failed to apply to 6.12-stable tree
To: axboe@kernel.dk,tip@tenbrinkmeijs.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Dec 2025 12:34:15 +0100
Message-ID: <2025122915-sensually-wasting-f5f8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x e15cb2200b934e507273510ba6bc747d5cde24a3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025122915-sensually-wasting-f5f8@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e15cb2200b934e507273510ba6bc747d5cde24a3 Mon Sep 17 00:00:00 2001
From: Jens Axboe <axboe@kernel.dk>
Date: Tue, 9 Dec 2025 13:25:23 -0700
Subject: [PATCH] io_uring: fix min_wait wakeups for SQPOLL

Using min_wait, two timeouts are given:

1) The min_wait timeout, within which up to 'wait_nr' events are
   waited for.
2) The overall long timeout, which is entered if no events are generated
   in the min_wait window.

If the min_wait has expired, any event being posted must wake the task.
For SQPOLL, that isn't the case, as it won't trigger the io_has_work()
condition, as it will have already processed the task_work that happened
when an event was posted. This causes any event to trigger post the
min_wait to not always cause the waiting application to wakeup, and
instead it will wait until the overall timeout has expired. This can be
shown in a test case that has a 1 second min_wait, with a 5 second
overall wait, even if an event triggers after 1.5 seconds:

axboe@m2max-kvm /d/iouring-mre (master)> zig-out/bin/iouring
info: MIN_TIMEOUT supported: true, features: 0x3ffff
info: Testing: min_wait=1000ms, timeout=5s, wait_nr=4
info: 1 cqes in 5000.2ms

where the expected result should be:

axboe@m2max-kvm /d/iouring-mre (master)> zig-out/bin/iouring
info: MIN_TIMEOUT supported: true, features: 0x3ffff
info: Testing: min_wait=1000ms, timeout=5s, wait_nr=4
info: 1 cqes in 1500.3ms

When the min_wait timeout triggers, reset the number of completions
needed to wake the task. This should ensure that any future events will
wake the task, regardless of how many events it originally wanted to
wait for.

Reported-by: Tip ten Brink <tip@tenbrinkmeijs.com>
Cc: stable@vger.kernel.org
Fixes: 1100c4a2656d ("io_uring: add support for batch wait timeout")
Link: https://github.com/axboe/liburing/issues/1477
Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 5d130c578435..6cb24cdf8e68 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -2536,6 +2536,9 @@ static enum hrtimer_restart io_cqring_min_timer_wakeup(struct hrtimer *timer)
 			goto out_wake;
 	}
 
+	/* any generated CQE posted past this time should wake us up */
+	iowq->cq_tail = iowq->cq_min_tail;
+
 	hrtimer_update_function(&iowq->t, io_cqring_timer_wakeup);
 	hrtimer_set_expires(timer, iowq->timeout);
 	return HRTIMER_RESTART;


