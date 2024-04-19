Return-Path: <stable+bounces-40269-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B2D8AACF5
	for <lists+stable@lfdr.de>; Fri, 19 Apr 2024 12:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 813C8B21049
	for <lists+stable@lfdr.de>; Fri, 19 Apr 2024 10:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966297E582;
	Fri, 19 Apr 2024 10:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cS4eRatV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A1D199C2
	for <stable@vger.kernel.org>; Fri, 19 Apr 2024 10:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713523155; cv=none; b=kYDoNul2TwFr8HX+MP49JKCiyINhX8yakCBV9tXzVWvYBw2rl/MtEbTFPsEfl+dCmzyjXsUTARdEfzOdsx0YhwYYqp4cEyCBC5Sf39LQMAMbJ/APO7NjtqBIVFsvPBKfI8+qcZd9xsRfadFnUGyd9VtVAk7Zj36XxKeWKW0ZjEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713523155; c=relaxed/simple;
	bh=M/OXcq3d/XVJQlC5b6csW+vj/CsE8yM4YrCIvR962BQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=uFr7efEH3pzfXyVzG48p/21d8JkO7G+x0pGn49wU7xFaQdtKMR7HyJEjvxmp+API2C5dfgg4u7fM8rCeR6gJaMJp5bh0SP2WoZQE3dBcUESk5sA1SW4ypmegshBBqcMs6SfFde4z3oAVJlvPplBKnkP284Sb0z0ilk6oTSw+ZDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cS4eRatV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0215C32781;
	Fri, 19 Apr 2024 10:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713523155;
	bh=M/OXcq3d/XVJQlC5b6csW+vj/CsE8yM4YrCIvR962BQ=;
	h=Subject:To:Cc:From:Date:From;
	b=cS4eRatVaeO1NEj7sU+oNzIygD1+4lh3eaM9LJxQz9p+J2UWY2JrYvtivVVb9/+OC
	 mXmR6xyP5OXU+ZFnch99j9HQvjLUztOBF8B/AP2KwrDSw1JHW+AI1JzPZ05BaBwOws
	 wnsS9ATCN02G7WSDgfYdGrXhaCckUgcyfR3qwuq0=
Subject: FAILED: patch "[PATCH] random: handle creditable entropy from atomic process context" failed to apply to 5.4-stable tree
To: Jason@zx2c4.com,guoyong.wang@mediatek.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 19 Apr 2024 12:39:06 +0200
Message-ID: <2024041905-obvious-blush-10d8@gregkh>
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
git cherry-pick -x e871abcda3b67d0820b4182ebe93435624e9c6a4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024041905-obvious-blush-10d8@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

e871abcda3b6 ("random: handle creditable entropy from atomic process context")
bbc7e1bed1f5 ("random: add back async readiness notifier")
9148de3196ed ("random: reseed in delayed work rather than on-demand")
f62384995e4c ("random: split initialization into early step and later step")
745558f95885 ("random: use hwgenerator randomness more frequently at early boot")
228dfe98a313 ("Merge tag 'char-misc-6.0-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e871abcda3b67d0820b4182ebe93435624e9c6a4 Mon Sep 17 00:00:00 2001
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Wed, 17 Apr 2024 13:38:29 +0200
Subject: [PATCH] random: handle creditable entropy from atomic process context

The entropy accounting changes a static key when the RNG has
initialized, since it only ever initializes once. Static key changes,
however, cannot be made from atomic context, so depending on where the
last creditable entropy comes from, the static key change might need to
be deferred to a worker.

Previously the code used the execute_in_process_context() helper
function, which accounts for whether or not the caller is
in_interrupt(). However, that doesn't account for the case where the
caller is actually in process context but is holding a spinlock.

This turned out to be the case with input_handle_event() in
drivers/input/input.c contributing entropy:

  [<ffffffd613025ba0>] die+0xa8/0x2fc
  [<ffffffd613027428>] bug_handler+0x44/0xec
  [<ffffffd613016964>] brk_handler+0x90/0x144
  [<ffffffd613041e58>] do_debug_exception+0xa0/0x148
  [<ffffffd61400c208>] el1_dbg+0x60/0x7c
  [<ffffffd61400c000>] el1h_64_sync_handler+0x38/0x90
  [<ffffffd613011294>] el1h_64_sync+0x64/0x6c
  [<ffffffd613102d88>] __might_resched+0x1fc/0x2e8
  [<ffffffd613102b54>] __might_sleep+0x44/0x7c
  [<ffffffd6130b6eac>] cpus_read_lock+0x1c/0xec
  [<ffffffd6132c2820>] static_key_enable+0x14/0x38
  [<ffffffd61400ac08>] crng_set_ready+0x14/0x28
  [<ffffffd6130df4dc>] execute_in_process_context+0xb8/0xf8
  [<ffffffd61400ab30>] _credit_init_bits+0x118/0x1dc
  [<ffffffd6138580c8>] add_timer_randomness+0x264/0x270
  [<ffffffd613857e54>] add_input_randomness+0x38/0x48
  [<ffffffd613a80f94>] input_handle_event+0x2b8/0x490
  [<ffffffd613a81310>] input_event+0x6c/0x98

According to Guoyong, it's not really possible to refactor the various
drivers to never hold a spinlock there. And in_atomic() isn't reliable.

So, rather than trying to be too fancy, just punt the change in the
static key to a workqueue always. There's basically no drawback of doing
this, as the code already needed to account for the static key not
changing immediately, and given that it's just an optimization, there's
not exactly a hurry to change the static key right away, so deferal is
fine.

Reported-by: Guoyong Wang <guoyong.wang@mediatek.com>
Cc: stable@vger.kernel.org
Fixes: f5bda35fba61 ("random: use static branch for crng_ready()")
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 456be28ba67c..2597cb43f438 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -702,7 +702,7 @@ static void extract_entropy(void *buf, size_t len)
 
 static void __cold _credit_init_bits(size_t bits)
 {
-	static struct execute_work set_ready;
+	static DECLARE_WORK(set_ready, crng_set_ready);
 	unsigned int new, orig, add;
 	unsigned long flags;
 
@@ -718,8 +718,8 @@ static void __cold _credit_init_bits(size_t bits)
 
 	if (orig < POOL_READY_BITS && new >= POOL_READY_BITS) {
 		crng_reseed(NULL); /* Sets crng_init to CRNG_READY under base_crng.lock. */
-		if (static_key_initialized)
-			execute_in_process_context(crng_set_ready, &set_ready);
+		if (static_key_initialized && system_unbound_wq)
+			queue_work(system_unbound_wq, &set_ready);
 		atomic_notifier_call_chain(&random_ready_notifier, 0, NULL);
 		wake_up_interruptible(&crng_init_wait);
 		kill_fasync(&fasync, SIGIO, POLL_IN);
@@ -890,8 +890,8 @@ void __init random_init(void)
 
 	/*
 	 * If we were initialized by the cpu or bootloader before jump labels
-	 * are initialized, then we should enable the static branch here, where
-	 * it's guaranteed that jump labels have been initialized.
+	 * or workqueues are initialized, then we should enable the static
+	 * branch here, where it's guaranteed that these have been initialized.
 	 */
 	if (!static_branch_likely(&crng_is_ready) && crng_init >= CRNG_READY)
 		crng_set_ready(NULL);


